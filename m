Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA80C5AE5A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42422075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVlPqIIq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C42422075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030823AbeFST5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:57:12 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55561 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030448AbeFST5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:57:05 -0400
Received: by mail-wm0-f65.google.com with SMTP id v16-v6so2272526wmh.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 12:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wkAcahGsPARvz4KXA49j3SuNHKNcz47sqBhDqxG0je0=;
        b=JVlPqIIqn/hz8H8tgy9DopU9A2mcXkKDOYtbpycbBwendsjSsjeq1m5XppzXjsGZsv
         zrYXYyYN/ruNUrRdwilj4n3C69KemBtuwZVPsPigg9EYUsqnKQwa7hlmqrm5R++n+ZSc
         6hmaZU5mVkt9TgVKZiCV9HJ3BWgRHEO2a1SCISXX/9tq79nwJlOImpGGlZX5zQOgA6WS
         tmnhLzZzBh2yAPjrt+53Wnzz9THZtlffsLOVqbncJY3yRJtDvY6eEnXqqaE3KDuIvcMn
         6qN/4RfbW79XM04vACxkvP1qBF9rKgGq0JUAyFNSaULsq7i/KxjC6m50SDhF64zHlBMP
         Lw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wkAcahGsPARvz4KXA49j3SuNHKNcz47sqBhDqxG0je0=;
        b=R12Odphq8JMFdkLG1sSTBjLZdNK6MqpzWUv1H7a2TlvYQKTBSQMCgK3/tTCMvvftdy
         7yQHtQ+SHPdfhz0JARZTOl4v4RsS1ojUG1MGZzVAq2UQS0L0JN0CA/He5ZEK0u0sNeJF
         M5d/IxrsgBvnIzwPA3BCredOlmj9ZUwKFUEhkKiI8dXX5I8Gx+vvfL/B90CwYebxxyhi
         ij5xyi2l6bpc6gaBKleRqvCyd+aHtEUsFCzvU35A/Qex7Jk8+lsGcaDFAG8KdwSEjian
         T1emIs8a7MGm3VWZRJmZ5IWArYsgpIV7pbGadfmihJNDOG9vOCMa38EbmkV5uq3WrmT3
         t6bw==
X-Gm-Message-State: APt69E1T7p4kreEdSObyawhgl8ISoyZoUvVZS9l4fT9jbExl8a/Wm3Zv
        asqxanKFFAAfPr7v4iEMt0A=
X-Google-Smtp-Source: ADUXVKJhbQ2TH7Ya6eodlkqG9TbhD8/nfSZ5ZFwvg6ZZImGfxzFDd2mNblyyImyx4bRzjijbLUga+Q==
X-Received: by 2002:a1c:110a:: with SMTP id 10-v6mr11797614wmr.130.1529438224389;
        Tue, 19 Jun 2018 12:57:04 -0700 (PDT)
Received: from localhost.localdomain (host86-190-130-185.range86-190.btcentralplus.com. [86.190.130.185])
        by smtp.gmail.com with ESMTPSA id c53-v6sm1105983wrg.12.2018.06.19.12.57.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 12:57:03 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 6/9] staging: rtl8192u: Remove braces from single statement blocks - Style
Date:   Tue, 19 Jun 2018 20:56:02 +0100
Message-Id: <20180619195605.31321-7-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619195605.31321-1-johnfwhitmore@gmail.com>
References: <20180619195605.31321-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed the unrequired braces from single statement blocks - Coding Style.
Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 732d03e8474e..c942d886429e 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -554,11 +554,10 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 
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
@@ -727,9 +726,8 @@ void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg,
 	*posRT2RTAgg++ = 0x01;
 	*posRT2RTAgg = 0x10;//*posRT2RTAgg = 0x02;
 
-	if (ieee->bSupportRemoteWakeUp) {
+	if (ieee->bSupportRemoteWakeUp)
 		*posRT2RTAgg |= 0x08;//RT_HT_CAP_USE_WOW;
-	}
 
 	*len = 6 + 2;
 	return;
@@ -871,9 +869,8 @@ static u8 HTFilterMCSRate(struct ieee80211_device *ieee, u8 *pSupportMCS,
 	u8 i = 0;
 
 	// filter out operational rate set not supported by AP, the length of it is 16
-	for (i = 0; i <= 15; i++) {
+	for (i = 0; i <= 15; i++)
 		pOperateMCS[i] = ieee->Regdot11HTOperationalRateSet[i] & pSupportMCS[i];
-	}
 
 	/*
 	 * TODO: adjust our operational rate set  according to our channel
-- 
2.17.1

