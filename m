Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752806AbeDRPRV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 11:17:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:50486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751204AbeDRPRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 11:17:20 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B84C62178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Wed, 18 Apr 2018 12:17:16 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
        LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Wang Nan <wangnan0@huawei.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH v2] tracing/x86: Update syscall trace events to handle
 new x86 syscall func names
Message-ID: <20180418151716.GC10084@kernel.org>
References: <20180417130702.01575029@gandalf.local.home>
 <20180417172236.GA17342@light.dominikbrodowski.net>
 <20180417180430.GF3625@kernel.org>
 <20180417181304.GA2895@kernel.org>
 <20180417174128.0f3457f0@gandalf.local.home>
 <20180418125322.GB2895@kernel.org>
 <20180418103606.4118b35f@gandalf.local.home>
 <20180418150212.GA10084@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418150212.GA10084@kernel.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 18, 2018 at 12:02:12PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Apr 18, 2018 at 10:36:06AM -0400, Steven Rostedt escreveu:
> > On Wed, 18 Apr 2018 09:53:22 -0300
> > Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > Em Tue, Apr 17, 2018 at 05:41:28PM -0400, Steven Rostedt escreveu:
> > > > On Tue, 17 Apr 2018 15:13:04 -0300 Arnaldo Carvalho de Melo <acme@kernel.org> wrote:  
> > > > > Yeah, failing:  
> 
> > > > > [root@jouet ~]# strace -e openat -e file perf test -F -v "mmap interface" |& grep syscalls
> > > > > openat(AT_FDCWD, "/sys/kernel/debug/tracing/events/syscalls/sys_enter_getsid/format", O_RDONLY) = 3
> > > > > openat(AT_FDCWD, "/sys/kernel/debug/tracing/events/syscalls/sys_enter_getppid/format", O_RDONLY) = -1 ENOENT (No such file or directory)  
> > >  
> > > > It doesn't have to do with the number of parameters, not everything
> > > > has "__x64" on it.  
> 
> > > > Try this patch:  
> 
> > > Trying...
>  
> > You're keeping me in suspense!
> 
> I switched locations, had trouble reconnecting, those tests are ok now,
> there is just one case left, related to the syscall routines renames,
> but not related to the syscalls:sys_{enter,exit}_NAME tracepoints:
> 40: BPF filter                                            :
> 40.1: Basic BPF filtering                                 : FAILED!
> 40.2: BPF pinning                                         : Skip
> 40.3: BPF prologue generation                             : Skip
> 40.4: BPF relocation checker                              : Skip
> 
> If we use -v for that test we see the problem:
> 
> To the point:
> 
>   Probe point 'SyS_epoll_pwait' not found.
> 
> This is not there anymore, I'll change this test to first figure out
> what is the syscall routine for the epoll_pwait syscall so that it works
> with pre-syscall-routines-rename and after that.

This does the trick, by not using the main syscall routine, but one
called from it and not renamed, should work with older kernels.

This test should be improved to look if the desired routine is in place,
if not just skip the test and tell about the unavailability of the
wanted function, but that is for later.

- Arnaldo

diff --git a/tools/perf/tests/bpf-script-example.c b/tools/perf/tests/bpf-script-example.c
index e4123c1b0e88..1ca5106df5f1 100644
--- a/tools/perf/tests/bpf-script-example.c
+++ b/tools/perf/tests/bpf-script-example.c
@@ -31,7 +31,7 @@ struct bpf_map_def SEC("maps") flip_table = {
 	.max_entries = 1,
 };
 
-SEC("func=SyS_epoll_pwait")
+SEC("func=do_epoll_wait")
 int bpf_func__SyS_epoll_pwait(void *ctx)
 {
 	int ind =0;
