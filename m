Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDAEC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97DDF216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:23:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97DDF216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbeI1EoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 00:44:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49667 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbeI1EoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 00:44:08 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1g5eh4-0000VX-Cc; Thu, 27 Sep 2018 22:23:34 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steve Bayless <steve_bayless@keysight.com>,
        Guido Kiener <guido@kiener-muenchen.de>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: usbtmc: check size before allocating buffer and remove duplicated allocation
Date:   Thu, 27 Sep 2018 23:23:32 +0100
Message-Id: <20180927222332.13360-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the allocation of a buffer is performed before a sanity check on
the required buffer size and if the buffer size is too large the error exit
return leaks the allocated buffer.  Fix this by checking the size before
allocating.

Also, the same buffer is allocated again inside an if statement, causing
the first allocation to be leaked.  Fix this by removing this second
redundant allocation.

Detected by CoverityScan, CID#1473697 ("Resource leak")

Fixes: 658f24f4523e ("usb: usbtmc: Add ioctl for generic requests on control")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/class/usbtmc.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index 0fcb81a1399b..c01edff190d2 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -1895,18 +1895,14 @@ static int usbtmc_ioctl_request(struct usbtmc_device_data *data,
 	if (res)
 		return -EFAULT;
 
+	if (request.req.wLength > USBTMC_BUFSIZE)
+		return -EMSGSIZE;
+
 	buffer = kmalloc(request.req.wLength, GFP_KERNEL);
 	if (!buffer)
 		return -ENOMEM;
 
-	if (request.req.wLength > USBTMC_BUFSIZE)
-		return -EMSGSIZE;
-
 	if (request.req.wLength) {
-		buffer = kmalloc(request.req.wLength, GFP_KERNEL);
-		if (!buffer)
-			return -ENOMEM;
-
 		if ((request.req.bRequestType & USB_DIR_IN) == 0) {
 			/* Send control data to device */
 			res = copy_from_user(buffer, request.data,
-- 
2.17.1

