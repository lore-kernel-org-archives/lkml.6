Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB95C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67EF7208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:47:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67EF7208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732157AbeKNDrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 22:47:04 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60280 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731685AbeKNDrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 22:47:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4000EBD;
        Tue, 13 Nov 2018 09:47:56 -0800 (PST)
Received: from blommer (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6828D3F5CF;
        Tue, 13 Nov 2018 09:47:56 -0800 (PST)
Date:   Tue, 13 Nov 2018 17:47:54 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Zhang =?utf-8?B?WmhpemhvdSjlvKDmsrvmtLIp?= 
        <zhizhouzhang@asrmicro.com>
Cc:     "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zhizhouzh@gmail.com" <zhizhouzh@gmail.com>
Subject: Re: [PATCH] ftrace: remove KASAN poison in ftrace_ops_test()
Message-ID: <20181113174754.gsghl5aj23xg5hl6@blommer>
References: <1541949017-3001-1-git-send-email-zhizhouzhang@asrmicro.com>
 <20181111173211.q2gzf7h4htxbezch@salmiak>
 <a5c150395e9d4157a1a6cf95fe47bbc9@mail2012.asrmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a5c150395e9d4157a1a6cf95fe47bbc9@mail2012.asrmicro.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 08:09:22AM +0000, Zhang Zhizhou(张治洲) wrote:
> 
> 
> > -----Original Message-----
> > From: Mark Rutland [mailto:mark.rutland@arm.com]
> > Sent: Monday, November 12, 2018 1:32 AM
> > To: Zhang Zhizhou(张治洲) <zhizhouzhang@asrmicro.com>
> > Cc: rostedt@goodmis.org; mingo@redhat.com; linux-
> > kernel@vger.kernel.org; zhizhouzh@gmail.com
> > Subject: Re: [PATCH] ftrace: remove KASAN poison in ftrace_ops_test()
> > 
> > On Sun, Nov 11, 2018 at 11:10:17PM +0800, Zhizhou Zhang wrote:
> > > ftrace_ops_test() passed local varible parameter to
> > > hash_contains_ip(), which could result KASAN stack-out-of-bounds
> > warning.
> > >
> > > Signed-off-by: Zhizhou Zhang <zhizhouzhang@asrmicro.com>
> > > ---
> > >  kernel/trace/ftrace.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c index
> > > f536f60..6e11f90 100644
> > > --- a/kernel/trace/ftrace.c
> > > +++ b/kernel/trace/ftrace.c
> > > @@ -1522,6 +1522,8 @@ ftrace_ops_test(struct ftrace_ops *ops, unsigned
> > long ip, void *regs)
> > >  	rcu_assign_pointer(hash.filter_hash, ops->func_hash->filter_hash);
> > >  	rcu_assign_pointer(hash.notrace_hash, ops->func_hash-
> > >notrace_hash);
> > >
> > > +	kasan_unpoison_task_stack(current);
> > 
> > This is extremely heavy-handed, and will mask legitimate stack-out-of-
> > bounds errors.
> > 
> Yes. I tried to find ways to mark this function no need to poison, but
> failed. My first thought was just make this function not poison its stack.
> 
> > Passing a stack-local variable by reference *should not* result in KASAN
> > warnings unless KASAN itself is broken. Can you please give an example
> > report when this occurs?
> > 
> Please excuse my lack of knowledge. Did you mean if a function passing a
> stack-local variable as parameter to another function, the compiler won't
> poison the stack-local variable?

Yes. That should not be poisoned unless there is a compiler bug.

> The KASAN report is based on 4.4.145, I'm not sure for the latest kernel:
> 
> c3 0 (swapper/3) ==================================================================
> c3 0 (swapper/3) BUG: KASAN: stack-out-of-bounds in hash_contains_ip.isra.4+0x44/0xd0
> c3 0 (swapper/3) Read of size 8 at addr ffffffc0d204bc20 by task swapper/3/0
> c3 0 (swapper/3) 
> c3 0 (swapper/3) CPU: 3 PID: 0 Comm: swapper/3 Not tainted 4.4.145+ #168
> c3 0 (swapper/3) Hardware name: ASR AQUILAC EVB (DT)
> c3 0 (swapper/3) Call trace:
> c3 0 (swapper/3) [<ffffff9008091a50>] dump_backtrace+0x0/0x418
> c3 0 (swapper/3) [<ffffff9008091e90>] show_stack+0x28/0x38
> c3 0 (swapper/3) [<ffffff90086253a4>] dump_stack+0xe8/0x13c
> c3 0 (swapper/3) [<ffffff900831c15c>] print_address_description+0x8c/0x2b0
> c3 0 (swapper/3) [<ffffff900831c688>] kasan_report+0x210/0x330
> c3 0 (swapper/3) [<ffffff900831aba4>] __asan_load8+0x84/0x98
> c3 0 (swapper/3) [<ffffff900821a694>] hash_contains_ip.isra.4+0x44/0xd0
> c3 0 (swapper/3) [<ffffff900821a7c8>] ftrace_ops_test.isra.5+0xa8/0xe0
> c3 0 (swapper/3) [<ffffff90082239cc>] ftrace_ops_no_ops+0xdc/0x218
> c3 0 (swapper/3) [<ffffff90080a1d0c>] ftrace_graph_call+0x0/0x14
> c3 0 (swapper/3) [<ffffff900809afbc>] scale_cpu_capacity+0x24/0x70
> c3 0 (swapper/3) [<ffffff900813ada0>] sync_entity_load_avg+0xb0/0x4c0
> c3 0 (swapper/3) [<ffffff900813b1dc>] remove_entity_load_avg+0x2c/0x80
> c3 0 (swapper/3) [<ffffff900813b250>] task_dead_fair+0x20/0x30
> c3 0 (swapper/3) [<ffffff900811169c>] finish_task_switch+0x1f4/0x2a0
> c3 0 (swapper/3) [<ffffff90092deb94>] __schedule+0x4cc/0xe80
> c3 0 (swapper/3) [<ffffff90092df820>] schedule+0x70/0x110
> c3 0 (swapper/3) [<ffffff90092dfbdc>] schedule_preempt_disabled+0x24/0x70
> c3 0 (swapper/3) [<ffffff9008151dc8>] cpu_startup_entry+0x198/0x538
> c3 0 (swapper/3) [<ffffff9008099f38>] secondary_start_kernel+0x258/0x2f0
> c3 0 (swapper/3) [<00000001032e803c>] 0x1032e803c
> c3 0 (swapper/3) 
> c3 0 (swapper/3) The buggy address belongs to the page:
> c3 0 (swapper/3) page:ffffffbdc34812c0 count:0 mapcount:0 mapping:          (null) index:0x0
> c3 0 (swapper/3) flags: 0x0()
> c3 0 (swapper/3) page dumped because: kasan: bad access detected
> c3 0 (swapper/3) 
> c3 0 (swapper/3) Memory state around the buggy address:
> c3 0 (swapper/3)  ffffffc0d204bb00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c3 0 (swapper/3)  ffffffc0d204bb80: 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1
> c3 0 (swapper/3) >ffffffc0d204bc00: f1 f1 f1 f1 f3 f3 f3 f3 00 00 00 00 00 00 00 00
> c3 0 (swapper/3)                                ^
> c3 0 (swapper/3)  ffffffc0d204bc80: 00 00 00 00 00 00 f2 f2 00 00 00 00 00 00 00 00
> c3 0 (swapper/3)  ffffffc0d204bd00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c3 0 (swapper/3) ==================================================================
> c3 1 (init) init: Untracked pid 3103 killed by signal 14
> c4 972 (syz-executor) asr-wdt d4080000.watchdog: feed asr_wdt(soc_wdt).

Aha. I take it you have KCOV enabled?

In the past I've seen erroneous KASAN reports when KASAN and KCOV were
enabled [1], so I suspect this is may be a mis-compilation.

> c5 431 (kworker/u16:8) C0_DFC: Time 117510987492 (1248 -> 1600);
> c5 431 (kworker/u16:8) C0_DFC: Time 117582358799 (1600 -> 1248);
> c5 431 (kworker/u16:8) C1_DFC: Time 51133656270 (1900 -> 1248);
> c5 431 (kworker/u16:8) C1_DFC: Time 51133864462 (1248 -> 1600);
> c5 431 (kworker/u16:8) DDR_DFC: Time 0 (0 -> 0);
> c5 431 (kworker/u16:8) DDR_DFC: Time 0 (0 -> 0);
> c5 431 (kworker/u16:8) CLK:      GPU(312000000, 0);VPU(832000000, 0);ISP(312000000, 0);
> c5 431 (kworker/u16:8) DVC:      clst0(11); clst1(11); m2(11); peri(1); d1p(1);
> c5 431 (kworker/u16:8) Temp:     cpu(82000); gpu(64000); ddr(68000); local(64000); battery(0); pmic(0)
> c5 431 (kworker/u16:8) Battery:  soc(57648); i_battery(-941556);
> c5 431 (kworker/u16:8) 88pm88x-battery 88pm88x-battery: l=80% v=3957mV t0=25C t1=0C c=-941mA st=UNKNOWN ocv=0
> 
> > Which compiler are you using?
> > 
> I'm using gcc 7.1.0: aarch64-linux-gnu-gcc (GCC) 7.1.0.

The issues I saw [1] were also with GCC 7.x

Can you see if you see the same issue using the kernel.org crosstool GCC 8.1.0 [2]?

Thanks,
Mark.

[1] https://lore.kernel.org/lkml/20171128152405.vkwxdbkbuokjt2hv@lakrids.cambridge.arm.com/
[2] https://mirrors.edge.kernel.org/pub/tools/crosstool/
