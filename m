Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DD9ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1861208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3myy5+q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1861208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729780AbeKIHgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:36:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:53434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728347AbeKIHgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:36:13 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2463520892;
        Thu,  8 Nov 2018 21:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714325;
        bh=QL0xlfyZnYCL5sGoKwdQthXM7Vhq5LC/gi3REOGWTtQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e3myy5+q/CJtQ+a+TsndWbqHCY6EYa20HX0ViSlFIJJ2TZQNrZuIrF8FdS6NwUQ6Y
         jVgAgc6dTKBWOHPGtNwbcuUp3AMb3XKbMrMAOyOAytOD+kDIG/lgttZ1Yk2ZEK3I0P
         YlrqSCYWWWQzJt04BU4vly/fXpyGaLAEYLz2O4t0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 004/114] cfg80211: reg: Init wiphy_idx in regulatory_hint_core()
Date:   Thu,  8 Nov 2018 13:50:19 -0800
Message-Id: <20181108215059.395603189@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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



