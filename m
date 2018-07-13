Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BFFECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FFDD2087C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:13:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FFDD2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=purdue.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731975AbeGMU3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 16:29:36 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:35698 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731564AbeGMU3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 16:29:34 -0400
Received: by mail-it0-f67.google.com with SMTP id l16-v6so13198768ita.0;
        Fri, 13 Jul 2018 13:13:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=CE8UKnFs4NuGFiz4GASL6BrgVutrdxOQOvs85mXjhhE=;
        b=Xr3wIGTHhLzl0fSrqYYxJAipqyjblLEjFwn7inT2yeiCu/INJ7dTs6CockpuN2HD4T
         GSWZZNlbhcx15vXF0st7EXk5BGqLlEVDDZm4rB16Y7MiYsfcaSN3FnWeqfS8B029+fzW
         LtMfp6viR/VY1IesY/amY+YKeuYQcm8Z+JGcNWb72CLnTgxp+cSWVs2G/mo00SK4s1Z/
         n45wtY8fHpN71zqklr33tJLSOqpHB3H9Hp1IFrEka90HkSRTde5vOfKEaeOB5lLzcLMO
         aqGMkc+gIsYTyJcWqrNBcAe9QdCL8B1zo7v3aCBpwLGGlb1glon7YNPqFWTO5ZpVXzMO
         5uxw==
X-Gm-Message-State: AOUpUlEVExzXR1SCByC/nHQIyDAvdi+RKF82getsJVj1+yp1Dib751UP
        p1HRVEg1EMTvgTlIRmjnwPA=
X-Google-Smtp-Source: AAOMgpeTjPYnOufiuBU9aV4LXUbYBGA6ZrR8hhFnu/x+Hje/7FFf/0aeyi+BFFx2/inW7+x3/joUOw==
X-Received: by 2002:a02:4d57:: with SMTP id l84-v6mr6790934jab.56.1531512805693;
        Fri, 13 Jul 2018 13:13:25 -0700 (PDT)
Received: from melon (melon.cs.purdue.edu. [128.10.126.30])
        by smtp.gmail.com with ESMTPSA id u23-v6sm10487126iob.0.2018.07.13.13.13.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 13:13:24 -0700 (PDT)
References: <87k1q4nnit.fsf@gmail.com>
User-agent: mu4e 1.1.0; emacs 24.5.1
From:   Byoungyoung Lee <byoungyoung@purdue.edu>
To:     netdev@vger.kernel.org, ubraun@linux.ibm.com,
        linux-s390@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        DaeRyong Jeong <threeearcat@gmail.com>,
        Kyungtae Kim <kt0755@gmail.com>,
        Basavesh Ammanaghatta Shivakumar <bammanag@purdue.edu>,
        syzkaller@googlegroups.com
Subject: Re: KASAN: null-ptr-deref Read in smc_ioctl
In-reply-to: <87k1q4nnit.fsf@gmail.com>
Date:   Fri, 13 Jul 2018 16:13:23 -0400
Message-ID: <87h8l27v30.fsf@purdue.edu>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Attached C repro code as well as its kernel config. It takes about 10-30
seconds to reproduce.

C repro: https://kiwi.cs.purdue.edu/static/race-fuzzer/null-ptr-deref-smc_ioctl.c
kernel config (v4.18-rc3): https://kiwi.cs.purdue.edu/static/race-fuzzer/null-ptr-deref-smc_ioctl.c


