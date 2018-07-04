Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C324DC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7283823E10
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kwpv02TQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7283823E10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753156AbeGDOVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:21:25 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38612 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753075AbeGDOVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:21:21 -0400
Received: by mail-wm0-f68.google.com with SMTP id 69-v6so5911399wmf.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 07:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SwfRJQiQhlxkx04RrupDwEUAOqf7C0q8KhfHAyD1tAk=;
        b=Kwpv02TQqi7wkKVJTiXj94kGq/vmHAz8hTpVexlkCua1zdOdi6FRrAU+63f46bTQKn
         0fczYv68g17Oc/ZzvBEXKEKVXjNIifOA5EqJ0Fz/twPt/owHps2k584LPWzAa0UEbRbg
         fhgbcmwX5nZTLXEsYPjHQFsJRLzgS19yL7OwTl8MVUnqNJHOThkCdKvxDh9NutOWRGmo
         HOxnzf8xR8DkjkqNwCiFzcQEDueAsl4btGuGp6pQjjpL+ik47N/VHbgsZYNcW+dTIAtD
         QRlXGUgUIx48AViWCOXoOrNthUhzthwyiNhSHMiTV+I6tZCGYGKbTzY3CzaFa1clfo1Z
         giaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SwfRJQiQhlxkx04RrupDwEUAOqf7C0q8KhfHAyD1tAk=;
        b=c0k/AUgbfGgux8PlpNcGia2qlz0BhdLCgvMzUTcZvXbIRyyIWsdGNm1/TfBaLsfDY6
         EOnBitkLhFzODb2j66Y2oaM8wWftvzO9DD2fvZHqIvsrmGyW489tn2kA1on2jNIOybKd
         /1Q7rz7hDDCtHIQ+Da7WL51zPVCPA03gb9g6H3DdoJt/hVyMMgYbr1mGngfi7Tk8zexg
         wrxa/6AT2Kksn4+lIvM0OPKkeYxS6GcD2fgSEGykTM4cjT00iR/zL+kss2MleTAamxvT
         bDZxJ68cYXwdR+bTmlGoxrIhOvak13HadFgQusUcuoztZyK1aqb6JJ+GHL5tK6bhBd+X
         NyFw==
X-Gm-Message-State: APt69E17/8+X5EiCtozFTnDu8ojmyfHb1z9TXY21wOoG3yrm3ZZldGIw
        cMHeYaXwZdHrnOlg7jk01z4Hp4aB
X-Google-Smtp-Source: AAOMgpcGQmJxLKIZggqW2+ARdD5bmeQhd/FpKqzrLqjcwr6YHUGXlL09sGP9lSFeGB0LRI/Jf+/icg==
X-Received: by 2002:a1c:2352:: with SMTP id j79-v6mr1755967wmj.124.1530714079534;
        Wed, 04 Jul 2018 07:21:19 -0700 (PDT)
Received: from localhost.localdomain (host81-152-164-58.range81-152.btcentralplus.com. [81.152.164.58])
        by smtp.gmail.com with ESMTPSA id s41-v6sm7109142wrc.5.2018.07.04.07.21.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 07:21:18 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, insafonov@gmail.com,
        baijiaju1990@gmail.com, keescook@chromium.org, joe@perches.com,
        colin.king@canonical.com, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 8/9] staging: rtl8192u: Add required space around '=' operator - Style
