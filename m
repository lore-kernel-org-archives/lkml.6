Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB566C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FDCB213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/NiMnc8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FDCB213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732063AbeJKXQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:16:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732050AbeJKXQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:16:05 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFFC021470;
        Thu, 11 Oct 2018 15:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272899;
        bh=7IbEvQ+Yk2B02ufmWke3u4vsm2G0i8Ef58bMa1wcYY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r/NiMnc8aoiihtYW2H3KcMzdgjLZt3CnZL5qQjKPcGCrtD5Lu61/EzF6aBJ0RhFAn
         ovHUFqfvpd3QvxD6RYgPf/OU2tNCgFQzsDY52LhXQbGUVc+lLb5AE8HpRaHy0/aZBC
         QRUSeXTMTWGFQAU44h9tK2fQDjZ68ejzNR2bzm60=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kristian Evensen <kristian.evensen@gmail.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.18 32/44] USB: serial: option: add two-endpoints device-id flag
Date:   Thu, 11 Oct 2018 17:40:10 +0200
Message-Id: <20181011152453.852573726@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152452.571669983@linuxfoundation.org>
References: <20181011152452.571669983@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 35aecc02b5b621782111f64cbb032c7f6a90bb32 upstream.

Allow matching on interfaces having two endpoints by adding a new
device-id flag.

This allows for the handling of devices whose interface numbers can
change (e.g. Quectel EP06) to be contained in the device-id table.

Tested-by: Kristian Evensen <kristian.evensen@gmail.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/option.c |   17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -561,6 +561,9 @@ static void option_instat_callback(struc
 /* Interface is reserved */
 #define RSVD(ifnum)	((BIT(ifnum) & 0xff) << 0)
 
+/* Interface must have two endpoints */
+#define NUMEP2		BIT(16)
+
 
 static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE(OPTION_VENDOR_ID, OPTION_PRODUCT_COLT) },
@@ -1082,7 +1085,7 @@ static const struct usb_device_id option
 	{ USB_DEVICE(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_BG96),
 	  .driver_info = RSVD(4) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EP06, 0xff, 0xff, 0xff),
-	  .driver_info = RSVD(1) | RSVD(2) | RSVD(3) | RSVD(4) },
+	  .driver_info = RSVD(1) | RSVD(2) | RSVD(3) | RSVD(4) | NUMEP2 },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EP06, 0xff, 0, 0) },
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_6001) },
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_CMU_300) },
@@ -1986,7 +1989,6 @@ static int option_probe(struct usb_seria
 {
 	struct usb_interface_descriptor *iface_desc =
 				&serial->interface->cur_altsetting->desc;
-	struct usb_device_descriptor *dev_desc = &serial->dev->descriptor;
 	unsigned long device_flags = id->driver_info;
 
 	/* Never bind to the CD-Rom emulation interface	*/
@@ -2002,16 +2004,11 @@ static int option_probe(struct usb_seria
 		return -ENODEV;
 
 	/*
-	 * Don't bind to the QMI device of the Quectel EP06/EG06/EM06. Class,
-	 * subclass and protocol is 0xff for both the diagnostic port and the
-	 * QMI interface, but the diagnostic port only has two endpoints (QMI
-	 * has three).
+	 * Allow matching on bNumEndpoints for devices whose interface numbers
+	 * can change (e.g. Quectel EP06).
 	 */
-	if (dev_desc->idVendor == cpu_to_le16(QUECTEL_VENDOR_ID) &&
-	    dev_desc->idProduct == cpu_to_le16(QUECTEL_PRODUCT_EP06) &&
-	    iface_desc->bInterfaceSubClass && iface_desc->bNumEndpoints == 3) {
+	if (device_flags & NUMEP2 && iface_desc->bNumEndpoints != 2)
 		return -ENODEV;
-	}
 
 	/* Store the device flags so we can use them during attach. */
 	usb_set_serial_data(serial, (void *)device_flags);


