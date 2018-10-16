Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433AEC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A3C2098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtoGb8pg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02A3C2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbeJPMC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:02:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729340AbeJPMC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:02:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D82D21470;
        Tue, 16 Oct 2018 04:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663273;
        bh=NLDRErPHUGVU6AJ6yqtHlDs0En8ukSv5Y2M8TWgYplA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rtoGb8pg+8fvlbRBhbb6nlYghzXwei2Z5kQgppjMzVcS1cWC8hgo2mjd0SPAtlr6i
         gib9+klfJZWKR+DPA0BMdhuxxN9JYd97xE7hgvbR+j4rCQu3qSxiMuTvuKB9Ql4ZQJ
         A8yjUCG+xtnuOs8XiISEdfqhu4YI4GzaAvb9Vby4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Masashi Honma <masashi.honma@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 33/61] nl80211: Fix possible Spectre-v1 for CQM RSSI thresholds
Date:   Tue, 16 Oct 2018 00:13:35 -0400
Message-Id: <20181016041403.135678-33-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041403.135678-1-sashal@kernel.org>
References: <20181016041403.135678-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masashi Honma <masashi.honma@gmail.com>

[ Upstream commit 1222a16014888ed9733c11e221730d4a8196222b ]

Use array_index_nospec() to sanitize i with respect to speculation.

Note that the user doesn't control i directly, but can make it out
of bounds by not finding a threshold in the array.

Signed-off-by: Masashi Honma <masashi.honma@gmail.com>
[add note about user control, as explained by Masashi]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/nl80211.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 5e7c9b361e8a..46e9812d13c0 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -9720,7 +9720,7 @@ static int cfg80211_cqm_rssi_update(struct cfg80211_registered_device *rdev,
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	s32 last, low, high;
 	u32 hyst;
-	int i, n;
+	int i, n, low_index;
 	int err;
 
 	/* RSSI reporting disabled? */
@@ -9757,10 +9757,19 @@ static int cfg80211_cqm_rssi_update(struct cfg80211_registered_device *rdev,
 		if (last < wdev->cqm_config->rssi_thresholds[i])
 			break;
 
-	low = i > 0 ?
-		(wdev->cqm_config->rssi_thresholds[i - 1] - hyst) : S32_MIN;
-	high = i < n ?
-		(wdev->cqm_config->rssi_thresholds[i] + hyst - 1) : S32_MAX;
+	low_index = i - 1;
+	if (low_index >= 0) {
+		low_index = array_index_nospec(low_index, n);
+		low = wdev->cqm_config->rssi_thresholds[low_index] - hyst;
+	} else {
+		low = S32_MIN;
+	}
+	if (i < n) {
+		i = array_index_nospec(i, n);
+		high = wdev->cqm_config->rssi_thresholds[i] + hyst - 1;
+	} else {
+		high = S32_MAX;
+	}
 
 	return rdev_set_cqm_rssi_range_config(rdev, dev, low, high);
 }
-- 
2.17.1

