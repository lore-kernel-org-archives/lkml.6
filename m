Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6079C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5627B25061
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMC1WIQt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5627B25061
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755719AbeFXPlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:41:07 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45789 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755896AbeFXPlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:41:03 -0400
Received: by mail-wr0-f194.google.com with SMTP id s7-v6so1911163wro.12
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 08:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Omaajg3zht5wN0A/kRIdRl0rgfwuHeYz/DBwFOGT88I=;
        b=GMC1WIQtq00OTrTgPneoZfG4jrI4ZKMm4OOqVVjDHWJq30zfEp0wUowVXsQVyLEKjy
         vxLDA0XrNH5YSBm4T/wQB0z69jTLtMEhQH3bjmzUGlUHNFm7QdDfRV6EEsqdUf+8G/ee
         f6nJ3RcI7tOI/t0oaCJ1RjYpQLwQ82g2JRZfmj+XmGc6lej6Lu8tdrQKmPAlITSd1li+
         rpLqkEPuVp7ht537aI44Qmsnei5lDcz1im9FtCZF+C3KEYgLUdZhrxZbsIrRRunR6T5R
         InUEdk02GuJlITc0WKB9kA2qFoGuFor1VXVAdK20+6I2HTgXRisN5XTiccR/uQfFHzhY
         4v0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Omaajg3zht5wN0A/kRIdRl0rgfwuHeYz/DBwFOGT88I=;
        b=DRKD8B2rCY2nmH2yskTGJXQgbvHNfz7jS/Zk4vG8bvcBnlugyWjPBxQD/epoBXnkt2
         9uovgi28y2A+tuByOZikniScDhzM7s5CuuhidejOD5Vsx/O5+TG7UuhlhtKH+cKvgpY9
         rrM8gxbCSpiRFS1cuiwLUtJHWIEm09TXIO1TO+wDLxP7OBdSOBN8/fU/cf4lRPyheRB6
         xb7Lh53UjkWFlzos3w0KMCUodaGEJ+mGp8vNeLqXlptyi2cp/rukGLVg4TeGSXzAkutZ
         cNpxmbbRHhLuB4gtUo2RfxQyZPiC9pfNIXYPMN4ow/VO7cAphFzH1yxZpDF59T3WU6kx
         ckmA==
X-Gm-Message-State: APt69E3mEkT+By3jdHhaiVkLV93bwbY0KytKCB1t3Fq1tS5doPn+530Q
        PWfqADkHmcP7PFOcSIfmIk5JJu+x
X-Google-Smtp-Source: AAOMgpc6Zh+5BBGLdGq4BIc/nbD8yEsSPIaSjCs76mVvjeaDNnhumNQltv0uaKPH4itIGuAA53uG7g==
X-Received: by 2002:adf:d204:: with SMTP id g4-v6mr7457975wri.229.1529854861383;
        Sun, 24 Jun 2018 08:41:01 -0700 (PDT)
Received: from localhost.localdomain (host86-190-130-185.range86-190.btcentralplus.com. [86.190.130.185])
        by smtp.gmail.com with ESMTPSA id w12-v6sm2782920wrp.69.2018.06.24.08.40.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jun 2018 08:41:00 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v3 6/8] staging: rtl8192u: Remove braces from single statement blocks - Style
Date:   Sun, 24 Jun 2018 16:40:25 +0100
Message-Id: <20180624154027.27654-7-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180624154027.27654-1-johnfwhitmore@gmail.com>
References: <20180624154027.27654-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed the unrequired braces from single statement blocks - Coding Style.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 6793a9aabb2f..227710419123 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -549,11 +549,10 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 
 	//HT capability info
 	pCapELE->AdvCoding		= 0; // This feature is not supported now!!
-	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev)) {
+	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
 		pCapELE->ChlWidth = 0;
-	} else {
+	else
 		pCapELE->ChlWidth = (pHT->bRegBW40MHz ? 1 : 0);
-	}
 
 //	pCapELE->ChlWidth		= (pHT->bRegBW40MHz?1:0);
 	pCapELE->MimoPwrSave		= pHT->SelfMimoPs;
@@ -721,9 +720,8 @@ void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg,
 	*posRT2RTAgg++ = 0x01;
 	*posRT2RTAgg = 0x10;//*posRT2RTAgg = 0x02;
 
-	if (ieee->bSupportRemoteWakeUp) {
+	if (ieee->bSupportRemoteWakeUp)
 		*posRT2RTAgg |= 0x08;//RT_HT_CAP_USE_WOW;
-	}
 
 	*len = 6 + 2;
 	return;
@@ -861,12 +859,10 @@ static u8 HTFilterMCSRate(struct ieee80211_device *ieee, u8 *pSupportMCS,
 	u8 i = 0;
 
 	// filter out operational rate set not supported by AP, the length of it is 16
-	for (i = 0; i <= 15; i++) {
+	for (i = 0; i <= 15; i++)
 		pOperateMCS[i] = ieee->Regdot11HTOperationalRateSet[i] & pSupportMCS[i];
-	}
 
 	// TODO: adjust our operational rate set  according to our channel bandwidth, STBC and Antenna number
-
 	/*
 	 * TODO: fill suggested rate adaptive rate index and give firmware info
 	 * using Tx command packet we also shall suggested the first start rate
-- 
2.17.1

