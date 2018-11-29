Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8E2C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C945A205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KnusBHR9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C945A205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbeK2XgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 18:36:01 -0500
Received: from merlin.infradead.org ([205.233.59.134]:42114 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbeK2XgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 18:36:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QQY6Wx/YGRuJuebnzeAN6Np+N0fQVT0a0UfkxLjrvos=; b=KnusBHR9bvbLI+GdLK3NlMrvL
        Jd4m1l2Yg9y9BtoyglYuAahW6DJet/x2PBMyRckxml/s9f4u5MGvK6k7iNvFxvbzvloSkqTBN5cr7
        d18pdIGiP9Mc+V3RK1H9i5f8XDp+ywm/fh+s4lVy5FQPfwm+TK9/rbTpiZEoqX3WGOv5JgFmPyvrB
        0ArOYAMKjZzXBca5bB39FGWoBAwRBROoMAJh1n7wm6AxbGlysExZPecGKEwNOFadBgAC+QoYUVp2V
        aEGCExgAT5fvXsXqjJPN5ptg71g4x1rygYpLKBmhB9Dm1CajOyVdGXMVVP+mqQgKW/rQfZGk9H2Ex
        SPRA1dA7Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSLSs-0007y8-M5; Thu, 29 Nov 2018 12:30:42 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E7D4D2029FD58; Thu, 29 Nov 2018 13:30:39 +0100 (CET)
Date:   Thu, 29 Nov 2018 13:30:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     mingo@redhat.com, tj@kernel.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 23/27] locking/lockdep: Check data structure consistency
Message-ID: <20181129123039.GJ2131@hirez.programming.kicks-ass.net>
References: <20181128234325.110011-1-bvanassche@acm.org>
 <20181128234325.110011-24-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128234325.110011-24-bvanassche@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 03:43:21PM -0800, Bart Van Assche wrote:

> +static bool in_list(struct list_head *e, struct list_head *h)
> +{
> +	struct list_head *f;
> +
> +	list_for_each(f, h)
> +		if (e == f)
> +			return true;

Coding style wants { } around any multi line block, even if C doesn't
strictly require it.

> +
> +	return false;
> +}

> +static bool check_lock_chain_key(struct lock_chain *chain)
> +{
> +	u64 chain_key = 0;
> +	int i;
> +
> +	for (i = chain->base; i < chain->base + chain->depth; i++)
> +		chain_key = iterate_chain_key(chain_key, chain_hlocks[i] + 1);
> +	/*
> +	 * The 'unsigned long long' casts avoid that a compiler warning
> +	 * is reported when building tools/lib/lockdep.
> +	 */
> +	if (chain->chain_key != chain_key)
> +		printk(KERN_INFO "chain %lld: key %#llx <> %#llx\n",
> +		       (unsigned long long)(chain - lock_chains),
> +		       (unsigned long long)chain->chain_key,
> +		       (unsigned long long)chain_key);

Idem on the { }

> +	return chain->chain_key == chain_key;
> +}
> +
> +static bool check_data_structures(void)
> +{
> +	struct lock_class *class;
> +	struct lock_chain *chain;
> +	struct hlist_head *head;
> +	struct lock_list *e;
> +	int i;
> +
> +	/*
> +	 * Check whether all list entries that are in use occur in a class
> +	 * lock list.
> +	 */
> +	list_for_each_entry(e, &all_list_entries, alloc_entry) {
> +		if (!in_any_class_list(&e->lock_order_entry)) {
> +			printk(KERN_INFO "list entry %ld is not in any class list; class %s <> %s\n",
> +			       e - list_entries,
> +			       e->class->name ? : "(?)",
> +			       e->links_to->name ? : "(?)");
> +			return false;
> +		}
> +	}
> +
> +	/*
> +	 * Check whether all list entries that are not in use do not occur in
> +	 * a class lock list.
> +	 */
> +	list_for_each_entry(e, &free_list_entries, alloc_entry) {
> +		if (in_any_class_list(&e->lock_order_entry)) {
> +			printk(KERN_INFO "list entry %ld occurs in a class list; class %s <> %s\n",
> +			       e - list_entries,
> +			       e->class && e->class->name ? e->class->name :
> +			       "(?)",
> +			       e->links_to && e->links_to->name ?
> +			       e->links_to->name : "(?)");
> +			return false;
> +		}
> +	}
> +
> +	/* Check whether all classes have valid lock lists. */
> +	for (i = 0; i < ARRAY_SIZE(lock_classes); i++) {
> +		class = &lock_classes[i];
> +		if (!class->locks_before.next)
> +			continue;
> +		if (!class_lock_list_valid(class, &class->locks_before))
> +			return false;
> +		if (!class_lock_list_valid(class, &class->locks_after))
> +			return false;
> +	}
> +
> +	/* Check the chain_key of all lock chains. */
> +	for (i = 0; i < ARRAY_SIZE(chainhash_table); i++) {
> +		head = chainhash_table + i;
> +		hlist_for_each_entry_rcu(chain, head, entry)
> +			if (!check_lock_chain_key(chain))
> +				return false;

And again.

> +	}
> +
> +	return true;
> +}

IIRC there were a few other sites in the series, please check them all.
