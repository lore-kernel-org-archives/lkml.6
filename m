Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339DAC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E12202077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWr/hQNo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E12202077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbeIDPVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 11:21:40 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37856 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727364AbeIDPVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 11:21:39 -0400
Received: by mail-wr1-f67.google.com with SMTP id u12-v6so3474190wrr.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 03:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xrn4/FyPZQG+hxey1O4xccb2bfvDP7c30IuGTKIErDI=;
        b=iWr/hQNofJ8sjESiuDR0WClh9B3Qfn7ziroqUNYYZPbzYJu13iGgPaqiRRLSrHHkzX
         iIHTHAKR3C3ROygvFyRHf7QfPorShVTrYSOwjt4hnogefVLt/T5m5NX6b+krrCFUR5iw
         PQwdL/+DGFr9j0wKA43PyKLe0JxdfetnEQsSrMpeEXlrhUPyUnCMGAx5QOt+k58oSpza
         rOsxKI9ICbDC+oNIHV6cc07CD2CwKcq5oVrqOVUieDCc93XOR8Y891hPrxl1+hbe/oW3
         eBORwEGNaMuBmRVdZIgKNzHxTDp0I1MW56UsEJsa/yRuoBsfM+ehH3Kmn5vPRZjV743X
         W5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xrn4/FyPZQG+hxey1O4xccb2bfvDP7c30IuGTKIErDI=;
        b=KrC8e/1KAw9nMq+KQyZLzWTCtsnOblBi+l3lBDBYWqsfLVovyoM12jIdJ+qf+2pvWp
         2GrW1JGqvnqXU90z+wAD980mafb1NjNkBazM1UMMmgo45jgL9w9B2iy/sUxkV34RjOOX
         gQfSMsq23vtuFu70NE9NACjH+MTyT7+/L8mv/sOCP9z4CsrqGY7QAHSJ892+Tj0SuN9s
         FheROfhP8otW/+lvtfnsZV+zAWWFKd2u4z2FoUryOeyJSnTtQnMonHItg4gocERn5urV
         eZKae8wdhfiR9gewF+/aMFK4T36WqH48SJR4dBs9uCqF36DuYVOowjvRiCONZn3dDkV3
         k5CQ==
X-Gm-Message-State: APzg51DG+BxBAAaGyCNdG6SSM4sOX+W3SvERxRdWMwlp/RN2Q6+q7tbh
        JAsrHhZIP/Bwk8/EF060MC3Bbl0E
X-Google-Smtp-Source: ANB0VdYWQJzyC9wEZRQZdDODxQQ+FXAZc/9rPBgX+VZojcNxDkd3oeI/v0Wb8SnySsLyxDbM2zILaQ==
X-Received: by 2002:adf:9031:: with SMTP id h46-v6mr21903205wrh.248.1536058622241;
        Tue, 04 Sep 2018 03:57:02 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id 184-v6sm27539085wmv.6.2018.09.04.03.57.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 03:57:01 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        sfr@canb.auug.org.au, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 1/1] staging:rtl8192u: Rename dot11d_init to fix name clash
Date:   Tue,  4 Sep 2018 11:56:23 +0100
Message-Id: <20180904105623.15797-2-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180904105623.15797-1-johnfwhitmore@gmail.com>
References: <20180904105623.15797-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function dot11d_init() was previously renamed to clear a style
issue. Unfortunately the new name used, dot11d_init(), clashes with
a sybmol which is exported with the same name. To correct this
problem the function has been renamed to rtl8192u_dot11d_init().

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.c | 6 +++---
 drivers/staging/rtl8192u/ieee80211/dot11d.h | 2 +-
 drivers/staging/rtl8192u/r8192U_core.c      | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.c b/drivers/staging/rtl8192u/ieee80211/dot11d.c
index d3b13f0cfc09..3c8e8ba999cf 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.c
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.c
@@ -3,7 +3,7 @@
 
 #include "dot11d.h"
 
-void dot11d_init(struct ieee80211_device *ieee)
+void rtl8192u_dot11d_init(struct ieee80211_device *ieee)
 {
 	struct rt_dot11d_info *pDot11dInfo = GET_DOT11D_INFO(ieee);
 
@@ -15,9 +15,9 @@ void dot11d_init(struct ieee80211_device *ieee)
 	memset(pDot11dInfo->max_tx_pwr_dbm_list, 0xFF, MAX_CHANNEL_NUMBER+1);
 	RESET_CIE_WATCHDOG(ieee);
 
-	netdev_info(ieee->dev, "dot11d_init()\n");
+	netdev_info(ieee->dev, "rtl8192u_dot11d_init()\n");
 }
-EXPORT_SYMBOL(dot11d_init);
+EXPORT_SYMBOL(rtl8192u_dot11d_init);
 
 /* Reset to the state as we are just entering a regulatory domain. */
 void dot11d_reset(struct ieee80211_device *ieee)
diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index be59f720ae20..d217eb8063c4 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -43,7 +43,7 @@ struct rt_dot11d_info {
 #define RESET_CIE_WATCHDOG(ieee_dev) (GET_CIE_WATCHDOG(ieee_dev) = 0)
 #define UPDATE_CIE_WATCHDOG(ieee_dev) (++GET_CIE_WATCHDOG(ieee_dev))
 
-void dot11d_init(struct ieee80211_device *dev);
+void rtl8192u_dot11d_init(struct ieee80211_device *dev);
 void dot11d_reset(struct ieee80211_device *dev);
 void dot11d_update_country_ie(struct ieee80211_device *dev,
 			      u8 *addr,
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 6b22aaa40ff9..0a21a76dcbc3 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -183,7 +183,7 @@ static void rtl819x_set_channel_map(u8 channel_plan, struct r8192_priv *priv)
 	case COUNTRY_CODE_ISRAEL:
 	case COUNTRY_CODE_TELEC:
 	case COUNTRY_CODE_MIC:
-		dot11d_init(ieee);
+		rtl8192u_dot11d_init(ieee);
 		ieee->bGlobalDomain = false;
 		/* actually 8225 & 8256 rf chips only support B,G,24N mode */
 		if ((priv->rf_chip == RF_8225) || (priv->rf_chip == RF_8256)) {
-- 
2.18.0

