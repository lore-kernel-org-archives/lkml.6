Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224A4C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E04B721477
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zaZHSnCV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E04B721477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbeJPMCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:02:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:50546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729075AbeJPMCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:02:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6EF421476;
        Tue, 16 Oct 2018 04:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663254;
        bh=hEbZ+MD11StPve5h2gVF5MFtPBXyn9532+ZnHL/erTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zaZHSnCVDpjUt2m9z2mLIGQVmp2lYVJTfaoIuyKLQBFbS1swW+UGgffM7TuC0RJvY
         6VQE85U6e+JNiDjKwQ1xnuOa9sBLCkUTW05P4rB0M6JWUOtwKqM1dgGt2JXAfFPwUf
         XFm/BgxM2n5HYCjOW3xCt8joSDgHMmVMhDokJkHs=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yuan-Chi Pang <fu3mo6goo@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 10/61] mac80211: fix TX status reporting for ieee80211s
Date:   Tue, 16 Oct 2018 00:13:12 -0400
Message-Id: <20181016041403.135678-10-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041403.135678-1-sashal@kernel.org>
References: <20181016041403.135678-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuan-Chi Pang <fu3mo6goo@gmail.com>

[ Upstream commit c42055105785580563535e6d3143cad95c7ac7ee ]

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
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mesh.h      | 3 ++-
 net/mac80211/mesh_hwmp.c | 9 +++------
 net/mac80211/status.c    | 4 +++-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/mesh.h b/net/mac80211/mesh.h
index 7e5f271e3c30..4f1c61637ce3 100644
--- a/net/mac80211/mesh.h
+++ b/net/mac80211/mesh.h
@@ -217,7 +217,8 @@ void mesh_rmc_free(struct ieee80211_sub_if_data *sdata);
 int mesh_rmc_init(struct ieee80211_sub_if_data *sdata);
 void ieee80211s_init(void);
 void ieee80211s_update_metric(struct ieee80211_local *local,
-			      struct sta_info *sta, struct sk_buff *skb);
+			      struct sta_info *sta,
+			      struct ieee80211_tx_status *st);
 void ieee80211_mesh_init_sdata(struct ieee80211_sub_if_data *sdata);
 void ieee80211_mesh_teardown_sdata(struct ieee80211_sub_if_data *sdata);
 int ieee80211_start_mesh(struct ieee80211_sub_if_data *sdata);
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 055ea36ff27b..fab0764c315f 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -295,15 +295,12 @@ int mesh_path_error_tx(struct ieee80211_sub_if_data *sdata,
 }
 
 void ieee80211s_update_metric(struct ieee80211_local *local,
-		struct sta_info *sta, struct sk_buff *skb)
+			      struct sta_info *sta,
+			      struct ieee80211_tx_status *st)
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
index ccac205e5853..bdf131ed5ce8 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -797,7 +797,7 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 
 		rate_control_tx_status(local, sband, status);
 		if (ieee80211_vif_is_mesh(&sta->sdata->vif))
-			ieee80211s_update_metric(local, sta, skb);
+			ieee80211s_update_metric(local, sta, status);
 
 		if (!(info->flags & IEEE80211_TX_CTL_INJECTED) && acked)
 			ieee80211_frame_acked(sta, skb);
@@ -958,6 +958,8 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 		}
 
 		rate_control_tx_status(local, sband, status);
+		if (ieee80211_vif_is_mesh(&sta->sdata->vif))
+			ieee80211s_update_metric(local, sta, status);
 	}
 
 	if (acked || noack_success) {
-- 
2.17.1

