Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751913AbeCVVsX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 17:48:23 -0400
Received: from mail.efficios.com ([167.114.142.138]:50880 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751868AbeCVVsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 17:48:21 -0400
Date: Thu, 22 Mar 2018 17:48:17 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Erica Bugden <ebugden@efficios.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1443383811.3019.1521755297202.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180316165239.GA28462@redhat.com>
References: <670124481.11073.1521146881571.JavaMail.zimbra@efficios.com> <20180316165239.GA28462@redhat.com>
Subject: Re: uprobes misses breakpoint insertion into VM_WRITE mappings
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.7_GA_1964 (ZimbraWebClient - FF52 (Linux)/8.8.7_GA_1964)
Thread-Topic: uprobes misses breakpoint insertion into VM_WRITE mappings
Thread-Index: WGEkbW6SzmhtL2I3iv/QF00BGA6WWg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Mar 16, 2018, at 12:52 PM, Oleg Nesterov oleg@redhat.com wrote:

> On 03/15, Mathieu Desnoyers wrote:
>>
>> Hi,
>>
>> Erica has been working on extending test-cases for uprobes, and found
>> something unexpected:
>>
>> Since commit e40cfce626a5 "uprobes: Restrict valid_vma(false) to skip VM_SHARED
>> vmas"
>> uprobes does not insert breakpoints into mappings mprotect'd as writeable.
> 
> Not really, VM_WRITE was illegal from the very beginning, this commit only
> affects the "is_register == false" case.

Good point. I only noticed it after further archeology research through git blame. ;)

> 
>> This issue can be reproduced by compiling a library without PIC (not using GOT),
>> and then concurrently:
>>
>> A) Load the library (dynamic loader mprotect the code as writeable to do
>>    the relocations, and then mprotect as executable),
>>
>> B) Enable a uprobe through perf.
>>
>> (it is a race window between the two mprotect syscalls)
>>
>> It appears that the following restriction in valid_vma() is responsible
>> for this behavior:
>>
>>         if (is_register)
>>                 flags |= VM_WRITE;
>>
>> I don't figure a clear explanation for this flag based on the function
>> comment nor the commit changelog. Any idea on whether this is really
>> needed ?
> 
> Because we do not want to modify the writable area. If nothing else, this
> can break the application which writes to the page we are going to replace.

I fully agree on never poking writeable pages. However, I think something is
missing here.

The plausible scenario that's inherently racy is:

1) dynamic loader mprotect(write) the mapping,
2) dynamic loader performs relocations
3) (concurrently) uprobe is enabled for this mapping
4) dynamic loader mprotect(read|exec) the mapping.

Again, I fully agree that step (3) should *not* touch the mapping while it is
writeable, because there is no way to synchronize the the application which is
expecting to be sole owner of the code being modified.

However, what I think is missing here is that step (4) (mprotect(read|exec))
should apply all "pending" modifications for that mapping.

This means that if some code is always writeable, uprobes will not
mess with it. However, if the pattern is to make it writeable for a short
while and then make it read|exec again, then the queued modifications
could be applied by mprotect().

What is not entirely clear to me is how to bound the number of pending
modifications and where to these pending uprobes operation queues should
reside.

Thoughts ?

Thanks,

Mathieu


> 
>> Note that on uprobes unregister, it allows removing a breakpoint event
>> on a writeable mapping,
> 
> Yes. Because a probed apllication can do mprotect() after the kernel installs
> the breakpoint. And we have to remove this breakpoint in any case, even if
> this is unsafe too.
> 
> Oleg.

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
