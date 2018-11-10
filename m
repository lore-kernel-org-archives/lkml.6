Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3798C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 08:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7773620892
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 08:52:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7773620892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbeKJSge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 13:36:34 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:56369 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbeKJSge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 13:36:34 -0500
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wAA8qJEb034966;
        Sat, 10 Nov 2018 17:52:19 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp);
 Sat, 10 Nov 2018 17:52:19 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157065137.bbtec.net [60.157.65.137])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wAA8qJtq034918
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sat, 10 Nov 2018 17:52:19 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 3/3] lockdep: Use line-buffered printk() for lockdep
 messages.
To:     Petr Mladek <pmladek@suse.com>
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
References: <1541165517-3557-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <1541165517-3557-3-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181107151900.gxmdvx42qeanpoah@pathway.suse.cz>
 <20181108044510.GC2343@jagdpanzerIV>
 <9648a384-853c-942e-6a8d-80432d943aae@i-love.sakura.ne.jp>
 <20181109061204.GC599@jagdpanzerIV>
 <07dcbcb8-c5a7-8188-b641-c110ade1c5da@i-love.sakura.ne.jp>
 <20181109154326.apqkbsojmbg26o3b@pathway.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <2d0d1f60-d8b6-41e0-6845-0eb62f211e40@i-love.sakura.ne.jp>
Date:   Sat, 10 Nov 2018 17:52:17 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181109154326.apqkbsojmbg26o3b@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/10 0:43, Petr Mladek wrote:
> On Fri 2018-11-09 18:55:26, Tetsuo Handa wrote:
>> How early_printk requirement affects line buffered printk() API?
>>
>> I don't think it is impossible to convert from
>>
>>      printk("Testing feature XYZ..");
>>      this_may_blow_up_because_of_hw_bugs();
>>      printk(KERN_CONT " ... ok\n");
>>
>> to
>>
>>      printk("Testing feature XYZ:\n");
>>      this_may_blow_up_because_of_hw_bugs();
>>      printk("Testing feature XYZ.. ... ok\n");
>>
>> in https://lore.kernel.org/lkml/CA+55aFwmwdY_mMqdEyFPpRhCKRyeqj=+aCqe5nN108v8ELFvPw@mail.gmail.com/ .
> 
> I just wonder how this pattern is common. I have tried but I failed
> to find any instance.
> 
> This problem looks like a big argument against explicit buffers.
> But I wonder if it is real.

An example of boot up messages where buffering makes difference.

Vanilla:

[    0.260459] smp: Bringing up secondary CPUs ...
[    0.269595] x86: Booting SMP configuration:
[    0.270461] .... node  #0, CPUs:      #1
[    0.066578] Disabled fast string operations
[    0.066578] mce: CPU supports 0 MCE banks
[    0.066578] smpboot: CPU 1 Converting physical 2 to logical package 1
[    0.342569]  #2
[    0.066578] Disabled fast string operations
[    0.066578] mce: CPU supports 0 MCE banks
[    0.066578] smpboot: CPU 2 Converting physical 4 to logical package 2
[    0.413442]  #3
[    0.066578] Disabled fast string operations
[    0.066578] mce: CPU supports 0 MCE banks
[    0.066578] smpboot: CPU 3 Converting physical 6 to logical package 3
[    0.476562] smp: Brought up 1 node, 4 CPUs
[    0.477477] smpboot: Max logical packages: 8
[    0.477514] smpboot: Total of 4 processors activated (22691.70 BogoMIPS)

With try_buffered_printk() patch:

[    0.279768] smp: Bringing up secondary CPUs ...
[    0.288825] x86: Booting SMP configuration:
[    0.066748] Disabled fast string operations
[    0.066748] mce: CPU supports 0 MCE banks
[    0.066748] smpboot: CPU 1 Converting physical 2 to logical package 1
[    0.066748] Disabled fast string operations
[    0.066748] mce: CPU supports 0 MCE banks
[    0.066748] smpboot: CPU 2 Converting physical 4 to logical package 2
[    0.066748] Disabled fast string operations
[    0.066748] mce: CPU supports 0 MCE banks
[    0.066748] smpboot: CPU 3 Converting physical 6 to logical package 3
[    0.495862] .... node  #0, CPUs:      #1 #2 #36smp: Brought up 1 node, 4 CPUs
[    0.496833] smpboot: Max logical packages: 8
[    0.497609] smpboot: Total of 4 processors activated (22665.22 BogoMIPS)



Hmm, arch/x86/kernel/smpboot.c is not emitting '\n' after #num

        if (system_state < SYSTEM_RUNNING) {
                if (node != current_node) {
                        if (current_node > (-1))
                                pr_cont("\n");
                        current_node = node;

                        printk(KERN_INFO ".... node %*s#%d, CPUs:  ",
                               node_width - num_digits(node), " ", node);
                }

                /* Add padding for the BSP */
                if (cpu == 1)
                        pr_cont("%*s", width + 1, " ");

                pr_cont("%*s#%d", width - num_digits(cpu), " ", cpu);

        } else
                pr_info("Booting Node %d Processor %d APIC 0x%x\n",
                        node, cpu, apicid);

and causing

        pr_info("Brought up %d node%s, %d CPU%s\n",
                num_nodes, (num_nodes > 1 ? "s" : ""),
                num_cpus,  (num_cpus  > 1 ? "s" : ""));

line to be concatenated to previous line.
Maybe disable try_buffered_printk() if system_state != SYSTEM_RUNNING ?
