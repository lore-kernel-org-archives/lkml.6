Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FB1C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB8D2208E7
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB8D2208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbeLHRem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 12:34:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:38100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbeLHRem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 12:34:42 -0500
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C19720868;
        Sat,  8 Dec 2018 17:34:40 +0000 (UTC)
Date:   Sat, 8 Dec 2018 12:34:37 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luis Claudio R. Goncalves" <lclaudio@uudg.org>, ldv@altlinux.org,
        esyr@redhat.com, Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 1/8] perf: Allow to block process in syscall tracepoints
Message-ID: <20181208123437.16e42fe3@vmware.local.home>
In-Reply-To: <20181208104121.GD5289@hirez.programming.kicks-ass.net>
References: <20181205160509.1168-1-jolsa@kernel.org>
        <20181205160509.1168-2-jolsa@kernel.org>
        <20181206081028.GE4234@hirez.programming.kicks-ass.net>
        <20181206083400.GA13675@hirez.programming.kicks-ass.net>
        <20181206131946.2c47f556@vmware.local.home>
        <20181207085839.GC2237@hirez.programming.kicks-ass.net>
        <20181207072701.5bc564c7@vmware.local.home>
        <20181207151105.GB5289@hirez.programming.kicks-ass.net>
        <20181207154921.GB28174@kernel.org>
        <20181208104121.GD5289@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Dec 2018 11:41:21 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> > [root@seventh bpf]# trace -e augmented_raw_syscalls.c  --filter-pids 2279,1643
> > <SNIP>
> >  19766.027 ( 0.003 ms): gcc/27524 openat(dfd: CWD, filename: /lib64/libz.so.1, flags: CLOEXEC           ) = 5
> >  19766.035 ( 0.001 ms): gcc/27524 fstat(fd: 5, statbuf: 0x7ffe9323e2a0                                  ) = 0
> >  19766.037 ( 0.003 ms): gcc/27524 mmap(len: 2187272, prot: EXEC|READ, flags: PRIVATE|DENYWRITE, fd: 5   ) = 0x7fa2df435000
> >  19766.042 ( 0.003 ms): gcc/27524 mprotect(start: 0x7fa2df44b000, len: 2093056                          ) = 0
> >  19766.046 ( 0.004 ms): gcc/27524 mmap(addr: 0x7fa2df64a000, len: 4096, prot: READ|WRITE, flags: PRIVATE|FIXED|DENYWRITE, fd: 5, off: 86016) = 0x7fa2df64a000
> >  19766.051 ( 0.002 ms): gcc/27524 mmap(addr: 0x7fa2df64b000, len: 8, prot: READ|WRITE, flags: PRIVATE|FIXED|ANONYMOUS) = 0x7fa2df64b000
> >  19766.057 ( 0.001 ms): gcc/27524 close(fd: 5                                                           ) = 0
> >  19766.062 ( 0.003 ms): gcc/27524 openat(dfd: CWD, filename: /lib64/libc.so.6, flags: CLOEXEC           ) = 5
> > <SNIP>  
> 
> Right; and that is all nice. And exactly doesn't answer my question. Why
> do we care about those LOST entries so much that we have to do such
> horribly ugly things?
> 
> Esp. as you point out, they're clearly marked in the output and easily
> avoided by using a slightly larger buffer.

For small cases like this a slightly larger buffer wont help. And it
would suck if you are tracing something to find out why there's some
kind of anomaly that takes hours to run, only to find out that the
anomaly happened in the lost events.

Yes, there is a use case for a guarantee of no lost events!


-- Steve
