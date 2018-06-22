Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13865C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 05:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE2EE23D88
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 05:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE2EE23D88
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751256AbeFVFwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 01:52:05 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:41574 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751135AbeFVFwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 01:52:02 -0400
Received: by mail-it0-f69.google.com with SMTP id h26-v6so881025itj.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 22:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=zimLOM0joMQIpaIER/jggMH5WndIxBZ15NOHlgK0JxU=;
        b=Ax8CUheKsU7zcyfaLgEeKdpAb58HhGcAI0l4c2PdooOAZQ60W3s/S9r2AEaX9GruxB
         Q9PkO9lFn6NzCL9AGGMwjQk7b/BYGLWHkjfk9lTgyocmFMYBvpCdRP+EHbenypCSdt1r
         MksTVy6iPZ8RCwfyCeX4ts+zam4N7A6TekQhlDyG30aSHcmSJdcZCXmOmoZcfG0vNWOV
         u/CnH6JLcdakg132DOdGs/y1y2Ia2GjHWT6381/DcAltpgPJFMUrQwHJkxNFHATyl7zq
         Yg4Sf/nsD1Z6n06cyQ7rn+R15ynFr8wJvJ/WhP+XjIMbJB5/Vm0/Xys0OimkCxHLBZ2L
         Jh9A==
X-Gm-Message-State: APt69E1O3JApcr9+jSY9+sr0JMrEwdtyM24/zWqXUDiSNparszEGdhlx
        PAdqBTnemYJaix2nKt09pRPGEo8UpL735lo29GcX0ONRxsHh
X-Google-Smtp-Source: AAOMgpdKvtsSmY2221P11yf1kYjM5A+KTmOixsYW5UYSYgxlfmoXmUNqWsTGCxV2NA236WLDlUHstGwKaVFwvsC17CwIUSpsnaGd
MIME-Version: 1.0
X-Received: by 2002:a6b:8e0a:: with SMTP id q10-v6mr67210iod.2.1529646722044;
 Thu, 21 Jun 2018 22:52:02 -0700 (PDT)
Date:   Thu, 21 Jun 2018 22:52:02 -0700
In-Reply-To: <000000000000c66d94056a84011d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007fdef5056f34a108@google.com>
Subject: Re: KMSAN: uninit-value in ip_vs_lblc_check_expire
From:   syzbot <syzbot+3e9695f147fb529aa9bc@syzkaller.appspotmail.com>
To:     coreteam@netfilter.org, davem@davemloft.net, fw@strlen.de,
        horms@verge.net.au, ja@ssi.bg, kadlec@blackhole.kfki.hu,
        linux-kernel@vger.kernel.org, lvs-devel@vger.kernel.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com,
        wensong@linux-vs.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    123906095e30 kmsan: introduce kmsan_interrupt_enter()/kmsa..
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=134ad890400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=848e40757852af3e
dashboard link: https://syzkaller.appspot.com/bug?extid=3e9695f147fb529aa9bc
compiler:       clang version 7.0.0 (trunk 334104)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=11505218400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1168a490400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3e9695f147fb529aa9bc@syzkaller.appspotmail.com

==================================================================
BUG: KMSAN: uninit-value in ip_vs_lblc_check_expire+0xe62/0xf10  
net/netfilter/ipvs/ip_vs_lblc.c:315
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.17.0+ #9
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x185/0x1d0 lib/dump_stack.c:113
  kmsan_report+0x188/0x2a0 mm/kmsan/kmsan.c:1125
  __msan_warning_32+0x70/0xc0 mm/kmsan/kmsan_instr.c:620
  ip_vs_lblc_check_expire+0xe62/0xf10 net/netfilter/ipvs/ip_vs_lblc.c:315
  call_timer_fn+0x280/0x5d0 kernel/time/timer.c:1326
  expire_timers kernel/time/timer.c:1363 [inline]
  __run_timers+0xd96/0x11b0 kernel/time/timer.c:1666
  run_timer_softirq+0x43/0x70 kernel/time/timer.c:1692
  __do_softirq+0x592/0x979 kernel/softirq.c:285
  invoke_softirq kernel/softirq.c:365 [inline]
  irq_exit+0x202/0x240 kernel/softirq.c:405
  exiting_irq+0xe/0x10 arch/x86/include/asm/apic.h:525
  smp_apic_timer_interrupt+0x64/0x90 arch/x86/kernel/apic/apic.c:1055
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:866
  </IRQ>
