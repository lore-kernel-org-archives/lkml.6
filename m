Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8EDC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF3A20882
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544197767;
	bh=5lUVu2HtgNAccJB5cmQp1y8euTywzPWsqLr/XtUHmNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BFMP/uFPe1FaJK5YZKy12lbsKrXhIG9QarxINNiCm9ptO3X46SGtaZIVT8uZGsTeR
	 txdpMQaJ/75Kgu12sL/V4CANpH4mBibKNC7FgSDgGVtSLibIALfJfGWY277pYJjU3j
	 wkhxCjLxCCsfHjpo3vAd0dKyuQao6NtCibHXl9zA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF3A20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbeLGPtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 10:49:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:55980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbeLGPtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 10:49:25 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB63A20837;
        Fri,  7 Dec 2018 15:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544197764;
        bh=5lUVu2HtgNAccJB5cmQp1y8euTywzPWsqLr/XtUHmNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BSziyQYACg4rd5Yu7Xe4V7mgm9IGDv3ieTOR9VvG8rls0zf7iSBWaQ5JCKLKyyBOe
         t3Leb0JLqz6r5+ZL/zaKjsAuod53KjWRjB/TzGOkUtZ8pitlG2PULJDKKQjtU+6OwA
         3C/Rm/QWoQ6/R00Heh2VeXKvrMrZNz9163lnMZ5w=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 386554042C; Fri,  7 Dec 2018 12:49:21 -0300 (-03)
Date:   Fri, 7 Dec 2018 12:49:21 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luis Claudio R. Goncalves" <lclaudio@uudg.org>, ldv@altlinux.org,
        esyr@redhat.com, Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 1/8] perf: Allow to block process in syscall tracepoints
Message-ID: <20181207154921.GB28174@kernel.org>
References: <20181205160509.1168-1-jolsa@kernel.org>
 <20181205160509.1168-2-jolsa@kernel.org>
 <20181206081028.GE4234@hirez.programming.kicks-ass.net>
 <20181206083400.GA13675@hirez.programming.kicks-ass.net>
 <20181206131946.2c47f556@vmware.local.home>
 <20181207085839.GC2237@hirez.programming.kicks-ass.net>
 <20181207072701.5bc564c7@vmware.local.home>
 <20181207151105.GB5289@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207151105.GB5289@hirez.programming.kicks-ass.net>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 07, 2018 at 04:11:05PM +0100, Peter Zijlstra escreveu:
> On Fri, Dec 07, 2018 at 08:41:18AM -0500, Steven Rostedt wrote:
> > On Fri, 7 Dec 2018 09:58:39 +0100 Peter Zijlstra <peterz@infradead.org> wrote:

> > > These patches give no justification *what*so*ever* for why we're doing
> > > ugly arse things like this. And why does this, whatever this is, need to
> > > be done in perf?

> > > IOW, what problem are we solving ?

> > I guess the cover letter should have had a link (or copy) of this:

> >  http://lkml.kernel.org/r/20181128134700.212ed035@gandalf.local.home

> That doesn't even begin to explain. Who cares about strace and why? And
> why is it such a bad thing to loose the occasional record etc..

The following almost addresses all the details for doing such a perf
based strace tool (modulo signals), was started by Thomas a long time
ago [1] and is in the tree for a long time, with BPF attached to the
raw_syscalls:sys_{enter,exit} (that -e augmented_raw_syscalls.c thing
that lives in tools/perf/examples/bpf now but would be put in place
transparently and pre-compiled as augmented_raw_syscalls.o) to collect
pointer contents without using ptrace:

