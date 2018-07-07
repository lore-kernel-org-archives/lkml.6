Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B3CC6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 14:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E07E20862
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 14:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InNIRHqO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E07E20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932944AbeGGO5T (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 10:57:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45462 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753741AbeGGOzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 10:55:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id u7-v6so6727820wrn.12
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 07:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lM5UsR98WItOqTmhz40VHk0Fbt9OEoga+hFfidofplg=;
        b=InNIRHqOd988gtAZ95iIkiQtexBBBvfTcHm22h8G0y/UK+pXNyE93WtH/7U0Dk8LVm
         pP6orc16I4SSIGTknDzSqF7SNrvMVSIiPnaImwCqElWrIc357jGKR7LJD7DUtW6NUaqT
         QN+CYM7slDfyIB+nWfdt10XbMjSoJ59kZzVYVCh1c0KQgVxjoezr8SxS8UagXUfJF0vC
         Ca0T909ibzAFXYgHzAQoXy8s36w0lp1JedUJxDqaHcTFm/aGJUmXHVOOF+JqtYNZKFHD
         e63ZQ/5JBUuMalvbc7x5ZYxBisqE4GG2UqXhdtnEkMwKIk3ULNT+6sTSp6nFvTgkkXBP
         BSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lM5UsR98WItOqTmhz40VHk0Fbt9OEoga+hFfidofplg=;
        b=iaSnvpv9I3DJcW9MhUdR9DlAzhAdK6i8772ULZekZkGVLdyi3bubsofBvESPsmyX5k
         eghzdXgQMfgPmK5tGNhP2yv9JVUsB9L4sf/abltVURXrrN+hogpJ/MOzkCV9W6LIiJ4E
         BLGRTkaMi8OeHoOi9Ae0VpoFSzn0iHtLEcE7RYTM2GP1RJaL98ZF7klNKl6cMoOC6jaa
         cor5N0d67fXwVyudImc9xHxVuHXpjlARneh76lPs2ckjUgXALfKPLw5sbzxia1iwYF80
         i+XEtQw7c5mUCG7TDAOgqNH91BVRe3q7BOxwSNJ2DA8FWPVg6eUWCVvBQLpFQuP0D8ey
         z3wA==
X-Gm-Message-State: APt69E1TrDHA1IHV0Ev5YfFv8L0DKozoVOc6TKhMrHc6iRkNjB7lq8s4
        LEVgtd7HbertMddUYSW3hJtfVg==
X-Google-Smtp-Source: AAOMgpeRguE0bJfMrTQ/tISFzvfNDJ4GcSylCrkXqm0qBrIdjOVv3467mCtM7W38tWwKWz9WKobaWQ==
X-Received: by 2002:a5d:4985:: with SMTP id r5-v6mr10480935wrq.116.1530975330991;
        Sat, 07 Jul 2018 07:55:30 -0700 (PDT)
Received: from localhost.localdomain (host81-152-164-58.range81-152.btcentralplus.com. [81.152.164.58])
        by smtp.gmail.com with ESMTPSA id 131-v6sm20714923wmm.31.2018.07.07.07.55.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Jul 2018 07:55:30 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        aastha.gupta4104@gmail.com, keescook@chromium.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 04/12] staging:rtl8192u: Add spaces required around operators - Coding Style
Date:   Sat,  7 Jul 2018 15:55:05 +0100
Message-Id: <20180707145513.15325-4-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180707145513.15325-1-johnfwhitmore@gmail.com>
References: <20180707145513.15325-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added the spaces, required by coding style, around the various operators.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../rtl8192u/ieee80211/ieee80211_softmac.c    | 124 +++++++++---------
 1 file changed, 62 insertions(+), 62 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index e046cc49f3d7..5ec74f9d61b2 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -108,7 +108,7 @@ static void ieee80211_WMM_Info(struct ieee80211_device *ieee, u8 **tag_p)
 	*tag++ = 0x01;
 #ifdef SUPPORT_USPD
 	if (ieee->current_network.wmm_info & 0x80) {
-		*tag++ = 0x0f|MAX_SP_Len;
+		*tag++ = 0x0f | MAX_SP_Len;
 	} else {
 		*tag++ = MAX_SP_Len;
 	}
