Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC243C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C16B20855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543538;
	bh=ZaGYyjaV59uDGija242PxqDspBwSJ2TOHUcIAe14BwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=op4voS0F4EnysIJUPKxdv1qQSWQdWpuJCWtJpKAEWEWJOXOesOu7y8wW6YSE6wkqI
	 fcSo+J1OD1bWV1e9Ah+dkt0lMG8gQxFX8N76BJ7onRN1TS9e/F4z68jh6g4iNQT9VZ
	 t/rCAFx3lGHoiAymVGj+JUOoa0DJPMGyi7tmnRno=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C16B20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbeLKPwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:52:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:40920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727901AbeLKPwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:52:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D358720855;
        Tue, 11 Dec 2018 15:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543533;
        bh=ZaGYyjaV59uDGija242PxqDspBwSJ2TOHUcIAe14BwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RR/zr+aUDjiA/yz1vodQRv8DDgsuxHH0jJ/JcAbcvwL1z01Iuhysj3rfi6LxfU52l
         X6i/uX5OZzMztM4Y9Wknrrh8SXFDNIa1Uzd+scM8iRvd4yizn74Exd6yTpQlsV4YUX
         XwlbzazNv+1m4Pwi/l1gZgZYwxPr0k6gHRwx7T3I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hui Peng <benquike@gmail.com>,
        Mathias Payer <mathias.payer@nebelwelt.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        stable <stable@kernel.org>
Subject: [PATCH 4.14 33/67] USB: check usb_get_extra_descriptor for proper size
Date:   Tue, 11 Dec 2018 16:41:33 +0100
Message-Id: <20181211151632.057311822@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151630.378216233@linuxfoundation.org>
References: <20181211151630.378216233@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/hub.c    |    2 +-
 drivers/usb/core/usb.c    |    6 +++---
 drivers/usb/host/hwa-hc.c |    2 +-
 include/linux/usb.h       |    4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2231,7 +2231,7 @@ static int usb_enumerate_device_otg(stru
 		/* descriptor may appear anywhere in config */
 		err = __usb_get_extra_descriptor(udev->rawdescriptors[0],
 				le16_to_cpu(udev->config[0].desc.wTotalLength),
-				USB_DT_OTG, (void **) &desc);
+				USB_DT_OTG, (void **) &desc, sizeof(*desc));
 		if (err || !(desc->bmAttributes & USB_OTG_HNP))
 			return 0;
 
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -833,14 +833,14 @@ EXPORT_SYMBOL_GPL(usb_get_current_frame_
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
@@ -849,7 +849,7 @@ int __usb_get_extra_descriptor(char *buf
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
@@ -407,11 +407,11 @@ struct usb_host_bos {
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
 


