Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE331C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 10:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A63FE2082D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 10:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X1sqJcjY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A63FE2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbeLHKlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 05:41:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38648 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeLHKlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 05:41:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5KFZORgDx5DiK+YL2VbczodsAsaOlpGZp+P3s6Vg6KQ=; b=X1sqJcjYWx+NqZ2D8MaZHoVF1
        Vz+zSxMQLR37EZ3Tund1uAzw8DXBT+Wru2iqxwuBSOj5rx75bK925kNlTPEN4KSFFoqaeRicGa9aW
        JAigZIxCdGFvdqcJC6B6IaXsJV9im4Bs3WvihdJpqXt8JKahF7u/y1Cz8CHu2TFhtcTTaMy0KWUO8
        vNtgPEzl3tukO0Np2RK83PHmHc12us34PLKwxgb7Vj1pz+iFOg93RVOg/SfCww6xiAri1NhFwYZPK
        tbxUHzDv/2XIV8dOlGZTA4S4SRtVRQJ8rDlGF6v3BLEVBKV6c3oTuFWguwMzmyBbGLKJ641b/wpmU
        T7NZMwxMA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gVa31-0002eP-1d; Sat, 08 Dec 2018 10:41:23 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8AC04207261A7; Sat,  8 Dec 2018 11:41:21 +0100 (CET)
Date:   Sat, 8 Dec 2018 11:41:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luis Claudio R. Goncalves" <lclaudio@uudg.org>, ldv@altlinux.org,
        esyr@redhat.com, Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 1/8] perf: Allow to block process in syscall tracepoints
Message-ID: <20181208104121.GD5289@hirez.programming.kicks-ass.net>
References: <20181205160509.1168-1-jolsa@kernel.org>
 <20181205160509.1168-2-jolsa@kernel.org>
 <20181206081028.GE4234@hirez.programming.kicks-ass.net>
 <20181206083400.GA13675@hirez.programming.kicks-ass.net>
 <20181206131946.2c47f556@vmware.local.home>
 <20181207085839.GC2237@hirez.programming.kicks-ass.net>
 <20181207072701.5bc564c7@vmware.local.home>
 <20181207151105.GB5289@hirez.programming.kicks-ass.net>
 <20181207154921.GB28174@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207154921.GB28174@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 12:49:21PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Dec 07, 2018 at 04:11:05PM +0100, Peter Zijlstra escreveu:
> > On Fri, Dec 07, 2018 at 08:41:18AM -0500, Steven Rostedt wrote:
> > > On Fri, 7 Dec 2018 09:58:39 +0100 Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > > These patches give no justification *what*so*ever* for why we're doing
> > > > ugly arse things like this. And why does this, whatever this is, need to
> > > > be done in perf?
> 
> > > > IOW, what problem are we solving ?
> 
> > > I guess the cover letter should have had a link (or copy) of this:
> 
> > >  http://lkml.kernel.org/r/20181128134700.212ed035@gandalf.local.home
> 
> > That doesn't even begin to explain. Who cares about strace and why? And
> > why is it such a bad thing to loose the occasional record etc..
> 
> The following almost addresses all the details for doing such a perf
> based strace tool (modulo signals), was started by Thomas a long time
> ago [1] and is in the tree for a long time, with BPF attached to the
> raw_syscalls:sys_{enter,exit} (that -e augmented_raw_syscalls.c thing
> that lives in tools/perf/examples/bpf now but would be put in place
> transparently and pre-compiled as augmented_raw_syscalls.o) to collect
> pointer contents without using ptrace:

> For system wide stracing elliminating the feedback loop of your GUI
> components will most of the time work with the default ring buffer size
> and when it doesn't, you'll get things like that "LOST events!" message,
> and for such extreme cases, just use '-m' to bump the rb size some more.

> # trace  --filter-pids 2279,1643

>   8793.640 ( 0.001 ms): cc1/19097 read(fd: 21, buf: 0x3ed6a13, count: 4096                              ) = 0
> LOST 34956 events!
>   9497.921 ( 0.006 ms): gcc/19180 openat(dfd: CWD, filename: 0x3115e20, flags: NOCTTY                   ) = -1 ENOENT No such file or directory

> 'trace' is just 'perf trace', perf has logic to see if argv[0]  is
> 'trace', then it goes and does a 'perf trace'. The above case does't use
> bpf at all, gets details from /proc.
> 
> With bpf we get the 'filename' contents:
> 
> [root@seventh bpf]# trace -e augmented_raw_syscalls.c  --filter-pids 2279,1643
> <SNIP>
>  19766.027 ( 0.003 ms): gcc/27524 openat(dfd: CWD, filename: /lib64/libz.so.1, flags: CLOEXEC           ) = 5
>  19766.035 ( 0.001 ms): gcc/27524 fstat(fd: 5, statbuf: 0x7ffe9323e2a0                                  ) = 0
>  19766.037 ( 0.003 ms): gcc/27524 mmap(len: 2187272, prot: EXEC|READ, flags: PRIVATE|DENYWRITE, fd: 5   ) = 0x7fa2df435000
>  19766.042 ( 0.003 ms): gcc/27524 mprotect(start: 0x7fa2df44b000, len: 2093056                          ) = 0
>  19766.046 ( 0.004 ms): gcc/27524 mmap(addr: 0x7fa2df64a000, len: 4096, prot: READ|WRITE, flags: PRIVATE|FIXED|DENYWRITE, fd: 5, off: 86016) = 0x7fa2df64a000
>  19766.051 ( 0.002 ms): gcc/27524 mmap(addr: 0x7fa2df64b000, len: 8, prot: READ|WRITE, flags: PRIVATE|FIXED|ANONYMOUS) = 0x7fa2df64b000
>  19766.057 ( 0.001 ms): gcc/27524 close(fd: 5                                                           ) = 0
>  19766.062 ( 0.003 ms): gcc/27524 openat(dfd: CWD, filename: /lib64/libc.so.6, flags: CLOEXEC           ) = 5
> <SNIP>

Right; and that is all nice. And exactly doesn't answer my question. Why
do we care about those LOST entries so much that we have to do such
horribly ugly things?

Esp. as you point out, they're clearly marked in the output and easily
avoided by using a slightly larger buffer.
