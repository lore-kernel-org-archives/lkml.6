Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE87C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10BE5204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217370;
	bh=MfO/PqNymlUNc7ij60eWd1rl6GqJ04zc26QmCMXU+4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=19usoJOYNw3lXf3B9ViHAoZ6Arb+/3OkNPRlYBDbzxyKlPmOyIzijo8dJnkx+VgE4
	 f8gN3c2OWfSrYzeCqfnLTxqpr7k1niaQ7dF7zuV+9j6fQzHA/SyBRn7/xL7l3iuaAj
	 34ZCsuUkChAJdKb9O/Jo7Zp+l4liqE/lodOpLtH0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390305AbfAKOgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:36:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:56394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390276AbfAKOgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:36:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D035A204EC;
        Fri, 11 Jan 2019 14:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217365;
        bh=MfO/PqNymlUNc7ij60eWd1rl6GqJ04zc26QmCMXU+4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t4vVvPvzHPkLnrRBUzT44wnaNP8FDAmhBFJw3ruwr6xYEiucirZ+yMbTskjVoOlbO
         6j7KCV47SVITUUZi7e0lMdTyNN2ipm/K88o3ELdH7CsSkZ8WpRw8FLNN4DrVJAlBU8
         J8xOYWFBDn1ovc8lh3tKxCWl9y9Ta92XAR6b5qGU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 035/148] netfilter: nf_conncount: use rb_link_node_rcu() instead of rb_link_node()
Date:   Fri, 11 Jan 2019 15:13:33 +0100
Message-Id: <20190111131115.697675590@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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



