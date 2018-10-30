Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6086CC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286F320838
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUEC4Exj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 286F320838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbeJ3WX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:23:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:53944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727992AbeJ3WX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:23:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EFAD20838;
        Tue, 30 Oct 2018 13:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540906230;
        bh=MNi+oiTR2ERV02NvErlUISZaqhpJVa/433iTd7U798A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lUEC4Exj7VDHrCNvM59nKLTCl7mhv50EpjqeevTUn7zGGNJ3ZjRYo31lweDYj6ZRW
         9tiJx4ot6nHHy05L5ugDOz7sJRWSjNwbGlXf+NH8Z5+hmVvYzNACjtILXDrl+/746a
         QIbjjVJ3Ftp6H8v8BD7tP+MulrF5fniSjSQPNS78=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Florian Westphal <fw@strlen.de>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 03/13] xfrm: policy: use hlist rcu variants on insert
Date:   Tue, 30 Oct 2018 09:29:13 -0400
Message-Id: <20181030132923.218124-3-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030132923.218124-1-sashal@kernel.org>
References: <20181030132923.218124-1-sashal@kernel.org>
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
index d0dcfc68c043..155b1591b17a 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -659,9 +659,9 @@ static void xfrm_hash_rebuild(struct work_struct *work)
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
@@ -800,9 +800,9 @@ int xfrm_policy_insert(int dir, struct xfrm_policy *policy, int excl)
 			break;
 	}
 	if (newpos)
-		hlist_add_behind(&policy->bydst, newpos);
+		hlist_add_behind_rcu(&policy->bydst, newpos);
 	else
-		hlist_add_head(&policy->bydst, chain);
+		hlist_add_head_rcu(&policy->bydst, chain);
 	__xfrm_policy_link(policy, dir);
 	atomic_inc(&net->xfrm.flow_cache_genid);
 
-- 
2.17.1

