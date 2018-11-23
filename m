Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35932C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCCC620863
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:52:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCCC620863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504447AbeKWXg0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 18:36:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:39124 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403778AbeKWXg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 18:36:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 19CFAAEC0;
        Fri, 23 Nov 2018 12:52:20 +0000 (UTC)
Date:   Fri, 23 Nov 2018 13:52:19 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 3/3] lockdep: Use line-buffered printk() for lockdep
 messages.
Message-ID: <20181123125219.k5flkypofll7jwtr@pathway.suse.cz>
References: <1541165517-3557-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <1541165517-3557-3-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181107151900.gxmdvx42qeanpoah@pathway.suse.cz>
 <20181108044510.GC2343@jagdpanzerIV>
 <9648a384-853c-942e-6a8d-80432d943aae@i-love.sakura.ne.jp>
 <20181109061204.GC599@jagdpanzerIV>
 <07dcbcb8-c5a7-8188-b641-c110ade1c5da@i-love.sakura.ne.jp>
 <20181109154326.apqkbsojmbg26o3b@pathway.suse.cz>
 <2d0d1f60-d8b6-41e0-6845-0eb62f211e40@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <2d0d1f60-d8b6-41e0-6845-0eb62f211e40@i-love.sakura.ne.jp>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2018-11-10 17:52:17, Tetsuo Handa wrote:
> On 2018/11/10 0:43, Petr Mladek wrote:
> > On Fri 2018-11-09 18:55:26, Tetsuo Handa wrote:
> >> How early_printk requirement affects line buffered printk() API?
> >>
> >> I don't think it is impossible to convert from
> >>
> >>      printk("Testing feature XYZ..");
> >>      this_may_blow_up_because_of_hw_bugs();
> >>      printk(KERN_CONT " ... ok\n");
> >>
> >> to
> >>
> >>      printk("Testing feature XYZ:\n");
> >>      this_may_blow_up_because_of_hw_bugs();
> >>      printk("Testing feature XYZ.. ... ok\n");
> >>
> >> in https://lore.kernel.org/lkml/CA+55aFwmwdY_mMqdEyFPpRhCKRyeqj=+aCqe5nN108v8ELFvPw@mail.gmail.com/ .
> > 
> > I just wonder how this pattern is common. I have tried but I failed
> > to find any instance.
> > 
> > This problem looks like a big argument against explicit buffers.
> > But I wonder if it is real.
> 
> An example of boot up messages where buffering makes difference.
> 
> Vanilla:
> 
> [    0.260459] smp: Bringing up secondary CPUs ...
> [    0.269595] x86: Booting SMP configuration:
> [    0.270461] .... node  #0, CPUs:      #1
> [    0.066578] Disabled fast string operations
> [    0.066578] mce: CPU supports 0 MCE banks
> [    0.066578] smpboot: CPU 1 Converting physical 2 to logical package 1
> [    0.342569]  #2
> [    0.066578] Disabled fast string operations
> [    0.066578] mce: CPU supports 0 MCE banks
> [    0.066578] smpboot: CPU 2 Converting physical 4 to logical package 2
> [    0.413442]  #3
> [    0.066578] Disabled fast string operations
> [    0.066578] mce: CPU supports 0 MCE banks
> [    0.066578] smpboot: CPU 3 Converting physical 6 to logical package 3
> [    0.476562] smp: Brought up 1 node, 4 CPUs
> [    0.477477] smpboot: Max logical packages: 8
> [    0.477514] smpboot: Total of 4 processors activated (22691.70 BogoMIPS)
> 
> With try_buffered_printk() patch:
> 
> [    0.279768] smp: Bringing up secondary CPUs ...
> [    0.288825] x86: Booting SMP configuration:
> [    0.066748] Disabled fast string operations
> [    0.066748] mce: CPU supports 0 MCE banks
> [    0.066748] smpboot: CPU 1 Converting physical 2 to logical package 1
> [    0.066748] Disabled fast string operations
> [    0.066748] mce: CPU supports 0 MCE banks
> [    0.066748] smpboot: CPU 2 Converting physical 4 to logical package 2
> [    0.066748] Disabled fast string operations
> [    0.066748] mce: CPU supports 0 MCE banks
> [    0.066748] smpboot: CPU 3 Converting physical 6 to logical package 3
> [    0.495862] .... node  #0, CPUs:      #1 #2 #36smp: Brought up 1 node, 4 CPUs
> [    0.496833] smpboot: Max logical packages: 8
> [    0.497609] smpboot: Total of 4 processors activated (22665.22 BogoMIPS)
> 
> 
> 
> Hmm, arch/x86/kernel/smpboot.c is not emitting '\n' after #num
> 
>         if (system_state < SYSTEM_RUNNING) {
>                 if (node != current_node) {
>                         if (current_node > (-1))
>                                 pr_cont("\n");
>                         current_node = node;
> 
>                         printk(KERN_INFO ".... node %*s#%d, CPUs:  ",
>                                node_width - num_digits(node), " ", node);
>                 }
> 
>                 /* Add padding for the BSP */
>                 if (cpu == 1)
>                         pr_cont("%*s", width + 1, " ");
> 
>                 pr_cont("%*s#%d", width - num_digits(cpu), " ", cpu);
> 
>         } else
>                 pr_info("Booting Node %d Processor %d APIC 0x%x\n",
>                         node, cpu, apicid);
> 
> and causing
> 
>         pr_info("Brought up %d node%s, %d CPU%s\n",
>                 num_nodes, (num_nodes > 1 ? "s" : ""),
>                 num_cpus,  (num_cpus  > 1 ? "s" : ""));
> 
> line to be concatenated to previous line.
> Maybe disable try_buffered_printk() if system_state !=
> SYSTEM_RUNNING ?

We need to solve continuous lines also during boot. Also similar
problems might be in the code that is called in SYSTEM_RUNNING state.

This is yet another clue that try_buffered_printk() approach is not
that good idea.

Best Regards,
Petr
