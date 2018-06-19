Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B95C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DCEE2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+pt9P3x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DCEE2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030709AbeFST61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:58:27 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51844 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030472AbeFST5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:57:01 -0400
Received: by mail-wm0-f65.google.com with SMTP id r15-v6so2295980wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 12:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tKENHwSii1JVamnJ/NG9gg/b6Swyr0mPQSbWVcSkCqw=;
        b=X+pt9P3x2DMVCSQBn/cgGlPp37YnZuMAq0PlYEiTp6jel/7yqNEmluVERgSlHpjHFa
         DFRUzxa/ev1wHSxucx/6DcVridoK1sd2VpOT4ZsU6V/WtvrdrQCo2HCtUZjlR6BzYyC5
         irtp3JJsGBelkYB6hLq5xyOfh1hkH90/toWTuvmzf0rmFss/k1Bj2Z6YoLFCf5fkXqK3
         XX8SqcA1uNHb4rswOufrczG6lLCdpgY3gB11mxhxpNljxpuTamdndDysPXQFGO37P7S8
         5c3GHJAsMQM3f8cLGEAA80yucNejWMJ3c4h22CDRpfOVN0jqgBandIJX2kgas/ckuwTp
         vZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tKENHwSii1JVamnJ/NG9gg/b6Swyr0mPQSbWVcSkCqw=;
        b=Ny9za3qB1bz2hoGxHS0ZikWr6tJDWd4/qoV4D0g0KPBHzTTIZVRYPkTKKaVMRtZXFT
         fTciL7WFJLDvTNAHYuNXI/tXiQFMqrtEJdXP/j6JlrtQIVB48rVAHu3dWXR9xo+ofC58
         Lw1JGm1oPsHYdFGE439xLYPJf32harmFjE4jHtuZB2o09Gbj34MjYNqo0xptvIJ579Xd
         A6IUqo3EyKGrmGwiuU3PRM2VcZlo3zXoxkhM4FJIE+G9oUs9qL4ZJ07o0ZHJK58cCC6A
         9rvXTyZqFM1rBxomd6vkGTv/9WetdxY+Gkv+mlbXIuQ+RMl1piiss39Fb4LmFSqNwJX9
         IvHQ==
X-Gm-Message-State: APt69E2G3TmdVy63TZVTvDheDn2uE+I5214j9zId1fB6/ZWcVen88YWA
        cdlsfG/r1qbJS1piUiqM4ms=
X-Google-Smtp-Source: ADUXVKIR/Cl7RrF0C8TOTHFfZkWkl1Q7xMi+QergVsleSX3UXKSRmMUgQg2Q2cpdBB1gYMZB98ZtGw==
X-Received: by 2002:a1c:4a06:: with SMTP id x6-v6mr8688513wma.89.1529438219900;
        Tue, 19 Jun 2018 12:56:59 -0700 (PDT)
Received: from localhost.localdomain (host86-190-130-185.range86-190.btcentralplus.com. [86.190.130.185])
        by smtp.gmail.com with ESMTPSA id c53-v6sm1105983wrg.12.2018.06.19.12.56.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 12:56:59 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 3/9] staging: rtl8192u: Truncate block comments to 80 character length - Style
Date:   Tue, 19 Jun 2018 20:55:59 +0100
Message-Id: <20180619195605.31321-4-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619195605.31321-1-johnfwhitmore@gmail.com>
References: <20180619195605.31321-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Where possible truncation of block comments to the 80 character length
prefered by the coding style.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../rtl8192u/ieee80211/rtl819x_HTProc.c       | 157 +++++++++++-------
 1 file changed, 98 insertions(+), 59 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 4bfadb49c363..40dcb4105e78 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 
-//As this function is mainly ported from Windows driver, so leave the name little changed. If any confusion caused, tell me. Created by WB. 2008.05.08
+/*
+ * As this function is mainly ported from Windows driver, so leave the name
+ * little changed. If any confusion caused, tell me. Created by WB. 2008.05.08
+ */
 #include "ieee80211.h"
 #include "rtl819x_HT.h"
 u8 MCS_FILTER_ALL[16] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x1f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
