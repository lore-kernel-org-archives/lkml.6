Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129B2ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A1A20881
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNeW6VY9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A1A20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388271AbeGWVxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:53:51 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43568 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388235AbeGWVxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:53:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id b15-v6so1973296wrv.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 13:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BqUsf2wWGgTTy0qDmc1BMhY2RVpYaS+bAy0vdQmideI=;
        b=GNeW6VY9Lks/rnn7MM+2KNFnFo+ov2FZtB777spvlDFxxVlvaXBDi2y/y4USlZxv3+
         +Lrn4B0bTPWjYDZl+QC4tkl0/dwwJ2tdmpHOLX72zrlytGV0zxD/MD/KMjXsBcEqq0Im
         56nTkVqmxwXsSJvosQmrnlbpdGOt7lA+3lOClvdhKtzuFAjmyFfqXo+Z6PsdH2BvftsH
         aKJZOE4ItES06CSi8hnk2TmMbaqYi/IitZG8nYQzi4gHCPKMEGOByOgL5yDf2t9GmxM7
         I9vbPw4Ef/TmXpVF/ADaUaA3pL3B5qLc4tw0fme8IosVXUyylyduMKkCvMf4wHxZ1QUF
         3eVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BqUsf2wWGgTTy0qDmc1BMhY2RVpYaS+bAy0vdQmideI=;
        b=KzyeojT0JSNDpBZSbBjwHX1Q6AaP1ch0Onh/ZHVU7ZlsblBN0qBMT8jh68x/rhqCU9
         /IQG40iUC826ovjcsF/IkgYAyrgIs65cdRxAK74fH66SWNdGHRK8Nxq56EKjL+OdvEVa
         7XRZkzkubIoUn/QRBU60ITQZarQVrp9ajjG81NS2HSZB7J/3av+K2j+NWzqPaUNRlyv6
         wDahiWYPKd+bFNHCS76rbZJC21bEvUOU88ozbqRTqQFmoCOLnviUokAfAVjqKbxfsaoG
         RxJJB7yOEtGrzwYt+HTMQCpPihar7efQ9toQAsd8piymn+28YMYN/L2VK9uhotUZPGuf
         pHaw==
X-Gm-Message-State: AOUpUlHBmNtPNCvrTA71G/pE9ON8YHNM90Yj/MSucjFDq0iBcYJm/lW0
        3XastUzLSy3BUHfcHg5ARql1CKwg
X-Google-Smtp-Source: AAOMgpcAg/4sA5NrKFt6cWE1Dvj0GHQIXFeaSh8tx34kMFOcpGwalaTYt5KnkH+OoRcS1kIAI0c+YA==
X-Received: by 2002:a5d:6581:: with SMTP id q1-v6mr4649481wru.141.1532379051596;
        Mon, 23 Jul 2018 13:50:51 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id b123-v6sm14921874wma.24.2018.07.23.13.50.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 13:50:50 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 05/15] staging:rtl8192u: Remove unused structure STA_QOS - Style
Date:   Mon, 23 Jul 2018 21:50:21 +0100
Message-Id: <20180723205031.19816-6-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723205031.19816-1-johnfwhitmore@gmail.com>
References: <20180723205031.19816-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove structure STA_QOS as it is unused in code. This change is a coding
style change so should not impact runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/rtl819x_Qos.h  | 53 -------------------
 1 file changed, 53 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
index d202244b8cac..da74d4a29ed2 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -415,59 +415,6 @@ typedef struct _OCTET_STRING {
 	u16             Length;
 } OCTET_STRING, *POCTET_STRING;
 
-//
-// STA QoS data.
-// Ref: DOT11_QOS in 8185 code. [def. in QoS_mp.h]
-//
-typedef struct _STA_QOS {
-	//DECLARE_RT_OBJECT(STA_QOS);
-	u8				WMMIEBuf[MAX_WMMELE_LENGTH];
-	u8				*WMMIE;
-
-	// Part 1. Self QoS Mode.
-	u32			        QosCapability;  // QOS_MODE QoS Capability, 2006-06-14 Isaiah
-	u32			        CurrentQosMode; // QOS_MODE
-
-	// For WMM Power Save Mode :
-	// ACs are trigger/delivery enabled or legacy power save enabled. 2006-06-13 Isaiah
-	AC_UAPSD			b4ac_Uapsd;  //VoUapsd(bit0), ViUapsd(bit1),  BkUapsd(bit2), BeUapsd(bit3),
-	AC_UAPSD			Curr4acUapsd;
-	u8				bInServicePeriod;
-	u8				MaxSPLength;
-	int				NumBcnBeforeTrigger;
-
-	// Part 2. EDCA Parameter (perAC)
-	u8				*pWMMInfoEle;
-	u8				WMMParamEle[WMM_PARAM_ELEMENT_SIZE];
-	u8				WMMPELength;
-
-	// <Bruce_Note>
-	//2 ToDo: remove the Qos Info Field and replace it by the above WMM Info element.
-	// By Bruce, 2008-01-30.
-	// Part 2. EDCA Parameter (perAC)
-	QOS_INFO_FIELD			QosInfoField_STA;	// Maintained by STA
-	QOS_INFO_FIELD			QosInfoField_AP;	// Retrieved from AP
-
-	AC_PARAM			CurAcParameters[4];
-
-	// Part 3. ACM
-	ACM				acm[4];
-	ACM_METHOD			AcmMethod;
-
-	// Part 4. Per TID (Part 5: TCLASS will be described by TStream)
-	QOS_TSTREAM			TStream[16];
-	WMM_TSPEC			TSpec;
-
-	u32				QBssWirelessMode;
-
-	// No Ack Setting
-	u8				bNoAck;
-
-	// Enable/Disable Rx immediate BA capability.
-	u8				bEnableRxImmBA;
-
-} STA_QOS, *PSTA_QOS;
-
 //
 // Ref: sQoSCtlLng and QoSCtl definition in 8185 QoS code.
 //#define QoSCtl   ((	(Adapter->bRegQoS) && (Adapter->dot11QoS.QoSMode &(QOS_EDCA|QOS_HCCA))	  )  ?sQoSCtlLng:0)
-- 
2.18.0

