Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5826C282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A3C4218D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbfBCNyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:54:47 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:54474 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728719AbfBCNym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:54:42 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIEK-0003wG-9g; Sun, 03 Feb 2019 13:54:40 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9r-0007OO-8A; Sun, 03 Feb 2019 14:50:03 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Mathias Payer" <mathias.payer@nebelwelt.net>,
        "Hui Peng" <benquike@gmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.238537926@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 266/305] USB: check usb_get_extra_descriptor for
 proper size
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Payer <mathias.payer@nebelwelt.net>

commit 704620afc70cf47abb9d6a1a57f3825d2bca49cf upstream.

When reading an extra descriptor, we need to properly check the minimum
and maximum size allowed, to prevent from invalid data being sent by a
device.

Reported-by: Hui Peng <benquike@gmail.com>
Reported-by: Mathias Payer <mathias.payer@nebelwelt.net>
Co-developed-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Hui Peng <benquike@gmail.com>
Signed-off-by: Mathias Payer <mathias.payer@nebelwelt.net>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/core/hub.c    | 2 +-
 drivers/usb/core/usb.c    | 6 +++---
 drivers/usb/host/hwa-hc.c | 2 +-
 include/linux/usb.h       | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2211,7 +2211,7 @@ static int usb_enumerate_device_otg(stru
 		/* descriptor may appear anywhere in config */
 		if (__usb_get_extra_descriptor (udev->rawdescriptors[0],
 					le16_to_cpu(udev->config[0].desc.wTotalLength),
-					USB_DT_OTG, (void **) &desc) == 0) {
+					USB_DT_OTG, (void **) &desc, sizeof(*desc)) == 0) {
 			if (desc->bmAttributes & USB_OTG_HNP) {
 				unsigned		port1 = udev->portnum;
 
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -663,14 +663,14 @@ EXPORT_SYMBOL_GPL(usb_get_current_frame_
  */
 
 int __usb_get_extra_descriptor(char *buffer, unsigned size,
-			       unsigned char type, void **ptr)
+			       unsigned char type, void **ptr, size_t minsize)
 {
 	struct usb_descriptor_header *header;
 
 	while (size >= sizeof(struct usb_descriptor_header)) {
 		header = (struct usb_descriptor_header *)buffer;
 
-		if (header->bLength < 2) {
+		if (header->bLength < 2 || header->bLength > size) {
 			printk(KERN_ERR
 				"%s: bogus descriptor, type %d length %d\n",
 				usbcore_name,
@@ -679,7 +679,7 @@ int __usb_get_extra_descriptor(char *buf
 			return -1;
 		}
 
-		if (header->bDescriptorType == type) {
+		if (header->bDescriptorType == type && header->bLength >= minsize) {
 			*ptr = header;
 			return 0;
 		}
--- a/drivers/usb/host/hwa-hc.c
+++ b/drivers/usb/host/hwa-hc.c
@@ -654,7 +654,7 @@ static int hwahc_security_create(struct
 	top = itr + itr_size;
 	result = __usb_get_extra_descriptor(usb_dev->rawdescriptors[index],
 			le16_to_cpu(usb_dev->actconfig->desc.wTotalLength),
-			USB_DT_SECURITY, (void **) &secd);
+			USB_DT_SECURITY, (void **) &secd, sizeof(*secd));
 	if (result == -1) {
 		dev_warn(dev, "BUG? WUSB host has no security descriptors\n");
 		return 0;
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -334,11 +334,11 @@ struct usb_host_bos {
 };
 
 int __usb_get_extra_descriptor(char *buffer, unsigned size,
-	unsigned char type, void **ptr);
+	unsigned char type, void **ptr, size_t min);
 #define usb_get_extra_descriptor(ifpoint, type, ptr) \
 				__usb_get_extra_descriptor((ifpoint)->extra, \
 				(ifpoint)->extralen, \
-				type, (void **)ptr)
+				type, (void **)ptr, sizeof(**(ptr)))
 
 /* ----------------------------------------------------------------------- */
 