@@ -42,8 +45,8 @@ static u8 AIRLINK_RALINK[3] = {0x00, 0x18, 0x02};
 //static u8 DLINK_ATHEROS[3] = {0x00, 0x1c, 0xf0};
 static u8 CISCO_BROADCOM[3] = {0x00, 0x17, 0x94};
 /*
- * 2008/04/01 MH For Cisco G mode RX TP We need to change FW duration. Should we put the
- * code in other place??
+ * 2008/04/01 MH For Cisco G mode RX TP We need to change FW duration. Should we
+ * put the code in other place??
  * static u8 WIFI_CISCO_G_AP[3] = {0x00, 0x40, 0x96};
  */
 /*
@@ -95,8 +98,9 @@ void HTUpdateDefaultSetting(struct ieee80211_device *ieee)
 	pMgntInfo->bTxEnableFwCalcDur = (BOOLEAN)pNdisCommon->bRegTxEnableFwCalcDur;
 #endif
 	/*
-	 * 8190 only, Realtek proprietary aggregation mode
-	 * Set MPDUDensity=2,   1: Set MPDUDensity=2(32k)  for Realtek AP and set MPDUDensity=0(8k) for others
+	 * 8190 only, Realtek proprietary aggregation mode Set MPDUDensity=2,   
+	 * 1: Set MPDUDensity=2(32k) for Realtek AP 
+	 * and set MPDUDensity=0(8k) for others
 	 */
 	pHTInfo->bRegRT2RTAggregation = 1;//0: Set MPDUDensity=2,   1: Set MPDUDensity=2(32k)  for Realtek AP and set MPDUDensity=0(8k) for others
 
@@ -117,7 +121,8 @@ void HTUpdateDefaultSetting(struct ieee80211_device *ieee)
 }
 
 /*
- *function:  This function print out each field on HT capability IE mainly from (Beacon/ProbeRsp/AssocReq)
+ *function:  This function print out each field on HT capability 
+ *           IE mainly from (Beacon/ProbeRsp/AssocReq)
  *   input:  u8*	CapIE       //Capability IE to be printed out
  *	     u8*	TitleString //mainly print out caller function
  *  output:  none
@@ -151,7 +156,8 @@ void HTDebugHTCapability(u8 *CapIE, u8 *TitleString)
 }
 
 /*
- *function:  This function print out each field on HT Information IE mainly from (Beacon/ProbeRsp)
+ *function:  This function print out each field on HT Information
+ *           IE mainly from (Beacon/ProbeRsp)
  *   input:  u8*	InfoIE       //Capability IE to be printed out
  *	     u8*	TitleString //mainly print out caller function
  *  output:  none
@@ -387,7 +393,8 @@ static void HTIOTPeerDetermine(struct ieee80211_device *ieee)
 }
 
 /*
- *function:  Check whether driver should declare received rate up to MCS13 only since some chipset is not good
+ *function:  Check whether driver should declare received rate up to MCS13 
+ *           only since some chipset is not good
  *	     at receiving MCS14~15 frame from some AP.
  *   input:  struct ieee80211_device*	ieee
  *	     u8 *			PeerMacAddr
@@ -402,7 +409,8 @@ static u8 HTIOTActIsDisableMCS14(struct ieee80211_device *ieee, u8 *PeerMacAddr)
 /*
  * Function:	HTIOTActIsDisableMCS15
  *
- * Overview:	Check whether driver should declare capability of receiving MCS15
+ * Overview:	Check whether driver should declare capability of receiving 
+ *              MCS15
  *
  * Input:
  *			PADAPTER		Adapter,
@@ -439,7 +447,8 @@ static bool HTIOTActIsDisableMCS15(struct ieee80211_device *ieee)
 /*
  * Function:	HTIOTActIsDisableMCSTwoSpatialStream
  *
- * Overview:	Check whether driver should declare capability of receiving All 2 ss packets
+ * Overview:	Check whether driver should declare capability of receiving 
+ *              All 2 ss packets
  *
  * Input:
  *			PADAPTER		Adapter,
@@ -462,7 +471,8 @@ static bool HTIOTActIsDisableMCSTwoSpatialStream(struct ieee80211_device *ieee,
  *   input:  struct ieee80211_device*	ieee
  *	     u8*			PeerMacAddr
  *  output:  none
- *  return:  return 1 if driver should disable EDCA turbo mode(otherwise return 0)
+ *  return:  return 1 if driver should disable EDCA turbo mode
+ *           (otherwise return 0)
  */
 static u8 HTIOTActIsDisableEDCATurbo(struct ieee80211_device *ieee,
 				     u8 *PeerMacAddr)
