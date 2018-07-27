Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163EBC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5DB20842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R20st2wt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB5DB20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389143AbeG0Syk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:54:40 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38976 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388739AbeG0Syj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:54:39 -0400
Received: by mail-wr1-f67.google.com with SMTP id h10-v6so5789622wre.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 10:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9lRYmucztTNYuL0QYZztsdrEDwwhzQUIBulbIFnXkG0=;
        b=R20st2wts7YDGX0r8u/gRFMFfwwp+ntpLatykN9gLRYyot71YOv4FEcNDRuThmfd6E
         63aQYhGrjmzzGkkDyfxe4NuobsVGrPyQm1S3ooVAFpRW2raOqs6L05v+ctlo/TZ0Gtud
         KZJ4/1ztdJ3ISvnLKg/qGmKx3P6MtF+E8Xi720iBdjWZmUvkhE1eXdypTMAJMgAtfU3J
         ij6vvUJR5b6AJRvZ/OxdSUBVeinv08xMJ21xjLinyclOsisQUwOg/gDYHRBOu9tFHAnQ
         I8yr1S+onNqyx9aZc9sQUZNSejkzLYlVpQB3WV6q+TeV2P9bLfoj7BzMaLWmdCBEcbQ3
         o26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9lRYmucztTNYuL0QYZztsdrEDwwhzQUIBulbIFnXkG0=;
        b=Cu31MHApBatmyXnvTjaBeEXPjvcAF+6O0QKqrExgOSD1fHB3COYGEuwJfn+RlMsysg
         pHjv+tnmjoB+kbcF4vI3QzNyyLwsgEK+aIowLmlVc2H5VMlqT+eZthIW7qB22s4Rf+F1
         bM+eroXkR1/tiI2bvu/uFHC9X5ITqfxEe+ZdjMEDH5fMPZKLSOQo4LhDfUgFPEegsoTF
         XLsPbPLahqTO/dkmkarY8grCytHJbetCYyC6ejKLN6ki/5oTPqIvKZBDfV/reCoZ6U97
         8yxQZMrz+rHMx9aot7YpltKQithKvGCR3DN5Ee0casAW+YJnx+Uui3tXEn6kEew6QAKI
         TTMw==
X-Gm-Message-State: AOUpUlGdFsZyQxTw8uJVFtgoxXFI0xBIYTBFwTdYACopxV8RGmXpHAf9
        aAwbuH4th8h3NFcbkCqQcA0sXaCqSd8=
X-Google-Smtp-Source: AAOMgpdbmko3Ul0zSBcaF/lq5K+Tu2RPg7DK7dPJg5U71KJjlhB5r9NgTNSR7lj0sXr9bgo6yhALgA==
X-Received: by 2002:a5d:4210:: with SMTP id n16-v6mr5398965wrq.55.1532712704940;
        Fri, 27 Jul 2018 10:31:44 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id z3-v6sm6000010wru.27.2018.07.27.10.31.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 10:31:44 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 04/20] staging:rtl8192u: Rename TxPendingBARecord - Style
Date:   Fri, 27 Jul 2018 18:31:07 +0100
Message-Id: <20180727173123.27391-5-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727173123.27391-1-johnfwhitmore@gmail.com>
References: <20180727173123.27391-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the member variable TxPendingBARecord to tx_pending_ba_record.
This change clears the checkpatch issue with CamelCase naming.

The changes are purely coding style changes and should not impact
runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c | 12 ++++++------
 drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h     |  2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c |  4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
index b217310f9875..55b989d71ab8 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
@@ -43,7 +43,7 @@ static void DeActivateBAEntry(struct ieee80211_device *ieee, PBA_RECORD pBA)
 static u8 TxTsDeleteBA(struct ieee80211_device *ieee, struct tx_ts_record *pTxTs)
 {
 	PBA_RECORD		pAdmittedBa = &pTxTs->TxAdmittedBARecord;  //These two BA entries must exist in TS structure
-	PBA_RECORD		pPendingBa = &pTxTs->TxPendingBARecord;
+	PBA_RECORD		pPendingBa = &pTxTs->tx_pending_ba_record;
 	u8			bSendDELBA = false;
 
 	// Delete pending BA
@@ -470,7 +470,7 @@ int ieee80211_rx_ADDBARsp(struct ieee80211_device *ieee, struct sk_buff *skb)
 	}
 
 	pTS->bAddBaReqInProgress = false;
