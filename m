Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E603C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A252087A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01A252087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388387AbeKOToT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 14:44:19 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:46482 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388031AbeKOTnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 14:43:12 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 084085FDB1; Thu, 15 Nov 2018 17:36:05 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Loic Poulain <loic.poulain@gmail.com>,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/15] Bluetooth: btbcm: Add default address for BCM43430A0
Date:   Thu, 15 Nov 2018 17:36:01 +0800
Message-Id: <20181115093603.26729-14-wens@csie.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181115093603.26729-1-wens@csie.org>
References: <20181115093603.26729-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BCM43430A0 has the default MAC address 43:43:A0:12:1F:AC if none
is given. This address was found when enabling Bluetooth on a bunch of
boards with the AMPAK AP6210 module, all sharing the same address. It
also contains the sequence 4343A0, which is suspicious as that is also
the name the chip identifies itself as.

Add this to the list of default MAC addresses and leave it to the user
to configure a valid one.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/bluetooth/btbcm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 22d4b530da03..08e1f3dd4e03 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -34,6 +34,7 @@
 
 #define BDADDR_BCM20702A0 (&(bdaddr_t) {{0x00, 0xa0, 0x02, 0x70, 0x20, 0x00}})
 #define BDADDR_BCM20702A1 (&(bdaddr_t) {{0x00, 0x00, 0xa0, 0x02, 0x70, 0x20}})
+#define BDADDR_BCM43430A0 (&(bdaddr_t) {{0xac, 0x1f, 0x12, 0xa0, 0x43, 0x43}})
 #define BDADDR_BCM4324B3 (&(bdaddr_t) {{0x00, 0x00, 0x00, 0xb3, 0x24, 0x43}})
 #define BDADDR_BCM4330B1 (&(bdaddr_t) {{0x00, 0x00, 0x00, 0xb1, 0x30, 0x43}})
 
@@ -73,11 +74,15 @@ int btbcm_check_bdaddr(struct hci_dev *hdev)
 	 *
 	 * The address 43:30:B1:00:00:00 indicates a BCM4330B1 controller
 	 * with waiting for configuration state.
+	 *
+	 * The address 43:43:A0:12:1F:AC indicates a BCM43430A0 controller
+	 * with no configured address.
 	 */
 	if (!bacmp(&bda->bdaddr, BDADDR_BCM20702A0) ||
 	    !bacmp(&bda->bdaddr, BDADDR_BCM20702A1) ||
 	    !bacmp(&bda->bdaddr, BDADDR_BCM4324B3) ||
-	    !bacmp(&bda->bdaddr, BDADDR_BCM4330B1)) {
+	    !bacmp(&bda->bdaddr, BDADDR_BCM4330B1) ||
+	    !bacmp(&bda->bdaddr, BDADDR_BCM43430A0)) {
 		bt_dev_info(hdev, "BCM: Using default device address (%pMR)",
 			    &bda->bdaddr);
 		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
-- 
2.19.1

