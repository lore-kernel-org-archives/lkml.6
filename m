Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24B4C43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C37216E3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBNos2VF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77C37216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732553AbeHCB4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 21:56:37 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37105 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732444AbeHCB4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 21:56:34 -0400
Received: by mail-ed1-f68.google.com with SMTP id b10-v6so1565691eds.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 17:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nt6siKSEszMYCsosliQt2c0bqWjz1qlHKu0zbbFg0GQ=;
        b=UBNos2VFRgJvd9885wWBYMRRhcmE5whS8Q2dPmV1CBXmPry9twde1M0zYfZYdm1gII
         1p7csGFpXdHeOjuln7DCbsJR2e22NDeURL3EodOr1c6mV6J/Lexf5cIL70DTV7Vl3pL6
         g/ecKTRenU6J1wxc0rCQPj0XHFv3jI3k6/Mxu/1b1Oyh9Ev1OSMsubPk7p9rByIhnFzb
         R37AsEIS/iUx+oGHULx4ZIesGBR4EkF3tritoZS0LItvfEHn+P6ueKMyw2+4c1kDrx2+
         it2tBW6Gvx4cp8tnI72kR+gcf6+eM5D4z16fJelDFzPqRxb73jI0knnfwckNemJJtyEh
         34xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Nt6siKSEszMYCsosliQt2c0bqWjz1qlHKu0zbbFg0GQ=;
        b=YwKv7Ktl4A1NjGgrxTtnctqUdr1dDsy//vJp/gftosjtYMQW2Dk9ftEC+H4hkfxSDK
         OjOxboVbQJUFHkFfR/RLFhoPQIy/nzOUQVgJ2KYymMcLdfCucKptLaE0Fi55gy7wsGyu
         AexDq3tZWrHOr0kNwLwbKMqztXUpritBI7qW7uikMXclFrXHuoPvTr2cfN6pxEubxxY4
         GPgqW12pld4fOwMJF2iGCTXLG4tVm5QXTzTYwKOGGpLTlmADD2Q7wz1w+tl6cIQFjuFm
         ydMafCmQ7Ukc28EsD1Kes8OYqDxPgVM0eW6QfTrngy96BtyeB0gQs/hFfjLN0DKvo229
         +uLw==
X-Gm-Message-State: AOUpUlHhf1rnqDyl8/aQ7wBTCjCkIR2sm4/OqA5QNjiw7ObcYQaJpjvi
        ATe8iZdq3jRoc0x/YkfYzm+viTHO
X-Google-Smtp-Source: AAOMgpd59FoMymde3JR9NUqJ1gDBu2uhXj46niQwQq3T8Ofexa4nOIjwdC9+a90yJq9u23EhifoVEA==
X-Received: by 2002:aa7:c6c2:: with SMTP id b2-v6mr5042634eds.302.1533254582099;
        Thu, 02 Aug 2018 17:03:02 -0700 (PDT)
Received: from localhost.localdomain ([109.78.209.16])
        by smtp.gmail.com with ESMTPSA id d11-v6sm1310843edo.39.2018.08.02.17.03.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 17:03:01 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 15/18] staging:rtl8192u: Rename constants RateAdaptiveTH_Low_* - Style
