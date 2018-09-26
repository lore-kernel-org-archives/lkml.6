Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71275C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18FF321531
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="GL5dN6Lh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18FF321531
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=digitalocean.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbeIZXjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:39:21 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42866 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbeIZXjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:39:20 -0400
Received: by mail-pf1-f193.google.com with SMTP id l9-v6so13761322pff.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 10:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=x3jv+TXckRUM5Ing+VG5iQHgBSUYzqp3tmoL9nz/zU8=;
        b=GL5dN6Lhw04Y6vACRenPE4oTP8zrIkD7w9+YGDdBDYybJa9mosnvmFte08wUWaD5uX
         r2DfH+8+zY3RQpXsnYg/aPArV6XCL+GIIcmHD8I8Fl0DPaU41ywuYiX+sybfchRysMv0
         RBpU61RPHWkaEVTt1hxbjdIGZfSthQFA3aFLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=x3jv+TXckRUM5Ing+VG5iQHgBSUYzqp3tmoL9nz/zU8=;
        b=kriNnapwPa6daTRXt55LdzSUyWsivGWlXf0MoLSB9lzLQFsagcqU7wbJbG1NhFM/LG
         qbEQcQflrnf1V6BLuC8DIfxL0Vy0GrJSkYWDBwJJcCby/CGs+MAYRD2TcVkgl158I6Bj
         WtEpZ8250++RUkv+ydYxMEc0ytoI5fJWpa+VV1Yp0rS0rgyA0pS+9JrsciYtQ72A1Tfj
         yhy+z7+vGitB+JVTT0QVQMBs2hIIH8tT2j3CjCbLhn/+7UsxRk52MidFsdDKs+EdXx6k
         GAxzNhLOKEHufwy5AaTDKmm4MU/6ABJTYS2zxO/dEd1ScS/oMLW/PLAdGvCBgwzqHOfh
         Atcw==
X-Gm-Message-State: ABuFfojj1zOZ9ZbToYjhlHjZmGYNdv7IFa8DT3kgm73OJDb1t8mAT0nG
        eZwJL5ci3XxpfFytnTqrT68r9g==
X-Google-Smtp-Source: ACcGV62/CMFV+wBXPGnCgpAqNHRClknyXxgPJKzsdx1IK7wvq23COe+67nZt37IbOMyjpjjK5/71Fg==
X-Received: by 2002:a63:80c6:: with SMTP id j189-v6mr6686892pgd.40.1537982721603;
        Wed, 26 Sep 2018 10:25:21 -0700 (PDT)
Received: from breakout.internal.digitalocean.com (97-120-168-235.ptld.qwest.net. [97.120.168.235])
        by smtp.gmail.com with ESMTPSA id y64-v6sm11897406pgb.82.2018.09.26.10.25.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 10:25:20 -0700 (PDT)
Received: by breakout.internal.digitalocean.com (Postfix, from userid 1000)
        id EF4278A2A43; Wed, 26 Sep 2018 10:25:19 -0700 (PDT)
Date:   Wed, 26 Sep 2018 10:25:19 -0700
From:   Nishanth Aravamudan <naravamudan@digitalocean.com>
To:     Jan =?iso-8859-1?Q?H=2E_Sch=F6nherr?= <jschoenh@amazon.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 61/60] cosched: Accumulated fixes and improvements
Message-ID: <20180926172519.GA23535@breakout>
References: <20180907214047.26914-1-jschoenh@amazon.de>
 <20180913191938.30526-1-jschoenh@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180913191938.30526-1-jschoenh@amazon.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.09.2018 [21:19:38 +0200], Jan H. Schönherr wrote:
> Here is an "extra" patch containing bug fixes and warning removals,
> that I have accumulated up to this point.
> 
> It goes on top of the other 60 patches. (When it is time for v2,
> these fixes will be integrated into the appropriate patches within
> the series.)

I found another issue today, while attempting to test (with 61/60
applied) separate coscheduling cgroups for vcpus and emulator threads
[the default configuration with libvirt].

