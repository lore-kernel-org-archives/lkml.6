Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D0AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D43E820665
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cIWXdp0g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfBVQ0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 11:26:48 -0500
Received: from merlin.infradead.org ([205.233.59.134]:49280 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfBVQ0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 11:26:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=x/8Mlh8OobdhUqFPm0Mhgq2zGxKpTgc9o2+gLV/a4ME=; b=cIWXdp0gLxZus6X9OYugsSnDN
        kCp6eAkh1aha57sMauX1R3SJbfllAw95Hz4fJm12iNRKsf5BsT5lW27QHPpRu3wH/PJcHpCcAaBdB
        wun0y/+pjbfBflnqXzxslFp87AlbQdvwMR/+uGxjseylj8FQ70rkJaR1z5pmzBbs72yrRNptgJg9u
        LCKeNJG+u53iMmiXkt1kuN3t7b3J7SmbJ5HWLL7iCc1hg7OYCuUnjnszeyJTWQ351oyD7rIceBXca
        BCQ5q5X+AXgH4feqmYM4Z9adbrl38XJqbMS+HHfpOadFYZtucTzlKtrEEQGR3Y7JOSPE5oqsrorB6
        NJYb+8+Pg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gxDeb-00049y-K2; Fri, 22 Feb 2019 16:26:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 923C82869B520; Fri, 22 Feb 2019 17:26:22 +0100 (CET)
Date:   Fri, 22 Feb 2019 17:26:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     mingo@redhat.com, will.deacon@arm.com, tj@kernel.org,
        longman@redhat.com, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 00/23] locking/lockdep: Add support for dynamic keys
Message-ID: <20190222162622.GB32494@hirez.programming.kicks-ass.net>
References: <20190214230058.196511-1-bvanassche@acm.org>
 <1550786525.31902.140.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550786525.31902.140.camel@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 02:02:05PM -0800, Bart Van Assche wrote:
> On Thu, 2019-02-14 at 15:00 -0800, Bart Van Assche wrote:
> > A known shortcoming of the current lockdep implementation is that it requires
> > lock keys to be allocated statically. This forces certain unrelated
> > synchronization objects to share keys and this key sharing can cause false
> > positive deadlock reports. This patch series adds support for dynamic keys in
> > the lockdep code and eliminates a class of false positive reports from the
> > workqueue implementation.
> > 
> > Please consider these patches for kernel v5.1.
> 
> Hi Peter and Ingo,
> 
> Do you have any feedback about this patch series that you would like to share?

I've gone over all and I think it looks ok now; I'll give it another
round tomorrow^Wmonday and then queue bits.

So far the only changes I've made are the below. I'm not entirely sure
on the unconditional validity check on DEBUG_LOCKDEP, maybe I'll add a
boot param for that.


---
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -75,8 +75,6 @@ module_param(lock_stat, int, 0644);
 #define lock_stat 0
 #endif
 
-static bool check_data_structure_consistency;
-
 /*
  * lockdep_lock: protects the lockdep graph, the hashes and the
  *               class/list/hash allocators.
@@ -792,6 +790,8 @@ static bool assign_lock_key(struct lockd
 	return true;
 }
 
+#ifdef CONFIG_DEBUG_LOCKDEP
+
 /* Check whether element @e occurs in list @h */
 static bool in_list(struct list_head *e, struct list_head *h)
 {
@@ -856,15 +856,15 @@ static bool check_lock_chain_key(struct
 	 * The 'unsigned long long' casts avoid that a compiler warning
 	 * is reported when building tools/lib/lockdep.
 	 */
-	if (chain->chain_key != chain_key)
+	if (chain->chain_key != chain_key) {
 		printk(KERN_INFO "chain %lld: key %#llx <> %#llx\n",
 		       (unsigned long long)(chain - lock_chains),
 		       (unsigned long long)chain->chain_key,
 		       (unsigned long long)chain_key);
-	return chain->chain_key == chain_key;
-#else
-	return true;
+		return false;
+	}
 #endif
+	return true;
 }
 
 static bool in_any_zapped_class_list(struct lock_class *class)
@@ -872,10 +872,10 @@ static bool in_any_zapped_class_list(str
 	struct pending_free *pf;
 	int i;
 
-	for (i = 0, pf = delayed_free.pf; i < ARRAY_SIZE(delayed_free.pf);
-	     i++, pf++)
+	for (i = 0, pf = delayed_free.pf; i < ARRAY_SIZE(delayed_free.pf); i++, pf++) {
 		if (in_list(&class->lock_entry, &pf->zapped))
 			return true;
+	}
 
 	return false;
 }
@@ -897,7 +897,6 @@ static bool check_data_structures(void)
 			printk(KERN_INFO "class %px/%s is not in any class list\n",
 			       class, class->name ? : "(?)");
 			return false;
-			return false;
 		}
 	}
 
@@ -954,6 +953,12 @@ static bool check_data_structures(void)
 	return true;
 }
 
+#else /* CONFIG_DEBUG_LOCKDEP */
+
+static inline bool check_data_structures(void) { return true; }
+
+#endif /* CONFIG_DEBUG_LOCKDEP */
+
 /*
  * Initialize the lock_classes[] array elements, the free_lock_classes list
  * and also the delayed_free structure.
@@ -4480,10 +4485,11 @@ static void remove_class_from_lock_chain
 		if (chain_hlocks[i] != class - lock_classes)
 			continue;
 		/* The code below leaks one chain_hlock[] entry. */
-		if (--chain->depth > 0)
+		if (--chain->depth > 0) {
 			memmove(&chain_hlocks[i], &chain_hlocks[i + 1],
 				(chain->base + chain->depth - i) *
 				sizeof(chain_hlocks[0]));
+		}
 		/*
 		 * Each lock class occurs at most once in a lock chain so once
 		 * we found a match we can break out of this loop.
@@ -4637,8 +4643,7 @@ static void __free_zapped_classes(struct
 {
 	struct lock_class *class;
 
-	if (check_data_structure_consistency)
-		WARN_ON_ONCE(!check_data_structures());
+	WARN_ON_ONCE(!check_data_structures());
 
 	list_for_each_entry(class, &pf->zapped, lock_entry)
 		reinit_class(class);
