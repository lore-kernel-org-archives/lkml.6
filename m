Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB27AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C37F21741
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864753;
	bh=PUjI5Uku66uBCKDm6TyROCWeAXxbktFSb0wGojmIHnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SKzwahmqmK1AveQR/HezOfKSS5j1HJgzwoebHpoyfgpCCCe5iPrOgmAlmwhjTpvng
	 n1IvWZx2FBKzivsKvcNOIM7qbsLIcwzCPVWn7o1j14JiVm78QfGfK3VF5fXn9qQJ/Y
	 iDvUm6AGT2EoaQ1f+UNENfmxiVrOkfZHyFKiSNYc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbeLZWwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:52:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:37060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727975AbeLZWg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:36:59 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 824B3218FC;
        Wed, 26 Dec 2018 22:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863818;
        bh=PUjI5Uku66uBCKDm6TyROCWeAXxbktFSb0wGojmIHnQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RO0ZFJ9ZYUoKVAchIs9xtmoqlHGKXp8g0cMwpd9mKd/xNcb+jzmwvo+OFjALcYSpe
         od5T7ZSR362c6nxAjMwMiLXWL+z2giBFFMN4wevnfkRCsqfod/yCjCnusN7eLeK5ss
         ekXDDKDh32DgU+1TduCAgbcqOpKhce8t2FdLwS6Y=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Taehee Yoo <ap420073@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 37/97] netfilter: nf_conncount: use rb_link_node_rcu() instead of rb_link_node()
Date:   Wed, 26 Dec 2018 17:34:57 -0500
Message-Id: <20181226223557.149329-37-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taehee Yoo <ap420073@gmail.com>

[ Upstream commit d4e7df16567b80836a78d31b42f1a9355a636d67 ]

rbnode in insert_tree() is rcu protected pointer.
So, in order to handle this pointer, _rcu function should be used.
rb_link_node_rcu() is a rcu version of rb_link_node().

Fixes: 34848d5c896e ("netfilter: nf_conncount: Split insert and traversal")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_conncount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_conncount.c b/net/netfilter/nf_conncount.c
index b6d0f6deea86..9cd180bda092 100644
--- a/net/netfilter/nf_conncount.c
+++ b/net/netfilter/nf_conncount.c
@@ -427,7 +427,7 @@ insert_tree(struct net *net,
 	count = 1;
 	rbconn->list.count = count;
 
-	rb_link_node(&rbconn->node, parent, rbnode);
+	rb_link_node_rcu(&rbconn->node, parent, rbnode);
 	rb_insert_color(&rbconn->node, root);
 out_unlock:
 	spin_unlock_bh(&nf_conncount_locks[hash % CONNCOUNT_LOCK_SLOTS]);
-- 
2.19.1

