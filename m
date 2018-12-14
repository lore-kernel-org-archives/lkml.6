Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F111C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EB402147C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789018;
	bh=002hMrZurczKj3y/JFpzaLPtg9lCanElWKs4UWAGA7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1Y6DMJIrfirHnT3xV40q4hHRBmoyefyBpssab2S34MK9RmoKAMBS8iTKLh651Db0f
	 6xYzIrSWzQ0vdgeKzJLORLJTQbvtUll/1iHCf7pT+p5cwxowpm+MkgvMR+wvjPEX/a
	 N0Q42ZVGwap5H9K9cwFeLU4b28Vb0Yk8UgCP6w0M=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EB402147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbeLNMDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:03:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:47348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729775AbeLNMDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:03:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 477832145D;
        Fri, 14 Dec 2018 12:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789011;
        bh=002hMrZurczKj3y/JFpzaLPtg9lCanElWKs4UWAGA7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LshzqQ/0jdSDEXbe+K3iym7FPHJ4x41rWnDGSjIDOup2cVihPRsBCMLBeWMXmO/XV
         TSwznrPGyzkrF/t3Ea/qeEpZgXwm8bPzb+tVwXz0CaFRlXH35F3xvW82pvjtZxtW2K
         Of+/1ZlctN9Yx1/ljMikYmSuXQnORn98qNycYbXA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 060/142] netfilter: xt_hashlimit: fix a possible memory leak in htable_create()
Date:   Fri, 14 Dec 2018 12:59:05 +0100
Message-Id: <20181214115749.458157458@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
2.19.1