[root@seventh bpf]# perf trace --no-inherit -e augmented_raw_syscalls.c sleep 1
     0.019 ( 0.001 ms): brk(                                                                  ) = 0x559ca9dd7000
     0.031 ( 0.004 ms): access(filename: , mode: R                                            ) = -1 ENOENT No such file or directory
     0.039 ( 0.003 ms): openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC           ) = 3
     0.043 ( 0.002 ms): fstat(fd: 3, statbuf: 0x7ffdfa50e940                                  ) = 0
     0.045 ( 0.003 ms): mmap(len: 103484, prot: READ, flags: PRIVATE, fd: 3                   ) = 0x7fa76b2ce000
     0.049 ( 0.001 ms): close(fd: 3                                                           ) = 0
     0.056 ( 0.003 ms): openat(dfd: CWD, filename: /lib64/libc.so.6, flags: CLOEXEC           ) = 3
     0.060 ( 0.002 ms): read(fd: 3, buf: 0x7ffdfa50eb08, count: 832                           ) = 832
     0.063 ( 0.001 ms): fstat(fd: 3, statbuf: 0x7ffdfa50e9a0                                  ) = 0
     0.065 ( 0.002 ms): mmap(len: 8192, prot: READ|WRITE, flags: PRIVATE|ANONYMOUS            ) = 0x7fa76b2cc000
     0.070 ( 0.003 ms): mmap(len: 3889792, prot: EXEC|READ, flags: PRIVATE|DENYWRITE, fd: 3   ) = 0x7fa76ad0e000
     0.075 ( 0.005 ms): mprotect(start: 0x7fa76aebb000, len: 2093056                          ) = 0
     0.081 ( 0.005 ms): mmap(addr: 0x7fa76b0ba000, len: 24576, prot: READ|WRITE, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 1753088) = 0x7fa76b0ba000
     0.089 ( 0.002 ms): mmap(addr: 0x7fa76b0c0000, len: 14976, prot: READ|WRITE, flags: PRIVATE|FIXED|ANONYMOUS) = 0x7fa76b0c0000
     0.095 ( 0.001 ms): close(fd: 3                                                           ) = 0
     0.105 ( 0.001 ms): arch_prctl(option: 4098, arg2: 140357034366208                        ) = 0
     0.144 ( 0.004 ms): mprotect(start: 0x7fa76b0ba000, len: 16384, prot: READ                ) = 0
     0.159 ( 0.002 ms): mprotect(start: 0x559ca81aa000, len: 4096, prot: READ                 ) = 0
     0.163 ( 0.002 ms): mprotect(start: 0x7fa76b2e8000, len: 4096, prot: READ                 ) = 0
     0.167 ( 0.008 ms): munmap(addr: 0x7fa76b2ce000, len: 103484                              ) = 0
     0.218 ( 0.001 ms): brk(                                                                  ) = 0x559ca9dd7000
     0.220 ( 0.002 ms): brk(brk: 0x559ca9df8000                                               ) = 0x559ca9df8000
     0.224 ( 0.001 ms): brk(                                                                  ) = 0x559ca9df8000
     0.228 ( 0.004 ms): open(filename: /usr/lib/locale/locale-archive, flags: CLOEXEC         ) = 3
     0.233 ( 0.001 ms): fstat(fd: 3, statbuf: 0x7fa76b0bfaa0                                  ) = 0
     0.235 ( 0.003 ms): mmap(len: 113045344, prot: READ, flags: PRIVATE, fd: 3                ) = 0x7fa76413f000
     0.241 ( 0.001 ms): close(fd: 3                                                           ) = 0
     0.264 (1000.163 ms): nanosleep(rqtp: 0x7ffdfa50f680                                        ) = 0
  1000.440 ( 0.002 ms): close(fd: 1                                                           ) = 0
  1000.443 ( 0.001 ms): close(fd: 2                                                           ) = 0
  1000.449 (         ): exit_group(                                                           )
[root@seventh bpf]#

doing just:

   # perf trace --filter-pids pid-of-your-local-xterm,gnome-shell-pid-for-your-term

For system wide stracing elliminating the feedback loop of your GUI
components will most of the time work with the default ring buffer size
and when it doesn't, you'll get things like that "LOST events!" message,
and for such extreme cases, just use '-m' to bump the rb size some more.

