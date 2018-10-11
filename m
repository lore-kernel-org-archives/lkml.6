Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BACC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 423AB2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIKzGras"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 423AB2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbeJKXGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:06:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727569AbeJKXF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:05:59 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 999832098A;
        Thu, 11 Oct 2018 15:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272296;
        bh=LeKxiI7LFTTZ2seiH+E139tjvEmpMgtE67P03c7oZn8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kIKzGrasK56e6IBi0Exzg1aBEjldbYwNZGe2hos/E1jzJ1m14eSsU66btUruBBAyn
         vwhNNKuHwJlqnoAi/Vv+xSd4GS7+I73Zg3CB1I9mp0atYlOaDhzjOu/WWPewkIhycY
         d0vqbWVK4ftz8tHzusWM+gqGxtp5jfmVE42/zRmc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        syzbot+843efa30c8821bd69f53@syzkaller.appspotmail.com
Subject: [PATCH 3.18 057/120] USB: usbdevfs: sanitize flags more
Date:   Thu, 11 Oct 2018 17:33:58 +0200
Message-Id: <20181011152552.109242797@linuxfoundation.org>
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
@@ -1286,10 +1286,13 @@ static int proc_do_submiturb(struct usb_
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
@@ -1323,6 +1326,8 @@ static int proc_do_submiturb(struct usb_
 	u = 0;
 	switch(uurb->type) {
 	case USBDEVFS_URB_TYPE_CONTROL:
+		if (is_in)
+			allow_short = true;
 		if (!usb_endpoint_xfer_control(&ep->desc))
 			return -EINVAL;
 		/* min 8 byte setup packet */
@@ -1363,6 +1368,10 @@ static int proc_do_submiturb(struct usb_
 		break;
 
 	case USBDEVFS_URB_TYPE_BULK:
+		if (!is_in)
+			allow_zero = true;
+		else
+			allow_short = true;
 		switch (usb_endpoint_type(&ep->desc)) {
 		case USB_ENDPOINT_XFER_CONTROL:
 		case USB_ENDPOINT_XFER_ISOC:
@@ -1383,6 +1392,10 @@ static int proc_do_submiturb(struct usb_
 		if (!usb_endpoint_xfer_int(&ep->desc))
 			return -EINVAL;
  interrupt_urb:
+		if (!is_in)
+			allow_zero = true;
+		else
+			allow_short = true;
 		break;
 
 	case USBDEVFS_URB_TYPE_ISO:
@@ -1508,11 +1521,11 @@ static int proc_do_submiturb(struct usb_
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


