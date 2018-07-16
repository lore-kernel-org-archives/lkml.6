Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB758ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764F5206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:43:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 764F5206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389197AbeGPIJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:09:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48078 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388375AbeGPIJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:09:57 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BE471C03;
        Mon, 16 Jul 2018 07:43:53 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.9 11/32] USB: serial: ch341: fix type promotion bug in ch341_control_in()
Date:   Mon, 16 Jul 2018 09:36:19 +0200
Message-Id: <20180716073505.802427083@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073504.433996952@linuxfoundation.org>
References: <20180716073504.433996952@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

commit e33eab9ded328ccc14308afa51b5be7cbe78d30b upstream.

The "r" variable is an int and "bufsize" is an unsigned int so the
comparison is type promoted to unsigned.  If usb_control_msg() returns a
negative that is treated as a high positive value and the error handling
doesn't work.

Fixes: 2d5a9c72d0c4 ("USB: serial: ch341: fix control-message error handling")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/ch341.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/serial/ch341.c
+++ b/drivers/usb/serial/ch341.c
@@ -118,7 +118,7 @@ static int ch341_control_in(struct usb_d
 	r = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0), request,
 			    USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
 			    value, index, buf, bufsize, DEFAULT_TIMEOUT);
-	if (r < bufsize) {
+	if (r < (int)bufsize) {
 		if (r >= 0) {
 			dev_err(&dev->dev,
 				"short control message received (%d < %u)\n",


