Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3C3C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C675120840
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sj2IoOgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C675120840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbeKIIWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:22:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:47466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728403AbeKIHcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:32:20 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 317EB2086C;
        Thu,  8 Nov 2018 21:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714093;
        bh=3hBoFLqWYzz7XUs7k73BvU3Hew8HatBsANcZNYWQxgc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sj2IoOgRPRxKc66chz6/EK3Kt87ZcL8ky6P++h9ZeJuYxTTqV9t/cH5Hp6TsUlw7F
         eyYhHOmKpQNiffxkOMVSHYbMY+0LcrdONScFECW7SbLEq74a4y8R3erCR3t4NKd0uC
         qEgkjmdhtVHoKfXrC/+JYuI8yjHBrjY/W9FAlw6Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Hauke <mardnh@gmx.de>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        Johan Hovold <johan@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 035/144] USB: qcserial: Fix support for HP lt4112 LTE/HSPA+ Gobi 4G Modem
Date:   Thu,  8 Nov 2018 13:50:06 -0800
Message-Id: <20181108215057.411814172@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
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



