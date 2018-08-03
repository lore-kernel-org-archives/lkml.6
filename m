Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B295C46463
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71112168B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esxAJ/v5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C71112168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732266AbeHCB4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 21:56:20 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43575 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729790AbeHCB4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 21:56:19 -0400
Received: by mail-ed1-f68.google.com with SMTP id b20-v6so1550431edt.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 17:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uyPzCnprDfCSphK9BCG4grqgTrlnb/BaIi9Fwfv0qmo=;
        b=esxAJ/v5X8wnzXXN+AW/Pm+1nrYFj3wlPXuKDoqHurntlSynZlW2VunLCPIcGsO7B2
         Idk+Q8siGupseQ4xt1Os8YfrFRpEOtVEdIPKFWk/DvgziA6njLRmOE0xLpdM0Uiw04aU
         NybheADAvvkIj6+J+vDL8ufqcZpRon7xhbVD3y+2Gw2EJH96Qf0x8TBy57VyTtq4BTXh
         +QMXv2tU1Ft4pRNI3n/efqkZxBqSC4XCDT8iwpE8eFBjXbgyP/hbSQAaVtelyQHd6Svn
         pNaotkznbEkoNcGdGaOxiMK+15NOn/xcjYh1DIkkr68ibx41NtN0iq+5vFmKrsCEEBMJ
         gDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uyPzCnprDfCSphK9BCG4grqgTrlnb/BaIi9Fwfv0qmo=;
        b=ONTsMLIPfyTSoOgQbIhCRhF8vSTSl2OGW3weuhHF5YB7pA6L0FDu7xYaVZEPbw+lps
         2Qud5AoY+c2tLrItOXQf0xlOSgsA6lGMB6BxuKCSUzAcXxOe9G8LsvxCiyHdeZkaq3mQ
         HViMkcUVbDFS7Pgsq3WInfG3gTFiDueZ5a5QPw1czT+JPmyg6aHYFQAPHQ+bR+bbRvv6
         jtuelg8cIU2d8cb59QOz43RJY1kTlJyS7zeM5bL6czflegAQ4HIqaK/9k8L5UeDtsXUp
         ci3eTPuw6AxR13D4OPbdDUbpCG8EMt5MuU75u2QfSFrDbDF4J40BKkgJuThk542O581X
         jOSg==
X-Gm-Message-State: AOUpUlGFGex/KwEglsdsa2kZSA6XytgnQIAcfjxJfW5giI1oIFFoxZML
        3eX9WtHgBwDYeBiA+vP3NiRY4fME
X-Google-Smtp-Source: AAOMgpchHXr+W6qs6xClbQlJMe7xGHzl24sxxFccFN0ekVg/2mkuyd+tHmvJ577jhzIoMmZpfQRyHw==
X-Received: by 2002:a50:8607:: with SMTP id o7-v6mr5120506edo.243.1533254567358;
        Thu, 02 Aug 2018 17:02:47 -0700 (PDT)
Received: from localhost.localdomain ([109.78.209.16])
        by smtp.gmail.com with ESMTPSA id d11-v6sm1310843edo.39.2018.08.02.17.02.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 17:02:46 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 04/18] staging:rtl8192u: Rename enum constants - Style
Date:   Fri,  3 Aug 2018 01:01:57 +0100
Message-Id: <20180803000211.10589-5-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180803000211.10589-1-johnfwhitmore@gmail.com>
References: <20180803000211.10589-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the two constants defined in the enumerated type enum
cck_rx_path_method so that they are both uppercase, as suggested by
the coding style.

This is purely a coding style change and should have no impact on
runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_dm.c | 12 ++++++------
 drivers/staging/rtl8192u/r8192U_dm.h |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl8192u/r8192U_dm.c
