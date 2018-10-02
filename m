Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AF8C64EB5
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A5CA206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:35:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A5CA206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732596AbeJBUSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:18:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35580 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730199AbeJBUSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:18:37 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2935C5AA;
        Tue,  2 Oct 2018 13:35:13 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        syzbot+843efa30c8821bd69f53@syzkaller.appspotmail.com
Subject: [PATCH 4.14 099/137] USB: usbdevfs: sanitize flags more
Date:   Tue,  2 Oct 2018 06:25:00 -0700
Message-Id: <20181002132505.429178298@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132458.446916963@linuxfoundation.org>
References: <20181002132458.446916963@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1451,10 +1451,13 @@ static int proc_do_submiturb(struct usb_
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
@@ -1488,6 +1491,8 @@ static int proc_do_submiturb(struct usb_
 	u = 0;
 	switch (uurb->type) {
 	case USBDEVFS_URB_TYPE_CONTROL:
+		if (is_in)
+			allow_short = true;
 		if (!usb_endpoint_xfer_control(&ep->desc))
 			return -EINVAL;
 		/* min 8 byte setup packet */
@@ -1528,6 +1533,10 @@ static int proc_do_submiturb(struct usb_
 		break;
 
 	case USBDEVFS_URB_TYPE_BULK:
+		if (!is_in)
+			allow_zero = true;
+		else
+			allow_short = true;
 		switch (usb_endpoint_type(&ep->desc)) {
 		case USB_ENDPOINT_XFER_CONTROL:
 		case USB_ENDPOINT_XFER_ISOC:
@@ -1548,6 +1557,10 @@ static int proc_do_submiturb(struct usb_
 		if (!usb_endpoint_xfer_int(&ep->desc))
 			return -EINVAL;
  interrupt_urb:
+		if (!is_in)
+			allow_zero = true;
+		else
+			allow_short = true;
 		break;
 
 	case USBDEVFS_URB_TYPE_ISO:
@@ -1692,11 +1705,11 @@ static int proc_do_submiturb(struct usb_
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


