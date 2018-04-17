Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755237AbeDQQfc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 12:35:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:56036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754093AbeDQQfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 12:35:31 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B16021838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Tue, 17 Apr 2018 13:35:27 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH] tracing/x86: Update syscall trace events to handle new
 x86 syscall func names
Message-ID: <20180417163527.GA7775@kernel.org>
References: <20180417115440.2145f7f5@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417115440.2145f7f5@gandalf.local.home>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 17, 2018 at 11:54:40AM -0400, Steven Rostedt escreveu:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Arnaldo noticed that the latest kernel is missing the syscall event system
> directory in x86. I bisected it down to d5a00528b58c ("syscalls/core,
> syscalls/x86: Rename struct pt_regs-based sys_*() to __x64_sys_*()").
> 
> The system call trace events are special, as there is only one trace event
> for all system calls (the raw_syscalls). But a macro that wraps the system
> calls creates meta data for them that copies the name to find the system
> call that maps to the system call table (the number). At boot up, it does a
> kallsyms lookup for this mapping. If it does not find a function, then that
> system call is ignored.
> 
> Because the x86 system calls had "__x86_" appended to the "sys" for the
> names, they do not match the default compare algorithm. As this was a
> problem for power pc, the algorithm can be overwritten by the architecture.
> The solution is to have x86 have its own algorithm to do the compare and
> this brings back the system call trace events.
> 
> Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Fixes: d5a00528b58c ("syscalls/core, syscalls/x86: Rename struct pt_regs-based sys_*() to __x64_sys_*()")
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

[root@jouet ~]# perf test openat
 2: Detect openat syscall event                           : Ok
 3: Detect openat syscall event on all cpus               : Ok
15: syscalls:sys_enter_openat event fields                : Ok
[root@jouet ~]#

[root@jouet ~]# perf trace -e nanosleep,syscalls:*nanosleep sleep 1
     0.000 (         ): syscalls:sys_enter_nanosleep:rqtp: 0x7ffd9f737950, rmtp: 0x00000000
     0.009 (         ): sleep/7905 nanosleep(rqtp: 0x7ffd9f737950                                        ) ...
  1000.204 (         ): syscalls:sys_exit_nanosleep:0x0
     0.009 (1000.217 ms): sleep/7905  ... [continued]: nanosleep()) = 0
[root@jouet ~]#

Works, so the regression seems to be fixed, without looking at the code
that much:

Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
