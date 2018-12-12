Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C93DC67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 153412086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:52:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 153412086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=solarflare.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbeLLRwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:52:51 -0500
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:47686 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726922AbeLLRwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 12:52:50 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from webmail.solarflare.com (webmail.solarflare.com [12.187.104.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1-us1.ppe-hosted.com (Proofpoint Essentials ESMTP Server) with ESMTPS id 4CF62400066;
        Wed, 12 Dec 2018 17:52:49 +0000 (UTC)
Received: from ec-desktop.uk.solarflarecom.com (10.17.20.45) by
 ocex03.SolarFlarecom.com (10.20.40.36) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 12 Dec 2018 09:52:45 -0800
From:   Edward Cree <ecree@solarflare.com>
Subject: [RFC PATCH 2/2] net: core: rather hacky PoC implementation of dynamic
 calls
To:     Nadav Amit <namit@vmware.com>, Josh Poimboeuf <jpoimboe@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
References: <cf6e9449-f3f6-e0fc-8096-eaba6b5a3b97@solarflare.com>
Message-ID: <7ab6063d-92ac-4708-d820-0cf175cf0f92@solarflare.com>
Date:   Wed, 12 Dec 2018 17:52:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <cf6e9449-f3f6-e0fc-8096-eaba6b5a3b97@solarflare.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.17.20.45]
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.5.1010-24280.005
X-TM-AS-Result: No-9.604200-4.000000-10
X-TMASE-MatchedRID: EYA0sup6gNhl+hxxqfcpPsbr3d9/yP1kpPZLm8rbDqJjyv+d0Z0OxRWV
        SFc2ItaOvUbvPAStF2iUTQ2JYQzY21SU1d+VJ4IjnJ5tL+LbGOM4gG1vqBBN+AqiCYa6w8tvoja
        BwpG8gTPfqxfcyiWiyr4tP830vR4Aj1OThq6Zp6BbuDP8ZuCmXkrh/hn4JkBngrAXgr/AjP3NCc
        A6Zdzj71xmTQS70AzY8EVWJSRef2vz02Qfl8DhQMOvQCMFyZ9GyeUl7aCTy8hcKZwALwMGs2pHK
        tkQBynK2toxWPLv+HqE4pusuM4o3hv9h+4KF57mHPYwOJi6PLkhHWssEmb8zhxUkJPe1WBq92tT
        P3Yq8VAHL782mJ86aHLHqPoioImUm0Eb6QA1oW/Y8CtSlWSg/ClayzmQ9QV0gGbipuPzIdHloTS
        mLjO3jRwJa9cCgcwvQlNPb0UTAzIvRbVu13x7nuIfK/Jd5eHmZAQzy8TR+QbqLnOUXH9QdN+HYj
        GHlFYn9l4B8vq7n5v5F1yiVNAj2wjVnlevJ/ToR/j040fRFpKt4laWdJbsDMKQkd8YrGEviMF2e
        oWMKPXi8zVgXoAltkWL4rBlm20v8gATfdkjbTytIWznhjjBtfoLR4+zsDTtqFhHt/jREalnN9Ah
        bYYLy2RWjU8cQ3jQ0ZjgsXBtW+diuoXhHTpajlZca9RSYo/b
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.604200-4.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.5.1010-24280.005
X-MDID: 1544637170-g-HheZNtHp4z
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uses runtime instrumentation of callees from an indirect call site
 (deliver_skb, and also __netif_receive_skb_one_core()) to populate an
 indirect-call-wrapper branch tree.  Essentially we're doing indirect
 branch prediction in software because the hardware can't be trusted to
 get it right; this is sad.

It's also full of printk()s right now to display what it's doing for
 debugging purposes; obviously those wouldn't be quite the same in a
 finished version.

Signed-off-by: Edward Cree <ecree@solarflare.com>
---
 net/core/dev.c | 222 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 217 insertions(+), 5 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 04a6b7100aac..f69c110c34e3 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -145,6 +145,7 @@
 #include <linux/sctp.h>
 #include <net/udp_tunnel.h>
 #include <linux/net_namespace.h>
+#include <linux/static_call.h>
 
 #include "net-sysfs.h"
 
@@ -1935,14 +1936,223 @@ int dev_forward_skb(struct net_device *dev, struct sk_buff *skb)
 }
 EXPORT_SYMBOL_GPL(dev_forward_skb);
 