@@ -471,7 +481,8 @@ static u8 HTIOTActIsDisableEDCATurbo(struct ieee80211_device *ieee,
 }
 
 /*
- *function:  Check whether we need to use OFDM to sned MGNT frame for broadcom AP
+ *function:  Check whether we need to use OFDM to send MGNT frame for 
+ *           broadcom AP
  *   input:  struct ieee80211_network *network   //current network we live
  *  output:  none
  *  return:  return 1 if true
@@ -480,9 +491,13 @@ static u8 HTIOTActIsMgntUseCCK6M(struct ieee80211_network *network)
 {
 	u8	retValue = 0;
 
-	// 2008/01/25 MH Judeg if we need to use OFDM to sned MGNT frame for broadcom AP.
-	// 2008/01/28 MH We must prevent that we select null bssid to link.
-
+	/*
+	 * 2008/01/25 MH Judeg if we need to use OFDM to sned MGNT frame for
+	 * broadcom AP.
+	 */
+	/*
+	 * 2008/01/28 MH We must prevent that we select null bssid to link.
+	 */
 	if (network->broadcom_cap_exist)
 		retValue = 1;
 
@@ -510,9 +525,9 @@ void HTResetIOTSetting(PRT_HIGH_THROUGHPUT pHTInfo)
 /*
  *function:  Construct Capablility Element in Beacon... if HTEnable is turned on
  *   input:  struct ieee80211_device*	ieee
- *	     u8*			posHTCap //pointer to store Capability Ele
- *	     u8*			len //store length of CE
- *	     u8				IsEncrypt //whether encrypt, needed further
+ *	     u8*		     posHTCap //pointer to store Capability Ele
+ *	     u8*		     len //store length of CE
+ *	     u8			     IsEncrypt //whether encrypt, needed further
  *  output:  none
  *  return:  none
  *  notice:  posHTCap can't be null and should be initialized before.
@@ -551,7 +566,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	pCapELE->ShortGI20Mhz		= 1; // We can receive Short GI!!
 	pCapELE->ShortGI40Mhz		= 1; // We can receive Short GI!!
 	//DbgPrint("TX HT cap/info ele BW=%d SG20=%d SG40=%d\n\r",
-		//pCapELE->ChlWidth, pCapELE->ShortGI20Mhz, pCapELE->ShortGI40Mhz);
+	//pCapELE->ChlWidth, pCapELE->ShortGI20Mhz, pCapELE->ShortGI40Mhz);
 	pCapELE->TxSTBC			= 1;
 	pCapELE->RxSTBC			= 0;
 	pCapELE->DelayBA		= 0;	// Do not support now!!
@@ -587,7 +602,8 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 
 	/*
 	 * 2008.06.12
-	 * For RTL819X, if pairwisekey = wep/tkip, ap is ralink, we support only MCS0~7.
+	 * For RTL819X, if pairwisekey = wep/tkip, ap is ralink, 
+	 * we support only MCS0~7.
 	 */
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev)) {
 		int i;
@@ -612,19 +628,23 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 
 //	IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA | IEEE80211_DL_HT, posHTCap, *len -2);
 
-	//Print each field in detail. Driver should not print out this message by default
+	/*
+	 * Print each field in detail. Driver should not print out this
+	 * message by default
+	 */
 //	HTDebugHTCapability(posHTCap, (u8*)"HTConstructCapability()");
 }
 
 /*
- *function:  Construct  Information Element in Beacon... if HTEnable is turned on
+ *function:  Construct Information Element in Beacon... if HTEnable is turned on
  *   input:  struct ieee80211_device*	ieee
- *	     u8*			posHTCap //pointer to store Information Ele
- *	     u8*			len   //store len of
- *	     u8				IsEncrypt //whether encrypt, needed further
+ *	     u8*		    posHTCap //pointer to store Information Ele
+ *	     u8*		    len   //store len of
+ *	     u8			    IsEncrypt //whether encrypt, needed further
  *  output:  none
  *  return:  none
- *  notice:  posHTCap can't be null and be initialized before. only AP and IBSS sta should do this
+ *  notice:  posHTCap can't be null and be initialized before.
+             Only AP and IBSS sta should do this
  */
 void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *len, u8 IsEncrypt)
 {
@@ -666,16 +686,17 @@ void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *le
 }
 
 /*
- *  According to experiment, Realtek AP to STA (based on rtl8190) may achieve best performance
- *  if both STA and AP set limitation of aggregation size to 32K, that is, set AMPDU density to 2
- *  (Ref: IEEE 11n specification). However, if Realtek STA associates to other AP, STA should set
- *  limitation of aggregation size to 8K, otherwise, performance of traffic stream from STA to AP
- *  will be much less than the traffic stream from AP to STA if both of the stream runs concurrently
- *  at the same time.
+ * According to experiment, Realtek AP to STA (based on rtl8190) may achieve
+ * best performance if both STA and AP set limitation of aggregation size to
+ * 32K, that is, set AMPDU density to 2 (Ref: IEEE 11n specification). However,
+ * if Realtek STA associates to other AP, STA should set limitation of
+ * aggregation size to 8K, otherwise, performance of traffic stream from STA to
+ * AP will be much less than the traffic stream from AP to STA if both of the
+ * stream runs concurrently at the same time.
  *
  *  Frame Format
- *  Element ID		Length		OUI			Type1		Reserved
- *  1 byte			1 byte		3 bytes		1 byte		1 byte
+ *  Element ID		Length		OUI		Type1		Reserved
+ *  1 byte		1 byte		3 bytes		1 byte		1 byte
  *
  *  OUI		= 0x00, 0xe0, 0x4c,
  *  Type	= 0x02
@@ -735,8 +756,8 @@ void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg,
 
 /*
  *function:  Pick the right Rate Adaptive table to use
- *   input:  struct ieee80211_device*	ieee
- *	     u8*			pOperateMCS //A pointer to MCS rate bitmap
+ *   input:  struct ieee80211_device* ieee
+ *	     u8*		      pOperateMCS //A pointer to MCS rate bitmap
  *  return:  always we return true
  *  notice:
  */