index ede596a91c03..86f443ad75f5 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.c
+++ b/drivers/staging/rtl8192u/r8192U_dm.c
@@ -2391,9 +2391,9 @@ static void dm_init_rxpath_selection(struct net_device *dev)
 	DM_RxPathSelTable.SS_TH_low = RxPathSelection_SS_TH_low;
 	DM_RxPathSelTable.diff_TH = RxPathSelection_diff_TH;
 	if (priv->CustomerID == RT_CID_819x_Netcore)
-		DM_RxPathSelTable.cck_method = CCK_Rx_Version_2;
+		DM_RxPathSelTable.cck_method = CCK_RX_VERSION_2;
 	else
-		DM_RxPathSelTable.cck_method = CCK_Rx_Version_1;
+		DM_RxPathSelTable.cck_method = CCK_RX_VERSION_1;
 	DM_RxPathSelTable.disabledRF = 0;
 	for (i = 0; i < 4; i++) {
 		DM_RxPathSelTable.rf_rssi[i] = 50;
@@ -2429,7 +2429,7 @@ static void dm_rxpath_sel_byrssi(struct net_device *dev)
 	DM_RxPathSelTable.disabledRF = ~DM_RxPathSelTable.disabledRF & 0xf;
 
 	if (priv->ieee80211->mode == WIRELESS_MODE_B) {
-		DM_RxPathSelTable.cck_method = CCK_Rx_Version_2;	/* pure B mode, fixed cck version2 */
+		DM_RxPathSelTable.cck_method = CCK_RX_VERSION_2;	/* pure B mode, fixed cck version2 */
 		/*DbgPrint("Pure B mode, use cck rx version2\n");*/
 	}
 
@@ -2493,7 +2493,7 @@ static void dm_rxpath_sel_byrssi(struct net_device *dev)
 
 	rf_num = 0;
 	/* decide max/sec/min cck pwdb index */
-	if (DM_RxPathSelTable.cck_method == CCK_Rx_Version_2) {
+	if (DM_RxPathSelTable.cck_method == CCK_RX_VERSION_2) {
 		for (i = 0; i < RF90_PATH_MAX; i++) {
 			if (priv->brfpath_rxenable[i]) {
 				rf_num++;
@@ -2551,7 +2551,7 @@ static void dm_rxpath_sel_byrssi(struct net_device *dev)
 	 * reg0xA07[3:2]=cck default rx path, reg0xa07[1:0]=cck optional rx path.
 	 */
 	update_cck_rx_path = 0;
-	if (DM_RxPathSelTable.cck_method == CCK_Rx_Version_2) {
+	if (DM_RxPathSelTable.cck_method == CCK_RX_VERSION_2) {
 		cck_default_Rx = cck_rx_ver2_max_index;
 		cck_optional_Rx = cck_rx_ver2_sec_index;
 		if (tmp_cck_max_pwdb != -64)
@@ -2567,7 +2567,7 @@ static void dm_rxpath_sel_byrssi(struct net_device *dev)
 			rtl8192_setBBreg(dev, rOFDM1_TRxPathEnable, 0x1<<min_rssi_index, 0x0);	/* 0xd04[3:0] */
 			disabled_rf_cnt++;
 		}
-		if (DM_RxPathSelTable.cck_method == CCK_Rx_Version_1) {
+		if (DM_RxPathSelTable.cck_method == CCK_RX_VERSION_1) {
 			cck_default_Rx = max_rssi_index;
 			cck_optional_Rx = sec_rssi_index;
 			if (tmp_max_rssi)
diff --git a/drivers/staging/rtl8192u/r8192U_dm.h b/drivers/staging/rtl8192u/r8192U_dm.h
index ba73dd1d1793..d51c20eafef4 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.h
+++ b/drivers/staging/rtl8192u/r8192U_dm.h
@@ -124,8 +124,8 @@ struct dig {
 };
 
 enum cck_rx_path_method {
-	CCK_Rx_Version_1 = 0,
-	CCK_Rx_Version_2 = 1,
+	CCK_RX_VERSION_1 = 0,
+	CCK_RX_VERSION_2 = 1,
 };
 
 struct dynamic_rx_path_sel {
-- 
2.18.0

