Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACC4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C94D2063F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217391;
	bh=FHgGZqgMBQwwjiicoxNDVwbfGO4AZ2Oyn7AYRzKxLc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c7WI9QQ/BPSP980Fc+aNHOSMo41HTtxavtA0lbS9hWB6qjVtlawIM70B0uDeg77Sh
	 0dMLRcmIscnyKfZnACmM28IzMnE03GMd/hePY0ev8GBkQYAx7S6EI6/Li/u75LCYr3
	 z2hcwaEIkrXHp0kYdVjYDeSgXMAiMg6hriHCkGkQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389936AbfAKOga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:36:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:56760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390374AbfAKOgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:36:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 901B0204EC;
        Fri, 11 Jan 2019 14:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217384;
        bh=FHgGZqgMBQwwjiicoxNDVwbfGO4AZ2Oyn7AYRzKxLc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g312545ZKH3ioqfzmRZGATBRgGsTFHPHHOMeYivlLkaWHtqVy6ug3NoJLdhXLXDr4
         pI0NPprwraOMmlPrFEBvE9HQhTSXGaiqbdZXKuyNRmxxZvpLZ/2iIoxbn7tNRHsrsN
         aJLEvr6c1Hg7Y+fTXsRwRjUajXOJoroDvO9Wvn80=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 041/148] mt76: fix potential NULL pointer dereference in mt76_stop_tx_queues
Date:   Fri, 11 Jan 2019 15:13:39 +0100
Message-Id: <20190111131115.930854517@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 7c250f4612ae97aa04500c0d0cff69bb87046e3a ]

Starting from mac80211 commit adf8ed01e4fd ("mac80211: add an optional
TXQ for other PS-buffered frames") and commit 0eeb2b674f05 ("mac80211:
add an option for station management TXQ") a new per-sta queue has been
introduced for bufferable management frames.
sta->txq[IEEE80211_NUM_TIDS] is initialized just if the driver reports
the following hw flags:
- IEEE80211_HW_STA_MMPDU_TXQ
- IEEE80211_HW_BUFF_MMPDU_TXQ
This can produce a NULL pointer dereference in mt76_stop_tx_queues
since mt76 iterates on all available sta tx queues assuming they are
initialized by mac80211. This issue has been spotted analyzing the code
(it has not triggered any crash yet)

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/tx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index af48d43bb7dc..20447fdce4c3 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -385,7 +385,12 @@ void mt76_stop_tx_queues(struct mt76_dev *dev, struct ieee80211_sta *sta,
 
 	for (i = 0; i < ARRAY_SIZE(sta->txq); i++) {
 		struct ieee80211_txq *txq = sta->txq[i];
-		struct mt76_txq *mtxq = (struct mt76_txq *) txq->drv_priv;
+		struct mt76_txq *mtxq;
+
+		if (!txq)
+			continue;
+
+		mtxq = (struct mt76_txq *)txq->drv_priv;
 
 		spin_lock_bh(&mtxq->hwq->lock);
 		mtxq->send_bar = mtxq->aggr && send_bar;
-- 
2.19.1



