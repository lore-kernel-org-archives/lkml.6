Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84F0C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B572145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="by9IMvGA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B572145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbeJPMBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:01:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:48312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728116AbeJPMBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:01:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3A5A20869;
        Tue, 16 Oct 2018 04:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663178;
        bh=PwhcTO6ypne51VErD4IcC3dNTxOK00d+w1Z/V/hHJP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=by9IMvGAmNQIzilT/RCw1I/AwtpLWD1fbU2bPDX3xFXDEJz/NMtYZJpchzcjSkZEC
         MgW9MVZPoXNZCE2xti1hrm07YKQo/AcUmo1a2PUIE06GJuInGZZKQvbpWaih1faWz+
         Q4htN9zoZO5sasmBQEgaH7iEY5xPdrRcDMjAULV4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Masashi Honma <masashi.honma@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 038/100] nl80211: Fix possible Spectre-v1 for CQM RSSI thresholds
Date:   Tue, 16 Oct 2018 00:11:19 -0400
Message-Id: <20181016041221.135528-38-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
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
index 3b80cf012438..214f9ef79a64 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10125,7 +10125,7 @@ static int cfg80211_cqm_rssi_update(struct cfg80211_registered_device *rdev,
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	s32 last, low, high;
 	u32 hyst;
-	int i, n;
+	int i, n, low_index;
 	int err;
 
 	/* RSSI reporting disabled? */
@@ -10162,10 +10162,19 @@ static int cfg80211_cqm_rssi_update(struct cfg80211_registered_device *rdev,
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

