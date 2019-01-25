Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3284C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB2F218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548432346;
	bh=APSFi6vIi7J7yk3zjb9K3fPbyPI50aTYiExSIqq9Ndc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=E2OIbKJFkP2Ktpiy7kiOeh8B9VxlkryAcR698gLDFhHENDEA07dDtfoZeQJw9WZch
	 5XHEYjHPChBw/EVY7OXgYhRd4xtL7Zn8Q4ZGXoh1nvkNLDlyOd23XUeYkl7T8et32g
	 1qbviIonP71poxGuzkd2Xe4wdRFcQ/a1or2kz6xY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfAYQFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 11:05:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:47014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbfAYQFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 11:05:44 -0500
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87BD0218CD;
        Fri, 25 Jan 2019 16:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548432343;
        bh=APSFi6vIi7J7yk3zjb9K3fPbyPI50aTYiExSIqq9Ndc=;
        h=From:To:Cc:Subject:Date:From;
        b=yqoNIGbTCIRd4ZdgaAVyNNHxu/qqiOS0hlWe2ccpHNj7So5W3nupn/22XY7AJdl3R
         A8DqJrl1j2PBAoVbwto2BM/vZXC0+tdF63k6KDremHIeXa+RePP9dsDh6lzFSCDaGn
         SCjq/TjeiXYkicvE1kQ4QX2ZJ7yoG47iNmcczkjI=
From:   Shuah Khan <shuah@kernel.org>
To:     valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usbip: Fix vep_free_request() null pointer checks on input args
Date:   Fri, 25 Jan 2019 09:05:42 -0700
Message-Id: <20190125160542.6939-1-shuah@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix vep_free_request() to return when usb_ep and usb_request are null
instead of calling WARN_ON.

Signed-off-by: Shuah Khan <shuah@kernel.org>
---
 drivers/usb/usbip/vudc_dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/usbip/vudc_dev.c b/drivers/usb/usbip/vudc_dev.c
index 1634d8698e15..a72c17ff1c6a 100644
--- a/drivers/usb/usbip/vudc_dev.c
+++ b/drivers/usb/usbip/vudc_dev.c
@@ -297,7 +297,8 @@ static void vep_free_request(struct usb_ep *_ep, struct usb_request *_req)
 {
 	struct vrequest *req;
 
-	if (WARN_ON(!_ep || !_req))
+	/* ep is always valid here - see usb_ep_free_request() */
+	if (!_req)
 		return;
 
 	req = to_vrequest(_req);
-- 
2.17.1

