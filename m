Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206E9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D0A20657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tlNIPe5/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbfANNKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 08:10:14 -0500
Received: from merlin.infradead.org ([205.233.59.134]:46864 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfANNKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 08:10:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OxDIfeTncIhJ2P/KLTmDSXoakueEGzi6YAah7xEtPDs=; b=tlNIPe5/nN4We3O5agLv3+ZPJ
        BPyaPqD4EieKcDa5Bzu3nvqYg2WWimPxEOrlcA4Kt6W+VZczhMnu0ecgK66PbkaIGBwd+ZqBJmAd6
        Zx7h8pkNmIs9GR0kddQVbkCQxkoM/cf1l89p8SL64B4gbHs5rzZALsMBHpkt2+OZw0g2fPs/Myw6x
        IW+mSEUQU3N7OHL8Vm8U6w3jdH5yUhL5SKb8CBfb88p2+nKXAohUQQy5kFJO2d52jqTJBbSXLuCTG
        7rtnVhjMhnwNYNWZ415yffgFxtDXFn7yVrI43E/kMC9G4N4upf0kI4depL22mk+Cfrtuwf1GpidSp
        ljOFXrFqg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gj207-000547-Q9; Mon, 14 Jan 2019 13:10:00 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DABF9200A65EE; Mon, 14 Jan 2019 14:09:57 +0100 (CET)
Date:   Mon, 14 Jan 2019 14:09:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     rostedt <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Perf: event wakeup discards sched_waking events
Message-ID: <20190114130957.GA10486@hirez.programming.kicks-ass.net>
References: <2103471967.794.1547084331086.JavaMail.zimbra@efficios.com>
 <20190110110839.7daeef3d@gandalf.local.home>
 <1884815641.993.1547138653377.JavaMail.zimbra@efficios.com>
 <600900741.1177.1547140315581.JavaMail.zimbra@efficios.com>
 <1083900143.1198.1547141113001.JavaMail.zimbra@efficios.com>
 <1706586119.1203.1547142327142.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1706586119.1203.1547142327142.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 12:45:27PM -0500, Mathieu Desnoyers wrote:
 
> static void perf_pending_event(struct irq_work *entry)
> {
>         struct perf_event *event = container_of(entry,
>                         struct perf_event, pending);
>         int rctx;
> 
>         rctx = perf_swevent_get_recursion_context();
>         /*
>          * If we 'fail' here, that's OK, it means recursion is already disabled
>          * and we won't recurse 'further'.
>          */
> 
>         if (event->pending_disable) {
>                 event->pending_disable = 0;
>                 perf_event_disable_local(event);
>         }
> 
>         if (event->pending_wakeup) {
>                 event->pending_wakeup = 0;
>                 perf_event_wakeup(event);
>         }
> 
>         if (rctx >= 0)
>                 perf_swevent_put_recursion_context(rctx);
> }
> 
> One side-effect of perf_event_wakeup() is to generate a sched_waking
> event. But I suspect it won't be traced by perf because it is invoked before
> putting the recursion context.
> 
> Is there a reason why the wakeup is done before putting the recursion
> context ?

d525211f9d1b ("perf: Fix irq_work 'tail' recursion")

If we were to allow perf_event_wakeup() to generate its tracepoint, we'd
be back to square #1, no?