# trace  --filter-pids 2279,1643
<SNIP>
  8793.387 ( 0.003 ms): cc1/19097 openat(dfd: CWD, filename: 0x3df9940, flags: NOCTTY                   ) = 21
  8793.390 ( 0.001 ms): cc1/19097 fstat(fd: 21, statbuf: 0x3df9648                                      ) = 0
  8793.394 ( 0.003 ms): cc1/19097 read(fd: 21, buf: 0x3d6e0f0, count: 5804                              ) = 5804
  8793.398 ( 0.001 ms): cc1/19097 close(fd: 21                                                          ) = 0
  8793.403 ( 0.002 ms): cc1/19097 openat(dfd: CWD, filename: 0x3dfca70, flags: NOCTTY                   ) = -1 ENOENT No such file or directory
  8793.406 ( 0.001 ms): cc1/19097 openat(dfd: CWD, filename: 0x3dfca70, flags: NOCTTY                   ) = -1 ENOENT No such file or directory
  8793.409 ( 0.002 ms): cc1/19097 openat(dfd: CWD, filename: 0x3dfca70, flags: NOCTTY                   ) = 21
  8793.412 ( 0.001 ms): cc1/19097 fstat(fd: 21, statbuf: 0x3df9738                                      ) = 0
  8793.414 ( 0.022 ms): cc1/19097 read(fd: 21, buf: 0x3eb6d90, count: 25315                             ) = 25315
  8793.437 ( 0.001 ms): cc1/19097 close(fd: 21                                                          ) = 0
  8793.605 ( 0.005 ms): cc1/19097 openat(dfd: CWD, filename: 0x3dfca70                                  ) = 21
  8793.614 ( 0.001 ms): cc1/19097 close(fd: 5                                                           ) = 0
  8793.618 ( 0.001 ms): cc1/19097 fstat(fd: 21, statbuf: 0x7ffd653ed380                                 ) = 0
  8793.621 ( 0.002 ms): cc1/19097 read(fd: 21, buf: 0x3d41e30, count: 8192                              ) = 8192
  8793.626 ( 0.002 ms): cc1/19097 read(fd: 21, buf: 0x3ebf090, count: 8192                              ) = 8192
  8793.635 ( 0.003 ms): cc1/19097 read(fd: 21, buf: 0x3ed4730, count: 16384                             ) = 8931
  8793.640 ( 0.001 ms): cc1/19097 read(fd: 21, buf: 0x3ed6a13, count: 4096                              ) = 0
