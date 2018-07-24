Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C30C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A8C2064D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8A8C2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbeGYAw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 20:52:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41614 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727353AbeGYAw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 20:52:29 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B6EBAAF8;
        Tue, 24 Jul 2018 23:43:35 +0000 (UTC)
Date:   Tue, 24 Jul 2018 16:43:34 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Peter Zijlstra <peterz@infradead.org>, jbaron@akamai.com,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 0/2] fs/epoll: loosen irq safety when possible
Message-Id: <20180724164334.718ab5715b5d5ad0c6c005dd@linux-foundation.org>
In-Reply-To: <20180721183127.3busfa335zlcjeox@linux-r8p5>
References: <20180720172956.2883-1-dave@stgolabs.net>
        <20180720124212.7260d76d83e2b8e5e3349ea5@linux-foundation.org>
        <20180720200559.27nc7j2rrxpy5p3n@linux-r8p5>
        <20180720134429.1ba61018934b084bb2e17bdb@linux-foundation.org>
        <20180721172120.kbdu4euc2wn4xzgf@linux-r8p5>
        <20180721173944.GV2494@hirez.programming.kicks-ass.net>
        <20180721183127.3busfa335zlcjeox@linux-r8p5>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Jul 2018 11:31:27 -0700 Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Sat, 21 Jul 2018, Peter Zijlstra wrote:
> 
> >On Sat, Jul 21, 2018 at 10:21:20AM -0700, Davidlohr Bueso wrote:
> >> On Fri, 20 Jul 2018, Andrew Morton wrote:
> >>
> >> > We could open-code it locally.  Add a couple of
> >> > WARN_ON_ONCE(irqs_disabled())?  That might need re-benchmarking with
> >> > Xen but surely just reading the thing isn't too expensive?
> >>
> >> We could also pass on the responsibility to lockdep and just use
> >> lockdep_assert_irqs_disabled(). But I guess that would be less effective
> >> than to just open code it in epoll without lockdep -- note that over 80
> >> places in the kernel do this.
> >
> >The lockdep thing is relatively recent. I think someone proposed to go
> >replace a bunch of the open-coded ones at some point.
> 
> For the open coded checks, I'm seeing a small (1-2% ish) cost for bare
> metal on workload 1). I don't see (via code inspection) any additional
> overhead in xen either. While negligible in the overall of things, I do
> like the idea of lockdep handling it nonetheless.

It's good that the overhead goes away when lockdep is disabled.  That's
a big advantage over open-coding it.

> I can add the open coded version if people really feel that it would catch
> more bugs (no lockdep users out there in production afaik :) in the long
> term; but if lockdep is where things are headed...
> 
> ...
>
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -670,6 +670,9 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
>  	struct epitem *epi, *nepi;
>  	LIST_HEAD(txlist);
>  
> +	/* must not be called with irqs off */
> +	lockdep_assert_irqs_enabled();

Although I be the humble comment's most avid fan, these ones are too obvious
to be worth the space ;)

Would you survive if I zapped 'em?

--- a/fs/eventpoll.c~fs-epoll-robustify-irq-safety-with-lockdep_assert_irqs_enabled-fix
+++ a/fs/eventpoll.c
@@ -670,7 +670,6 @@ static __poll_t ep_scan_ready_list(struc
 	struct epitem *epi, *nepi;
 	LIST_HEAD(txlist);
 
-	/* must not be called with irqs off */
 	lockdep_assert_irqs_enabled();
 
 	/*
@@ -767,7 +766,6 @@ static int ep_remove(struct eventpoll *e
 {
 	struct file *file = epi->ffd.file;
 
-	/* must not be called with irqs off */
 	lockdep_assert_irqs_enabled();
 
 	/*
@@ -1418,7 +1416,6 @@ static int ep_insert(struct eventpoll *e
 	struct epitem *epi;
 	struct ep_pqueue epq;
 
-	/* must not be called with irqs off */
 	lockdep_assert_irqs_enabled();
 
 	user_watches = atomic_long_read(&ep->user->epoll_watches);
@@ -1549,7 +1546,6 @@ static int ep_modify(struct eventpoll *e
 	int pwake = 0;
 	poll_table pt;
 
-	/* must not be called with irqs off */
 	lockdep_assert_irqs_enabled();
 
 	init_poll_funcptr(&pt, NULL);
_

