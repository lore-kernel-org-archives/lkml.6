Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D45C1B0FD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88B82086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547846981;
	bh=1xk5HV9EXV9Mu0VSx9tWNzrcgsBKSCxtM9pc23SEWVA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=MwwNVvVm8bMeo5EeAf4l0eSmrjOxv7qeZ6SKef4/8X2Hrh810f05Ub8Bv9SB95RkM
	 BfJCbS0DUU1UWX5Y+blZIp5yGmtOV61ZAAP2GRd2vDTzbxfwcD9kQOLUAUxQfWlMSx
	 pSEUHEuLIfl/8FHFjeop+c7Wb1w0fz9Z0d/LffII=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbfARV3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 16:29:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:57716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729539AbfARV3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 16:29:34 -0500
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9089A2086D;
        Fri, 18 Jan 2019 21:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547846973;
        bh=1xk5HV9EXV9Mu0VSx9tWNzrcgsBKSCxtM9pc23SEWVA=;
        h=From:To:Cc:Subject:Date:From;
        b=tScGBx9ZJyGXGPwEkrl+KLjS8sxpBS9V0PNwLrl3XaJXpsUep33LQqKozrF1dfMFR
         EuqmI0dxyKw0RMcOY7K5TFvbQw7uHiVqLGpMz9PAa5yjwEpoSi4C1Tg7An3P12B/JE
         0kAGuX9jgthF0OUqVW3pEiaJKwIAaKyvwhNi2cJU=
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usbip: Fix vep_free_request() null pointer checks on input args
Date:   Fri, 18 Jan 2019 14:29:30 -0700
Message-Id: <20190118212931.18482-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuah Khan <shuah@kernel.org>

Fix vep_free_request() to return when usb_ep and usb_request are null
instead of calling WARN_ON.

Signed-off-by: Shuah Khan <shuah@kernel.org>
---
 drivers/usb/usbip/vudc_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/usbip/vudc_dev.c b/drivers/usb/usbip/vudc_dev.c
index 1634d8698e15..bfc8218e3fb6 100644
--- a/drivers/usb/usbip/vudc_dev.c
+++ b/drivers/usb/usbip/vudc_dev.c
@@ -297,7 +297,7 @@ static void vep_free_request(struct usb_ep *_ep, struct usb_request *_req)
 {
 	struct vrequest *req;
 
-	if (WARN_ON(!_ep || !_req))
+	if (!_ep || !_req)
 		return;
 
 	req = to_vrequest(_req);
-- 
2.17.1

