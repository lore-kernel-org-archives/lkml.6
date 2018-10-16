Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120B2C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78A421476
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7k5A32K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C78A421476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbeJPMCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:02:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729211AbeJPMCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:02:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DAC621480;
        Tue, 16 Oct 2018 04:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663264;
        bh=mSBwa44S3eqfKu/Md0buCPNiW6z6aeMaLyxPzsGPvWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p7k5A32KfG+YTqwOzTml0uk6BRQBJC2Ao+l0fiStc2MWoHkSa3hRKCdkdJtAvc6/V
         W+7DhbmF8XrxOcQBxQWjIuTz93+qUbK7llPV+x/+KXy+v2mYemUQkINCZirjc+UumQ
         2j19+37ejcBBdmfvXYMS+SP1KjnG4qTJUL8NtaMo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Martin Willi <martin@strongswan.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 22/61] mac80211_hwsim: do not omit multicast announce of first added radio
Date:   Tue, 16 Oct 2018 00:13:24 -0400
Message-Id: <20181016041403.135678-22-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041403.135678-1-sashal@kernel.org>
References: <20181016041403.135678-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Willi <martin@strongswan.org>

[ Upstream commit 28ef8b49a338dc1844e86b7954cfffc7dfa2660a ]

The allocation of hwsim radio identifiers uses a post-increment from 0,
so the first radio has idx 0. This idx is explicitly excluded from
multicast announcements ever since, but it is unclear why.

Drop that idx check and announce the first radio as well. This makes
userspace happy if it relies on these events.

Signed-off-by: Martin Willi <martin@strongswan.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mac80211_hwsim.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index aafa7aa18fbd..477f9f2f6626 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -2730,8 +2730,7 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 	list_add_tail(&data->list, &hwsim_radios);
 	spin_unlock_bh(&hwsim_radio_lock);
 
-	if (idx > 0)
-		hwsim_mcast_new_radio(idx, info, param);
+	hwsim_mcast_new_radio(idx, info, param);
 
 	return idx;
 
-- 
2.17.1

