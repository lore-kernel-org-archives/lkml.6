Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0B3C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 21:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D712150F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 21:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73D712150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbeHXA7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 20:59:18 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:45984 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbeHXA7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 20:59:18 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id SlTf1y00N3XaVaC01lTf2a; Thu, 23 Aug 2018 23:27:42 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fsx8l-0005ig-Im; Thu, 23 Aug 2018 23:27:39 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fsx8l-0004o2-Gx; Thu, 23 Aug 2018 23:27:39 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] mt76: Fix comparisons with invalid hardware key index
Date:   Thu, 23 Aug 2018 23:27:38 +0200
Message-Id: <20180823212738.18431-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With gcc 4.1.2:

    drivers/net/wireless/mediatek/mt76/mt76x0/tx.c: In function ‘mt76x0_tx’:
    drivers/net/wireless/mediatek/mt76/mt76x0/tx.c:169: warning: comparison is always true due to limited range of data type
    drivers/net/wireless/mediatek/mt76/mt76x2_tx_common.c: In function ‘mt76x2_tx’:
    drivers/net/wireless/mediatek/mt76/mt76x2_tx_common.c:35: warning: comparison is always true due to limited range of data type

While assigning -1 to a u8 works fine, comparing with -1 does not work
as expected.

Fix this by comparing with 0xff, like is already done in some other
places.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Compile-tested only.
---
 drivers/net/wireless/mediatek/mt76/mt76x0/tx.c        | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2_tx_common.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/tx.c b/drivers/net/wireless/mediatek/mt76/mt76x0/tx.c
index 751b49c28ae53f0f..c45d05d5aab1d207 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/tx.c
@@ -166,7 +166,7 @@ void mt76x0_tx(struct ieee80211_hw *hw, struct ieee80211_tx_control *control,
 	if (sta) {
 		msta = (struct mt76_sta *) sta->drv_priv;
 		wcid = &msta->wcid;
-	} else if (vif && (!info->control.hw_key && wcid->hw_key_idx != -1)) {
+	} else if (vif && (!info->control.hw_key && wcid->hw_key_idx != 0xff)) {
 		struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
 
 		wcid = &mvif->group_wcid;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2_tx_common.c b/drivers/net/wireless/mediatek/mt76/mt76x2_tx_common.c
index 36afb166fa3ffd29..c0ca0df84ed8b86a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2_tx_common.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2_tx_common.c
@@ -32,7 +32,7 @@ void mt76x2_tx(struct ieee80211_hw *hw, struct ieee80211_tx_control *control,
 		msta = (struct mt76x2_sta *)control->sta->drv_priv;
 		wcid = &msta->wcid;
 		/* sw encrypted frames */
-		if (!info->control.hw_key && wcid->hw_key_idx != -1)
+		if (!info->control.hw_key && wcid->hw_key_idx != 0xff)
 			control->sta = NULL;
 	}
 
-- 
2.17.1

