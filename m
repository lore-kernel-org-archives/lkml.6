Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8358C43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8B4216C4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcjPsCYT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B8B4216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732411AbeHCB41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 21:56:27 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45703 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732361AbeHCB40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 21:56:26 -0400
Received: by mail-ed1-f66.google.com with SMTP id s16-v6so1549493edq.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 17:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=siB86CTYp9jYSongy4BYe46C9JhoD/6wUWxIEtd54HM=;
        b=UcjPsCYTsRpmQEbBFDcOaVBzxwrKsgQxuB0M670e+qbIG//8PTSxbDC/+Mnpd9h33N
         +fiGS1EifdhtiTUvaRgszHepKWIuLlD0DYfbizuIZHOhh+K2dLFb/aZmu/nRR5d2GOAJ
         zzmDIik52hK9nwvstyb7uggoi3miMUHi+pXYD7zX23NyCD+iBGDM3C/IDjYy51Zo4D0z
         i6gycgZ3Dqy+Es3/yT0PDYPLFoQEImCHzGYYx315wl5DpTMduWIO95hZnK18ZlEDtlgI
         tjRw53a0RPhpnic/1zCDeNQE7NK3Ir2B8t8TvPLu23auavwkW2zN8jQhzu4v4ElxD6wG
         mmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=siB86CTYp9jYSongy4BYe46C9JhoD/6wUWxIEtd54HM=;
        b=uHC1lFEIzhagWAc3b4KwwgJvA3Oc/tCks6IRoq0TLb1Fink1pNXn+Xh0t1UeTl1NQ4
         mXuCHeE7UhRVS4p97Qykv+3+zBg0fVJCSBwobNMwexGEBg7OroUj2/uiU4IhcYHe6Sdx
         nocr7Hz02i9lL7nDjcvIX483mhvNYg/gswI2nqCasjVW7TaZUVS08cqS5Px0pXmdiR0G
         4eaWgos72b98YpTqpQhsogteUDrrZ/cB93T+GeBz3/JAE/RqjYUZjjclT5rdA2LcLpQ4
         z0Y8dkut3t+jWNRcrKouXG41ckE4Pz0/EaX1wCZJQLXgGHpbTPwAfKt8sO/duLDmjZH9
         0bkg==
X-Gm-Message-State: AOUpUlHV8nQeSyz8yK5wunhOXnXaLUfUu7ukmwBl0Wc0HAOjEWkUqyBX
        TopwFDjaNvi1VNKygUYLarx1wemB
X-Google-Smtp-Source: AAOMgpcoWG56T903oGI1l5Qsch43trrXZeOgQLF+iiKRSvGk/ybxfpYYdFYUSOTMbfPSjEj1z2odNA==
X-Received: by 2002:a50:e718:: with SMTP id a24-v6mr5133637edn.278.1533254574092;
        Thu, 02 Aug 2018 17:02:54 -0700 (PDT)
Received: from localhost.localdomain ([109.78.209.16])
        by smtp.gmail.com with ESMTPSA id d11-v6sm1310843edo.39.2018.08.02.17.02.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 17:02:53 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 09/18] staging:rtl8192u: Remove member diff_TH - Style
Date:   Fri,  3 Aug 2018 01:02:02 +0100
Message-Id: <20180803000211.10589-10-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180803000211.10589-1-johnfwhitmore@gmail.com>
References: <20180803000211.10589-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The member variable diff_TH is assigned a constant value and then used
in a comparison. The variable is never changed so the comparison can
as easily be performed directly with the defined constant.

The member variable has been removed and the defined constant
RxPathSelection_diff_TH renamed to RX_PATH_SELECTION_DIFF_TH, to clear
the checkpatch issue with CamelCase naming.

These are coding style changes which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_dm.c | 3 +--
 drivers/staging/rtl8192u/r8192U_dm.h | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl8192u/r8192U_dm.c
index f01d2f8d7fd2..d847adf57f60 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.c
+++ b/drivers/staging/rtl8192u/r8192U_dm.c
@@ -2385,7 +2385,6 @@ static void dm_init_rxpath_selection(struct net_device *dev)
 	u8 i;
 	struct r8192_priv *priv = ieee80211_priv(dev);
 
-	DM_RxPathSelTable.diff_TH = RxPathSelection_diff_TH;
 	if (priv->CustomerID == RT_CID_819x_Netcore)
 		DM_RxPathSelTable.cck_method = CCK_RX_VERSION_2;
 	else
@@ -2555,7 +2554,7 @@ static void dm_rxpath_sel_byrssi(struct net_device *dev)
 	}
 
 	if (tmp_min_rssi < RX_PATH_SELECTION_SS_TH_LOW && disabled_rf_cnt < 2) {
-		if ((tmp_max_rssi - tmp_min_rssi) >= DM_RxPathSelTable.diff_TH) {
+		if ((tmp_max_rssi - tmp_min_rssi) >= RX_PATH_SELECTION_DIFF_TH) {
 			/* record the enabled rssi threshold */
 			DM_RxPathSelTable.rf_enable_rssi_th[min_rssi_index] = tmp_max_rssi+5;
 			/* disable the BB Rx path, OFDM */
diff --git a/drivers/staging/rtl8192u/r8192U_dm.h b/drivers/staging/rtl8192u/r8192U_dm.h
index 0aaac0fca110..a7cce1fdd626 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.h
+++ b/drivers/staging/rtl8192u/r8192U_dm.h
@@ -38,7 +38,7 @@
 #define		DM_DIG_MIN_Netcore			0x12
 
 #define		RX_PATH_SELECTION_SS_TH_LOW		30
-#define		RxPathSelection_diff_TH			18
+#define		RX_PATH_SELECTION_DIFF_TH			18
 
 #define		RateAdaptiveTH_High			50
 #define		RateAdaptiveTH_Low_20M		30
@@ -132,7 +132,6 @@ struct dynamic_rx_path_sel {
 	enum cck_rx_path_method		cck_method;
 	u8		cck_rx_path;
 
-	u8		diff_TH;
 	u8		disabledRF;
 	u8		reserved;
 
-- 
2.18.0

