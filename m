Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04962C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2456214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QFYdbMda"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbfAJPU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:20:59 -0500
Received: from merlin.infradead.org ([205.233.59.134]:47330 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbfAJPU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:20:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UTi/ZbXdhwyBx9fxlkGH8Kdg1qUu+5Y4mOSxMllo1nM=; b=QFYdbMdag3X/xSPQv0CyG7sos
        xAMWVdZUKJLcHBC+4r/F0uoZT32bjS62X1OMWBqZXmkhJeijVOqSmktaDW80WyO/fNxJYJ0gzzRur
        y5Q4DUNyJ2XvIn2OgUOsFwb+UK2ZRA9JnXg91LRZck6s2DyNwBiLGkYaesltp1KQEoKH3CsFOgzUH
        BlMuPWnWxrlixyUb7fgn8o0w6IUzT/onbmBiL+TRewgU0Grny7zz3R6O0Jf54Wjp/PR+W/lH3nRN0
        GiQN92pKZWK0ddmoUUdTjyVFYrFYH+odLNZz/myB39Pt/wlWGf01HMtuA0A54iWM5kNQNrz2of/C5
        gge02qscA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ghc8N-0004xm-Vg; Thu, 10 Jan 2019 15:20:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9982B2040B9FD; Thu, 10 Jan 2019 16:20:35 +0100 (CET)
Date:   Thu, 10 Jan 2019 16:20:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     mingo@redhat.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v5 07/15] locking/lockdep: Free lock classes that are no
 longer in use
Message-ID: <20190110152035.GF30894@hirez.programming.kicks-ass.net>
References: <20181217213002.73776-1-bvanassche@acm.org>
 <20181217213002.73776-8-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217213002.73776-8-bvanassche@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

Sorry for the delay; real-life and holidays got in the way :/

On Mon, Dec 17, 2018 at 01:29:54PM -0800, Bart Van Assche wrote:
> +/* Remove a class from a lock chain. Must be called with the graph lock held. */
> +static void remove_class_from_lock_chain(struct lock_chain *chain,
> +					 struct lock_class *class)
> +{
> +#ifdef CONFIG_PROVE_LOCKING
> +	struct lock_chain *new_chain;
> +	u64 chain_key;
> +	int i;
> +
> +	for (i = chain->base; i < chain->base + chain->depth; i++) {
> +		if (chain_hlocks[i] != class - lock_classes)
> +			continue;
> +		/* The code below leaks one chain_hlock[] entry. */
> +		if (--chain->depth > 0)
> +			memmove(&chain_hlocks[i], &chain_hlocks[i + 1],
> +				(chain->base + chain->depth - i) *
> +				sizeof(chain_hlocks[0]));
> +		/*
> +		 * Each lock class occurs at most once in a lock chain so once
> +		 * we found a match we can break out of this loop.
> +		 */
> +		goto recalc;
> +	}
> +	/* Since the chain has not been modified, return. */
> +	return;
> +
> +recalc:
> +	chain_key = 0;
> +	for (i = chain->base; i < chain->base + chain->depth; i++)
> +		chain_key = iterate_chain_key(chain_key, chain_hlocks[i] + 1);
> +	if (chain->depth && chain->chain_key == chain_key)
> +		return;
> +	/* Overwrite the chain key for concurrent RCU readers. */
> +	WRITE_ONCE(chain->chain_key, chain_key);
> +	/*
> +	 * Note: calling hlist_del_rcu() from inside a
> +	 * hlist_for_each_entry_rcu() loop is safe.
> +	 */
> +	hlist_del_rcu(&chain->entry);
> +	if (chain->depth == 0)
> +		return;
> +	/*
> +	 * If the modified lock chain matches an existing lock chain, drop
> +	 * the modified lock chain.
> +	 */
> +	if (lookup_chain_cache(chain_key))
> +		return;
> +	if (WARN_ON_ONCE(nr_lock_chains >= MAX_LOCKDEP_CHAINS)) {
> +		debug_locks_off();
> +		return;
> +	}
> +	/*
> +	 * Leak *chain because it is not safe to reinsert it before an RCU
> +	 * grace period has expired.
> +	 */
> +	new_chain = lock_chains + nr_lock_chains++;
> +	*new_chain = *chain;
> +	hlist_add_head_rcu(&new_chain->entry, chainhashentry(chain_key));
> +#endif
> +}

Leaking a chain_hlocks[] and lock_chains[] entry is pretty gross, but
yes that should work.
