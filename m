Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69943C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B81120883
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtzadDGn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B81120883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732608AbeKIHqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:46:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:39560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729928AbeKIHp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:45:59 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D675E2147A;
        Thu,  8 Nov 2018 22:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714908;
        bh=4koSlYqrUYC6xxW/5NywzdwNhcnQSEq3+7Ckbm0VNDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JtzadDGnfFefW0zNf2CD3/1LEp63QXMnF+8x7R6ec/mvCrSbm0q8Rf/1nFCyXW5O0
         xbPLl6Ui03NNslR2QM5ZFe/LSuuknFT4tL2dj1qkKfCqW5fJrje4ntEJNNZoodKLkX
         mTjZi95H9pwNqESqyIowKbXlOSZJZ1ib9fMMpcX4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kristian Evensen <kristian.evensen@gmail.com>,
        Dan Williams <dcbw@redhat.com>,
        Johan Hovold <johan@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 03/31] USB: serial: option: improve Quectel EP06 detection
Date:   Thu,  8 Nov 2018 13:52:27 -0800
Message-Id: <20181108215129.893573077@linuxfoundation.org>
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

commit 36cae568404a298a19a6e8a3f18641075d4cab04 upstream

The Quectel EP06 (and EM06/EG06) LTE modem supports updating the USB
configuration, without the VID/PID or configuration number changing.
When the configuration is updated and interfaces are added/removed, the
interface numbers are updated. This causes our current code for matching
EP06 not to work as intended, as the assumption about reserved
interfaces no longer holds. If for example the diagnostic (first)
interface is removed, option will (try to) bind to the QMI interface.

This patch improves EP06 detection by replacing the current match with
two matches, and those matches check class, subclass and protocol as
well as VID and PID. The diag interface exports class, subclass and
protocol as 0xff. For the other serial interfaces, class is 0xff and
subclass and protocol are both 0x0.

The modem can export the following devices and always in this order:
diag, nmea, at, ppp. qmi and adb. This means that diag can only ever be
interface 0, and interface numbers 1-5 should be marked as reserved. The
three other serial devices can have interface numbers 0-3, but I have
not marked any interfaces as reserved. The reason is that the serial
devices are the only interfaces exported by the device where subclass
and protocol is 0x0.

QMI exports the same class, subclass and protocol values as the diag
interface. However, the two interfaces have different number of
endpoints, QMI has three and diag two. I have added a check for number
of interfaces if VID/PID matches the EP06, and we ignore the device if
number of interfaces equals three (and subclass is set).

The upstream commit does not apply cleanly to the 4.14-tree because of
differences in option_probe(). In order to make the commit apply, a
slight reshuffeling of the code was needed.

Signed-off-by: Kristian Evensen <kristian.evensen@gmail.com>
Acked-by: Dan Williams <dcbw@redhat.com>
[ johan: drop uneeded RSVD(5) for ADB ]
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Kristian Evensen <kristian.evensen@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/serial/option.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 0600dadd6a0c..d8d3cb18e9ea 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1084,8 +1084,9 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(4) },
 	{ USB_DEVICE(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_BG96),
 	  .driver_info = RSVD(4) },
-	{ USB_DEVICE(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EP06),
-	  .driver_info = RSVD(4) | RSVD(5) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EP06, 0xff, 0xff, 0xff),
+	  .driver_info = RSVD(1) | RSVD(2) | RSVD(3) | RSVD(4) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EP06, 0xff, 0, 0) },
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_6001) },
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_CMU_300) },
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_6003),
@@ -2010,6 +2011,18 @@ static int option_probe(struct usb_serial *serial,
 	    iface_desc->bInterfaceClass != USB_CLASS_CDC_DATA)
 		return -ENODEV;
 
+	/*
+	 * Don't bind to the QMI device of the Quectel EP06/EG06/EM06. Class,
+	 * subclass and protocol is 0xff for both the diagnostic port and the
+	 * QMI interface, but the diagnostic port only has two endpoints (QMI
+	 * has three).
+	 */
+	if (dev_desc->idVendor == cpu_to_le16(QUECTEL_VENDOR_ID) &&
+	    dev_desc->idProduct == cpu_to_le16(QUECTEL_PRODUCT_EP06) &&
+	    iface_desc->bInterfaceSubClass && iface_desc->bNumEndpoints == 3) {
+		return -ENODEV;
+	}
+
 	/* Store the device flags so we can use them during attach. */
 	usb_set_serial_data(serial, (void *)device_flags);
 
-- 
2.17.1