/sys/fs/cgroup/cpu# cat cpu.scheduled 
1
/sys/fs/cgroup/cpu# cd machine/
/sys/fs/cgroup/cpu/machine# cat cpu.scheduled
0
/sys/fs/cgroup/cpu/machine# cd VM-1.libvirt-qemu/
/sys/fs/cgroup/cpu/machine/VM-1.libvirt-qemu# cat cpu.scheduled
0
/sys/fs/cgroup/cpu/machine/VM-1.libvirt-qemu# cd vcpu0/
/sys/fs/cgroup/cpu/machine/VM-1.libvirt-qemu/vcpu0# cat cpu.scheduled
0
/sys/fs/cgroup/cpu/machine/VM-1.libvirt-qemu/vcpu0# echo 1 > cpu.scheduled
/sys/fs/cgroup/cpu/machine/VM-1.libvirt-qemu/vcpu0# cd ../emulator/
/sys/fs/cgroup/cpu/machine/VM-1.libvirt-qemu/emulator# echo 1 > cpu.scheduled
/sys/fs/cgroup/cpu/machine/VM-1.libvirt-qemu/emulator# <crash>

Serial console output (I apologize that some lines got truncated)

[ 1060.840120] BUG: unable to handle kernel NULL pointer dere0
[ 1060.848782] PGD 0 P4D 0 
[ 1060.852068] Oops: 0000 [#1] SMP PTI
[ 1060.856207] CPU: 44 PID: 0 Comm: swapper/44 Tainted: G           OE     4.19b
[ 1060.867029] Hardware name: Dell Inc. PowerEdge R640/0W23H8, BIOS 1.2.11 10/17
[ 1060.874872] RIP: 0010:set_next_entity+0x15/0x1d0
[ 1060.879770] Code: c8 48 8b 7d d0 eb 96 0f 1f 40 00 66 2e 0f 1f 84 00 00 00 00
[ 1060.899165] RSP: 0018:ffffaa2b98c0fd78 EFLAGS: 00010046
[ 1060.904720] RAX: 0000000000000000 RBX: ffff996940ba2d80 RCX: 0000000000000000
[ 1060.912199] RDX: 0000000000000008 RSI: 0000000000000000 RDI: ffff996940ba2e00
[ 1060.919678] RBP: ffffaa2b98c0fda0 R08: 0000000000000000 R09: 0000000000000000
[ 1060.927174] R10: 0000000000000000 R11: 0000000000000001 R12: ffff996940ba2e00
[ 1060.934655] R13: 0000000000000000 R14: ffff996940ba2e00 R15: 0000000000000000
[ 1060.942134] FS:  0000000000000000(0000) GS:ffff996940b80000(0000) knlGS:00000
[ 1060.950572] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1060.956673] CR2: 0000000000000040 CR3: 00000064af40a006 CR4: 00000000007626e0
[ 1060.964172] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1060.971677] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1060.979191] PKRU: 55555554
[ 1060.982282] Call Trace:
[ 1060.985126]  pick_next_task_fair+0x8a7/0xa20
[ 1060.989794]  __schedule+0x13a/0x8e0
[ 1060.993691]  ? update_ts_time_stats+0x59/0x80
[ 1060.998439]  schedule_idle+0x2c/0x40
[ 1061.002410]  do_idle+0x169/0x280
[ 1061.006032]  cpu_startup_entry+0x73/0x80
[ 1061.010348]  start_secondary+0x1ab/0x200
[ 1061.014673]  secondary_startup_64+0xa4/0xb0
[ 1061.019265] Modules linked in: act_police cls_basic ebtable_filter ebtables i
[ 1061.093145]  mac_hid coretemp lp parport btrfs zstd_compress raid456 async_ri
[ 1061.126494] CR2: 0000000000000040
[ 1061.130467] ---[ end trace 3462ef57e3394c4f ]---
[ 1061.147237] RIP: 0010:set_next_entity+0x15/0x1d0
[ 1061.152510] Code: c8 48 8b 7d d0 eb 96 0f 1f 40 00 66 2e 0f 1f 84 00 00 00 00
[ 1061.172573] RSP: 0018:ffffaa2b98c0fd78 EFLAGS: 00010046
[ 1061.178482] RAX: 0000000000000000 RBX: ffff996940ba2d80 RCX: 0000000000000000
[ 1061.186309] RDX: 0000000000000008 RSI: 0000000000000000 RDI: ffff996940ba2e00
[ 1061.194109] RBP: ffffaa2b98c0fda0 R08: 0000000000000000 R09: 0000000000000000
[ 1061.201908] R10: 0000000000000000 R11: 0000000000000001 R12: ffff996940ba2e00
[ 1061.209698] R13: 0000000000000000 R14: ffff996940ba2e00 R15: 0000000000000000
[ 1061.217490] FS:  0000000000000000(0000) GS:ffff996940b80000(0000) knlGS:00000
[ 1061.226236] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1061.232622] CR2: 0000000000000040 CR3: 00000064af40a006 CR4: 00000000007626e0
[ 1061.240405] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1061.248168] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1061.255909] PKRU: 55555554
[ 1061.259221] Kernel panic - not syncing: Attempted to kill the idle task!
[ 1062.345087] Shutting down cpus with NMI
[ 1062.351037] Kernel Offset: 0x33400000 from 0xffffffff81000000 (relocation ra)
[ 1062.374645] ---[ end Kernel panic - not syncing: Attempted to kill the idle -
[ 1062.383218] WARNING: CPU: 44 PID: 0 at /build/linux-4.19-0rc3.ag.4/kernel/sc0
[ 1062.394380] Modules linked in: act_police cls_basic ebtable_filter ebtables i
[ 1062.469725]  mac_hid coretemp lp parport btrfs zstd_compress raid456 async_ri
[ 1062.503656] CPU: 44 PID: 0 Comm: swapper/44 Tainted: G      D    OE     4.19b
[ 1062.514972] Hardware name: Dell Inc. PowerEdge R640/0W23H8, BIOS 1.2.11 10/17
[ 1062.523357] RIP: 0010:set_task_cpu+0x193/0x1a0
[ 1062.528624] Code: 00 00 04 e9 36 ff ff ff 0f 0b e9 be fe ff ff f7 43 60 fd f5
[ 1062.549066] RSP: 0018:ffff996940b83dc8 EFLAGS: 00010046
[ 1062.555134] RAX: 0000000000000200 RBX: ffff99c90f2a9e00 RCX: 0000000000000080
[ 1062.563096] RDX: ffff99c90f2aa101 RSI: 000000000000000f RDI: ffff99c90f2a9e00
[ 1062.571053] RBP: ffff996940b83de8 R08: 000000000000000f R09: 000000000000002c
[ 1062.578990] R10: 0000000000000001 R11: 0000000000000009 R12: ffff99c90f2aa934
[ 1062.586911] R13: 000000000000000f R14: 000000000000000f R15: 0000000000022d80
[ 1062.594826] FS:  0000000000000000(0000) GS:ffff996940b80000(0000) knlGS:00000
[ 1062.603681] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1062.610182] CR2: 0000000000000040 CR3: 00000064af40a006 CR4: 00000000007626e0
[ 1062.618061] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1062.625919] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1062.633762] PKRU: 55555554
[ 1062.637186] Call Trace:
[ 1062.640350]  <IRQ>
[ 1062.643066]  try_to_wake_up+0x159/0x4b0
[ 1062.647588]  default_wake_function+0x12/0x20
[ 1062.652539]  autoremove_wake_function+0x12/0x40
[ 1062.657744]  __wake_up_common+0x8c/0x130
[ 1062.662340]  __wake_up_common_lock+0x80/0xc0
[ 1062.667277]  __wake_up+0x13/0x20
[ 1062.671170]  wake_up_klogd_work_func+0x40/0x60
[ 1062.676275]  irq_work_run_list+0x55/0x80
[ 1062.680860]  irq_work_run+0x2c/0x40
[ 1062.684992]  flush_smp_call_function_queue+0xc0/0x100
[ 1062.690687]  generic_smp_call_function_single_interrupt+0x13/0x30
[ 1062.697430]  smp_call_function_single_interrupt+0x3e/0xe0
[ 1062.703485]  call_function_single_interrupt+0xf/0x20
[ 1062.709100]  </IRQ>
[ 1062.711851] RIP: 0010:panic+0x1fe/0x244
[ 1062.716329] Code: eb a6 83 3d 17 bc af 01 00 74 05 e8 b0 72 02 00 48 c7 c6 2f
[ 1062.736366] RSP: 0018:ffffaa2b98c0fe60 EFLAGS: 00000286 ORIG_RAX: ffffffffff4
[ 1062.744571] RAX: 000000000000004a RBX: ffff99693243bc00 RCX: 0000000000000006
[ 1062.752328] RDX: 0000000000000000 RSI: 0000000000000096 RDI: ffff996940b96420
[ 1062.760077] RBP: ffffaa2b98c0fed8 R08: 000000000000002c R09: 0000000000aaaaaa
[ 1062.767814] R10: 0000000000000040 R11: 0000000000000001 R12: 0000000000000000
[ 1062.775536] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000046
[ 1062.783236]  do_exit+0x886/0xb20
[ 1062.787023]  ? cpu_startup_entry+0x73/0x80
[ 1062.791659]  rewind_stack_do_exit+0x17/0x20
[ 1062.796364] ---[ end trace 3462ef57e3394c50 ]---
[ 1062.801485] ------------[ cut here ]------------
[ 1062.806599] sched: Unexpected reschedule of offline CPU#15!
[ 1062.812655] WARNING: CPU: 44 PID: 0 at /build/linux-4.19-0rc3.ag.4/arch/x86/0
[ 1062.825264] Modules linked in: act_police cls_basic ebtable_filter ebtables i
[ 1062.899387]  mac_hid coretemp lp parport btrfs zstd_compress raid456 async_ri
[ 1062.932747] CPU: 44 PID: 0 Comm: swapper/44 Tainted: G      D W  OE     4.19b
[ 1062.943874] Hardware name: Dell Inc. PowerEdge R640/0W23H8, BIOS 1.2.11 10/17
[ 1062.952057] RIP: 0010:native_smp_send_reschedule+0x3f/0x50
[ 1062.958164] Code: c0 84 c0 74 17 48 8b 05 ff d9 36 01 be fd 00 00 00 48 8b 40
[ 1062.978210] RSP: 0018:ffff996940b83de8 EFLAGS: 00010086
[ 1062.984093] RAX: 0000000000000000 RBX: ffff99c90f2a9e00 RCX: 0000000000000006
[ 1062.991894] RDX: 0000000000000007 RSI: 0000000000000086 RDI: ffff996940b96420
[ 1062.999695] RBP: ffff996940b83de8 R08: 000000000000002c R09: 0000000000aaaaaa
[ 1063.007501] R10: ffff996940b83dc8 R11: 0000000000000001 R12: ffff99c90f2aa934
[ 1063.015303] R13: 0000000000000004 R14: 0000000000000046 R15: 0000000000022d80
[ 1063.023110] FS:  0000000000000000(0000) GS:ffff996940b80000(0000) knlGS:00000
[ 1063.031881] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1063.038312] CR2: 0000000000000040 CR3: 00000064af40a006 CR4: 00000000007626e0
[ 1063.046138] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1063.053973] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1063.061796] PKRU: 55555554
[ 1063.065193] Call Trace:
[ 1063.068323]  <IRQ>
[ 1063.071021]  try_to_wake_up+0x3e3/0x4b0
[ 1063.075534]  default_wake_function+0x12/0x20
[ 1063.080485]  autoremove_wake_function+0x12/0x40
[ 1063.085682]  __wake_up_common+0x8c/0x130
[ 1063.090259]  __wake_up_common_lock+0x80/0xc0
[ 1063.095172]  __wake_up+0x13/0x20
[ 1063.099029]  wake_up_klogd_work_func+0x40/0x60
[ 1063.104100]  irq_work_run_list+0x55/0x80
[ 1063.108649]  irq_work_run+0x2c/0x40
[ 1063.112767]  flush_smp_call_function_queue+0xc0/0x100
[ 1063.118451]  generic_smp_call_function_single_interrupt+0x13/0x30
[ 1063.125174]  smp_call_function_single_interrupt+0x3e/0xe0
[ 1063.131209]  call_function_single_interrupt+0xf/0x20
[ 1063.136807]  </IRQ>
[ 1063.139535] RIP: 0010:panic+0x1fe/0x244
[ 1063.144009] Code: eb a6 83 3d 17 bc af 01 00 74 05 e8 b0 72 02 00 48 c7 c6 2f
[ 1063.164062] RSP: 0018:ffffaa2b98c0fe60 EFLAGS: 00000286 ORIG_RAX: ffffffffff4
[ 1063.172269] RAX: 000000000000004a RBX: ffff99693243bc00 RCX: 0000000000000006
[ 1063.180034] RDX: 0000000000000000 RSI: 0000000000000096 RDI: ffff996940b96420
[ 1063.187781] RBP: ffffaa2b98c0fed8 R08: 000000000000002c R09: 0000000000aaaaaa
[ 1063.195519] R10: 0000000000000040 R11: 0000000000000001 R12: 0000000000000000
[ 1063.203243] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000046
[ 1063.210950]  do_exit+0x886/0xb20
[ 1063.214736]  ? cpu_startup_entry+0x73/0x80
[ 1063.219371]  rewind_stack_do_exit+0x17/0x20
[ 1063.224076] ---[ end trace 3462ef57e3394c51 ]---