@@ -781,14 +802,15 @@ static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
 }
 
 /*
- *	Description:
- *		This function will get the highest speed rate in input MCS set.
+ * Description:
+ *	This function will get the highest speed rate in input MCS set.
  *
- *	/param	Adapter			Pionter to Adapter entity
- *			pMCSRateSet		Pointer to MCS rate bitmap
- *			pMCSFilter		Pointer to MCS rate filter
+ * /param	Adapter			Pionter to Adapter entity
+ *		pMCSRateSet		Pointer to MCS rate bitmap
+ *		pMCSFilter		Pointer to MCS rate filter
  *
- *	/return	Highest MCS rate included in pMCSRateSet and filtered by pMCSFilter.
+ * /return	Highest MCS rate included in pMCSRateSet and filtered by
+ *              pMCSFilter.
  *
  */
 /*
@@ -853,11 +875,15 @@ static u8 HTFilterMCSRate(struct ieee80211_device *ieee, u8 *pSupportMCS,
 		pOperateMCS[i] = ieee->Regdot11HTOperationalRateSet[i] & pSupportMCS[i];
 	}
 
-	// TODO: adjust our operational rate set  according to our channel bandwidth, STBC and Antenna number
+	/*
+	 * TODO: adjust our operational rate set  according to our channel
+	 * bandwidth, STBC and Antenna number
+	 */
 
 	/*
-	 * TODO: fill suggested rate adaptive rate index and give firmware info using Tx command packet
-	 * we also shall suggested the first start rate set according to our singal strength
+	 * TODO: fill suggested rate adaptive rate index and give firmware info
+	 * using Tx command packet we also shall suggested the first start rate
+	 * set according to our singal strength
 	 */
 	HT_PickMCSRate(ieee, pOperateMCS);
 
