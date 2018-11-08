Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F46ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1B92089F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1goWcKWB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B1B92089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732632AbeKIHqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:46:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:39692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731252AbeKIHqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:46:05 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D6882089F;
        Thu,  8 Nov 2018 22:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714913;
        bh=LO346Av21OvbT+uppmB8O9ZMiVG+7JLa228iiOb1JUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1goWcKWB+WarfjU8d6UL+PCKCyk8+FDm8ocFNMZDzr4eoJYwniTpcc+MDbg/Uelme
         qMoCTkCdppPDUxXizxHhVGxzfgxxgi5Z9+SnR7tj/uOCr0qSmoiUVlL9ih4ciSPAgx
         elMbJ56ezKpTsfFY0laOKJgV4560mVast5GXeSbA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kristian Evensen <kristian.evensen@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 04/31] USB: serial: option: add two-endpoints device-id flag
Date:   Thu,  8 Nov 2018 13:52:28 -0800
Message-Id: <20181108215129.992313687@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215129.641434673@linuxfoundation.org>
References: <20181108215129.641434673@linuxfoundation.org>
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

commit 35aecc02b5b621782111f64cbb032c7f6a90bb32 upstream

Allow matching on interfaces having two endpoints by adding a new
device-id flag.

This allows for the handling of devices whose interface numbers can
change (e.g. Quectel EP06) to be contained in the device-id table.

The upstream commit removes a variable that is still in use in the 4.14
version of the option-driver, so the removal is undone.

Tested-by: Kristian Evensen <kristian.evensen@gmail.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Kristian Evensen <kristian.evensen@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/serial/option.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index d8d3cb18e9ea..392fddc80c44 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -564,6 +564,9 @@ static void option_instat_callback(struct urb *urb);
 /* Interface is reserved */
 #define RSVD(ifnum)	((BIT(ifnum) & 0xff) << 0)
 
+/* Interface must have two endpoints */
+#define NUMEP2		BIT(16)
+
 
 static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE(OPTION_VENDOR_ID, OPTION_PRODUCT_COLT) },
@@ -1085,7 +1088,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_BG96),
 	  .driver_info = RSVD(4) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EP06, 0xff, 0xff, 0xff),
-	  .driver_info = RSVD(1) | RSVD(2) | RSVD(3) | RSVD(4) },
+	  .driver_info = RSVD(1) | RSVD(2) | RSVD(3) | RSVD(4) | NUMEP2 },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EP06, 0xff, 0, 0) },
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_6001) },
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_CMU_300) },
@@ -2012,16 +2015,11 @@ static int option_probe(struct usb_serial *serial,
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
-- 
2.17.1



