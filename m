Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8582FC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0000A208C2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbZH78ey"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0000A208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934513AbeGDMAS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:00:18 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44735 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934416AbeGDMAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:00:12 -0400
Received: by mail-wr0-f196.google.com with SMTP id r16-v6so1936491wrt.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 05:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EF1qT6Epm5SOdZE7+T7ddFOcSYb4tkHiruxuksSmvOg=;
        b=UbZH78eyRt3EhRSaW2Fkxc8r20xpKMKB6VNGb+E/omL7Pcz7mE6NVYuae/Jexk5tol
         cgZ3gccdRTv4OfU5a1ALiZgx4xJ9eOMjpQLD0ttpL7NhMXTxQY2VUa/nW9wEn5yVzwCQ
         svs6ifoTTPwaZjc2Sw1jmZQ4XRONshm7PGdMKWaaB3A+bDnNGJwQ8dsB4Kp/lNAlBhP9
         +HcFoY3FJ5akm5LOiwU4F5fFMYqiBMalE5fhPsgw9+cwhO29QdabgneerWXgdn66hQho
         3L0UOhkP3HqGvgBVcxMLKpDfHNSLaVBGetzxzyV7z5tinijqvJq+Z8sh/tsLnU6BZmCJ
         UY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EF1qT6Epm5SOdZE7+T7ddFOcSYb4tkHiruxuksSmvOg=;
        b=lLfl8XoMIJbPNWmhEEHmsrMA2yzqCp4KN8WBmYHnBEtmedlfHZq5PTFGu+g4iQ81MG
         dzV0S9JmKYTzhJKgnMh9atdQRyljOBwwFKVfxvTwc92nEq5cMxffsjX3SaYJ9TsztRKa
         NKJVW5ctFwQOhTwrMqrlT1SZwtBb73P5mzNKIDUfLjJF+/rwevbbqf5BMsyG1td6spR4
         YnK3Aaa19XbpITLG4rzi0Whtnzz1zE9gH3K8rd6w5pKC6x+rVLWHwUp2EBSJI12nIbkB
         cQi8eHMgsQleHO4Q5geZWpKYMJDki1TxCIphq8beLYvwBq+ZREnlAAqqYqsoSeMcFRTa
         qnqg==
X-Gm-Message-State: APt69E2S6hOM1veT9cKtiPvpQ+mJJD/M6/FF1JCAgKUMLlTuMKXB9+Pc
        cBZErYKalSoathwzqEZ5aKgbJIAZ
X-Google-Smtp-Source: AAOMgpdzwvGqi/bmASknMTKe8DmbV6yM+MEg0sPsJtrg3x5HAdBKKiS9GWv6Bfwnu0Yq49a2inwCDg==
X-Received: by 2002:a5d:4452:: with SMTP id x18-v6mr1477105wrr.227.1530705609281;
        Wed, 04 Jul 2018 05:00:09 -0700 (PDT)
Received: from localhost.localdomain (host81-152-164-58.range81-152.btcentralplus.com. [81.152.164.58])
        by smtp.gmail.com with ESMTPSA id 125-v6sm6893985wmw.9.2018.07.04.05.00.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 05:00:08 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, insafonov@gmail.com,
        baijiaju1990@gmail.com, keescook@chromium.org, joe@perches.com,
        colin.king@canonical.com, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 5/5] staging: rtl8192u: Refactor for coding style
Date:   Wed,  4 Jul 2018 12:59:25 +0100
Message-Id: <20180704115925.28024-5-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180704115925.28024-1-johnfwhitmore@gmail.com>
References: <20180704115925.28024-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes to indentation and witespace issues in the ieee80211_softmac.c file.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../rtl8192u/ieee80211/ieee80211_softmac.c    | 1015 +++++++----------
 1 file changed, 443 insertions(+), 572 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index 9d9a9e102bb8..b8e9322b72a1 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -13,7 +13,6 @@
  * released under the GPL
  */
 
-
 #include "ieee80211.h"
 
 #include <linux/random.h>
