Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07315C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB27206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:40:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB27206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732735AbeJBUX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:23:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36378 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731341AbeJBUUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:20:04 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CCB24C4D;
        Tue,  2 Oct 2018 13:36:39 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        syzbot+843efa30c8821bd69f53@syzkaller.appspotmail.com
Subject: [PATCH 4.9 68/94] USB: usbdevfs: sanitize flags more
Date:   Tue,  2 Oct 2018 06:25:22 -0700
Message-Id: <20181002132505.213517683@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132500.494838053@linuxfoundation.org>
References: <20181002132500.494838053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Neukum <oneukum@suse.com>

commit 7a68d9fb851012829c29e770621905529bd9490b upstream.

Requesting a ZERO_PACKET or not is sensible only for output.
In the input direction the device decides.
Likewise accepting short packets makes sense only for input.

This allows operation with panic_on_warn without opening up
a local DOS.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Reported-by: syzbot+843efa30c8821bd69f53@syzkaller.appspotmail.com
Fixes: 0cb54a3e47cb ("USB: debugging code shouldn't alter control flow")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/devio.c |   19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -1450,10 +1450,13 @@ static int proc_do_submiturb(struct usb_
 	struct async *as = NULL;
 	struct usb_ctrlrequest *dr = NULL;
 	unsigned int u, totlen, isofrmlen;
-	int i, ret, is_in, num_sgs = 0, ifnum = -1;
+	int i, ret, num_sgs = 0, ifnum = -1;
 	int number_of_packets = 0;
 	unsigned int stream_id = 0;
 	void *buf;
+	bool is_in;
+	bool allow_short = false;
+	bool allow_zero = false;
 	unsigned long mask =	USBDEVFS_URB_SHORT_NOT_OK |
 				USBDEVFS_URB_BULK_CONTINUATION |
 				USBDEVFS_URB_NO_FSBR |
@@ -1487,6 +1490,8 @@ static int proc_do_submiturb(struct usb_
 	u = 0;
 	switch (uurb->type) {
 	case USBDEVFS_URB_TYPE_CONTROL:
+		if (is_in)
+			allow_short = true;
 		if (!usb_endpoint_xfer_control(&ep->desc))
 			return -EINVAL;
 		/* min 8 byte setup packet */
@@ -1527,6 +1532,10 @@ static int proc_do_submiturb(struct usb_
 		break;
 
 	case USBDEVFS_URB_TYPE_BULK:
+		if (!is_in)
+			allow_zero = true;
+		else
+			allow_short = true;
 		switch (usb_endpoint_type(&ep->desc)) {
 		case USB_ENDPOINT_XFER_CONTROL:
 		case USB_ENDPOINT_XFER_ISOC:
@@ -1547,6 +1556,10 @@ static int proc_do_submiturb(struct usb_
 		if (!usb_endpoint_xfer_int(&ep->desc))
 			return -EINVAL;
  interrupt_urb:
+		if (!is_in)
+			allow_zero = true;
+		else
+			allow_short = true;
 		break;
 
 	case USBDEVFS_URB_TYPE_ISO:
@@ -1691,11 +1704,11 @@ static int proc_do_submiturb(struct usb_
 	u = (is_in ? URB_DIR_IN : URB_DIR_OUT);
 	if (uurb->flags & USBDEVFS_URB_ISO_ASAP)
 		u |= URB_ISO_ASAP;
-	if (uurb->flags & USBDEVFS_URB_SHORT_NOT_OK && is_in)
+	if (allow_short && uurb->flags & USBDEVFS_URB_SHORT_NOT_OK)
 		u |= URB_SHORT_NOT_OK;
 	if (uurb->flags & USBDEVFS_URB_NO_FSBR)
 		u |= URB_NO_FSBR;
-	if (uurb->flags & USBDEVFS_URB_ZERO_PACKET)
+	if (allow_zero && uurb->flags & USBDEVFS_URB_ZERO_PACKET)
 		u |= URB_ZERO_PACKET;
 	if (uurb->flags & USBDEVFS_URB_NO_INTERRUPT)
 		u |= URB_NO_INTERRUPT;