@@ -142,7 +142,7 @@ static void enqueue_mgmt(struct ieee80211_device *ieee, struct sk_buff *skb)
 {
 	int nh;
 
-	nh = (ieee->mgmt_queue_head +1) % MGMT_QUEUE_NUM;
+	nh = (ieee->mgmt_queue_head + 1) % MGMT_QUEUE_NUM;
 
 /*
  * if the queue is full but we have newer frames then
@@ -167,7 +167,7 @@ static struct sk_buff *dequeue_mgmt(struct ieee80211_device *ieee)
 	ret = ieee->mgmt_queue_ring[ieee->mgmt_queue_tail];
 
 	ieee->mgmt_queue_tail =
-		(ieee->mgmt_queue_tail+1) % MGMT_QUEUE_NUM;
+		(ieee->mgmt_queue_tail + 1) % MGMT_QUEUE_NUM;
 
 	return ret;
 }
@@ -192,7 +192,7 @@ static u8 MgntQuery_MgntFrameTxRate(struct ieee80211_device *ieee)
 		/* 2005.01.26, by rcnjko. */
 		if (ieee->mode == IEEE_A ||
 		    ieee->mode == IEEE_N_5G ||
-		    (ieee->mode == IEEE_N_24G&&!pHTInfo->bCurSuppCCK))
+		    (ieee->mode == IEEE_N_24G && !pHTInfo->bCurSuppCCK))
 			rate = 0x0c;
 		else
 			rate = 0x02;
@@ -237,7 +237,7 @@ inline void softmac_mgmt_xmit(struct sk_buff *skb, struct ieee80211_device *ieee
 		if (ieee->queue_stop){
 			enqueue_mgmt(ieee, skb);
 		}else{
-			header->seq_ctl = cpu_to_le16(ieee->seq_ctrl[0]<<4);
+			header->seq_ctl = cpu_to_le16(ieee->seq_ctrl[0] << 4);
 
 			if (ieee->seq_ctrl[0] == 0xFFF)
 				ieee->seq_ctrl[0] = 0;
@@ -373,7 +373,7 @@ static void ieee80211_send_beacon(struct ieee80211_device *ieee)
 //		if(!timer_pending(&ieee->beacon_timer))
 //			add_timer(&ieee->beacon_timer);
 		mod_timer(&ieee->beacon_timer,
-			  jiffies + msecs_to_jiffies(ieee->current_network.beacon_interval-5));
+			  jiffies + msecs_to_jiffies(ieee->current_network.beacon_interval - 5));
 	}
 	//spin_unlock_irqrestore(&ieee->beacon_lock,flags);
 }