Date:   Wed,  4 Jul 2018 15:20:55 +0100
Message-Id: <20180704142056.2179-8-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180704142056.2179-1-johnfwhitmore@gmail.com>
References: <20180704142056.2179-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch requires spaces around '=' operator so added.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../rtl8192u/ieee80211/ieee80211_softmac.c    | 50 +++++++++----------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index e7b5cd896f02..c7c391b1077e 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -219,7 +219,7 @@ inline void softmac_mgmt_xmit(struct sk_buff *skb, struct ieee80211_device *ieee
 {
 	unsigned long flags;
 	short single = ieee->softmac_features & IEEE_SOFTMAC_SINGLE_QUEUE;
-	struct rtl_80211_hdr_3addr  *header=
+	struct rtl_80211_hdr_3addr  *header =
 		(struct rtl_80211_hdr_3addr  *)skb->data;
 
 	struct cb_desc *tcb_desc = (struct cb_desc *)(skb->cb + 8);
@@ -686,12 +686,12 @@ static struct sk_buff *ieee80211_probe_resp(struct ieee80211_device *ieee, u8 *d
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
 
 	if(rate_ex_len > 0) rate_ex_len+=2;
 
@@ -710,9 +710,9 @@ static struct sk_buff *ieee80211_probe_resp(struct ieee80211_device *ieee, u8 *d
 	encrypt = ieee->host_encrypt && crypt && crypt->ops &&
 		((0 == strcmp(crypt->ops->name, "WEP") || wpa_ie_len));
 	/* HT ralated element */
-	tmp_ht_cap_buf =(u8 *)&(ieee->pHTInfo->SelfHTCap);
+	tmp_ht_cap_buf = (u8 *)&(ieee->pHTInfo->SelfHTCap);
 	tmp_ht_cap_len = sizeof(ieee->pHTInfo->SelfHTCap);
-	tmp_ht_info_buf =(u8 *)&(ieee->pHTInfo->SelfHTInfo);
+	tmp_ht_info_buf = (u8 *)&(ieee->pHTInfo->SelfHTInfo);
 	tmp_ht_info_len = sizeof(ieee->pHTInfo->SelfHTInfo);
 	HTConstructCapabilityElement(ieee, tmp_ht_cap_buf, &tmp_ht_cap_len,encrypt);
 	HTConstructInfoElement(ieee,tmp_ht_info_buf,&tmp_ht_info_len, encrypt);
@@ -858,7 +858,7 @@ static struct sk_buff *ieee80211_assoc_resp(struct ieee80211_device *ieee,
 
 	assoc->status = 0;
 	assoc->aid = cpu_to_le16(ieee->assoc_id);
-	if (ieee->assoc_id == 0x2007) ieee->assoc_id=0;
+	if (ieee->assoc_id == 0x2007) ieee->assoc_id = 0;
 	else ieee->assoc_id++;
 
 	tag = skb_put(skb, rate_len);
@@ -960,13 +960,13 @@ ieee80211_association_req(struct ieee80211_network *beacon,
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
 
@@ -1221,7 +1221,7 @@ static void ieee80211_associate_step1(struct ieee80211_device *ieee)
 	IEEE80211_DEBUG_MGMT("Stopping scan\n");
 
 	ieee->softmac_stats.tx_auth_rq++;
-	skb=ieee80211_authentication_req(beacon, ieee, 0);
+	skb = ieee80211_authentication_req(beacon, ieee, 0);
 
 	if (!skb)
 		ieee80211_associate_abort(ieee);
@@ -1280,7 +1280,7 @@ static void ieee80211_associate_step2(struct ieee80211_device *ieee)
 	IEEE80211_DEBUG_MGMT("Sending association request\n");
 
 	ieee->softmac_stats.tx_ass_rq++;
-	skb=ieee80211_association_req(beacon, ieee);
+	skb = ieee80211_association_req(beacon, ieee);
 	if (!skb)
 		ieee80211_associate_abort(ieee);
 	else{
@@ -1318,7 +1318,7 @@ static void ieee80211_associate_complete_wq(struct work_struct *work)
 	if (ieee->LinkDetectInfo.NumRecvBcnInPeriod == 0 || ieee->LinkDetectInfo.NumRecvDataInPeriod == 0 )
 	{
 		ieee->LinkDetectInfo.NumRecvBcnInPeriod = 1;
-		ieee->LinkDetectInfo.NumRecvDataInPeriod= 1;
+		ieee->LinkDetectInfo.NumRecvDataInPeriod = 1;
 	}
 	ieee->link_change(ieee->dev);
 	if (!ieee->is_silent_reset) {
@@ -1530,7 +1530,7 @@ static short probe_rq_parse(struct ieee80211_device *ieee, struct sk_buff *skb,
 {
 	u8 *tag;
 	u8 *skbend;
-	u8 *ssid=NULL;
+	u8 *ssid = NULL;
 	u8 ssidlen = 0;
 
 	struct rtl_80211_hdr_3addr   *header =
@@ -1945,7 +1945,7 @@ ieee80211_rx_frame_softmac(struct ieee80211_device *ieee, struct sk_buff *skb,
 
 			errcode = assoc_parse(ieee, skb, &aid);
 			if (!errcode) {
-				ieee->state=IEEE80211_LINKED;
+				ieee->state = IEEE80211_LINKED;
 				ieee->assoc_id = aid;
 				ieee->softmac_stats.rx_ass_ok++;
 				/* station support qos */
@@ -2597,8 +2597,8 @@ void ieee80211_softmac_init(struct ieee80211_device *ieee)
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "can't alloc memory for DOT11D\n");
 	//added for  AP roaming
 	ieee->LinkDetectInfo.SlotNum = 2;
-	ieee->LinkDetectInfo.NumRecvBcnInPeriod=0;
-	ieee->LinkDetectInfo.NumRecvDataInPeriod=0;
+	ieee->LinkDetectInfo.NumRecvBcnInPeriod = 0;
+	ieee->LinkDetectInfo.NumRecvDataInPeriod = 0;
 
 	ieee->assoc_id = 0;
 	ieee->queue_stop = 0;
@@ -2611,9 +2611,9 @@ void ieee80211_softmac_init(struct ieee80211_device *ieee)
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
-- 
2.17.1

