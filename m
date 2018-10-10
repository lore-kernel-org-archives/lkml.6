Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE590C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A54E021470
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A54E021470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbeJJXGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 19:06:50 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:60508 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbeJJXGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 19:06:50 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gAGeZ-0002Fx-82; Wed, 10 Oct 2018 09:44:03 -0600
Received: from 67-3-154-154.omah.qwest.net ([67.3.154.154] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gAGeJ-0005Da-OB; Wed, 10 Oct 2018 09:44:03 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     linux-kernel@vger.kernel.org, LKP <lkp@01.org>
References: <20181010020641.GE13396@shao2-debian>
Date:   Wed, 10 Oct 2018 10:43:38 -0500
In-Reply-To: <20181010020641.GE13396@shao2-debian> (kernel test robot's
        message of "Wed, 10 Oct 2018 10:06:41 +0800")
Message-ID: <87sh1dvmc5.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gAGeJ-0005Da-OB;;;mid=<87sh1dvmc5.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=67.3.154.154;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+PrsXBn8DOzWdO7fY+P4lXgITC6XRN1XI=
X-SA-Exim-Connect-IP: 67.3.154.154
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [LKP] 4ce5f9c9e7 [ 1.323881] WARNING: CPU: 0 PID: 1 at mm/slab_common.c:1031 kmalloc_slab
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


So I am flummoxed.  I am reading through the code and I don't see
anything that could trigger this, and when I ran the supplied reproducer
it did not reproduce for me.

Plus there is the noise from the kmalloc_slab test that is goofing up
the subject line.

Is there any chance I can get a disassembly of the
copy_siginfo_from_user or post_copy_siginfo_from_user from your build?
I don't have the same tool chain.

Right now I am strongly suspecting that there is a memory stomp
somewhere and the earlier tests just happen on something that is the
pinpointed commit to misbehave.

Either that or it is simply that I don't have the latest and greatest
smep/smap hardware and there is an off by one I am not seeing.

I don't doubt that this test is finding something I haven't figured out
how to see what it is finding, and when I exercise the same code path
with my own tests everything appears to work.

Eric

kernel test robot <rong.a.chen@intel.com> writes:

> Greetings,
>
> 0day kernel testing robot got the below dmesg and the first bad commit is
>
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
>
> commit 4ce5f9c9e7546915c559ffae594e6d73f918db00
> Author:     Eric W. Biederman <ebiederm@xmission.com>
> AuthorDate: Tue Sep 25 12:59:31 2018 +0200
> Commit:     Eric W. Biederman <ebiederm@xmission.com>
> CommitDate: Wed Oct 3 16:50:39 2018 +0200
>
>     signal: Use a smaller struct siginfo in the kernel
>     
>     We reserve 128 bytes for struct siginfo but only use about 48 bytes on
>     64bit and 32 bytes on 32bit.  Someday we might use more but it is unlikely
>     to be anytime soon.
>     
>     Userspace seems content with just enough bytes of siginfo to implement
>     sigqueue.  Or in the case of checkpoint/restart reinjecting signals
>     the kernel has sent.
>     
>     Reducing the stack footprint and the work to copy siginfo around from
>     2 cachelines to 1 cachelines seems worth doing even if I don't have
>     benchmarks to show a performance difference.
>     
>     Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
>     Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
> ae7795bc61  signal: Distinguish between kernel_siginfo and siginfo
> 4ce5f9c9e7  signal: Use a smaller struct siginfo in the kernel
> 570b7bdeaf  Add linux-next specific files for 20181009
> +-------------------------------------------+------------+------------+---------------+
> |                                           | ae7795bc61 | 4ce5f9c9e7 | next-20181009 |
> +-------------------------------------------+------------+------------+---------------+
> | boot_successes                            | 0          | 0          | 28            |
> | boot_failures                             | 1144       | 280        | 8             |
> | WARNING:at_mm/slab_common.c:#kmalloc_slab | 1144       | 280        |               |
> | RIP:kmalloc_slab                          | 1144       | 280        |               |
> | Mem-Info                                  | 1144       | 280        | 8             |
> | BUG:unable_to_handle_kernel               | 0          | 5          | 7             |
> | Oops:#[##]                                | 0          | 7          | 8             |
> | RIP:copy_siginfo_from_user                | 0          | 7          |               |
> | Kernel_panic-not_syncing:Fatal_exception  | 0          | 7          | 8             |
> | RIP:post_copy_siginfo_from_user           | 0          | 0          | 8             |
> +-------------------------------------------+------------+------------+---------------+
>
> [    1.320405] test_overflow: ok: (s8)(0 << 7) == 0
> [    1.321071] test_overflow: ok: (s16)(0 << 15) == 0
> [    1.321756] test_overflow: ok: (int)(0 << 31) == 0
> [    1.322442] test_overflow: ok: (s32)(0 << 31) == 0
> [    1.323121] test_overflow: ok: (s64)(0 << 63) == 0
> [    1.323881] WARNING: CPU: 0 PID: 1 at mm/slab_common.c:1031 kmalloc_slab+0x17/0x70
> [    1.324113] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G                T 4.19.0-rc1-00077-g4ce5f9c #1
> [    1.324113] RIP: 0010:kmalloc_slab+0x17/0x70
> [    1.324113] Code: 00 00 00 83 3d 11 78 14 03 02 55 48 89 e5 5d 0f 97 c0 c3 55 48 81 ff 00 00 40 00 48 89 e5 76 0e 31 c0 81 e6 00 02 00 00 75 4b <0f> 0b eb 47 48 81 ff c0 00 00 00 77 19 48 85 ff b8 10 00 00 00 74
> [    1.324113] RSP: 0000:ffff88000fc7fd50 EFLAGS: 00010246
> [    1.324113] RAX: 0000000000000000 RBX: 00000000006000c0 RCX: ffff88001fb68d47
> [    1.324113] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffffffffffffffff
> [    1.324113] RBP: ffff88000fc7fd50 R08: 00000000b128ac78 R09: 0000000000000001
> [    1.324113] R10: 0000000000000001 R11: 0000000000000000 R12: ffff88001d814800
> [    1.324113] R13: 0000000000000000 R14: ffffffff836e16f4 R15: 0000000000000001
> [    1.324113] FS:  0000000000000000(0000) GS:ffff88001f000000(0000) knlGS:0000000000000000
> [    1.324113] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.324113] CR2: 0000000000000000 CR3: 0000000003012001 CR4: 00000000001606b0
> [    1.324113] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    1.324113] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [    1.324113] Call Trace:
> [    1.324113]  __kmalloc+0x10/0x130
> [    1.324113]  ? test_overflow_calculation+0x152b/0x152b
> [    1.324113]  test_module_init+0x1262/0x1dfa
> [    1.324113]  ? vprintk_emit+0x29e/0x2b0
> [    1.324113]  ? _kstrtoull+0x2c/0x70
> [    1.324113]  ? kstrtoll+0x4b/0x70
> [    1.324113]  ? kstrtos8+0x15/0x40
> [    1.324113]  ? test_overflow_calculation+0x152b/0x152b
> [    1.324113]  ? do_early_param+0x92/0x92
> [    1.324113]  do_one_initcall+0x65/0x130
> [    1.324113]  ? do_early_param+0x92/0x92
> [    1.324113]  kernel_init_freeable+0x1b5/0x250
> [    1.324113]  ? rest_init+0xf0/0xf0
> [    1.324113]  kernel_init+0x9/0xf0
> [    1.324113]  ret_from_fork+0x35/0x40
> [    1.324113] _warn_unseeded_randomness: 1 callbacks suppressed
> [    1.324113] random: get_random_bytes called from print_oops_end_marker+0x21/0x50 with crng_init=0
> [    1.324113] ---[ end trace 8ef06e4cef93b260 ]---
> [    1.351969] test_overflow: kmalloc detected saturation
>
>                                                           # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
> git bisect start 570b7bdeaf18a5d66dc76d79d7f1e36cb10b5da0 0238df646e6224016a45505d2c111a24669ebe21 --
> git bisect good 073ceed8e5a6c9835a915549d248569067e11268  # 04:27  G    213     0  213 289  Merge remote-tracking branch 'opp/opp/linux-next'
> git bisect good fc708c9582d94983c6c908271390c9720ca3ec4c  # 04:42  G    216     0  216 293  Merge remote-tracking branch 'mailbox/mailbox-for-next'
> git bisect good 8c55f3646e42de506c5832d4ac8bf116ff3cb246  # 04:59  G    211     0  211 288  Merge remote-tracking branch 'char-misc/char-misc-next'
> git bisect  bad 616b28683e7f382c5dc8fa8ab7837fbd64ed261f  # 04:59  B      0     7   93  72  Merge remote-tracking branch 'userns/for-next'
> git bisect good 756752870e5af5586fecb5973a50db7f6ab96f91  # 05:23  G    212     0  212 289  Merge remote-tracking branch 'cgroup/for-next'
> git bisect good 50473600212c8bbd945d24a5f1fcb60e3e70c607  # 05:54  G    213     0  213 288  Merge remote-tracking branch 'rpmsg/for-next'
> git bisect good d112058d6e522116e9ba88c6962c7ce02d2c3d8f  # 06:17  G    209     0  209 286  Merge remote-tracking branch 'gpio/for-next'
> git bisect good 5ebcede43c9e797b6b3cb412f83fcbff65818ba9  # 06:33  G    215     0  215 294  Merge remote-tracking branch 'pinctrl/for-next'
> git bisect good cd60ab7abb3df301c4ff2cf7d619cf7e30cca289  # 06:46  G    210     0  210 289  signal/powerpc: Remove pkey parameter from __bad_area_nosemaphore
> git bisect good c852680959d0964198e829da80f012b3df43060c  # 06:57  G    208     0  208 285  signal/arm64: Use send_sig_fault where appropriate
> git bisect good 5ee527d7cefddebd72970d290e5cc06c9ae32890  # 07:20  G    209     0  209 286  signal/unicore32: Use send_sig_fault where appropriate
> git bisect good f28380185193610c716a90ec9b9e696638a495ce  # 07:39  G    208     0  208 283  signal: Remove the need for __ARCH_SI_PREABLE_SIZE and SI_PAD_SIZE
> git bisect good ae7795bc6187a15ec51cf258abae656a625f9980  # 07:54  G    216     0  216 291  signal: Distinguish between kernel_siginfo and siginfo
> git bisect  bad 601d5abfeaf244b86bb68c1e05c6e0d57be2f6b0  # 07:54  B      0     5   89  70  signal: In sigqueueinfo prefer sig not si_signo
> git bisect  bad 4ce5f9c9e7546915c559ffae594e6d73f918db00  # 07:54  B      0     5  294 275  signal: Use a smaller struct siginfo in the kernel
> # first bad commit: [4ce5f9c9e7546915c559ffae594e6d73f918db00] signal: Use a smaller struct siginfo in the kernel
> git bisect good ae7795bc6187a15ec51cf258abae656a625f9980  # 08:59  G    853     0  853 1144  signal: Distinguish between kernel_siginfo and siginfo
> # extra tests with debug options
> git bisect  bad 4ce5f9c9e7546915c559ffae594e6d73f918db00  # 09:21  B    156     1  156 158  signal: Use a smaller struct siginfo in the kernel
> # extra tests on HEAD of linux-next/master
> git bisect  bad 570b7bdeaf18a5d66dc76d79d7f1e36cb10b5da0  # 09:26  B     21     7    0   1  Add linux-next specific files for 20181009
> # extra tests on tree/branch linux-next/master
> git bisect  bad 570b7bdeaf18a5d66dc76d79d7f1e36cb10b5da0  # 09:27  B     21     7    0   1  Add linux-next specific files for 20181009
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/lkp                          Intel Corporation
