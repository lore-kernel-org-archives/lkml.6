Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C2EC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97FF3216F6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:23:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97FF3216F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbeHHKm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 06:42:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726979AbeHHKm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 06:42:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1978E40216E7;
        Wed,  8 Aug 2018 08:23:50 +0000 (UTC)
Received: from krava (unknown [10.43.17.133])
        by smtp.corp.redhat.com (Postfix) with SMTP id 87DBD1C70A;
        Wed,  8 Aug 2018 08:23:48 +0000 (UTC)
Date:   Wed, 8 Aug 2018 10:23:47 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Stephane Eranian <eranian@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, mingo@elte.hu
Subject: Re: [PATCH] perf ordered_events: fix crash in free_dup_event()
Message-ID: <20180808082347.GB20320@krava>
References: <1533605015-19514-1-git-send-email-eranian@google.com>
 <20180807072029.GA7716@krava>
 <CABPqkBSyf0WMKmZAFGSyBvX=jn1zifbMPztt_053hvvDh6UsHw@mail.gmail.com>
 <20180807085010.GC7716@krava>
 <CABPqkBTvXSgJNPW=4MxFqDR_oeYHteuDoeavdFHKuXe+8Y=2DQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBTvXSgJNPW=4MxFqDR_oeYHteuDoeavdFHKuXe+8Y=2DQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 08 Aug 2018 08:23:50 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 08 Aug 2018 08:23:50 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 12:11:05PM -0700, Stephane Eranian wrote:
> Jiri,
> On Tue, Aug 7, 2018 at 1:50 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Tue, Aug 07, 2018 at 01:16:22AM -0700, Stephane Eranian wrote:
> > > On Tue, Aug 7, 2018 at 12:20 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > > >
> > > > On Mon, Aug 06, 2018 at 06:23:35PM -0700, Stephane Eranian wrote:
> > > > > Depending on memory allocations, it was possible to get a SEGFAULT in
> > > > > free_dup_event() because the event pointer was bogus:
> > > > >
> > > > > perf[1354]: segfault at ffffffff00000006 ip 00000000004b7fc7
> > > >
> > > > is there any reproducer?
> > > >
> > > The cmdline is simple:
> > > $ perf record -e cycles:pp -o - -a sleep 1 | perf inject -b -i - >/dev/null
> > > I was using v4.13 for my tests and it may be sensitive to compiler.
> > > Was using LLVM.
> >
> > I can't make it fail even when I compile with clang 'make CC=clang'
> >
> I checked, my actual reproducer is:
> $ perf record -o - -e cycles date |  perf inject -b -i - >/dev/null
> Tue Aug  7 12:03:48 PDT 2018
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.000 MB - ]
> Segmentation fault (core dumped)
> 
> the crash is in perf inject.
> So if I do:
> $ perf record -o - -e cycles date >tt
> $ gdb perf
> (gdb) r inject -b -i - < tt  >/dev/null
> Program received signal SIGSEGV, Segmentation fault.
> free_dup_event (oe=0x26a39a0, event=0xffffffff00000000) at
> util/ordered-events.c:85
> 85 in util/ordered-events.c
> (gdb) bt
> #0  free_dup_event (oe=0x26a39a0, event=0xffffffff00000000) at
> util/ordered-events.c:85
> #1  ordered_events__free (oe=0x26a39a0) at util/ordered-events.c:310
> #2  0x00000000004b5a56 in __perf_session__process_pipe_events
> (session=<optimized out>) at util/session.c:1753
> #3  perf_session__process_events (session=<optimized out>) at
> util/session.c:1932
> #4  0x000000000043a2eb in __cmd_inject (inject=<optimized out>) at
> builtin-inject.c:750
> #5  cmd_inject (argc=<optimized out>, argv=<optimized out>) at
> builtin-inject.c:924
> #6  0x000000000046b175 in run_builtin (p=0xabc640 <commands+576>,
> argc=4, argv=0x7fffffffe560) at perf.c:297
> #7  0x000000000046b062 in handle_internal_command (argc=4,
> argv=0x7fffffffe560) at perf.c:349
> #8  0x000000000046a5e8 in run_argv (argcp=<optimized out>,
> argv=<optimized out>) at perf.c:393
> #9  main (argc=4, argv=0x7fffffffe560) at perf.c:531

nice

> 
> Again, this is with an older version of perf compiled with LLVM.

can you also reproduce it with latest code?

> Notice the value of event passed to free_dup_event(): 0xffffffff00000000
> And yes, I checked sizeof(union_perf_event) = 4168 which is the size of
> the mmap2_event which is the largest.
> 
> I also checked that you are freeing what you have actually allocated.
> No double free.
> If I add the padding or modifies the call to memdup() as in the patch,
> then the problem
> goes away.
> 
> If you don't want to copy 4Kb each time, then you could also make the
> event field
> by a void *event and case whenever needed.

not sure I understand this one.. could you please elaborate?

> 
> I suspect the problem may come from a compiler optimization or assumption which
> clashes with what you are optimizing here.

I'll go throught the code and try to find somethign.. thanks a lot for the backtrace

jirka

