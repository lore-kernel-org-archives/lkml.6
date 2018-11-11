Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34C5C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C1C2148E
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:44:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94C1C2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbeKLFeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:34:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56736 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726971AbeKLFdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:33:51 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wABJi9WD116372
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:44:25 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2npdv7rvvb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:44:25 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 11 Nov 2018 19:44:22 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 11 Nov 2018 19:44:14 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wABJiDl822020260
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 11 Nov 2018 19:44:13 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61D5FB206B;
        Sun, 11 Nov 2018 19:44:13 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 342FEB2070;
        Sun, 11 Nov 2018 19:44:13 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.24])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 11 Nov 2018 19:44:13 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 25FFC16C5DB1; Sun, 11 Nov 2018 11:44:13 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH tip/core/rcu 30/41] netfilter: Replace call_rcu_bh(), rcu_barrier_bh(), and synchronize_rcu_bh()
Date:   Sun, 11 Nov 2018 11:43:59 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181111194104.GA4787@linux.ibm.com>
References: <20181111194104.GA4787@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18111119-0064-0000-0000-000003722EA2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010028; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116019; UDB=6.00577118; IPR=6.00896119;
 MB=3.00024114; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-11 19:44:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111119-0065-0000-0000-00003B4D4139
Message-Id: <20181111194410.6368-30-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-11_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=62 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811110188
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that call_rcu()'s callback is not invoked until after bh-disable
regions of code have completed (in addition to explicitly marked
RCU read-side critical sections), call_rcu() can be used in place
of call_rcu_bh().  Similarly, rcu_barrier() can be used in place of
rcu_barrier_bh() and synchronize_rcu() in place of synchronize_rcu_bh().
This commit therefore makes these changes.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
Cc: Florian Westphal <fw@strlen.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc: <netfilter-devel@vger.kernel.org>
Cc: <coreteam@netfilter.org>
Cc: <netdev@vger.kernel.org>
---
 net/ipv4/netfilter/ipt_CLUSTERIP.c    | 6 +++---
 net/netfilter/ipset/ip_set_hash_gen.h | 4 ++--
 net/netfilter/nfnetlink_log.c         | 2 +-
 net/netfilter/xt_hashlimit.c          | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/netfilter/ipt_CLUSTERIP.c b/net/ipv4/netfilter/ipt_CLUSTERIP.c
index 2c8d313ae216..5b0c1ee6ae26 100644
--- a/net/ipv4/netfilter/ipt_CLUSTERIP.c
+++ b/net/ipv4/netfilter/ipt_CLUSTERIP.c
@@ -94,7 +94,7 @@ static inline void
 clusterip_config_put(struct clusterip_config *c)
 {
 	if (refcount_dec_and_test(&c->refcount))
-		call_rcu_bh(&c->rcu, clusterip_config_rcu_free);
+		call_rcu(&c->rcu, clusterip_config_rcu_free);
 }
 
 /* decrease the count of entries using/referencing this config.  If last
@@ -876,8 +876,8 @@ static void __exit clusterip_tg_exit(void)
 	xt_unregister_target(&clusterip_tg_reg);
 	unregister_pernet_subsys(&clusterip_net_ops);
 
-	/* Wait for completion of call_rcu_bh()'s (clusterip_config_rcu_free) */
-	rcu_barrier_bh();
+	/* Wait for completion of call_rcu()'s (clusterip_config_rcu_free) */
+	rcu_barrier();
 }
 
 module_init(clusterip_tg_init);
diff --git a/net/netfilter/ipset/ip_set_hash_gen.h b/net/netfilter/ipset/ip_set_hash_gen.h
index e287da68d5fa..2c9609929c71 100644
--- a/net/netfilter/ipset/ip_set_hash_gen.h
+++ b/net/netfilter/ipset/ip_set_hash_gen.h
@@ -67,7 +67,7 @@ tune_ahash_max(u8 curr, u32 multi)
 
 /* A hash bucket */
 struct hbucket {
-	struct rcu_head rcu;	/* for call_rcu_bh */
+	struct rcu_head rcu;	/* for call_rcu */
 	/* Which positions are used in the array */
 	DECLARE_BITMAP(used, AHASH_MAX_TUNED);
 	u8 size;		/* size of the array */
@@ -664,7 +664,7 @@ mtype_resize(struct ip_set *set, bool retried)
 	spin_unlock_bh(&set->lock);
 
 	/* Give time to other readers of the set */
-	synchronize_rcu_bh();
+	synchronize_rcu();
 
 	pr_debug("set %s resized from %u (%p) to %u (%p)\n", set->name,
 		 orig->htable_bits, orig, t->htable_bits, t);
diff --git a/net/netfilter/nfnetlink_log.c b/net/netfilter/nfnetlink_log.c
index 332c69d27b47..b1f9c5303f02 100644
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -148,7 +148,7 @@ static void
 instance_put(struct nfulnl_instance *inst)
 {
 	if (inst && refcount_dec_and_test(&inst->use))
-		call_rcu_bh(&inst->rcu, nfulnl_instance_free_rcu);
+		call_rcu(&inst->rcu, nfulnl_instance_free_rcu);
 }
 
 static void nfulnl_timer(struct timer_list *t);
diff --git a/net/netfilter/xt_hashlimit.c b/net/netfilter/xt_hashlimit.c
index 3e7d259e5d8d..8138b68a9a44 100644
--- a/net/netfilter/xt_hashlimit.c
+++ b/net/netfilter/xt_hashlimit.c
@@ -260,7 +260,7 @@ static inline void
 dsthash_free(struct xt_hashlimit_htable *ht, struct dsthash_ent *ent)
 {
 	hlist_del_rcu(&ent->node);
-	call_rcu_bh(&ent->rcu, dsthash_free_rcu);
+	call_rcu(&ent->rcu, dsthash_free_rcu);
 	ht->count--;
 }
 static void htable_gc(struct work_struct *work);
@@ -1329,7 +1329,7 @@ static void __exit hashlimit_mt_exit(void)
 	xt_unregister_matches(hashlimit_mt_reg, ARRAY_SIZE(hashlimit_mt_reg));
 	unregister_pernet_subsys(&hashlimit_net_ops);
 
-	rcu_barrier_bh();
+	rcu_barrier();
 	kmem_cache_destroy(hashlimit_cachep);
 }
 
-- 
2.17.1

