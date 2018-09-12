Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E086BC04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F2220882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="Vsz7BPWc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78F2220882
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=digitalocean.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbeILF0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 01:26:38 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37368 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbeILF0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 01:26:38 -0400
Received: by mail-pl1-f196.google.com with SMTP id f1-v6so78528plt.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 17:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=CDPY18wFjlMDcPW8MAAOnllfzB3sq2RULZnrHVbLCf0=;
        b=Vsz7BPWcCPrZ0Q4LUMadCF5Jtj93K9I6Wj90FdBcXLl6B4WjPpxUJwqggAF9FAe0mh
         nY3jJHFqPf00JYJL9Fijt3lcWYMfgZLBH5mj93w0X6iaQ3OxfaAZLvcSVKNOve9mhNhg
         APA9GWrPRG01pPYQtvLYsjiKp6HkNbLVPTC/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CDPY18wFjlMDcPW8MAAOnllfzB3sq2RULZnrHVbLCf0=;
        b=qUoAwewlUOiTaLtmAcz2FhbzEXMUifzcw9po4qZd3UDaG+BqokhORbCaq6qTdKTwrt
         lJhuTQz6rGetgbjuAPEiFp7nywmqRdmIJiHoVMD3AFD6gz59KejjlJWWdwoNsulHWM7S
         IzWpaM6EWuPyWgQP+Qk83qxYKGJgS1r4ORV5aXAfRe12Gb6rYjOuLA8nSySiYedFA9o9
         k6xoGIgVyKq1o1q7qLkxTxqC4YbBLCPSJWP+lh5HjIBbsWB1/i22NRpNk0lkoIDqEfNU
         9EsOWIOliSx+7HNj7+J7NajdYDR4V6PYy8PqJ6GxFzY/WcmBMzkiz2fa30UfcTiueMFM
         AjYg==
X-Gm-Message-State: APzg51CKUCtM/CjuJ3E3G3cKqomK0ciiYnOc/Xlo5PEQRP+pQxxSYIXE
        i4vh1oKDKVsLRS7drJlBZ1i3DA==
X-Google-Smtp-Source: ANB0VdYeyQur6Z7ct+u7aedvbzQVURLO+jDl5jffJRHG++e1X2LS/9oUn0qrJ9GQWyi6+hHl31ZeBg==
X-Received: by 2002:a17:902:a507:: with SMTP id s7-v6mr29042302plq.303.1536711890961;
        Tue, 11 Sep 2018 17:24:50 -0700 (PDT)
Received: from breakout.internal.digitalocean.com (97-120-204-225.ptld.qwest.net. [97.120.204.225])
        by smtp.gmail.com with ESMTPSA id 143-v6sm30298261pfy.156.2018.09.11.17.24.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 17:24:50 -0700 (PDT)
Received: by breakout.internal.digitalocean.com (Postfix, from userid 1000)
        id 488BA8A2A78; Tue, 11 Sep 2018 17:24:49 -0700 (PDT)
Date:   Tue, 11 Sep 2018 17:24:49 -0700
From:   Nishanth Aravamudan <naravamudan@digitalocean.com>
To:     Jan =?iso-8859-1?Q?H=2E_Sch=F6nherr?= <jschoenh@amazon.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 00/60] Coscheduling for Linux
Message-ID: <20180912002449.GA21797@breakout>
References: <20180907214047.26914-1-jschoenh@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180907214047.26914-1-jschoenh@amazon.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ I am not subscribed to LKML, please keep me CC'd on replies ]

On 07.09.2018 [23:39:47 +0200], Jan H. Schönherr wrote:
> This patch series extends CFS with support for coscheduling. The
> implementation is versatile enough to cover many different
> coscheduling use-cases, while at the same time being non-intrusive, so
> that behavior of legacy workloads does not change.

I tried a simple test with several VMs (in my initial test, I have 48
idle 1-cpu 512-mb VMs and 2 idle 2-cpu, 2-gb VMs) using libvirt, none
pinned to any CPUs. When I tried to set all of the top-level libvirt cpu
cgroups' to be co-scheduled (/bin/echo 1 >
/sys/fs/cgroup/cpu/machine/<VM-x>.libvirt-qemu/cpu.scheduled), the
machine hangs. This is using cosched_max_level=1.

There are several moving parts there, so I tried narrowing it down, by
only coscheduling one VM, and thing seemed fine:

/sys/fs/cgroup/cpu/machine/<VM-1>.libvirt-qemu# echo 1 > cpu.scheduled 
/sys/fs/cgroup/cpu/machine/<VM-1>.libvirt-qemu# cat cpu.scheduled 
1

One thing that is not entirely obvious to me (but might be completely
intentional) is that since by default the top-level libvirt cpu cgroups
are empty:

/sys/fs/cgroup/cpu/machine/<VM-1>.libvirt-qemu# cat tasks 

the result of this should be a no-op, right? [This becomes relevant
below] Specifically, all of the threads of qemu are in sub-cgroups,
which do not indicate they are co-scheduling:

/sys/fs/cgroup/cpu/machine/<VM-1>.libvirt-qemu# cat emulator/cpu.scheduled 
0
/sys/fs/cgroup/cpu/machine/<VM-1>.libvirt-qemu# cat vcpu0/cpu.scheduled 
0

