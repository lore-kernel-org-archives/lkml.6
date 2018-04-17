Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752570AbeDQR4v (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 13:56:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:39830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751157AbeDQR4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 13:56:50 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD1CD20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Tue, 17 Apr 2018 14:56:47 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH v2] tracing/x86: Update syscall trace events to handle
 new x86 syscall func names
Message-ID: <20180417175647.GE3625@kernel.org>
References: <20180417130702.01575029@gandalf.local.home>
 <20180417172940.GA3625@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417172940.GA3625@kernel.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 17, 2018 at 02:29:40PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Apr 17, 2018 at 01:07:02PM -0400, Steven Rostedt escreveu:
> > Because the x86 system calls had "__x64_" appended to the "sys" for the
> > names, they do not match the default compare algorithm. As this was a
> > problem for power pc, the algorithm can be overwritten by the architecture.
> > The solution is to have x86 have its own algorithm to do the compare and
> > this brings back the system call trace events.

> > Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Fixes: d5a00528b58c ("syscalls/core, syscalls/x86: Rename struct pt_regs-based sys_*() to __x64_sys_*()")
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
 
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
 
> Again on x86_64, the number of files in
> /sys/kernel/debug/tracing/events/syscalls/ is the same, all my perf
> related tests pass.
> 
> Now to the next seemingly kernel related test failure, unrelated to
> this:
> 
>  4: Read samples using the mmap interface                 : FAILED!

Ok, I take that back, it is related:

[root@jouet perf]# perf test -F -v "mmap interface" |& grep -v plugins
 4: Read samples using the mmap interface                 :
--- start ---
perf_evsel__new(sys_enter_getppid)
---- end ----
Read samples using the mmap interface: FAILED!
[root@jouet perf]#

[root@jouet perf]# strace -e openat -e file perf test -F -v "mmap interface" |& grep syscalls
openat(AT_FDCWD, "/sys/kernel/debug/tracing/events/syscalls/sys_enter_getsid/format", O_RDONLY) = 3
openat(AT_FDCWD, "/sys/kernel/debug/tracing/events/syscalls/sys_enter_getppid/format", O_RDONLY) = -1 ENOENT (No such file or directory)
[root@jouet perf]#

Where did syscalls:sys_enter_getppid go? Zero argument syscall,
investigating...

- Arnaldo
