Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36201C46472
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF82B217B9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:34:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF82B217B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389615AbeHGQsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 12:48:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:53820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389575AbeHGQsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 12:48:51 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D936217B7;
        Tue,  7 Aug 2018 14:34:13 +0000 (UTC)
Date:   Tue, 7 Aug 2018 10:34:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joelaf@google.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v12 3/3] tracing: Centralize preemptirq tracepoints and
 unify their usage
Message-ID: <20180807103410.4fe203cb@gandalf.local.home>
In-Reply-To: <446AE5F2-39E0-46B6-8E0B-207E003DBF20@google.com>
References: <20180730222423.196630-1-joel@joelfernandes.org>
        <20180730222423.196630-4-joel@joelfernandes.org>
        <20180806155058.5ee875f4@gandalf.local.home>
        <CAJWu+oqvpev_EZC38_mi+UNRCxS8GqNVagHyGM4dUjruzKgwgQ@mail.gmail.com>
        <20180806214300.13e63523@gandalf.local.home>
        <CAJWu+oqZi2W9OYAn2xu17fdrBitQs4Gti4LxWmtx5B-EYtNMmA@mail.gmail.com>
        <20180807094954.5137972d@gandalf.local.home>
        <446AE5F2-39E0-46B6-8E0B-207E003DBF20@google.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Aug 2018 10:10:59 -0400
Joel Fernandes <joelaf@google.com> wrote:

> On August 7, 2018 9:49:54 AM EDT, Steven Rostedt <rostedt@goodmis.org> wrote:
> >On Tue, 7 Aug 2018 06:33:35 -0700
> >Joel Fernandes <joelaf@google.com> wrote:
> >  
> >> Thanks, also one more thing I noticed in your patch,
> >> lockdep_hardirqs_off needs to be called before all other probes but
> >> you're calling it after. This is why I registered it with INT_MAX:
> >> 
> >> register_trace_prio_irq_disable(lockdep_hardirqs_off, NULL, INT_MAX);
> >> 
> >> Without it you may get annotation warnings. Thanks,  
> >
> >Interesting. I was following the old way where we called the tracing
> >code before calling the lockdep code (all hard coded and not from
> >trace events). Is this have something to do with calling the code from
> >a tracepoint?
> >
> >Do you have an example that could trigger the warning?
> >  
> 
> I remember the warnings but can't remember now how I triggered them.
> I think I saw them with the irqsoff tracer or irq trace events
> running, with lockdep turned on.

I'll see if I can trigger it. I'll run this all through my tests.

> 
> Also an irq disable probe that does a lockdep assert that irqs are
> disabled could trigger it?
> 

You mean if someone add a tracepoint callback to the irq disable
tracepoint, and did a lockdep assert to make sure interrupts are
disabled?

-- Steve

