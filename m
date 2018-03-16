Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753523AbeCPQwn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 12:52:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36240 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751448AbeCPQwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 12:52:41 -0400
Date: Fri, 16 Mar 2018 17:52:39 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Erica Bugden <ebugden@efficios.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: uprobes misses breakpoint insertion into VM_WRITE mappings
Message-ID: <20180316165239.GA28462@redhat.com>
References: <670124481.11073.1521146881571.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <670124481.11073.1521146881571.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/15, Mathieu Desnoyers wrote:
>
> Hi,
>
> Erica has been working on extending test-cases for uprobes, and found
> something unexpected:
>
> Since commit e40cfce626a5 "uprobes: Restrict valid_vma(false) to skip VM_SHARED vmas"
> uprobes does not insert breakpoints into mappings mprotect'd as writeable.

Not really, VM_WRITE was illegal from the very beginning, this commit only
affects the "is_register == false" case.

> This issue can be reproduced by compiling a library without PIC (not using GOT),
> and then concurrently:
>
> A) Load the library (dynamic loader mprotect the code as writeable to do
>    the relocations, and then mprotect as executable),
>
> B) Enable a uprobe through perf.
>
> (it is a race window between the two mprotect syscalls)
>
> It appears that the following restriction in valid_vma() is responsible
> for this behavior:
>
>         if (is_register)
>                 flags |= VM_WRITE;
>
> I don't figure a clear explanation for this flag based on the function
> comment nor the commit changelog. Any idea on whether this is really
> needed ?

Because we do not want to modify the writable area. If nothing else, this
can break the application which writes to the page we are going to replace.

> Note that on uprobes unregister, it allows removing a breakpoint event
> on a writeable mapping,

Yes. Because a probed apllication can do mprotect() after the kernel installs
the breakpoint. And we have to remove this breakpoint in any case, even if
this is unsafe too.

Oleg.
