Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67711C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61652081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YejsDxFo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C61652081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbeKCEK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:10:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729513AbeKCD5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:57:10 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 661932082D;
        Fri,  2 Nov 2018 18:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184536;
        bh=yCDOP+Rjo4THYIJKu6BxR86Qr8NBUf8fTLmI8RLlVyk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YejsDxFouisIR2gnJKPnKKay5zKzSRSwgofvFn5LbsZnzZ2zdnBr03T9wf6UoRWQx
         S5okEoa7QS/KDMbxlSTCMc0fUk8pbJtKdr4gcG0tBPShiuJqIlozRUJst0NBC9L7DC
         qncaROEcQDKXIyD9mqUABn14tljisBILFri85Sww=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masashi Honma <masashi.honma@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 029/143] nl80211: Fix possible Spectre-v1 for CQM RSSI thresholds
Date:   Fri,  2 Nov 2018 19:33:34 +0100
Message-Id: <20181102182859.412533830@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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



