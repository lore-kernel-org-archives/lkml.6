Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C16C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1057420652
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131264;
	bh=i4+UjnbMYybqDcCGsiQhMYQUZEkqANtfihUyT6Bem2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c0LmxMHYuZEJALaAaEnnxiAH2danuJMkL3DQFctBlJUqgO5cxJumODGGjT9MN/EPN
	 oacyHpnIfZFmyCfd3s127VlGvrUch6UO+Cg65GT/cykYIso/iyXzpu7aD0PVQNVedN
	 3BCT7u0eKVW3Tzwlk9IjLlRcCLPuwansd1SOYTlY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731743AbfBYV13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:27:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:33356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729693AbfBYV1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:27:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4953C213A2;
        Mon, 25 Feb 2019 21:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130044;
        bh=i4+UjnbMYybqDcCGsiQhMYQUZEkqANtfihUyT6Bem2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oGKQpoVIrp3JUKEerYRAaBYf/RbxuAYBu3ZcS3rqoN1EYRGtKOVi4aO72Alsc2qj1
         W2IiguV48zpYWz4CFjp7xmNuaY7hYGxsd6rZI13AjII3Mu+aWOOSnGTdOSXO97c5qU
         NJSQzsS14NpbJg/Vw+M0D5bPDzRJ9PDACZO8lHbI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.19 150/152] netfilter: ipt_CLUSTERIP: fix sleep-in-atomic bug in clusterip_config_entry_put()
Date:   Mon, 25 Feb 2019 22:12:22 +0100
Message-Id: <20190225195055.274072757@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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

From: Taehee Yoo <ap420073@gmail.com>

commit 2a61d8b883bbad26b06d2e6cc3777a697e78830d upstream.

A proc_remove() can sleep. so that it can't be inside of spin_lock.
Hence proc_remove() is moved to outside of spin_lock. and it also
adds mutex to sync create and remove of proc entry(config->pde).

test commands:
SHELL#1
   %while :; do iptables -A INPUT -p udp -i enp2s0 -d 192.168.1.100 \
	   --dport 9000  -j CLUSTERIP --new --hashmode sourceip \
	   --clustermac 01:00:5e:00:00:21 --total-nodes 3 --local-node 3; \
	   iptables -F; done

SHELL#2
   %while :; do echo +1 > /proc/net/ipt_CLUSTERIP/192.168.1.100; \
	   echo -1 > /proc/net/ipt_CLUSTERIP/192.168.1.100; done

[ 2949.569864] BUG: sleeping function called from invalid context at kernel/sched/completion.c:99
[ 2949.579944] in_atomic(): 1, irqs_disabled(): 0, pid: 5472, name: iptables
[ 2949.587920] 1 lock held by iptables/5472:
[ 2949.592711]  #0: 000000008f0ebcf2 (&(&cn->lock)->rlock){+...}, at: refcount_dec_and_lock+0x24/0x50
[ 2949.603307] CPU: 1 PID: 5472 Comm: iptables Tainted: G        W         4.19.0-rc5+ #16
[ 2949.604212] Hardware name: To be filled by O.E.M. To be filled by O.E.M./Aptio CRB, BIOS 5.6.5 07/08/2015
[ 2949.604212] Call Trace:
[ 2949.604212]  dump_stack+0xc9/0x16b
[ 2949.604212]  ? show_regs_print_info+0x5/0x5
[ 2949.604212]  ___might_sleep+0x2eb/0x420
[ 2949.604212]  ? set_rq_offline.part.87+0x140/0x140
[ 2949.604212]  ? _rcu_barrier_trace+0x400/0x400
[ 2949.604212]  wait_for_completion+0x94/0x710
[ 2949.604212]  ? wait_for_completion_interruptible+0x780/0x780
[ 2949.604212]  ? __kernel_text_address+0xe/0x30
[ 2949.604212]  ? __lockdep_init_map+0x10e/0x5c0
[ 2949.604212]  ? __lockdep_init_map+0x10e/0x5c0
[ 2949.604212]  ? __init_waitqueue_head+0x86/0x130
[ 2949.604212]  ? init_wait_entry+0x1a0/0x1a0
[ 2949.604212]  proc_entry_rundown+0x208/0x270
[ 2949.604212]  ? proc_reg_get_unmapped_area+0x370/0x370
[ 2949.604212]  ? __lock_acquire+0x4500/0x4500
[ 2949.604212]  ? complete+0x18/0x70
[ 2949.604212]  remove_proc_subtree+0x143/0x2a0
[ 2949.708655]  ? remove_proc_entry+0x390/0x390
[ 2949.708655]  clusterip_tg_destroy+0x27a/0x630 [ipt_CLUSTERIP]
[ ... ]