@@ -971,12 +997,17 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 			pHTInfo->CurrentAMPDUFactor = pHTInfo->AMPDU_Factor;
 	} else {
 		/*
-		 * Set MPDU density to 2 to Realtek AP, and set it to 0 for others
-		 * Replace MPDU factor declared in original association response frame format. 2007.08.20 by Emily
+		 * Set MPDU density to 2 to Realtek AP, 
+		 * and set it to 0 for others
+		 * Replace MPDU factor declared in original association
+		 * response frame format. 2007.08.20 by Emily
 		 */
 		if (ieee->current_network.bssht.bdRT2RTAggregation) {
 			if (ieee->pairwise_key_type != KEY_TYPE_NA)
-				// Realtek may set 32k in security mode and 64k for others
+				/*
+				 * Realtek may set 32k in security mode and 64k
+				 * for others
+				 */
 				pHTInfo->CurrentAMPDUFactor = pPeerHTCap->MaxRxAMPDUFactor;
 			else
 				pHTInfo->CurrentAMPDUFactor = HT_AGG_SIZE_64K;
@@ -1016,7 +1047,8 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	/*
 	 * Filter out unsupported HT rate for this AP
 	 * Update RATR table
-	 * This is only for 8190 ,8192 or later product which using firmware to handle rate adaptive mechanism.
+	 * This is only for 8190 ,8192 or later product which using firmware to
+	 * handle rate adaptive mechanism.
 	 */
 
 	/*
@@ -1053,7 +1085,9 @@ void HTSetConnectBwModeCallback(struct ieee80211_device *ieee);
  *   input:  struct ieee80211_device*	ieee
  *  output:  none
  *  return:  none
- *  notice: This function is called when *  (1) MPInitialization Phase *  (2) Receiving of Deauthentication from AP
+ *  notice: This function is called when
+ *                              *  (1) MPInitialization Phase
+ *                              *  (2) Receiving of Deauthentication from AP
  */
 // TODO: Should this funciton be called when receiving of Disassociation?
 void HTInitializeHTInfo(struct ieee80211_device *ieee)
@@ -1078,8 +1112,8 @@ void HTInitializeHTInfo(struct ieee80211_device *ieee)
 	/*
 	 * CCK rate support
 	 * This flag is set to true to support CCK rate by default.
-	 * It will be affected by "pHTInfo->bRegSuppCCK" and AP capabilities only when associate to
-	 * 11N BSS.
+	 * It will be affected by "pHTInfo->bRegSuppCCK" and AP capabilities 
+	 * only when associate to 11N BSS.
 	 */
 	pHTInfo->bCurSuppCCK = true;
 
@@ -1143,7 +1177,8 @@ void HTInitializeBssDesc(PBSS_HT pBssHT)
 /*
  *function:  initialize Bss HT structure(struct PBSS_HT)
  *   input:  struct ieee80211_device	*ieee
- *	     struct ieee80211_network	*pNetwork //usually current network we are live in
+ *	     struct ieee80211_network	*pNetwork //usually current network 
+ *                                                  we are live in
  *  output:  none
  *  return:  none
  *  notice: This function should ONLY be called before association
@@ -1161,7 +1196,10 @@ void HTResetSelfAndSavePeerSetting(struct ieee80211_device *ieee,	struct ieee802
 	//  Save Peer Setting before Association
 	//
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "==============>%s()\n", __func__);
-	/*unmark bEnableHT flag here is the same reason why unmarked in function ieee80211_softmac_new_net. WB 2008.09.10*/
+	/*
+	 * unmark bEnableHT flag here is the same reason why unmarked in 
+	 * function ieee80211_softmac_new_net. WB 2008.09.10
+	 */
 //	if( pHTInfo->bEnableHT &&  pNetwork->bssht.bdSupportHT)
 	if (pNetwork->bssht.bdSupportHT) {
 		pHTInfo->bCurrentHTSupport = true;
@@ -1188,7 +1226,8 @@ void HTResetSelfAndSavePeerSetting(struct ieee80211_device *ieee,	struct ieee802
 
 		/*
 		 * Decide IOT Action
-		 * Must be called after the parameter of pHTInfo->bCurrentRT2RTAggregation is decided
+		 * Must be called after the parameter of 
+		 * pHTInfo->bCurrentRT2RTAggregation is decided
 		 */
 		pHTInfo->IOTAction = 0;
 		bIOTAction = HTIOTActIsDisableMCS14(ieee, pNetwork->bssid);
@@ -1303,10 +1342,10 @@ void HTSetConnectBwMode(struct ieee80211_device *ieee, HT_CHANNEL_WIDTH	Bandwidt
 	pHTInfo->bSwBwInProgress = true;
 
 	/*
-	 * TODO: 2007.7.13 by Emily Wait 2000ms  in order to guarantee that switching
-	 *   bandwidth is executed after scan is finished. It is a temporal solution
-	 *   because software should ganrantee the last operation of switching bandwidth
-	 *   is executed properlly.
+	 * TODO: 2007.7.13 by Emily Wait 2000ms  in order to guarantee that
+	 *   switching bandwidth is executed after scan is finished. It is a
+	 *   temporal solution because software should ganrantee the last
+	 *   operation of switching bandwidth is executed properlly.
 	 */
 	HTSetConnectBwModeCallback(ieee);
 
-- 
2.17.1

