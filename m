Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8479AECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A446208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGg0tb2t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A446208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbeJYWwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:52:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730290AbeJYWwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:52:02 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA86F2086D;
        Thu, 25 Oct 2018 14:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477144;
        bh=jUDEOz+4hOjFo/kCO84R5YCx+Dn+pkLtkURv9wqVWMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EGg0tb2taqpJeaHYYO0bJPO1PCSv4vxQbIn6Jg179Io+7uSFP11c45H6Sfqpgca6Z
         wj/n9I+Q6pwZAzhZyzknxPBV0mKjrO0oDuAcKpPcnzPaXPoQCSrc1Wr30V3hR8kzRS
         ONkhJOJCJTPn0l6rQVOYh+CZ5LPdaTA+T5oSa/O8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        Johan Hovold <johan@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 04/98] USB: qcserial: Fix support for HP lt4112 LTE/HSPA+ Gobi 4G Modem
Date:   Thu, 25 Oct 2018 10:17:19 -0400
Message-Id: <20181025141853.214051-4-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjørn Mork <bjorn@mork.no>

[ Upstream commit 59536da34513c594af2a6fd35ba65ea45b6960a1 ]

The DEVICE_HWI type was added under the faulty assumption that Huawei
devices based on Qualcomm chipsets and firmware use the static USB
interface numbering known from Gobi devices.  But this model does
not apply to Huawei devices like the HP branded lt4112 (Huawei me906e).
Huawei firmwares will dynamically assign interface numbers. Functions
are renumbered when the firmware is reconfigured.

Fix by changing the DEVICE_HWI type to use a simplified version
of Huawei's subclass + protocol scheme: Blacklisting known network
interface combinations and assuming the rest are serial.

Reported-and-tested-by: Muri Nicanor <muri+libqmi@immerda.ch>
Tested-by: Martin Hauke <mardnh@gmx.de>
Cc: <stable@vger.kernel.org>
Fixes: e7181d005e84 ("USB: qcserial: Add support for HP lt4112 LTE/HSPA+ Gobi 4G Modem")
Signed-off-by: Bjørn Mork <bjorn@mork.no>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/serial/qcserial.c | 54 ++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/serial/qcserial.c b/drivers/usb/serial/qcserial.c
index adc372411019..7e8014304b33 100644
--- a/drivers/usb/serial/qcserial.c
+++ b/drivers/usb/serial/qcserial.c
@@ -190,6 +190,10 @@ static int qcprobe(struct usb_serial *serial, const struct usb_device_id *id)
 	__u8 ifnum;
 	int altsetting = -1;
 
+	/* we only support vendor specific functions */
+	if (intf->desc.bInterfaceClass != USB_CLASS_VENDOR_SPEC)
+		goto done;
+
 	nintf = serial->dev->actconfig->desc.bNumInterfaces;
 	dev_dbg(dev, "Num Interfaces = %d\n", nintf);
 	ifnum = intf->desc.bInterfaceNumber;
@@ -309,29 +313,39 @@ static int qcprobe(struct usb_serial *serial, const struct usb_device_id *id)
 		break;
 	case QCSERIAL_HWI:
 		/*
-		 * Huawei layout:
-		 * 0: AT-capable modem port
-		 * 1: DM/DIAG
-		 * 2: AT-capable modem port
-		 * 3: CCID-compatible PCSC interface
-		 * 4: QMI/net
-		 * 5: NMEA
+		 * Huawei devices map functions by subclass + protocol
+		 * instead of interface numbers. The protocol identify
+		 * a specific function, while the subclass indicate a
+		 * specific firmware source
+		 *
+		 * This is a blacklist of functions known to be
+		 * non-serial.  The rest are assumed to be serial and
+		 * will be handled by this driver
 		 */
-		switch (ifnum) {
-		case 0:
-		case 2:
-			dev_dbg(dev, "Modem port found\n");
-			break;
-		case 1:
-			dev_dbg(dev, "DM/DIAG interface found\n");
-			break;
-		case 5:
-			dev_dbg(dev, "NMEA GPS interface found\n");
-			break;
-		default:
-			/* don't claim any unsupported interface */
+		switch (intf->desc.bInterfaceProtocol) {
+			/* QMI combined (qmi_wwan) */
+		case 0x07:
+		case 0x37:
+		case 0x67:
+			/* QMI data (qmi_wwan) */
+		case 0x08:
+		case 0x38:
+		case 0x68:
+			/* QMI control (qmi_wwan) */
+		case 0x09:
+		case 0x39:
+		case 0x69:
+			/* NCM like (huawei_cdc_ncm) */
+		case 0x16:
+		case 0x46:
+		case 0x76:
 			altsetting = -1;
 			break;
+		default:
+			dev_dbg(dev, "Huawei type serial port found (%02x/%02x/%02x)\n",
+				intf->desc.bInterfaceClass,
+				intf->desc.bInterfaceSubClass,
+				intf->desc.bInterfaceProtocol);
 		}
 		break;
 	default:
-- 
2.17.1