Date:   Fri,  3 Aug 2018 01:02:08 +0100
Message-Id: <20180803000211.10589-16-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180803000211.10589-1-johnfwhitmore@gmail.com>
References: <20180803000211.10589-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two constants, RateAdaptiveTH_Low_20M and RateAdaptiveTH_Low_40M
generate a checkpatch warning about CamelCase naming. The two have been
renamed to clear this issue. RATE_ADAPTIVE_TH_LOW_20M and
RATE_ADAPTIVE_TH_LOW_40M

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_core.c | 8 ++++----
 drivers/staging/rtl8192u/r8192U_dm.c   | 8 ++++----
 drivers/staging/rtl8192u/r8192U_dm.h   | 4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index d4a063afca55..6129ac55656f 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -3082,14 +3082,14 @@ static bool HalRxCheckStuck819xUsb(struct net_device *dev)
 	if (priv->undecorated_smoothed_pwdb >= (RATE_ADAPTIVE_TH_HIGH + 5)) {
 		rx_chk_cnt = 0;	/* high rssi, check rx stuck right now. */
 	} else if (priv->undecorated_smoothed_pwdb < (RATE_ADAPTIVE_TH_HIGH + 5) &&
-		   ((priv->CurrentChannelBW != HT_CHANNEL_WIDTH_20 && priv->undecorated_smoothed_pwdb >= RateAdaptiveTH_Low_40M) ||
-		    (priv->CurrentChannelBW == HT_CHANNEL_WIDTH_20 && priv->undecorated_smoothed_pwdb >= RateAdaptiveTH_Low_20M))) {
+		   ((priv->CurrentChannelBW != HT_CHANNEL_WIDTH_20 && priv->undecorated_smoothed_pwdb >= RATE_ADAPTIVE_TH_LOW_40M) ||
+		    (priv->CurrentChannelBW == HT_CHANNEL_WIDTH_20 && priv->undecorated_smoothed_pwdb >= RATE_ADAPTIVE_TH_LOW_20M))) {
 		if (rx_chk_cnt < 2)
 			return bStuck;
 
 		rx_chk_cnt = 0;
-	} else if (((priv->CurrentChannelBW != HT_CHANNEL_WIDTH_20 && priv->undecorated_smoothed_pwdb < RateAdaptiveTH_Low_40M) ||
-		    (priv->CurrentChannelBW == HT_CHANNEL_WIDTH_20 && priv->undecorated_smoothed_pwdb < RateAdaptiveTH_Low_20M)) &&
+	} else if (((priv->CurrentChannelBW != HT_CHANNEL_WIDTH_20 && priv->undecorated_smoothed_pwdb < RATE_ADAPTIVE_TH_LOW_40M) ||
+		    (priv->CurrentChannelBW == HT_CHANNEL_WIDTH_20 && priv->undecorated_smoothed_pwdb < RATE_ADAPTIVE_TH_LOW_20M)) &&
 		     priv->undecorated_smoothed_pwdb >= VeryLowRSSI) {
 		if (rx_chk_cnt < 4)
 			return bStuck;
diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl8192u/r8192U_dm.c
index b9b751fb96c3..21107a00776f 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.c
+++ b/drivers/staging/rtl8192u/r8192U_dm.c
@@ -244,12 +244,12 @@ void init_rate_adaptive(struct net_device *dev)
 
 	pra->ratr_state = DM_RATR_STA_MAX;
 	pra->high2low_rssi_thresh_for_ra = RATE_ADAPTIVE_TH_HIGH;
-	pra->low2high_rssi_thresh_for_ra20M = RateAdaptiveTH_Low_20M+5;
-	pra->low2high_rssi_thresh_for_ra40M = RateAdaptiveTH_Low_40M+5;
+	pra->low2high_rssi_thresh_for_ra20M = RATE_ADAPTIVE_TH_LOW_20M + 5;
+	pra->low2high_rssi_thresh_for_ra40M = RATE_ADAPTIVE_TH_LOW_40M + 5;
 
 	pra->high_rssi_thresh_for_ra = RATE_ADAPTIVE_TH_HIGH + 5;
-	pra->low_rssi_thresh_for_ra20M = RateAdaptiveTH_Low_20M;
-	pra->low_rssi_thresh_for_ra40M = RateAdaptiveTH_Low_40M;
+	pra->low_rssi_thresh_for_ra20M = RATE_ADAPTIVE_TH_LOW_20M;
+	pra->low_rssi_thresh_for_ra40M = RATE_ADAPTIVE_TH_LOW_40M;
 
 	if (priv->CustomerID == RT_CID_819x_Netcore)
 		pra->ping_rssi_enable = 1;
diff --git a/drivers/staging/rtl8192u/r8192U_dm.h b/drivers/staging/rtl8192u/r8192U_dm.h
index 07e80e064f76..a1378488423b 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.h
+++ b/drivers/staging/rtl8192u/r8192U_dm.h
@@ -41,8 +41,8 @@
 #define		RX_PATH_SELECTION_DIFF_TH			18
 
 #define		RATE_ADAPTIVE_TH_HIGH			50
-#define		RateAdaptiveTH_Low_20M		30
-#define		RateAdaptiveTH_Low_40M		10
+#define		RATE_ADAPTIVE_TH_LOW_20M		30
+#define		RATE_ADAPTIVE_TH_LOW_40M		10
 #define		VeryLowRSSI					15
 #define		CTSToSelfTHVal					30
 
-- 
2.18.0

