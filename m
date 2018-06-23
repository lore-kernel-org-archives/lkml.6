Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C093DC43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 17:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6284524CAC
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 17:28:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6284524CAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751759AbeFWR2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 13:28:03 -0400
Received: from smtprelay0174.hostedemail.com ([216.40.44.174]:50132 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751706AbeFWR2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 13:28:02 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 68809180A887B;
        Sat, 23 Jun 2018 17:28:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: test66_80162a1557e0e
X-Filterd-Recvd-Size: 2400
Received: from joe-laptop.perches.com (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Sat, 23 Jun 2018 17:28:00 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: Convert random_ether_addr to eth_random_addr
Date:   Sat, 23 Jun 2018 10:27:58 -0700
Message-Id: <d5ed83275b7e9ed8bacbcc8a45fcb5ac419c272f.1529774856.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

random_ether_addr is a #define for eth_random_addr which is
generally preferred in kernel code by ~3:1

Convert the uses of random_ether_addr to enable removing the #define

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/staging/mt7621-eth/mtk_eth_soc.c               | 2 +-
 drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/mt7621-eth/mtk_eth_soc.c b/drivers/staging/mt7621-eth/mtk_eth_soc.c
index 2c7a2e666bfb..e1696b06870e 100644
--- a/drivers/staging/mt7621-eth/mtk_eth_soc.c
+++ b/drivers/staging/mt7621-eth/mtk_eth_soc.c
@@ -1822,7 +1822,7 @@ static int __init mtk_init(struct net_device *dev)
 
 	/* If the mac address is invalid, use random mac address  */
 	if (!is_valid_ether_addr(dev->dev_addr)) {
-		random_ether_addr(dev->dev_addr);
+		eth_random_addr(dev->dev_addr);
 		dev_err(eth->dev, "generated random MAC address %pM\n",
 			dev->dev_addr);
 		dev->addr_assign_type = NET_ADDR_RANDOM;
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index 21874e78d8a1..9d9a9e102bb8 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -2382,7 +2382,7 @@ static void ieee80211_start_ibss_wq(struct work_struct *work)
 	if (ieee->state == IEEE80211_NOLINK) {
 		printk("creating new IBSS cell\n");
 		if(!ieee->wap_set)
-			random_ether_addr(ieee->current_network.bssid);
+			eth_random_addr(ieee->current_network.bssid);
 
 		if(ieee->modulation & IEEE80211_CCK_MODULATION){
 
-- 
2.15.0

