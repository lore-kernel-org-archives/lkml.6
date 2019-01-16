Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE19C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F92C20859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547632862;
	bh=onuC8TK2HozgzSnWsYqVjLyuRTILoz83QJhiMUDneEI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=dY+/N88IzDMOHzA6TPvXIZyoYtzLXh27YHkGbD5p6NEExNPy6rol33yKcm38c1spq
	 3yzJANfyWto6EGNYjVvKjlMGtB/Sm9dS87cdZGSBTDzsY1J0rSvPquCkuWn2Iisgzv
	 6NYViytXefDEC2Mu5ZnGT+jW9INXoJ6MjMVyWL/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731628AbfAPKBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:01:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:60534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729836AbfAPKA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 05:00:59 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C5C52082F;
        Wed, 16 Jan 2019 10:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547632858;
        bh=onuC8TK2HozgzSnWsYqVjLyuRTILoz83QJhiMUDneEI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=miYE7zmecT1WX73SwCtHB1fpbg82mTXq0zIAN81ubaGLTNrU4buRBpnA2xzVjL3RB
         atIYe6u9PUxQZX8OEz6xp2wAc8SLrl+05MmFCx207iICsYJm//Km+HQx3kTC09cvlh
         YKCMAKNl2lnnYDcYtOqJpTjIkuLqh6KBE+RweJ1Y=
Date:   Wed, 16 Jan 2019 19:00:54 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andreas Ziegler <andreas.ziegler@fau.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: uprobes: bug in comm/string output?
Message-Id: <20190116190054.ac22c8495540578834446236@kernel.org>
In-Reply-To: <8b67136d-28d7-a734-6366-9511e30d66a7@fau.de>
References: <bf358673-ceb2-65bf-80c9-4b1c09a8a264@fau.de>
        <8b67136d-28d7-a734-6366-9511e30d66a7@fau.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2019 14:36:48 +0100
Andreas Ziegler <andreas.ziegler@fau.de> wrote:

> Hi again,
> 
> On 1/14/19 1:38 PM, Andreas Ziegler wrote:
> > Hi,
> > 
> > I've been playing around with uprobes today and found the following weird behaviour/output when using more than one string argument (or using the $comm argument). This was run on a v4.20 mainline build on Ubuntu 18.04.
> > 
> > root@ubuntu1810:~# uname -a
> > Linux ubuntu1810 4.20.0-042000-generic #201812232030 SMP Mon Dec 24 01:32:58 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux
> > 
> > I'm trying to track calls to dlopen so I'm looking up the correct offset in libdl.so:
> > 
> > root@ubuntu1810:/sys/kernel/debug/tracing# readelf -s /lib/x86_64-linux-gnu/libdl-2.28.so | grep dlopen
> >     34: 00000000000012a0   133 FUNC    GLOBAL DEFAULT   14 dlopen@@GLIBC_2.2.5
> > 
> > Then I'm creating a uprobe with two prints of $comm and two prints of the first argument to dlopen, and enable that probe. The '/root/test' program only does a dlopen("libc.so.6", RTLD_LAZY) in main().
> > 
> > root@ubuntu1810:/sys/kernel/debug/tracing# echo 'p:dlopen /lib/x86_64-linux-gnu/libdl-2.28.so:0x12a0 $comm $comm +0(%di):string +0(%di):string' > uprobe_events
> > root@ubuntu1810:/sys/kernel/debug/tracing# echo 1 > events/uprobes/dlopen/enable
> > root@ubuntu1810:/sys/kernel/debug/tracing# /root/test
> > 
> > The trace output looks like this:
> > 
> > root@ubuntu1810:/sys/kernel/debug/tracing# cat trace
> > # tracer: nop
> > #
> > #                              _-----=> irqs-off
> > #                             / _----=> need-resched
> > #                            | / _---=> hardirq/softirq
> > #                            || / _--=> preempt-depth
> > #                            ||| /     delay
> > #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> > #              | |       |   ||||       |         |
> >             test-1617  [000] d...  1237.959168: dlopen: (0x7fbd5272e2a0) arg1=(fault) arg2=(fault) arg3="libc.so.6libc.so.6" arg4="libc.so.6" 
> > 
> > That's very weird for two reasons:
> > - fetching $comm seems to fail with an invalid pointer
> > - arg3 contains the text twice (if I add another print of the argument, arg3 will contain the wanted string three times, arg4 two times and the last argument will contain it once). 
> 
> at least for the second problem I think I found the answer, and for the 
> first problem I have a suspicion (see last paragraph for that).

OK, this looks broken. Thank you very much for reporting it!

BTW, I tried to reproduce it with kprobe event, but it seems working well. e.g.

 # echo 'p ksys_chdir $comm $comm +0(%di):string +0(%di):string' > kprobe_events 
 # echo 1 > events/kprobes/enable
 # cd /sys/kernel/debug/tracing
 # cat trace
              sh-812   [003] ...1   229.344360: p_ksys_chdir_0: (ksys_chdir+0x0/0xc0) arg1="sh" arg2="sh" arg3="/sys/kernel/debug/tracing" arg4="/sys/kernel/debug/tracing"

So, it might be an issue on uprobe_event.

