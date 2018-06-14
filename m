Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CA072C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F37B208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtizjVyJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F37B208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965829AbeFNOLX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:11:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:52358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965788AbeFNOLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:11:15 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 455FD208DA;
        Thu, 14 Jun 2018 14:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985474;
        bh=QhDJ8qZpgbeotQiCHBcvVR1cknlrEWz7iV5KbZNP54A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KtizjVyJ6qf1fmdD3bAq8nLCZk0D3qBWIEXW7Td/unUP5zM0skgnY56Z7Mt4NokfX
         Lg2/7OsXYKBhhafsGifWs0oE1QKjBbXD/yb11fJuOgA2/PYeWgD7IATp9IgsFsgh+N
         ABwJX6giY71GE4u4M7v2vI9m+GGlC0QSGIID3QOU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Carlos Manuel Santos <cmmpsantos@gmail.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.14 10/36] NFC: pn533: dont send USB data off of the stack
Date:   Thu, 14 Jun 2018 16:04:33 +0200
Message-Id: <20180614132157.746575492@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132157.333004166@linuxfoundation.org>
References: <20180614132157.333004166@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit dbafc28955fa6779dc23d1607a0fee5e509a278b upstream.

It's amazing that this driver ever worked, but now that x86 doesn't
allow USB data to be sent off of the stack, it really does not work at
all.  Fix this up by properly allocating the data for the small
"commands" that get sent to the device off of the stack.

We do this for one command by having a whole urb just for ack messages,
as they can be submitted in interrupt context, so we can not use
usb_bulk_msg().  But the poweron command can sleep (and does), so use
usb_bulk_msg() for that transfer.

Reported-by: Carlos Manuel Santos <cmmpsantos@gmail.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>
Cc: stable <stable@vger.kernel.org>
Reviewed-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nfc/pn533/usb.c |   42 ++++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)

--- a/drivers/nfc/pn533/usb.c
+++ b/drivers/nfc/pn533/usb.c
@@ -62,6 +62,9 @@ struct pn533_usb_phy {
 	struct urb *out_urb;
 	struct urb *in_urb;
 
+	struct urb *ack_urb;
+	u8 *ack_buffer;
+
 	struct pn533 *priv;
 };
 
@@ -150,13 +153,16 @@ static int pn533_usb_send_ack(struct pn5
 	struct pn533_usb_phy *phy = dev->phy;
 	static const u8 ack[6] = {0x00, 0x00, 0xff, 0x00, 0xff, 0x00};
 	/* spec 7.1.1.3:  Preamble, SoPC (2), ACK Code (2), Postamble */
-	int rc;
 
-	phy->out_urb->transfer_buffer = (u8 *)ack;
-	phy->out_urb->transfer_buffer_length = sizeof(ack);
-	rc = usb_submit_urb(phy->out_urb, flags);
+	if (!phy->ack_buffer) {
+		phy->ack_buffer = kmemdup(ack, sizeof(ack), flags);
+		if (!phy->ack_buffer)
+			return -ENOMEM;
+	}
 
-	return rc;
+	phy->ack_urb->transfer_buffer = phy->ack_buffer;
+	phy->ack_urb->transfer_buffer_length = sizeof(ack);
+	return usb_submit_urb(phy->ack_urb, flags);
 }
 
 static int pn533_usb_send_frame(struct pn533 *dev,
@@ -375,26 +381,31 @@ static int pn533_acr122_poweron_rdr(stru
 	/* Power on th reader (CCID cmd) */
 	u8 cmd[10] = {PN533_ACR122_PC_TO_RDR_ICCPOWERON,
 		      0, 0, 0, 0, 0, 0, 3, 0, 0};
+	char *buffer;
+	int transferred;
 	int rc;
 	void *cntx;
 	struct pn533_acr122_poweron_rdr_arg arg;
 
 	dev_dbg(&phy->udev->dev, "%s\n", __func__);
 
+	buffer = kmemdup(cmd, sizeof(cmd), GFP_KERNEL);
+	if (!buffer)
+		return -ENOMEM;
+
 	init_completion(&arg.done);
 	cntx = phy->in_urb->context;  /* backup context */
 
 	phy->in_urb->complete = pn533_acr122_poweron_rdr_resp;
 	phy->in_urb->context = &arg;
 
-	phy->out_urb->transfer_buffer = cmd;
-	phy->out_urb->transfer_buffer_length = sizeof(cmd);
-
 	print_hex_dump_debug("ACR122 TX: ", DUMP_PREFIX_NONE, 16, 1,
 		       cmd, sizeof(cmd), false);
 
-	rc = usb_submit_urb(phy->out_urb, GFP_KERNEL);
-	if (rc) {
+	rc = usb_bulk_msg(phy->udev, phy->out_urb->pipe, buffer, sizeof(cmd),
+			  &transferred, 0);
+	kfree(buffer);
+	if (rc || (transferred != sizeof(cmd))) {
 		nfc_err(&phy->udev->dev,
 			"Reader power on cmd error %d\n", rc);
 		return rc;
@@ -490,8 +501,9 @@ static int pn533_usb_probe(struct usb_in
 
 	phy->in_urb = usb_alloc_urb(0, GFP_KERNEL);
 	phy->out_urb = usb_alloc_urb(0, GFP_KERNEL);
+	phy->ack_urb = usb_alloc_urb(0, GFP_KERNEL);
 
-	if (!phy->in_urb || !phy->out_urb)
+	if (!phy->in_urb || !phy->out_urb || !phy->ack_urb)
 		goto error;
 
 	usb_fill_bulk_urb(phy->in_urb, phy->udev,
@@ -501,7 +513,9 @@ static int pn533_usb_probe(struct usb_in
 	usb_fill_bulk_urb(phy->out_urb, phy->udev,
 			  usb_sndbulkpipe(phy->udev, out_endpoint),
 			  NULL, 0, pn533_send_complete, phy);
-
+	usb_fill_bulk_urb(phy->ack_urb, phy->udev,
+			  usb_sndbulkpipe(phy->udev, out_endpoint),
+			  NULL, 0, pn533_send_complete, phy);
 
 	switch (id->driver_info) {
 	case PN533_DEVICE_STD:
@@ -554,6 +568,7 @@ static int pn533_usb_probe(struct usb_in
 error:
 	usb_free_urb(phy->in_urb);
 	usb_free_urb(phy->out_urb);
+	usb_free_urb(phy->ack_urb);
 	usb_put_dev(phy->udev);
 	kfree(in_buf);
 
@@ -573,10 +588,13 @@ static void pn533_usb_disconnect(struct
 
 	usb_kill_urb(phy->in_urb);
 	usb_kill_urb(phy->out_urb);
+	usb_kill_urb(phy->ack_urb);
 
 	kfree(phy->in_urb->transfer_buffer);
 	usb_free_urb(phy->in_urb);
 	usb_free_urb(phy->out_urb);
+	usb_free_urb(phy->ack_urb);
+	kfree(phy->ack_buffer);
 
 	nfc_info(&interface->dev, "NXP PN533 NFC device disconnected\n");
 }


