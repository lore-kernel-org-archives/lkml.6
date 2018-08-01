Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749D3C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3999C2083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3999C2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732962AbeHAUN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:13:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46140 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404236AbeHATDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:37 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0E5CB1033;
        Wed,  1 Aug 2018 17:00:26 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Luca Bisti <luca.bisti@gmail.com>,
        Gaetano Catalli <gaetano.catalli@gmail.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Felix Fietkau <nbd@nbd.name>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 142/336] mt76x2: apply coverage class on slot time too
Date:   Wed,  1 Aug 2018 18:47:57 +0200
Message-Id: <20180801165034.579899660@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>

[ Upstream commit 0d45d3fe42efc76b6c4f5a62f8d110c7a2e6f83f ]

According to 802.11-2007 17.3.8.6 (slot time), the slot time should
be increased by 3 us * coverage class. Taking into account coverage
class in slot time configuration allows to increase by an order of
magnitude the throughput on a 4Km link in a noisy environment

Tested-by: Luca Bisti <luca.bisti@gmail.com>
Tested-by: Gaetano Catalli <gaetano.catalli@gmail.com>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Acked-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x2_init.c |    3 +++
 drivers/net/wireless/mediatek/mt76/mt76x2_main.c |    3 +--
 2 files changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/mediatek/mt76/mt76x2_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2_init.c
@@ -482,7 +482,10 @@ void mt76x2_set_tx_ackto(struct mt76x2_d
 {
 	u8 ackto, sifs, slottime = dev->slottime;
 
+	/* As defined by IEEE 802.11-2007 17.3.8.6 */
 	slottime += 3 * dev->coverage_class;
+	mt76_rmw_field(dev, MT_BKOFF_SLOT_CFG,
+		       MT_BKOFF_SLOT_CFG_SLOTTIME, slottime);
 
 	sifs = mt76_get_field(dev, MT_XIFS_TIME_CFG,
 			      MT_XIFS_TIME_CFG_OFDM_SIFS);
--- a/drivers/net/wireless/mediatek/mt76/mt76x2_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2_main.c
@@ -247,8 +247,7 @@ mt76x2_bss_info_changed(struct ieee80211
 		int slottime = info->use_short_slot ? 9 : 20;
 
 		dev->slottime = slottime;
-		mt76_rmw_field(dev, MT_BKOFF_SLOT_CFG,
-			       MT_BKOFF_SLOT_CFG_SLOTTIME, slottime);
+		mt76x2_set_tx_ackto(dev);
 	}
 
 	mutex_unlock(&dev->mutex);


