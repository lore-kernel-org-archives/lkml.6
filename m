Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C558C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B6A2243E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B6A2243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388248AbeKOTnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 14:43:14 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:46476 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388028AbeKOTnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 14:43:12 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id EC1245FD9F; Thu, 15 Nov 2018 17:36:04 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Loic Poulain <loic.poulain@gmail.com>,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v2 11/15] Bluetooth: hci_bcm: Add BCM20702A1 variant
Date:   Thu, 15 Nov 2018 17:35:59 +0800
Message-Id: <20181115093603.26729-12-wens@csie.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181115093603.26729-1-wens@csie.org>
References: <20181115093603.26729-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

The BCM20702A1 chip is a single-chip Bluetooth 4.0 controller and
transceiver. It is found in the AMPAK AP6210 WiFi+BT package.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/bluetooth/btbcm.c   | 6 ++++++
 drivers/bluetooth/hci_bcm.c | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index e3e4d929e74f..22d4b530da03 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -33,6 +33,7 @@
 #define VERSION "0.1"
 
 #define BDADDR_BCM20702A0 (&(bdaddr_t) {{0x00, 0xa0, 0x02, 0x70, 0x20, 0x00}})
+#define BDADDR_BCM20702A1 (&(bdaddr_t) {{0x00, 0x00, 0xa0, 0x02, 0x70, 0x20}})
 #define BDADDR_BCM4324B3 (&(bdaddr_t) {{0x00, 0x00, 0x00, 0xb3, 0x24, 0x43}})
 #define BDADDR_BCM4330B1 (&(bdaddr_t) {{0x00, 0x00, 0x00, 0xb1, 0x30, 0x43}})
 
@@ -64,6 +65,9 @@ int btbcm_check_bdaddr(struct hci_dev *hdev)
 	 * The address 00:20:70:02:A0:00 indicates a BCM20702A0 controller
 	 * with no configured address.
 	 *
+	 * The address 20:70:02:A0:00:00 indicates a BCM20702A1 controller
+	 * with no configured address.
+	 *
 	 * The address 43:24:B3:00:00:00 indicates a BCM4324B3 controller
 	 * with waiting for configuration state.
 	 *
@@ -71,6 +75,7 @@ int btbcm_check_bdaddr(struct hci_dev *hdev)
 	 * with waiting for configuration state.
 	 */
 	if (!bacmp(&bda->bdaddr, BDADDR_BCM20702A0) ||
+	    !bacmp(&bda->bdaddr, BDADDR_BCM20702A1) ||
 	    !bacmp(&bda->bdaddr, BDADDR_BCM4324B3) ||
 	    !bacmp(&bda->bdaddr, BDADDR_BCM4330B1)) {
 		bt_dev_info(hdev, "BCM: Using default device address (%pMR)",
@@ -330,6 +335,7 @@ static const struct bcm_subver_table bcm_uart_subver_table[] = {
 	{ 0x2209, "BCM43430A1"  },	/* 001.002.009 */
 	{ 0x6119, "BCM4345C0"	},	/* 003.001.025 */
 	{ 0x230f, "BCM4356A2"	},	/* 001.003.015 */
+	{ 0x220e, "BCM20702A1"  },	/* 001.002.014 */
 	{ }
 };
 
diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 538ce8059bff..8c75e7a67379 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -1396,6 +1396,7 @@ static void bcm_serdev_remove(struct serdev_device *serdev)
 
 #ifdef CONFIG_OF
 static const struct of_device_id bcm_bluetooth_of_match[] = {
+	{ .compatible = "brcm,bcm20702a1" },
 	{ .compatible = "brcm,bcm43438-bt" },
 	{ },
 };
-- 
2.19.1

