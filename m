Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB5AC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D28D208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8WRB7z9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D28D208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbeLEJiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:38:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:42038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727309AbeLEJiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:38:18 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8123A2084C;
        Wed,  5 Dec 2018 09:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002697;
        bh=25Ng+LAejBTsYCHYkAf9n69lSvLKSx9zHZS77ZoVKdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k8WRB7z92fox2Q2z0Oqc8sxtIJpxDRT4mBEfmRbNPYsgfFFKDuFvBTjC7bX8GfCRh
         R40nd/IQM9bqvWNGrtjG0zqm8VbA1scGQe628CCF/JCv09UDgYKtpmNA2sUagA+HUm
         71y3FtDPVdqNER1LJi/oyCmaHWaBIpjeiDAeo0fQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Taehee Yoo <ap420073@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 042/123] netfilter: xt_hashlimit: fix a possible memory leak in htable_create()
Date:   Wed,  5 Dec 2018 04:34:34 -0500
Message-Id: <20181205093555.5386-42-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taehee Yoo <ap420073@gmail.com>

[ Upstream commit b4e955e9f372035361fbc6f07b21fe2cc6a5be4a ]

In the htable_create(), hinfo is allocated by vmalloc()
So that if error occurred, hinfo should be freed.

Fixes: 11d5f15723c9 ("netfilter: xt_hashlimit: Create revision 2 to support higher pps rates")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/xt_hashlimit.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/xt_hashlimit.c b/net/netfilter/xt_hashlimit.c
index 3e7d259e5d8d..1ad4017f9b73 100644
--- a/net/netfilter/xt_hashlimit.c
+++ b/net/netfilter/xt_hashlimit.c
@@ -295,9 +295,10 @@ static int htable_create(struct net *net, struct hashlimit_cfg3 *cfg,
 
 	/* copy match config into hashtable config */
 	ret = cfg_copy(&hinfo->cfg, (void *)cfg, 3);
-
-	if (ret)
+	if (ret) {
+		vfree(hinfo);
 		return ret;
+	}
 
 	hinfo->cfg.size = size;
 	if (hinfo->cfg.max == 0)
@@ -814,7 +815,6 @@ hashlimit_mt_v1(const struct sk_buff *skb, struct xt_action_param *par)
 	int ret;
 
 	ret = cfg_copy(&cfg, (void *)&info->cfg, 1);
-
 	if (ret)
 		return ret;
 
@@ -830,7 +830,6 @@ hashlimit_mt_v2(const struct sk_buff *skb, struct xt_action_param *par)
 	int ret;
 
 	ret = cfg_copy(&cfg, (void *)&info->cfg, 2);
-
 	if (ret)
 		return ret;
 
@@ -921,7 +920,6 @@ static int hashlimit_mt_check_v1(const struct xt_mtchk_param *par)
 		return ret;
 
 	ret = cfg_copy(&cfg, (void *)&info->cfg, 1);
-
 	if (ret)
 		return ret;
 
@@ -940,7 +938,6 @@ static int hashlimit_mt_check_v2(const struct xt_mtchk_param *par)
 		return ret;
 
 	ret = cfg_copy(&cfg, (void *)&info->cfg, 2);
-
 	if (ret)
 		return ret;
 
-- 
2.17.1

