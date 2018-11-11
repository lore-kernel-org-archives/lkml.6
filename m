Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FACC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A00214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A00214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731430AbeKLF4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:56:35 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52072 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727449AbeKLF4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:56:34 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvss-0000l7-4z; Sun, 11 Nov 2018 19:59:02 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsV-0001g7-H5; Sun, 11 Nov 2018 19:58:39 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        "Johan Hovold" <johan@kernel.org>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.887008852@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 229/366] USB: serial: ch341: fix type promotion bug
 in ch341_control_in()
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

commit e33eab9ded328ccc14308afa51b5be7cbe78d30b upstream.

The "r" variable is an int and "bufsize" is an unsigned int so the
comparison is type promoted to unsigned.  If usb_control_msg() returns a
negative that is treated as a high positive value and the error handling
doesn't work.

Fixes: 2d5a9c72d0c4 ("USB: serial: ch341: fix control-message error handling")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/serial/ch341.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/serial/ch341.c
+++ b/drivers/usb/serial/ch341.c
@@ -131,7 +131,7 @@ static int ch341_control_in(struct usb_d
 	r = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0), request,
 			    USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
 			    value, index, buf, bufsize, DEFAULT_TIMEOUT);
-	if (r < bufsize) {
+	if (r < (int)bufsize) {
 		if (r >= 0) {
 			dev_err(&dev->dev,
 				"short control message received (%d < %u)\n",

