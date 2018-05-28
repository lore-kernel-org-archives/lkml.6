Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165323AbeE1NVZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:21:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:38878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163440AbeE1KtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:49:05 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 145/496] netfilter: ipt_CLUSTERIP: put config instead of freeing it
Date: Mon, 28 May 2018 11:58:50 +0200
Message-Id: <20180528100326.022704026@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 1a9da5937386dbe553ffcf6c65d985bd48c347c5 ]

Once struct is added to per-netns list it becomes visible to other cpus,
so we cannot use kfree().

Also delay setting entries refcount to 1 until after everything is
initialised so that when we call clusterip_config_put() in this spot
entries is still zero.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/netfilter/ipt_CLUSTERIP.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/net/ipv4/netfilter/ipt_CLUSTERIP.c
+++ b/net/ipv4/netfilter/ipt_CLUSTERIP.c
@@ -228,7 +228,6 @@ clusterip_config_init(struct net *net, c
 	c->hash_mode = i->hash_mode;
 	c->hash_initval = i->hash_initval;
 	refcount_set(&c->refcount, 1);
-	refcount_set(&c->entries, 1);
 
 	spin_lock_bh(&cn->lock);
 	if (__clusterip_config_find(net, ip)) {
@@ -259,8 +258,10 @@ clusterip_config_init(struct net *net, c
 
 	c->notifier.notifier_call = clusterip_netdev_event;
 	err = register_netdevice_notifier(&c->notifier);
-	if (!err)
+	if (!err) {
+		refcount_set(&c->entries, 1);
 		return c;
+	}
 
 #ifdef CONFIG_PROC_FS
 	proc_remove(c->pde);
@@ -269,7 +270,7 @@ err:
 	spin_lock_bh(&cn->lock);
 	list_del_rcu(&c->list);
 	spin_unlock_bh(&cn->lock);
-	kfree(c);
+	clusterip_config_put(c);
 
 	return ERR_PTR(err);
 }
