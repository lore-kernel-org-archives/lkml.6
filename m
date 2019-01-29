Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4F4C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D44A214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762125;
	bh=O8RS+HHJQ0H5zagU02BURofzHcm9iZpuZWkk31GxoP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vB2l+P1jPZbFeS5C7JPvMS5g9i0BkyRuIv0KPwBZ1DBo9wP0xOFBEWkUgGY74vmQH
	 xlbxOwI3DmPfAqC45fCcy0v7uqxyoAhfaGkO6b5SdN7pR/d0Z+cdxeng0BOLLaK5An
	 z0YvnEDptp5JGlxYj3RrhTVvaz0qjg4elAU69/SE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbfA2LmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:42:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:59556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729242AbfA2LmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:42:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70A0D20882;
        Tue, 29 Jan 2019 11:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762119;
        bh=O8RS+HHJQ0H5zagU02BURofzHcm9iZpuZWkk31GxoP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oZ+EmeYWQ68sQPpNlwGSuUjVefQdx+C20q2Mua0Sk7k/IEm77/ZEKyGJmzLVFBzoJ
         TaHrAYxsVimXXdH15CsjN/T8Ak2rbJxHHPiqGlq4IlpB7ZlCviQ4JgmcpSB+JhwEt2
         ZQbf0IxcSyWqOgAoCvBOcOczzDWTjLzqkRO0bp5M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Felix Fietkau <nbd@nbd.name>,
        Stanislaw Gruszka <sgruszka@redhat.com>
Subject: [PATCH 4.20 116/117] mt76x0: phy: unify calibration between mt76x0u and mt76x0e
Date:   Tue, 29 Jan 2019 12:36:07 +0100
Message-Id: <20190129113213.130392659@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>

commit 1163bdb636a118b9d7c3c03b9e67e7e799425a9c upstream.

Align phy calibration logic between mt76x0u and mt76x0e drivers
This patch improves connection stability with low SNR

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h        |    1 
 drivers/net/wireless/mediatek/mt76/mt76x0/main.c |    3 
 drivers/net/wireless/mediatek/mt76/mt76x0/phy.c  |  101 -----------------------
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c  |    1 
 4 files changed, 6 insertions(+), 100 deletions(-)

