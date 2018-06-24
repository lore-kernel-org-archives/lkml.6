Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7444DC43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 09:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21DDE24E7F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 09:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWr6ARpa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21DDE24E7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752506AbeFXJ7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 05:59:34 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38531 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752123AbeFXJ6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 05:58:19 -0400
Received: by mail-wm0-f66.google.com with SMTP id 69-v6so6870150wmf.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 02:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wdAHNB5Sh3BSZjkHiZFOqk5BY6nJEA/W0qI8OP7EpiU=;
        b=eWr6ARpaDKgH4zwBLabNrkESwDF+l2oNKv0L6vnNm34yFcwkHDo/HVLX8zdtkWw5hG
         IGkC9lB9jxGHR/+c6f9NOOJKa5lz1NnS4izW2hBJRMI5t39auMJrHTEOg2DEb6zEqWqZ
         7IkF1Lt3kls8CVDNhrs60mIMk6x1PyeuYDUcTNLIH0oax/NPgPeQ9pDk/aVAH1nbJZgY
         CaV/Df1xT7TdhzIjCo0lqjDMqqgbVePbeVP000ATqRhSCntgYVzWjUgVKRRt2B49TJfQ
         wreLHnao9/LEHmQo5ODriL+gSXqf5iO/+Yge6Gbi5pWhj+X3kcU6Fanb9zE0rxirsRMn
         /vog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wdAHNB5Sh3BSZjkHiZFOqk5BY6nJEA/W0qI8OP7EpiU=;
        b=pmq9dAco6PtDvrsVHtBmlGZnfMi+mC4GouiJ+BhOpQqjnELgkXBgCB7AZdVlzp0wTA
         CwiLy9eFMO5SLaf0bRm0RivbKoW/cbUzti2IHhEarJ4kRa/IiluQaPBvQGUM9spvr1hh
         EsZkcgX3XEwO6mbMPO3YGvtc34y3jBVjfh8cKqHCJVz5bGzISSd7pfPjkshY/B9eTPhX
         1P5a1j/uQ0glHB5/JKTwmYa00GA36mxF0zJX8CwCp6YUs2Ue9yzHL4FceVLPTXK+oLvz
         hftApKTAbyjYl5qcu17kTWnZJofehZpY3toeREpi24neWmFJ/qqx4PV3ENehUqIhGse3
         shaw==
X-Gm-Message-State: APt69E3oFoeINoOw51lK8/66fz5qWe9TnulxW9ZtnhBGphPEdeGIGo5Y
        U5ekzxuyKQfjJmcw2MsjDnYDxg==
X-Google-Smtp-Source: ADUXVKJa3+ft9s4/J6O1rOxl2m/igmgn+boqCguUv2XWF2wui0LvmgAUSeCXRmwKf+dOqX1PHMC1rg==
X-Received: by 2002:a1c:3610:: with SMTP id d16-v6mr6741657wma.126.1529834297907;
        Sun, 24 Jun 2018 02:58:17 -0700 (PDT)
Received: from localhost.localdomain (host86-190-130-185.range86-190.btcentralplus.com. [86.190.130.185])
        by smtp.gmail.com with ESMTPSA id u4-v6sm4468328wmc.1.2018.06.24.02.58.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jun 2018 02:58:17 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 4/8] staging: rtl8192u: Truncate block comments to 80 character length - Style
Date:   Sun, 24 Jun 2018 10:57:28 +0100
Message-Id: <20180624095732.12082-5-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180624095732.12082-1-johnfwhitmore@gmail.com>
References: <20180624095732.12082-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Where possible truncation of block comments to the 80 character length
preferred by the coding style.

