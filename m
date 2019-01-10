Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766ADC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454AD2177B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbfAJOsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:48:19 -0500
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:53116 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728125AbfAJOsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 09:48:19 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1ghbcy-0006Lj-1R; Thu, 10 Jan 2019 15:48:12 +0100
Date:   Thu, 10 Jan 2019 15:48:12 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Florian Westphal <fw@strlen.de>,
        Anatol Pomozov <anatol.pomozov@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, paulmck@linux.ibm.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: seqcount usage in xt_replace_table()
Message-ID: <20190110144812.mkbokbj2iyryj6lv@breakpoint.cc>
References: <CAOMFOmU=t9YbE68YpoQn0Ug0XN1F+0iuJp9J=htCRRrbdaPSVA@mail.gmail.com>
 <20190108223746.shuwx3ro7cgwz7hh@breakpoint.cc>
 <20190110124123.GA21224@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110124123.GA21224@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> wrote:
> 	/*
> 	 * Ensure contents of newinfo are visible before assigning to
> 	 * private.
> 	 */
> 	smp_wmb();
> 	table->private = newinfo;
> 
> we have:
> 
> 	smp_store_release(&table->private, newinfo);
> 
> But what store does that second smp_wmb() order against? The comment:
> 
> 	/* make sure all cpus see new ->private value */
> 	smp_wmb();
> 
> makes no sense what so ever, no smp_*() barrier can provide such
> guarantees.

IIRC I added this at the request of a reviewer of an earlier iteration
of that patch.

IIRC the concern was that compiler/hw could re-order

smb_wmb();
table->private = newinfo;
/* wait until all cpus are done with old table */

 into:

smb_wmb();
/* wait until all cpus are done with old table */
...
table->private = newinfo;

and that (obviously) makes the wait-loop useless.

> > Only alternative I see that might work is synchronize_rcu (the
> > _do_table functions are called with rcu read lock held).
> > 
> > I guess current scheme is cheaper though.
> 
> Is performance a concern in this path? There is no comment justifying
> this 'creative' stuff.

We have to wait until all cpus are done with current iptables ruleset.

Before this 'creative' change, this relied on get_counters
synchronization.  And that caused wait times of 30 seconds or more on
busy systems.

I have no objections swapping this with a synchronize_rcu() if that
makes it easier.

(synchronize_rcu might be confusing though, as we don't use rcu
 for table->private), and one 'has to know' that all the netfilter
 hooks, including the iptables eval loop, run with rcu_read_lock
 held).
