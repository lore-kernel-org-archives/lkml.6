Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB84C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C53208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSEUabeh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C53208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbeJPMAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:00:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbeJPMAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:00:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80D0D2098A;
        Tue, 16 Oct 2018 04:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663151;
        bh=4RAFpfr4sjoQUP8CxpjR6J+3raqu4Yoi99juJASXioA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NSEUabehvYjKAckOvYhEZ2AleT0/LhvNN9wYF8CJKisRaeLfauH5z/zFqUnLHzdcI
         PZplIvTZiNEXAMeglvgXxhCaUXDL9KSPT56XfmO9anAN0t5J3hwDCCG5PYDdd7GtLX
         L0usVzMc2B0YBVk2EQ5eJQfjXjaXD3f5JBXpFn3g=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 006/100] cfg80211: reg: Init wiphy_idx in regulatory_hint_core()
Date:   Tue, 16 Oct 2018 00:10:47 -0400
Message-Id: <20181016041221.135528-6-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>

[ Upstream commit 24f33e64fcd0d50a4b1a8e5b41bd0257aa66b0e8 ]

Core regulatory hints didn't set wiphy_idx to WIPHY_IDX_INVALID. Since
the regulatory request is zeroed, wiphy_idx was always implicitly set to
0. This resulted in updating only phy #0.
Fix that.

Fixes: 806a9e39670b ("cfg80211: make regulatory_request use wiphy_idx instead of wiphy")
Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
[add fixes tag]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/reg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 2f702adf2912..765dedb12361 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2867,6 +2867,7 @@ static int regulatory_hint_core(const char *alpha2)
 	request->alpha2[0] = alpha2[0];
 	request->alpha2[1] = alpha2[1];
 	request->initiator = NL80211_REGDOM_SET_BY_CORE;
+	request->wiphy_idx = WIPHY_IDX_INVALID;
 
 	queue_regulatory_request(request);
 
-- 
2.17.1