When I then try to coschedule the second VM, the machine hangs.

/sys/fs/cgroup/cpu/machine/<VM-2>.libvirt-qemu# echo 1 > cpu.scheduled 
Timeout, server <HOST> not responding.

On the console, I see the same backtraces I see when I try to set all of
the VMs to be coscheduled:

[  144.494091] watchdog: BUG: soft lockup - CPU#87 stuck for 22s! [CPU 0/KVM:25344]
[  144.507629] Modules linked in: act_police cls_basic ebtable_filter ebtables ip6table_filter iptable_filter nbd ip6table_raw ip6_tables xt_CT iptable_raw ip_tables s
[  144.578858]  xxhash raid10 raid0 multipath linear raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor ses raid6_pq enclosure libcrc32c raid1 scsi
[  144.599227] CPU: 87 PID: 25344 Comm: CPU 0/KVM Tainted: G           O      4.19.0-rc2-amazon-cosched+ #1
[  144.608819] Hardware name: Dell Inc. PowerEdge R640/0W23H8, BIOS 1.4.9 06/29/2018
[  144.616403] RIP: 0010:smp_call_function_single+0xa7/0xd0
[  144.621818] Code: 01 48 89 d1 48 89 f2 4c 89 c6 e8 64 fe ff ff c9 c3 48 89 d1 48 89 f2 48 89 e6 e8 54 fe ff ff 8b 54 24 18 83 e2 01 74 0b f3 90 <8b> 54 24 18 83 e25
[  144.640703] RSP: 0018:ffffb2a4a75abb40 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
[  144.648390] RAX: 0000000000000000 RBX: 0000000000000057 RCX: 0000000000000000
[  144.655607] RDX: 0000000000000001 RSI: 00000000000000fb RDI: 0000000000000202
[  144.662826] RBP: ffffb2a4a75abb60 R08: 0000000000000000 R09: 0000000000000f39
[  144.670073] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8a9c03fc8000
[  144.677301] R13: ffff8ab4589dc100 R14: 0000000000000057 R15: 0000000000000000
[  144.684519] FS:  00007f51cd41a700(0000) GS:ffff8ab45fac0000(0000) knlGS:0000000000000000
[  144.692710] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  144.698542] CR2: 000000c4203c0000 CR3: 000000178a97e005 CR4: 00000000007626e0
[  144.705771] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  144.712989] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  144.720215] PKRU: 55555554
[  144.723016] Call Trace:
[  144.725553]  ? vmx_sched_in+0xc0/0xc0 [kvm_intel]
[  144.730341]  vmx_vcpu_load+0x244/0x310 [kvm_intel]
[  144.735220]  ? __switch_to_asm+0x40/0x70
[  144.739231]  ? __switch_to_asm+0x34/0x70
[  144.743235]  ? __switch_to_asm+0x40/0x70
[  144.747240]  ? __switch_to_asm+0x34/0x70
[  144.751243]  ? __switch_to_asm+0x40/0x70
[  144.755246]  ? __switch_to_asm+0x34/0x70
[  144.759250]  ? __switch_to_asm+0x40/0x70
[  144.763272]  ? __switch_to_asm+0x34/0x70
[  144.767284]  ? __switch_to_asm+0x40/0x70
[  144.771296]  ? __switch_to_asm+0x34/0x70
[  144.775299]  ? __switch_to_asm+0x40/0x70
[  144.779313]  ? __switch_to_asm+0x34/0x70
[  144.783317]  ? __switch_to_asm+0x40/0x70
[  144.787338]  kvm_arch_vcpu_load+0x40/0x270 [kvm]
[  144.792056]  finish_task_switch+0xe2/0x260
[  144.796238]  __schedule+0x316/0x890
[  144.799810]  schedule+0x32/0x80
[  144.803039]  kvm_vcpu_block+0x7a/0x2e0 [kvm]
[  144.807399]  kvm_arch_vcpu_ioctl_run+0x1a7/0x1990 [kvm]
[  144.812705]  ? futex_wake+0x84/0x150
[  144.816368]  kvm_vcpu_ioctl+0x3ab/0x5d0 [kvm]
[  144.820810]  ? wake_up_q+0x70/0x70
[  144.824311]  do_vfs_ioctl+0x92/0x600
[  144.827985]  ? syscall_trace_enter+0x1ac/0x290
[  144.832517]  ksys_ioctl+0x60/0x90
[  144.835913]  ? exit_to_usermode_loop+0xa6/0xc2
[  144.840436]  __x64_sys_ioctl+0x16/0x20
[  144.844267]  do_syscall_64+0x55/0x110
[  144.848012]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  144.853160] RIP: 0033:0x7f51cf82bea7
[  144.856816] Code: 44 00 00 48 8b 05 e1 cf 2c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff8
[  144.875752] RSP: 002b:00007f51cd419a18 EFLAGS: 00000246 ORIG_RAX: 0000000000000010

I am happy to do any further debugging I can do, or try patches on top
of those posted on the mailing list.

Thanks,
Nish
