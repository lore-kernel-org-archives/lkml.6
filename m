Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1BAC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1EE20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yfSRWpGW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D1EE20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbeJPMEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:04:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:53510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729125AbeJPMEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:04:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 586A9214AB;
        Tue, 16 Oct 2018 04:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663372;
        bh=qPRCtA8k03NdbKS8quRWD1AA5Fc8Z7kWDvUoCSr6QKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yfSRWpGWATFNr2iU1ltJ3pDjmLuWle7bzDaBsg+3LsH72SvEiSO0IzZm7/T47vK19
         JipZASf3JflODdNh/wD0UywoBELG0HxpCheMiJ+r+3DQMei8q0y3sfl8CcFGu9E4QR
         fw8uan5quo0PfQ8PbSoh0nrzo4Cl4iQbZCM8dVFg=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 04/25] cfg80211: reg: Init wiphy_idx in regulatory_hint_core()
Date:   Tue, 16 Oct 2018 00:15:45 -0400
Message-Id: <20181016041606.135876-4-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041606.135876-1-sashal@kernel.org>
References: <20181016041606.135876-1-sashal@kernel.org>
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
index 06d050da0d94..50dffd183cc6 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2367,6 +2367,7 @@ static int regulatory_hint_core(const char *alpha2)
 	request->alpha2[0] = alpha2[0];
 	request->alpha2[1] = alpha2[1];
 	request->initiator = NL80211_REGDOM_SET_BY_CORE;
+	request->wiphy_idx = WIPHY_IDX_INVALID;
 
 	queue_regulatory_request(request);
 
-- 
2.17.1

