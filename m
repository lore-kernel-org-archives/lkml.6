Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4773DC070C3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05EFE21476
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NiOo/MtY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05EFE21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbeJPMCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:02:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:50840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727783AbeJPMCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:02:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55F042145D;
        Tue, 16 Oct 2018 04:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663263;
        bh=5E0IY2ltCD/23OyvNlR5Cad2YzwiE0hjI+DfKXbOqTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NiOo/MtYSyXr5bewc8MKoxeRx8vt4XGWBWzOEFkVYzu5TrBo2RqFKPd5r6xXQQs3w
         Ge7bjOyIsYmhqbKRDgbA+i20mca3ULUyUDq6hw3JpWlbDWGsx5buzJF1TkXcFRhAgD
         /mtnVl3HLLM02hlWAj/GVHTNboskLoBR1WmFHdFE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Masashi Honma <masashi.honma@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 21/61] nl80211: Fix possible Spectre-v1 for NL80211_TXRATE_HT
Date:   Tue, 16 Oct 2018 00:13:23 -0400
Message-Id: <20181016041403.135678-21-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041403.135678-1-sashal@kernel.org>
References: <20181016041403.135678-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masashi Honma <masashi.honma@gmail.com>

[ Upstream commit 30fe6d50eb088783c8729c7d930f65296b2b3fa7 ]

Use array_index_nospec() to sanitize ridx with respect to speculation.

Signed-off-by: Masashi Honma <masashi.honma@gmail.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/nl80211.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 3de415bca391..5e7c9b361e8a 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3480,6 +3480,7 @@ static bool ht_rateset_to_mask(struct ieee80211_supported_band *sband,
 			return false;
 
 		/* check availability */
+		ridx = array_index_nospec(ridx, IEEE80211_HT_MCS_MASK_LEN);
 		if (sband->ht_cap.mcs.rx_mask[ridx] & rbit)
 			mcs[ridx] |= rbit;
 		else
-- 
2.17.1

