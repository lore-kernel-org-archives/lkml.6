Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D71BC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F7AD20645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F7AD20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbeJNXLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:11:41 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35626 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726893AbeJNXLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:41 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLV-0004cF-3K; Sun, 14 Oct 2018 16:30:21 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLS-0000Lp-Qg; Sun, 14 Oct 2018 16:30:18 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Vasyl Vavrychuk" <vvavrychuk@gmail.com>,
        "Johan Hovold" <johan@kernel.org>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.206418106@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 155/366] USB: serial: ftdi_sio: use jtag quirk for
 Arrow USB Blaster
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Vasyl Vavrychuk <vvavrychuk@gmail.com>

commit 470b5d6f0cf4674be2d1ec94e54283a1770b6a1a upstream.

Arrow USB Blaster integrated on MAX1000 board uses the same vendor ID
(0x0403) and product ID (0x6010) as the "original" FTDI device.

This patch avoids picking up by ftdi_sio of the first interface of this
USB device. After that this device can be used by Arrow user-space JTAG
driver.

Signed-off-by: Vasyl Vavrychuk <vvavrychuk@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/serial/ftdi_sio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1929,7 +1929,8 @@ static int ftdi_8u2232c_probe(struct usb
 		return ftdi_jtag_probe(serial);
 
 	if (udev->product &&
-		(!strcmp(udev->product, "BeagleBone/XDS100V2") ||
+		(!strcmp(udev->product, "Arrow USB Blaster") ||
+		 !strcmp(udev->product, "BeagleBone/XDS100V2") ||
 		 !strcmp(udev->product, "SNAP Connect E10")))
 		return ftdi_jtag_probe(serial);
 