[  172.890255]
==================================================================
[  172.892790] BUG: KASAN: null-ptr-deref in smc_ioctl+0x5c5/0x7a0
[  172.894579] Read of size 4 at addr 0000000000000020 by task repro.exe/5499
[  172.896648]
[  172.897213] CPU: 0 PID: 5499 Comm: repro.exe Not tainted 4.18.0-rc3#1
[  172.899216] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.8.2-0-g33fbe13 by qemu-project.org 04/01/2014
[  172.902409] Call Trace:
[  172.903173]  dump_stack+0x18f/0x26c
[  172.904202]  ? dump_stack_print_info.cold.2+0x40/0x40
[  172.905712]  ? kasan_check_write+0x14/0x20
[  172.906926]  ? do_raw_spin_lock+0x9c/0x120
[  172.908111]  ? vprintk_func+0x81/0xe7
[  172.909202]  ? smc_ioctl+0x5c5/0x7a0
[  172.910244]  kasan_report.cold.7+0x13b/0x2f5
[  172.911472]  __asan_load4+0x78/0x80
[  172.912506]  smc_ioctl+0x5c5/0x7a0
[  172.913463]  ? smc_tx_prepared_sends+0x300/0x300
[  172.914722]  ? find_held_lock+0xca/0xf0
[  172.915809]  ? avc_has_extended_perms+0x6d6/0xec0
[  172.917072]  ? lock_downgrade+0x390/0x390
[  172.918156]  ? lock_release+0x550/0x550
[  172.919205]  ? kasan_check_read+0x11/0x20
[  172.920329]  ? rcu_report_qs_rnp+0x410/0x410
[  172.921504]  ? __lock_is_held+0x39/0xc0
[  172.922569]  ? avc_has_extended_perms+0x82b/0xec0
[  172.923887]  sock_do_ioctl+0xcc/0x380
[  172.924897]  ? compat_ifr_data_ioctl+0x150/0x150
[  172.926052]  ? avc_ss_reset+0x100/0x100
[  172.927033]  ? lock_downgrade+0x390/0x390
[  172.928057]  ? kasan_check_read+0x11/0x20
[  172.929076]  ? rcu_is_watching+0x9d/0xe0
[  172.930081]  ? rcu_report_qs_rnp+0x410/0x410
[  172.931174]  ? __sanitizer_cov_trace_switch+0x53/0x90
[  172.932464]  sock_ioctl+0x2bd/0x5a0
[  172.933363]  ? dlci_ioctl_set+0x40/0x40
[  172.934348]  ? ___might_sleep+0x1a4/0x280
[  172.935372]  ? check_same_owner+0x240/0x240
[  172.936452]  ? expand_files.part.8+0x750/0x750
[  172.937535]  ? rcu_note_context_switch+0x500/0x500
[  172.938684]  ? dlci_ioctl_set+0x40/0x40
[  172.939605]  do_vfs_ioctl+0x188/0xf80
[  172.940510]  ? ioctl_preallocate+0x200/0x200
[  172.941538]  ? selinux_capable+0x40/0x40
[  172.942475]  ? get_unused_fd_flags+0xdb/0x110
[  172.943535]  ? __x64_sys_futex+0x3cb/0x540
[  172.944536]  ? __sanitizer_cov_trace_const_cmp4+0x16/0x20
[  172.945818]  ksys_ioctl+0xa9/0xd0
[  172.946636]  __x64_sys_ioctl+0x43/0x50
[  172.947570]  do_syscall_64+0x182/0x540
[  172.948490]  ? syscall_return_slowpath+0x3f0/0x3f0
[  172.949596]  ? __sanitizer_cov_trace_const_cmp4+0x16/0x20
[  172.950798]  ? syscall_return_slowpath+0x266/0x3f0
[  172.951867]  ? mark_held_locks+0x25/0xb0
[  172.952798]  ? entry_SYSCALL_64_after_hwframe+0x59/0xbe
[  172.953967]  ? trace_hardirqs_off_caller+0xb5/0x120
[  172.955059]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  172.956121]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  172.957263] RIP: 0033:0x452a09
[  172.957961] Code: e8 dc f8 01 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f
05 <48> 3d 01 f0 ff ff 0f 83 2b af fb ff c3 66 2e 0f 1f 84 00 00 00 00
[  172.962330] RSP: 002b:00007f40bc5cacd8 EFLAGS: 00000297 ORIG_RAX: 0000000000000010
[  172.963917] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000452a09
[  172.965405] RDX: 0000000020000180 RSI: 0000000000008905 RDI: 0000000000000058
[  172.966883] RBP: 00007f40bc5cad10 R08: 0000000000000000 R09: 0000000000000000
[  172.968369] R10: 0000000000000000 R11: 0000000000000297 R12: 0000000000000000
[  172.969862] R13: 0000000000000000 R14: 00007f40bc5cb9c0 R15: 00007f40bc5cb700


Thanks,
Byoungyoung


Byoungyoung Lee <lifeasageek@gmail.com> writes:

