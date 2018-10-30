Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927DDC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A6120870
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYEMiWya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A6120870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbeJ3WWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:22:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727759AbeJ3WWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:22:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCDFF20870;
        Tue, 30 Oct 2018 13:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540906118;
        bh=Et4T+K3PC2/IlX54horCuM98sawd3i0z0TehWOStdFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OYEMiWyauOrBAMtF21lJXiDZncb2mzsIWhTEJzdNLhX4SniheJaXueUiwFCbP+0g+
         0rzLHrokCSJmSO2v00OszQDUI01O8EEklvS5GG7x+8xHDxvdlscx1ry5ffVNE67nyB
         a2UYDEkgpeWC+KRrPL74HBvO70sK/imEwIcFLRZQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Florian Westphal <fw@strlen.de>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 04/19] xfrm: policy: use hlist rcu variants on insert
Date:   Tue, 30 Oct 2018 09:28:09 -0400
Message-Id: <20181030132824.218056-4-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030132824.218056-1-sashal@kernel.org>
References: <20181030132824.218056-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 9dffff200fd178f11dd50eb1fd8ccd0650c9284e ]

bydst table/list lookups use rcu, so insertions must use rcu versions.

Fixes: a7c44247f704e ("xfrm: policy: make xfrm_policy_lookup_bytype lockless")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_policy.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 2fb7a78308e1..f60ff9b6a731 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -626,9 +626,9 @@ static void xfrm_hash_rebuild(struct work_struct *work)
 				break;
 		}
 		if (newpos)
-			hlist_add_behind(&policy->bydst, newpos);
+			hlist_add_behind_rcu(&policy->bydst, newpos);
 		else
-			hlist_add_head(&policy->bydst, chain);
+			hlist_add_head_rcu(&policy->bydst, chain);
 	}
 
 	spin_unlock_bh(&net->xfrm.xfrm_policy_lock);
@@ -767,9 +767,9 @@ int xfrm_policy_insert(int dir, struct xfrm_policy *policy, int excl)
 			break;
 	}
 	if (newpos)
-		hlist_add_behind(&policy->bydst, newpos);
+		hlist_add_behind_rcu(&policy->bydst, newpos);
 	else
-		hlist_add_head(&policy->bydst, chain);
+		hlist_add_head_rcu(&policy->bydst, chain);
 	__xfrm_policy_link(policy, dir);
 
 	/* After previous checking, family can either be AF_INET or AF_INET6 */
-- 
2.17.1

