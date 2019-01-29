Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED75BC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4E3C214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762121;
	bh=vZzBy18lbiGEqy/mi3DWhGyp3T7J8LHV1LmVo7utBi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rhQ+KHPZXWuzbivd/NynAaz5b3HfF2iqnucM3C/6QkfAJEaXQbcTNE3u3xDMJnsJk
	 qsZMFBpfwyUFX9h4LkNc2wXfiLGM2+xYulytRyBIRKWZ372NMIlkIFwArnrsIS5z65
	 kzlpespnEUIZzDpl6JuXIPs9syuTKOWWlbEoUeB0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbfA2LmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:42:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:59482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729931AbfA2Ll5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:41:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD73120882;
        Tue, 29 Jan 2019 11:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762116;
        bh=vZzBy18lbiGEqy/mi3DWhGyp3T7J8LHV1LmVo7utBi4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v3+n+JZnTEsi30qL+cHhNlh1XDbX4hHSZfWTl+tVFYwFtexmuKtjtGcVwSDCyuVEN
         7HFjJ0SG5kr8c8ZLXJYRvgSIVTOdlrh2Ehi/icH4I7ggSvcboVNT1zSkg2AsQ0DAsL
         Yt6K9C1Fg6mYyv0ZfHT5Ww0tEi9GvRDz06nK80Uc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Felix Fietkau <nbd@nbd.name>,
        Stanislaw Gruszka <sgruszka@redhat.com>
Subject: [PATCH 4.20 115/117] mt76x0: antenna select corrections
Date:   Tue, 29 Jan 2019 12:36:06 +0100
Message-Id: <20190129113213.083993716@linuxfoundation.org>
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

From: Stanislaw Gruszka <sgruszka@redhat.com>

commit ef442b73b6bc36b5499e1983611abb46e6337975 upstream.

Update mt76x0_phy_ant_select() to conform vendor driver, most notably
add dual antenna mode support, read configuration from EEPROM and
move ant select out of channel config to init phase. Plus small MT7630E
quirk for MT_CMB_CTRL register which vendor driver dedicated to this
chip do.

This make MT7630E workable with mt76x0e driver and do not cause any
problems on MT7610U for me.

Acked-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x0/phy.c     |   52 +++++++++++++++-----
 drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.h |   10 +--
 2 files changed, 44 insertions(+), 18 deletions(-)

