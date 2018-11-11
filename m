Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3CAC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6801214DB
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6801214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbeKLFhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:37:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56440 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726997AbeKLFdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:33:46 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wABJiKX6116550
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:44:20 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2npdv7rvsu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:44:19 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 11 Nov 2018 19:44:18 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 11 Nov 2018 19:44:13 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wABJiCMK40632328
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 11 Nov 2018 19:44:12 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8BBF8B2064;
        Sun, 11 Nov 2018 19:44:12 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 544D0B2068;
        Sun, 11 Nov 2018 19:44:12 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.24])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 11 Nov 2018 19:44:12 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 198B216C5D5F; Sun, 11 Nov 2018 11:44:13 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org
Subject: [PATCH tip/core/rcu 28/41] slab: Replace synchronize_sched() with synchronize_rcu()
Date:   Sun, 11 Nov 2018 11:43:57 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181111194104.GA4787@linux.ibm.com>
References: <20181111194104.GA4787@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18111119-0068-0000-0000-0000035E482E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010028; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116019; UDB=6.00578732; IPR=6.00896120;
 MB=3.00024114; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-11 19:44:18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111119-0069-0000-0000-000046644C6B
Message-Id: <20181111194410.6368-28-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-11_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811110188
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that synchronize_rcu() waits for preempt-disable regions of code
as well as RCU read-side critical sections, synchronize_sched() can be
replaced by synchronize_rcu().  This commit therefore makes this change.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: <linux-mm@kvack.org>
---
 mm/slab.c        | 4 ++--
 mm/slab_common.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 2a5654bb3b3f..3abb9feb3818 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -962,10 +962,10 @@ static int setup_kmem_cache_node(struct kmem_cache *cachep,
 	 * To protect lockless access to n->shared during irq disabled context.
 	 * If n->shared isn't NULL in irq disabled context, accessing to it is
 	 * guaranteed to be valid until irq is re-enabled, because it will be
-	 * freed after synchronize_sched().
+	 * freed after synchronize_rcu().
 	 */
 	if (old_shared && force_change)
-		synchronize_sched();
+		synchronize_rcu();
 
 fail:
 	kfree(old_shared);
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 7eb8dc136c1c..9c11e8a937d2 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -724,7 +724,7 @@ void slab_deactivate_memcg_cache_rcu_sched(struct kmem_cache *s,
 	css_get(&s->memcg_params.memcg->css);
 
 	s->memcg_params.deact_fn = deact_fn;
-	call_rcu_sched(&s->memcg_params.deact_rcu_head, kmemcg_deactivate_rcufn);
+	call_rcu(&s->memcg_params.deact_rcu_head, kmemcg_deactivate_rcufn);
 }
 
 void memcg_deactivate_kmem_caches(struct mem_cgroup *memcg)
@@ -839,11 +839,11 @@ static void flush_memcg_workqueue(struct kmem_cache *s)
 	mutex_unlock(&slab_mutex);
 
 	/*
-	 * SLUB deactivates the kmem_caches through call_rcu_sched. Make
+	 * SLUB deactivates the kmem_caches through call_rcu. Make
 	 * sure all registered rcu callbacks have been invoked.
 	 */
 	if (IS_ENABLED(CONFIG_SLUB))
-		rcu_barrier_sched();
+		rcu_barrier();
 
 	/*
 	 * SLAB and SLUB create memcg kmem_caches through workqueue and SLUB
-- 
2.17.1

