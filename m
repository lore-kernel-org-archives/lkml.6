Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B79C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB794213F2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbfAJW3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 17:29:25 -0500
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:55694 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728042AbfAJW3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 17:29:25 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1ghipE-0001kK-9d; Thu, 10 Jan 2019 23:29:20 +0100
Date:   Thu, 10 Jan 2019 23:29:20 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Florian Westphal <fw@strlen.de>,
        Anatol Pomozov <anatol.pomozov@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, paulmck@linux.ibm.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: seqcount usage in xt_replace_table()
Message-ID: <20190110222920.jqpzzv74huc2lb7f@breakpoint.cc>
References: <CAOMFOmU=t9YbE68YpoQn0Ug0XN1F+0iuJp9J=htCRRrbdaPSVA@mail.gmail.com>
 <20190108223746.shuwx3ro7cgwz7hh@breakpoint.cc>
 <20190110124123.GA21224@hirez.programming.kicks-ass.net>
 <20190110144812.mkbokbj2iyryj6lv@breakpoint.cc>
 <20190110202533.GK2861@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110202533.GK2861@worktop.programming.kicks-ass.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> wrote:
> Would using synchronize_rcu() not also mean you can get rid of that
> xt_write_recseq*() stuff entirely?

No, because those are used to synchronize with cpus that read
the ruleset counters, see

net/ipv4/netfilter/ip_tables.c:get_counters().

> Anyway, synchronize_rcu() can also take a little while, but I don't
> think anywere near 30 seconds.

Ok, I think in that case it would be best to just replace the
recseq value sampling with smp_mb + synchronize_rcu plus a comment
that explains why its done.
