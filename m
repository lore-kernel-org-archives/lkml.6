Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1D3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A78420874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bs10b1Ll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730844AbfAKIeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 03:34:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44416 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbfAKIeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 03:34:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XztsdydnA9aErpsx+ZLJyi1LgXJcuTHdbr1BDNLGFYQ=; b=bs10b1LlljCRAmHsKrXP1lxoR
        wggpYj99i32W381r9cbrHsdBiztV3x/At6X+D7DtqTRMQTRjq8XaeN+3fpfHSgqBjKi0Y/07mb9+r
        W3IexEOXhDoqKta15DK5aACnj8YLfWJlh28X4xMZ5dNGqvG2ZkHFPuJkDMZGERFCGhgNbRSxeVNdG
        7B2ikyup19y6CqpZto2Ozf9hlmhpZnPvTNkpcZqQvlIKYHBcuLFvtGuZgfERp7txUB1F9wVkNK23M
        YW1y1ZWbizPZoOUJsIqgCR23PBKsiT0Cko1rAn5mw3ncmgmlWKYUjoX/n+PwZ0G7NeH+ykHjVc6R7
        yuiR7akgQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ghsGd-00011G-0L; Fri, 11 Jan 2019 08:34:15 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6F04B20280450; Fri, 11 Jan 2019 09:34:11 +0100 (CET)
Date:   Fri, 11 Jan 2019 09:34:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     Anatol Pomozov <anatol.pomozov@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, paulmck@linux.ibm.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: seqcount usage in xt_replace_table()
Message-ID: <20190111083411.GM1900@hirez.programming.kicks-ass.net>
References: <CAOMFOmU=t9YbE68YpoQn0Ug0XN1F+0iuJp9J=htCRRrbdaPSVA@mail.gmail.com>
 <20190108223746.shuwx3ro7cgwz7hh@breakpoint.cc>
 <20190110124123.GA21224@hirez.programming.kicks-ass.net>
 <20190110144812.mkbokbj2iyryj6lv@breakpoint.cc>
 <20190110202533.GK2861@worktop.programming.kicks-ass.net>
 <20190110222920.jqpzzv74huc2lb7f@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110222920.jqpzzv74huc2lb7f@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 11:29:20PM +0100, Florian Westphal wrote:
> Peter Zijlstra <peterz@infradead.org> wrote:
> > Would using synchronize_rcu() not also mean you can get rid of that
> > xt_write_recseq*() stuff entirely?
> 
> No, because those are used to synchronize with cpus that read
> the ruleset counters, see
> 
> net/ipv4/netfilter/ip_tables.c:get_counters().

Ah, bummer :/

> > Anyway, synchronize_rcu() can also take a little while, but I don't
> > think anywere near 30 seconds.
> 
> Ok, I think in that case it would be best to just replace the
> recseq value sampling with smp_mb + synchronize_rcu plus a comment
> that explains why its done.

synchronize_rcu() implies smp_mb() on all CPUs.
