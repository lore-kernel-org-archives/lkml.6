Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76470C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2761F20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="l07eMoI3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2761F20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbeJPML0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:11:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:52478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729721AbeJPMDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:03:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B6C720866;
        Tue, 16 Oct 2018 04:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663329;
        bh=1IlUiw3aPSkPTp47I1mJfGXbX6SjnwBY9aUfdNdq0Rs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l07eMoI3NjAFM0NjdkyduUwViVXQ1qSx22ETKFt+CEygL7mOhvuK3GiPEokR8qIyB
         cqiPu9T+JI/PQUPrdcMZPBQbteS8Kr0BIWb8c51AeJdJRiq79rTZIM3LKp6sc1LDI4
         ACPO7kbIozmUNDppPPGz9PURBpfEunw97zTM4vbc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 04/38] cfg80211: reg: Init wiphy_idx in regulatory_hint_core()
Date:   Tue, 16 Oct 2018 00:14:48 -0400
Message-Id: <20181016041522.135789-4-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041522.135789-1-sashal@kernel.org>
References: <20181016041522.135789-1-sashal@kernel.org>
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
index 5dbac3749738..36d1d25082e3 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2298,6 +2298,7 @@ static int regulatory_hint_core(const char *alpha2)
 	request->alpha2[0] = alpha2[0];
 	request->alpha2[1] = alpha2[1];
 	request->initiator = NL80211_REGDOM_SET_BY_CORE;
+	request->wiphy_idx = WIPHY_IDX_INVALID;
 
 	queue_regulatory_request(request);
 
-- 
2.17.1

