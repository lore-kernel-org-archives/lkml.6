Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7445C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1422087A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5K1mcw8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD1422087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbeJKXEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:04:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728128AbeJKXEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:04:37 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B57E22087A;
        Thu, 11 Oct 2018 15:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272215;
        bh=AgWJRg7dGCccKuK7NkRcN7BqDLJVxBpQ27AtDphwcgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e5K1mcw8+S5KhJPYlsNVIFgv0hWP1FDcIO9dmTqRv/A8Sv2NQSvJZH9G7KuAMWotZ
         Nwb5CX8PkbuC00loa12kNdBkES4vcUxcSanOh5w0CDJSweFpsnnWH80ujgHVdpRG+H
         sNKr9sgtxvPOR3i5CBxj24L6H8//ME0sp1EXPtGI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 030/120] usb: wusbcore: security: cast sizeof to int for comparison
Date:   Thu, 11 Oct 2018 17:33:31 +0200
Message-Id: <20181011152550.889182358@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julia Lawall <Julia.Lawall@lip6.fr>

[ Upstream commit d3ac5598c5010a8999978ebbcca3b1c6188ca36b ]

Comparing an int to a size, which is unsigned, causes the int to become
unsigned, giving the wrong result.  usb_get_descriptor can return a
negative error code.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
int x;
expression e,e1;
identifier f;
@@

*x = f(...);
... when != x = e1
    when != if (x < 0 || ...) { ... return ...; }
*x < sizeof(e)
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/wusbcore/security.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/wusbcore/security.c
+++ b/drivers/usb/wusbcore/security.c
@@ -230,7 +230,7 @@ int wusb_dev_sec_add(struct wusbhc *wusb
 
 	result = usb_get_descriptor(usb_dev, USB_DT_SECURITY,
 				    0, secd, sizeof(*secd));
-	if (result < sizeof(*secd)) {
+	if (result < (int)sizeof(*secd)) {
 		dev_err(dev, "Can't read security descriptor or "
 			"not enough data: %d\n", result);
 		goto out;