> 
> For this, I installed a uprobe for libdl.so/dlopen once again, the 
> command would be
> 
> 'p:dlopen /lib/x86_64-linux-gnu/libdl-2.28.so:0x12a0 $comm $comm'
> 
> so it should print the process name twice (using a kernel v4.18 on 
> Ubuntu 18.10).
> 
> The code which prints the collected data (print_type_string, defined by 
> PRINT_TYPE_FUNC_NAME(string) in kernel/trace/trace_probe.c) is the 
> following, it simply passes the respective data to trace_seq_printf with 
> a "%s" format string:
> 
> int PRINT_TYPE_FUNC_NAME(string)(struct trace_seq *s, void *data, void *ent)
> {
>          int len = *(u32 *)data >> 16;
> 
>          if (!len)
>                  trace_seq_puts(s, "(fault)");
>          else
>                  trace_seq_printf(s, "\"%s\"",
>                                   (const char *)get_loc_data(data, ent));
>          return !trace_seq_has_overflowed(s);
> }
> 
> I dug into that function with KGDB and found the following: 'data' holds 
> the size and offset for the member in question, which is 0xf and 0x18, 
> respectively. 'ent' holds the base address for event. When we print the 
> string at ent + 0x18, we can see that the output for 'arg1' will be 
> "update-notifierupdate-notifier"
> 
> Thread 511 hit Breakpoint 6, print_type_string (s=0xffff880078fd1090, 
> name=0xffff880078fe4458 "arg1", data=0xffff88007d01f05c, 
> ent=0xffff88007d01f04c) at 
> /build/linux-EsXT4r/linux-4.18.0/kernel/trace/trace_probe.c:67
> 67	in /build/linux-EsXT4r/linux-4.18.0/kernel/trace/trace_probe.c
> gdb$ p *(uint32_t *) data
> $46 = 0xf0018
> gdb$ p ent
> $47 = (void *) 0xffff88007d01f04c
> gdb$ p ((char *)ent + 0x18)
> $48 = 0xffff88007d01f064 "update-notifierupdate-notifier"
> 
> Moving on printing 'arg2' (e.g., the other $comm string). Here we see 
> that the string in question is at offset 0x27, and if we print that, we 
> see the correct "update-notifier".
> 
> Thread 511 hit Breakpoint 6, print_type_string (s=0xffff880078fd1090, 
> name=0xffff880078fe4d70 "arg2", data=0xffff88007d01f060, 
> ent=0xffff88007d01f04c) at 
> /build/linux-EsXT4r/linux-4.18.0/kernel/trace/trace_probe.c:67
> 67	in /build/linux-EsXT4r/linux-4.18.0/kernel/trace/trace_probe.c
> gdb$ p *(uint32_t *) data
> $49 = 0xf0027
> gdb$ p ((char *)ent + 0x27)
> $50 = 0xffff88007d01f073 "update-notifier"
> 
> Looking at the bytes in memory and the offsets it becomes clear that 
> there is no \0 byte at the end of the first entry (which would need to 
> be at address 0xffff88007d01f064 + 0xf = 0xffff88007d01f073 but instead 
> that's the start address of the second entry which simply gets consumed 
> by the (first) "%s" as well.
> 
> gdb$ x/32x ent
> 0xffff88007d01f04c:	0x00010592	0x00002143	0xe83522a0	0x00007f7f
> 0xffff88007d01f05c:	0x000f0018	0x000f0027	0x61647075	0x6e2d6574
> 0xffff88007d01f06c:	0x6669746f	0x75726569	0x74616470	0x6f6e2d65
> 0xffff88007d01f07c:	0x69666974	0x00007265	0x0045feee	0x00010592
> 0xffff88007d01f08c:	0x00002143	0xe83522a0	0x00007f7f	0x000f0018
> 0xffff88007d01f09c:	0x000f0027	0x61647075	0x6e2d6574	0x6669746f
> 0xffff88007d01f0ac:	0x75726569	0x74616470	0x6f6e2d65	0x69666974
> 0xffff88007d01f0bc:	0x00007265	0x0038806e	0x00010592	0x00002143
> 
> Should we simply also store the terminating \0 at the end of the string? 
> The $comm string is saved by fetch_comm_string (in v4.18) which uses 
> 'strlcpy' and its return value as the size of the respective data... 
> that value however does NOT include the terminating \0 byte (as it's 
> simply the return value of a call to strlen). The same holds for 
> "regular" string arguments where the code uses 'strncpy_from_user' which 
> has the same return value semantics. Or should we use the information in 
> 'len' to only print that many characters?
> 
> As fetch_store_string has changed between v4.18 and v4.20, I could try 
> to reproduce this with a v4.20 kernel but from looking at the code I 
> suspect this should be the problem in v4.20 as well.
> 
> As for $comm only printing "(fault)" I suspect this has to do with 
> commit 533059281ee5 ("tracing: probeevent: Introduce new argument 
> fetching code") as we lost the 'fetch_comm_string' function in that 
> commit and (I think, didn't have the newer kernel running yet) go 
> through 'fetch_store_string' now. This calls 'strncpy_from_user' instead 
> of accessing current->comm directly (and thus does not succeed in 
> fetching it). I'm adding Masami to Cc: as the author of said patch.

Ah, OK. I have to check fetch_store_string() implementation differences
between trace_kprobe.c and trace_uprobe.c. Well, in the uprobes, we may
need more careful steps.

Anyway, that is my fault. I will fix the issue. Hmm, and I may need to
consider to add some test program for uprobes, which including a target
application to be probed.

Thank you!

-- 
Masami Hiramatsu <mhiramat@kernel.org>
