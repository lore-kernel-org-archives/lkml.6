Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752503AbeDQR3r (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 13:29:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:36020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751230AbeDQR3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 13:29:46 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63E1C2175C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Tue, 17 Apr 2018 14:29:40 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH v2] tracing/x86: Update syscall trace events to handle
 new x86 syscall func names
Message-ID: <20180417172940.GA3625@kernel.org>
References: <20180417130702.01575029@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417130702.01575029@gandalf.local.home>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 17, 2018 at 01:07:02PM -0400, Steven Rostedt escreveu:
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
> Because the x86 system calls had "__x64_" appended to the "sys" for the
> names, they do not match the default compare algorithm. As this was a
> problem for power pc, the algorithm can be overwritten by the architecture.
> The solution is to have x86 have its own algorithm to do the compare and
> this brings back the system call trace events.
> 
> Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Fixes: d5a00528b58c ("syscalls/core, syscalls/x86: Rename struct pt_regs-based sys_*() to __x64_sys_*()")
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Again on x86_64, the number of files in
/sys/kernel/debug/tracing/events/syscalls/ is the same, all my perf
related tests pass.

Now to the next seemingly kernel related test failure, unrelated to
this:

 4: Read samples using the mmap interface                 : FAILED!

- Arnaldo
