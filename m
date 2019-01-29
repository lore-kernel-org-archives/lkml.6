Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6717C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86EF1214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762110;
	bh=AB+82sKHxr+wB4ZeV28mPgyNkYGRXXU/yiCVQNKEi3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HNo+m0TYFEYvJyYffcw/Hm6pkW5Y8p8K6QwcZ0CxCiPGGpgdKWCxlAoLJgKLDY2wS
	 bWZ43Lhb07BqpqRFjFhoQSs2qRJSQHyW3Cf8BEDTdf4olF35XPhCQr4bNbhwZAOcXr
	 /0GWfViPlggP0AichBju+AhSp2uOpEmYEaKhzlmw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbfA2Llt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:41:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:59166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729348AbfA2Llp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:41:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13111214DA;
        Tue, 29 Jan 2019 11:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762104;
        bh=AB+82sKHxr+wB4ZeV28mPgyNkYGRXXU/yiCVQNKEi3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AgoXPSxLKskLJYS//VfLwJJmcwirwa/5F/hAvRm9iTIjSNw+SSKPXDJ0vqp5iRbyB
         USK3exl3vxNqzXdXS05wNJA34rmDiF8vHGdulinSXqWSGJvks8hJJBnKFrCD2KFcj6
         VZN0JB2ReXGkXYgiOHKybZsf9XqimbiDSXyWHLH8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stanislaw Gruszka <sgruszka@redhat.com>,
        Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 4.20 111/117] mt76x0: use band parameter for LC calibration
Date:   Tue, 29 Jan 2019 12:36:02 +0100
Message-Id: <20190129113212.906465773@linuxfoundation.org>
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

commit ad3f993a0857ad3b792e7463828eb0d90cdd6f4d upstream.

We use always 1 as band parameter for MCU_CAL_LC, this break 2GHz,
we should use 0 for this band instead.

Patch fixes problems happened sometimes when try to associate with 2GHz
AP and manifest by errors like below:

[14680.920823] wlan0: authenticate with 18:31:bf:c0:51:b0
[14681.109506] wlan0: send auth to 18:31:bf:c0:51:b0 (try 1/3)
[14681.310454] wlan0: send auth to 18:31:bf:c0:51:b0 (try 2/3)
[14681.518469] wlan0: send auth to 18:31:bf:c0:51:b0 (try 3/3)
[14681.726499] wlan0: authentication with 18:31:bf:c0:51:b0 timed out

Fixes: 9aec146d0f6b ("mt76x0: pci: introduce mt76x0_phy_calirate routine")
Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/mediatek/mt76/mt76x0/phy.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
@@ -585,6 +585,7 @@ void mt76x0_phy_set_txpower(struct mt76x
 void mt76x0_phy_calibrate(struct mt76x02_dev *dev, bool power_on)
 {
 	struct ieee80211_channel *chan = dev->mt76.chandef.chan;
+	int is_5ghz = (chan->band == NL80211_BAND_5GHZ) ? 1 : 0;
 	u32 val, tx_alc, reg_val;
 
 	if (power_on) {
@@ -602,7 +603,7 @@ void mt76x0_phy_calibrate(struct mt76x02
 	reg_val = mt76_rr(dev, MT_BBP(IBI, 9));
 	mt76_wr(dev, MT_BBP(IBI, 9), 0xffffff7e);
 
-	if (chan->band == NL80211_BAND_5GHZ) {
+	if (is_5ghz) {
 		if (chan->hw_value < 100)
 			val = 0x701;
 		else if (chan->hw_value < 140)
@@ -615,7 +616,7 @@ void mt76x0_phy_calibrate(struct mt76x02
 
 	mt76x02_mcu_calibrate(dev, MCU_CAL_FULL, val, false);
 	msleep(350);
-	mt76x02_mcu_calibrate(dev, MCU_CAL_LC, 1, false);
+	mt76x02_mcu_calibrate(dev, MCU_CAL_LC, is_5ghz, false);
 	usleep_range(15000, 20000);
 
 	mt76_wr(dev, MT_BBP(IBI, 9), reg_val);