-static inline int deliver_skb(struct sk_buff *skb,
-			      struct packet_type *pt_prev,
-			      struct net_device *orig_dev)
+static void deliver_skb_update(struct work_struct *unused);
+
+static DECLARE_WORK(deliver_skb_update_work, deliver_skb_update);
+
+typedef int (*deliver_skb_func)(struct sk_buff *, struct net_device *, struct packet_type *, struct net_device *);
+
+struct deliver_skb_candidate {
+	deliver_skb_func func;
+	unsigned long hit_count;
+};
+
+static DEFINE_PER_CPU(struct deliver_skb_candidate[4], deliver_skb_candidates);
+
+static DEFINE_PER_CPU(unsigned long, deliver_skb_miss_count);
+
+/* Used to route around the dynamic version when we're changing it, as well as
+ * as a fallback if none of our static calls match.
+ */
+static int do_deliver_skb(struct sk_buff *skb,
+			  struct packet_type *pt_prev,
+			  struct net_device *orig_dev)
+{
+	struct deliver_skb_candidate *cands = *this_cpu_ptr(&deliver_skb_candidates);
+	deliver_skb_func func = pt_prev->func;
+	unsigned long total_count;
+	int i;
+
+	for (i = 0; i < 4; i++)
+		if (func == cands[i].func) {
+			cands[i].hit_count++;
+			break;
+		}
+	if (i == 4) /* no match */
+		for (i = 0; i < 4; i++)
+			if (!cands[i].func) {
+				cands[i].func = func;
+				cands[i].hit_count = 1;
+				break;
+			}
+	if (i == 4) /* no space */
+		(*this_cpu_ptr(&deliver_skb_miss_count))++;
+
+	total_count = *this_cpu_ptr(&deliver_skb_miss_count);
+	for (i = 0; i < 4; i++)
+		total_count += cands[i].hit_count;
+	if (total_count > 1000) /* Arbitrary threshold */
+		schedule_work(&deliver_skb_update_work);
+	return pt_prev->func(skb, skb->dev, pt_prev, orig_dev);
+}
+
+DEFINE_STATIC_CALL(dispatch_deliver_skb, do_deliver_skb);
+
+static int dummy_deliver_skb(struct sk_buff *skb, struct net_device *dev,
+			     struct packet_type *pt_prev,
+			     struct net_device *orig_dev)
+{
+	WARN_ON_ONCE(1); /* shouldn't ever actually get here */
+	return do_deliver_skb(skb, pt_prev, orig_dev);
+}
+
+DEFINE_STATIC_CALL(dynamic_deliver_skb_1, dummy_deliver_skb);
+DEFINE_STATIC_CALL(dynamic_deliver_skb_2, dummy_deliver_skb);
+
+static DEFINE_PER_CPU(unsigned long, dds1_hit_count);
+static DEFINE_PER_CPU(unsigned long, dds2_hit_count);
+
+static int dynamic_deliver_skb(struct sk_buff *skb,
+			       struct packet_type *pt_prev,
+			       struct net_device *orig_dev)
+{
+	deliver_skb_func func = pt_prev->func;
+
+	if (func == dynamic_deliver_skb_1.func) {
+		(*this_cpu_ptr(&dds1_hit_count))++;
+		return static_call(dynamic_deliver_skb_1, skb, skb->dev,
+				   pt_prev, orig_dev);
+	}
+	if (func == dynamic_deliver_skb_2.func) {
+		(*this_cpu_ptr(&dds2_hit_count))++;
+		return static_call(dynamic_deliver_skb_2, skb, skb->dev,
+				   pt_prev, orig_dev);
+	}
+	return do_deliver_skb(skb, pt_prev, orig_dev);
+}
+
+DEFINE_MUTEX(deliver_skb_update_lock);
+
+static void deliver_skb_add_cand(struct deliver_skb_candidate *top,
+				 size_t ncands,
+				 struct deliver_skb_candidate next)
+{
+	struct deliver_skb_candidate old;
+	int i;
+
+	for (i = 0; i < ncands; i++) {
+		if (next.hit_count > top[i].hit_count) {
+			/* Swap next with top[i], so that the old top[i] can
+			 * shunt along all lower scores
+			 */
+			old = top[i];
+			top[i] = next;
+			next = old;
+		}
+	}
+}
+
+static void deliver_skb_count_hits(struct deliver_skb_candidate *top,
+				   size_t ncands, struct static_call_key *key,
+				   unsigned long __percpu *hit_count)
+{
+	struct deliver_skb_candidate next;
+	int cpu;
+
+	next.func = key->func;
+	next.hit_count = 0;
+	for_each_online_cpu(cpu) {
+		next.hit_count += *per_cpu_ptr(hit_count, cpu);
+		*per_cpu_ptr(hit_count, cpu) = 0;
+	}
+
+	printk(KERN_ERR "hit_count for old %pf: %lu\n", next.func,
+	       next.hit_count);
+
+	deliver_skb_add_cand(top, ncands, next);
+}
+
+static void deliver_skb_update(struct work_struct *unused)
+{
+	struct deliver_skb_candidate top[4], next, *cands, *cands2;
+	int cpu, i, cpu2, j;
+
+	memset(top, 0, sizeof(top));
+
+	printk(KERN_ERR "deliver_skb_update called\n");
+	mutex_lock(&deliver_skb_update_lock);
+	printk(KERN_ERR "deliver_skb_update_lock acquired\n");
+	/* We don't stop the other CPUs adding to their counts while this is
+	 * going on; but it doesn't really matter because this is a heuristic
+	 * anyway so we don't care about perfect accuracy.
+	 */
+	/* First count up the hits on the existing static branches */
+	deliver_skb_count_hits(top, ARRAY_SIZE(top), &dynamic_deliver_skb_1,
+			       &dds1_hit_count);
+	deliver_skb_count_hits(top, ARRAY_SIZE(top), &dynamic_deliver_skb_2,
+			       &dds2_hit_count);
+	/* Next count up the callees seen in the fallback path */
+	for_each_online_cpu(cpu) {
+		cands = *per_cpu_ptr(&deliver_skb_candidates, cpu);
+		printk(KERN_ERR "miss_count for %d: %lu\n", cpu,
+		       *per_cpu_ptr(&deliver_skb_miss_count, cpu));
+		for (i = 0; i < 4; i++) {
+			next = cands[i];
+			if (next.func == NULL)
+				continue;
+			next.hit_count = 0;
+			for_each_online_cpu(cpu2) {
+				cands2 = *per_cpu_ptr(&deliver_skb_candidates,
+						      cpu2);
+				for (j = 0; j < 4; j++) {
+					if (cands2[j].func == next.func) {
+						next.hit_count += cands2[j].hit_count;
+						cands2[j].hit_count = 0;
+						cands2[j].func = NULL;
+						break;
+					}
+				}
+			}
+			printk(KERN_ERR "candidate %d/%d: %pf %lu\n", cpu, i,
+			       next.func, next.hit_count);
+			deliver_skb_add_cand(top, ARRAY_SIZE(top), next);
+		}
+	}
+	/* Record our results (for debugging) */
+	for (i = 0; i < ARRAY_SIZE(top); i++) {
+		if (i < 2) /* 2 == number of static calls in the branch tree */
+			printk(KERN_ERR "selected [%d] %pf, score %lu\n", i,
+			       top[i].func, top[i].hit_count);
+		else
+			printk(KERN_ERR "runnerup [%d] %pf, score %lu\n", i,
+			       top[i].func, top[i].hit_count);
+	}
+	/* It's possible that we could have picked up multiple pushes of the
+	 * workitem, so someone already collected most of the count.  In that
+	 * case, don't make a decision based on only a small number of calls.
+	 */
+	if (top[0].hit_count > 250) {
+		/* Divert callers away from the fast path */
+		static_call_update(dispatch_deliver_skb, do_deliver_skb);
+		printk(KERN_ERR "patched dds to %pf\n", dispatch_deliver_skb.func);
+		/* Wait for existing fast path callers to finish */
+		synchronize_rcu();
+		/* Patch the chosen callees into the fast path */
+		static_call_update(dynamic_deliver_skb_1, *top[0].func);
+		printk(KERN_ERR "patched dds1 to %pf\n", dynamic_deliver_skb_1.func);
+		static_call_update(dynamic_deliver_skb_2, *top[1].func);
+		printk(KERN_ERR "patched dds2 to %pf\n", dynamic_deliver_skb_2.func);
+		/* Ensure the new fast path is seen before we direct anyone
+		 * into it.  This probably isn't necessary (the binary-patching
+		 * framework probably takes care of it) but let's be paranoid.
+		 */
+		wmb();
+		/* Switch callers back onto the fast path */
+		static_call_update(dispatch_deliver_skb, dynamic_deliver_skb);
+		printk(KERN_ERR "patched dds to %pf\n", dispatch_deliver_skb.func);
+	}
+	mutex_unlock(&deliver_skb_update_lock);
+	printk(KERN_ERR "deliver_skb_update finished\n");
+}
+
+static noinline int deliver_skb(struct sk_buff *skb,
+				struct packet_type *pt_prev,
+				struct net_device *orig_dev)
 {
 	if (unlikely(skb_orphan_frags_rx(skb, GFP_ATOMIC)))
 		return -ENOMEM;
 	refcount_inc(&skb->users);
-	return pt_prev->func(skb, skb->dev, pt_prev, orig_dev);
+	return static_call(dispatch_deliver_skb, skb, pt_prev, orig_dev);
 }
 
 static inline void deliver_ptype_list_skb(struct sk_buff *skb,
@@ -4951,7 +5161,9 @@ static int __netif_receive_skb_one_core(struct sk_buff *skb, bool pfmemalloc)
 
 	ret = __netif_receive_skb_core(skb, pfmemalloc, &pt_prev);
 	if (pt_prev)
-		ret = pt_prev->func(skb, skb->dev, pt_prev, orig_dev);
+		/* ret = pt_prev->func(skb, skb->dev, pt_prev, orig_dev); */
+		/* but (hopefully) faster */
+		ret = static_call(dispatch_deliver_skb, skb, pt_prev, orig_dev);
 	return ret;
 }
 
