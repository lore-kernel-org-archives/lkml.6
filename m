Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3012BC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ACCC21533
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="hNbKQQYY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ACCC21533
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=digitalocean.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbeI0DUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 23:20:44 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38074 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbeI0DUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 23:20:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id x17-v6so229232pfh.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 14:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=63BsdFfMVLPq2U44I6h8wyfBPlUtfdlk8shfBGpLUus=;
        b=hNbKQQYYDL5SRRH/+zbLLZG1Zd0F2sipG2sQ0GBgc0aF/o2qmgniKcoH2ft+W5hlXR
         RwsqmiE5A0zcFcroHXCDbn+QtSyXWy3zhzxzIlaCwm3u9YLogjy95PGliSy8WZrjAvia
         +YLMfuG2Ab3V66crRY6TkHkOt7iXZCFkEcowk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=63BsdFfMVLPq2U44I6h8wyfBPlUtfdlk8shfBGpLUus=;
        b=YZpuIUhlut6u9+EIWBTXRvtIFjeQ3AFNikwZ8pIuQxOKxQgOzGuxst4+Z/ZSKkIcG2
         Jo//RAc7fa5X568BM5v0tFL4f//7Jh0DO9diCze8wzrvsJKyWTUrIHzjNl783T+p2E/w
         BVG96xLwAf0OK5L7fWBegkMN7rsDPOVIw2jKokdmIY05Tm2fRr9G1Q9tBzlF5smMT6v7
         AMzNmnggM4wgO4Msv8rb+foyOkNXFiVAitxgUcyD1hTPd4yTzhQ/B91fK2J9qAX6gMbK
         MP2W0OvvalWnZmtcpWR1Xu7zr+lJ+/jCcuJ6GV9E3zxPGXwi30iF28+W3mvcbVb1ay9q
         9LfQ==
X-Gm-Message-State: ABuFfojCvmuTPbH/HdtWtqAW2u2v80KUm7HpfZM7mhFwIsvZr4BCBsKq
        Et+aKJZazlpemLJzVHQOSLOu8k2oGHk=
X-Google-Smtp-Source: ACcGV61KDpZXu56AGUjb4Eg9dtOI305A0lMy8AAFm7IaIw5mZTax5Fi9qCkawOTIzAg37wa4K9Y0hw==
X-Received: by 2002:a63:be4a:: with SMTP id g10-v6mr7283447pgo.378.1537995953066;
        Wed, 26 Sep 2018 14:05:53 -0700 (PDT)
Received: from breakout.internal.digitalocean.com (97-120-168-235.ptld.qwest.net. [97.120.168.235])
        by smtp.gmail.com with ESMTPSA id v23-v6sm60694pfm.80.2018.09.26.14.05.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 14:05:52 -0700 (PDT)
Received: by breakout.internal.digitalocean.com (Postfix, from userid 1000)
        id 390A58A2A43; Wed, 26 Sep 2018 14:05:51 -0700 (PDT)
Date:   Wed, 26 Sep 2018 14:05:51 -0700
From:   Nishanth Aravamudan <naravamudan@digitalocean.com>
To:     Jan =?iso-8859-1?Q?H=2E_Sch=F6nherr?= <jschoenh@amazon.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 61/60] cosched: Accumulated fixes and improvements
Message-ID: <20180926210551.GA28790@breakout>
References: <20180907214047.26914-1-jschoenh@amazon.de>
 <20180913191938.30526-1-jschoenh@amazon.de>
 <20180926172519.GA23535@breakout>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180926172519.GA23535@breakout>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.09.2018 [10:25:19 -0700], Nishanth Aravamudan wrote:
> On 13.09.2018 [21:19:38 +0200], Jan H. Schönherr wrote:
> > Here is an "extra" patch containing bug fixes and warning removals,
> > that I have accumulated up to this point.
> > 
> > It goes on top of the other 60 patches. (When it is time for v2,
> > these fixes will be integrated into the appropriate patches within
> > the series.)
> 
> I found another issue today, while attempting to test (with 61/60
> applied) separate coscheduling cgroups for vcpus and emulator threads
> [the default configuration with libvirt].

<snip>

> Serial console output (I apologize that some lines got truncated)

I got an non-truncated log as well:

