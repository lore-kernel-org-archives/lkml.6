Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED77C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3432C21527
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vkzW8ngv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3432C21527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390944AbeKLIX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:23:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:57060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390887AbeKLIX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:23:27 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18E4021582;
        Sun, 11 Nov 2018 22:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975610;
        bh=Bv8RpEdUhYMqZrk+MQ2Vb0R8tRd48PxpQYmjsTWVxXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vkzW8ngvNvxKWMcbZiGIW7+6v8kiMCSBhoylIDY/OnQ58CH/H/9hweh49wRJSxeEg
         IXZzDUYxdrSfNwj7025rXVxSgIRbhYkW1rkp8P/7sCCCy6Z1NIlAIP7v8ppt/tf2ve
         bkaa6JkUDoell5/+yw3dFmA+nrEV0ngf3FcTwkRA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 018/141] xfrm: policy: use hlist rcu variants on insert
Date:   Sun, 11 Nov 2018 14:24:37 -0800
Message-Id: <20181111221630.253983858@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221627.853046496@linuxfoundation.org>
References: <20181111221627.853046496@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 9dffff200fd178f11dd50eb1fd8ccd0650c9284e ]

bydst table/list lookups use rcu, so insertions must use rcu versions.

Fixes: a7c44247f704e ("xfrm: policy: make xfrm_policy_lookup_bytype lockless")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/xfrm/xfrm_policy.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -659,9 +659,9 @@ static void xfrm_hash_rebuild(struct wor
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
@@ -800,9 +800,9 @@ int xfrm_policy_insert(int dir, struct x
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
 


