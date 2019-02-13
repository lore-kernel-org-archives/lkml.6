Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8C3C4151A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B50EA2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392485AbfBMPlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:41:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:59942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732059AbfBMPlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 10:41:47 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 587AC20700;
        Wed, 13 Feb 2019 15:41:45 +0000 (UTC)
Date:   Wed, 13 Feb 2019 10:41:43 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] kprobe: safely access memory specified by userspace
Message-ID: <20190213104143.5c390b28@gandalf.local.home>
In-Reply-To: <20190213143638.y54hghilbyastlpo@mail.google.com>
References: <20190125151051.7381-1-changbin.du@gmail.com>
        <20190213143638.y54hghilbyastlpo@mail.google.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019 22:36:40 +0800
Changbin Du <changbin.du@gmail.com> wrote:

> Hi Steven,
> I think this is a critical issue. Could you give priority to this fix?
> 
> On Fri, Jan 25, 2019 at 11:10:50PM +0800, Changbin Du wrote:
> > The userspace can ask kprobe to intercept strings at any memory address,
> > including invalid kernel address. In this case, fetch_store_strlen()
> > would crash since it uses general usercopy function.
> > 
> > For example, we can crash the kernel by doing something as below:
> > 
> > $ sudo kprobe 'p:do_sys_open +0(+0(%si)):string'

Note, I'm not able to reproduce this.

I just get:

        sendmail-1085  [001] ....   277.344573: open: (do_sys_open+0x0/0x210) arg1=(fault)
           <...>-1550  [003] ....   279.879011: open: (do_sys_open+0x0/0x210) arg1=(fault)
           <...>-1550  [003] ....   279.879056: open: (do_sys_open+0x0/0x210) arg1=(fault)
           <...>-1550  [003] ....   279.879079: open: (do_sys_open+0x0/0x210) arg1=(fault)
           <...>-1550  [003] ....   279.879132: open: (do_sys_open+0x0/0x210) arg1=(fault)
           <...>-1550  [003] ....   279.879683: open: (do_sys_open+0x0/0x210) arg1=(fault)
           <...>-1550  [003] ....   279.881521: open: (do_sys_open+0x0/0x210) arg1=(fault)
           <...>-1550  [003] ....   279.881541: open: (do_sys_open+0x0/0x210) arg1=""
           <...>-1597  [005] ....   280.907662: open: (do_sys_open+0x0/0x210) arg1=(fault)
           <...>-1597  [005] ....   280.907694: open: (do_sys_open+0x0/0x210) arg1=(fault)
           <...>-1597  [005] ....   280.907772: open: (do_sys_open+0x0/0x210) arg1=(fault)
           <...>-1597  [005] ....   280.907825: open: (do_sys_open+0x0/0x210) arg1=(fault)
           <...>-1597  [005] ....   280.907891: open: (do_sys_open+0x0/0x210) arg1=(fault)
           <...>-1597  [005] ....   280.907947: open: (do_sys_open+0x0/0x210) arg1=(fault)