> Reporting the crash: KASAN: null-ptr-deref Read in smc_ioctl
>
> This crash has been found in v4.18-rc3 using RaceFuzzer (a modified
> version of Syzkaller), which we describe more at the end of this
> report.
>
> Our analysis shows that the race occurs when invoking two syscalls
> concurrently, ioctl$sock_inet_tcp_SIOCATMARK() and listen(). More
> specifically, two code lines, `if (smc->sk.sk_state == SMC_LISTEN)` in
> smc_ioctl() and `sk->sk_state = SMC_LISTEN` in smc_listen() are racing
> as switching its execution order results in different execution
> behaviors, which in turn raises null-ptr-deref.  More details on the
> thread interleaving raising the crash are follows.
>
> Thread interleaving:
> CPU0 (smc_ioctl)                                        CPU1 (smc_listen)
> =====							=====
>
> // net/smc/af_smc.c#L1524 (v4.18-rc3)
> if (smc->sk.sk_state == SMC_LISTEN)
>
>                                                         // net/smc/af_smc.c#L1106 (v4.18-rc3)
>                                                         sk->sk_state = SMC_LISTEN;
>                                                         // ...
>                                                         release_sock(lsk);
>
> if (smc->sk.sk_state == SMC_INIT ||
>     smc->sk.sk_state == SMC_CLOSED) {
>   // ...
> } else {
>
>   // ...
>   answ = smc_curs_diff(conn->rmb_desc->len, // null-ptr-deref
>                        &cons, &urg) == 1;
> }
>
> Note that all the other cases in smc_ioctl() seem to have similar race
> issues. For example, running the SIOCOUTQNSD case leads to yet another
> crashes, such as "KASAN: null-ptr-deref Read in smc_tx_prepared_sends"
> or "general protection fault in smc_tx_prepared_sends". In particular,
> "general protection fault in smc_tx_prepared_sends" is recently
> spotted by Syzkaller
> (https://syzkaller.appspot.com/bug?id=02252298a71214aad90c45a91f86ad3d3c9c3588).
>
> ==================================================================
> BUG: KASAN: null-ptr-deref in smc_ioctl+0x5c5/0x7a0 net/smc/af_smc.c:1536
> Read of size 4 at addr 0000000000000020 by task syz-executor0/5046
>
> CPU: 0 PID: 5046 Comm: syz-executor0 Not tainted 4.18.0-rc3 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.8.2-0-g33fbe13 by qemu-project.org 04/01/2014
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x18f/0x26c lib/dump_stack.c:113
>  kasan_report_error mm/kasan/report.c:352 [inline]
>  kasan_report.cold.7+0x13b/0x2f5 mm/kasan/report.c:412
>  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
>  __asan_load4+0x78/0x80 mm/kasan/kasan.c:698
>  smc_ioctl+0x5c5/0x7a0 net/smc/af_smc.c:1536
>  sock_do_ioctl+0xcc/0x380 net/socket.c:969
>  sock_ioctl+0x2bd/0x5a0 net/socket.c:1093
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  file_ioctl fs/ioctl.c:500 [inline]
>  do_vfs_ioctl+0x188/0xf80 fs/ioctl.c:684
>  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
>  __do_sys_ioctl fs/ioctl.c:708 [inline]
>  __se_sys_ioctl fs/ioctl.c:706 [inline]
>  __x64_sys_ioctl+0x43/0x50 fs/ioctl.c:706
>  do_syscall_64+0x182/0x540 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x44b939
> Code: 8d 6b fc ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 5b 6b fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f6708050b48 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 000000000071bee0 RCX: 000000000044b939
> RDX: 0000000020000180 RSI: 0000000000008905 RDI: 0000000000000015
> RBP: 00000000000066a8 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f67080516d4
> R13: 00000000ffffffff R14: 00000000006f2748 R15: 0000000000000001
> ==================================================================
>
> = About RaceFuzzer
>
> RaceFuzzer is a customized version of Syzkaller, specifically tailored
> to find race condition bugs in the Linux kernel. While we leverage
> many different technique, the notable feature of RaceFuzzer is in
> leveraging a custom hypervisor (QEMU/KVM) to interleave the
> scheduling. In particular, we modified the hypervisor to intentionally
> stall a per-core execution, which is similar to supporting per-core
> breakpoint functionality. This allows RaceFuzzer to force the kernel
> to deterministically trigger racy condition (which may rarely happen
> in practice due to randomness in scheduling).
>
> RaceFuzzer's C repro always pinpoints two racy syscalls. Since C
> repro's scheduling synchronization should be performed at the user
> space, its reproducibility is limited (reproduction may take from 1
> second to 10 minutes (or even more), depending on a bug). This is
> because, while RaceFuzzer precisely interleaves the scheduling at the
> kernel's instruction level when finding this bug, C repro cannot fully
> utilize such a feature. Please disregard all code related to
> "should_hypercall" in the C repro, as this is only for our debugging
> purposes using our own hypervisor.