Fixes: b3e456fce9f5 ("netfilter: ipt_CLUSTERIP: fix a race condition of proc file creation")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv4/netfilter/ipt_CLUSTERIP.c |   19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

--- a/net/ipv4/netfilter/ipt_CLUSTERIP.c
+++ b/net/ipv4/netfilter/ipt_CLUSTERIP.c
@@ -56,7 +56,7 @@ struct clusterip_config {
 #endif
 	enum clusterip_hashmode hash_mode;	/* which hashing mode */
 	u_int32_t hash_initval;			/* hash initialization */
-	struct rcu_head rcu;
+	struct rcu_head rcu;			/* for call_rcu_bh */
 	struct net *net;			/* netns for pernet list */
 	char ifname[IFNAMSIZ];			/* device ifname */
 };
@@ -72,6 +72,8 @@ struct clusterip_net {
 
 #ifdef CONFIG_PROC_FS
 	struct proc_dir_entry *procdir;
+	/* mutex protects the config->pde*/
+	struct mutex mutex;
 #endif
 };
 
@@ -118,17 +120,18 @@ clusterip_config_entry_put(struct cluste
 
 	local_bh_disable();
 	if (refcount_dec_and_lock(&c->entries, &cn->lock)) {
+		list_del_rcu(&c->list);
+		spin_unlock(&cn->lock);
+		local_bh_enable();
 		/* In case anyone still accesses the file, the open/close
 		 * functions are also incrementing the refcount on their own,
 		 * so it's safe to remove the entry even if it's in use. */
 #ifdef CONFIG_PROC_FS
+		mutex_lock(&cn->mutex);
 		if (cn->procdir)
 			proc_remove(c->pde);
+		mutex_unlock(&cn->mutex);
 #endif
-		list_del_rcu(&c->list);
-		spin_unlock(&cn->lock);
-		local_bh_enable();
-
 		return;
 	}
 	local_bh_enable();
@@ -278,9 +281,11 @@ clusterip_config_init(struct net *net, c
 
 		/* create proc dir entry */
 		sprintf(buffer, "%pI4", &ip);
+		mutex_lock(&cn->mutex);
 		c->pde = proc_create_data(buffer, 0600,
 					  cn->procdir,
 					  &clusterip_proc_fops, c);
+		mutex_unlock(&cn->mutex);
 		if (!c->pde) {
 			err = -ENOMEM;
 			goto err;
@@ -833,6 +838,7 @@ static int clusterip_net_init(struct net
 		pr_err("Unable to proc dir entry\n");
 		return -ENOMEM;
 	}
+	mutex_init(&cn->mutex);
 #endif /* CONFIG_PROC_FS */
 
 	return 0;
@@ -841,9 +847,12 @@ static int clusterip_net_init(struct net
 static void clusterip_net_exit(struct net *net)
 {
 	struct clusterip_net *cn = clusterip_pernet(net);
+
 #ifdef CONFIG_PROC_FS
+	mutex_lock(&cn->mutex);
 	proc_remove(cn->procdir);
 	cn->procdir = NULL;
+	mutex_unlock(&cn->mutex);
 #endif
 	nf_unregister_net_hook(net, &cip_arp_ops);
 }


