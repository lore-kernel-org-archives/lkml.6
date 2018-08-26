Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A052C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 22:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10B742172A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 22:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgjtBA59"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10B742172A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbeH0CaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 22:30:01 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36862 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeH0CaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 22:30:01 -0400
Received: by mail-ed1-f65.google.com with SMTP id f4-v6so6492505edq.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 15:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tCwFCRzyIDoiH/sxhenJ4FSA1k1bRVRLQNoFjXk6rhs=;
        b=SgjtBA59t3VwhUMQsitGY1c7PVG/Xj4R11czerXmSiTL66dpoJ/F8NW68nM+Q+xbgH
         W1xhqxgobAU2VZhYcFMetXFhK5zyP5elgi/LGGyYMjOZaSU/WNLRBTuX8TjnSVi2YYqI
         +11zlwOmwFwNIdivm5TF0K207jB1o7yE4IwoDsX1QNR/EgaYS7wuE6L5PBAg6c1tWbCM
         lDDEtWuiWzsBZljQl7+WrpngYvEieP6+Xno7U5Lg+VYchISmYs0g8mQHmDVYzhWK0Prr
         iB8tnnwtH5Ob1Xp+CmkmnJNtOGW3d1n0rHEUWe0BQhrqtrBc90z67WpnNPfnMhCXJPlX
         drxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tCwFCRzyIDoiH/sxhenJ4FSA1k1bRVRLQNoFjXk6rhs=;
        b=HyR08m4R5O31gOarylYzAQAw5AUxIduY8XcTlc2dMTh5vLKh8x6ck4oZSXb5SFawOU
         cDmu2dp14jpoM637IOzYvRkM6WDnOwwCGHMfUhpdFEHR7nhMSDDWOXaVdC425zL+sVrA
         F3npMI+vq7bcJ2Y1VDsLl7/jYbjXdfE4voBDfhgMu42t5Ekn3bDIe13IEalquD72jaEF
         9IuL7ovhxfrYP5+aDvkcpaUXblEeXqtAgO+6zn8DCHP8yCq3jjGPo63Bsr5wVX1nuXhg
         TqYHG9e/LyTQHg3OkmNyaNHwcZBHTZUgUeZXTb54RF6OR2oNwnYY7T4aao0GSb4CaN0p
         29dQ==
X-Gm-Message-State: APzg51DE+I/q3msokpkGodseE/xTQlP+R+ByQHQ4+2qUn+ZuWe5wmrc0
        l/m1Em5b10ntblWhi9yZvY890ac1
X-Google-Smtp-Source: ANB0VdbdG1jLVLziIhaO1uJw0LfXiyHxXai7ZIxwEJR/NiCwOuH4Iy/o3gxnTJUtdjUk/QJVo9qFOw==
X-Received: by 2002:a50:924e:: with SMTP id j14-v6mr14007634eda.249.1535323561763;
        Sun, 26 Aug 2018 15:46:01 -0700 (PDT)
Received: from localhost.localdomain ([109.78.216.151])
        by smtp.gmail.com with ESMTPSA id a33-v6sm5519165eda.2.2018.08.26.15.46.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 15:46:01 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 5/6] staging:rtl8192u: Rename PHY_SetRF8256OFDMTxPower() - Style
Date:   Sun, 26 Aug 2018 23:45:32 +0100
Message-Id: <20180826224533.16020-6-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180826224533.16020-1-johnfwhitmore@gmail.com>
References: <20180826224533.16020-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename function PHY_SetRF8256OFDMTxPower() to
phy_set_rf8256_ofdm_tx_power(), to clear the checkpatch issue with
CamelCase naming.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8190_rtl8256.c | 2 +-
 drivers/staging/rtl8192u/r8190_rtl8256.h | 2 +-
 drivers/staging/rtl8192u/r819xU_phy.c    | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8190_rtl8256.c b/drivers/staging/rtl8192u/r8190_rtl8256.c
index e4abb15d2067..f11405076c2a 100644
--- a/drivers/staging/rtl8192u/r8190_rtl8256.c
+++ b/drivers/staging/rtl8192u/r8190_rtl8256.c
@@ -245,7 +245,7 @@ void phy_set_rf8256_cck_tx_power(struct net_device *dev, u8 powerlevel)
 }
 
 
-void PHY_SetRF8256OFDMTxPower(struct net_device *dev, u8 powerlevel)
+void phy_set_rf8256_ofdm_tx_power(struct net_device *dev, u8 powerlevel)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
 	/* Joseph TxPower for 8192 testing */
diff --git a/drivers/staging/rtl8192u/r8190_rtl8256.h b/drivers/staging/rtl8192u/r8190_rtl8256.h
index c291f699eaf7..c943a367d9e4 100644
--- a/drivers/staging/rtl8192u/r8190_rtl8256.h
+++ b/drivers/staging/rtl8192u/r8190_rtl8256.h
@@ -18,6 +18,6 @@ void phy_set_rf8256_bandwidth(struct net_device *dev,
 			      enum ht_channel_width bandwidth);
 void phy_rf8256_config(struct net_device *dev);
 void phy_set_rf8256_cck_tx_power(struct net_device *dev, u8 powerlevel);
-void PHY_SetRF8256OFDMTxPower(struct net_device *dev, u8 powerlevel);
+void phy_set_rf8256_ofdm_tx_power(struct net_device *dev, u8 powerlevel);
 
 #endif
diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl8192u/r819xU_phy.c
index 69bc0afd4e5c..5429a118efd4 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -918,7 +918,7 @@ void rtl8192_phy_setTxPower(struct net_device *dev, u8 channel)
 	case RF_8256:
 		/* need further implement */
 		phy_set_rf8256_cck_tx_power(dev, powerlevel);
-		PHY_SetRF8256OFDMTxPower(dev, powerlevelOFDM24G);
+		phy_set_rf8256_ofdm_tx_power(dev, powerlevelOFDM24G);
 		break;
 	default:
 		RT_TRACE((COMP_PHY|COMP_ERR),
@@ -1066,7 +1066,7 @@ static void rtl8192_SetTxPowerLevel(struct net_device *dev, u8 channel)
 
 	case RF_8256:
 		phy_set_rf8256_cck_tx_power(dev, powerlevel);
-		PHY_SetRF8256OFDMTxPower(dev, powerlevelOFDM24G);
+		phy_set_rf8256_ofdm_tx_power(dev, powerlevelOFDM24G);
 		break;
 
 	case RF_8258:
-- 
2.18.0