RIP: 0010:native_safe_halt arch/x86/include/asm/irqflags.h:55 [inline]
RIP: 0010:arch_safe_halt arch/x86/include/asm/irqflags.h:97 [inline]
RIP: 0010:default_idle+0x20b/0x3e0 arch/x86/kernel/process.c:500
RSP: 0018:ffff8801d8e5fdf0 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RAX: ffff8801fd432f18 RBX: 0000000000000000 RCX: ffff880000000000
RDX: ffff8801fd032f18 RSI: aaaaaaaaaaaab000 RDI: ffffea0000000000
RBP: ffff8801d8e5fe28 R08: 0000000001080020 R09: 0000000000000002
R10: 00000030de3d75c0 R11: ffffffff89fef830 R12: ffff8801d8e5fe8f
R13: ffff8801d8da57c0 R14: ffff8801d8e5fe8c R15: ffff8801d8da6098
  arch_cpu_idle+0x26/0x30 arch/x86/kernel/process.c:491
  default_idle_call kernel/sched/idle.c:93 [inline]
  cpuidle_idle_call kernel/sched/idle.c:153 [inline]
  do_idle+0x36d/0x830 kernel/sched/idle.c:262
  cpu_startup_entry+0x45/0x50 kernel/sched/idle.c:368
  start_secondary+0x3c6/0x490 arch/x86/kernel/smpboot.c:272
  secondary_startup_64+0xa5/0xb0 arch/x86/kernel/head_64.S:242

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:282 [inline]
  kmsan_alloc_meta_for_pages+0x161/0x3a0 mm/kmsan/kmsan.c:819
  kmsan_alloc_page+0x82/0xe0 mm/kmsan/kmsan.c:889
  __alloc_pages_nodemask+0xf7b/0x5cc0 mm/page_alloc.c:4402
  alloc_pages_current+0x6b1/0x970 mm/mempolicy.c:2093
  alloc_pages include/linux/gfp.h:494 [inline]
  kmalloc_order mm/slab_common.c:1148 [inline]
  kmalloc_order_trace+0xbb/0x390 mm/slab_common.c:1159
  kmalloc_large include/linux/slab.h:446 [inline]
  __kmalloc+0x335/0x350 mm/slub.c:3805
  kmalloc include/linux/slab.h:517 [inline]
  ip_vs_lblc_init_svc+0x57/0x310 net/netfilter/ipvs/ip_vs_lblc.c:355
  ip_vs_bind_scheduler+0xa9/0x1f0 net/netfilter/ipvs/ip_vs_sched.c:51
  ip_vs_add_service+0xa9d/0x1d90 net/netfilter/ipvs/ip_vs_ctl.c:1265
  do_ip_vs_set_ctl+0x2aa9/0x2cd0 net/netfilter/ipvs/ip_vs_ctl.c:2462
  nf_sockopt net/netfilter/nf_sockopt.c:106 [inline]
  nf_setsockopt+0x47c/0x4e0 net/netfilter/nf_sockopt.c:115
  ip_setsockopt+0x24b/0x2b0 net/ipv4/ip_sockglue.c:1251
  udp_setsockopt+0x108/0x1b0 net/ipv4/udp.c:2416
  ipv6_setsockopt+0x311/0x350 net/ipv6/ipv6_sockglue.c:917
  tcp_setsockopt+0x1c0/0x1f0 net/ipv4/tcp.c:2891
  sock_common_setsockopt+0x13b/0x170 net/core/sock.c:3039
  __sys_setsockopt+0x496/0x540 net/socket.c:1903
  __do_sys_setsockopt net/socket.c:1914 [inline]
  __se_sys_setsockopt net/socket.c:1911 [inline]
  __x64_sys_setsockopt+0x15c/0x1c0 net/socket.c:1911
  do_syscall_64+0x15b/0x230 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
==================================================================