[  764.132461] BUG: unable to handle kernel NULL pointer dereference at 0000000000000040
[  764.141001] PGD 0 P4D 0 
[  764.144020] Oops: 0000 [#1] SMP PTI
[  764.147988] CPU: 70 PID: 0 Comm: swapper/70 Tainted: G           OE     4.19-0rc3.ag-generic #4+1536951040do~8680a1b
[  764.159086] Hardware name: Dell Inc. PowerEdge R640/0W23H8, BIOS 1.2.11 10/19/2017
[  764.166968] RIP: 0010:set_next_entity+0x15/0x1d0
[  764.171887] Code: c8 48 8b 7d d0 eb 96 0f 1f 40 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 41 55 41 54 49 89 fc 53 <8b> 46 40 48 89 f30
[  764.191276] RSP: 0018:ffffb97158cdfd78 EFLAGS: 00010046
[  764.196888] RAX: 0000000000000000 RBX: ffff9806c0ee2d80 RCX: 0000000000000000
[  764.204403] RDX: 0000000000000022 RSI: 0000000000000000 RDI: ffff9806c0ee2e00
[  764.211918] RBP: ffffb97158cdfda0 R08: ffffb97178cd8000 R09: 0000000000006080
[  764.219412] R10: 0000000000000000 R11: 0000000000000001 R12: ffff9806c0ee2e00
[  764.226903] R13: 0000000000000000 R14: ffff9806c0ee2e00 R15: 0000000000000000
[  764.234433] FS:  0000000000000000(0000) GS:ffff9806c0ec0000(0000) knlGS:0000000000000000
[  764.242919] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  764.249045] CR2: 0000000000000040 CR3: 00000002d720a004 CR4: 00000000007626e0
[  764.256558] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  764.264108] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  764.271663] PKRU: 55555554
[  764.274784] Call Trace:
[  764.277633]  pick_next_task_fair+0x8a7/0xa20
[  764.282292]  __schedule+0x13a/0x8e0
[  764.286184]  schedule_idle+0x2c/0x40
[  764.290161]  do_idle+0x169/0x280
[  764.293816]  cpu_startup_entry+0x73/0x80
[  764.298151]  start_secondary+0x1ab/0x200
[  764.302513]  secondary_startup_64+0xa4/0xb0
[  764.307127] Modules linked in: act_police cls_basic ebtable_filter ebtables ip6table_filter iptable_filter nbd ip6table_raw ip6_tables xt_CT iptable_raw ip_tables r
[  764.381780]  coretemp lp parport btrfs zstd_compress raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid0 multipath linei
[  764.414567] CR2: 0000000000000040
[  764.418596] ---[ end trace 9b35e3cb99f8eacb ]---
[  764.437343] RIP: 0010:set_next_entity+0x15/0x1d0
[  764.442748] Code: c8 48 8b 7d d0 eb 96 0f 1f 40 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 41 55 41 54 49 89 fc 53 <8b> 46 40 48 89 f30
[  764.462845] RSP: 0018:ffffb97158cdfd78 EFLAGS: 00010046
[  764.468788] RAX: 0000000000000000 RBX: ffff9806c0ee2d80 RCX: 0000000000000000
[  764.476633] RDX: 0000000000000022 RSI: 0000000000000000 RDI: ffff9806c0ee2e00
[  764.484476] RBP: ffffb97158cdfda0 R08: ffffb97178cd8000 R09: 0000000000006080
[  764.492322] R10: 0000000000000000 R11: 0000000000000001 R12: ffff9806c0ee2e00
[  764.500143] R13: 0000000000000000 R14: ffff9806c0ee2e00 R15: 0000000000000000
[  764.507988] FS:  0000000000000000(0000) GS:ffff9806c0ec0000(0000) knlGS:0000000000000000
[  764.516801] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  764.523258] CR2: 0000000000000040 CR3: 00000002d720a004 CR4: 00000000007626e0
[  764.531084] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  764.538987] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  764.546813] PKRU: 55555554
[  764.550185] Kernel panic - not syncing: Attempted to kill the idle task!
[  764.557615] Kernel Offset: 0x1f400000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[  764.581890] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---
[  764.590574] WARNING: CPU: 70 PID: 0 at /build/linux-4.19-0rc3.ag.4/kernel/sched/core.c:1187 set_task_cpu+0x193/0x1a0
[  764.601740] Modules linked in: act_police cls_basic ebtable_filter ebtables ip6table_filter iptable_filter nbd ip6table_raw ip6_tables xt_CT iptable_raw ip_tables r
[  764.677788]  coretemp lp parport btrfs zstd_compress raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid0 multipath linei
[  764.711018] CPU: 70 PID: 0 Comm: swapper/70 Tainted: G      D    OE     4.19-0rc3.ag-generic #4+1536951040do~8680a1b
[  764.722332] Hardware name: Dell Inc. PowerEdge R640/0W23H8, BIOS 1.2.11 10/19/2017
[  764.730716] RIP: 0010:set_task_cpu+0x193/0x1a0
[  764.735983] Code: 00 00 04 e9 36 ff ff ff 0f 0b e9 be fe ff ff f7 43 60 fd ff ff ff 0f 84 c8 fe ff ff 0f 0b e9 c1 fe ff ff 31 c0 e9 6d ff ff ff <0f> 0b e9 c9 fe ff5
[  764.756428] RSP: 0018:ffff9806c0ec3e08 EFLAGS: 00010046
[  764.762512] RAX: 0000000000000200 RBX: ffff980547829e00 RCX: 0000000000000080
[  764.770492] RDX: ffff98054782a101 RSI: 0000000000000000 RDI: ffff980547829e00
[  764.778456] RBP: ffff9806c0ec3e28 R08: 0000000000000000 R09: 0000000000000046
[  764.786412] R10: 0000000000000001 R11: 0000000000000046 R12: ffff98054782a934
[  764.794351] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000022d80
[  764.802272] FS:  0000000000000000(0000) GS:ffff9806c0ec0000(0000) knlGS:0000000000000000
[  764.811138] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  764.817657] CR2: 0000000000000040 CR3: 00000002d720a004 CR4: 00000000007626e0
[  764.825550] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  764.833427] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  764.841280] PKRU: 55555554
[  764.844702] Call Trace:
[  764.847857]  <IRQ>
[  764.850581]  try_to_wake_up+0x159/0x4b0
[  764.855146]  ? apic_timer_expired+0x70/0x70 [kvm]
[  764.860529]  wake_up_process+0x15/0x20
[  764.864952]  swake_up_locked+0x24/0x40
[  764.869370]  swake_up_one+0x1f/0x30
[  764.873544]  apic_timer_expired+0x4b/0x70 [kvm]
[  764.878739]  apic_timer_fn+0x1b/0x50 [kvm]
[  764.883487]  __hrtimer_run_queues+0x106/0x270
[  764.888496]  hrtimer_interrupt+0x116/0x240
[  764.893237]  smp_apic_timer_interrupt+0x6f/0x140
[  764.898497]  apic_timer_interrupt+0xf/0x20
[  764.903228]  </IRQ>
[  764.905967] RIP: 0010:panic+0x1fe/0x244
[  764.910438] Code: eb a6 83 3d 17 bc af 01 00 74 05 e8 b0 72 02 00 48 c7 c6 20 f1 f8 a1 48 c7 c7 10 54 6d a1 e8 c0 a3 06 00 fb 66 0f 1f 44 00 00 <31> db e8 3f f5 0df
[  764.930499] RSP: 0018:ffffb97158cdfe60 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
[  764.938726] RAX: 000000000000004a RBX: ffff9806b2501e00 RCX: 0000000000000006
[  764.946509] RDX: 0000000000000000 RSI: 0000000000000096 RDI: ffff9806c0ed6420
[  764.954282] RBP: ffffb97158cdfed8 R08: 0000000000000046 R09: 0000000000aaaaaa
[  764.962038] R10: 0000000000000040 R11: 0000000000000001 R12: 0000000000000000
[  764.969776] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000046
[  764.977502]  do_exit+0x886/0xb20
[  764.981305]  ? cpu_startup_entry+0x73/0x80
[  764.985967]  rewind_stack_do_exit+0x17/0x20
[  764.990699] ---[ end trace 9b35e3cb99f8eacc ]---
[  764.995851] ------------[ cut here ]------------
[  765.000984] sched: Unexpected reschedule of offline CPU#0!
[  765.006976] WARNING: CPU: 70 PID: 0 at /build/linux-4.19-0rc3.ag.4/arch/x86/kernel/smp.c:128 native_smp_send_reschedule+0x3f/0x50
[  765.019617] Modules linked in: act_police cls_basic ebtable_filter ebtables ip6table_filter iptable_filter nbd ip6table_raw ip6_tables xt_CT iptable_raw ip_tables r
[  765.094470]  coretemp lp parport btrfs zstd_compress raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid0 multipath linei
[  765.127134] CPU: 70 PID: 0 Comm: swapper/70 Tainted: G      D W  OE     4.19-0rc3.ag-generic #4+1536951040do~8680a1b
[  765.138261] Hardware name: Dell Inc. PowerEdge R640/0W23H8, BIOS 1.2.11 10/19/2017
[  765.146443] RIP: 0010:native_smp_send_reschedule+0x3f/0x50
[  765.152543] Code: c0 84 c0 74 17 48 8b 05 ff d9 36 01 be fd 00 00 00 48 8b 40 30 e8 71 5e da 00 5d c3 89 fe 48 c7 c7 e8 b5 6c a1 e8 31 5b 03 00 <0f> 0b 5d c3 0f 1f0
[  765.172572] RSP: 0018:ffff9806c0ec3d78 EFLAGS: 00010086
[  765.178438] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000006
[  765.186228] RDX: 0000000000000007 RSI: 0000000000000082 RDI: ffff9806c0ed6420
[  765.194020] RBP: ffff9806c0ec3d78 R08: 0000000000000046 R09: 0000000000aaaaaa
[  765.201812] R10: ffff9806c0ec3c98 R11: 0000000000000001 R12: ffff9806c0622d80
[  765.209601] R13: ffff9806c0622d80 R14: ffff9806c0ec3e48 R15: ffff9806c0622d80
[  765.217394] FS:  0000000000000000(0000) GS:ffff9806c0ec0000(0000) knlGS:0000000000000000
[  765.226154] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  765.232575] CR2: 0000000000000040 CR3: 00000002d720a004 CR4: 00000000007626e0
[  765.240395] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  765.248211] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  765.256028] PKRU: 55555554
[  765.259416] Call Trace:
[  765.262547]  <IRQ>
[  765.265232]  resched_curr+0x79/0xf0
[  765.269391]  check_preempt_curr+0x78/0xe0
[  765.274073]  ttwu_do_wakeup+0x1e/0x150
[  765.278485]  ttwu_do_activate+0x77/0x80
[  765.282966]  try_to_wake_up+0x1d6/0x4b0
[  765.287445]  ? apic_timer_expired+0x70/0x70 [kvm]
[  765.292775]  wake_up_process+0x15/0x20
[  765.297151]  swake_up_locked+0x24/0x40
[  765.301518]  swake_up_one+0x1f/0x30
[  765.305637]  apic_timer_expired+0x4b/0x70 [kvm]
[  765.310800]  apic_timer_fn+0x1b/0x50 [kvm]
[  765.315515]  __hrtimer_run_queues+0x106/0x270
[  765.320490]  hrtimer_interrupt+0x116/0x240
[  765.325204]  smp_apic_timer_interrupt+0x6f/0x140
[  765.330439]  apic_timer_interrupt+0xf/0x20
[  765.335151]  </IRQ>
[  765.337865] RIP: 0010:panic+0x1fe/0x244
[  765.342304] Code: eb a6 83 3d 17 bc af 01 00 74 05 e8 b0 72 02 00 48 c7 c6 20 f1 f8 a1 48 c7 c7 10 54 6d a1 e8 c0 a3 06 00 fb 66 0f 1f 44 00 00 <31> db e8 3f f5 0df
[  765.362254] RSP: 0018:ffffb97158cdfe60 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
[  765.370407] RAX: 000000000000004a RBX: ffff9806b2501e00 RCX: 0000000000000006
[  765.378120] RDX: 0000000000000000 RSI: 0000000000000096 RDI: ffff9806c0ed6420
[  765.385815] RBP: ffffb97158cdfed8 R08: 0000000000000046 R09: 0000000000aaaaaa
[  765.393504] R10: 0000000000000040 R11: 0000000000000001 R12: 0000000000000000
[  765.401172] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000046
[  765.408830]  do_exit+0x886/0xb20
[  765.412561]  ? cpu_startup_entry+0x73/0x80
[  765.417147]  rewind_stack_do_exit+0x17/0x20
[  765.421799] ---[ end trace 9b35e3cb99f8eacd ]---

Thanks,
Nish