-	pPendingBA = &pTS->TxPendingBARecord;
+	pPendingBA = &pTS->tx_pending_ba_record;
 	pAdmittedBA = &pTS->TxAdmittedBARecord;
 
 
@@ -615,7 +615,7 @@ TsInitAddBA(
 	u8		bOverwritePending
 	)
 {
-	PBA_RECORD			pBA = &pTS->TxPendingBARecord;
+	PBA_RECORD			pBA = &pTS->tx_pending_ba_record;
 
 	if (pBA->bValid && !bOverwritePending)
 		return;
@@ -647,7 +647,7 @@ TsInitDelBA(struct ieee80211_device *ieee, struct ts_common_info *pTsCommonInfo,
 			ieee80211_send_DELBA(
 				ieee,
 				pTsCommonInfo->addr,
-				(pTxTs->TxAdmittedBARecord.bValid)?(&pTxTs->TxAdmittedBARecord):(&pTxTs->TxPendingBARecord),
+				(pTxTs->TxAdmittedBARecord.bValid)?(&pTxTs->TxAdmittedBARecord):(&pTxTs->tx_pending_ba_record),
 				TxRxSelect,
 				DELBA_REASON_END_BA);
 	} else if (TxRxSelect == RX_DIR) {
@@ -669,11 +669,11 @@ TsInitDelBA(struct ieee80211_device *ieee, struct ts_common_info *pTsCommonInfo,
  ********************************************************************************************************************/
 void BaSetupTimeOut(struct timer_list *t)
 {
-	struct tx_ts_record *pTxTs = from_timer(pTxTs, t, TxPendingBARecord.Timer);
+	struct tx_ts_record *pTxTs = from_timer(pTxTs, t, tx_pending_ba_record.Timer);
 
 	pTxTs->bAddBaReqInProgress = false;
 	pTxTs->bAddBaReqDelayed = true;
-	pTxTs->TxPendingBARecord.bValid = false;
+	pTxTs->tx_pending_ba_record.bValid = false;
 }
 
 void TxBaInactTimeout(struct timer_list *t)
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
index 8bb55e537bfd..3af894fe5afe 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -29,7 +29,7 @@ struct ts_common_info {
 struct tx_ts_record {
 	struct ts_common_info		ts_common_info;
 	u16				tx_cur_seq;
-	BA_RECORD			TxPendingBARecord;	/*  For BA Originator */
+	BA_RECORD			tx_pending_ba_record;	/*  For BA Originator */
 	BA_RECORD			TxAdmittedBARecord;	/*  For BA Originator */
 /* 	QOS_DL_RECORD		DLRecord; */
 	u8				bAddBaReqInProgress;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index 3dd42091ed9a..3cb6354cf14e 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -118,7 +118,7 @@ static void ResetTxTsEntry(struct tx_ts_record *pTS)
 	pTS->bAddBaReqDelayed = false;
 	pTS->bUsingBa = false;
 	ResetBaEntry(&pTS->TxAdmittedBARecord); //For BA Originator
-	ResetBaEntry(&pTS->TxPendingBARecord);
+	ResetBaEntry(&pTS->tx_pending_ba_record);
 }
 
 static void ResetRxTsEntry(PRX_TS_RECORD pTS)
@@ -151,7 +151,7 @@ void TSInitialize(struct ieee80211_device *ieee)
 		timer_setup(&pTxTS->ts_common_info.inact_timer, TsInactTimeout,
 			    0);
 		timer_setup(&pTxTS->TsAddBaTimer, TsAddBaProcess, 0);
-		timer_setup(&pTxTS->TxPendingBARecord.Timer, BaSetupTimeOut,
+		timer_setup(&pTxTS->tx_pending_ba_record.Timer, BaSetupTimeOut,
 			    0);
 		timer_setup(&pTxTS->TxAdmittedBARecord.Timer,
 			    TxBaInactTimeout, 0);
-- 
2.18.0