> > 
> > [  103.620391] BUG: GPF in non-whitelisted uaccess (non-canonical address?)
> > [  103.622104] general protection fault: 0000 [#1] SMP PTI
> > [  103.623424] CPU: 10 PID: 1046 Comm: cat Not tainted 5.0.0-rc3-00130-gd73aba1-dirty #96
> > [  103.625321] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-2-g628b2e6-dirty-20190104_103505-linux 04/01/2014
> > [  103.628284] RIP: 0010:process_fetch_insn+0x1ab/0x4b0

What line number is the RIP on?

-- Steve


> > [  103.629518] Code: 10 83 80 28 2e 00 00 01 31 d2 31 ff 48 8b 74 24 28 eb 0c 81 fa ff 0f 00 00 7f 1c 85 c0 75 18 66 66 90 0f ae e8 48 63
> >  ca 89 f8 <8a> 0c 31 66 66 90 83 c2 01 84 c9 75 dc 89 54 24 34 89 44 24 28 48
> > [  103.634032] RSP: 0018:ffff88845eb37ce0 EFLAGS: 00010246
> > [  103.635312] RAX: 0000000000000000 RBX: ffff888456c4e5a8 RCX: 0000000000000000
> > [  103.637057] RDX: 0000000000000000 RSI: 2e646c2f6374652f RDI: 0000000000000000
> > [  103.638795] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> > [  103.640556] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
> > [  103.642297] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > [  103.644040] FS:  0000000000000000(0000) GS:ffff88846f000000(0000) knlGS:0000000000000000
> > [  103.646019] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  103.647436] CR2: 00007ffc79758038 CR3: 0000000463360006 CR4: 0000000000020ee0
> > [  103.649147] Call Trace:
> > [  103.649781]  ? sched_clock_cpu+0xc/0xa0
> > [  103.650747]  ? do_sys_open+0x5/0x220
> > [  103.651635]  kprobe_trace_func+0x303/0x380
> > [  103.652645]  ? do_sys_open+0x5/0x220
> > [  103.653528]  kprobe_dispatcher+0x45/0x50
> > [  103.654682]  ? do_sys_open+0x1/0x220
> > [  103.655875]  kprobe_ftrace_handler+0x90/0xf0
> > [  103.657282]  ftrace_ops_assist_func+0x54/0xf0
> > [  103.658564]  ? __call_rcu+0x1dc/0x280
> > [  103.659482]  0xffffffffc00000bf
> > [  103.660384]  ? __ia32_sys_open+0x20/0x20
> > [  103.661682]  ? do_sys_open+0x1/0x220
> > [  103.662863]  do_sys_open+0x5/0x220
> > [  103.663988]  do_syscall_64+0x60/0x210
> > [  103.665201]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > [  103.666862] RIP: 0033:0x7fc22fadccdd
> > [  103.668034] Code: 48 89 54 24 e0 41 83 e2 40 75 32 89 f0 25 00 00 41 00 3d 00 00 41 00 74 24 89 f2 b8 01 01 00 00 48 89 fe bf 9c ff ff
> >  ff 0f 05 <48> 3d 00 f0 ff ff 77 33 f3 c3 66 0f 1f 84 00 00 00 00 00 48 8d 44
> > [  103.674029] RSP: 002b:00007ffc7972c3a8 EFLAGS: 00000287 ORIG_RAX: 0000000000000101
> > [  103.676512] RAX: ffffffffffffffda RBX: 0000562f86147a21 RCX: 00007fc22fadccdd
> > [  103.678853] RDX: 0000000000080000 RSI: 00007fc22fae1428 RDI: 00000000ffffff9c
> > [  103.681151] RBP: ffffffffffffffff R08: 0000000000000000 R09: 0000000000000000
> > [  103.683489] R10: 0000000000000000 R11: 0000000000000287 R12: 00007fc22fce90a8
> > [  103.685774] R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
> > [  103.688056] Modules linked in:
> > [  103.689131] ---[ end trace 43792035c28984a1 ]---
> > 
> > This can be fixed by using probe_mem_read() instead.
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  kernel/trace/trace_kprobe.c | 10 +---------
> >  1 file changed, 1 insertion(+), 9 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index d5fb09ebba8b..9eaf07f99212 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -861,22 +861,14 @@ static const struct file_operations kprobe_profile_ops = {
> >  static nokprobe_inline int
> >  fetch_store_strlen(unsigned long addr)
> >  {
> > -	mm_segment_t old_fs;
> >  	int ret, len = 0;
> >  	u8 c;
> >  
> > -	old_fs = get_fs();
> > -	set_fs(KERNEL_DS);
> > -	pagefault_disable();
> > -
> >  	do {
> > -		ret = __copy_from_user_inatomic(&c, (u8 *)addr + len, 1);
> > +		ret = probe_mem_read(&c, (u8 *)addr + len, 1);
> >  		len++;
> >  	} while (c && ret == 0 && len < MAX_STRING_SIZE);
> >  
> > -	pagefault_enable();
> > -	set_fs(old_fs);
> > -
> >  	return (ret < 0) ? ret : len;
> >  }
> >  
> > -- 
> > 2.19.1
> >   
> 