--- a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
@@ -518,21 +518,47 @@ mt76x0_phy_set_chan_bbp_params(struct mt
 
 static void mt76x0_ant_select(struct mt76x02_dev *dev)
 {
-	struct ieee80211_channel *chan = dev->mt76.chandef.chan;
-
-	/* single antenna mode */
-	if (chan->band == NL80211_BAND_2GHZ) {
-		mt76_rmw(dev, MT_COEXCFG3,
-			 BIT(5) | BIT(4) | BIT(3) | BIT(2), BIT(1));
-		mt76_rmw(dev, MT_WLAN_FUN_CTRL, BIT(5), BIT(6));
+	u16 ee_ant = mt76x02_eeprom_get(dev, MT_EE_ANTENNA);
+	u16 nic_conf2 = mt76x02_eeprom_get(dev, MT_EE_NIC_CONF_2);
+	u32 wlan, coex3, cmb;
+	bool ant_div;
+
+	wlan = mt76_rr(dev, MT_WLAN_FUN_CTRL);
+	cmb = mt76_rr(dev, MT_CMB_CTRL);
+	coex3 = mt76_rr(dev, MT_COEXCFG3);
+
+	cmb   &= ~(BIT(14) | BIT(12));
+	wlan  &= ~(BIT(6) | BIT(5));
+	coex3 &= ~GENMASK(5, 2);
+
+	if (ee_ant & MT_EE_ANTENNA_DUAL) {
+		/* dual antenna mode */
+		ant_div = !(nic_conf2 & MT_EE_NIC_CONF_2_ANT_OPT) &&
+			  (nic_conf2 & MT_EE_NIC_CONF_2_ANT_DIV);
+		if (ant_div)
+			cmb |= BIT(12);
+		else
+			coex3 |= BIT(4);
+		coex3 |= BIT(3);
+		if (dev->mt76.cap.has_2ghz)
+			wlan |= BIT(6);
 	} else {
-		mt76_rmw(dev, MT_COEXCFG3, BIT(5) | BIT(2),
-			 BIT(4) | BIT(3));
-		mt76_clear(dev, MT_WLAN_FUN_CTRL,
-			   BIT(6) | BIT(5));
+		/* sigle antenna mode */
+		if (dev->mt76.cap.has_5ghz) {
+			coex3 |= BIT(3) | BIT(4);
+		} else {
+			wlan |= BIT(6);
+			coex3 |= BIT(1);
+		}
 	}
-	mt76_clear(dev, MT_CMB_CTRL, BIT(14) | BIT(12));
+
+	if (is_mt7630(dev))
+		cmb |= BIT(14) | BIT(11);
+
+	mt76_wr(dev, MT_WLAN_FUN_CTRL, wlan);
+	mt76_wr(dev, MT_CMB_CTRL, cmb);
 	mt76_clear(dev, MT_COEXCFG0, BIT(2));
+	mt76_wr(dev, MT_COEXCFG3, coex3);
 }
 
 static void
@@ -700,7 +726,6 @@ int mt76x0_phy_set_channel(struct mt76x0
 	mt76x02_phy_set_bw(dev, chandef->width, ch_group_index);
 	mt76x02_phy_set_band(dev, chandef->chan->band,
 			     ch_group_index & 1);
-	mt76x0_ant_select(dev);
 
 	mt76_rmw(dev, MT_EXT_CCA_CFG,
 		 (MT_EXT_CCA_CFG_CCA0 |
@@ -927,6 +952,7 @@ void mt76x0_phy_init(struct mt76x02_dev
 {
 	INIT_DELAYED_WORK(&dev->cal_work, mt76x0_phy_calibration_work);
 
+	mt76x0_ant_select(dev);
 	mt76x0_rf_init(dev);
 	mt76x02_phy_set_rxpath(dev);
 	mt76x02_phy_set_txdac(dev);
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.h
@@ -25,6 +25,7 @@ enum mt76x02_eeprom_field {
 	MT_EE_VERSION =				0x002,
 	MT_EE_MAC_ADDR =			0x004,
 	MT_EE_PCI_ID =				0x00A,
+	MT_EE_ANTENNA =				0x022,
 	MT_EE_NIC_CONF_0 =			0x034,
 	MT_EE_NIC_CONF_1 =			0x036,
 	MT_EE_COUNTRY_REGION_5GHZ =		0x038,
@@ -104,6 +105,8 @@ enum mt76x02_eeprom_field {
 	__MT_EE_MAX
 };
 
+#define MT_EE_ANTENNA_DUAL			BIT(15)
+
 #define MT_EE_NIC_CONF_0_RX_PATH		GENMASK(3, 0)
 #define MT_EE_NIC_CONF_0_TX_PATH		GENMASK(7, 4)
 #define MT_EE_NIC_CONF_0_PA_TYPE		GENMASK(9, 8)
@@ -118,12 +121,9 @@ enum mt76x02_eeprom_field {
 #define MT_EE_NIC_CONF_1_LNA_EXT_5G		BIT(3)
 #define MT_EE_NIC_CONF_1_TX_ALC_EN		BIT(13)
 
-#define MT_EE_NIC_CONF_2_RX_STREAM		GENMASK(3, 0)
-#define MT_EE_NIC_CONF_2_TX_STREAM		GENMASK(7, 4)
-#define MT_EE_NIC_CONF_2_HW_ANTDIV		BIT(8)
+#define MT_EE_NIC_CONF_2_ANT_OPT		BIT(3)
+#define MT_EE_NIC_CONF_2_ANT_DIV		BIT(4)
 #define MT_EE_NIC_CONF_2_XTAL_OPTION		GENMASK(10, 9)
-#define MT_EE_NIC_CONF_2_TEMP_DISABLE		BIT(11)
-#define MT_EE_NIC_CONF_2_COEX_METHOD		GENMASK(15, 13)
 
 #define MT_EFUSE_USAGE_MAP_SIZE			(MT_EE_USAGE_MAP_END - \
 						 MT_EE_USAGE_MAP_START + 1)


