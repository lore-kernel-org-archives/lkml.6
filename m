Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D11C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD69320834
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jfQ1yvZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD69320834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeK2Vmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 16:42:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41514 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbeK2Vmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 16:42:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0Z+JkfOx+eta1HptoWLBsSRC9nN6dWveZk0kYBWi1FI=; b=jfQ1yvZ6y9eOvYPcecNVaOsBJ
        Q6Ptp+V3RLuS/4RLSnxTDz0P0deZJWsiP1Tq987dz554e7SKqiIW5NNSVgZC8qlDDTe7Ehq8Mfpd4
        yEbZCDIvj1bYmUer4fYQrHE9/xBe8vc/OZvGbn2Ra3xZ8YAU3mxBEKrnHF5D0E+wQW9tzoQaKd+UI
        XUQns+qGvf8U70LmoB2Hb/7jRtVfCsIix3AvaHEkzSqMpknD7QgG0tCZOWbvGIsYhl/SH5RQmHqFV
        aLodyGM6Cn1da1e4ku81RxvlxuPUTRKLqRJSxAVm483f31hJsInxH8n25xUxJO3tlmj0j8e9/lqQr
        dvgQj7eGQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSJhU-0006Yw-6J; Thu, 29 Nov 2018 10:37:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 89B802029FD58; Thu, 29 Nov 2018 11:37:38 +0100 (CET)
Date:   Thu, 29 Nov 2018 11:37:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     mingo@redhat.com, tj@kernel.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 20/27] locking/lockdep: Free lock classes that are no
 longer in use
Message-ID: <20181129103738.GG2131@hirez.programming.kicks-ass.net>
References: <20181128234325.110011-1-bvanassche@acm.org>
 <20181128234325.110011-21-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128234325.110011-21-bvanassche@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 03:43:18PM -0800, Bart Van Assche wrote:
> +/* Must be called with the graph lock held. */
> +static void remove_class_from_lock_chain(struct lock_chain *chain,
> +					 struct lock_class *class)
> +{
> +	u64 chain_key;
> +	int i;
> +
> +	for (i = chain->base; i < chain->base + chain->depth; i++) {
> +		if (chain_hlocks[i] != class - lock_classes)
> +			continue;
> +		if (--chain->depth == 0)
> +			break;
> +		memmove(&chain_hlocks[i], &chain_hlocks[i + 1],
> +			(chain->base + chain->depth - i) *
> +			sizeof(chain_hlocks[0]));
> +		/*
> +		 * Each lock class occurs at most once in a
> +		 * lock chain so once we found a match we can
> +		 * break out of this loop.
> +		 */
> +		break;
> +	}
> +	/*
> +	 * Note: calling hlist_del_rcu() from inside a
> +	 * hlist_for_each_entry_rcu() loop is safe.
> +	 */
> +	if (chain->depth == 0) {
> +		/* To do: decrease chain count. See also inc_chains(). */
> +		hlist_del_rcu(&chain->entry);
> +		return;
> +	}
> +	chain_key = 0;
> +	for (i = chain->base; i < chain->base + chain->depth; i++)
> +		chain_key = iterate_chain_key(chain_key, chain_hlocks[i] + 1);
> +	if (chain->chain_key == chain_key)
> +		return;
> +	hlist_del_rcu(&chain->entry);
> +	chain->chain_key = chain_key;
> +	hlist_add_head_rcu(&chain->entry, chainhashentry(chain_key));
> +}
> +
> +/* Must be called with the graph lock held. */
> +static void remove_class_from_lock_chains(struct lock_class *class)
> +{
> +	struct lock_chain *chain;
> +	struct hlist_head *head;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(chainhash_table); i++) {
> +		head = chainhash_table + i;
> +		hlist_for_each_entry_rcu(chain, head, entry) {
> +			remove_class_from_lock_chain(chain, class);
> +		}
> +	}
> +}

*shudder*, I suppose that is the reason I never went there.

I suoppose that if you don't do this too often it doesn't matter it is
horribly epxneisve.