@@ -79,8 +78,7 @@ static void ieee80211_MFIE_Grate(struct ieee80211_device *ieee, u8 **tag_p)
 {
 	u8 *tag = *tag_p;
 
-		if (ieee->modulation & IEEE80211_OFDM_MODULATION) {
-
+	if (ieee->modulation & IEEE80211_OFDM_MODULATION) {
 		*tag++ = MFIE_TYPE_RATES_EX;
 		*tag++ = 8;
 		*tag++ = IEEE80211_BASIC_RATE_MASK | IEEE80211_OFDM_RATE_6MB;
@@ -91,14 +89,12 @@ static void ieee80211_MFIE_Grate(struct ieee80211_device *ieee, u8 **tag_p)
 		*tag++ = IEEE80211_BASIC_RATE_MASK | IEEE80211_OFDM_RATE_36MB;
 		*tag++ = IEEE80211_BASIC_RATE_MASK | IEEE80211_OFDM_RATE_48MB;
 		*tag++ = IEEE80211_BASIC_RATE_MASK | IEEE80211_OFDM_RATE_54MB;
-
 	}
 
 	/* We may add an option for custom rates that specific HW might support */
 	*tag_p = tag;
 }
 
-
 static void ieee80211_WMM_Info(struct ieee80211_device *ieee, u8 **tag_p)
 {
 	u8 *tag = *tag_p;
@@ -112,11 +108,10 @@ static void ieee80211_WMM_Info(struct ieee80211_device *ieee, u8 **tag_p)
 	*tag++ = 0x00;
 	*tag++ = 0x01;
 #ifdef SUPPORT_USPD
-	if(ieee->current_network.wmm_info & 0x80) {
-		*tag++ = 0x0f|MAX_SP_Len;
-	} else {
+	if (ieee->current_network.wmm_info & 0x80)
+		*tag++ = 0x0f | MAX_SP_Len;
+	else
 		*tag++ = MAX_SP_Len;
-	}
 #else
 	*tag++ = MAX_SP_Len;
 #endif
@@ -147,7 +142,7 @@ static void enqueue_mgmt(struct ieee80211_device *ieee, struct sk_buff *skb)
 {
 	int nh;
 
-	nh = (ieee->mgmt_queue_head +1) % MGMT_QUEUE_NUM;
+	nh = (ieee->mgmt_queue_head + 1) % MGMT_QUEUE_NUM;
 
 /*
  * if the queue is full but we have newer frames then
@@ -166,13 +161,13 @@ static struct sk_buff *dequeue_mgmt(struct ieee80211_device *ieee)
 {
 	struct sk_buff *ret;
 
-	if(ieee->mgmt_queue_tail == ieee->mgmt_queue_head)
+	if (ieee->mgmt_queue_tail == ieee->mgmt_queue_head)
 		return NULL;
 
 	ret = ieee->mgmt_queue_ring[ieee->mgmt_queue_tail];
 
 	ieee->mgmt_queue_tail =
-		(ieee->mgmt_queue_tail+1) % MGMT_QUEUE_NUM;
+		(ieee->mgmt_queue_tail + 1) % MGMT_QUEUE_NUM;
 
 	return ret;
 }
@@ -188,16 +183,16 @@ static u8 MgntQuery_MgntFrameTxRate(struct ieee80211_device *ieee)
 	u8 rate;
 
 	/* 2008/01/25 MH For broadcom, MGNT frame set as OFDM 6M. */
-	if(pHTInfo->IOTAction & HT_IOT_ACT_MGNT_USE_CCK_6M)
+	if (pHTInfo->IOTAction & HT_IOT_ACT_MGNT_USE_CCK_6M)
 		rate = 0x0c;
 	else
 		rate = ieee->basic_rate & 0x7f;
 
 	if (rate == 0) {
 		/* 2005.01.26, by rcnjko. */
-		if(ieee->mode == IEEE_A||
-		   ieee->mode== IEEE_N_5G||
-		   (ieee->mode== IEEE_N_24G&&!pHTInfo->bCurSuppCCK))
+		if (ieee->mode == IEEE_A ||
+		    ieee->mode == IEEE_N_5G ||
+		    (ieee->mode == IEEE_N_24G && !pHTInfo->bCurSuppCCK))
 			rate = 0x0c;
 		else
 			rate = 0x02;
@@ -216,15 +211,14 @@ static u8 MgntQuery_MgntFrameTxRate(struct ieee80211_device *ieee)
 	return rate;
 }
 
-
 void ieee80211_sta_wakeup(struct ieee80211_device *ieee, short nl);
 
 inline void softmac_mgmt_xmit(struct sk_buff *skb, struct ieee80211_device *ieee)
 {
 	unsigned long flags;
 	short single = ieee->softmac_features & IEEE_SOFTMAC_SINGLE_QUEUE;
-	struct rtl_80211_hdr_3addr  *header=
-		(struct rtl_80211_hdr_3addr  *) skb->data;
+	struct rtl_80211_hdr_3addr  *header =
+		(struct rtl_80211_hdr_3addr  *)skb->data;
 
 	struct cb_desc *tcb_desc = (struct cb_desc *)(skb->cb + 8);
 
@@ -239,11 +233,11 @@ inline void softmac_mgmt_xmit(struct sk_buff *skb, struct ieee80211_device *ieee
 	tcb_desc->bTxDisableRateFallBack = 1;
 	tcb_desc->bTxUseDriverAssingedRate = 1;
 
-	if(single){
-		if(ieee->queue_stop){
+	if (single) {
+		if (ieee->queue_stop) {
 			enqueue_mgmt(ieee, skb);
-		}else{
-			header->seq_ctl = cpu_to_le16(ieee->seq_ctrl[0]<<4);
+		} else {
+			header->seq_ctl = cpu_to_le16(ieee->seq_ctrl[0] << 4);
 
 			if (ieee->seq_ctrl[0] == 0xFFF)
 				ieee->seq_ctrl[0] = 0;
@@ -252,12 +246,12 @@ inline void softmac_mgmt_xmit(struct sk_buff *skb, struct ieee80211_device *ieee
 
 			/* avoid watchdog triggers */
 			netif_trans_update(ieee->dev);
-			ieee->softmac_data_hard_start_xmit(skb,ieee->dev,ieee->basic_rate);
+			ieee->softmac_data_hard_start_xmit(skb, ieee->dev, ieee->basic_rate);
 			//dev_kfree_skb_any(skb);//edit by thomas
 		}
 
 		spin_unlock_irqrestore(&ieee->lock, flags);
-	}else{
+	} else {
 		spin_unlock_irqrestore(&ieee->lock, flags);
 		spin_lock_irqsave(&ieee->mgmt_tx_lock, flags);
 
@@ -269,14 +263,14 @@ inline void softmac_mgmt_xmit(struct sk_buff *skb, struct ieee80211_device *ieee
 			ieee->seq_ctrl[0]++;
 
 		/* check whether the managed packet queued greater than 5 */
-		if(!ieee->check_nic_enough_desc(ieee->dev,tcb_desc->queue_index)||\
-				(skb_queue_len(&ieee->skb_waitQ[tcb_desc->queue_index]) != 0)||\
-				(ieee->queue_stop) ) {
+		if (!ieee->check_nic_enough_desc(ieee->dev, tcb_desc->queue_index) ||
+		    (skb_queue_len(&ieee->skb_waitQ[tcb_desc->queue_index]) != 0) ||
+		    (ieee->queue_stop)) {
 			/* insert the skb packet to the management queue */
 			/* as for the completion function, it does not need
 			 * to check it any more.
 			 * */
-			printk("%s():insert to waitqueue!\n",__func__);
+			printk("%s():insert to waitqueue!\n", __func__);
 			skb_queue_tail(&ieee->skb_waitQ[tcb_desc->queue_index], skb);
 		} else {
 			ieee->softmac_hard_start_xmit(skb, ieee->dev);
@@ -289,14 +283,11 @@ inline void softmac_mgmt_xmit(struct sk_buff *skb, struct ieee80211_device *ieee
 static inline void
 softmac_ps_mgmt_xmit(struct sk_buff *skb, struct ieee80211_device *ieee)
 {
-
 	short single = ieee->softmac_features & IEEE_SOFTMAC_SINGLE_QUEUE;
 	struct rtl_80211_hdr_3addr  *header =
-		(struct rtl_80211_hdr_3addr  *) skb->data;
-
-
-	if(single){
+		(struct rtl_80211_hdr_3addr  *)skb->data;
 
+	if (single) {
 		header->seq_ctl = cpu_to_le16(ieee->seq_ctrl[0] << 4);
 
 		if (ieee->seq_ctrl[0] == 0xFFF)
@@ -306,10 +297,8 @@ softmac_ps_mgmt_xmit(struct sk_buff *skb, struct ieee80211_device *ieee)
 
 		/* avoid watchdog triggers */
 		netif_trans_update(ieee->dev);
-		ieee->softmac_data_hard_start_xmit(skb,ieee->dev,ieee->basic_rate);
-
-	}else{
-
+		ieee->softmac_data_hard_start_xmit(skb, ieee->dev, ieee->basic_rate);
+	} else {
 		header->seq_ctl = cpu_to_le16(ieee->seq_ctrl[0] << 4);
 
 		if (ieee->seq_ctrl[0] == 0xFFF)
@@ -318,7 +307,6 @@ softmac_ps_mgmt_xmit(struct sk_buff *skb, struct ieee80211_device *ieee)
 			ieee->seq_ctrl[0]++;
 
 		ieee->softmac_hard_start_xmit(skb, ieee->dev);
-
 	}
 	//dev_kfree_skb_any(skb);//edit by thomas
 }
@@ -356,8 +344,8 @@ static inline struct sk_buff *ieee80211_probe_req(struct ieee80211_device *ieee)
 	memcpy(tag, ieee->current_network.ssid, len);
 	tag += len;
 
-	ieee80211_MFIE_Brate(ieee,&tag);
-	ieee80211_MFIE_Grate(ieee,&tag);
+	ieee80211_MFIE_Brate(ieee, &tag);
+	ieee80211_MFIE_Grate(ieee, &tag);
 	return skb;
 }
 
@@ -367,7 +355,7 @@ static void ieee80211_send_beacon(struct ieee80211_device *ieee)
 {
 	struct sk_buff *skb;
 
-	if(!ieee->ieee_up)
+	if (!ieee->ieee_up)
 		return;
 	//unsigned long flags;
 	skb = ieee80211_get_beacon_(ieee);
@@ -385,12 +373,11 @@ static void ieee80211_send_beacon(struct ieee80211_device *ieee)
 //		if(!timer_pending(&ieee->beacon_timer))
 //			add_timer(&ieee->beacon_timer);
 		mod_timer(&ieee->beacon_timer,
-			  jiffies + msecs_to_jiffies(ieee->current_network.beacon_interval-5));
+			  jiffies + msecs_to_jiffies(ieee->current_network.beacon_interval - 5));
 	}
 	//spin_unlock_irqrestore(&ieee->beacon_lock,flags);
 }
 
-
 static void ieee80211_send_beacon_cb(struct timer_list *t)
 {
 	struct ieee80211_device *ieee =
@@ -402,7 +389,6 @@ static void ieee80211_send_beacon_cb(struct timer_list *t)
 	spin_unlock_irqrestore(&ieee->beacon_lock, flags);
 }
 
-
 static void ieee80211_send_probe(struct ieee80211_device *ieee)
 {
 	struct sk_buff *skb;
@@ -429,19 +415,17 @@ static void ieee80211_send_probe_requests(struct ieee80211_device *ieee)
 void ieee80211_softmac_scan_syncro(struct ieee80211_device *ieee)
 {
 	short ch = 0;
-	u8 channel_map[MAX_CHANNEL_NUMBER+1];
+	u8 channel_map[MAX_CHANNEL_NUMBER + 1];
 
-	memcpy(channel_map, GET_DOT11D_INFO(ieee)->channel_map, MAX_CHANNEL_NUMBER+1);
+	memcpy(channel_map, GET_DOT11D_INFO(ieee)->channel_map, MAX_CHANNEL_NUMBER + 1);
 	mutex_lock(&ieee->scan_mutex);
 
-	while(1)
-	{
-
-		do{
+	while (1) {
+		do {
 			ch++;
 			if (ch > MAX_CHANNEL_NUMBER)
 				goto out; /* scan completed */
-		}while(!channel_map[ch]);
+		} while (!channel_map[ch]);
 
 		/* this function can be called in two situations
 		 * 1- We have switched to ad-hoc mode and we are
@@ -465,7 +449,7 @@ void ieee80211_softmac_scan_syncro(struct ieee80211_device *ieee)
 		if (ieee->state == IEEE80211_LINKED)
 			goto out;
 		ieee->set_chan(ieee->dev, ch);
-		if(channel_map[ch] == 1)
+		if (channel_map[ch] == 1)
 			ieee80211_send_probe_requests(ieee);
 
 		/* this prevent excessive time wait when we
@@ -475,19 +459,17 @@ void ieee80211_softmac_scan_syncro(struct ieee80211_device *ieee)
 			goto out;
 
 		msleep_interruptible(IEEE80211_SOFTMAC_SCAN_TIME);
-
 	}
 out:
-	if(ieee->state < IEEE80211_LINKED){
+	if (ieee->state < IEEE80211_LINKED) {
 		ieee->actscanning = false;
 		mutex_unlock(&ieee->scan_mutex);
+	} else {
+		ieee->sync_scan_hurryup = 0;
+		if (IS_DOT11D_ENABLE(ieee))
+			DOT11D_ScanComplete(ieee);
+		mutex_unlock(&ieee->scan_mutex);
 	}
-	else{
-	ieee->sync_scan_hurryup = 0;
-	if(IS_DOT11D_ENABLE(ieee))
-		DOT11D_ScanComplete(ieee);
-	mutex_unlock(&ieee->scan_mutex);
-}
 }
 EXPORT_SYMBOL(ieee80211_softmac_scan_syncro);
 
@@ -496,37 +478,35 @@ static void ieee80211_softmac_scan_wq(struct work_struct *work)
 	struct delayed_work *dwork = to_delayed_work(work);
 	struct ieee80211_device *ieee = container_of(dwork, struct ieee80211_device, softmac_scan_wq);
 	static short watchdog;
-	u8 channel_map[MAX_CHANNEL_NUMBER+1];
+	u8 channel_map[MAX_CHANNEL_NUMBER + 1];
 
-	memcpy(channel_map, GET_DOT11D_INFO(ieee)->channel_map, MAX_CHANNEL_NUMBER+1);
-	if(!ieee->ieee_up)
+	memcpy(channel_map, GET_DOT11D_INFO(ieee)->channel_map, MAX_CHANNEL_NUMBER + 1);
+	if (!ieee->ieee_up)
 		return;
 	mutex_lock(&ieee->scan_mutex);
-	do{
+	do {
 		ieee->current_network.channel =
 			(ieee->current_network.channel + 1) % MAX_CHANNEL_NUMBER;
-		if (watchdog++ > MAX_CHANNEL_NUMBER)
-		{
+		if (watchdog++ > MAX_CHANNEL_NUMBER) {
 		//if current channel is not in channel map, set to default channel.
 			if (!channel_map[ieee->current_network.channel]) {
 				ieee->current_network.channel = 6;
 				goto out; /* no good chans */
 			}
 		}
-	}while(!channel_map[ieee->current_network.channel]);
-	if (ieee->scanning == 0 )
+	} while (!channel_map[ieee->current_network.channel]);
+	if (ieee->scanning == 0)
 		goto out;
 	ieee->set_chan(ieee->dev, ieee->current_network.channel);
-	if(channel_map[ieee->current_network.channel] == 1)
+	if (channel_map[ieee->current_network.channel] == 1)
 		ieee80211_send_probe_requests(ieee);
 
-
 	schedule_delayed_work(&ieee->softmac_scan_wq, IEEE80211_SOFTMAC_SCAN_TIME);
 
 	mutex_unlock(&ieee->scan_mutex);
 	return;
 out:
-	if(IS_DOT11D_ENABLE(ieee))
+	if (IS_DOT11D_ENABLE(ieee))
 		DOT11D_ScanComplete(ieee);
 	ieee->actscanning = false;
 	watchdog = 0;
@@ -534,12 +514,11 @@ static void ieee80211_softmac_scan_wq(struct work_struct *work)
 	mutex_unlock(&ieee->scan_mutex);
 }
 
-
-
 static void ieee80211_beacons_start(struct ieee80211_device *ieee)
 {
 	unsigned long flags;
-	spin_lock_irqsave(&ieee->beacon_lock,flags);
+
+	spin_lock_irqsave(&ieee->beacon_lock, flags);
 
 	ieee->beacon_txing = 1;
 	ieee80211_send_beacon(ieee);
@@ -557,13 +536,11 @@ static void ieee80211_beacons_stop(struct ieee80211_device *ieee)
 	del_timer_sync(&ieee->beacon_timer);
 
 	spin_unlock_irqrestore(&ieee->beacon_lock, flags);
-
 }
 
-
 void ieee80211_stop_send_beacons(struct ieee80211_device *ieee)
 {
-	if(ieee->stop_send_beacons)
+	if (ieee->stop_send_beacons)
 		ieee->stop_send_beacons(ieee->dev);
 	if (ieee->softmac_features & IEEE_SOFTMAC_BEACONS)
 		ieee80211_beacons_stop(ieee);
@@ -572,9 +549,9 @@ EXPORT_SYMBOL(ieee80211_stop_send_beacons);
 
 void ieee80211_start_send_beacons(struct ieee80211_device *ieee)
 {
-	if(ieee->start_send_beacons)
+	if (ieee->start_send_beacons)
 		ieee->start_send_beacons(ieee->dev, ieee->basic_rate);
-	if(ieee->softmac_features & IEEE_SOFTMAC_BEACONS)
+	if (ieee->softmac_features & IEEE_SOFTMAC_BEACONS)
 		ieee80211_beacons_start(ieee);
 }
 EXPORT_SYMBOL(ieee80211_start_send_beacons);
@@ -610,39 +587,32 @@ EXPORT_SYMBOL(ieee80211_stop_scan);
 /* called with ieee->lock held */
 static void ieee80211_start_scan(struct ieee80211_device *ieee)
 {
-	if (IS_DOT11D_ENABLE(ieee) )
-	{
+	if (IS_DOT11D_ENABLE(ieee)) {
 		if (IS_COUNTRY_IE_VALID(ieee))
-		{
 			RESET_CIE_WATCHDOG(ieee);
-		}
 	}
-	if (ieee->softmac_features & IEEE_SOFTMAC_SCAN){
+	if (ieee->softmac_features & IEEE_SOFTMAC_SCAN) {
 		if (ieee->scanning == 0) {
 			ieee->scanning = 1;
 			schedule_delayed_work(&ieee->softmac_scan_wq, 0);
 		}
-	}else
+	} else {
 		ieee->start_scan(ieee->dev);
-
+	}
 }
 
 /* called with wx_mutex held */
 void ieee80211_start_scan_syncro(struct ieee80211_device *ieee)
 {
-	if (IS_DOT11D_ENABLE(ieee) )
-	{
+	if (IS_DOT11D_ENABLE(ieee)) {
 		if (IS_COUNTRY_IE_VALID(ieee))
-		{
 			RESET_CIE_WATCHDOG(ieee);
-		}
 	}
 	ieee->sync_scan_hurryup = 0;
 	if (ieee->softmac_features & IEEE_SOFTMAC_SCAN)
 		ieee80211_softmac_scan_syncro(ieee);
 	else
 		ieee->scan_syncro(ieee->dev);
-
 }
 EXPORT_SYMBOL(ieee80211_start_scan_syncro);
 
@@ -654,9 +624,9 @@ ieee80211_authentication_req(struct ieee80211_network *beacon,
 	struct ieee80211_authentication *auth;
 	int len = sizeof(struct ieee80211_authentication) + challengelen + ieee->tx_headroom;
 
-
 	skb = dev_alloc_skb(len);
-	if (!skb) return NULL;
+	if (!skb)
+		return NULL;
 
 	skb_reserve(skb, ieee->tx_headroom);
 	auth = skb_put(skb, sizeof(struct ieee80211_authentication));
@@ -674,23 +644,23 @@ ieee80211_authentication_req(struct ieee80211_network *beacon,
 	memcpy(auth->header.addr3, beacon->bssid, ETH_ALEN);
 
 	//auth->algorithm = ieee->open_wep ? WLAN_AUTH_OPEN : WLAN_AUTH_SHARED_KEY;
-	if(ieee->auth_mode == 0)
+	if (ieee->auth_mode == 0)
 		auth->algorithm = WLAN_AUTH_OPEN;
-	else if(ieee->auth_mode == 1)
+	else if (ieee->auth_mode == 1)
 		auth->algorithm = cpu_to_le16(WLAN_AUTH_SHARED_KEY);
-	else if(ieee->auth_mode == 2)
+	else if (ieee->auth_mode == 2)
 		auth->algorithm = WLAN_AUTH_OPEN; /* 0x80; */
-	printk("=================>%s():auth->algorithm is %d\n",__func__,auth->algorithm);
+	printk("=================>%s():auth->algorithm is %d\n",
+	       __func__,
+	       auth->algorithm);
 	auth->transaction = cpu_to_le16(ieee->associate_seq);
 	ieee->associate_seq++;
 
 	auth->status = cpu_to_le16(WLAN_STATUS_SUCCESS);
 
 	return skb;
-
 }
 
-
 static struct sk_buff *ieee80211_probe_resp(struct ieee80211_device *ieee, u8 *dest)
 {
 	u8 *tag;
@@ -703,74 +673,71 @@ static struct sk_buff *ieee80211_probe_resp(struct ieee80211_device *ieee, u8 *d
 
 	char *ssid = ieee->current_network.ssid;
 	int ssid_len = ieee->current_network.ssid_len;
-	int rate_len = ieee->current_network.rates_len+2;
+	int rate_len = ieee->current_network.rates_len + 2;
 	int rate_ex_len = ieee->current_network.rates_ex_len;
 	int wpa_ie_len = ieee->wpa_ie_len;
 	u8 erpinfo_content = 0;
 
 	u8 *tmp_ht_cap_buf;
-	u8 tmp_ht_cap_len=0;
+	u8 tmp_ht_cap_len = 0;
 	u8 *tmp_ht_info_buf;
-	u8 tmp_ht_info_len=0;
+	u8 tmp_ht_info_len = 0;
 	PRT_HIGH_THROUGHPUT	pHTInfo = ieee->pHTInfo;
-	u8 *tmp_generic_ie_buf=NULL;
-	u8 tmp_generic_ie_len=0;
+	u8 *tmp_generic_ie_buf = NULL;
+	u8 tmp_generic_ie_len = 0;
 
-	if(rate_ex_len > 0) rate_ex_len+=2;
+	if (rate_ex_len > 0)
+		rate_ex_len += 2;
 
-	if(ieee->current_network.capability & WLAN_CAPABILITY_IBSS)
+	if (ieee->current_network.capability & WLAN_CAPABILITY_IBSS)
 		atim_len = 4;
 	else
 		atim_len = 0;
 
-	if(ieee80211_is_54g(&ieee->current_network))
+	if (ieee80211_is_54g(&ieee->current_network))
 		erp_len = 3;
 	else
 		erp_len = 0;
 
-
 	crypt = ieee->crypt[ieee->tx_keyidx];
 
-
 	encrypt = ieee->host_encrypt && crypt && crypt->ops &&
 		((0 == strcmp(crypt->ops->name, "WEP") || wpa_ie_len));
 	/* HT ralated element */
-	tmp_ht_cap_buf =(u8 *) &(ieee->pHTInfo->SelfHTCap);
+	tmp_ht_cap_buf = (u8 *)&ieee->pHTInfo->SelfHTCap;
 	tmp_ht_cap_len = sizeof(ieee->pHTInfo->SelfHTCap);
-	tmp_ht_info_buf =(u8 *) &(ieee->pHTInfo->SelfHTInfo);
+	tmp_ht_info_buf = (u8 *)&ieee->pHTInfo->SelfHTInfo;
 	tmp_ht_info_len = sizeof(ieee->pHTInfo->SelfHTInfo);
-	HTConstructCapabilityElement(ieee, tmp_ht_cap_buf, &tmp_ht_cap_len,encrypt);
-	HTConstructInfoElement(ieee,tmp_ht_info_buf,&tmp_ht_info_len, encrypt);
+	HTConstructCapabilityElement(ieee, tmp_ht_cap_buf, &tmp_ht_cap_len, encrypt);
+	HTConstructInfoElement(ieee, tmp_ht_info_buf, &tmp_ht_info_len, encrypt);
 
-
-	if (pHTInfo->bRegRT2RTAggregation)
-	{
+	if (pHTInfo->bRegRT2RTAggregation) {
 		tmp_generic_ie_buf = ieee->pHTInfo->szRT2RTAggBuffer;
 		tmp_generic_ie_len = sizeof(ieee->pHTInfo->szRT2RTAggBuffer);
 		HTConstructRT2RTAggElement(ieee, tmp_generic_ie_buf, &tmp_generic_ie_len);
 	}
 //	printk("===============>tmp_ht_cap_len is %d,tmp_ht_info_len is %d, tmp_generic_ie_len is %d\n",tmp_ht_cap_len,tmp_ht_info_len,tmp_generic_ie_len);
-	beacon_size = sizeof(struct ieee80211_probe_response)+2+
-		ssid_len
-		+3 //channel
-		+rate_len
-		+rate_ex_len
-		+atim_len
-		+erp_len
-		+wpa_ie_len
-	//	+tmp_ht_cap_len
-	//	+tmp_ht_info_len
-	//	+tmp_generic_ie_len
-//		+wmm_len+2
-		+ieee->tx_headroom;
+	beacon_size = sizeof(struct ieee80211_probe_response) + 2
+		+ ssid_len
+		+ 3 //channel
+		+ rate_len
+		+ rate_ex_len
+		+ atim_len
+		+ erp_len
+		+ wpa_ie_len
+	//	+ tmp_ht_cap_len
+	//	+ tmp_ht_info_len
+	//	+ tmp_generic_ie_len
+//		+ wmm_len+2
+		+ ieee->tx_headroom;
 	skb = dev_alloc_skb(beacon_size);
 	if (!skb)
 		return NULL;
 	skb_reserve(skb, ieee->tx_headroom);
 	beacon_buf = skb_put(skb, (beacon_size - ieee->tx_headroom));
-	memcpy (beacon_buf->header.addr1, dest,ETH_ALEN);
-	memcpy (beacon_buf->header.addr2, ieee->dev->dev_addr, ETH_ALEN);
-	memcpy (beacon_buf->header.addr3, ieee->current_network.bssid, ETH_ALEN);
+	memcpy(beacon_buf->header.addr1, dest, ETH_ALEN);
+	memcpy(beacon_buf->header.addr2, ieee->dev->dev_addr, ETH_ALEN);
+	memcpy(beacon_buf->header.addr3, ieee->current_network.bssid, ETH_ALEN);
 
 	beacon_buf->header.duration_id = 0; /* FIXME */
 	beacon_buf->beacon_interval =
@@ -780,28 +747,27 @@ static struct sk_buff *ieee80211_probe_resp(struct ieee80211_device *ieee, u8 *d
 	beacon_buf->capability |=
 		cpu_to_le16(ieee->current_network.capability & WLAN_CAPABILITY_SHORT_PREAMBLE); /* add short preamble here */
 
-	if(ieee->short_slot && (ieee->current_network.capability & WLAN_CAPABILITY_SHORT_SLOT))
+	if (ieee->short_slot && (ieee->current_network.capability & WLAN_CAPABILITY_SHORT_SLOT))
 		beacon_buf->capability |= cpu_to_le16(WLAN_CAPABILITY_SHORT_SLOT);
 
 	crypt = ieee->crypt[ieee->tx_keyidx];
 	if (encrypt)
 		beacon_buf->capability |= cpu_to_le16(WLAN_CAPABILITY_PRIVACY);
 
-
 	beacon_buf->header.frame_ctl = cpu_to_le16(IEEE80211_STYPE_PROBE_RESP);
 	beacon_buf->info_element[0].id = MFIE_TYPE_SSID;
 	beacon_buf->info_element[0].len = ssid_len;
 
-	tag = (u8 *) beacon_buf->info_element[0].data;
+	tag = (u8 *)beacon_buf->info_element[0].data;
 
 	memcpy(tag, ssid, ssid_len);
 
 	tag += ssid_len;
 
 	*(tag++) = MFIE_TYPE_RATES;
-	*(tag++) = rate_len-2;
-	memcpy(tag, ieee->current_network.rates, rate_len-2);
-	tag+=rate_len-2;
+	*(tag++) = rate_len - 2;
+	memcpy(tag, ieee->current_network.rates, rate_len - 2);
+	tag += rate_len - 2;
 
 	*(tag++) = MFIE_TYPE_DS_SET;
 	*(tag++) = 1;
@@ -813,7 +779,7 @@ static struct sk_buff *ieee80211_probe_resp(struct ieee80211_device *ieee, u8 *d
 
 		put_unaligned_le16(ieee->current_network.atim_window,
 				   tag);
-		tag+=2;
+		tag += 2;
 	}
 
 	if (erp_len) {
@@ -823,17 +789,15 @@ static struct sk_buff *ieee80211_probe_resp(struct ieee80211_device *ieee, u8 *d
 	}
 	if (rate_ex_len) {
 		*(tag++) = MFIE_TYPE_RATES_EX;
-		*(tag++) = rate_ex_len-2;
-		memcpy(tag, ieee->current_network.rates_ex, rate_ex_len-2);
-		tag+=rate_ex_len-2;
+		*(tag++) = rate_ex_len - 2;
+		memcpy(tag, ieee->current_network.rates_ex, rate_ex_len - 2);
+		tag += rate_ex_len - 2;
 	}
 
-	if (wpa_ie_len)
-	{
+	if (wpa_ie_len) {
 		if (ieee->iw_mode == IW_MODE_ADHOC)
-		{//as Windows will set pairwise key same as the group key which is not allowed in Linux, so set this for IOT issue. WB 2008.07.07
+			//as Windows will set pairwise key same as the group key which is not allowed in Linux, so set this for IOT issue. WB 2008.07.07
 			memcpy(&ieee->wpa_ie[14], &ieee->wpa_ie[8], 4);
-		}
 		memcpy(tag, ieee->wpa_ie, ieee->wpa_ie_len);
 		tag += wpa_ie_len;
 	}
@@ -842,7 +806,6 @@ static struct sk_buff *ieee80211_probe_resp(struct ieee80211_device *ieee, u8 *d
 	return skb;
 }
 
-
 static struct sk_buff *ieee80211_assoc_resp(struct ieee80211_device *ieee,
 					    u8 *dest)
 {
@@ -866,19 +829,19 @@ static struct sk_buff *ieee80211_assoc_resp(struct ieee80211_device *ieee,
 	assoc = skb_put(skb, sizeof(struct ieee80211_assoc_response_frame));
 
 	assoc->header.frame_ctl = cpu_to_le16(IEEE80211_STYPE_ASSOC_RESP);
-	memcpy(assoc->header.addr1, dest,ETH_ALEN);
+	memcpy(assoc->header.addr1, dest, ETH_ALEN);
 	memcpy(assoc->header.addr3, ieee->dev->dev_addr, ETH_ALEN);
 	memcpy(assoc->header.addr2, ieee->dev->dev_addr, ETH_ALEN);
 	assoc->capability = cpu_to_le16(ieee->iw_mode == IW_MODE_MASTER ?
 		WLAN_CAPABILITY_BSS : WLAN_CAPABILITY_IBSS);
 
-
-	if(ieee->short_slot)
+	if (ieee->short_slot)
 		assoc->capability |= cpu_to_le16(WLAN_CAPABILITY_SHORT_SLOT);
 
 	if (ieee->host_encrypt)
 		crypt = ieee->crypt[ieee->tx_keyidx];
-	else crypt = NULL;
+	else
+		crypt = NULL;
 
 	encrypt = crypt && crypt->ops;
 
@@ -887,8 +850,10 @@ static struct sk_buff *ieee80211_assoc_resp(struct ieee80211_device *ieee,
 
 	assoc->status = 0;
 	assoc->aid = cpu_to_le16(ieee->assoc_id);
-	if (ieee->assoc_id == 0x2007) ieee->assoc_id=0;
-	else ieee->assoc_id++;
+	if (ieee->assoc_id == 0x2007)
+		ieee->assoc_id = 0;
+	else
+		ieee->assoc_id++;
 
 	tag = skb_put(skb, rate_len);
 
@@ -903,7 +868,7 @@ static struct sk_buff *ieee80211_auth_resp(struct ieee80211_device *ieee,
 {
 	struct sk_buff *skb;
 	struct ieee80211_authentication *auth;
-	int len = ieee->tx_headroom + sizeof(struct ieee80211_authentication)+1;
+	int len = ieee->tx_headroom + sizeof(struct ieee80211_authentication) + 1;
 
 	skb = dev_alloc_skb(len);
 
@@ -923,8 +888,6 @@ static struct sk_buff *ieee80211_auth_resp(struct ieee80211_device *ieee,
 	memcpy(auth->header.addr1, dest, ETH_ALEN);
 	auth->header.frame_ctl = cpu_to_le16(IEEE80211_STYPE_AUTH);
 	return skb;
-
-
 }
 
 static struct sk_buff *ieee80211_null_func(struct ieee80211_device *ieee,
@@ -946,14 +909,11 @@ static struct sk_buff *ieee80211_null_func(struct ieee80211_device *ieee,
 
 	hdr->frame_ctl = cpu_to_le16(IEEE80211_FTYPE_DATA |
 		IEEE80211_STYPE_NULLFUNC | IEEE80211_FCTL_TODS |
-		(pwr ? IEEE80211_FCTL_PM:0));
+		(pwr ? IEEE80211_FCTL_PM : 0));
 
 	return skb;
-
-
 }
 
-
 static void ieee80211_resp_to_assoc_rq(struct ieee80211_device *ieee, u8 *dest)
 {
 	struct sk_buff *buf = ieee80211_assoc_resp(ieee, dest);
@@ -962,7 +922,6 @@ static void ieee80211_resp_to_assoc_rq(struct ieee80211_device *ieee, u8 *dest)
 		softmac_mgmt_xmit(buf, ieee);
 }
 
-
 static void ieee80211_resp_to_auth(struct ieee80211_device *ieee, int s,
 				   u8 *dest)
 {
@@ -972,17 +931,14 @@ static void ieee80211_resp_to_auth(struct ieee80211_device *ieee, int s,
 		softmac_mgmt_xmit(buf, ieee);
 }
 
-
 static void ieee80211_resp_to_probe(struct ieee80211_device *ieee, u8 *dest)
 {
-
-
 	struct sk_buff *buf = ieee80211_probe_resp(ieee, dest);
+
 	if (buf)
 		softmac_mgmt_xmit(buf, ieee);
 }
 
-
 static inline struct sk_buff *
 ieee80211_association_req(struct ieee80211_network *beacon,
 			  struct ieee80211_device *ieee)
@@ -999,59 +955,52 @@ ieee80211_association_req(struct ieee80211_network *beacon,
 	//unsigned int wpa_len = beacon->wpa_ie_len;
 	//for HT
 	u8 *ht_cap_buf = NULL;
-	u8 ht_cap_len=0;
-	u8 *realtek_ie_buf=NULL;
-	u8 realtek_ie_len=0;
-	int wpa_ie_len= ieee->wpa_ie_len;
-	unsigned int ckip_ie_len=0;
-	unsigned int ccxrm_ie_len=0;
-	unsigned int cxvernum_ie_len=0;
+	u8 ht_cap_len = 0;
+	u8 *realtek_ie_buf = NULL;
+	u8 realtek_ie_len = 0;
+	int wpa_ie_len = ieee->wpa_ie_len;
+	unsigned int ckip_ie_len = 0;
+	unsigned int ccxrm_ie_len = 0;
+	unsigned int cxvernum_ie_len = 0;
 	struct ieee80211_crypt_data *crypt;
 	int encrypt;
 
 	unsigned int rate_len = ieee80211_MFIE_rate_len(ieee);
-	unsigned int wmm_info_len = beacon->qos_data.supported?9:0;
+	unsigned int wmm_info_len = beacon->qos_data.supported ? 9 : 0;
 #ifdef THOMAS_TURBO
-	unsigned int turbo_info_len = beacon->Turbo_Enable?9:0;
+	unsigned int turbo_info_len = beacon->Turbo_Enable ? 9 : 0;
 #endif
 
 	int len = 0;
 
 	crypt = ieee->crypt[ieee->tx_keyidx];
-	encrypt = ieee->host_encrypt && crypt && crypt->ops && ((0 == strcmp(crypt->ops->name,"WEP") || wpa_ie_len));
+	encrypt = ieee->host_encrypt && crypt && crypt->ops && ((0 == strcmp(crypt->ops->name, "WEP") || wpa_ie_len));
 
 	/* Include High Throuput capability && Realtek proprietary */
-	if (ieee->pHTInfo->bCurrentHTSupport&&ieee->pHTInfo->bEnableHT)
-	{
-		ht_cap_buf = (u8 *)&(ieee->pHTInfo->SelfHTCap);
+	if (ieee->pHTInfo->bCurrentHTSupport && ieee->pHTInfo->bEnableHT) {
+		ht_cap_buf = (u8 *)&ieee->pHTInfo->SelfHTCap;
 		ht_cap_len = sizeof(ieee->pHTInfo->SelfHTCap);
 		HTConstructCapabilityElement(ieee, ht_cap_buf, &ht_cap_len, encrypt);
-		if (ieee->pHTInfo->bCurrentRT2RTAggregation)
-		{
+		if (ieee->pHTInfo->bCurrentRT2RTAggregation) {
 			realtek_ie_buf = ieee->pHTInfo->szRT2RTAggBuffer;
-			realtek_ie_len = sizeof( ieee->pHTInfo->szRT2RTAggBuffer);
+			realtek_ie_len = sizeof(ieee->pHTInfo->szRT2RTAggBuffer);
 			HTConstructRT2RTAggElement(ieee, realtek_ie_buf, &realtek_ie_len);
-
 		}
 	}
-	if (ieee->qos_support) {
-		wmm_info_len = beacon->qos_data.supported?9:0;
-	}
-
+	if (ieee->qos_support)
+		wmm_info_len = beacon->qos_data.supported ? 9 : 0;
 
 	if (beacon->bCkipSupported)
-	{
-		ckip_ie_len = 30+2;
-	}
+		ckip_ie_len = 30 + 2;
+
 	if (beacon->bCcxRmEnable)
-	{
-		ccxrm_ie_len = 6+2;
-	}
+		ccxrm_ie_len = 6 + 2;
+
 	if (beacon->BssCcxVerNumber >= 2)
-		cxvernum_ie_len = 5+2;
+		cxvernum_ie_len = 5 + 2;
 
 #ifdef THOMAS_TURBO
-	len = sizeof(struct ieee80211_assoc_request_frame)+ 2
+	len = sizeof(struct ieee80211_assoc_request_frame) + 2
 		+ beacon->ssid_len	/* essid tagged val */
 		+ rate_len	/* rates tagged val */
 		+ wpa_ie_len
@@ -1064,7 +1013,7 @@ ieee80211_association_req(struct ieee80211_network *beacon,
 		+ cxvernum_ie_len
 		+ ieee->tx_headroom;
 #else
-	len = sizeof(struct ieee80211_assoc_request_frame)+ 2
+	len = sizeof(struct ieee80211_assoc_request_frame) + 2
 		+ beacon->ssid_len	/* essid tagged val */
 		+ rate_len	/* rates tagged val */
 		+ wpa_ie_len
@@ -1086,7 +1035,6 @@ ieee80211_association_req(struct ieee80211_network *beacon,
 
 	hdr = skb_put(skb, sizeof(struct ieee80211_assoc_request_frame) + 2);
 
-
 	hdr->header.frame_ctl = IEEE80211_STYPE_ASSOC_REQ;
 	hdr->header.duration_id = cpu_to_le16(37);
 	memcpy(hdr->header.addr1, beacon->bssid, ETH_ALEN);
@@ -1096,13 +1044,13 @@ ieee80211_association_req(struct ieee80211_network *beacon,
 	memcpy(ieee->ap_mac_addr, beacon->bssid, ETH_ALEN);//for HW security, John
 
 	hdr->capability = cpu_to_le16(WLAN_CAPABILITY_BSS);
-	if (beacon->capability & WLAN_CAPABILITY_PRIVACY )
+	if (beacon->capability & WLAN_CAPABILITY_PRIVACY)
 		hdr->capability |= cpu_to_le16(WLAN_CAPABILITY_PRIVACY);
 
 	if (beacon->capability & WLAN_CAPABILITY_SHORT_PREAMBLE)
 		hdr->capability |= cpu_to_le16(WLAN_CAPABILITY_SHORT_PREAMBLE); //add short_preamble here
 
-	if(ieee->short_slot)
+	if (ieee->short_slot)
 		hdr->capability |= cpu_to_le16(WLAN_CAPABILITY_SHORT_SLOT);
 	if (wmm_info_len) //QOS
 		hdr->capability |= cpu_to_le16(WLAN_CAPABILITY_QOS);
@@ -1136,7 +1084,7 @@ ieee80211_association_req(struct ieee80211_network *beacon,
 		// CCX1 spec V1.13, A01.1 CKIP Negotiation (page23):
 		// "The CKIP negotiation is started with the associate request from the client to the access point,
 		//  containing an Aironet element with both the MIC and KP bits set."
-		osCcxAironetIE.Octet[IE_CISCO_FLAG_POSITION] |=  (SUPPORT_CKIP_PK|SUPPORT_CKIP_MIC) ;
+		osCcxAironetIE.Octet[IE_CISCO_FLAG_POSITION] |=  (SUPPORT_CKIP_PK | SUPPORT_CKIP_MIC);
 		tag = skb_put(skb, ckip_ie_len);
 		*tag++ = MFIE_TYPE_AIRONET;
 		*tag++ = osCcxAironetIE.Length;
@@ -1144,8 +1092,7 @@ ieee80211_association_req(struct ieee80211_network *beacon,
 		tag += osCcxAironetIE.Length;
 	}
 
-	if (beacon->bCcxRmEnable)
-	{
+	if (beacon->bCcxRmEnable) {
 		static u8 CcxRmCapBuf[] = {0x00, 0x40, 0x96, 0x01, 0x01, 0x00};
 		OCTET_STRING osCcxRmCap;
 
@@ -1161,6 +1108,7 @@ ieee80211_association_req(struct ieee80211_network *beacon,
 	if (beacon->BssCcxVerNumber >= 2) {
 		u8			CcxVerNumBuf[] = {0x00, 0x40, 0x96, 0x03, 0x00};
 		OCTET_STRING	osCcxVerNum;
+
 		CcxVerNumBuf[4] = beacon->BssCcxVerNumber;
 		osCcxVerNum.Octet = CcxVerNumBuf;
 		osCcxVerNum.Length = sizeof(CcxVerNumBuf);
@@ -1172,21 +1120,18 @@ ieee80211_association_req(struct ieee80211_network *beacon,
 	}
 	//HT cap element
 	if (ieee->pHTInfo->bCurrentHTSupport && ieee->pHTInfo->bEnableHT) {
-		if (ieee->pHTInfo->ePeerHTSpecVer != HT_SPEC_VER_EWC)
-		{
+		if (ieee->pHTInfo->ePeerHTSpecVer != HT_SPEC_VER_EWC) {
 			tag = skb_put(skb, ht_cap_len);
 			*tag++ = MFIE_TYPE_HT_CAP;
 			*tag++ = ht_cap_len - 2;
 			memcpy(tag, ht_cap_buf, ht_cap_len - 2);
-			tag += ht_cap_len -2;
+			tag += ht_cap_len - 2;
 		}
 	}
 
-
 	//choose what wpa_supplicant gives to associate.
-	if (wpa_ie_len) {
+	if (wpa_ie_len)
 		skb_put_data(skb, ieee->wpa_ie, wpa_ie_len);
-	}
 
 	if (wmm_info_len) {
 		tag = skb_put(skb, wmm_info_len);
@@ -1200,13 +1145,12 @@ ieee80211_association_req(struct ieee80211_network *beacon,
 #endif
 
 	if (ieee->pHTInfo->bCurrentHTSupport && ieee->pHTInfo->bEnableHT) {
-		if(ieee->pHTInfo->ePeerHTSpecVer == HT_SPEC_VER_EWC)
-		{
+		if (ieee->pHTInfo->ePeerHTSpecVer == HT_SPEC_VER_EWC) {
 			tag = skb_put(skb, ht_cap_len);
 			*tag++ = MFIE_TYPE_GENERIC;
 			*tag++ = ht_cap_len - 2;
 			memcpy(tag, ht_cap_buf, ht_cap_len - 2);
-			tag += ht_cap_len -2;
+			tag += ht_cap_len - 2;
 		}
 
 		if (ieee->pHTInfo->bCurrentRT2RTAggregation) {
@@ -1223,8 +1167,8 @@ ieee80211_association_req(struct ieee80211_network *beacon,
 
 void ieee80211_associate_abort(struct ieee80211_device *ieee)
 {
-
 	unsigned long flags;
+
 	spin_lock_irqsave(&ieee->lock, flags);
 
 	ieee->associate_seq++;
@@ -1235,18 +1179,18 @@ void ieee80211_associate_abort(struct ieee80211_device *ieee)
 	 * Here we will check if there are good nets to associate
 	 * with, so we retry or just get back to NO_LINK and scanning
 	 */
-	if (ieee->state == IEEE80211_ASSOCIATING_AUTHENTICATING){
+	if (ieee->state == IEEE80211_ASSOCIATING_AUTHENTICATING) {
 		IEEE80211_DEBUG_MGMT("Authentication failed\n");
 		ieee->softmac_stats.no_auth_rs++;
-	}else{
+	} else {
 		IEEE80211_DEBUG_MGMT("Association failed\n");
 		ieee->softmac_stats.no_ass_rs++;
 	}
 
 	ieee->state = IEEE80211_ASSOCIATING_RETRY;
 
-	schedule_delayed_work(&ieee->associate_retry_wq, \
-			   IEEE80211_SOFTMAC_ASSOC_RETRY_TIME);
+	schedule_delayed_work(&ieee->associate_retry_wq,
+			      IEEE80211_SOFTMAC_ASSOC_RETRY_TIME);
 
 	spin_unlock_irqrestore(&ieee->lock, flags);
 }
@@ -1258,7 +1202,6 @@ static void ieee80211_associate_abort_cb(struct timer_list *t)
 	ieee80211_associate_abort(dev);
 }
 
-
 static void ieee80211_associate_step1(struct ieee80211_device *ieee)
 {
 	struct ieee80211_network *beacon = &ieee->current_network;
@@ -1267,12 +1210,12 @@ static void ieee80211_associate_step1(struct ieee80211_device *ieee)
 	IEEE80211_DEBUG_MGMT("Stopping scan\n");
 
 	ieee->softmac_stats.tx_auth_rq++;
-	skb=ieee80211_authentication_req(beacon, ieee, 0);
+	skb = ieee80211_authentication_req(beacon, ieee, 0);
 
-	if (!skb)
+	if (!skb) {
 		ieee80211_associate_abort(ieee);
-	else{
-		ieee->state = IEEE80211_ASSOCIATING_AUTHENTICATING ;
+	} else {
+		ieee->state = IEEE80211_ASSOCIATING_AUTHENTICATING;
 		IEEE80211_DEBUG_MGMT("Sending authentication request\n");
 		softmac_mgmt_xmit(skb, ieee);
 		//BUGON when you try to add_timer twice, using mod_timer may be better, john0709
@@ -1296,21 +1239,21 @@ static void ieee80211_auth_challenge(struct ieee80211_device *ieee,
 	ieee->associate_seq++;
 	ieee->softmac_stats.tx_auth_rq++;
 
-	skb = ieee80211_authentication_req(beacon, ieee, chlen+2);
-	if (!skb)
+	skb = ieee80211_authentication_req(beacon, ieee, chlen + 2);
+	if (!skb) {
 		ieee80211_associate_abort(ieee);
-	else{
-		c = skb_put(skb, chlen+2);
+	} else {
+		c = skb_put(skb, chlen + 2);
 		*(c++) = MFIE_TYPE_CHALLENGE;
 		*(c++) = chlen;
 		memcpy(c, challenge, chlen);
 
 		IEEE80211_DEBUG_MGMT("Sending authentication challenge response\n");
 
-		ieee80211_encrypt_fragment(ieee, skb, sizeof(struct rtl_80211_hdr_3addr  ));
+		ieee80211_encrypt_fragment(ieee, skb, sizeof(struct rtl_80211_hdr_3addr));
 
 		softmac_mgmt_xmit(skb, ieee);
-		mod_timer(&ieee->associate_timer, jiffies + (HZ/2));
+		mod_timer(&ieee->associate_timer, jiffies + (HZ / 2));
 		//dev_kfree_skb_any(skb);//edit by thomas
 	}
 	kfree(challenge);
@@ -1326,45 +1269,42 @@ static void ieee80211_associate_step2(struct ieee80211_device *ieee)
 	IEEE80211_DEBUG_MGMT("Sending association request\n");
 
 	ieee->softmac_stats.tx_ass_rq++;
-	skb=ieee80211_association_req(beacon, ieee);
-	if (!skb)
+	skb = ieee80211_association_req(beacon, ieee);
+	if (!skb) {
 		ieee80211_associate_abort(ieee);
-	else{
+	} else {
 		softmac_mgmt_xmit(skb, ieee);
-		mod_timer(&ieee->associate_timer, jiffies + (HZ/2));
+		mod_timer(&ieee->associate_timer, jiffies + (HZ / 2));
 		//dev_kfree_skb_any(skb);//edit by thomas
 	}
 }
+
 static void ieee80211_associate_complete_wq(struct work_struct *work)
 {
 	struct ieee80211_device *ieee = container_of(work, struct ieee80211_device, associate_complete_wq);
-	printk(KERN_INFO "Associated successfully\n");
-	if(ieee80211_is_54g(&ieee->current_network) &&
-		(ieee->modulation & IEEE80211_OFDM_MODULATION)){
 
+	printk(KERN_INFO "Associated successfully\n");
+	if (ieee80211_is_54g(&ieee->current_network) &&
+	    (ieee->modulation & IEEE80211_OFDM_MODULATION)) {
 		ieee->rate = 108;
-		printk(KERN_INFO"Using G rates:%d\n", ieee->rate);
-	}else{
+		printk(KERN_INFO "Using G rates:%d\n", ieee->rate);
+	} else {
 		ieee->rate = 22;
-		printk(KERN_INFO"Using B rates:%d\n", ieee->rate);
+		printk(KERN_INFO "Using B rates:%d\n", ieee->rate);
 	}
-	if (ieee->pHTInfo->bCurrentHTSupport&&ieee->pHTInfo->bEnableHT)
-	{
+	if (ieee->pHTInfo->bCurrentHTSupport && ieee->pHTInfo->bEnableHT) {
 		printk("Successfully associated, ht enabled\n");
 		HTOnAssocRsp(ieee);
-	}
-	else
-	{
+	} else {
 		printk("Successfully associated, ht not enabled(%d, %d)\n", ieee->pHTInfo->bCurrentHTSupport, ieee->pHTInfo->bEnableHT);
 		memset(ieee->dot11HTOperationalRateSet, 0, 16);
 		//HTSetConnectBwMode(ieee, HT_CHANNEL_WIDTH_20, HT_EXTCHNL_OFFSET_NO_EXT);
 	}
-	ieee->LinkDetectInfo.SlotNum = 2 * (1 + ieee->current_network.beacon_interval/500);
+	ieee->LinkDetectInfo.SlotNum = 2 * (1 + ieee->current_network.beacon_interval / 500);
 	// To prevent the immediately calling watch_dog after association.
-	if (ieee->LinkDetectInfo.NumRecvBcnInPeriod==0||ieee->LinkDetectInfo.NumRecvDataInPeriod==0 )
-	{
+	if (ieee->LinkDetectInfo.NumRecvBcnInPeriod == 0 || ieee->LinkDetectInfo.NumRecvDataInPeriod == 0) {
 		ieee->LinkDetectInfo.NumRecvBcnInPeriod = 1;
-		ieee->LinkDetectInfo.NumRecvDataInPeriod= 1;
+		ieee->LinkDetectInfo.NumRecvDataInPeriod = 1;
 	}
 	ieee->link_change(ieee->dev);
 	if (!ieee->is_silent_reset) {
@@ -1394,6 +1334,7 @@ static void ieee80211_associate_complete(struct ieee80211_device *ieee)
 static void ieee80211_associate_procedure_wq(struct work_struct *work)
 {
 	struct ieee80211_device *ieee = container_of(work, struct ieee80211_device, associate_procedure_wq);
+
 	ieee->sync_scan_hurryup = 1;
 	mutex_lock(&ieee->wx_mutex);
 
@@ -1413,7 +1354,7 @@ static void ieee80211_associate_procedure_wq(struct work_struct *work)
 
 inline void ieee80211_softmac_new_net(struct ieee80211_device *ieee, struct ieee80211_network *net)
 {
-	u8 tmp_ssid[IW_ESSID_MAX_SIZE+1];
+	u8 tmp_ssid[IW_ESSID_MAX_SIZE + 1];
 	int tmp_ssid_len = 0;
 
 	short apset, ssidset, ssidbroad, apmatch, ssidmatch;
@@ -1430,7 +1371,6 @@ inline void ieee80211_softmac_new_net(struct ieee80211_device *ieee, struct ieee
 	if ((ieee->iw_mode == IW_MODE_ADHOC) && !(net->capability & WLAN_CAPABILITY_IBSS))
 		return;
 
-
 	if (ieee->iw_mode == IW_MODE_INFRA || ieee->iw_mode == IW_MODE_ADHOC) {
 		/* if the user specified the AP MAC, we need also the essid
 		 * This could be obtained by beacons or, if the network does not
@@ -1438,77 +1378,81 @@ inline void ieee80211_softmac_new_net(struct ieee80211_device *ieee, struct ieee
 		 */
 		apset = ieee->wap_set;//(memcmp(ieee->current_network.bssid, zero,ETH_ALEN)!=0 );
 		ssidset = ieee->ssid_set;//ieee->current_network.ssid[0] != '\0';
-		ssidbroad =  !(net->ssid_len == 0 || net->ssid[0]== '\0');
-		apmatch = (memcmp(ieee->current_network.bssid, net->bssid, ETH_ALEN)==0);
-		ssidmatch = (ieee->current_network.ssid_len == net->ssid_len)&&\
-				(!strncmp(ieee->current_network.ssid, net->ssid, net->ssid_len));
-
-
-		if (	/* if the user set the AP check if match.
-			 * if the network does not broadcast essid we check the user supplyed ANY essid
-			 * if the network does broadcast and the user does not set essid it is OK
-			 * if the network does broadcast and the user did set essid chech if essid match
-			 */
-			(apset && apmatch &&
-				((ssidset && ssidbroad && ssidmatch) || (ssidbroad && !ssidset) || (!ssidbroad && ssidset)) ) ||
-			/* if the ap is not set, check that the user set the bssid
-			 * and the network does broadcast and that those two bssid matches
+		ssidbroad =  !(net->ssid_len == 0 || net->ssid[0] == '\0');
+		apmatch = (memcmp(ieee->current_network.bssid, net->bssid, ETH_ALEN) == 0);
+		ssidmatch = (ieee->current_network.ssid_len == net->ssid_len) &&
+			(!strncmp(ieee->current_network.ssid, net->ssid, net->ssid_len));
+
+		/* if the user set the AP check if match.
+		 * if the network does not broadcast essid we check the user supplyed ANY essid
+		 * if the network does broadcast and the user does not set essid it is OK
+		 * if the network does broadcast and the user did set essid chech if essid match
+		 */
+		if ((apset && apmatch &&
+		     ((ssidset && ssidbroad && ssidmatch) || (ssidbroad && !ssidset) || (!ssidbroad && ssidset))) ||
+		    /* if the ap is not set, check that the user set the bssid
+		     * and the network does broadcast and that those two bssid matches
+		     */
+		    (!apset && ssidset && ssidbroad && ssidmatch)) {
+			/* if the essid is hidden replace it with the
+			 * essid provided by the user.
 			 */
-			(!apset && ssidset && ssidbroad && ssidmatch)
-			){
-				/* if the essid is hidden replace it with the
-				* essid provided by the user.
-				*/
-				if (!ssidbroad) {
-					strncpy(tmp_ssid, ieee->current_network.ssid, IW_ESSID_MAX_SIZE);
-					tmp_ssid_len = ieee->current_network.ssid_len;
-				}
-				memcpy(&ieee->current_network, net, sizeof(struct ieee80211_network));
-
-				strncpy(ieee->current_network.ssid, tmp_ssid, IW_ESSID_MAX_SIZE);
-				ieee->current_network.ssid_len = tmp_ssid_len;
-				printk(KERN_INFO"Linking with %s,channel:%d, qos:%d, myHT:%d, networkHT:%d\n",ieee->current_network.ssid,ieee->current_network.channel, ieee->current_network.qos_data.supported, ieee->pHTInfo->bEnableHT, ieee->current_network.bssht.bdSupportHT);
-
-				//ieee->pHTInfo->IOTAction = 0;
-				HTResetIOTSetting(ieee->pHTInfo);
-				if (ieee->iw_mode == IW_MODE_INFRA){
-					/* Join the network for the first time */
-					ieee->AsocRetryCount = 0;
-					//for HT by amy 080514
-					if((ieee->current_network.qos_data.supported == 1) &&
-					  // (ieee->pHTInfo->bEnableHT && ieee->current_network.bssht.bdSupportHT))
-					   ieee->current_network.bssht.bdSupportHT)
-/*WB, 2008.09.09:bCurrentHTSupport and bEnableHT two flags are going to put together to check whether we are in HT now, so needn't to check bEnableHT flags here. That's is to say we will set to HT support whenever joined AP has the ability to support HT. And whether we are in HT or not, please check bCurrentHTSupport&&bEnableHT now please.*/
-					{
+			if (!ssidbroad) {
+				strncpy(tmp_ssid, ieee->current_network.ssid, IW_ESSID_MAX_SIZE);
+				tmp_ssid_len = ieee->current_network.ssid_len;
+			}
+			memcpy(&ieee->current_network, net, sizeof(struct ieee80211_network));
+
+			strncpy(ieee->current_network.ssid, tmp_ssid, IW_ESSID_MAX_SIZE);
+			ieee->current_network.ssid_len = tmp_ssid_len;
+			printk(KERN_INFO "Linking with %s,channel:%d, qos:%d, myHT:%d, networkHT:%d\n",
+			       ieee->current_network.ssid,
+			       ieee->current_network.channel,
+			       ieee->current_network.qos_data.supported,
+			       ieee->pHTInfo->bEnableHT,
+			       ieee->current_network.bssht.bdSupportHT);
+
+			//ieee->pHTInfo->IOTAction = 0;
+			HTResetIOTSetting(ieee->pHTInfo);
+			if (ieee->iw_mode == IW_MODE_INFRA) {
+				/* Join the network for the first time */
+				ieee->AsocRetryCount = 0;
+				//for HT by amy 080514
+				if ((ieee->current_network.qos_data.supported == 1) &&
+				    // (ieee->pHTInfo->bEnableHT && ieee->current_network.bssht.bdSupportHT))
+				    ieee->current_network.bssht.bdSupportHT) {
+					/*
+					 * WB, 2008.09.09:bCurrentHTSupport and bEnableHT two flags are goin
+					 * to put together to check whether we are in HT now, so needn't to
+					 * check bEnableHT flags here. That's is to say we will set to HT support
+					 * whenever joined AP has the ability to support HT. And whether we are
+					 * in HT or not, please check bCurrentHTSupport&&bEnableHT now please.
+					 */
 					//	ieee->pHTInfo->bCurrentHTSupport = true;
-						HTResetSelfAndSavePeerSetting(ieee, &(ieee->current_network));
-					}
-					else
-					{
-						ieee->pHTInfo->bCurrentHTSupport = false;
-					}
-
-					ieee->state = IEEE80211_ASSOCIATING;
-					schedule_work(&ieee->associate_procedure_wq);
-				}else{
-					if(ieee80211_is_54g(&ieee->current_network) &&
-						(ieee->modulation & IEEE80211_OFDM_MODULATION)){
-						ieee->rate = 108;
-						ieee->SetWirelessMode(ieee->dev, IEEE_G);
-						printk(KERN_INFO"Using G rates\n");
-					}else{
-						ieee->rate = 22;
-						ieee->SetWirelessMode(ieee->dev, IEEE_B);
-						printk(KERN_INFO"Using B rates\n");
-					}
-					memset(ieee->dot11HTOperationalRateSet, 0, 16);
-					//HTSetConnectBwMode(ieee, HT_CHANNEL_WIDTH_20, HT_EXTCHNL_OFFSET_NO_EXT);
-					ieee->state = IEEE80211_LINKED;
+					HTResetSelfAndSavePeerSetting(ieee, &ieee->current_network);
+				} else {
+					ieee->pHTInfo->bCurrentHTSupport = false;
 				}
 
+				ieee->state = IEEE80211_ASSOCIATING;
+				schedule_work(&ieee->associate_procedure_wq);
+			} else {
+				if (ieee80211_is_54g(&ieee->current_network) &&
+				    (ieee->modulation & IEEE80211_OFDM_MODULATION)) {
+					ieee->rate = 108;
+					ieee->SetWirelessMode(ieee->dev, IEEE_G);
+					printk(KERN_INFO "Using G rates\n");
+				} else {
+					ieee->rate = 22;
+					ieee->SetWirelessMode(ieee->dev, IEEE_B);
+					printk(KERN_INFO "Using B rates\n");
+				}
+				memset(ieee->dot11HTOperationalRateSet, 0, 16);
+				//HTSetConnectBwMode(ieee, HT_CHANNEL_WIDTH_20, HT_EXTCHNL_OFFSET_NO_EXT);
+				ieee->state = IEEE80211_LINKED;
+			}
 		}
 	}
-
 }
 
 void ieee80211_softmac_check_all_nets(struct ieee80211_device *ieee)
@@ -1519,7 +1463,6 @@ void ieee80211_softmac_check_all_nets(struct ieee80211_device *ieee)
 	spin_lock_irqsave(&ieee->lock, flags);
 
 	list_for_each_entry(target, &ieee->network_list, list) {
-
 		/* if the state become different that NOLINK means
 		 * we had found what we are searching for
 		 */
@@ -1532,20 +1475,19 @@ void ieee80211_softmac_check_all_nets(struct ieee80211_device *ieee)
 	}
 
 	spin_unlock_irqrestore(&ieee->lock, flags);
-
 }
 
-
 static inline u16 auth_parse(struct sk_buff *skb, u8 **challenge, int *chlen)
 {
 	struct ieee80211_authentication *a;
 	u8 *t;
+
 	if (skb->len < (sizeof(struct ieee80211_authentication) - sizeof(struct ieee80211_info_element))) {
-		IEEE80211_DEBUG_MGMT("invalid len in auth resp: %d\n",skb->len);
+		IEEE80211_DEBUG_MGMT("invalid len in auth resp: %d\n", skb->len);
 		return 0xcafe;
 	}
 	*challenge = NULL;
-	a = (struct ieee80211_authentication *) skb->data;
+	a = (struct ieee80211_authentication *)skb->data;
 	if (skb->len > (sizeof(struct ieee80211_authentication) + 3)) {
 		t = skb->data + sizeof(struct ieee80211_authentication);
 
@@ -1558,21 +1500,19 @@ static inline u16 auth_parse(struct sk_buff *skb, u8 **challenge, int *chlen)
 	}
 
 	return le16_to_cpu(a->status);
-
 }
 
-
 static int auth_rq_parse(struct sk_buff *skb, u8 *dest)
 {
 	struct ieee80211_authentication *a;
 
 	if (skb->len < (sizeof(struct ieee80211_authentication) - sizeof(struct ieee80211_info_element))) {
-		IEEE80211_DEBUG_MGMT("invalid len in auth request: %d\n",skb->len);
+		IEEE80211_DEBUG_MGMT("invalid len in auth request: %d\n", skb->len);
 		return -1;
 	}
-	a = (struct ieee80211_authentication *) skb->data;
+	a = (struct ieee80211_authentication *)skb->data;
 
-	memcpy(dest,a->header.addr2, ETH_ALEN);
+	memcpy(dest, a->header.addr2, ETH_ALEN);
 
 	if (le16_to_cpu(a->algorithm) != WLAN_AUTH_OPEN)
 		return  WLAN_STATUS_NOT_SUPPORTED_AUTH_ALG;
@@ -1584,25 +1524,25 @@ static short probe_rq_parse(struct ieee80211_device *ieee, struct sk_buff *skb,
 {
 	u8 *tag;
 	u8 *skbend;
-	u8 *ssid=NULL;
+	u8 *ssid = NULL;
 	u8 ssidlen = 0;
 
 	struct rtl_80211_hdr_3addr   *header =
-		(struct rtl_80211_hdr_3addr   *) skb->data;
+		(struct rtl_80211_hdr_3addr *)skb->data;
 
-	if (skb->len < sizeof (struct rtl_80211_hdr_3addr  ))
+	if (skb->len < sizeof(struct rtl_80211_hdr_3addr))
 		return -1; /* corrupted */
 
-	memcpy(src,header->addr2, ETH_ALEN);
+	memcpy(src, header->addr2, ETH_ALEN);
 
 	skbend = (u8 *)skb->data + skb->len;
 
-	tag = skb->data + sizeof (struct rtl_80211_hdr_3addr  );
+	tag = skb->data + sizeof(struct rtl_80211_hdr_3addr);
 
-	while (tag+1 < skbend){
+	while (tag + 1 < skbend) {
 		if (*tag == 0) {
-			ssid = tag+2;
-			ssidlen = *(tag+1);
+			ssid = tag + 2;
+			ssidlen = *(tag + 1);
 			break;
 		}
 		tag++; /* point to the len field */
@@ -1611,11 +1551,12 @@ static short probe_rq_parse(struct ieee80211_device *ieee, struct sk_buff *skb,
 	}
 
 	//IEEE80211DMESG("Card MAC address is "MACSTR, MAC2STR(src));
-	if (ssidlen == 0) return 1;
+	if (ssidlen == 0)
+		return 1;
 
-	if (!ssid) return 1; /* ssid not found in tagged param */
+	if (!ssid)
+		return 1; /* ssid not found in tagged param */
 	return (!strncmp(ssid, ieee->current_network.ssid, ssidlen));
-
 }
 
 static int assoc_rq_parse(struct sk_buff *skb, u8 *dest)
@@ -1623,15 +1564,14 @@ static int assoc_rq_parse(struct sk_buff *skb, u8 *dest)
 	struct ieee80211_assoc_request_frame *a;
 
 	if (skb->len < (sizeof(struct ieee80211_assoc_request_frame) -
-		sizeof(struct ieee80211_info_element))) {
-
-		IEEE80211_DEBUG_MGMT("invalid len in auth request:%d \n", skb->len);
+			sizeof(struct ieee80211_info_element))) {
+		IEEE80211_DEBUG_MGMT("invalid len in auth request:%d\n", skb->len);
 		return -1;
 	}
 
-	a = (struct ieee80211_assoc_request_frame *) skb->data;
+	a = (struct ieee80211_assoc_request_frame *)skb->data;
 
-	memcpy(dest,a->header.addr2,ETH_ALEN);
+	memcpy(dest, a->header.addr2, ETH_ALEN);
 
 	return 0;
 }
@@ -1646,18 +1586,17 @@ static inline u16 assoc_parse(struct ieee80211_device *ieee, struct sk_buff *skb
 		return 0xcafe;
 	}
 
-	response_head = (struct ieee80211_assoc_response_frame *) skb->data;
+	response_head = (struct ieee80211_assoc_response_frame *)skb->data;
 	*aid = le16_to_cpu(response_head->aid) & 0x3fff;
 
 	status_code = le16_to_cpu(response_head->status);
-	if((status_code==WLAN_STATUS_ASSOC_DENIED_RATES || \
-	   status_code==WLAN_STATUS_CAPS_UNSUPPORTED)&&
-	   ((ieee->mode == IEEE_G) &&
-	    (ieee->current_network.mode == IEEE_N_24G) &&
-	    (ieee->AsocRetryCount++ < (RT_ASOC_RETRY_LIMIT-1)))) {
-		 ieee->pHTInfo->IOTAction |= HT_IOT_ACT_PURE_N_MODE;
-	}else {
-		 ieee->AsocRetryCount = 0;
+	if ((status_code == WLAN_STATUS_ASSOC_DENIED_RATES || status_code == WLAN_STATUS_CAPS_UNSUPPORTED) &&
+	    ((ieee->mode == IEEE_G) &&
+	     (ieee->current_network.mode == IEEE_N_24G) &&
+	     (ieee->AsocRetryCount++ < (RT_ASOC_RETRY_LIMIT - 1)))) {
+		ieee->pHTInfo->IOTAction |= HT_IOT_ACT_PURE_N_MODE;
+	} else {
+		ieee->AsocRetryCount = 0;
 	}
 
 	return le16_to_cpu(response_head->status);
@@ -1687,39 +1626,35 @@ ieee80211_rx_auth_rq(struct ieee80211_device *ieee, struct sk_buff *skb)
 	ieee->softmac_stats.rx_auth_rq++;
 
 	status = auth_rq_parse(skb, dest);
-	if (status != -1) {
+	if (status != -1)
 		ieee80211_resp_to_auth(ieee, status, dest);
-	}
-	//DMESG("Dest is "MACSTR, MAC2STR(dest));
 
+	//DMESG("Dest is "MACSTR, MAC2STR(dest));
 }
 
 static inline void
 ieee80211_rx_assoc_rq(struct ieee80211_device *ieee, struct sk_buff *skb)
 {
-
 	u8 dest[ETH_ALEN];
 	//unsigned long flags;
 
 	ieee->softmac_stats.rx_ass_rq++;
-	if (assoc_rq_parse(skb, dest) != -1) {
+	if (assoc_rq_parse(skb, dest) != -1)
 		ieee80211_resp_to_assoc_rq(ieee, dest);
-	}
 
-	printk(KERN_INFO"New client associated: %pM\n", dest);
+	printk(KERN_INFO "New client associated: %pM\n", dest);
 	//FIXME
 }
 
 static void ieee80211_sta_ps_send_null_frame(struct ieee80211_device *ieee,
 					     short pwr)
 {
-
 	struct sk_buff *buf = ieee80211_null_func(ieee, pwr);
 
 	if (buf)
 		softmac_ps_mgmt_xmit(buf, ieee);
-
 }
+
 /* EXPORT_SYMBOL(ieee80211_sta_ps_send_null_frame); */
 
 static short ieee80211_sta_ps_sleep(struct ieee80211_device *ieee, u32 *time_h,
@@ -1727,6 +1662,7 @@ static short ieee80211_sta_ps_sleep(struct ieee80211_device *ieee, u32 *time_h,
 {
 	int timeout;
 	u8 dtim;
+
 	/*if(ieee->ps == IEEE80211_PS_DISABLED ||
 		ieee->iw_mode != IW_MODE_INFRA ||
 		ieee->state != IEEE80211_LINKED)
@@ -1734,46 +1670,43 @@ static short ieee80211_sta_ps_sleep(struct ieee80211_device *ieee, u32 *time_h,
 		return 0;
 	*/
 	dtim = ieee->current_network.dtim_data;
-	if(!(dtim & IEEE80211_DTIM_VALID))
+	if (!(dtim & IEEE80211_DTIM_VALID))
 		return 0;
 	timeout = ieee->current_network.beacon_interval; //should we use ps_timeout value or beacon_interval
 	ieee->current_network.dtim_data = IEEE80211_DTIM_INVALID;
 
-	if(dtim & ((IEEE80211_DTIM_UCAST | IEEE80211_DTIM_MBCAST)& ieee->ps))
+	if (dtim & ((IEEE80211_DTIM_UCAST | IEEE80211_DTIM_MBCAST) & ieee->ps))
 		return 2;
 
-	if(!time_after(jiffies,
-		       dev_trans_start(ieee->dev) + msecs_to_jiffies(timeout)))
+	if (!time_after(jiffies,
+			dev_trans_start(ieee->dev) + msecs_to_jiffies(timeout)))
 		return 0;
 
-	if(!time_after(jiffies,
-		       ieee->last_rx_ps_time + msecs_to_jiffies(timeout)))
+	if (!time_after(jiffies,
+			ieee->last_rx_ps_time + msecs_to_jiffies(timeout)))
 		return 0;
 
-	if((ieee->softmac_features & IEEE_SOFTMAC_SINGLE_QUEUE ) &&
-		(ieee->mgmt_queue_tail != ieee->mgmt_queue_head))
+	if ((ieee->softmac_features & IEEE_SOFTMAC_SINGLE_QUEUE) &&
+	    (ieee->mgmt_queue_tail != ieee->mgmt_queue_head))
 		return 0;
 
 	if (time_l) {
 		*time_l = ieee->current_network.last_dtim_sta_time[0]
 			+ (ieee->current_network.beacon_interval
-			* ieee->current_network.dtim_period) * 1000;
+			   * ieee->current_network.dtim_period) * 1000;
 	}
 
 	if (time_h) {
 		*time_h = ieee->current_network.last_dtim_sta_time[1];
-		if(time_l && *time_l < ieee->current_network.last_dtim_sta_time[0])
+		if (time_l && *time_l < ieee->current_network.last_dtim_sta_time[0])
 			*time_h += 1;
 	}
 
 	return 1;
-
-
 }
 
 static inline void ieee80211_sta_ps(struct ieee80211_device *ieee)
 {
-
 	u32 th, tl;
 	short sleep;
 
@@ -1782,10 +1715,9 @@ static inline void ieee80211_sta_ps(struct ieee80211_device *ieee)
 	spin_lock_irqsave(&ieee->lock, flags);
 
 	if ((ieee->ps == IEEE80211_PS_DISABLED ||
-		ieee->iw_mode != IW_MODE_INFRA ||
-		ieee->state != IEEE80211_LINKED)){
-
-	//	#warning CHECK_LOCK_HERE
+	     ieee->iw_mode != IW_MODE_INFRA ||
+	     ieee->state != IEEE80211_LINKED)) {
+		//	#warning CHECK_LOCK_HERE
 		spin_lock_irqsave(&ieee->mgmt_tx_lock, flags2);
 
 		ieee80211_sta_wakeup(ieee, 1);
@@ -1793,23 +1725,19 @@ static inline void ieee80211_sta_ps(struct ieee80211_device *ieee)
 		spin_unlock_irqrestore(&ieee->mgmt_tx_lock, flags2);
 	}
 
-	sleep = ieee80211_sta_ps_sleep(ieee,&th, &tl);
+	sleep = ieee80211_sta_ps_sleep(ieee, &th, &tl);
 	/* 2 wake, 1 sleep, 0 do nothing */
-	if(sleep == 0)
+	if (sleep == 0)
 		goto out;
 
-	if(sleep == 1){
-
-		if(ieee->sta_sleep == 1)
+	if (sleep == 1) {
+		if (ieee->sta_sleep == 1) {
 			ieee->enter_sleep_state(ieee->dev, th, tl);
-
-		else if(ieee->sta_sleep == 0){
+		} else if (ieee->sta_sleep == 0) {
 		//	printk("send null 1\n");
 			spin_lock_irqsave(&ieee->mgmt_tx_lock, flags2);
 
-			if(ieee->ps_is_queue_empty(ieee->dev)){
-
-
+			if (ieee->ps_is_queue_empty(ieee->dev)) {
 				ieee->sta_sleep = 2;
 
 				ieee->ps_request_tx_ack(ieee->dev);
@@ -1820,11 +1748,8 @@ static inline void ieee80211_sta_ps(struct ieee80211_device *ieee)
 				ieee->ps_tl = tl;
 			}
 			spin_unlock_irqrestore(&ieee->mgmt_tx_lock, flags2);
-
 		}
-
-
-	}else if(sleep == 2){
+	} else if (sleep == 2) {
 //#warning CHECK_LOCK_HERE
 		spin_lock_irqsave(&ieee->mgmt_tx_lock, flags2);
 
@@ -1835,7 +1760,6 @@ static inline void ieee80211_sta_ps(struct ieee80211_device *ieee)
 
 out:
 	spin_unlock_irqrestore(&ieee->lock, flags);
-
 }
 
 void ieee80211_sta_wakeup(struct ieee80211_device *ieee, short nl)
@@ -1847,10 +1771,9 @@ void ieee80211_sta_wakeup(struct ieee80211_device *ieee, short nl)
 			ieee80211_sta_ps_send_null_frame(ieee, 0);
 		}
 		return;
-
 	}
 
-	if(ieee->sta_sleep == 1)
+	if (ieee->sta_sleep == 1)
 		ieee->sta_wake_up(ieee->dev);
 
 	ieee->sta_sleep = 0;
@@ -1867,18 +1790,17 @@ void ieee80211_ps_tx_ack(struct ieee80211_device *ieee, short success)
 
 	spin_lock_irqsave(&ieee->lock, flags);
 
-	if(ieee->sta_sleep == 2){
+	if (ieee->sta_sleep == 2) {
 		/* Null frame with PS bit set */
 		if (success) {
 			ieee->sta_sleep = 1;
-			ieee->enter_sleep_state(ieee->dev,ieee->ps_th,ieee->ps_tl);
+			ieee->enter_sleep_state(ieee->dev, ieee->ps_th, ieee->ps_tl);
 		}
 		/* if the card report not success we can't be sure the AP
 		 * has not RXed so we can't assume the AP believe us awake
 		 */
-	}
-	/* 21112005 - tx again null without PS bit if lost */
-	else {
+	} else {
+		/* 21112005 - tx again null without PS bit if lost */
 
 		if ((ieee->sta_sleep == 0) && !success) {
 			spin_lock_irqsave(&ieee->mgmt_tx_lock, flags2);
@@ -1897,13 +1819,12 @@ static void ieee80211_process_action(struct ieee80211_device *ieee,
 	u8 *act = ieee80211_get_payload(header);
 	u8 tmp = 0;
 //	IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA|IEEE80211_DL_BA, skb->data, skb->len);
-	if (act == NULL)
-	{
+	if (act == NULL) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "error to get payload of action frame\n");
 		return;
 	}
 	tmp = *act;
-	act ++;
+	act++;
 	switch (tmp) {
 	case ACT_CAT_BA:
 		if (*act == ACT_ADDBAREQ)
@@ -1917,7 +1838,6 @@ static void ieee80211_process_action(struct ieee80211_device *ieee,
 		break;
 	}
 	return;
-
 }
 
 static void ieee80211_check_auth_response(struct ieee80211_device *ieee,
@@ -1947,8 +1867,8 @@ static void ieee80211_check_auth_response(struct ieee80211_device *ieee,
 						bHalfSupportNmode = false;
 					}
 					netdev_dbg(ieee->dev, "SEC(%d, %d)\n",
-							bSupportNmode,
-							bHalfSupportNmode);
+						   bSupportNmode,
+						   bHalfSupportNmode);
 				}
 			}
 			/* Dummy wirless mode setting- avoid encryption issue */
@@ -1962,12 +1882,12 @@ static void ieee80211_check_auth_response(struct ieee80211_device *ieee,
 			}
 
 			if (ieee->current_network.mode == IEEE_N_24G &&
-					bHalfSupportNmode) {
+			    bHalfSupportNmode) {
 				netdev_dbg(ieee->dev, "enter half N mode\n");
 				ieee->bHalfWirelessN24GMode = true;
-			} else
+			} else {
 				ieee->bHalfWirelessN24GMode = false;
-
+			}
 			ieee80211_associate_step2(ieee);
 		} else {
 			ieee80211_auth_challenge(ieee, challenge, chlen);
@@ -1981,44 +1901,41 @@ static void ieee80211_check_auth_response(struct ieee80211_device *ieee,
 
 inline int
 ieee80211_rx_frame_softmac(struct ieee80211_device *ieee, struct sk_buff *skb,
-			struct ieee80211_rx_stats *rx_stats, u16 type,
-			u16 stype)
+			   struct ieee80211_rx_stats *rx_stats, u16 type,
+			   u16 stype)
 {
-	struct rtl_80211_hdr_3addr *header = (struct rtl_80211_hdr_3addr *) skb->data;
+	struct rtl_80211_hdr_3addr *header = (struct rtl_80211_hdr_3addr *)skb->data;
 	u16 errcode;
 	int aid;
 	struct ieee80211_assoc_response_frame *assoc_resp;
 //	struct ieee80211_info_element *info_element;
 
-	if(!ieee->proto_started)
+	if (!ieee->proto_started)
 		return 0;
 
-	if(ieee->sta_sleep || (ieee->ps != IEEE80211_PS_DISABLED &&
-		ieee->iw_mode == IW_MODE_INFRA &&
-		ieee->state == IEEE80211_LINKED))
-
+	if (ieee->sta_sleep || (ieee->ps != IEEE80211_PS_DISABLED &&
+				ieee->iw_mode == IW_MODE_INFRA &&
+				ieee->state == IEEE80211_LINKED))
 		tasklet_schedule(&ieee->ps_task);
 
-	if(WLAN_FC_GET_STYPE(header->frame_ctl) != IEEE80211_STYPE_PROBE_RESP &&
-		WLAN_FC_GET_STYPE(header->frame_ctl) != IEEE80211_STYPE_BEACON)
+	if (WLAN_FC_GET_STYPE(header->frame_ctl) != IEEE80211_STYPE_PROBE_RESP &&
+	    WLAN_FC_GET_STYPE(header->frame_ctl) != IEEE80211_STYPE_BEACON)
 		ieee->last_rx_ps_time = jiffies;
 
 	switch (WLAN_FC_GET_STYPE(header->frame_ctl)) {
-
 	case IEEE80211_STYPE_ASSOC_RESP:
 	case IEEE80211_STYPE_REASSOC_RESP:
-
 		IEEE80211_DEBUG_MGMT("received [RE]ASSOCIATION RESPONSE (%d)\n",
-				WLAN_FC_GET_STYPE(header->frame_ctl));
+				     WLAN_FC_GET_STYPE(header->frame_ctl));
 		if ((ieee->softmac_features & IEEE_SOFTMAC_ASSOCIATE) &&
-			ieee->state == IEEE80211_ASSOCIATING_AUTHENTICATED &&
-			ieee->iw_mode == IW_MODE_INFRA){
+		    ieee->state == IEEE80211_ASSOCIATING_AUTHENTICATED &&
+		    ieee->iw_mode == IW_MODE_INFRA) {
 			struct ieee80211_network network_resp;
 			struct ieee80211_network *network = &network_resp;
 
 			errcode = assoc_parse(ieee, skb, &aid);
 			if (!errcode) {
-				ieee->state=IEEE80211_LINKED;
+				ieee->state = IEEE80211_LINKED;
 				ieee->assoc_id = aid;
 				ieee->softmac_stats.rx_ass_ok++;
 				/* station support qos */
@@ -2026,13 +1943,14 @@ ieee80211_rx_frame_softmac(struct ieee80211_device *ieee, struct sk_buff *skb,
 				if (ieee->qos_support) {
 					assoc_resp = (struct ieee80211_assoc_response_frame *)skb->data;
 					memset(network, 0, sizeof(*network));
-					if (ieee80211_parse_info_param(ieee,assoc_resp->info_element,\
-								rx_stats->len - sizeof(*assoc_resp),\
-								network,rx_stats)){
+					if (ieee80211_parse_info_param(ieee,
+								       assoc_resp->info_element,
+								       rx_stats->len - sizeof(*assoc_resp),
+								       network,
+								       rx_stats)) {
 						return 1;
-					}
-					else
-					{	//filling the PeerHTCap. //maybe not necessary as we can get its info from current_network.
+					} else {
+						//filling the PeerHTCap. //maybe not necessary as we can get its info from current_network.
 						memcpy(ieee->pHTInfo->PeerHTCapBuf, network->bssht.bdHTCapBuf, network->bssht.bdHTCapLen);
 						memcpy(ieee->pHTInfo->PeerHTInfoBuf, network->bssht.bdHTInfoBuf, network->bssht.bdHTInfoLen);
 					}
@@ -2043,36 +1961,29 @@ ieee80211_rx_frame_softmac(struct ieee80211_device *ieee, struct sk_buff *skb,
 			} else {
 				/* aid could not been allocated */
 				ieee->softmac_stats.rx_ass_err++;
-				printk(
-					"Association response status code 0x%x\n",
-					errcode);
-				IEEE80211_DEBUG_MGMT(
-					"Association response status code 0x%x\n",
-					errcode);
-				if(ieee->AsocRetryCount < RT_ASOC_RETRY_LIMIT) {
+				printk("Association response status code 0x%x\n",
+				       errcode);
+				IEEE80211_DEBUG_MGMT("Association response status code 0x%x\n",
+						     errcode);
+				if (ieee->AsocRetryCount < RT_ASOC_RETRY_LIMIT)
 					schedule_work(&ieee->associate_procedure_wq);
-				} else {
+				else
 					ieee80211_associate_abort(ieee);
-				}
 			}
 		}
 		break;
 
 	case IEEE80211_STYPE_ASSOC_REQ:
 	case IEEE80211_STYPE_REASSOC_REQ:
-
 		if ((ieee->softmac_features & IEEE_SOFTMAC_ASSOCIATE) &&
-			ieee->iw_mode == IW_MODE_MASTER)
-
+		    ieee->iw_mode == IW_MODE_MASTER)
 			ieee80211_rx_assoc_rq(ieee, skb);
 		break;
 
 	case IEEE80211_STYPE_AUTH:
-
 		if (ieee->softmac_features & IEEE_SOFTMAC_ASSOCIATE) {
-			if (ieee->state == IEEE80211_ASSOCIATING_AUTHENTICATING
-				&& ieee->iw_mode == IW_MODE_INFRA) {
-
+			if (ieee->state == IEEE80211_ASSOCIATING_AUTHENTICATING &&
+			    ieee->iw_mode == IW_MODE_INFRA) {
 				IEEE80211_DEBUG_MGMT("Received auth response");
 				ieee80211_check_auth_response(ieee, skb);
 			} else if (ieee->iw_mode == IW_MODE_MASTER) {
@@ -2082,11 +1993,10 @@ ieee80211_rx_frame_softmac(struct ieee80211_device *ieee, struct sk_buff *skb,
 		break;
 
 	case IEEE80211_STYPE_PROBE_REQ:
-
 		if ((ieee->softmac_features & IEEE_SOFTMAC_PROBERS) &&
-			((ieee->iw_mode == IW_MODE_ADHOC ||
-			ieee->iw_mode == IW_MODE_MASTER) &&
-			ieee->state == IEEE80211_LINKED)){
+		    ((ieee->iw_mode == IW_MODE_ADHOC ||
+		      ieee->iw_mode == IW_MODE_MASTER) &&
+		     ieee->state == IEEE80211_LINKED)){
 			ieee80211_rx_probe_rq(ieee, skb);
 		}
 		break;
@@ -2097,9 +2007,8 @@ ieee80211_rx_frame_softmac(struct ieee80211_device *ieee, struct sk_buff *skb,
 		* both for disassociation and deauthentication
 		*/
 		if ((ieee->softmac_features & IEEE_SOFTMAC_ASSOCIATE) &&
-			ieee->state == IEEE80211_LINKED &&
-			ieee->iw_mode == IW_MODE_INFRA){
-
+		    ieee->state == IEEE80211_LINKED &&
+		    ieee->iw_mode == IW_MODE_INFRA){
 			ieee->state = IEEE80211_ASSOCIATING;
 			ieee->softmac_stats.reassoc++;
 
@@ -2140,7 +2049,6 @@ ieee80211_rx_frame_softmac(struct ieee80211_device *ieee, struct sk_buff *skb,
  */
 void ieee80211_softmac_xmit(struct ieee80211_txb *txb, struct ieee80211_device *ieee)
 {
-
 	unsigned int queue_index = txb->queue_index;
 	unsigned long flags;
 	int  i;
@@ -2155,18 +2063,18 @@ void ieee80211_softmac_xmit(struct ieee80211_txb *txb, struct ieee80211_device *
 	ieee->stats.tx_bytes += le16_to_cpu(txb->payload_size);
 	ieee->stats.tx_packets++;
 	tcb_desc = (struct cb_desc *)(txb->fragments[0]->cb + MAX_DEV_ADDR_SIZE);
-	if (tcb_desc->bMulticast) {
+	if (tcb_desc->bMulticast)
 		ieee->stats.multicast++;
-	}
+
 	/* if xmit available, just xmit it immediately, else just insert it to the wait queue */
-	for(i = 0; i < txb->nr_frags; i++) {
+	for (i = 0; i < txb->nr_frags; i++) {
 #ifdef USB_TX_DRIVER_AGGREGATION_ENABLE
 		if ((skb_queue_len(&ieee->skb_drv_aggQ[queue_index]) != 0) ||
 #else
 		if ((skb_queue_len(&ieee->skb_waitQ[queue_index]) != 0) ||
 #endif
-		(!ieee->check_nic_enough_desc(ieee->dev,queue_index))||\
-		     (ieee->queue_stop)) {
+		    (!ieee->check_nic_enough_desc(ieee->dev, queue_index)) ||
+		    (ieee->queue_stop)) {
 			/* insert the skb packet to the wait queue */
 			/* as for the completion function, it does not need
 			 * to check it any more.
@@ -2178,10 +2086,9 @@ void ieee80211_softmac_xmit(struct ieee80211_txb *txb, struct ieee80211_device *
 #else
 			skb_queue_tail(&ieee->skb_waitQ[queue_index], txb->fragments[i]);
 #endif
-		}else{
-			ieee->softmac_data_hard_start_xmit(
-					txb->fragments[i],
-					ieee->dev, ieee->rate);
+		} else {
+			ieee->softmac_data_hard_start_xmit(txb->fragments[i],
+							   ieee->dev, ieee->rate);
 			//ieee->stats.tx_packets++;
 			//ieee->stats.tx_bytes += txb->fragments[i]->len;
 			//ieee->dev->trans_start = jiffies;
@@ -2191,7 +2098,6 @@ void ieee80211_softmac_xmit(struct ieee80211_txb *txb, struct ieee80211_device *
 
 //exit:
 	spin_unlock_irqrestore(&ieee->lock, flags);
-
 }
 EXPORT_SYMBOL(ieee80211_softmac_xmit);
 
@@ -2199,28 +2105,24 @@ EXPORT_SYMBOL(ieee80211_softmac_xmit);
 static void ieee80211_resume_tx(struct ieee80211_device *ieee)
 {
 	int i;
-	for(i = ieee->tx_pending.frag; i < ieee->tx_pending.txb->nr_frags; i++) {
 
-		if (ieee->queue_stop){
+	for (i = ieee->tx_pending.frag; i < ieee->tx_pending.txb->nr_frags; i++) {
+		if (ieee->queue_stop) {
 			ieee->tx_pending.frag = i;
 			return;
-		}else{
-
-			ieee->softmac_data_hard_start_xmit(
-				ieee->tx_pending.txb->fragments[i],
-				ieee->dev, ieee->rate);
-				//(i+1)<ieee->tx_pending.txb->nr_frags);
+		} else {
+			ieee->softmac_data_hard_start_xmit(ieee->tx_pending.txb->fragments[i],
+							   ieee->dev, ieee->rate);
+			//(i+1)<ieee->tx_pending.txb->nr_frags);
 			ieee->stats.tx_packets++;
 			netif_trans_update(ieee->dev);
 		}
 	}
 
-
 	ieee80211_txb_free(ieee->tx_pending.txb);
 	ieee->tx_pending.txb = NULL;
 }
 
-
 void ieee80211_reset_queue(struct ieee80211_device *ieee)
 {
 	unsigned long flags;
@@ -2233,26 +2135,24 @@ void ieee80211_reset_queue(struct ieee80211_device *ieee)
 	}
 	ieee->queue_stop = 0;
 	spin_unlock_irqrestore(&ieee->lock, flags);
-
 }
 EXPORT_SYMBOL(ieee80211_reset_queue);
 
 void ieee80211_wake_queue(struct ieee80211_device *ieee)
 {
-
 	unsigned long flags;
 	struct sk_buff *skb;
 	struct rtl_80211_hdr_3addr  *header;
 
 	spin_lock_irqsave(&ieee->lock, flags);
-	if (! ieee->queue_stop) goto exit;
+	if (!ieee->queue_stop)
+		goto exit;
 
 	ieee->queue_stop = 0;
 
 	if (ieee->softmac_features & IEEE_SOFTMAC_SINGLE_QUEUE) {
-		while (!ieee->queue_stop && (skb = dequeue_mgmt(ieee))){
-
-			header = (struct rtl_80211_hdr_3addr  *) skb->data;
+		while (!ieee->queue_stop && (skb = dequeue_mgmt(ieee))) {
+			header = (struct rtl_80211_hdr_3addr  *)skb->data;
 
 			header->seq_ctl = cpu_to_le16(ieee->seq_ctrl[0] << 4);
 
@@ -2261,7 +2161,7 @@ void ieee80211_wake_queue(struct ieee80211_device *ieee)
 			else
 				ieee->seq_ctrl[0]++;
 
-			ieee->softmac_data_hard_start_xmit(skb,ieee->dev,ieee->basic_rate);
+			ieee->softmac_data_hard_start_xmit(skb, ieee->dev, ieee->basic_rate);
 			//dev_kfree_skb_any(skb);//edit by thomas
 		}
 	}
@@ -2273,9 +2173,10 @@ void ieee80211_wake_queue(struct ieee80211_device *ieee)
 		netif_wake_queue(ieee->dev);
 	}
 
-exit :
+exit:
 	spin_unlock_irqrestore(&ieee->lock, flags);
 }
+
 EXPORT_SYMBOL(ieee80211_wake_queue);
 
 void ieee80211_stop_queue(struct ieee80211_device *ieee)
@@ -2289,7 +2190,6 @@ void ieee80211_stop_queue(struct ieee80211_device *ieee)
 	}
 	ieee->queue_stop = 1;
 	//spin_unlock_irqrestore(&ieee->lock,flags);
-
 }
 EXPORT_SYMBOL(ieee80211_stop_queue);
 
@@ -2323,18 +2223,18 @@ void ieee80211_start_master_bss(struct ieee80211_device *ieee)
 static void ieee80211_start_monitor_mode(struct ieee80211_device *ieee)
 {
 	if (ieee->raw_tx) {
-
 		if (ieee->data_hard_resume)
 			ieee->data_hard_resume(ieee->dev);
 
 		netif_carrier_on(ieee->dev);
 	}
 }
+
 static void ieee80211_start_ibss_wq(struct work_struct *work)
 {
-
 	struct delayed_work *dwork = to_delayed_work(work);
 	struct ieee80211_device *ieee = container_of(dwork, struct ieee80211_device, start_ibss_wq);
+
 	/* iwconfig mode ad-hoc will schedule this and return
 	 * on the other hand this will block further iwconfig SET
 	 * operations because of the wx_mutex hold.
@@ -2357,7 +2257,6 @@ static void ieee80211_start_ibss_wq(struct work_struct *work)
 	/* check if we have this cell in our network list */
 	ieee80211_softmac_check_all_nets(ieee);
 
-
 //	if((IS_DOT11D_ENABLE(ieee)) && (ieee->state == IEEE80211_NOLINK))
 	if (ieee->state == IEEE80211_NOLINK)
 		ieee->current_network.channel = 6;
@@ -2381,22 +2280,21 @@ static void ieee80211_start_ibss_wq(struct work_struct *work)
 	/* the network definitively is not here.. create a new cell */
 	if (ieee->state == IEEE80211_NOLINK) {
 		printk("creating new IBSS cell\n");
-		if(!ieee->wap_set)
+		if (!ieee->wap_set)
 			eth_random_addr(ieee->current_network.bssid);
 
-		if(ieee->modulation & IEEE80211_CCK_MODULATION){
-
+		if (ieee->modulation & IEEE80211_CCK_MODULATION) {
 			ieee->current_network.rates_len = 4;
 
 			ieee->current_network.rates[0] = IEEE80211_BASIC_RATE_MASK | IEEE80211_CCK_RATE_1MB;
 			ieee->current_network.rates[1] = IEEE80211_BASIC_RATE_MASK | IEEE80211_CCK_RATE_2MB;
 			ieee->current_network.rates[2] = IEEE80211_BASIC_RATE_MASK | IEEE80211_CCK_RATE_5MB;
 			ieee->current_network.rates[3] = IEEE80211_BASIC_RATE_MASK | IEEE80211_CCK_RATE_11MB;
-
-		}else
+		} else {
 			ieee->current_network.rates_len = 0;
+		}
 
-		if(ieee->modulation & IEEE80211_OFDM_MODULATION){
+		if (ieee->modulation & IEEE80211_OFDM_MODULATION) {
 			ieee->current_network.rates_ex_len = 8;
 
 			ieee->current_network.rates_ex[0] = IEEE80211_BASIC_RATE_MASK | IEEE80211_OFDM_RATE_6MB;
@@ -2409,7 +2307,7 @@ static void ieee80211_start_ibss_wq(struct work_struct *work)
 			ieee->current_network.rates_ex[7] = IEEE80211_BASIC_RATE_MASK | IEEE80211_OFDM_RATE_54MB;
 
 			ieee->rate = 108;
-		}else{
+		} else {
 			ieee->current_network.rates_ex_len = 0;
 			ieee->rate = 22;
 		}
@@ -2419,9 +2317,8 @@ static void ieee80211_start_ibss_wq(struct work_struct *work)
 		ieee->SetWirelessMode(ieee->dev, IEEE_G);
 		ieee->current_network.atim_window = 0;
 		ieee->current_network.capability = WLAN_CAPABILITY_IBSS;
-		if(ieee->short_slot)
+		if (ieee->short_slot)
 			ieee->current_network.capability |= WLAN_CAPABILITY_SHORT_SLOT;
-
 	}
 
 	ieee->state = IEEE80211_LINKED;
@@ -2453,12 +2350,9 @@ void ieee80211_start_bss(struct ieee80211_device *ieee)
 	// Ref: 802.11d 11.1.3.3
 	// STA shall not start a BSS unless properly formed Beacon frame including a Country IE.
 	//
-	if (IS_DOT11D_ENABLE(ieee) && !IS_COUNTRY_IE_VALID(ieee))
-	{
-		if (! ieee->bGlobalDomain)
-		{
+	if (IS_DOT11D_ENABLE(ieee) && !IS_COUNTRY_IE_VALID(ieee)) {
+		if (!ieee->bGlobalDomain)
 			return;
-		}
 	}
 	/* check if we have already found the net we
 	 * are interested in (if any).
@@ -2486,22 +2380,19 @@ void ieee80211_start_bss(struct ieee80211_device *ieee)
 /* called only in userspace context */
 void ieee80211_disassociate(struct ieee80211_device *ieee)
 {
-
-
 	netif_carrier_off(ieee->dev);
 	if (ieee->softmac_features & IEEE_SOFTMAC_TX_QUEUE)
-			ieee80211_reset_queue(ieee);
+		ieee80211_reset_queue(ieee);
 
 	if (ieee->data_hard_stop)
-			ieee->data_hard_stop(ieee->dev);
-	if(IS_DOT11D_ENABLE(ieee))
+		ieee->data_hard_stop(ieee->dev);
+	if (IS_DOT11D_ENABLE(ieee))
 		Dot11d_Reset(ieee);
 	ieee->state = IEEE80211_NOLINK;
 	ieee->is_set_key = false;
 	ieee->link_change(ieee->dev);
 	//HTSetConnectBwMode(ieee, HT_CHANNEL_WIDTH_20, HT_EXTCHNL_OFFSET_NO_EXT);
 	notify_wx_assoc_event(ieee);
-
 }
 EXPORT_SYMBOL(ieee80211_disassociate);
 
@@ -2512,10 +2403,10 @@ static void ieee80211_associate_retry_wq(struct work_struct *work)
 	unsigned long flags;
 
 	mutex_lock(&ieee->wx_mutex);
-	if(!ieee->proto_started)
+	if (!ieee->proto_started)
 		goto exit;
 
-	if(ieee->state != IEEE80211_ASSOCIATING_RETRY)
+	if (ieee->state != IEEE80211_ASSOCIATING_RETRY)
 		goto exit;
 
 	/* until we do not set the state to IEEE80211_NOLINK
@@ -2537,7 +2428,7 @@ static void ieee80211_associate_retry_wq(struct work_struct *work)
 
 	spin_lock_irqsave(&ieee->lock, flags);
 
-	if(ieee->state == IEEE80211_NOLINK)
+	if (ieee->state == IEEE80211_NOLINK)
 		ieee80211_start_scan(ieee);
 
 	spin_unlock_irqrestore(&ieee->lock, flags);
@@ -2558,11 +2449,10 @@ struct sk_buff *ieee80211_get_beacon_(struct ieee80211_device *ieee)
 	if (!skb)
 		return NULL;
 
-	b = (struct ieee80211_probe_response *) skb->data;
+	b = (struct ieee80211_probe_response *)skb->data;
 	b->header.frame_ctl = cpu_to_le16(IEEE80211_STYPE_BEACON);
 
 	return skb;
-
 }
 
 struct sk_buff *ieee80211_get_beacon(struct ieee80211_device *ieee)
@@ -2571,10 +2461,10 @@ struct sk_buff *ieee80211_get_beacon(struct ieee80211_device *ieee)
 	struct ieee80211_probe_response *b;
 
 	skb = ieee80211_get_beacon_(ieee);
-	if(!skb)
+	if (!skb)
 		return NULL;
 
-	b = (struct ieee80211_probe_response *) skb->data;
+	b = (struct ieee80211_probe_response *)skb->data;
 	b->header.seq_ctl = cpu_to_le16(ieee->seq_ctrl[0] << 4);
 
 	if (ieee->seq_ctrl[0] == 0xFFF)
@@ -2632,11 +2522,11 @@ void ieee80211_start_protocol(struct ieee80211_device *ieee)
 	ieee->proto_started = 1;
 
 	if (ieee->current_network.channel == 0) {
-		do{
+		do {
 			ch++;
 			if (ch > MAX_CHANNEL_NUMBER)
 				return; /* no channel found */
-		}while(!GET_DOT11D_INFO(ieee)->channel_map[ch]);
+		} while (!GET_DOT11D_INFO(ieee)->channel_map[ch]);
 		ieee->current_network.channel = ch;
 	}
 
@@ -2645,15 +2535,14 @@ void ieee80211_start_protocol(struct ieee80211_device *ieee)
 //	printk("===>%s(), chan:%d\n", __func__, ieee->current_network.channel);
 //	ieee->set_chan(ieee->dev,ieee->current_network.channel);
 
-	for(i = 0; i < 17; i++) {
-	  ieee->last_rxseq_num[i] = -1;
-	  ieee->last_rxfrag_num[i] = -1;
-	  ieee->last_packet_time[i] = 0;
+	for (i = 0; i < 17; i++) {
+		ieee->last_rxseq_num[i] = -1;
+		ieee->last_rxfrag_num[i] = -1;
+		ieee->last_packet_time[i] = 0;
 	}
 
 	ieee->init_wmmparam_flag = 0;//reinitialize AC_xx_PARAM registers.
 
-
 	/* if the user set the MAC of the ad-hoc cell and then
 	 * switch to managed mode, shall we  make sure that association
 	 * attempts does not fail just because the user provide the essid
@@ -2668,29 +2557,29 @@ void ieee80211_start_protocol(struct ieee80211_device *ieee)
 	else if (ieee->iw_mode == IW_MODE_MASTER)
 		ieee80211_start_master_bss(ieee);
 
-	else if(ieee->iw_mode == IW_MODE_MONITOR)
+	else if (ieee->iw_mode == IW_MODE_MONITOR)
 		ieee80211_start_monitor_mode(ieee);
 }
 
-
 #define DRV_NAME  "Ieee80211"
 void ieee80211_softmac_init(struct ieee80211_device *ieee)
 {
 	int i;
+
 	memset(&ieee->current_network, 0, sizeof(struct ieee80211_network));
 
 	ieee->state = IEEE80211_NOLINK;
 	ieee->sync_scan_hurryup = 0;
-	for(i = 0; i < 5; i++) {
-	  ieee->seq_ctrl[i] = 0;
-	}
+	for (i = 0; i < 5; i++)
+		ieee->seq_ctrl[i] = 0;
+
 	ieee->pDot11dInfo = kzalloc(sizeof(RT_DOT11D_INFO), GFP_KERNEL);
 	if (!ieee->pDot11dInfo)
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "can't alloc memory for DOT11D\n");
 	//added for  AP roaming
 	ieee->LinkDetectInfo.SlotNum = 2;
-	ieee->LinkDetectInfo.NumRecvBcnInPeriod=0;
-	ieee->LinkDetectInfo.NumRecvDataInPeriod=0;
+	ieee->LinkDetectInfo.NumRecvBcnInPeriod = 0;
+	ieee->LinkDetectInfo.NumRecvDataInPeriod = 0;
 
 	ieee->assoc_id = 0;
 	ieee->queue_stop = 0;
@@ -2703,9 +2592,9 @@ void ieee80211_softmac_init(struct ieee80211_device *ieee)
 	ieee->rate = 22;
 	ieee->ps = IEEE80211_PS_DISABLED;
 	ieee->sta_sleep = 0;
-	ieee->Regdot11HTOperationalRateSet[0]= 0xff;//support MCS 0~7
-	ieee->Regdot11HTOperationalRateSet[1]= 0xff;//support MCS 8~15
-	ieee->Regdot11HTOperationalRateSet[4]= 0x01;
+	ieee->Regdot11HTOperationalRateSet[0] = 0xff;//support MCS 0~7
+	ieee->Regdot11HTOperationalRateSet[1] = 0xff;//support MCS 8~15
+	ieee->Regdot11HTOperationalRateSet[4] = 0x01;
 	//added by amy
 	ieee->actscanning = false;
 	ieee->beinretry = false;
@@ -2724,7 +2613,6 @@ void ieee80211_softmac_init(struct ieee80211_device *ieee)
 
 	timer_setup(&ieee->beacon_timer, ieee80211_send_beacon_cb, 0);
 
-
 	INIT_DELAYED_WORK(&ieee->start_ibss_wq, ieee80211_start_ibss_wq);
 	INIT_WORK(&ieee->associate_complete_wq, ieee80211_associate_complete_wq);
 	INIT_WORK(&ieee->associate_procedure_wq, ieee80211_associate_procedure_wq);
@@ -2732,7 +2620,6 @@ void ieee80211_softmac_init(struct ieee80211_device *ieee)
 	INIT_DELAYED_WORK(&ieee->associate_retry_wq, ieee80211_associate_retry_wq);
 	INIT_WORK(&ieee->wx_sync_scan_wq, ieee80211_wx_sync_scan_wq);
 
-
 	mutex_init(&ieee->wx_mutex);
 	mutex_init(&ieee->scan_mutex);
 
@@ -2740,9 +2627,8 @@ void ieee80211_softmac_init(struct ieee80211_device *ieee)
 	spin_lock_init(&ieee->beacon_lock);
 
 	tasklet_init(&ieee->ps_task,
-	     (void(*)(unsigned long)) ieee80211_sta_ps,
-	     (unsigned long)ieee);
-
+		     (void(*)(unsigned long)) ieee80211_sta_ps,
+		     (unsigned long)ieee);
 }
 
 void ieee80211_softmac_free(struct ieee80211_device *ieee)
@@ -2762,7 +2648,6 @@ void ieee80211_softmac_free(struct ieee80211_device *ieee)
  * this is stolen from the ipw2200 driver               *
  ********************************************************/
 
-
 static int ieee80211_wpa_enable(struct ieee80211_device *ieee, int value)
 {
 	/* This is called when wpa_supplicant loads and closes the driver
@@ -2772,7 +2657,6 @@ static int ieee80211_wpa_enable(struct ieee80211_device *ieee, int value)
 	return 0;
 }
 
-
 static void ieee80211_wpa_assoc_frame(struct ieee80211_device *ieee,
 				      char *wpa_ie, int wpa_ie_len)
 {
@@ -2782,10 +2666,8 @@ static void ieee80211_wpa_assoc_frame(struct ieee80211_device *ieee,
 	ieee80211_disassociate(ieee);
 }
 
-
 static int ieee80211_wpa_mlme(struct ieee80211_device *ieee, int command, int reason)
 {
-
 	int ret = 0;
 
 	switch (command) {
@@ -2805,9 +2687,8 @@ static int ieee80211_wpa_mlme(struct ieee80211_device *ieee, int command, int re
 	return ret;
 }
 
-
 static int ieee80211_wpa_set_wpa_ie(struct ieee80211_device *ieee,
-			      struct ieee_param *param, int plen)
+				    struct ieee_param *param, int plen)
 {
 	u8 *buf;
 
@@ -2839,7 +2720,6 @@ static int ieee80211_wpa_set_wpa_ie(struct ieee80211_device *ieee,
 
 static int ieee80211_wpa_set_auth_algs(struct ieee80211_device *ieee, int value)
 {
-
 	struct ieee80211_security sec = {
 		.flags = SEC_AUTH_MODE,
 	};
@@ -2848,18 +2728,16 @@ static int ieee80211_wpa_set_auth_algs(struct ieee80211_device *ieee, int value)
 		sec.auth_mode = WLAN_AUTH_SHARED_KEY;
 		ieee->open_wep = 0;
 		ieee->auth_mode = 1;
-	} else if (value & AUTH_ALG_OPEN_SYSTEM){
+	} else if (value & AUTH_ALG_OPEN_SYSTEM) {
 		sec.auth_mode = WLAN_AUTH_OPEN;
 		ieee->open_wep = 1;
 		ieee->auth_mode = 0;
-	}
-	else if (value & IW_AUTH_ALG_LEAP){
+	} else if (value & IW_AUTH_ALG_LEAP) {
 		sec.auth_mode = WLAN_AUTH_LEAP;
 		ieee->open_wep = 1;
 		ieee->auth_mode = 2;
 	}
 
-
 	if (ieee->set_security)
 		ieee->set_security(ieee->dev, &sec);
 	//else
@@ -2905,8 +2783,7 @@ static int ieee80211_wpa_set_param(struct ieee80211_device *ieee, u8 name, u32 v
 		if (!value) {
 			sec.flags |= SEC_LEVEL;
 			sec.level = SEC_LEVEL_0;
-		}
-		else {
+		} else {
 			sec.flags |= SEC_LEVEL;
 			sec.level = SEC_LEVEL_1;
 		}
@@ -2945,7 +2822,7 @@ static int ieee80211_wpa_set_param(struct ieee80211_device *ieee, u8 name, u32 v
 /* implementation borrowed from hostap driver */
 
 static int ieee80211_wpa_set_encryption(struct ieee80211_device *ieee,
-				  struct ieee_param *param, int param_len)
+					struct ieee_param *param, int param_len)
 {
 	int ret = 0;
 	const char *module = NULL;
@@ -2961,10 +2838,10 @@ static int ieee80211_wpa_set_encryption(struct ieee80211_device *ieee,
 	param->u.crypt.alg[IEEE_CRYPT_ALG_NAME_LEN - 1] = '\0';
 
 	if (param_len !=
-	    (int) ((char *) param->u.crypt.key - (char *) param) +
+	    (int) ((char *)param->u.crypt.key - (char *)param) +
 	    param->u.crypt.key_len) {
 		printk("Len mismatch %d, %d\n", param_len,
-			       param->u.crypt.key_len);
+		       param->u.crypt.key_len);
 		return -EINVAL;
 	}
 	if (is_broadcast_ether_addr(param->sta_addr)) {
@@ -3053,9 +2930,9 @@ static int ieee80211_wpa_set_encryption(struct ieee80211_device *ieee,
 		ieee->tx_keyidx = param->u.crypt.idx;
 		sec.active_key = param->u.crypt.idx;
 		sec.flags |= SEC_ACTIVE_KEY;
-	} else
+	} else {
 		sec.flags &= ~SEC_ACTIVE_KEY;
-
+	}
 	memcpy(sec.keys[param->u.crypt.idx],
 	       param->u.crypt.key,
 	       param->u.crypt.key_len);
@@ -3093,10 +2970,9 @@ static int ieee80211_wpa_set_encryption(struct ieee80211_device *ieee,
 	return ret;
 }
 
-static inline struct sk_buff *ieee80211_disassociate_skb(
-							struct ieee80211_network *beacon,
-							struct ieee80211_device *ieee,
-							u8	asRsn)
+static inline struct sk_buff *ieee80211_disassociate_skb(struct ieee80211_network *beacon,
+							 struct ieee80211_device *ieee,
+							 u8	asRsn)
 {
 	struct sk_buff *skb;
 	struct ieee80211_disassoc *disass;
@@ -3117,22 +2993,18 @@ static inline struct sk_buff *ieee80211_disassociate_skb(
 	return skb;
 }
 
-
-void
-SendDisassociation(
-		struct ieee80211_device *ieee,
-		u8					*asSta,
-		u8						asRsn
-)
+void SendDisassociation(struct ieee80211_device *ieee,
+			u8			*asSta,
+			u8			asRsn)
 {
-		struct ieee80211_network *beacon = &ieee->current_network;
-		struct sk_buff *skb;
+	struct ieee80211_network *beacon = &ieee->current_network;
+	struct sk_buff *skb;
 
-		skb = ieee80211_disassociate_skb(beacon, ieee, asRsn);
-		if (skb) {
-				softmac_mgmt_xmit(skb, ieee);
-				//dev_kfree_skb_any(skb);//edit by thomas
-		}
+	skb = ieee80211_disassociate_skb(beacon, ieee, asRsn);
+	if (skb) {
+		softmac_mgmt_xmit(skb, ieee);
+		//dev_kfree_skb_any(skb);//edit by thomas
+	}
 }
 EXPORT_SYMBOL(SendDisassociation);
 
@@ -3156,10 +3028,9 @@ int ieee80211_wpa_supplicant_ioctl(struct ieee80211_device *ieee, struct iw_poin
 	}
 
 	switch (param->cmd) {
-
 	case IEEE_CMD_SET_WPA_PARAM:
 		ret = ieee80211_wpa_set_param(ieee, param->u.wpa_param.name,
-					param->u.wpa_param.value);
+					      param->u.wpa_param.value);
 		break;
 
 	case IEEE_CMD_SET_WPA_IE:
@@ -3172,11 +3043,11 @@ int ieee80211_wpa_supplicant_ioctl(struct ieee80211_device *ieee, struct iw_poin
 
 	case IEEE_CMD_MLME:
 		ret = ieee80211_wpa_mlme(ieee, param->u.mlme.command,
-				   param->u.mlme.reason_code);
+					 param->u.mlme.reason_code);
 		break;
 
 	default:
-		printk("Unknown WPA supplicant request: %d\n",param->cmd);
+		printk("Unknown WPA supplicant request: %d\n", param->cmd);
 		ret = -EOPNOTSUPP;
 		break;
 	}
-- 
2.17.1