In a previous version of this commit some of the comments were contentious so
those have not been touched in this version.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../rtl8192u/ieee80211/rtl819x_HTProc.c       | 108 +++++++++++-------
 1 file changed, 64 insertions(+), 44 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index bbac9d04c23e..604b393d856f 100644
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
@@ -117,7 +120,8 @@ void HTUpdateDefaultSetting(struct ieee80211_device *ieee)
 }
 
 /*
- *function:  This function print out each field on HT capability IE mainly from (Beacon/ProbeRsp/AssocReq)
+ *function:  This function print out each field on HT capability
+ *           IE mainly from (Beacon/ProbeRsp/AssocReq)
  *   input:  u8*	CapIE       //Capability IE to be printed out
  *	     u8*	TitleString //mainly print out caller function
  *  output:  none
@@ -151,7 +155,8 @@ void HTDebugHTCapability(u8 *CapIE, u8 *TitleString)
 }
 
 /*
- *function:  This function print out each field on HT Information IE mainly from (Beacon/ProbeRsp)
+ *function:  This function print out each field on HT Information
+ *           IE mainly from (Beacon/ProbeRsp)
  *   input:  u8*	InfoIE       //Capability IE to be printed out
  *	     u8*	TitleString //mainly print out caller function
  *  output:  none
@@ -387,8 +392,9 @@ static void HTIOTPeerDetermine(struct ieee80211_device *ieee)
 }
 
 /*
- *function:  Check whether driver should declare received rate up to MCS13 only since some chipset is not good
- *	     at receiving MCS14~15 frame from some AP.
+ *function:  Check whether driver should declare received rate up to MCS13
+ *           only since some chipset is not good at receiving MCS14~15 frame
+ *           from some AP.
  *   input:  struct ieee80211_device*	ieee
  *	     u8 *			PeerMacAddr
  *  output:  none
@@ -402,7 +408,8 @@ static u8 HTIOTActIsDisableMCS14(struct ieee80211_device *ieee, u8 *PeerMacAddr)
 /*
  * Function:	HTIOTActIsDisableMCS15
  *
- * Overview:	Check whether driver should declare capability of receiving MCS15
+ * Overview:	Check whether driver should declare capability of receiving
+ *              MCS15
  *
  * Input:
  *			PADAPTER		Adapter,
@@ -439,7 +446,8 @@ static bool HTIOTActIsDisableMCS15(struct ieee80211_device *ieee)
 /*
  * Function:	HTIOTActIsDisableMCSTwoSpatialStream
  *
- * Overview:	Check whether driver should declare capability of receiving All 2 ss packets
+ * Overview:	Check whether driver should declare capability of receiving
+ *              All 2 ss packets
  *
  * Input:
  *			PADAPTER		Adapter,
@@ -462,7 +470,8 @@ static bool HTIOTActIsDisableMCSTwoSpatialStream(struct ieee80211_device *ieee,
  *   input:  struct ieee80211_device*	ieee
  *	     u8*			PeerMacAddr
  *  output:  none
- *  return:  return 1 if driver should disable EDCA turbo mode(otherwise return 0)
+ *  return:  return 1 if driver should disable EDCA turbo mode
+ *           (otherwise return 0)
  */
 static u8 HTIOTActIsDisableEDCATurbo(struct ieee80211_device *ieee,
 				     u8 *PeerMacAddr)
