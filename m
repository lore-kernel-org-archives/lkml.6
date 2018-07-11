Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0826C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E91A20854
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E91A20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732362AbeGKHpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:45:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44077 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbeGKHpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:45:54 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fd9m1-0003YO-Ml; Wed, 11 Jul 2018 07:42:53 +0000
From:   Colin King <colin.king@canonical.com>
To:     Stanislaw Gruszka <sgruszka@redhat.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iwlegacy: remove several redundant variables
Date:   Wed, 11 Jul 2018 08:42:53 +0100
Message-Id: <20180711074253.4192-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variables id, unicast, write, conf, a_band, accum_tx and ucode are
assigned a value but it is never read, hence they are redundant and
can be removed.

Cleans up clang warnings:
warning: variable 'id' set but not used [-Wunused-but-set-variable]
warning: variable 'unicast' set but not used [-Wunused-but-set-variable]
warning: variable 'write' set but not used [-Wunused-but-set-variable]
warning: variable 'conf' set but not used [-Wunused-but-set-variable]
warning: variable 'a_band' set but not used [-Wunused-but-set-variable]
warning: variable 'tx' set but not used [-Wunused-but-set-variable]
warning: variable 'accum_tx' set but not used [-Wunused-but-set-variable]
warning: variable 'ucode' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/wireless/intel/iwlegacy/3945-mac.c | 10 ----------
 drivers/net/wireless/intel/iwlegacy/3945.c     |  2 --
 drivers/net/wireless/intel/iwlegacy/4965-mac.c |  6 ------
 3 files changed, 18 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/3945-mac.c b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
index 62a9794f952b..57e3b6cca234 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
@@ -476,8 +476,6 @@ il3945_tx_skb(struct il_priv *il,
 	int txq_id = skb_get_queue_mapping(skb);
 	u16 len, idx, hdr_len;
 	u16 firstlen, secondlen;
-	u8 id;
-	u8 unicast;
 	u8 sta_id;
 	u8 tid = 0;
 	__le16 fc;
@@ -496,9 +494,6 @@ il3945_tx_skb(struct il_priv *il,
 		goto drop_unlock;
 	}
 
-	unicast = !is_multicast_ether_addr(hdr->addr1);
-	id = 0;
-
 	fc = hdr->frame_control;
 
 #ifdef CONFIG_IWLEGACY_DEBUG
@@ -957,10 +952,8 @@ il3945_rx_queue_restock(struct il_priv *il)
 	struct list_head *element;
 	struct il_rx_buf *rxb;
 	unsigned long flags;
-	int write;
 
 	spin_lock_irqsave(&rxq->lock, flags);
-	write = rxq->write & ~0x7;
 	while (il_rx_queue_space(rxq) > 0 && rxq->free_count) {
 		/* Get next free Rx buffer, remove from free list */
 		element = rxq->rx_free.next;
@@ -2725,7 +2718,6 @@ void
 il3945_post_associate(struct il_priv *il)
 {
 	int rc = 0;
-	struct ieee80211_conf *conf = NULL;
 
 	if (!il->vif || !il->is_open)
 		return;
@@ -2738,8 +2730,6 @@ il3945_post_associate(struct il_priv *il)
 
 	il_scan_cancel_timeout(il, 200);
 
-	conf = &il->hw->conf;
-
 	il->staging.filter_flags &= ~RXON_FILTER_ASSOC_MSK;
 	il3945_commit_rxon(il);
 
diff --git a/drivers/net/wireless/intel/iwlegacy/3945.c b/drivers/net/wireless/intel/iwlegacy/3945.c
index dbf164d48ed3..3e568ce2fb20 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945.c
@@ -1634,7 +1634,6 @@ il3945_hw_reg_set_txpower(struct il_priv *il, s8 power)
 {
 	struct il_channel_info *ch_info;
 	s8 max_power;
-	u8 a_band;
 	u8 i;
 
 	if (il->tx_power_user_lmt == power) {
@@ -1650,7 +1649,6 @@ il3945_hw_reg_set_txpower(struct il_priv *il, s8 power)
 
 	for (i = 0; i < il->channel_count; i++) {
 		ch_info = &il->channel_info[i];
-		a_band = il_is_channel_a_band(ch_info);
 
 		/* find minimum power of all user and regulatory constraints
 		 *    (does not consider h/w clipping limitations) */
diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
index 562e94870a9c..280cd8ae1696 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
@@ -1338,15 +1338,12 @@ il4965_accumulative_stats(struct il_priv *il, __le32 * stats)
 	u32 *accum_stats;
 	u32 *delta, *max_delta;
 	struct stats_general_common *general, *accum_general;
-	struct stats_tx *tx, *accum_tx;
 
 	prev_stats = (__le32 *) &il->_4965.stats;
 	accum_stats = (u32 *) &il->_4965.accum_stats;
 	size = sizeof(struct il_notif_stats);
 	general = &il->_4965.stats.general.common;
 	accum_general = &il->_4965.accum_stats.general.common;
-	tx = &il->_4965.stats.tx;
-	accum_tx = &il->_4965.accum_stats.tx;
 	delta = (u32 *) &il->_4965.delta_stats;
 	max_delta = (u32 *) &il->_4965.max_delta;
 
@@ -4784,7 +4781,6 @@ static void
 il4965_ucode_callback(const struct firmware *ucode_raw, void *context)
 {
 	struct il_priv *il = context;
-	struct il_ucode_header *ucode;
 	int err;
 	struct il4965_firmware_pieces pieces;
 	const unsigned int api_max = il->cfg->ucode_api_max;
@@ -4814,8 +4810,6 @@ il4965_ucode_callback(const struct firmware *ucode_raw, void *context)
 	}
 
 	/* Data from ucode file:  header followed by uCode images */
-	ucode = (struct il_ucode_header *)ucode_raw->data;
-
 	err = il4965_load_firmware(il, ucode_raw, &pieces);
 
 	if (err)
-- 
2.17.1

