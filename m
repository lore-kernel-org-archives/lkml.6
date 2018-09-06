Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE9CC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69DDC2083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScYizKca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69DDC2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbeIFNch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:32:37 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43710 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbeIFNch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:32:37 -0400
Received: by mail-pf1-f195.google.com with SMTP id j26-v6so4940903pfi.10;
        Thu, 06 Sep 2018 01:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ww6MeoaO70E/3i2L5ecT5nfX8TmRL7LA8ebcVLUJN6s=;
        b=ScYizKcaxZKF7UA8N9Bl92BjVxkSGYHE4EMLa4hKM1TACqsN6Zu0isdUV6PFWky05T
         FDnmzLiZDHadVP0Q7LsSy2QxJ/oskIytgw9FySj5alUQR1dfVMJxKQWEr5FTNAfHWgpn
         4FzO/YhI067ZSq50lf/uiirZvUwPjEUvqmhhOr0a9BTEJStAfik7qFIFKrsryTCXhpEI
         VfNtM+r5Lw12zhI5aH79rhrzuYsKZx4amNFZVhaCd/w8L5heo7MfLhGyEV7OeLr2sQW3
         hWmR9mUmwyqmACaTibCMBcr3zdF6OELQ/V4NwM7f8ByqUGFI3XkT6jcRLRP0hCE7YQS/
         Okqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ww6MeoaO70E/3i2L5ecT5nfX8TmRL7LA8ebcVLUJN6s=;
        b=i+EEyU07Ylp2nZ/rtK/h+qk3GHjon6NJnRTW77Kz2jpmeMFOKciXoeCBoDiLjhXgJ8
         BHS6H5hlDESy+KObPcg8oVI/Es3mNt71X8JzElRToEFOEoOFpLHRU8wOzfJXLALJKkDR
         S5NDPcgo1OSMdttig7TX9J+cLQeB7bNhjOGSae6UF6BKSWTpkh2CCli4w8zcJDHfVls2
         PCwWPY9wNRsOwP5op8fa+h1uj0vSt3tn5/rtLAjOqzMyodxuK3OEv78QqhNLsrja2UeU
         2JN0fZc2B0BRysf6D+8cWhKakAWCEHNr0tXwqETaxyKK5KyaIbpafeHyccCg3OMTynBu
         swfg==
X-Gm-Message-State: APzg51CyAEYdJqYocXd4OJ3ijEcn3QwFM+I8VXTlet0DMaHmbW8+fHE4
        Hptw20K2v61dEk7Avdf8QUU=
X-Google-Smtp-Source: ANB0Vdblf6nMCyDzJBhIlLVybnQ9VA8DINvO1x+ZFEgHMTIalkSmRCP61XX9/5Y5h0WUfE6ME23eQQ==
X-Received: by 2002:a63:f849:: with SMTP id v9-v6mr1700806pgj.71.1536224291042;
        Thu, 06 Sep 2018 01:58:11 -0700 (PDT)
Received: from localhost.localdomain ([122.146.92.136])
        by smtp.gmail.com with ESMTPSA id s3-v6sm5786251pgj.84.2018.09.06.01.58.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Sep 2018 01:58:10 -0700 (PDT)
From:   Yuan-Chi Pang <fu3mo6goo@gmail.com>
Cc:     fu3mo6goo@gmail.com, Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mac80211: fix TX status reporting for ieee80211s
Date:   Thu,  6 Sep 2018 16:57:48 +0800
Message-Id: <1536224269-69350-1-git-send-email-fu3mo6goo@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535963610.3437.10.camel@sipsolutions.net>
References: <1535963610.3437.10.camel@sipsolutions.net>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TX status reporting to ieee80211s is through ieee80211s_update_metric.
There are two problems about ieee80211s_update_metric:

1. The purpose is to estimate the fail probability
to a specific link. No need to restrict to data frame.

2. Current implementation does not work if wireless driver does not
pass tx_status with skb.

Fix this by removing ieee80211_is_data condition, passing
ieee80211_tx_status directly to ieee80211s_update_metric, and
putting it in both __ieee80211_tx_status and ieee80211_tx_status_ext.

Signed-off-by: Yuan-Chi Pang <fu3mo6goo@gmail.com>
---
 net/mac80211/mesh.h      | 2 +-
 net/mac80211/mesh_hwmp.c | 8 ++------
 net/mac80211/status.c    | 4 +++-
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/mesh.h b/net/mac80211/mesh.h
index ee56f18..7ffe56a 100644
--- a/net/mac80211/mesh.h
+++ b/net/mac80211/mesh.h
@@ -217,7 +217,7 @@ void mesh_rmc_free(struct ieee80211_sub_if_data *sdata);
 int mesh_rmc_init(struct ieee80211_sub_if_data *sdata);
 void ieee80211s_init(void);
 void ieee80211s_update_metric(struct ieee80211_local *local,
-			      struct sta_info *sta, struct sk_buff *skb);
+			 struct sta_info *sta, struct ieee80211_tx_status *st);
 void ieee80211_mesh_init_sdata(struct ieee80211_sub_if_data *sdata);
 void ieee80211_mesh_teardown_sdata(struct ieee80211_sub_if_data *sdata);
 int ieee80211_start_mesh(struct ieee80211_sub_if_data *sdata);
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index daf9db3..4286673 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -295,15 +295,11 @@ int mesh_path_error_tx(struct ieee80211_sub_if_data *sdata,
 }
 
 void ieee80211s_update_metric(struct ieee80211_local *local,
-		struct sta_info *sta, struct sk_buff *skb)
+		struct sta_info *sta, struct ieee80211_tx_status *st)
 {
-	struct ieee80211_tx_info *txinfo = IEEE80211_SKB_CB(skb);
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *) skb->data;
+	struct ieee80211_tx_info *txinfo = st->info;
 	int failed;
 
-	if (!ieee80211_is_data(hdr->frame_control))
-		return;
-
 	failed = !(txinfo->flags & IEEE80211_TX_STAT_ACK);
 
 	/* moving average, scaled to 100.
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index 9a6d720..dfcd419 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -811,7 +811,7 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 
 		rate_control_tx_status(local, sband, status);
 		if (ieee80211_vif_is_mesh(&sta->sdata->vif))
-			ieee80211s_update_metric(local, sta, skb);
+			ieee80211s_update_metric(local, sta, status);
 
 		if (!(info->flags & IEEE80211_TX_CTL_INJECTED) && acked)
 			ieee80211_frame_acked(sta, skb);
@@ -972,6 +972,8 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 		}
 
 		rate_control_tx_status(local, sband, status);
+		if (ieee80211_vif_is_mesh(&sta->sdata->vif))
+			ieee80211s_update_metric(local, sta, status);
 	}
 
 	if (acked || noack_success) {
-- 
2.7.4

