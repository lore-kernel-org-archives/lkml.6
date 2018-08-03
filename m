Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA39EC43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E762214AB
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gf6BOCd7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E762214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732628AbeHCB53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 21:57:29 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41180 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732321AbeHCB4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 21:56:25 -0400
Received: by mail-ed1-f68.google.com with SMTP id s24-v6so1558835edr.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 17:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jguKyj5M6z5Qh1Z2uPNYr6+dwLJ1e1ggr+rKrCDL9qw=;
        b=gf6BOCd79EBSH4iZTWscChqLurtJV0qyDLCl8v0rN/ORu6hovkhyfuZVgtnbR5Z716
         /D4GHxk8d8yGUvHHv98PYOzAjVoj5HmmvszkjdZPFGX1ZUmNEWwwCWo/9Ng9k4X7X0He
         TEhjfrnf6/VdpiEFysf652wsa/7ciK3Jsbp7BPXf2m30Cd1v+Km24wWndpl6UvzwxG11
         NFiTbYzxARYuXLUxRtvqktP+u4FU9nNmKYSC16UOxCc4nMg6GeYhWIeHVywG0+8yWPZE
         Gj9KbZ8zwL2vzVoD2Drvd6tiZ8yjhMplkfahHd+kPC0uOU4JxikSZ2Xqwy7mbK44/KD4
         Kw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jguKyj5M6z5Qh1Z2uPNYr6+dwLJ1e1ggr+rKrCDL9qw=;
        b=hPSOTA9JqLHBKEdW2PV6ZDK2AIGNviyVisxWlmh1PmaeMxCebxyNHJu2A+vun+lenP
         M5M8yt7bCFY3AsuDdg9hPnme6bqamlMiYNDlTzPBZ6ZjamuZEQBf6fXZT3HK5luJQB+I
         vx15m+5aJVFMaR3DEfwgspnXJlSrf934C3ykQBTnSkUp/4TEVI5TipV2xUbXG/pQC5g7
         CncWsAD4HDUpi22Hj6U0yOHIPZp+XhQv310GpGNlUF8AWxQYw5m0N3liuYZVMho8xgQO
         usXLpXeVBopM8v/L1+LkildDSpLxWsLmoEG5PhAFrowP9spEleQujTZ0F/jbOTGCArtv
         1PoQ==
X-Gm-Message-State: AOUpUlFVNQLb28x3eXn2aDVCrQ8UUzrXkROzOuNRbFAsb0d8X66UhYZd
        /rQRu1+ml9hvYlqFIqZu77CQmGci
X-Google-Smtp-Source: AAOMgpf6cvOxJc2xl17saAy8+oywuwRmBTpop+G/3R9qrK+0FJQ3rCklMGoLlKdS+6NQOr3cfmeuoQ==
X-Received: by 2002:a50:a93c:: with SMTP id l57-v6mr4956893edc.229.1533254572764;
        Thu, 02 Aug 2018 17:02:52 -0700 (PDT)
Received: from localhost.localdomain ([109.78.209.16])
        by smtp.gmail.com with ESMTPSA id d11-v6sm1310843edo.39.2018.08.02.17.02.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 17:02:52 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 08/18] staging:rtl8192u: Remove SS_TH_low - Style
Date:   Fri,  3 Aug 2018 01:02:01 +0100
Message-Id: <20180803000211.10589-9-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180803000211.10589-1-johnfwhitmore@gmail.com>
References: <20180803000211.10589-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The member variable SS_TH_low is assigned a constant and then used
in a comparison. This member variable is redundant as the constant
can be used directly for the comparison.

In addition the constant RxPathSelection_SS_TH_low has been renamed
to RX_PATH_SELECTION_SS_TH_LOW, to clear the checkpatch issue with
CamelCase naming.

These changes are coding style in nature and should not impact
runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_dm.c | 3 +--
 drivers/staging/rtl8192u/r8192U_dm.h | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl8192u/r8192U_dm.c
index 495f563879c8..f01d2f8d7fd2 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.c
+++ b/drivers/staging/rtl8192u/r8192U_dm.c
@@ -2385,7 +2385,6 @@ static void dm_init_rxpath_selection(struct net_device *dev)
 	u8 i;
 	struct r8192_priv *priv = ieee80211_priv(dev);
 
-	DM_RxPathSelTable.SS_TH_low = RxPathSelection_SS_TH_low;
 	DM_RxPathSelTable.diff_TH = RxPathSelection_diff_TH;
 	if (priv->CustomerID == RT_CID_819x_Netcore)
 		DM_RxPathSelTable.cck_method = CCK_RX_VERSION_2;
@@ -2555,7 +2554,7 @@ static void dm_rxpath_sel_byrssi(struct net_device *dev)
 			update_cck_rx_path = 1;
 	}
 
-	if (tmp_min_rssi < DM_RxPathSelTable.SS_TH_low && disabled_rf_cnt < 2) {
+	if (tmp_min_rssi < RX_PATH_SELECTION_SS_TH_LOW && disabled_rf_cnt < 2) {
 		if ((tmp_max_rssi - tmp_min_rssi) >= DM_RxPathSelTable.diff_TH) {
 			/* record the enabled rssi threshold */
 			DM_RxPathSelTable.rf_enable_rssi_th[min_rssi_index] = tmp_max_rssi+5;
diff --git a/drivers/staging/rtl8192u/r8192U_dm.h b/drivers/staging/rtl8192u/r8192U_dm.h
index b1f19bad2c30..0aaac0fca110 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.h
+++ b/drivers/staging/rtl8192u/r8192U_dm.h
@@ -37,7 +37,7 @@
 #define		DM_DIG_MIN					0x1c
 #define		DM_DIG_MIN_Netcore			0x12
 
-#define		RxPathSelection_SS_TH_low		30
+#define		RX_PATH_SELECTION_SS_TH_LOW		30
 #define		RxPathSelection_diff_TH			18
 
 #define		RateAdaptiveTH_High			50
@@ -132,7 +132,6 @@ struct dynamic_rx_path_sel {
 	enum cck_rx_path_method		cck_method;
 	u8		cck_rx_path;
 
-	u8		SS_TH_low;
 	u8		diff_TH;
 	u8		disabledRF;
 	u8		reserved;
-- 
2.18.0