LOST 34956 events!
  9497.921 ( 0.006 ms): gcc/19180 openat(dfd: CWD, filename: 0x3115e20, flags: NOCTTY                   ) = -1 ENOENT No such file or directory
  9497.935 ( 0.002 ms): gcc/19180 openat(dfd: CWD, filename: 0x3115e20, flags: NOCTTY                   ) = -1 ENOENT No such file or directory
  9497.939 ( 0.003 ms): gcc/19180 openat(dfd: CWD, filename: 0x3115e20, flags: NOCTTY                   ) = 9
  9497.943 ( 0.001 ms): gcc/19180 fstat(fd: 9</home/acme/git/linux/include/linux/page_ref.h>, statbuf: 0x3153568) = 0
  9497.945 ( 0.006 ms): gcc/19180 read(fd: 9</home/acme/git/linux/include/linux/page_ref.h>, buf: 0x31c00a0, count: 40574) = 40574
  9497.952 ( 0.001 ms): gcc/19180 close(fd: 9</home/acme/git/linux/include/linux/page_ref.h>            ) = 0
  9497.959 ( 0.002 ms): gcc/19180 openat(dfd: CWD, filename: 0x31540a0, flags: NOCTTY                   ) = -1 ENOENT No such file or directory
  9497.962 ( 0.002 ms): gcc/19180 openat(dfd: CWD, filename: 0x31540a0, flags: NOCTTY                   ) = -1 ENOENT No such file or directory
  9497.965 ( 0.002 ms): gcc/19180 openat(dfd: CWD, filename: 0x31540a0, flags: NOCTTY                   ) = 9
  9497.969 ( 0.001 ms): gcc/19180 fstat(fd: 9</home/acme/git/linux/include/linux/page_ref.h>, statbuf: 0x30dcf38) = 0
  9497.970 ( 0.003 ms): gcc/19180 read(fd: 9</home/acme/git/linux/include/linux/page_ref.h>, buf: 0x31b8320, count: 23058) = 23058
  9497.975 ( 0.001 ms): gcc/19180 close(fd: 9</home/acme/git/linux/include/linux/page_ref.h>            ) = 0
  9497.979 ( 0.002 ms): gcc/19180 openat(dfd: CWD, filename: 0x3154020, flags: NOCTTY                   ) = -1 ENOENT No such file or directory
  9497.982 ( 0.002 ms): gcc/19180 openat(dfd: CWD, filename: 0x3154020, flags: NOCTTY                   ) = -1 ENOENT No such file or directory
  9497.986 ( 0.002 ms): gcc/19180 openat(dfd: CWD, filename: 0x3154020, flags: NOCTTY                   ) = 9
  9497.989 ( 0.001 ms): gcc/19180 fstat(fd: 9</home/acme/git/linux/include/linux/page_ref.h>, statbuf: 0x3116178) = 0
  9497.990 ( 0.001 ms): gcc/19180 read(fd: 9</home/acme/git/linux/include/linux/page_ref.h>, buf: 0x31509c0, count: 1948) = 1948
  9497.993 ( 0.001 ms): gcc/19180 close(fd: 9</home/acme/git/linux/include/linux/page_ref.h>            ) = 0
  9498.039 ( 0.003 ms): gcc/19180 openat(dfd: CWD, filename: 0x3154060, flags: NOCTTY                   ) = -1 ENOENT No such file or directory
  9498.043 ( 0.002 ms): gcc/19180 openat(dfd: CWD, filename: 0x3154060, flags: NOCTTY                   ) = -1 ENOENT No such file or directory
  9498.046 ( 0.002 ms): gcc/19180 openat(dfd: CWD, filename: 0x3154060, flags: NOCTTY                   ) = 9
  9498.049 ( 0.001 ms): gcc/19180 fstat(fd: 9</home/acme/git/linux/include/linux/page_ref.h>, statbuf: 0x3153a08) = 0

'trace' is just 'perf trace', perf has logic to see if argv[0]  is
'trace', then it goes and does a 'perf trace'. The above case does't use
bpf at all, gets details from /proc.

With bpf we get the 'filename' contents:

[root@seventh bpf]# trace -e augmented_raw_syscalls.c  --filter-pids 2279,1643
<SNIP>
 19766.027 ( 0.003 ms): gcc/27524 openat(dfd: CWD, filename: /lib64/libz.so.1, flags: CLOEXEC           ) = 5
 19766.035 ( 0.001 ms): gcc/27524 fstat(fd: 5, statbuf: 0x7ffe9323e2a0                                  ) = 0
 19766.037 ( 0.003 ms): gcc/27524 mmap(len: 2187272, prot: EXEC|READ, flags: PRIVATE|DENYWRITE, fd: 5   ) = 0x7fa2df435000
 19766.042 ( 0.003 ms): gcc/27524 mprotect(start: 0x7fa2df44b000, len: 2093056                          ) = 0
 19766.046 ( 0.004 ms): gcc/27524 mmap(addr: 0x7fa2df64a000, len: 4096, prot: READ|WRITE, flags: PRIVATE|FIXED|DENYWRITE, fd: 5, off: 86016) = 0x7fa2df64a000
 19766.051 ( 0.002 ms): gcc/27524 mmap(addr: 0x7fa2df64b000, len: 8, prot: READ|WRITE, flags: PRIVATE|FIXED|ANONYMOUS) = 0x7fa2df64b000
 19766.057 ( 0.001 ms): gcc/27524 close(fd: 5                                                           ) = 0
 19766.062 ( 0.003 ms): gcc/27524 openat(dfd: CWD, filename: /lib64/libc.so.6, flags: CLOEXEC           ) = 5
<SNIP>

- Arnaldo

[1] https://lwn.net/Articles/415728/
