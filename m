Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984C1C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 23:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305452174B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 23:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 305452174B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbeHHCCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 22:02:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:41486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbeHHCCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 22:02:07 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5867215EA;
        Tue,  7 Aug 2018 23:45:16 +0000 (UTC)
Date:   Tue, 7 Aug 2018 19:45:15 -0400
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
Message-ID: <20180807194515.4e549c1a@gandalf.local.home>
In-Reply-To: <6B9E5DC9-0859-41B4-9B72-A7D85E9EA2AD@google.com>
References: <20180730222423.196630-1-joel@joelfernandes.org>
        <20180730222423.196630-4-joel@joelfernandes.org>
        <20180806155058.5ee875f4@gandalf.local.home>
        <CAJWu+oqvpev_EZC38_mi+UNRCxS8GqNVagHyGM4dUjruzKgwgQ@mail.gmail.com>
        <20180806214300.13e63523@gandalf.local.home>
        <CAJWu+oqZi2W9OYAn2xu17fdrBitQs4Gti4LxWmtx5B-EYtNMmA@mail.gmail.com>
        <20180807094954.5137972d@gandalf.local.home>
        <446AE5F2-39E0-46B6-8E0B-207E003DBF20@google.com>
        <20180807103410.4fe203cb@gandalf.local.home>
        <C1CB990F-8232-4168-89A8-E8C13B660B0B@google.com>
        <20180807110906.3a1b0ac4@gandalf.local.home>
        <6B9E5DC9-0859-41B4-9B72-A7D85E9EA2AD@google.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Aug 2018 11:24:13 -0400
Joel Fernandes <joelaf@google.com> wrote:

> On August 7, 2018 11:09:06 AM EDT, Steven Rostedt <rostedt@goodmis.org> wrote:
> >On Tue, 07 Aug 2018 10:48:05 -0400
> >Joel Fernandes <joelaf@google.com> wrote:
> >  
> >> >You mean if someone add a tracepoint callback to the irq disable
> >> >tracepoint, and did a lockdep assert to make sure interrupts are
> >> >disabled?    
> >> 
> >> Yes that's what I meant.  
> >
> >That sounds like a "Doctor, it hurts me when I do this" problem ;-)  
> 
> Haha, yes true. But just to clarify, I didn't do this to see the problem but noticed it with turning on existing things. :-) but I see your point...
> 

OK, I hit this bug, but it's not because of the partial revert. This
bug seems it needs to be another partial revert. I like you movement of
the code, but I'm starting to doubt that we can use a trace event as a
hook for critical areas yet. Well, not until we can use srcu in NMI.

#define __DO_TRACE(tp, proto, args, cond, rcuidle)			\
	do {								\
		struct tracepoint_func *it_func_ptr;			\
		void *it_func;						\
		void *__data;						\
		int __maybe_unused idx = 0;				\
									\
		if (!(cond))						\
			return;						\
									\
		/* srcu can't be used from NMI */			\

		WARN_ON_ONCE(rcuidle && in_nmi()); <== WARN_ON_ONCE hit!

WARNING: CPU: 3 PID: 3727 at /work/build/trace/nobackup/linux-test.git/include/trace/events/preemptirq.h:38 trace_irq_disable_rcuidle+0x2a/0x6c
Modules linked in: ip6t_REJECT nf_reject_ipv6 nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 crc_ccitt r8169 ppdev parport_pc parport
CPU: 3 PID: 3727 Comm: trace-cmd Not tainted 4.18.0-rc6-test+ #14
Hardware name: MSI MS-7823/CSM-H87M-G43 (MS-7823), BIOS V1.6 02/22/2014
EIP: trace_irq_disable_rcuidle+0x2a/0x6c
Code: e9 01 00 00 00 c3 64 8b 0d 24 e1 50 c1 0f a3 0d e0 f1 3f c1 73 55 55 89 e5 57 56 53 51 64 8b 0d cc 37 51 c1 0f ba e1 14 73 02 <0f> 0b 89 d7 89 c6 b8 e0 d8 2e c1 e8 8e 5b fa ff 8b 1d 9c 27 3d c1 
EAX: c0401509 EBX: efa43680 ECX: 80110000 EDX: c0dc81f3
ESI: ed823d44 EDI: efa43680 EBP: ed823cd0 ESP: ed823cc0
DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010047
CR0: 80050033 CR2: b7f06000 CR3: 30513b00 CR4: 001406f0
Call Trace:
 trace_hardirqs_off_caller+0x23/0x2d
 trace_hardirqs_off_thunk+0xc/0x10
EIP: default_do_nmi+0x1/0x157


-- Steve