@@ -471,7 +480,8 @@ static u8 HTIOTActIsDisableEDCATurbo(struct ieee80211_device *ieee,
 }
 
 /*
- *function:  Check whether we need to use OFDM to sned MGNT frame for broadcom AP
+ *function:  Check whether we need to use OFDM to sned MGNT frame for
+ *           broadcom AP
  *   input:  struct ieee80211_network *network   //current network we live
  *  output:  none
  *  return:  return 1 if true
@@ -510,9 +520,9 @@ void HTResetIOTSetting(PRT_HIGH_THROUGHPUT pHTInfo)
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
@@ -551,7 +561,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	pCapELE->ShortGI20Mhz		= 1; // We can receive Short GI!!
 	pCapELE->ShortGI40Mhz		= 1; // We can receive Short GI!!
 	//DbgPrint("TX HT cap/info ele BW=%d SG20=%d SG40=%d\n\r",
-		//pCapELE->ChlWidth, pCapELE->ShortGI20Mhz, pCapELE->ShortGI40Mhz);
+	//pCapELE->ChlWidth, pCapELE->ShortGI20Mhz, pCapELE->ShortGI40Mhz);
 	pCapELE->TxSTBC			= 1;
 	pCapELE->RxSTBC			= 0;
 	pCapELE->DelayBA		= 0;	// Do not support now!!
@@ -612,19 +622,23 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 
 //	IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA | IEEE80211_DL_HT, posHTCap, *len -2);
 
-	//Print each field in detail. Driver should not print out this message by default
+	/*
+         * Print each field in detail. Driver should not print out this message
+         * by default
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
+ *	     u8*		     posHTCap //pointer to store Information Ele
+ *	     u8*		     len   //store len of
+ *	     u8			     IsEncrypt //whether encrypt, needed further
  *  output:  none
  *  return:  none
- *  notice:  posHTCap can't be null and be initialized before. only AP and IBSS sta should do this
+ *  notice:  posHTCap can't be null and be initialized before.
+ *           only AP and IBSS sta should do this
  */
 void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *len, u8 IsEncrypt)
 {
@@ -666,16 +680,17 @@ void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *le
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
+ * 32K, that is, set AMPDU density to 2 (Ref: IEEE 11n specification).
+ * However, if Realtek STA associates to other AP, STA should set limitation of
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
@@ -686,8 +701,8 @@ void HTConstructInfoElement(struct ieee80211_device *ieee, u8 *posHTInfo, u8 *le
 /*
  *function:  Construct  Information Element in Beacon... in RT2RT condition
  *   input:  struct ieee80211_device*	ieee
- *	     u8*			posRT2RTAgg //pointer to store Information Ele
- *	     u8*			len   //store len
+ *	     u8*		  posRT2RTAgg //pointer to store Information Ele
+ *	     u8*		  len   //store len
  *  output:  none
  *  return:  none
  *  notice:
@@ -735,8 +750,8 @@ void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg,
 
 /*
  *function:  Pick the right Rate Adaptive table to use
- *   input:  struct ieee80211_device*	ieee
- *	     u8*			pOperateMCS //A pointer to MCS rate bitmap
+ *   input:  struct ieee80211_device* ieee
+ *	     u8*		      pOperateMCS //A pointer to MCS rate bitmap
  *  return:  always we return true
  *  notice:
  */
@@ -853,8 +868,9 @@ static u8 HTFilterMCSRate(struct ieee80211_device *ieee, u8 *pSupportMCS,
 	// TODO: adjust our operational rate set  according to our channel bandwidth, STBC and Antenna number
 
 	/*
-	 * TODO: fill suggested rate adaptive rate index and give firmware info using Tx command packet
-	 * we also shall suggested the first start rate set according to our singal strength
+	 * TODO: fill suggested rate adaptive rate index and give firmware info
+	 * using Tx command packet we also shall suggested the first start rate
+	 * set according to our singal strength
 	 */
 	HT_PickMCSRate(ieee, pOperateMCS);
 
@@ -1013,7 +1029,8 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	/*
 	 * Filter out unsupported HT rate for this AP
 	 * Update RATR table
-	 * This is only for 8190 ,8192 or later product which using firmware to handle rate adaptive mechanism.
+	 * This is only for 8190 ,8192 or later product which using firmware to
+	 * handle rate adaptive mechanism.
 	 */
 
 	/*
@@ -1050,7 +1067,9 @@ void HTSetConnectBwModeCallback(struct ieee80211_device *ieee);
  *   input:  struct ieee80211_device*	ieee
  *  output:  none
  *  return:  none
- *  notice: This function is called when *  (1) MPInitialization Phase *  (2) Receiving of Deauthentication from AP
+ *  notice: This function is called when 
+ *                                  *  (1) MPInitialization Phase
+ *                                  *  (2) Receiving of Deauthentication from AP
  */
 // TODO: Should this funciton be called when receiving of Disassociation?
 void HTInitializeHTInfo(struct ieee80211_device *ieee)
@@ -1075,8 +1094,8 @@ void HTInitializeHTInfo(struct ieee80211_device *ieee)
 	/*
 	 * CCK rate support
 	 * This flag is set to true to support CCK rate by default.
-	 * It will be affected by "pHTInfo->bRegSuppCCK" and AP capabilities only when associate to
-	 * 11N BSS.
+	 * It will be affected by "pHTInfo->bRegSuppCCK" and AP capabilities
+	 * only when associate to 11N BSS.
 	 */
 	pHTInfo->bCurSuppCCK = true;
 
@@ -1140,7 +1159,8 @@ void HTInitializeBssDesc(PBSS_HT pBssHT)
 /*
  *function:  initialize Bss HT structure(struct PBSS_HT)
  *   input:  struct ieee80211_device	*ieee
- *	     struct ieee80211_network	*pNetwork //usually current network we are live in
+ *	     struct ieee80211_network	*pNetwork //usually current network
+ *                                                  we are live in
  *  output:  none
  *  return:  none
  *  notice: This function should ONLY be called before association
@@ -1300,10 +1320,10 @@ void HTSetConnectBwMode(struct ieee80211_device *ieee, HT_CHANNEL_WIDTH	Bandwidt
 	pHTInfo->bSwBwInProgress = true;
 
 	/*
-	 * TODO: 2007.7.13 by Emily Wait 2000ms  in order to guarantee that switching
-	 *   bandwidth is executed after scan is finished. It is a temporal solution
-	 *   because software should ganrantee the last operation of switching bandwidth
-	 *   is executed properlly.
+	 * TODO: 2007.7.13 by Emily Wait 2000ms  in order to guarantee that
+	 * switching bandwidth is executed after scan is finished. It is a
+	 * temporal solution because software should ganrantee the last
+	 * operation of switching bandwidth is executed properlly.
 	 */
 	HTSetConnectBwModeCallback(ieee);
 
-- 
2.17.1