--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1,3 +1,4 @@
+
 /*
  * Copyright (C) 2016 Felix Fietkau <nbd@nbd.name>
  *
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
@@ -116,9 +116,6 @@ void mt76x0_bss_info_changed(struct ieee
 			       MT_BKOFF_SLOT_CFG_SLOTTIME, slottime);
 	}
 
-	if (changed & BSS_CHANGED_ASSOC)
-		mt76x0_phy_recalibrate_after_assoc(dev);
-
 	mutex_unlock(&dev->mt76.mutex);
 }
 EXPORT_SYMBOL_GPL(mt76x0_bss_info_changed);
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
@@ -215,62 +215,6 @@ int mt76x0_wait_bbp_ready(struct mt76x02
 	return 0;
 }
 
-static void mt76x0_vco_cal(struct mt76x02_dev *dev, u8 channel)
-{
-	u8 val;
-
-	val = rf_rr(dev, MT_RF(0, 4));
-	if ((val & 0x70) != 0x30)
-		return;
-
-	/*
-	 * Calibration Mode - Open loop, closed loop, and amplitude:
-	 * B0.R06.[0]: 1
-	 * B0.R06.[3:1] bp_close_code: 100
-	 * B0.R05.[7:0] bp_open_code: 0x0
-	 * B0.R04.[2:0] cal_bits: 000
-	 * B0.R03.[2:0] startup_time: 011
-	 * B0.R03.[6:4] settle_time:
-	 *  80MHz channel: 110
-	 *  40MHz channel: 101
-	 *  20MHz channel: 100
-	 */
-	val = rf_rr(dev, MT_RF(0, 6));
-	val &= ~0xf;
-	val |= 0x09;
-	rf_wr(dev, MT_RF(0, 6), val);
-
-	val = rf_rr(dev, MT_RF(0, 5));
-	if (val != 0)
-		rf_wr(dev, MT_RF(0, 5), 0x0);
-
-	val = rf_rr(dev, MT_RF(0, 4));
-	val &= ~0x07;
-	rf_wr(dev, MT_RF(0, 4), val);
-
-	val = rf_rr(dev, MT_RF(0, 3));
-	val &= ~0x77;
-	if (channel == 1 || channel == 7 || channel == 9 || channel >= 13) {
-		val |= 0x63;
-	} else if (channel == 3 || channel == 4 || channel == 10) {
-		val |= 0x53;
-	} else if (channel == 2 || channel == 5 || channel == 6 ||
-		   channel == 8 || channel == 11 || channel == 12) {
-		val |= 0x43;
-	} else {
-		WARN(1, "Unknown channel %u\n", channel);
-		return;
-	}
-	rf_wr(dev, MT_RF(0, 3), val);
-
-	/* TODO replace by mt76x0_rf_set(dev, MT_RF(0, 4), BIT(7)); */
-	val = rf_rr(dev, MT_RF(0, 4));
-	val = ((val & ~(0x80)) | 0x80);
-	rf_wr(dev, MT_RF(0, 4), val);
-
-	msleep(2);
-}
-
 static void
 mt76x0_phy_set_band(struct mt76x02_dev *dev, enum nl80211_band band)
 {
@@ -749,19 +693,15 @@ int mt76x0_phy_set_channel(struct mt76x0
 	mt76x0_read_rx_gain(dev);
 	mt76x0_phy_set_chan_bbp_params(dev, rf_bw_band);
 
-	if (mt76_is_usb(dev)) {
-		mt76x0_vco_cal(dev, channel);
-	} else {
-		/* enable vco */
-		rf_set(dev, MT_RF(0, 4), BIT(7));
-	}
+	/* enable vco */
+	rf_set(dev, MT_RF(0, 4), BIT(7));
 
 	if (scan)
 		return 0;
 
+	mt76x0_phy_calibrate(dev, false);
 	mt76x02_init_agc_gain(dev);
-	if (mt76_is_mmio(dev))
-		mt76x0_phy_calibrate(dev, false);
+
 	mt76x0_phy_set_txpower(dev);
 
 	ieee80211_queue_delayed_work(dev->mt76.hw, &dev->cal_work,
@@ -770,39 +710,6 @@ int mt76x0_phy_set_channel(struct mt76x0
 	return 0;
 }
 
-void mt76x0_phy_recalibrate_after_assoc(struct mt76x02_dev *dev)
-{
-	u32 tx_alc, reg_val;
-	u8 channel = dev->mt76.chandef.chan->hw_value;
-	int is_5ghz = (dev->mt76.chandef.chan->band == NL80211_BAND_5GHZ) ? 1 : 0;
-
-	mt76x02_mcu_calibrate(dev, MCU_CAL_R, 0, false);
-
-	mt76x0_vco_cal(dev, channel);
-
-	tx_alc = mt76_rr(dev, MT_TX_ALC_CFG_0);
-	mt76_wr(dev, MT_TX_ALC_CFG_0, 0);
-	usleep_range(500, 700);
-
-	reg_val = mt76_rr(dev, MT_BBP(IBI, 9));
-	mt76_wr(dev, MT_BBP(IBI, 9), 0xffffff7e);
-
-	mt76x02_mcu_calibrate(dev, MCU_CAL_RXDCOC, 0, false);
-
-	mt76x02_mcu_calibrate(dev, MCU_CAL_LC, is_5ghz, false);
-	mt76x02_mcu_calibrate(dev, MCU_CAL_LOFT, is_5ghz, false);
-	mt76x02_mcu_calibrate(dev, MCU_CAL_TXIQ, is_5ghz, false);
-	mt76x02_mcu_calibrate(dev, MCU_CAL_TX_GROUP_DELAY, is_5ghz, false);
-	mt76x02_mcu_calibrate(dev, MCU_CAL_RXIQ, is_5ghz, false);
-	mt76x02_mcu_calibrate(dev, MCU_CAL_RX_GROUP_DELAY, is_5ghz, false);
-
-	mt76_wr(dev, MT_BBP(IBI, 9), reg_val);
-	mt76_wr(dev, MT_TX_ALC_CFG_0, tx_alc);
-	msleep(100);
-
-	mt76x02_mcu_calibrate(dev, MCU_CAL_RXDCOC, 1, false);
-}
-
 static void mt76x0_temp_sensor(struct mt76x02_dev *dev)
 {
 	u8 rf_b7_73, rf_b0_66, rf_b0_67;
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
@@ -117,6 +117,7 @@ static int mt76x0u_start(struct ieee8021
 	if (ret)
 		goto out;
 
+	mt76x0_phy_calibrate(dev, true);
 	ieee80211_queue_delayed_work(dev->mt76.hw, &dev->mac_work,
 				     MT_CALIBRATE_INTERVAL);
 	ieee80211_queue_delayed_work(dev->mt76.hw, &dev->cal_work,


