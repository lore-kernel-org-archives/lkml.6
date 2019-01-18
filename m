Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA56C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D06E52087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q1Nk641Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfARIlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:41:44 -0500
Received: from merlin.infradead.org ([205.233.59.134]:56916 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbfARIln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:41:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YbuExQsgmep5NmV3tEy3Rh9aiqP2mqptXXYbF6dwUTM=; b=Q1Nk641ZyPGq5vXULYfg/6d9R
        TBaJswp4a+Qs68DgD5ydvmt9ioBXbAYxCiW2OAs0zU3U52eNA2Cl34m8w6oG+1NprG6V8cV+CDCWr
        dPfBYTpoEkMvQUd1miC2OPR1+ihR3rA0BGCv/3UC6Q1CC86idFoYdUxKz62NzsgWKLqUcY6nTh+V9
        QCC3wgTZyHFTxUGrcvG5r/1EoVFZ6Y7YDYm4M1L+v7XpMi/rrEtzZJa+jKKEmf0QMNJrpUNzucV3g
        7Qzm9PzSs8HpdWIPe0vIPyvnuomg5/BSPhZCzkZkLIL9rHf57iJMaeBm+0jzpYdRcqIoVdXy28qhr
        TlkOR9G1Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gkPiX-000197-Ig; Fri, 18 Jan 2019 08:41:33 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 211C7202A6AFB; Fri, 18 Jan 2019 09:41:32 +0100 (CET)
Date:   Fri, 18 Jan 2019 09:41:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        acme@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, dsahern@gmail.com,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v10 perf, bpf-next 1/9] perf, bpf: Introduce
 PERF_RECORD_KSYMBOL
Message-ID: <20190118084132.GB10855@hirez.programming.kicks-ass.net>
References: <20190116162931.1542429-1-songliubraving@fb.com>
 <20190116162931.1542429-2-songliubraving@fb.com>
 <20190117125653.GF10486@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117125653.GF10486@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 01:56:53PM +0100, Peter Zijlstra wrote:
> +static __always_inline struct latch_tree_node *
> +latch_tree_first(struct latch_tree_root *root)
> +{
> +	struct latch_tree_node *ltn = NULL;
> +	struct rb_node *node;
> +	unsigned int seq;
> +
> +	do {
> +		struct rb_root *rbr;
> +
> +		seq = raw_read_seqcount_latch(&root->seq);
> +		rbr = &root->tree[seq & 1];
> +		node = rb_first(rbr);
> +	} while (read_seqcount_retry(&root->seq, seq));
> +
> +	if (node)
> +		ltn = __lt_from_rb(node, seq & 1);
> +
> +	return ltn;
> +}
> +
> +/**
> + * latch_tree_next() - find the next @ltn in @root per sort order
> + * @root: trees to which @ltn belongs
> + * @ltn: nodes to start from
> + *
> + * Does a lockless lookup in the trees @root for the next node starting at
> + * @ltn.
> + *
> + * Using this function outside of the write side lock is rather dodgy but given
> + * latch_tree_erase() doesn't re-init the nodes and the whole iteration is done
> + * under a single RCU critical section, it should be non-fatal and generate some
> + * semblance of order - albeit possibly missing chunks of the tree.
> + */
> +static __always_inline struct latch_tree_node *
> +latch_tree_next(struct latch_tree_root *root, struct latch_tree_node *ltn)
> +{
> +	struct rb_node *node;
> +	unsigned int seq;
> +
> +	do {
> +		seq = raw_read_seqcount_latch(&root->seq);
> +		node = rb_next(&ltn->node[seq & 1]);
> +	} while (read_seqcount_retry(&root->seq, seq));
> +
> +	return __lt_from_rb(node, seq & 1);
> +}

> +static int kallsym_tree_kallsym(unsigned int symnum, unsigned long *value, char *type,
> +				char *sym, char *modname, int *exported)
> +{
> +	struct latch_tree_node *ltn;
> +	int i, ret = -ERANGE;
> +
> +	rcu_read_lock();
> +	for (i = 0, ltn = latch_tree_first(&kallsym_tree); i < symnum && ltn;
> +	     i++, ltn = latch_tree_next(&kallsym_tree, ltn))
> +		;

On second thought; I don't think this will be good enough after all.
Missing entire subtrees is too much.

The rcu-list iteration will only miss newly added symbols, and for those
we'll get the events, combined we'll still have a complete picture. Not
so when a whole subtree goes missing.

I thought I could avoid the list this way, but alas, not so.

> +
> +	if (ltn) {
> +		struct kallsym_node *kn;
> +		char *mod;
> +
> +		kn = container_of(ltn, struct kallsym_node, kn_node);
> +
> +		kn->kn_names(kn, sym, &mod);
> +		if (mod)
> +			strlcpy(modname, mod, MODULE_NAME_LEN);
> +		else
> +			modname[0] = '\0';
> +
> +		*type = 't';
> +		*exported = 0;
> +		ret = 0;
> +	}
> +	rcu_read_unlock();
> +
> +	return ret;
> +}
