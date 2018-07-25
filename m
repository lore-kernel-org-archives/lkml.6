Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0F7C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00EAA2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="W5QihBnC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00EAA2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbeGYUcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 16:32:23 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50530 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729354AbeGYUcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 16:32:23 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6PJHvMt001442;
        Wed, 25 Jul 2018 12:18:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=sFglfcdk6hTnvDrNm6gpJVY5INnhD08DZ4EVOOU/Ddw=;
 b=W5QihBnCiJML8eu/l3Ub9x7iaGz3fprRfMe519n6r8zvKD5hdu5kUx5t96CZ9AWMlh8g
 4ZZmMqYkPX0XqBYkf1VG1Bwg9+1gqfXPRpBdDlLqGWqH024xk0t3FZOsipWT48TOUR+U
 eNdCR2d+133EmbioR/n9BVkYY4OW7Y/7/X8= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kewsdr956-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 25 Jul 2018 12:18:54 -0700
Received: from kafai-mbp.dhcp.thefacebook.com (192.168.52.123) by
 mail.TheFacebook.com (192.168.16.17) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Wed, 25 Jul 2018 12:18:51 -0700
Date:   Wed, 25 Jul 2018 12:18:47 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
CC:     <netdev@vger.kernel.org>, <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <rostedt@goodmis.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: selftests: bpf: test_progs: deadlock at trace_call_bpf
Message-ID: <20180725191847.z2plxuggbptf7mgb@kafai-mbp.dhcp.thefacebook.com>
References: <CA+G9fYs-AzZ4x2x8m5kOYaEg_vagaorjQAkWs9C5ghOnCLYZvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CA+G9fYs-AzZ4x2x8m5kOYaEg_vagaorjQAkWs9C5ghOnCLYZvA@mail.gmail.com>
User-Agent: NeoMutt/20180512
X-Originating-IP: [192.168.52.123]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-25_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 02:51:42PM +0530, Naresh Kamboju wrote:
> Deadlock warning on x86 machine while testing selftests: bpf:
> test_progs and running linux next 4.18.0-rc3-next-20180705 and still
> happening on 4.18.0-rc5-next-20180720.
> 
> Any one noticed this kernel warning about deadlock ?
It should be a false positive.  The head->lock is a percpu
lock and is acquired by the bpf prog running on that cpu when
updating a bpf htab.  Hence, CPU0 and CPU1 are acquiring
a different head->lock.

When looking at a CPU alone, another bpf prog cannot start
running on the same CPU before the currently running bpf prog
has finished.  e.g. There is a percpu "bpf_prog_active" counter
to ensure that in the tracing side.

The head->lock is primary used in bpf htab update which
is used very heavily in most of the bpf progs.  Hence,
replacing the lock with the irqsave version is unnecessary
while having performance impact.

Thanks,
Martin

