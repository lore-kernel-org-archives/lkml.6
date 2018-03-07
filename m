Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4119318-1520452971-2-3423559566800737930
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520452970; b=n47hBu/rotUPyLjB8axPtN4CM/jX5Cn+LEAfkt7brUZYUzg
    qo1ZpFmgCKfayWu0j08GH+X7ZvP7HmZARUX9EShOu3JtnXbFPmFPQ+rHQ8rV+B5M
    7oU3LvA20zxP6kmMOh5Mws0+mQVzRU5qRmWwJpMbrhuBfvr+2xFn7M3QRhp+zhDh
    S2319uH8/YQlaDG6eB+C3WPeSxrpA/i8F5+Xsaxh7djHd4W3Qz8WxNGJpCyT+bR0
    GLNFcI3PI2PcnAQG5u4A2uAz+BLSiCF4Bgz1TT08rhp+ibEmKQvTnm2/t+pUfLmf
    j2ZQLwrcWWelR5qNzJS5rz+e0e2UTFOwKfW9Veg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520452970; bh=RtqE7+QsRrIAe6iUfyvjhIs2BE
    DZg0VfBFDsIlVMJQk=; b=YDReReGO+79Ou+jlpnRRIPWwyYNuXf1661e7m6iAd3
    7gfzWV2KdUn8aRl6VwRMDFfMzTgSqCvVT/TZPio5ToJ9AfmGMrt99w2n6yWYo/i2
    6nyyJx76mVZI4jVnNKW6G+VDLLd9FR9nVu06Q2wLy0Y9zd9nSvpgY19CwcTZVnTT
    +nX9HSCNjMAEFeF33hYeg1+Hpb6+NixvCuJDNSkgLc3EsceVtq0jFMuHlQTwWDYR
    EJ3gBSKnMhkcWSUeLhB8Ek5663YPsx0sxg79rk7NiFpyNwjUtMxFEyzyEmKBsHR7
    ecd4z3P+tFJf1FQ0mhPXStJHdRZrEWaM3B+3KZpLtzHg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965591AbeCGTqn (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 14:46:43 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44706 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965587AbeCGTqm (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:46:42 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li Shuang <shuali@redhat.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 068/110] cls_u32: fix use after free in u32_destroy_key()
Date: Wed,  7 Mar 2018 11:38:51 -0800
Message-Id: <20180307191048.275826398@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>


[ Upstream commit d7cdee5ea8d28ae1b6922deb0c1badaa3aa0ef8c ]

Li Shuang reported an Oops with cls_u32 due to an use-after-free
in u32_destroy_key(). The use-after-free can be triggered with:

dev=lo
tc qdisc add dev $dev root handle 1: htb default 10
tc filter add dev $dev parent 1: prio 5 handle 1: protocol ip u32 divisor 256
tc filter add dev $dev protocol ip parent 1: prio 5 u32 ht 800:: match ip dst\
 10.0.0.0/8 hashkey mask 0x0000ff00 at 16 link 1:
tc qdisc del dev $dev root

Which causes the following kasan splat:

 ==================================================================
 BUG: KASAN: use-after-free in u32_destroy_key.constprop.21+0x117/0x140 [cls_u32]
 Read of size 4 at addr ffff881b83dae618 by task kworker/u48:5/571

 CPU: 17 PID: 571 Comm: kworker/u48:5 Not tainted 4.15.0+ #87
 Hardware name: Dell Inc. PowerEdge R730/072T6D, BIOS 2.1.7 06/16/2016
 Workqueue: tc_filter_workqueue u32_delete_key_freepf_work [cls_u32]
 Call Trace:
  dump_stack+0xd6/0x182
  ? dma_virt_map_sg+0x22e/0x22e
  print_address_description+0x73/0x290
  kasan_report+0x277/0x360
  ? u32_destroy_key.constprop.21+0x117/0x140 [cls_u32]
  u32_destroy_key.constprop.21+0x117/0x140 [cls_u32]
  u32_delete_key_freepf_work+0x1c/0x30 [cls_u32]
  process_one_work+0xae0/0x1c80
  ? sched_clock+0x5/0x10
  ? pwq_dec_nr_in_flight+0x3c0/0x3c0
  ? _raw_spin_unlock_irq+0x29/0x40
  ? trace_hardirqs_on_caller+0x381/0x570
  ? _raw_spin_unlock_irq+0x29/0x40
  ? finish_task_switch+0x1e5/0x760
  ? finish_task_switch+0x208/0x760
  ? preempt_notifier_dec+0x20/0x20
  ? __schedule+0x839/0x1ee0
  ? check_noncircular+0x20/0x20
  ? firmware_map_remove+0x73/0x73
  ? find_held_lock+0x39/0x1c0
  ? worker_thread+0x434/0x1820
  ? lock_contended+0xee0/0xee0
  ? lock_release+0x1100/0x1100
  ? init_rescuer.part.16+0x150/0x150
  ? retint_kernel+0x10/0x10
  worker_thread+0x216/0x1820
  ? process_one_work+0x1c80/0x1c80
  ? lock_acquire+0x1a5/0x540
  ? lock_downgrade+0x6b0/0x6b0
  ? sched_clock+0x5/0x10
  ? lock_release+0x1100/0x1100
  ? compat_start_thread+0x80/0x80
  ? do_raw_spin_trylock+0x190/0x190
  ? _raw_spin_unlock_irq+0x29/0x40
  ? trace_hardirqs_on_caller+0x381/0x570
  ? _raw_spin_unlock_irq+0x29/0x40
  ? finish_task_switch+0x1e5/0x760
  ? finish_task_switch+0x208/0x760
  ? preempt_notifier_dec+0x20/0x20
  ? __schedule+0x839/0x1ee0
  ? kmem_cache_alloc_trace+0x143/0x320
  ? firmware_map_remove+0x73/0x73
  ? sched_clock+0x5/0x10
  ? sched_clock_cpu+0x18/0x170
  ? find_held_lock+0x39/0x1c0
  ? schedule+0xf3/0x3b0
  ? lock_downgrade+0x6b0/0x6b0
  ? __schedule+0x1ee0/0x1ee0
  ? do_wait_intr_irq+0x340/0x340
  ? do_raw_spin_trylock+0x190/0x190
  ? _raw_spin_unlock_irqrestore+0x32/0x60
  ? process_one_work+0x1c80/0x1c80
  ? process_one_work+0x1c80/0x1c80
  kthread+0x312/0x3d0
  ? kthread_create_worker_on_cpu+0xc0/0xc0
  ret_from_fork+0x3a/0x50

 Allocated by task 1688:
  kasan_kmalloc+0xa0/0xd0
  __kmalloc+0x162/0x380
  u32_change+0x1220/0x3c9e [cls_u32]
  tc_ctl_tfilter+0x1ba6/0x2f80
  rtnetlink_rcv_msg+0x4f0/0x9d0
  netlink_rcv_skb+0x124/0x320
  netlink_unicast+0x430/0x600
  netlink_sendmsg+0x8fa/0xd60
  sock_sendmsg+0xb1/0xe0
  ___sys_sendmsg+0x678/0x980
  __sys_sendmsg+0xc4/0x210
  do_syscall_64+0x232/0x7f0
  return_from_SYSCALL_64+0x0/0x75

 Freed by task 112:
  kasan_slab_free+0x71/0xc0
  kfree+0x114/0x320
  rcu_process_callbacks+0xc3f/0x1600
  __do_softirq+0x2bf/0xc06

 The buggy address belongs to the object at ffff881b83dae600
  which belongs to the cache kmalloc-4096 of size 4096
 The buggy address is located 24 bytes inside of
  4096-byte region [ffff881b83dae600, ffff881b83daf600)
 The buggy address belongs to the page:
 page:ffffea006e0f6a00 count:1 mapcount:0 mapping:          (null) index:0x0 compound_mapcount: 0
 flags: 0x17ffffc0008100(slab|head)
 raw: 0017ffffc0008100 0000000000000000 0000000000000000 0000000100070007
 raw: dead000000000100 dead000000000200 ffff880187c0e600 0000000000000000
 page dumped because: kasan: bad access detected

 Memory state around the buggy address:
  ffff881b83dae500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff881b83dae580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 >ffff881b83dae600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                             ^
  ffff881b83dae680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff881b83dae700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ==================================================================

The problem is that the htnode is freed before the linked knodes and the
latter will try to access the first at u32_destroy_key() time.
This change addresses the issue using the htnode refcnt to guarantee
the correct free order. While at it also add a RCU annotation,
to keep sparse happy.

v1 -> v2: use rtnl_derefence() instead of RCU read locks
v2 -> v3:
  - don't check refcnt in u32_destroy_hnode()
  - cleaned-up u32_destroy() implementation
  - cleaned-up code comment
v3 -> v4:
  - dropped unneeded comment

Reported-by: Li Shuang <shuali@redhat.com>
Fixes: c0d378ef1266 ("net_sched: use tcf_queue_work() in u32 filter")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Acked-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/cls_u32.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -398,10 +398,12 @@ static int u32_init(struct tcf_proto *tp
 static int u32_destroy_key(struct tcf_proto *tp, struct tc_u_knode *n,
 			   bool free_pf)
 {
+	struct tc_u_hnode *ht = rtnl_dereference(n->ht_down);
+
 	tcf_exts_destroy(&n->exts);
 	tcf_exts_put_net(&n->exts);
-	if (n->ht_down)
-		n->ht_down->refcnt--;
+	if (ht && --ht->refcnt == 0)
+		kfree(ht);
 #ifdef CONFIG_CLS_U32_PERF
 	if (free_pf)
 		free_percpu(n->pf);
@@ -649,16 +651,15 @@ static void u32_destroy(struct tcf_proto
 
 		hlist_del(&tp_c->hnode);
 
-		for (ht = rtnl_dereference(tp_c->hlist);
-		     ht;
-		     ht = rtnl_dereference(ht->next)) {
-			ht->refcnt--;
-			u32_clear_hnode(tp, ht);
-		}
-
 		while ((ht = rtnl_dereference(tp_c->hlist)) != NULL) {
+			u32_clear_hnode(tp, ht);
 			RCU_INIT_POINTER(tp_c->hlist, ht->next);
-			kfree_rcu(ht, rcu);
+
+			/* u32_destroy_key() will later free ht for us, if it's
+			 * still referenced by some knode
+			 */
+			if (--ht->refcnt == 0)
+				kfree_rcu(ht, rcu);
 		}
 
 		kfree(tp_c);
