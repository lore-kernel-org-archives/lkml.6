Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EA0C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A1020882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548763544;
	bh=6VFtdQw4qwy7yAXXoBOnkyupi9BgYoNKbVskiX40HfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IFAprRi28r73DapUATBhiVRYA5XcWkXTB3TkIx8E84r6ICxtxnkY8cymogDdwMJOO
	 qAXxHR8IU3Edd5uQoPKehpycTnjlh3arT3Ze85Efn6OIZ/tWiQvMSbL7K0LjytOMSM
	 1oUocqz0qeX1I9rJoJtZiWX04Aycuj2pEiAcu2No=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbfA2MFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:05:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:59268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729189AbfA2Llt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:41:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73E66214DA;
        Tue, 29 Jan 2019 11:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762108;
        bh=6VFtdQw4qwy7yAXXoBOnkyupi9BgYoNKbVskiX40HfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1B3qyKNaEDCddvFVag+e9kH8uuq6bXFrcFjIY/duF5tQT/TfxkLqyDFh6jkIc3Du5
         N/3RN8ay0ZjePLRLmdauxmDCvmMCPORMKcXlwfg1NrkZQMMrQyDlp9MkMsF4csI5XU
         5OW/IUHfk5D+7uUz6YiuVsJhkN3Up7MWu1MzbOHQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stanislaw Gruszka <sgruszka@redhat.com>,
        Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 4.20 112/117] mt76x02: run calibration after scanning
Date:   Tue, 29 Jan 2019 12:36:03 +0100
Message-Id: <20190129113212.949210337@linuxfoundation.org>
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

commit f1b8ee35fec4a070b7760a99709fc98f237c2b86 upstream.

If we are associated and scanning is performed, sw_scan_complete callback
is done after we get back to operating channel, so we do not perform
queue cal work. Fix this queue cal work from sw_scan_complete().

On mt76x0 we have to restore gain in MT_BBP(AGC, 8) register after
scanning, as it was multiple times modified by channel switch code.
So queue cal work without any delay to set AGC gain value.

Similar like in mt76x2 init AGC gain only when set operating channel
and just check before queuing cal work in sw_scan_complete() if
initialization was already done.

Fixes: bbd10586f0df ("mt76x0: phy: do not run calibration during channel switch")
Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 drivers/net/wireless/mediatek/mt76/mt76x0/main.c     |    3 +++
 drivers/net/wireless/mediatek/mt76/mt76x0/phy.c      |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02.h         |    1 +
 drivers/net/wireless/mediatek/mt76/mt76x02_phy.c     |    1 +
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c |    3 +++
 5 files changed, 9 insertions(+), 1 deletion(-)

--- a/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
@@ -138,6 +138,9 @@ void mt76x0_sw_scan_complete(struct ieee
 	struct mt76x02_dev *dev = hw->priv;
 
 	clear_bit(MT76_SCANNING, &dev->mt76.state);
+
+	if (dev->cal.gain_init_done)
+		ieee80211_queue_delayed_work(hw, &dev->cal_work, 0);
 }
 EXPORT_SYMBOL_GPL(mt76x0_sw_scan_complete);
 
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
@@ -720,7 +720,6 @@ int mt76x0_phy_set_channel(struct mt76x0
 
 	mt76x0_read_rx_gain(dev);
 	mt76x0_phy_set_chan_bbp_params(dev, rf_bw_band);
-	mt76x02_init_agc_gain(dev);
 
 	if (mt76_is_usb(dev)) {
 		mt76x0_vco_cal(dev, channel);
@@ -732,6 +731,7 @@ int mt76x0_phy_set_channel(struct mt76x0
 	if (scan)
 		return 0;
 
+	mt76x02_init_agc_gain(dev);
 	if (mt76_is_mmio(dev))
 		mt76x0_phy_calibrate(dev, false);
 	mt76x0_phy_set_txpower(dev);
--- a/drivers/net/wireless/mediatek/mt76/mt76x02.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02.h
@@ -63,6 +63,7 @@ struct mt76x02_calibration {
 	bool tssi_comp_pending;
 	bool dpd_cal_done;
 	bool channel_cal_done;
+	bool gain_init_done;
 };
 
 struct mt76x02_dev {
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_phy.c
@@ -254,5 +254,6 @@ void mt76x02_init_agc_gain(struct mt76x0
 	memcpy(dev->cal.agc_gain_cur, dev->cal.agc_gain_init,
 	       sizeof(dev->cal.agc_gain_cur));
 	dev->cal.low_gain = -1;
+	dev->cal.gain_init_done = true;
 }
 EXPORT_SYMBOL_GPL(mt76x02_init_agc_gain);
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
@@ -156,6 +156,9 @@ mt76x2u_sw_scan_complete(struct ieee8021
 	struct mt76x02_dev *dev = hw->priv;
 
 	clear_bit(MT76_SCANNING, &dev->mt76.state);
+
+	if (dev->cal.gain_init_done)
+		ieee80211_queue_delayed_work(hw, &dev->cal_work, 0);
 }
 
 const struct ieee80211_ops mt76x2u_ops = {


