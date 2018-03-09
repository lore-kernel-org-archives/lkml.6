Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932209AbeCIPPa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 10:15:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:46354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932178AbeCIPP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 10:15:26 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA26D20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Sat, 10 Mar 2018 00:15:22 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Francis Deslauriers <francis.deslauriers@efficios.com>
Cc: tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] x86/kprobes: Prohibit probing of .entry_trampoline
 code
Message-Id: <20180310001522.5b81074c7c7ec24cfb5f0a06@kernel.org>
In-Reply-To: <1520565492-4637-1-git-send-email-francis.deslauriers@efficios.com>
References: <1520565492-4637-1-git-send-email-francis.deslauriers@efficios.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  8 Mar 2018 22:18:11 -0500
Francis Deslauriers <francis.deslauriers@efficios.com> wrote:

> Hi all,
> 
> While fuzzing the Perf kprobe interface, I found that adding a probe on
> the 'entry_SYSCALL_64_trampoline' symbol will crash my 4.16-rc4
> kernel(661e50bc853209e41a5c14a290ca4decc43cbfd1) on a x86_64 Qemu VM.
> 
> How to reproduce:
> 	echo 'p:event1 entry_SYSCALL_64_trampoline' > ./kprobe_events
> 	echo 1 >  events/kprobes/enable
> Crash log:[1]
> 
> My understanding is that the userspace CR3 register has not yet been
> replaced by the kernel's CR3, when the kprobe is triggered. This means
> that the kernel addresses can not be translated, thus making the
> handling of the kprobe impossible.

Thanks for reporting!
And yes, all entry code must be nokprobe.

> 
> This can be fixed by blacklisting the .entry_trampoline section. See
> patch[1/1].
> 
> Here is the config I am using[2].
> 
> Thanks,
> 
> Francis Deslauriers
> EfficiOS inc.
> 
> 1:http://paste.ubuntu.com/p/djnpZCzQKv/
> 2:http://paste.ubuntu.com/p/3jrFYt6XQB/
> 
> Francis Deslauriers (1):
>   x86/kprobes: Prohibit probing of .entry_trampoline code
> 
>  arch/x86/include/asm/sections.h |  1 +
>  arch/x86/kernel/kprobes/core.c  | 10 +++++++++-
>  arch/x86/kernel/vmlinux.lds.S   |  2 ++
>  3 files changed, 12 insertions(+), 1 deletion(-)
> 
> -- 
> 2.7.4
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
