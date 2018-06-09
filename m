Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 3i4RKX13G1s4dQAAmS7hNA
	; Sat, 09 Jun 2018 06:45:17 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 91C16607E7; Sat,  9 Jun 2018 06:45:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8CFB7600D0;
	Sat,  9 Jun 2018 06:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8CFB7600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753104AbeFIGpN (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 02:45:13 -0400
Received: from smtprelay0155.hostedemail.com ([216.40.44.155]:59665 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751528AbeFIGpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 02:45:11 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 3E25787F0;
        Sat,  9 Jun 2018 06:45:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: plot62_670e2aca8be5b
X-Filterd-Recvd-Size: 30605
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Sat,  9 Jun 2018 06:45:08 +0000 (UTC)
Message-ID: <62ed190ace0c462bdec606b9bfbd87af8718bbd8.camel@perches.com>
Subject: Re: [PATCH 2/2] staging: rtl8192e: fix line over 80 characters
From: Joe Perches <joe@perches.com>
To: thtlwlsmsgkfla@gmail.com, gregkh@linuxfoundation.org
Cc: davem@davemloft.net, colin.king@canonical.com,
        johannes.berg@intel.com, Linyu.Yuan@alcatel-sbell.com.cn,
        keescook@chromium.org, tvboxspy@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Date: Fri, 08 Jun 2018 23:45:06 -0700
In-Reply-To: <1667235.oI4jP7xdTe@os-virtualbox>
References: <1667235.oI4jP7xdTe@os-virtualbox>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-06-09 at 15:07 +0900, thtlwlsmsgkfla@gmail.com wrote:
> *fix checkpatch.pl warnings:
>  WARNING: line over 80 characters

Consider using a temporary for these ieee->current_network.
dereferences.

> diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
[]
> @@ -2596,7 +2596,8 @@ static void rtllib_start_ibss_wq(void *data)
>  
>  	if (ieee->current_network.ssid_len == 0) {
>  		strcpy(ieee->current_network.ssid, RTLLIB_DEFAULT_TX_ESSID);
> -		ieee->current_network.ssid_len = strlen(RTLLIB_DEFAULT_TX_ESSID);
> +		ieee->current_network.ssid_len =
> +			strlen(RTLLIB_DEFAULT_TX_ESSID);
>  		ieee->ssid_set = 1;
>  	}

For instance:

Adding a temporary for all ieee->current_network
deferences actually reduces line count in this file.

---
 drivers/staging/rtl8192e/rtllib_softmac.c | 281 +++++++++++++++---------------
 1 file changed, 139 insertions(+), 142 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 919231fec09c..5733a1ab59d1 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -157,10 +157,10 @@ MgntQuery_TxRateExcludeCCKRates(struct rtllib_device *ieee)
 	u16	i;
 	u8	QueryRate = 0;
 	u8	BasicRate;
+	struct rtllib_network *cur_net = &ieee->current_network;
 
-
-	for (i = 0; i < ieee->current_network.rates_len; i++) {
-		BasicRate = ieee->current_network.rates[i]&0x7F;
+	for (i = 0; i < cur_net->rates_len; i++) {
+		BasicRate = cur_net->rates[i] & 0x7F;
 		if (!rtllib_is_cck_rate(BasicRate)) {
 			if (QueryRate == 0) {
 				QueryRate = BasicRate;
@@ -338,8 +338,9 @@ static inline struct sk_buff *rtllib_probe_req(struct rtllib_device *ieee)
 	u8 *tag;
 	struct sk_buff *skb;
 	struct rtllib_probe_request *req;
+	struct rtllib_network *cur_net = &ieee->current_network;
 
-	len = ieee->current_network.ssid_len;
+	len = cur_net->ssid_len;
 
 	rate_len = rtllib_MFIE_rate_len(ieee);
 
@@ -363,7 +364,7 @@ static inline struct sk_buff *rtllib_probe_req(struct rtllib_device *ieee)
 
 	*tag++ = MFIE_TYPE_SSID;
 	*tag++ = len;
-	memcpy(tag, ieee->current_network.ssid, len);
+	memcpy(tag, cur_net->ssid, len);
 	tag += len;
 
 	rtllib_MFIE_Brate(ieee, &tag);
@@ -377,6 +378,7 @@ static struct sk_buff *rtllib_get_beacon_(struct rtllib_device *ieee);
 static void rtllib_send_beacon(struct rtllib_device *ieee)
 {
 	struct sk_buff *skb;
+	struct rtllib_network *cur_net = &ieee->current_network;
 
 	if (!ieee->ieee_up)
 		return;
@@ -389,7 +391,7 @@ static void rtllib_send_beacon(struct rtllib_device *ieee)
 
 	if (ieee->beacon_txing && ieee->ieee_up)
 		mod_timer(&ieee->beacon_timer, jiffies +
-			  (msecs_to_jiffies(ieee->current_network.beacon_interval - 5)));
+			  (msecs_to_jiffies(cur_net->beacon_interval - 5)));
 }
 
 
@@ -578,7 +580,8 @@ static void rtllib_softmac_scan_wq(void *data)
 {
 	struct rtllib_device *ieee = container_of_dwork_rsl(data,
 				     struct rtllib_device, softmac_scan_wq);
-	u8 last_channel = ieee->current_network.channel;
+	struct rtllib_network *cur_net = &ieee->current_network;
+	u8 last_channel = cur_net->channel;
 
 	rtllib_update_active_chan_map(ieee);
 
@@ -597,22 +600,20 @@ static void rtllib_softmac_scan_wq(void *data)
 	}
 
 	do {
-		ieee->current_network.channel =
-			(ieee->current_network.channel + 1) %
-			MAX_CHANNEL_NUMBER;
+		cur_net->channel = (cur_net->channel + 1) % MAX_CHANNEL_NUMBER;
 		if (ieee->scan_watch_dog++ > MAX_CHANNEL_NUMBER) {
-			if (!ieee->active_channel_map[ieee->current_network.channel])
-				ieee->current_network.channel = 6;
+			if (!ieee->active_channel_map[cur_net->channel])
+				cur_net->channel = 6;
 			goto out; /* no good chans */
 		}
-	} while (!ieee->active_channel_map[ieee->current_network.channel]);
+	} while (!ieee->active_channel_map[cur_net->channel]);
 
 	if (ieee->scanning_continue == 0)
 		goto out;
 
-	ieee->set_chan(ieee->dev, ieee->current_network.channel);
+	ieee->set_chan(ieee->dev, cur_net->channel);
 
-	if (ieee->active_channel_map[ieee->current_network.channel] == 1)
+	if (ieee->active_channel_map[cur_net->channel] == 1)
 		rtllib_send_probe_requests(ieee, 0);
 
 	schedule_delayed_work(&ieee->softmac_scan_wq,
@@ -624,7 +625,7 @@ static void rtllib_softmac_scan_wq(void *data)
 out:
 	if (IS_DOT11D_ENABLE(ieee))
 		DOT11D_ScanComplete(ieee);
-	ieee->current_network.channel = last_channel;
+	cur_net->channel = last_channel;
 
 out1:
 	ieee->actscanning = false;
@@ -822,11 +823,11 @@ static struct sk_buff *rtllib_probe_resp(struct rtllib_device *ieee,
 	int encrypt;
 	int atim_len, erp_len;
 	struct lib80211_crypt_data *crypt;
-
-	char *ssid = ieee->current_network.ssid;
-	int ssid_len = ieee->current_network.ssid_len;
-	int rate_len = ieee->current_network.rates_len+2;
-	int rate_ex_len = ieee->current_network.rates_ex_len;
+	struct rtllib_network *cur_net = &ieee->current_network;
+	char *ssid = cur_net->ssid;
+	int ssid_len = cur_net->ssid_len;
+	int rate_len = cur_net->rates_len + 2;
+	int rate_ex_len = cur_net->rates_ex_len;
 	int wpa_ie_len = ieee->wpa_ie_len;
 	u8 erpinfo_content = 0;
 
@@ -841,17 +842,17 @@ static struct sk_buff *rtllib_probe_resp(struct rtllib_device *ieee,
 	if (rate_ex_len > 0)
 		rate_ex_len += 2;
 
-	if (ieee->current_network.capability & WLAN_CAPABILITY_IBSS)
+	if (cur_net->capability & WLAN_CAPABILITY_IBSS)
 		atim_len = 4;
 	else
 		atim_len = 0;
 
-	if ((ieee->current_network.mode == IEEE_G) ||
-	   (ieee->current_network.mode == IEEE_N_24G &&
+	if ((cur_net->mode == IEEE_G) ||
+	   (cur_net->mode == IEEE_N_24G &&
 	   ieee->pHTInfo->bCurSuppCCK)) {
 		erp_len = 3;
 		erpinfo_content = 0;
-		if (ieee->current_network.buseprotection)
+		if (cur_net->buseprotection)
 			erpinfo_content |= ERP_UseProtection;
 	} else
 		erp_len = 0;
@@ -890,20 +891,17 @@ static struct sk_buff *rtllib_probe_resp(struct rtllib_device *ieee,
 	beacon_buf = skb_put(skb, (beacon_size - ieee->tx_headroom));
 	ether_addr_copy(beacon_buf->header.addr1, dest);
 	ether_addr_copy(beacon_buf->header.addr2, ieee->dev->dev_addr);
-	ether_addr_copy(beacon_buf->header.addr3, ieee->current_network.bssid);
+	ether_addr_copy(beacon_buf->header.addr3, cur_net->bssid);
 
 	beacon_buf->header.duration_id = 0;
-	beacon_buf->beacon_interval =
-		cpu_to_le16(ieee->current_network.beacon_interval);
-	beacon_buf->capability =
-		cpu_to_le16(ieee->current_network.capability &
-		WLAN_CAPABILITY_IBSS);
-	beacon_buf->capability |=
-		cpu_to_le16(ieee->current_network.capability &
-		WLAN_CAPABILITY_SHORT_PREAMBLE);
-
-	if (ieee->short_slot && (ieee->current_network.capability &
-	    WLAN_CAPABILITY_SHORT_SLOT_TIME))
+	beacon_buf->beacon_interval = cpu_to_le16(cur_net->beacon_interval);
+	beacon_buf->capability = cpu_to_le16(cur_net->capability &
+					     WLAN_CAPABILITY_IBSS);
+	beacon_buf->capability |= cpu_to_le16(cur_net->capability &
+					      WLAN_CAPABILITY_SHORT_PREAMBLE);
+
+	if (ieee->short_slot &&
+	    (cur_net->capability & WLAN_CAPABILITY_SHORT_SLOT_TIME))
 		beacon_buf->capability |=
 			cpu_to_le16(WLAN_CAPABILITY_SHORT_SLOT_TIME);
 
@@ -924,18 +922,18 @@ static struct sk_buff *rtllib_probe_resp(struct rtllib_device *ieee,
 
 	*(tag++) = MFIE_TYPE_RATES;
 	*(tag++) = rate_len-2;
-	memcpy(tag, ieee->current_network.rates, rate_len-2);
+	memcpy(tag, cur_net->rates, rate_len - 2);
 	tag += rate_len-2;
 
 	*(tag++) = MFIE_TYPE_DS_SET;
 	*(tag++) = 1;
-	*(tag++) = ieee->current_network.channel;
+	*(tag++) = cur_net->channel;
 
 	if (atim_len) {
 		u16 val16;
 		*(tag++) = MFIE_TYPE_IBSS_SET;
 		*(tag++) = 2;
-		val16 = ieee->current_network.atim_window;
+		val16 = cur_net->atim_window;
 		memcpy((u8 *)tag, (u8 *)&val16, 2);
 		tag += 2;
 	}
@@ -948,7 +946,7 @@ static struct sk_buff *rtllib_probe_resp(struct rtllib_device *ieee,
 	if (rate_ex_len) {
 		*(tag++) = MFIE_TYPE_RATES_EX;
 		*(tag++) = rate_ex_len-2;
-		memcpy(tag, ieee->current_network.rates_ex, rate_ex_len-2);
+		memcpy(tag, cur_net->rates_ex, rate_ex_len - 2);
 		tag += rate_ex_len-2;
 	}
 
@@ -1053,6 +1051,7 @@ static struct sk_buff *rtllib_null_func(struct rtllib_device *ieee, short pwr)
 {
 	struct sk_buff *skb;
 	struct rtllib_hdr_3addr *hdr;
+	struct rtllib_network *cur_net = &ieee->current_network;
 
 	skb = dev_alloc_skb(sizeof(struct rtllib_hdr_3addr)+ieee->tx_headroom);
 	if (!skb)
@@ -1062,9 +1061,9 @@ static struct sk_buff *rtllib_null_func(struct rtllib_device *ieee, short pwr)
 
 	hdr = skb_put(skb, sizeof(struct rtllib_hdr_3addr));
 
-	ether_addr_copy(hdr->addr1, ieee->current_network.bssid);
+	ether_addr_copy(hdr->addr1, cur_net->bssid);
 	ether_addr_copy(hdr->addr2, ieee->dev->dev_addr);
-	ether_addr_copy(hdr->addr3, ieee->current_network.bssid);
+	ether_addr_copy(hdr->addr3, cur_net->bssid);
 
 	hdr->frame_ctl = cpu_to_le16(RTLLIB_FTYPE_DATA |
 		RTLLIB_STYPE_NULLFUNC | RTLLIB_FCTL_TODS |
@@ -1079,6 +1078,7 @@ static struct sk_buff *rtllib_pspoll_func(struct rtllib_device *ieee)
 {
 	struct sk_buff *skb;
 	struct rtllib_pspoll_hdr *hdr;
+	struct rtllib_network *cur_net = &ieee->current_network;
 
 	skb = dev_alloc_skb(sizeof(struct rtllib_pspoll_hdr)+ieee->tx_headroom);
 	if (!skb)
@@ -1088,7 +1088,7 @@ static struct sk_buff *rtllib_pspoll_func(struct rtllib_device *ieee)
 
 	hdr = skb_put(skb, sizeof(struct rtllib_pspoll_hdr));
 
-	ether_addr_copy(hdr->bssid, ieee->current_network.bssid);
+	ether_addr_copy(hdr->bssid, cur_net->bssid);
 	ether_addr_copy(hdr->ta, ieee->dev->dev_addr);
 
 	hdr->aid = cpu_to_le16(ieee->assoc_id | 0xc000);
@@ -1162,6 +1162,7 @@ rtllib_association_req(struct rtllib_network *beacon,
 	struct lib80211_crypt_data *crypt;
 	int encrypt;
 	int	PMKCacheIdx;
+	struct rtllib_network *cur_net = &ieee->current_network;
 
 	unsigned int rate_len = (beacon->rates_len ?
 				(beacon->rates_len + 2) : 0) +
@@ -1209,7 +1210,7 @@ rtllib_association_req(struct rtllib_network *beacon,
 	if (beacon->BssCcxVerNumber >= 2)
 		cxvernum_ie_len = 5+2;
 
-	PMKCacheIdx = SecIsInPMKIDList(ieee, ieee->current_network.bssid);
+	PMKCacheIdx = SecIsInPMKIDList(ieee, cur_net->bssid);
 	if (PMKCacheIdx >= 0) {
 		wpa_ie_len += 18;
 		netdev_info(ieee->dev, "[PMK cache]: WPA2 IE length: %x\n",
@@ -1515,10 +1516,11 @@ static void rtllib_associate_complete_wq(void *data)
 				     container_of_work_rsl(data,
 				     struct rtllib_device,
 				     associate_complete_wq);
+	struct rtllib_network *cur_net = &ieee->current_network;
 	struct rt_pwr_save_ctrl *pPSC = &(ieee->PowerSaveControl);
 
 	netdev_info(ieee->dev, "Associated successfully with %pM\n",
-		    ieee->current_network.bssid);
+		    cur_net->bssid);
 	if (!ieee->is_silent_reset) {
 		netdev_info(ieee->dev, "normal associate\n");
 		notify_wx_assoc_event(ieee);
@@ -1545,9 +1547,7 @@ static void rtllib_associate_complete_wq(void *data)
 			    ieee->pHTInfo->bEnableHT);
 		memset(ieee->dot11HTOperationalRateSet, 0, 16);
 	}
-	ieee->LinkDetectInfo.SlotNum = 2 * (1 +
-				       ieee->current_network.beacon_interval /
-				       500);
+	ieee->LinkDetectInfo.SlotNum = 2 * (1 + cur_net->beacon_interval / 500);
 	if (ieee->LinkDetectInfo.NumRecvBcnInPeriod == 0 ||
 	    ieee->LinkDetectInfo.NumRecvDataInPeriod == 0) {
 		ieee->LinkDetectInfo.NumRecvBcnInPeriod = 1;
@@ -1585,6 +1585,8 @@ static void rtllib_associate_procedure_wq(void *data)
 	struct rtllib_device *ieee = container_of_dwork_rsl(data,
 				     struct rtllib_device,
 				     associate_procedure_wq);
+	struct rtllib_network *cur_net = &ieee->current_network;
+
 	rtllib_stop_scan_syncro(ieee);
 	if (ieee->rtllib_ips_leave != NULL)
 		ieee->rtllib_ips_leave(ieee->dev);
@@ -1594,8 +1596,7 @@ static void rtllib_associate_procedure_wq(void *data)
 		ieee->data_hard_stop(ieee->dev);
 
 	rtllib_stop_scan(ieee);
-	RT_TRACE(COMP_DBG, "===>%s(), chan:%d\n", __func__,
-		 ieee->current_network.channel);
+	RT_TRACE(COMP_DBG, "===>%s(), chan:%d\n", __func__, cur_net->channel);
 	HTSetConnectBwMode(ieee, HT_CHANNEL_WIDTH_20, HT_EXTCHNL_OFFSET_NO_EXT);
 	if (ieee->eRFPowerState == eRfOff) {
 		RT_TRACE(COMP_DBG,
@@ -1608,7 +1609,7 @@ static void rtllib_associate_procedure_wq(void *data)
 	}
 	ieee->associate_seq = 1;
 
-	rtllib_associate_step1(ieee, ieee->current_network.bssid);
+	rtllib_associate_step1(ieee, cur_net->bssid);
 
 	mutex_unlock(&ieee->wx_mutex);
 }
@@ -1618,6 +1619,7 @@ inline void rtllib_softmac_new_net(struct rtllib_device *ieee,
 {
 	u8 tmp_ssid[IW_ESSID_MAX_SIZE + 1];
 	int tmp_ssid_len = 0;
+	struct rtllib_network *cur_net = &ieee->current_network;
 
 	short apset, ssidset, ssidbroad, apmatch, ssidmatch;
 
@@ -1646,13 +1648,11 @@ inline void rtllib_softmac_new_net(struct rtllib_device *ieee,
 		apset = ieee->wap_set;
 		ssidset = ieee->ssid_set;
 		ssidbroad =  !(net->ssid_len == 0 || net->ssid[0] == '\0');
-		apmatch = (memcmp(ieee->current_network.bssid, net->bssid,
-				  ETH_ALEN) == 0);
+		apmatch = (memcmp(cur_net->bssid, net->bssid, ETH_ALEN) == 0);
 		if (!ssidbroad) {
-			ssidmatch = (ieee->current_network.ssid_len ==
-				    net->hidden_ssid_len) &&
-				    (!strncmp(ieee->current_network.ssid,
-				    net->hidden_ssid, net->hidden_ssid_len));
+			ssidmatch = ((cur_net->ssid_len == net->hidden_ssid_len) &&
+				     (!strncmp(cur_net->ssid, net->hidden_ssid,
+					       net->hidden_ssid_len)));
 			if (net->hidden_ssid_len > 0) {
 				strncpy(net->ssid, net->hidden_ssid,
 					net->hidden_ssid_len);
@@ -1660,10 +1660,9 @@ inline void rtllib_softmac_new_net(struct rtllib_device *ieee,
 				ssidbroad = 1;
 			}
 		} else
-			ssidmatch =
-			   (ieee->current_network.ssid_len == net->ssid_len) &&
-			   (!strncmp(ieee->current_network.ssid, net->ssid,
-			   net->ssid_len));
+			ssidmatch = ((cur_net->ssid_len == net->ssid_len) &&
+				     (!strncmp(cur_net->ssid, net->ssid,
+					       net->ssid_len)));
 
 		/* if the user set the AP check if match.
 		 * if the network does not broadcast essid we check the
@@ -1684,26 +1683,26 @@ inline void rtllib_softmac_new_net(struct rtllib_device *ieee,
 			 * essid provided by the user.
 			 */
 			if (!ssidbroad) {
-				strncpy(tmp_ssid, ieee->current_network.ssid,
+				strncpy(tmp_ssid, cur_net->ssid,
 					IW_ESSID_MAX_SIZE);
-				tmp_ssid_len = ieee->current_network.ssid_len;
+				tmp_ssid_len = cur_net->ssid_len;
 			}
 			memcpy(&ieee->current_network, net,
 			       sizeof(struct rtllib_network));
 			if (!ssidbroad) {
-				strncpy(ieee->current_network.ssid, tmp_ssid,
+				strncpy(cur_net->ssid, tmp_ssid,
 					IW_ESSID_MAX_SIZE);
-				ieee->current_network.ssid_len = tmp_ssid_len;
+				cur_net->ssid_len = tmp_ssid_len;
 			}
 			netdev_info(ieee->dev,
 				    "Linking with %s,channel:%d, qos:%d, myHT:%d, networkHT:%d, mode:%x cur_net.flags:0x%x\n",
-				    ieee->current_network.ssid,
-				    ieee->current_network.channel,
-				    ieee->current_network.qos_data.supported,
+				    cur_net->ssid,
+				    cur_net->channel,
+				    cur_net->qos_data.supported,
 				    ieee->pHTInfo->bEnableHT,
-				    ieee->current_network.bssht.bdSupportHT,
-				    ieee->current_network.mode,
-				    ieee->current_network.flags);
+				    cur_net->bssht.bdSupportHT,
+				    cur_net->mode,
+				    cur_net->flags);
 
 			if ((rtllib_act_scanning(ieee, false)) &&
 			   !(ieee->softmac_features & IEEE_SOFTMAC_SCAN))
@@ -1714,8 +1713,8 @@ inline void rtllib_softmac_new_net(struct rtllib_device *ieee,
 			if (ieee->iw_mode == IW_MODE_INFRA) {
 				/* Join the network for the first time */
 				ieee->AsocRetryCount = 0;
-				if ((ieee->current_network.qos_data.supported == 1) &&
-				    ieee->current_network.bssht.bdSupportHT)
+				if (((cur_net->qos_data.supported == 1) &&
+				     cur_net->bssht.bdSupportHT))
 					HTResetSelfAndSavePeerSetting(ieee,
 						 &(ieee->current_network));
 				else
@@ -1829,13 +1828,13 @@ static short probe_rq_parse(struct rtllib_device *ieee, struct sk_buff *skb,
 	struct rtllib_hdr_3addr   *header =
 		(struct rtllib_hdr_3addr   *) skb->data;
 	bool bssid_match;
+	struct rtllib_network *cur_net = &ieee->current_network;
 
 	if (skb->len < sizeof(struct rtllib_hdr_3addr))
 		return -1; /* corrupted */
 
-	bssid_match =
-	  (!ether_addr_equal(header->addr3, ieee->current_network.bssid)) &&
-	  (!is_broadcast_ether_addr(header->addr3));
+	bssid_match = ((!ether_addr_equal(header->addr3, cur_net->bssid)) &&
+		       (!is_broadcast_ether_addr(header->addr3)));
 	if (bssid_match)
 		return -1;
 
@@ -1862,7 +1861,7 @@ static short probe_rq_parse(struct rtllib_device *ieee, struct sk_buff *skb,
 	if (!ssid)
 		return 1; /* ssid not found in tagged param */
 
-	return !strncmp(ssid, ieee->current_network.ssid, ssidlen);
+	return !strncmp(ssid, cur_net->ssid, ssidlen);
 }
 
 static int assoc_rq_parse(struct net_device *dev, struct sk_buff *skb, u8 *dest)
@@ -1887,6 +1886,7 @@ static inline u16 assoc_parse(struct rtllib_device *ieee, struct sk_buff *skb,
 {
 	struct rtllib_assoc_response_frame *response_head;
 	u16 status_code;
+	struct rtllib_network *cur_net = &ieee->current_network;
 
 	if (skb->len <  sizeof(struct rtllib_assoc_response_frame)) {
 		netdev_dbg(ieee->dev, "Invalid len in auth resp: %d\n",
@@ -1901,7 +1901,7 @@ static inline u16 assoc_parse(struct rtllib_device *ieee, struct sk_buff *skb,
 	if ((status_code == WLAN_STATUS_ASSOC_DENIED_RATES ||
 	   status_code == WLAN_STATUS_CAPS_UNSUPPORTED) &&
 	   ((ieee->mode == IEEE_G) &&
-	   (ieee->current_network.mode == IEEE_N_24G) &&
+	   (cur_net->mode == IEEE_N_24G) &&
 	   (ieee->AsocRetryCount++ < (RT_ASOC_RETRY_LIMIT-1)))) {
 		ieee->pHTInfo->IOTAction |= HT_IOT_ACT_PURE_N_MODE;
 	} else {
@@ -1970,6 +1970,7 @@ static short rtllib_sta_ps_sleep(struct rtllib_device *ieee, u64 *time)
 {
 	int timeout;
 	u8 dtim;
+	struct rtllib_network *cur_net = &ieee->current_network;
 	struct rt_pwr_save_ctrl *pPSC = &(ieee->PowerSaveControl);
 
 	if (ieee->LPSDelayCnt) {
@@ -1977,11 +1978,11 @@ static short rtllib_sta_ps_sleep(struct rtllib_device *ieee, u64 *time)
 		return 0;
 	}
 
-	dtim = ieee->current_network.dtim_data;
+	dtim = cur_net->dtim_data;
 	if (!(dtim & RTLLIB_DTIM_VALID))
 		return 0;
-	timeout = ieee->current_network.beacon_interval;
-	ieee->current_network.dtim_data = RTLLIB_DTIM_INVALID;
+	timeout = cur_net->beacon_interval;
+	cur_net->dtim_data = RTLLIB_DTIM_INVALID;
 	/* there's no need to nofity AP that I find you buffered
 	 * with broadcast packet
 	 */
@@ -2009,7 +2010,7 @@ static short rtllib_sta_ps_sleep(struct rtllib_device *ieee, u64 *time)
 			if (pPSC->RegMaxLPSAwakeIntvl == 0)
 				MaxPeriod = 1;
 			else if (pPSC->RegMaxLPSAwakeIntvl == 0xFF)
-				MaxPeriod = ieee->current_network.dtim_period;
+				MaxPeriod = cur_net->dtim_period;
 			else
 				MaxPeriod = pPSC->RegMaxLPSAwakeIntvl;
 			pPSC->LPSAwakeIntvl = (pPSC->LPSAwakeIntvl >=
@@ -2018,8 +2019,8 @@ static short rtllib_sta_ps_sleep(struct rtllib_device *ieee, u64 *time)
 		}
 		{
 			u8 LPSAwakeIntvl_tmp = 0;
-			u8 period = ieee->current_network.dtim_period;
-			u8 count = ieee->current_network.tim.tim_count;
+			u8 period = cur_net->dtim_period;
+			u8 count = cur_net->tim.tim_count;
 
 			if (count == 0) {
 				if (pPSC->LPSAwakeIntvl > period)
@@ -2033,7 +2034,7 @@ static short rtllib_sta_ps_sleep(struct rtllib_device *ieee, u64 *time)
 
 			} else {
 				if (pPSC->LPSAwakeIntvl >
-				    ieee->current_network.tim.tim_count)
+				    cur_net->tim.tim_count)
 					LPSAwakeIntvl_tmp = count +
 					(pPSC->LPSAwakeIntvl - count) -
 					((pPSC->LPSAwakeIntvl-count)%period);
@@ -2041,8 +2042,8 @@ static short rtllib_sta_ps_sleep(struct rtllib_device *ieee, u64 *time)
 					LPSAwakeIntvl_tmp = pPSC->LPSAwakeIntvl;
 			}
 
-		*time = ieee->current_network.last_dtim_sta_time
-			+ msecs_to_jiffies(ieee->current_network.beacon_interval *
+		*time = cur_net->last_dtim_sta_time
+			+ msecs_to_jiffies(cur_net->beacon_interval *
 			LPSAwakeIntvl_tmp);
 	}
 	}
@@ -2211,6 +2212,7 @@ static inline int
 rtllib_rx_assoc_resp(struct rtllib_device *ieee, struct sk_buff *skb,
 		     struct rtllib_rx_stats *rx_stats)
 {
+	struct rtllib_network *cur_net = &ieee->current_network;
 	u16 errcode;
 	int aid;
 	u8 *ies;
@@ -2238,7 +2240,7 @@ rtllib_rx_assoc_resp(struct rtllib_device *ieee, struct sk_buff *skb,
 			/* station support qos */
 			/* Let the register setting default with Legacy station */
 			assoc_resp = (struct rtllib_assoc_response_frame *)skb->data;
-			if (ieee->current_network.qos_data.supported == 1) {
+			if (cur_net->qos_data.supported == 1) {
 				if (rtllib_parse_info_param(ieee, assoc_resp->info_element,
 							rx_stats->len - sizeof(*assoc_resp),
 							network, rx_stats)) {
@@ -2292,6 +2294,7 @@ rtllib_rx_assoc_resp(struct rtllib_device *ieee, struct sk_buff *skb,
 
 static void rtllib_rx_auth_resp(struct rtllib_device *ieee, struct sk_buff *skb)
 {
+	struct rtllib_network *cur_net = &ieee->current_network;
 	u16 errcode;
 	u8 *challenge;
 	int chlen = 0;
@@ -2324,15 +2327,13 @@ static void rtllib_rx_auth_resp(struct rtllib_device *ieee, struct sk_buff *skb)
 		}
 		/* Dummy wirless mode setting to avoid encryption issue */
 		if (bSupportNmode) {
-			ieee->SetWirelessMode(ieee->dev,
-					      ieee->current_network.mode);
+			ieee->SetWirelessMode(ieee->dev, cur_net->mode);
 		} else {
 			/*TODO*/
 			ieee->SetWirelessMode(ieee->dev, IEEE_G);
 		}
 
-		if ((ieee->current_network.mode == IEEE_N_24G) &&
-		    bHalfSupportNmode) {
+		if ((cur_net->mode == IEEE_N_24G) && bHalfSupportNmode) {
 			netdev_info(ieee->dev, "======>enter half N mode\n");
 			ieee->bHalfWirelessN24GMode = true;
 		} else {
@@ -2366,9 +2367,10 @@ static inline int
 rtllib_rx_deauth(struct rtllib_device *ieee, struct sk_buff *skb)
 {
 	struct rtllib_hdr_3addr *header = (struct rtllib_hdr_3addr *) skb->data;
+	struct rtllib_network *cur_net = &ieee->current_network;
 	u16 frame_ctl;
 
-	if (memcmp(header->addr3, ieee->current_network.bssid, ETH_ALEN) != 0)
+	if (memcmp(header->addr3, cur_net->bssid, ETH_ALEN) != 0)
 		return 0;
 
 	/* FIXME for now repeat all the association procedure
@@ -2542,21 +2544,20 @@ void rtllib_wake_all_queues(struct rtllib_device *ieee)
 /* called in user context only */
 static void rtllib_start_master_bss(struct rtllib_device *ieee)
 {
+	struct rtllib_network *cur_net = &ieee->current_network;
 	ieee->assoc_id = 1;
 
-	if (ieee->current_network.ssid_len == 0) {
-		strncpy(ieee->current_network.ssid,
-			RTLLIB_DEFAULT_TX_ESSID,
+	if (cur_net->ssid_len == 0) {
+		strncpy(cur_net->ssid, RTLLIB_DEFAULT_TX_ESSID,
 			IW_ESSID_MAX_SIZE);
 
-		ieee->current_network.ssid_len =
-				 strlen(RTLLIB_DEFAULT_TX_ESSID);
+		cur_net->ssid_len = strlen(RTLLIB_DEFAULT_TX_ESSID);
 		ieee->ssid_set = 1;
 	}
 
-	ether_addr_copy(ieee->current_network.bssid, ieee->dev->dev_addr);
+	ether_addr_copy(cur_net->bssid, ieee->dev->dev_addr);
 
-	ieee->set_chan(ieee->dev, ieee->current_network.channel);
+	ieee->set_chan(ieee->dev, cur_net->channel);
 	ieee->state = RTLLIB_LINKED;
 	ieee->link_change(ieee->dev);
 	notify_wx_assoc_event(ieee);
@@ -2582,6 +2583,8 @@ static void rtllib_start_ibss_wq(void *data)
 {
 	struct rtllib_device *ieee = container_of_dwork_rsl(data,
 				     struct rtllib_device, start_ibss_wq);
+	struct rtllib_network *cur_net = &ieee->current_network;
+
 	/* iwconfig mode ad-hoc will schedule this and return
 	 * on the other hand this will block further iwconfig SET
 	 * operations because of the wx_mutex hold.
@@ -2595,9 +2598,9 @@ static void rtllib_start_ibss_wq(void *data)
 	}
 	mutex_lock(&ieee->wx_mutex);
 
-	if (ieee->current_network.ssid_len == 0) {
-		strcpy(ieee->current_network.ssid, RTLLIB_DEFAULT_TX_ESSID);
-		ieee->current_network.ssid_len = strlen(RTLLIB_DEFAULT_TX_ESSID);
+	if (cur_net->ssid_len == 0) {
+		strcpy(cur_net->ssid, RTLLIB_DEFAULT_TX_ESSID);
+		cur_net->ssid_len = strlen(RTLLIB_DEFAULT_TX_ESSID);
 		ieee->ssid_set = 1;
 	}
 
@@ -2627,57 +2630,49 @@ static void rtllib_start_ibss_wq(void *data)
 	/* the network definitively is not here.. create a new cell */
 	if (ieee->state == RTLLIB_NOLINK) {
 		netdev_info(ieee->dev, "creating new IBSS cell\n");
-		ieee->current_network.channel = ieee->IbssStartChnl;
+		cur_net->channel = ieee->IbssStartChnl;
 		if (!ieee->wap_set)
-			eth_random_addr(ieee->current_network.bssid);
+			eth_random_addr(cur_net->bssid);
 
 		if (ieee->modulation & RTLLIB_CCK_MODULATION) {
 
-			ieee->current_network.rates_len = 4;
+			cur_net->rates_len = 4;
 
-			ieee->current_network.rates[0] =
+			cur_net->rates[0] =
 				 RTLLIB_BASIC_RATE_MASK | RTLLIB_CCK_RATE_1MB;
-			ieee->current_network.rates[1] =
+			cur_net->rates[1] =
 				 RTLLIB_BASIC_RATE_MASK | RTLLIB_CCK_RATE_2MB;
-			ieee->current_network.rates[2] =
+			cur_net->rates[2] =
 				 RTLLIB_BASIC_RATE_MASK | RTLLIB_CCK_RATE_5MB;
-			ieee->current_network.rates[3] =
+			cur_net->rates[3] =
 				 RTLLIB_BASIC_RATE_MASK | RTLLIB_CCK_RATE_11MB;
 
 		} else
-			ieee->current_network.rates_len = 0;
+			cur_net->rates_len = 0;
 
 		if (ieee->modulation & RTLLIB_OFDM_MODULATION) {
-			ieee->current_network.rates_ex_len = 8;
-
-			ieee->current_network.rates_ex[0] =
-						 RTLLIB_OFDM_RATE_6MB;
-			ieee->current_network.rates_ex[1] =
-						 RTLLIB_OFDM_RATE_9MB;
-			ieee->current_network.rates_ex[2] =
-						 RTLLIB_OFDM_RATE_12MB;
-			ieee->current_network.rates_ex[3] =
-						 RTLLIB_OFDM_RATE_18MB;
-			ieee->current_network.rates_ex[4] =
-						 RTLLIB_OFDM_RATE_24MB;
-			ieee->current_network.rates_ex[5] =
-						 RTLLIB_OFDM_RATE_36MB;
-			ieee->current_network.rates_ex[6] =
-						 RTLLIB_OFDM_RATE_48MB;
-			ieee->current_network.rates_ex[7] =
-						 RTLLIB_OFDM_RATE_54MB;
+			cur_net->rates_ex_len = 8;
+
+			cur_net->rates_ex[0] = RTLLIB_OFDM_RATE_6MB;
+			cur_net->rates_ex[1] = RTLLIB_OFDM_RATE_9MB;
+			cur_net->rates_ex[2] = RTLLIB_OFDM_RATE_12MB;
+			cur_net->rates_ex[3] = RTLLIB_OFDM_RATE_18MB;
+			cur_net->rates_ex[4] = RTLLIB_OFDM_RATE_24MB;
+			cur_net->rates_ex[5] = RTLLIB_OFDM_RATE_36MB;
+			cur_net->rates_ex[6] = RTLLIB_OFDM_RATE_48MB;
+			cur_net->rates_ex[7] = RTLLIB_OFDM_RATE_54MB;
 
 			ieee->rate = 108;
 		} else {
-			ieee->current_network.rates_ex_len = 0;
+			cur_net->rates_ex_len = 0;
 			ieee->rate = 22;
 		}
 
-		ieee->current_network.qos_data.supported = 0;
+		cur_net->qos_data.supported = 0;
 		ieee->SetWirelessMode(ieee->dev, IEEE_G);
-		ieee->current_network.mode = ieee->mode;
-		ieee->current_network.atim_window = 0;
-		ieee->current_network.capability = WLAN_CAPABILITY_IBSS;
+		cur_net->mode = ieee->mode;
+		cur_net->atim_window = 0;
+		cur_net->capability = WLAN_CAPABILITY_IBSS;
 	}
 
 	netdev_info(ieee->dev, "%s(): ieee->mode = %d\n", __func__, ieee->mode);
@@ -2913,6 +2908,7 @@ EXPORT_SYMBOL(rtllib_softmac_start_protocol);
 
 void rtllib_start_protocol(struct rtllib_device *ieee)
 {
+	struct rtllib_network *cur_net = &ieee->current_network;
 	short ch = 0;
 	int i = 0;
 
@@ -2923,17 +2919,17 @@ void rtllib_start_protocol(struct rtllib_device *ieee)
 
 	ieee->proto_started = 1;
 
-	if (ieee->current_network.channel == 0) {
+	if (cur_net->channel == 0) {
 		do {
 			ch++;
 			if (ch > MAX_CHANNEL_NUMBER)
 				return; /* no channel found */
 		} while (!ieee->active_channel_map[ch]);
-		ieee->current_network.channel = ch;
+		cur_net->channel = ch;
 	}
 
-	if (ieee->current_network.beacon_interval == 0)
-		ieee->current_network.beacon_interval = 100;
+	if (cur_net->beacon_interval == 0)
+		cur_net->beacon_interval = 100;
 
 	for (i = 0; i < 17; i++) {
 		ieee->last_rxseq_num[i] = -1;
@@ -3136,6 +3132,7 @@ void SendDisassociation(struct rtllib_device *ieee, bool deauth, u16 asRsn)
 
 u8 rtllib_ap_sec_type(struct rtllib_device *ieee)
 {
+	struct rtllib_network *cur_net = &ieee->current_network;
 	static u8 ccmp_ie[4] = {0x00, 0x50, 0xf2, 0x04};
 	static u8 ccmp_rsn_ie[4] = {0x00, 0x0f, 0xac, 0x04};
 	int wpa_ie_len = ieee->wpa_ie_len;
@@ -3143,7 +3140,7 @@ u8 rtllib_ap_sec_type(struct rtllib_device *ieee)
 	int encrypt;
 
 	crypt = ieee->crypt_info.crypt[ieee->crypt_info.tx_keyidx];
-	encrypt = (ieee->current_network.capability & WLAN_CAPABILITY_PRIVACY)
+	encrypt = (cur_net->capability & WLAN_CAPABILITY_PRIVACY)
 		  || (ieee->host_encrypt && crypt && crypt->ops &&
 		  (strcmp(crypt->ops->name, "R-WEP") == 0));
 
@@ -3250,6 +3247,7 @@ EXPORT_SYMBOL(rtllib_MgntDisconnect);
 
 void notify_wx_assoc_event(struct rtllib_device *ieee)
 {
+	struct rtllib_network *cur_net = &ieee->current_network;
 	union iwreq_data wrqu;
 
 	if (ieee->cannot_notify)
@@ -3257,8 +3255,7 @@ void notify_wx_assoc_event(struct rtllib_device *ieee)
 
 	wrqu.ap_addr.sa_family = ARPHRD_ETHER;
 	if (ieee->state == RTLLIB_LINKED)
-		memcpy(wrqu.ap_addr.sa_data, ieee->current_network.bssid,
-		       ETH_ALEN);
+		memcpy(wrqu.ap_addr.sa_data, cur_net->bssid, ETH_ALEN);
 	else {
 
 		netdev_info(ieee->dev, "%s(): Tell user space disconnected\n",