> 
> selftests: bpf: test_progs
> libbpf: incorrect bpf_call opcode
> libbpf: incorrect bpf_call opcode
> test_pkt_access:FAIL:ipv4 err 0 errno 2 retval 0 duration 126
> test_pkt_access:FAIL:ipv6 err 0 errno 2 retval 0 duration 115
> test_xdp:FAIL:ipv4 err 0 errno 2 retval 3 size 74
> test_xdp:FAIL:ipv6 err 0 errno 2 retval 3 size 114
> test_xdp_adjust_tail:FAIL:ipv4 err 0 errno 2 retval 1 size 54
> test_xdp_adjust_tail:FAIL:ipv6 err 0 errno 2 retval 3 siz[   69.901655]
> [   69.903862] ========================================================
> [   69.910213] WARNING: possible irq lock inversion dependency detected
> [   69.916559] 4.18.0-rc3-next-20180705 #1 Not tainted
> [   69.921428] --------------------------------------------------------
> [   69.927774] dd/2928 just changed the state of lock:
> [   69.932643] 0000000022eeb38d (&head->lock){+...}, at:
> pcpu_freelist_push+0x28/0x50
> [   69.940208] but this lock was taken by another, HARDIRQ-safe lock
> in the past:
> [   69.947420]  (&rq->lock){-.-.}
> [   69.947421]
> [   69.947421]
> [   69.947421] and interrupts could create inverse lock ordering between them.
> [   69.947421]
> [   69.961842]
> [   69.961842] other info that might help us debug this:
> [   69.968357]  Possible interrupt unsafe locking scenario:
> [   69.968357]
> [   69.975136]        CPU0                    CPU1
> [   69.979659]        ----                    ----
> [   69.984184]   lock(&head->lock);
> [   69.987406]                                local_irq_disable();
> [   69.993319]                                lock(&rq->lock);
> [   69.998882]                                lock(&head->lock);
> [   70.004618]   <Interrupt>
> [   70.007235]     lock(&rq->lock);
> [   70.010461]
> [   70.010461]  *** DEADLOCK ***
> [   70.010461]
> [   70.016372] 1 lock held by dd/2928:
> [   70.019856]  #0: 00000000ab9293c8 (rcu_read_lock){....}, at:
> trace_call_bpf+0x37/0x1d0
> [   70.027768]
> [   70.027768] the shortest dependencies between 2nd lock and 1st lock:
> [   70.035586]  -> (&rq->lock){-.-.} ops: 1401365 {
> [   70.040204]     IN-HARDIRQ-W at:
> [   70.043428]                       lock_acquire+0xd5/0x1c0
> [   70.048820]                       _raw_spin_lock+0x2f/0x40
> [   70.054299]                       scheduler_tick+0x51/0xf0
> [   70.059781]                       update_process_times+0x47/0x60
> [   70.065779]                       tick_periodic+0x2b/0xc0
> [   70.071171]                       tick_handle_periodic+0x25/0x70
> [   70.077168]                       timer_interrupt+0x15/0x20
> [   70.082731]                       __handle_irq_event_percpu+0x48/0x320
> [   70.089250]                       handle_irq_event_percpu+0x32/0x80
> [   70.095505]                       handle_irq_event+0x39/0x60
> [   70.101157]                       handle_level_irq+0x7f/0x100
> [   70.106893]                       handle_irq+0x6f/0x110
> [   70.112112]                       do_IRQ+0x5c/0x110
> [   70.116982]                       ret_from_intr+0x0/0x1d
> [   70.122286]                       _raw_spin_unlock_irqrestore+0x38/0x50
> [   70.128891]                       __setup_irq+0x45d/0x700
> [   70.134281]                       setup_irq+0x4c/0x90
> [   70.139324]                       hpet_time_init+0x25/0x37
> [   70.144803]                       x86_late_time_init+0xf/0x1c
> [   70.150538]                       start_kernel+0x40c/0x4ca
> [   70.156017]                       x86_64_start_reservations+0x24/0x26
> [   70.162445]                       x86_64_start_kernel+0x6f/0x72
> [   70.168357]                       secondary_startup_64+0xa4/0xb0
> [   70.174356]     IN-SOFTIRQ-W at:
> [   70.177578]                       lock_acquire+0xd5/0x1c0
> [   70.182970]                       _raw_spin_lock+0x2f/0x40
> [   70.188448]                       try_to_wake_up+0x31b/0x540
> [   70.194097]                       wake_up_process+0x15/0x20
> [   70.199661]                       swake_up_locked+0x24/0x40
> [   70.205226]                       swake_up_one+0x1f/0x30
> [   70.210530]                       rcu_gp_kthread_wake+0x3b/0x40
> [   70.216441]                       rcu_accelerate_cbs_unlocked+0x9c/0xe0
> [   70.223048]                       rcu_process_callbacks+0x111/0x10c0
> [   70.229396]                       __do_softirq+0xbf/0x493
> [   70.234788]                       irq_exit+0xc3/0xd0
> [   70.239743]                       smp_apic_timer_interrupt+0x93/0x2a0
> [   70.246176]                       apic_timer_interrupt+0xf/0x20
> [   70.252084]                       console_unlock+0x4e8/0x620
> [   70.257737]                       vprintk_emit+0x254/0x430
> [   70.263214]                       vprintk_default+0x1f/0x30
> [   70.268776]                       vprintk_func+0x27/0x60
> [   70.274082]                       printk+0x52/0x6e
> [   70.278864]                       native_cpu_up+0x71b/0x7a0
> [   70.284431]                       bringup_cpu+0x2a/0xb0
> [   70.289648]                       cpuhp_invoke_callback+0xb2/0xb20
> [   70.295818]                       _cpu_up+0xae/0x160
> [   70.300776]                       do_cpu_up+0x8d/0xb0
> [   70.305818]                       cpu_up+0x13/0x20
> [   70.310602]                       smp_init+0x67/0xc4
> [   70.315559]                       kernel_init_freeable+0x134/0x259
> [   70.321731]                       kernel_init+0xe/0x110
> [   70.326947]                       ret_from_fork+0x3a/0x50
> [   70.332339]     INITIAL USE at:
> [   70.335477]                      lock_acquire+0xd5/0x1c0
> [   70.340780]                      _raw_spin_lock_irqsave+0x3a/0x50
> [   70.346864]                      rq_attach_root+0x1b/0xc0
> [   70.352255]                      sched_init+0x310/0x432
> [   70.357472]                      start_kernel+0x26e/0x4ca
> [   70.362861]                      x86_64_start_reservations+0x24/0x26
> [   70.369207]                      x86_64_start_kernel+0x6f/0x72
> [   70.375048]                      secondary_startup_64+0xa4/0xb0
> [   70.380958]   }
> [   70.382710]   ... key      at: [<ffffffff8716faf8>] __key.69482+0x0/0x8
> [   70.389310]   ... acquired at:
> [   70.392364]    _raw_spin_lock+0x2f/0x40
> [   70.396192]    pcpu_freelist_pop+0x7a/0xd0
> [   70.400286]    bpf_get_stackid+0x1ca/0x470
> [   70.404383]    bpf_get_stackid_tp+0x11/0x20
> [   70.408559]    ___bpf_prog_run+0x7f2/0x1090
> [   70.412739]    __bpf_prog_run32+0x39/0x50
> [   70.416742]    trace_call_bpf+0xc8/0x1d0
> [   70.420659]    perf_trace_run_bpf_submit+0x42/0xb0
> [   70.425444]    perf_trace_sched_switch+0x116/0x190
> [   70.430227]    __schedule+0x6d8/0xa20
> [   70.433883]    schedule+0x3d/0x90
> [   70.437194]    worker_thread+0xd0/0x410
> [   70.441025]    kthread+0x10d/0x140
> [   70.444424]    ret_from_fork+0x3a/0x50
> [   70.448165]
> [   70.449658] -> (&head->lock){+...} ops: 61660 {
> [   70.454181]    HARDIRQ-ON-W at:
> [   70.457319]                     lock_acquire+0xd5/0x1c0
> [   70.462536]                     _raw_spin_lock+0x2f/0x40
> [   70.467841]                     pcpu_freelist_push+0x28/0x50
> [   70.473492]                     bpf_get_stackid+0x43a/0x470
> [   70.479054]                     bpf_get_stackid_tp+0x11/0x20
> [   70.484724]                     ___bpf_prog_run+0x7f2/0x1090
> [   70.490372]                     __bpf_prog_run32+0x39/0x50
> [   70.495852]                     trace_call_bpf+0xc8/0x1d0
> [   70.501243]                     perf_trace_run_bpf_submit+0x42/0xb0
> [   70.507500]                     perf_trace_urandom_read+0xbf/0x100
> [   70.513670]                     urandom_read+0x1ce/0x340
> [   70.518975]                     __vfs_read+0x37/0x160
> [   70.524027]                     vfs_read+0xa8/0x150
> [   70.528898]                     ksys_read+0x58/0xc0
> [   70.533766]                     __x64_sys_read+0x1a/0x20
> [   70.539092]                     do_syscall_64+0x4f/0x190
> [   70.544401]                     entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [   70.551092]    INITIAL USE at:
> [   70.554143]                    lock_acquire+0xd5/0x1c0
> [   70.559272]                    _raw_spin_lock+0x2f/0x40
> [   70.564491]                    pcpu_freelist_populate+0xb6/0x110
> [   70.570489]                    htab_map_alloc+0x3b6/0x4c0
> [   70.575878]                    map_create+0xf0/0x370
> [   70.580836]                    __x64_sys_bpf+0x10b/0x260
> [   70.586138]                    do_syscall_64+0x4f/0x190
> [   70.591356]                    entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [   70.597960]  }
> [   70.599624]  ... key      at: [<ffffffff87d4c5a0>] __key.11024+0x0/0x8
> [   70.606142]  ... acquired at:
> [   70.609104]    mark_lock+0x392/0x570
> [   70.612676]    __lock_acquire+0x5cd/0x13c0
> [   70.616767]    lock_acquire+0xd5/0x1c0
> [   70.620511]    _raw_spin_lock+0x2f/0x40
> [   70.624342]    pcpu_freelist_push+0x28/0x50
> [   70.628519]    bpf_get_stackid+0x43a/0x470
> [   70.632610]    bpf_get_stackid_tp+0x11/0x20
> [   70.636785]    ___bpf_prog_run+0x7f2/0x1090
> [   70.640965]    __bpf_prog_run32+0x39/0x50
> [   70.644969]    trace_call_bpf+0xc8/0x1d0
> [   70.648886]    perf_trace_run_bpf_submit+0x42/0xb0
> [   70.653668]    perf_trace_urandom_read+0xbf/0x100
> [   70.658366]    urandom_read+0x1ce/0x340
> [   70.662199]    __vfs_read+0x37/0x160
> [   70.665768]    vfs_read+0xa8/0x150
> [   70.669166]    ksys_read+0x58/0xc0
> [   70.672562]    __x64_sys_read+0x1a/0x20
> [   70.676393]    do_syscall_64+0x4f/0x190
> [   70.680223]    entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [   70.685440]
> [   70.686933]
> [   70.686933] stack backtrace:
> [   70.691283] CPU: 3 PID: 2928 Comm: dd Not tainted 4.18.0-rc3-next-20180705 #1
> [   70.698405] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.0b 07/27/2017
> [   70.705875] Call Trace:
> [   70.708321]  dump_stack+0x68/0x95
> [   70.711631]  print_irq_inversion_bug.part.41+0x1a5/0x1b1
> [   70.716935]  check_usage_backwards+0x14b/0x160
> [   70.721374]  mark_lock+0x392/0x570
> [   70.724771]  ? mark_lock+0x392/0x570
> [   70.728340]  ? print_shortest_lock_dependencies+0x1a0/0x1a0
> [   70.733904]  __lock_acquire+0x5cd/0x13c0
> [   70.737823]  ? find_get_entry+0x1a2/0x2f0
> [   70.741825]  lock_acquire+0xd5/0x1c0
> [   70.745397]  ? lock_acquire+0xd5/0x1c0
> [   70.749141]  ? pcpu_freelist_push+0x28/0x50
> [   70.753317]  _raw_spin_lock+0x2f/0x40
> [   70.756974]  ? pcpu_freelist_push+0x28/0x50
> [   70.761153]  pcpu_freelist_push+0x28/0x50
> [   70.765156]  bpf_get_stackid+0x43a/0x470
> [   70.769073]  bpf_get_stackid_tp+0x11/0x20
> [   70.773077]  ___bpf_prog_run+0x7f2/0x1090
> [   70.777083]  __bpf_prog_run32+0x39/0x50
> [   70.780912]  ? lock_acquire+0xd5/0x1c0
> [   70.784656]  trace_call_bpf+0xc8/0x1d0
> [   70.788399]  perf_trace_run_bpf_submit+0x42/0xb0
> [   70.793013]  perf_trace_urandom_read+0xbf/0x100
> [   70.797544]  urandom_read+0x1ce/0x340
> [   70.801202]  __vfs_read+0x37/0x160
> [   70.804598]  ? security_file_permission+0x8d/0xb0
> [   70.809297]  ? security_file_permission+0x8d/0xb0
> [   70.813993]  vfs_read+0xa8/0x150
> [   70.817218]  ksys_read+0x58/0xc0
> [   70.820442]  __x64_sys_read+0x1a/0x20
> [   70.824106]  do_syscall_64+0x4f/0x190
> [   70.827764]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [   70.832807] RIP: 0033:0x7f302526f160
> [   70.836378] Code: b6 fe ff ff 48 8d 3d 97 b1 08 00 48 83 ec 08 e8
> 66 d3 01 00 66 0f 1f 44 00 00 83 3d e9 15 2c 00 00 75 10 b8 00 00 00
> 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 7e 94 01 00 48 89
> 04 24
> [   70.855253] RSP: 002b:00007fff096fd4e8 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000000
> [   70.862812] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f302526f160
> [   70.869935] RDX: 0000000000000200 RSI: 000000000070f000 RDI: 0000000000000000
> [   70.877060] RBP: 0000000000000200 R08: 000000000070f000 R09: 0000000000711060
> [   70.884183] R10: 0000000000000871 R11: 0000000000000246 R12: 000000000070f000
> [   70.891306] R13: 0000000000000000 R14: 0000000000000200 R15: 0000000000000000
> e 54
> test_l4lb:FAIL:ipv4 err 0 errno 2 retval 7 size 54 magic 1234
> 
> Full kernel selftest test log,
> https://urldefense.proofpoint.com/v2/url?u=https-3A__lkft.validation.linaro.org_scheduler_job_314724-23L2142&d=DwIBaQ&c=5VD0RTtNlTh3ycd41b3MUw&r=VQnoQ7LvghIj0gVEaiQSUw&m=jZ-W3Sa5-4fLxWPWxGZCwCp8KROtodYFS8Hz01vayqc&s=N9XPdzKisD7r4k5e94WLyeOinbQRUkmhBtNx6Fj4jhQ&e=
> 
> Best regards
> Naresh Kamboju
