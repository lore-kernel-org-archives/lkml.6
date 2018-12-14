Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C1AC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE70214D9
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789312;
	bh=DJuJpRRTpFkuh+0WmvBMYsbOU9wtmdnZKrofnAKAfmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q69GyXcTJH/5Cw2+BXJnbPCly179NmaNadVzO2dYCCN+bHJm9RyQTao3ILj9SjVPz
	 PnVL6phxX+eiFv+YS3EUaIi3SzSEL4uehwTqG1g3Lb8G6wzuUjxTgYXRajsviLia07
	 Lr5PsrXsLfZ8cs6Y0O7YN1zvusPAkSO5E/J77pEE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CE70214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730550AbeLNMIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:08:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:53860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731259AbeLNMIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:08:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B6D4214AE;
        Fri, 14 Dec 2018 12:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789305;
        bh=DJuJpRRTpFkuh+0WmvBMYsbOU9wtmdnZKrofnAKAfmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1k7Ti2JlpQGsayPUcuhE8Pfs7XYxknnaAUYEp9Gs6ZV2GIOggasM0b87K951coLEH
         dWJMVX/q+tueoGvNKvlAXlVO0uFTWB/m69jbfohZds/JPXu1hsJahqOtIRy0YeVJlU
         +FI43/VgJFi7YTRT0M2S3O+UKn88LiGsbQREgRn8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 31/89] netfilter: xt_hashlimit: fix a possible memory leak in htable_create()
Date:   Fri, 14 Dec 2018 12:59:44 +0100
Message-Id: <20181214115731.228742419@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index 0c034597b9b8..fe8e8a1622b5 100644
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
 
@@ -920,7 +919,6 @@ static int hashlimit_mt_check_v1(const struct xt_mtchk_param *par)
 		return ret;
 
 	ret = cfg_copy(&cfg, (void *)&info->cfg, 1);
-
 	if (ret)
 		return ret;
 
@@ -939,7 +937,6 @@ static int hashlimit_mt_check_v2(const struct xt_mtchk_param *par)
 		return ret;
 
 	ret = cfg_copy(&cfg, (void *)&info->cfg, 2);
-
 	if (ret)
 		return ret;
 
-- 
2.19.1