@@ -415,9 +415,9 @@ static void ieee80211_send_probe_requests(struct ieee80211_device *ieee)
 void ieee80211_softmac_scan_syncro(struct ieee80211_device *ieee)
 {
 	short ch = 0;
-	u8 channel_map[MAX_CHANNEL_NUMBER+1];
+	u8 channel_map[MAX_CHANNEL_NUMBER + 1];
 
-	memcpy(channel_map, GET_DOT11D_INFO(ieee)->channel_map, MAX_CHANNEL_NUMBER+1);
+	memcpy(channel_map, GET_DOT11D_INFO(ieee)->channel_map, MAX_CHANNEL_NUMBER + 1);
 	mutex_lock(&ieee->scan_mutex);
 
 	while (1)
@@ -480,9 +480,9 @@ static void ieee80211_softmac_scan_wq(struct work_struct *work)
 	struct delayed_work *dwork = to_delayed_work(work);
 	struct ieee80211_device *ieee = container_of(dwork, struct ieee80211_device, softmac_scan_wq);
 	static short watchdog;
-	u8 channel_map[MAX_CHANNEL_NUMBER+1];
+	u8 channel_map[MAX_CHANNEL_NUMBER + 1];
 
-	memcpy(channel_map, GET_DOT11D_INFO(ieee)->channel_map, MAX_CHANNEL_NUMBER+1);
+	memcpy(channel_map, GET_DOT11D_INFO(ieee)->channel_map, MAX_CHANNEL_NUMBER + 1);
 	if (!ieee->ieee_up)
 		return;
 	mutex_lock(&ieee->scan_mutex);
@@ -677,7 +677,7 @@ static struct sk_buff *ieee80211_probe_resp(struct ieee80211_device *ieee, u8 *d
 
 	char *ssid = ieee->current_network.ssid;
 	int ssid_len = ieee->current_network.ssid_len;
-	int rate_len = ieee->current_network.rates_len+2;
+	int rate_len = ieee->current_network.rates_len + 2;
 	int rate_ex_len = ieee->current_network.rates_ex_len;
 	int wpa_ie_len = ieee->wpa_ie_len;
 	u8 erpinfo_content = 0;
@@ -690,7 +690,7 @@ static struct sk_buff *ieee80211_probe_resp(struct ieee80211_device *ieee, u8 *d
 	u8 *tmp_generic_ie_buf = NULL;
 	u8 tmp_generic_ie_len = 0;
 
-	if (rate_ex_len > 0) rate_ex_len+=2;
+	if (rate_ex_len > 0) rate_ex_len += 2;
 
 	if (ieee->current_network.capability & WLAN_CAPABILITY_IBSS)
 		atim_len = 4;
@@ -721,19 +721,19 @@ static struct sk_buff *ieee80211_probe_resp(struct ieee80211_device *ieee, u8 *d
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
@@ -769,9 +769,9 @@ static struct sk_buff *ieee80211_probe_resp(struct ieee80211_device *ieee, u8 *d
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
@@ -783,7 +783,7 @@ static struct sk_buff *ieee80211_probe_resp(struct ieee80211_device *ieee, u8 *d
 
 		put_unaligned_le16(ieee->current_network.atim_window,
 				   tag);
-		tag+=2;
+		tag += 2;
 	}
 
 	if (erp_len) {
@@ -793,9 +793,9 @@ static struct sk_buff *ieee80211_probe_resp(struct ieee80211_device *ieee, u8 *d
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
 
 	if (wpa_ie_len)
@@ -871,7 +871,7 @@ static struct sk_buff *ieee80211_auth_resp(struct ieee80211_device *ieee,
 {
 	struct sk_buff *skb;
 	struct ieee80211_authentication *auth;
-	int len = ieee->tx_headroom + sizeof(struct ieee80211_authentication)+1;
+	int len = ieee->tx_headroom + sizeof(struct ieee80211_authentication) + 1;
 
 	skb = dev_alloc_skb(len);
 
@@ -912,7 +912,7 @@ static struct sk_buff *ieee80211_null_func(struct ieee80211_device *ieee,
 
 	hdr->frame_ctl = cpu_to_le16(IEEE80211_FTYPE_DATA |
 		IEEE80211_STYPE_NULLFUNC | IEEE80211_FCTL_TODS |
-		(pwr ? IEEE80211_FCTL_PM:0));
+		(pwr ? IEEE80211_FCTL_PM : 0));
 
 	return skb;
 }
@@ -968,9 +968,9 @@ ieee80211_association_req(struct ieee80211_network *beacon,
 	int encrypt;
 
 	unsigned int rate_len = ieee80211_MFIE_rate_len(ieee);
-	unsigned int wmm_info_len = beacon->qos_data.supported?9:0;
+	unsigned int wmm_info_len = beacon->qos_data.supported ? 9 : 0;
 #ifdef THOMAS_TURBO
-	unsigned int turbo_info_len = beacon->Turbo_Enable?9:0;
+	unsigned int turbo_info_len = beacon->Turbo_Enable ? 9 : 0;
 #endif
 
 	int len = 0;
@@ -979,7 +979,7 @@ ieee80211_association_req(struct ieee80211_network *beacon,
 	encrypt = ieee->host_encrypt && crypt && crypt->ops && ((0 == strcmp(crypt->ops->name, "WEP") || wpa_ie_len));
 
 	/* Include High Throuput capability && Realtek proprietary */
-	if (ieee->pHTInfo->bCurrentHTSupport&&ieee->pHTInfo->bEnableHT)
+	if (ieee->pHTInfo->bCurrentHTSupport && ieee->pHTInfo->bEnableHT)
 	{
 		ht_cap_buf = (u8 *)&(ieee->pHTInfo->SelfHTCap);
 		ht_cap_len = sizeof(ieee->pHTInfo->SelfHTCap);
@@ -992,22 +992,22 @@ ieee80211_association_req(struct ieee80211_network *beacon,
 		}
 	}
 	if (ieee->qos_support) {
-		wmm_info_len = beacon->qos_data.supported?9:0;
+		wmm_info_len = beacon->qos_data.supported ? 9 : 0;
 	}
 
 	if (beacon->bCkipSupported)
 	{
-		ckip_ie_len = 30+2;
+		ckip_ie_len = 30 + 2;
 	}
 	if (beacon->bCcxRmEnable)
 	{
-		ccxrm_ie_len = 6+2;
+		ccxrm_ie_len = 6 + 2;
 	}
 	if (beacon->BssCcxVerNumber >= 2)
-		cxvernum_ie_len = 5+2;
+		cxvernum_ie_len = 5 + 2;
 
 #ifdef THOMAS_TURBO
-	len = sizeof(struct ieee80211_assoc_request_frame)+ 2
+	len = sizeof(struct ieee80211_assoc_request_frame) + 2
 		+ beacon->ssid_len	/* essid tagged val */
 		+ rate_len	/* rates tagged val */
 		+ wpa_ie_len
@@ -1020,7 +1020,7 @@ ieee80211_association_req(struct ieee80211_network *beacon,
 		+ cxvernum_ie_len
 		+ ieee->tx_headroom;
 #else
-	len = sizeof(struct ieee80211_assoc_request_frame)+ 2
+	len = sizeof(struct ieee80211_assoc_request_frame) + 2
 		+ beacon->ssid_len	/* essid tagged val */
 		+ rate_len	/* rates tagged val */
 		+ wpa_ie_len
@@ -1090,7 +1090,7 @@ ieee80211_association_req(struct ieee80211_network *beacon,
 		// CCX1 spec V1.13, A01.1 CKIP Negotiation (page23):
 		// "The CKIP negotiation is started with the associate request from the client to the access point,
 		//  containing an Aironet element with both the MIC and KP bits set."
-		osCcxAironetIE.Octet[IE_CISCO_FLAG_POSITION] |=  (SUPPORT_CKIP_PK|SUPPORT_CKIP_MIC) ;
+		osCcxAironetIE.Octet[IE_CISCO_FLAG_POSITION] |=  (SUPPORT_CKIP_PK | SUPPORT_CKIP_MIC) ;
 		tag = skb_put(skb, ckip_ie_len);
 		*tag++ = MFIE_TYPE_AIRONET;
 		*tag++ = osCcxAironetIE.Length;
@@ -1132,7 +1132,7 @@ ieee80211_association_req(struct ieee80211_network *beacon,
 			*tag++ = MFIE_TYPE_HT_CAP;
 			*tag++ = ht_cap_len - 2;
 			memcpy(tag, ht_cap_buf, ht_cap_len - 2);
-			tag += ht_cap_len -2;
+			tag += ht_cap_len - 2;
 		}
 	}
 
@@ -1159,7 +1159,7 @@ ieee80211_association_req(struct ieee80211_network *beacon,
 			*tag++ = MFIE_TYPE_GENERIC;
 			*tag++ = ht_cap_len - 2;
 			memcpy(tag, ht_cap_buf, ht_cap_len - 2);
-			tag += ht_cap_len -2;
+			tag += ht_cap_len - 2;
 		}
 
 		if (ieee->pHTInfo->bCurrentRT2RTAggregation) {
@@ -1247,11 +1247,11 @@ static void ieee80211_auth_challenge(struct ieee80211_device *ieee,
 	ieee->associate_seq++;
 	ieee->softmac_stats.tx_auth_rq++;
 
-	skb = ieee80211_authentication_req(beacon, ieee, chlen+2);
+	skb = ieee80211_authentication_req(beacon, ieee, chlen + 2);
 	if (!skb)
 		ieee80211_associate_abort(ieee);
 	else{
-		c = skb_put(skb, chlen+2);
+		c = skb_put(skb, chlen + 2);
 		*(c++) = MFIE_TYPE_CHALLENGE;
 		*(c++) = chlen;
 		memcpy(c, challenge, chlen);
@@ -1261,7 +1261,7 @@ static void ieee80211_auth_challenge(struct ieee80211_device *ieee,
 		ieee80211_encrypt_fragment(ieee, skb, sizeof(struct rtl_80211_hdr_3addr  ));
 
 		softmac_mgmt_xmit(skb, ieee);
-		mod_timer(&ieee->associate_timer, jiffies + (HZ/2));
+		mod_timer(&ieee->associate_timer, jiffies + (HZ / 2));
 		//dev_kfree_skb_any(skb);//edit by thomas
 	}
 	kfree(challenge);
@@ -1282,7 +1282,7 @@ static void ieee80211_associate_step2(struct ieee80211_device *ieee)
 		ieee80211_associate_abort(ieee);
 	else{
 		softmac_mgmt_xmit(skb, ieee);
-		mod_timer(&ieee->associate_timer, jiffies + (HZ/2));
+		mod_timer(&ieee->associate_timer, jiffies + (HZ / 2));
 		//dev_kfree_skb_any(skb);//edit by thomas
 	}
 }
@@ -1298,7 +1298,7 @@ static void ieee80211_associate_complete_wq(struct work_struct *work)
 		ieee->rate = 22;
 		printk(KERN_INFO"Using B rates:%d\n", ieee->rate);
 	}
-	if (ieee->pHTInfo->bCurrentHTSupport&&ieee->pHTInfo->bEnableHT)
+	if (ieee->pHTInfo->bCurrentHTSupport && ieee->pHTInfo->bEnableHT)
 	{
 		printk("Successfully associated, ht enabled\n");
 		HTOnAssocRsp(ieee);
@@ -1309,7 +1309,7 @@ static void ieee80211_associate_complete_wq(struct work_struct *work)
 		memset(ieee->dot11HTOperationalRateSet, 0, 16);
 		//HTSetConnectBwMode(ieee, HT_CHANNEL_WIDTH_20, HT_EXTCHNL_OFFSET_NO_EXT);
 	}
-	ieee->LinkDetectInfo.SlotNum = 2 * (1 + ieee->current_network.beacon_interval/500);
+	ieee->LinkDetectInfo.SlotNum = 2 * (1 + ieee->current_network.beacon_interval / 500);
 	// To prevent the immediately calling watch_dog after association.
 	if (ieee->LinkDetectInfo.NumRecvBcnInPeriod == 0 || ieee->LinkDetectInfo.NumRecvDataInPeriod == 0 )
 	{
@@ -1363,7 +1363,7 @@ static void ieee80211_associate_procedure_wq(struct work_struct *work)
 
 inline void ieee80211_softmac_new_net(struct ieee80211_device *ieee, struct ieee80211_network *net)
 {
-	u8 tmp_ssid[IW_ESSID_MAX_SIZE+1];
+	u8 tmp_ssid[IW_ESSID_MAX_SIZE + 1];
 	int tmp_ssid_len = 0;
 
 	short apset, ssidset, ssidbroad, apmatch, ssidmatch;
@@ -1389,8 +1389,8 @@ inline void ieee80211_softmac_new_net(struct ieee80211_device *ieee, struct ieee
 		ssidset = ieee->ssid_set;//ieee->current_network.ssid[0] != '\0';
 		ssidbroad =  !(net->ssid_len == 0 || net->ssid[0] == '\0');
 		apmatch = (memcmp(ieee->current_network.bssid, net->bssid, ETH_ALEN) == 0);
-		ssidmatch = (ieee->current_network.ssid_len == net->ssid_len)&&\
-				(!strncmp(ieee->current_network.ssid, net->ssid, net->ssid_len));
+		ssidmatch = (ieee->current_network.ssid_len == net->ssid_len) &&
+			(!strncmp(ieee->current_network.ssid, net->ssid, net->ssid_len));
 
 		if (	/* if the user set the AP check if match.
 			 * if the network does not broadcast essid we check the user supplyed ANY essid
@@ -1545,10 +1545,10 @@ static short probe_rq_parse(struct ieee80211_device *ieee, struct sk_buff *skb,
 
 	tag = skb->data + sizeof (struct rtl_80211_hdr_3addr  );
 
-	while (tag+1 < skbend){
+	while (tag + 1 < skbend){
 		if (*tag == 0) {
-			ssid = tag+2;
-			ssidlen = *(tag+1);
+			ssid = tag + 2;
+			ssidlen = *(tag + 1);
 			break;
 		}
 		tag++; /* point to the len field */
@@ -1594,11 +1594,11 @@ static inline u16 assoc_parse(struct ieee80211_device *ieee, struct sk_buff *skb
 	*aid = le16_to_cpu(response_head->aid) & 0x3fff;
 
 	status_code = le16_to_cpu(response_head->status);
-	if ((status_code == WLAN_STATUS_ASSOC_DENIED_RATES || \
-	     status_code == WLAN_STATUS_CAPS_UNSUPPORTED)&&
+	if ((status_code == WLAN_STATUS_ASSOC_DENIED_RATES ||
+	     status_code == WLAN_STATUS_CAPS_UNSUPPORTED) &&
 	    ((ieee->mode == IEEE_G) &&
 	     (ieee->current_network.mode == IEEE_N_24G) &&
-	     (ieee->AsocRetryCount++ < (RT_ASOC_RETRY_LIMIT-1)))) {
+	     (ieee->AsocRetryCount++ < (RT_ASOC_RETRY_LIMIT - 1)))) {
 		ieee->pHTInfo->IOTAction |= HT_IOT_ACT_PURE_N_MODE;
 	}else {
 		ieee->AsocRetryCount = 0;
@@ -1679,7 +1679,7 @@ static short ieee80211_sta_ps_sleep(struct ieee80211_device *ieee, u32 *time_h,
 	timeout = ieee->current_network.beacon_interval; //should we use ps_timeout value or beacon_interval
 	ieee->current_network.dtim_data = IEEE80211_DTIM_INVALID;
 
-	if (dtim & ((IEEE80211_DTIM_UCAST | IEEE80211_DTIM_MBCAST)& ieee->ps))
+	if (dtim & ((IEEE80211_DTIM_UCAST | IEEE80211_DTIM_MBCAST) & ieee->ps))
 		return 2;
 
 	if (!time_after(jiffies,
-- 
2.18.0

