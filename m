Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4900C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99EA82084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVsi7TNf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99EA82084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbeLEJkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:40:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:44786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728668AbeLEJk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:40:28 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73CC320878;
        Wed,  5 Dec 2018 09:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002827;
        bh=YjfV/qcAngNF465X+6pQ7QmVT7cR5Q53TnPcqa3q/Tc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dVsi7TNfcLc3orWg9QoVZgsbwbEcVFMxZrmaE+xEHj4Lxe+L+0B+OqJCUWj/EJDic
         XxMnHEhcZyaDr9SdMZVQ6NPjf4g8JcvQhgPq0xbtXmVEB0quUk4N6DgMA4pkVCe8wg
         CiAojGfasyw8Q64ZDxhRMNXKa9CHkBGMG3gnM/No=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Taehee Yoo <ap420073@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 079/123] netfilter: nf_conncount: remove wrong condition check routine
Date:   Wed,  5 Dec 2018 04:35:11 -0500
Message-Id: <20181205093555.5386-79-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taehee Yoo <ap420073@gmail.com>

[ Upstream commit 53ca0f2fec39c80ccd19e6e3f30cc8daef174b70 ]

All lists that reach the tree_nodes_free() function have both zero
counter and true dead flag. The reason for this is that lists to be
release are selected by nf_conncount_gc_list() which already decrements
the list counter and sets on the dead flag. Therefore, this if statement
in tree_nodes_free() is unnecessary and wrong.

Fixes: 31568ec09ea0 ("netfilter: nf_conncount: fix list_del corruption in conn_free")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_conncount.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nf_conncount.c b/net/netfilter/nf_conncount.c
index 8acae4a3e4c0..b6d0f6deea86 100644
--- a/net/netfilter/nf_conncount.c
+++ b/net/netfilter/nf_conncount.c
@@ -323,11 +323,8 @@ static void tree_nodes_free(struct rb_root *root,
 	while (gc_count) {
 		rbconn = gc_nodes[--gc_count];
 		spin_lock(&rbconn->list.list_lock);
-		if (rbconn->list.count == 0 && rbconn->list.dead == false) {
-			rbconn->list.dead = true;
-			rb_erase(&rbconn->node, root);
-			call_rcu(&rbconn->rcu_head, __tree_nodes_free);
-		}
+		rb_erase(&rbconn->node, root);
+		call_rcu(&rbconn->rcu_head, __tree_nodes_free);
 		spin_unlock(&rbconn->list.list_lock);
 	}
 }
-- 
2.17.1

