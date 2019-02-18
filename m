Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F71C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 131502177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+cXCya7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfBRThi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:37:38 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34341 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbfBRThi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 14:37:38 -0500
Received: by mail-pg1-f194.google.com with SMTP id i130so8959763pgd.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 11:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vdcSThFaeMfb6wVasgNi6YM0p3F8vSh8Rp64gail00w=;
        b=G+cXCya7YmWguTARbodt1d/g47JiuuXPbtIKvlZozwY5oHBi41tluWfGrzYpGqEY4w
         8MqBXOwD+kZTsYGRUstUDyXYVzj8uoAYiy0lNaMX/rwtoqyE1D7a9iz0l+WtVv9WQA/L
         /1o+1gVEdAMm4EuFOTZ9oVzrbbF4EjiU3EO22gEuOijtd9uGmVqlZXBkG3E22jVGJWt9
         kp6tpXcMJJadJdq6eVsIRArbKz2gKPxUamrb5TttLxCBxcBEzew+EhkBQ85ZrfNLI1uW
         Lu+xtp4cauMKEbuBOJytJni8NSd6ClrsfT79ie8TLi8M/6RkqyBR014YotFkzxssgs+L
         HWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vdcSThFaeMfb6wVasgNi6YM0p3F8vSh8Rp64gail00w=;
        b=AaWf9TcwjssqdL6Otw2vDSwZFPFLUMBFnuvhhyx3dZazaqoVFB11zWQM2asIxO8xJ3
         +Kic0gRUv+JbNsSLHXkQQZLwIcVT5+ujSKpRQ9xx/Z1dzsIaKYTG+GqFZ4IHBNdGfTND
         ARk+nKWFq/1Mndsp/NlFdsthnMghO/udyCAbe1Bg1ttHaDavXL/nwQ1U9uJfB6JXtKj0
         bdyFV0CiwLe5X0HzJjBVVQNcgwbxBUBELXXIsBKRFd3lM/5NzLO8wMY0cDny6C+Qb+nl
         Z3cn5i7aiHZEDVjraXz2Lq+wAoqKBuvrWQCPugPiu64wwpbRThRJobS7yPQqQbHq5agW
         Dhrw==
X-Gm-Message-State: AHQUAuYizOunzEbzgADUlgCoYYSXS/0X2dDxwQNYjPAPm6qaFYEazANJ
        0hmr2XtABN6mA/qH/TbX5jRMAd0P
X-Google-Smtp-Source: AHgI3IaNxYmeD9F2UFBEbRQ+3aQIC1QB+8lT7bbQlxNIdnsHlWPhaKdlO9QyB29CbCswPFF6PHf6qQ==
X-Received: by 2002:a63:4d4f:: with SMTP id n15mr20346091pgl.327.1550518656447;
        Mon, 18 Feb 2019 11:37:36 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h79sm21036867pfj.186.2019.02.18.11.37.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 11:37:35 -0800 (PST)
Date:   Mon, 18 Feb 2019 11:37:34 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ben Woodard <woodard@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] exec: increase BINPRM_BUF_SIZE to 256
Message-ID: <20190218193734.GA29983@roeck-us.net>
References: <20181112160931.GA28463@redhat.com>
 <20181112160956.GA28472@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112160956.GA28472@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 12, 2018 at 05:09:56PM +0100, Oleg Nesterov wrote:
> Large enterprise clients often times run applications out of networked
> file systems where the IT mandated layout of project volumes can end up
> leading to paths that are longer than 128 characters. Bumping this up to
> the next order of two solves this problem in all but the most egregious
> case while still fitting into a 512b slab.
> 
> Reported-by: Ben Woodard <woodard@redhat.com>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> Acked-by: Kees Cook <keescook@chromium.org>
> Acked-by: Michal Hocko <mhocko@suse.com>

Unfortunately, this patch causes one of my qemu emulations to crash.
The crash is not always seen, but at least with every other boot attempt.
Reverting the patch fixes the problem. Crash log and bisect results
are attached below.

For reference, here is the qemu command line. This is with qemu 3.1.

qemu-system-ppc -kernel vmlinux -M virtex-ml507 -m 256 -no-reboot \
	-initrd rootfs.cpio \
	-dtb arch/powerpc/boot/dts/virtex440-ml507.dtb \
	--append 'rdinit=/sbin/init panic=-1 mem=256M console=ttyS0' \
	-monitor none -nographic

Configuration is 44x/virtex5_defconfig with various debug options
enabled.

Guenter

---
bisect:

# bad: [cb916fc5eabf8832e05f73c246eb467259846ef0] Add linux-next specific files for 20190218
# good: [d13937116f1e82bf508a6325111b322c30c85eb9] Linux 5.0-rc6
git bisect start 'HEAD' 'v5.0-rc6'
# good: [8a076e150433e8623c844aef43b38889df81a503] Merge remote-tracking branch 'nand/nand/next'
git bisect good 8a076e150433e8623c844aef43b38889df81a503
# good: [3db519b877efbfa9d58e141a1049774ea56fc90b] Merge remote-tracking branch 'spi/for-next'
git bisect good 3db519b877efbfa9d58e141a1049774ea56fc90b
# good: [8033390e270f04ee300a6358dcbff633a0b99e2c] Merge remote-tracking branch 'staging/staging-next'
git bisect good 8033390e270f04ee300a6358dcbff633a0b99e2c
# good: [e8d89c35e4c67686ebe2471962e1bda2449fbad2] Merge remote-tracking branch 'kselftest/next'
git bisect good e8d89c35e4c67686ebe2471962e1bda2449fbad2
# good: [adf037fa027a2cfa841d358bf40e62fb124674f5] epoll: use rwlock in order to reduce ep_poll_callback() contention
git bisect good adf037fa027a2cfa841d358bf40e62fb124674f5
# good: [a69d64f0ccb8dc334debd1681d0f5f507f35cb83] Merge remote-tracking branch 'nvmem/for-next'
git bisect good a69d64f0ccb8dc334debd1681d0f5f507f35cb83
# bad: [521ffb22b5e3eefc5f4a44d540acf746d6233cde] Merge branch 'akpm-current/current'
git bisect bad 521ffb22b5e3eefc5f4a44d540acf746d6233cde
# good: [f5f8a43b28ac49c9182d5ed86724550bbaeff3e9] Merge remote-tracking branch 'kspp-gustavo/for-next/kspp'
git bisect good f5f8a43b28ac49c9182d5ed86724550bbaeff3e9
# bad: [e0fdf04adb0928a941210ba919507450e9eaf196] sysctl: handle overflow for file-max
git bisect bad e0fdf04adb0928a941210ba919507450e9eaf196
# good: [c427946e32843fa6f9e8a34ff8daf4076ccaebd6] ptrace: take into account saved_sigmask in PTRACE_{GET,SET}SIGMASK
git bisect good c427946e32843fa6f9e8a34ff8daf4076ccaebd6
# bad: [e42c7d9007a96ee56813a304ca5b6b38f3ba181c] kernel: workqueue: clarify wq_worker_last_func() caller requirements
git bisect bad e42c7d9007a96ee56813a304ca5b6b38f3ba181c
# good: [afcd760e9725f4846d10c243f29931d34faa660a] fs/exec.c: replace opencoded set_mask_bits()
git bisect good afcd760e9725f4846d10c243f29931d34faa660a
# bad: [6328cf069588d413c7cd56fa55243cd2a05a0d9d] exec-increase-binprm_buf_size-to-256-fix
git bisect bad 6328cf069588d413c7cd56fa55243cd2a05a0d9d
# bad: [2342f07a7a01eb302fc101664255c3a09dcfdfe9] exec: increase BINPRM_BUF_SIZE to 256
git bisect bad 2342f07a7a01eb302fc101664255c3a09dcfdfe9
# first bad commit: [2342f07a7a01eb302fc101664255c3a09dcfdfe9] exec: increase BINPRM_BUF_SIZE to 256

---
crash log:

...
[    8.240183] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    8.243094] romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
[    8.264478] ------------[ cut here ]------------
[    8.264517] DEBUG_LOCKS_WARN_ON(!current->hardirqs_enabled)
[    8.264794] WARNING: CPU: 0 PID: 354 at kernel/locking/lockdep.c:3754 check_flags.part.23+0x1cc/0x1f8
[    8.264832] Modules linked in:
[    8.264980] CPU: 0 PID: 354 Comm: modprobe Not tainted 5.0.0-rc6-next-20190218+ #2
[    8.265030] NIP:  c00771f4 LR: c00771f4 CTR: 00000000
[    8.265079] REGS: cfb23e00 TRAP: 0700   Not tainted  (5.0.0-rc6-next-20190218+)
[    8.265093] MSR:  00021000 <CE,ME>  CR: 28000222  XER: 20000000
[    8.265167] 
[    8.265167] GPR00: c00771f4 cfb23eb0 cf92a220 0000002f 00000001 c008b5e8 c118b816 0000002f 
[    8.265167] GPR08: 00021000 00000000 00000001 00000004 28000428 00000000 00000000 00000000 
[    8.265167] GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 bffd89b8 b7a2a688 
[    8.265167] GPR24: 00000000 00000001 00029000 ffffffff b79eb000 c0a1b1b4 cf92a220 c0a90000 
[    8.265271] NIP [c00771f4] check_flags.part.23+0x1cc/0x1f8
[    8.265289] LR [c00771f4] check_flags.part.23+0x1cc/0x1f8
[    8.265321] Call Trace:
[    8.265362] [cfb23eb0] [c00771f4] check_flags.part.23+0x1cc/0x1f8 (unreliable)
[    8.265472] [cfb23ec0] [c0079e18] lock_is_held_type+0x164/0x1a8
[    8.265521] [cfb23ee0] [c07aad64] __schedule+0x49c/0x870
[    8.265537] [cfb23f30] [c07ab16c] schedule+0x34/0x94
[    8.265551] [cfb23f40] [c000f95c] recheck+0x0/0x24
[    8.265633] --- interrupt: 901 at 0xb7a0281c
[    8.265633]     LR = 0xb7a2b854
[    8.265667] Instruction dump:
[    8.265783] 3c80c091 3c60c090 3884b100 38635d6c 4bfba3cd 0fe00000 4bffff6c 3c80c091 
[    8.265811] 3c60c090 3884b144 38635d6c 4bfba3b1 <0fe00000> 4bfffec8 3c80c091 3c60c090 
[    8.265864] irq event stamp: 354
[    8.265884] hardirqs last  enabled at (352): [<c00a472c>] rcu_core+0x6d8/0x738
[    8.265910] hardirqs last disabled at (353): [<c07b1d68>] __do_softirq+0x2f8/0x518
[    8.265928] softirqs last  enabled at (354): [<c07b1dd8>] __do_softirq+0x368/0x518
[    8.265949] softirqs last disabled at (327): [<c003717c>] irq_exit+0x128/0x134
[    8.265990] ---[ end trace 13c9ff51d41b9d3f ]---
[    8.266074] possible reason: unannotated irqs-on.
[    8.266091] irq event stamp: 354
[    8.266104] hardirqs last  enabled at (352): [<c00a472c>] rcu_core+0x6d8/0x738
[    8.266117] hardirqs last disabled at (353): [<c07b1d68>] __do_softirq+0x2f8/0x518
[    8.266129] softirqs last  enabled at (354): [<c07b1dd8>] __do_softirq+0x368/0x518
[    8.266142] softirqs last disabled at (327): [<c003717c>] irq_exit+0x128/0x134
[    8.376997] io scheduler mq-deadline registered
[    8.377091] io scheduler kyber registered
[    9.499525] String selftests succeeded
[    9.500387] test_firmware: interface ready
[    9.501040] test passed
[    9.502388] test_bitmap: test 13: input is '0-2047:128/256' OK, Time: 480
[    9.512115] test_bitmap: all 1524 tests passed
[    9.512492] test_uuid: all 18 tests passed
[    9.513657] crc32: CRC_LE_BITS = 64, CRC_BE BITS = 64
[    9.513680] crc32: self tests passed, processed 225944 bytes in 492400 nsec
[    9.514233] crc32c: CRC_LE_BITS = 64
[    9.514257] crc32c: self tests passed, processed 225944 bytes in 257883 nsec
[    9.562213] crc32_combine: 8373 self tests passed
[    9.608528] crc32c_combine: 8373 self tests passed
[    9.608847] glob: 64 self-tests passed, 0 failed
[    9.609064] rbtree testing
[    9.626316]  -> test 1 (latency of nnodes insert+delete): 6875 cycles
[    9.646472]  -> test 2 (latency of nnodes cached insert+delete): 8050 cycles
[    9.649627]  -> test 3 (latency of inorder traversal): 1241 cycles
[    9.649711]  -> test 4 (latency to fetch first node)
[    9.649730]         non-cached: 25 cycles
[    9.649748]         cached: 0 cycles
[    9.800745] augmented rbtree testing
[    9.836800]  -> test 1 (latency of nnodes insert+delete): 14408 cycles
[    9.873724]  -> test 2 (latency of nnodes cached insert+delete): 14749 cycles
[   10.097628] interval tree insert/remove
[   10.124548]  -> 10735 cycles
[   10.124572] interval tree search
[   10.345597]  -> 88388 cycles (2692 results)
[   10.570802] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[   10.579938] printk: console [ttyS0] disabled
[   10.581102] 83e00000.serial: ttyS0 at MMIO 0x83e01003 (irq = 20, base_baud = 6250000) is a 16550
[   10.615302] printk: console [ttyS0] enabled
[   10.658149] brd: module loaded
[   10.679108] loop: module loaded
[   10.681671] BUG: Kernel NULL pointer dereference at 0x00000040
[   10.681826] Faulting instruction address: 0xc0431480
[   10.682072] Oops: Kernel access of bad area, sig: 11 [#1]
[   10.682251] BE PAGE_SIZE=4K PREEMPT Xilinx Virtex440
[   10.682387] Modules linked in:
[   10.682528] CPU: 0 PID: 1 Comm: swapper Tainted: G        W         5.0.0-rc6-next-20190218+ #2
[   10.682733] NIP:  c0431480 LR: c043147c CTR: c0422ad8
[   10.682863] REGS: cf82fbe0 TRAP: 0300   Tainted: G        W          (5.0.0-rc6-next-20190218+)
[   10.683065] MSR:  00029000 <CE,EE,ME>  CR: 22000222  XER: 00000000
[   10.683236] DEAR: 00000040 ESR: 00000000 
[   10.683236] GPR00: c043147c cf82fc90 cf82ccc0 00000000 00000000 00000000 00000002 00000000 
[   10.683236] GPR08: 00000000 00000000 c04310bc 00000000 22000222 00000000 c0002c54 00000000 
[   10.683236] GPR16: 00000000 00000001 c09aa39c c09021b0 c09021dc 00000007 c0a68c08 00000000 
[   10.683236] GPR24: 00000001 ced6d400 ced6dcf0 c0815d9c 00000000 00000000 00000000 cedf0800 
[   10.684331] NIP [c0431480] blk_mq_run_hw_queue+0x28/0x114
[   10.684473] LR [c043147c] blk_mq_run_hw_queue+0x24/0x114
[   10.684602] Call Trace:
[   10.684671] [cf82fc90] [c043147c] blk_mq_run_hw_queue+0x24/0x114 (unreliable)
[   10.684854] [cf82fcc0] [c04315bc] blk_mq_run_hw_queues+0x50/0x7c
[   10.685002] [cf82fce0] [c0422b24] blk_set_queue_dying+0x30/0x68
[   10.685154] [cf82fcf0] [c0423ec0] blk_cleanup_queue+0x34/0x14c
[   10.685306] [cf82fd10] [c054d73c] ace_probe+0x3dc/0x508
[   10.685445] [cf82fd50] [c052d740] platform_drv_probe+0x4c/0xb8
[   10.685592] [cf82fd70] [c052abb0] really_probe+0x20c/0x32c
[   10.685728] [cf82fda0] [c052ae58] driver_probe_device+0x68/0x464
[   10.685877] [cf82fdc0] [c052b500] device_driver_attach+0xb4/0xe4
[   10.686024] [cf82fde0] [c052b5dc] __driver_attach+0xac/0xfc
[   10.686161] [cf82fe00] [c0528428] bus_for_each_dev+0x80/0xc0
[   10.686314] [cf82fe30] [c0529b3c] bus_add_driver+0x144/0x234
[   10.686457] [cf82fe50] [c052c46c] driver_register+0x88/0x15c
[   10.686610] [cf82fe60] [c09de288] ace_init+0x4c/0xac
[   10.686742] [cf82fe80] [c0002730] do_one_initcall+0xac/0x330
[   10.686888] [cf82fee0] [c09aafd0] kernel_init_freeable+0x34c/0x478
[   10.687043] [cf82ff30] [c0002c6c] kernel_init+0x18/0x114
[   10.687188] [cf82ff40] [c000f2f0] ret_from_kernel_thread+0x14/0x1c
[   10.687349] Instruction dump:
[   10.687435] 3863ffd4 4bfffd70 9421ffd0 7c0802a6 93c10028 7c9e2378 93e1002c 38810008 
[   10.687637] 7c7f1b78 90010034 4bfffc25 813f008c <81290040> 75290100 4182002c 80810008 
[   10.688056] ---[ end trace 13c9ff51d41b9d40 ]---
[   10.688230] 
[   11.688548] BUG: sleeping function called from invalid context at ./include/linux/cgroup-defs.h:726
[   11.688768] in_atomic(): 0, irqs_disabled(): 1, pid: 1, name: swapper
[   11.688913] INFO: lockdep is turned off.
[   11.689002] irq event stamp: 110526
[   11.689092] hardirqs last  enabled at (110525): [<c07b0fc4>] _raw_spin_unlock_irq+0x30/0x80
[   11.689277] hardirqs last disabled at (110526): [<c07aa964>] __schedule+0x9c/0x870
[   11.689460] softirqs last  enabled at (110390): [<c07b1dd8>] __do_softirq+0x368/0x518
[   11.689634] softirqs last disabled at (110361): [<c003717c>] irq_exit+0x128/0x134
[   11.689834] Preemption disabled at:
[   11.689848] [<c008b490>] wake_up_klogd+0x14/0x94
[   11.690084] CPU: 0 PID: 1 Comm: swapper Tainted: G      D W         5.0.0-rc6-next-20190218+ #2
[   11.690307] Call Trace:
[   11.690388] [cf82fb10] [c0060c38] ___might_sleep+0x210/0x284 (unreliable)
[   11.690560] [cf82fb30] [c0045198] exit_signals+0x28/0x140
[   11.690699] [cf82fb50] [c0033ff0] do_exit+0xb8/0xb20
[   11.690823] [cf82fba0] [c000b59c] die+0x214/0x274
[   11.690940] [cf82fbd0] [c000f44c] handle_page_fault+0x34/0x38
[   11.691085] --- interrupt: 300 at blk_mq_run_hw_queue+0x28/0x114
[   11.691085]     LR = blk_mq_run_hw_queue+0x24/0x114
[   11.691338] [cf82fcc0] [c04315bc] blk_mq_run_hw_queues+0x50/0x7c
[   11.691491] [cf82fce0] [c0422b24] blk_set_queue_dying+0x30/0x68
[   11.691641] [cf82fcf0] [c0423ec0] blk_cleanup_queue+0x34/0x14c
[   11.691794] [cf82fd10] [c054d73c] ace_probe+0x3dc/0x508
[   11.691999] [cf82fd50] [c052d740] platform_drv_probe+0x4c/0xb8
[   11.692175] [cf82fd70] [c052abb0] really_probe+0x20c/0x32c
[   11.692345] [cf82fda0] [c052ae58] driver_probe_device+0x68/0x464
[   11.692540] [cf82fdc0] [c052b500] device_driver_attach+0xb4/0xe4
[   11.692721] [cf82fde0] [c052b5dc] __driver_attach+0xac/0xfc
[   11.692890] [cf82fe00] [c0528428] bus_for_each_dev+0x80/0xc0
[   11.693058] [cf82fe30] [c0529b3c] bus_add_driver+0x144/0x234
[   11.693221] [cf82fe50] [c052c46c] driver_register+0x88/0x15c
[   11.693386] [cf82fe60] [c09de288] ace_init+0x4c/0xac
[   11.693531] [cf82fe80] [c0002730] do_one_initcall+0xac/0x330
[   11.693703] [cf82fee0] [c09aafd0] kernel_init_freeable+0x34c/0x478
[   11.693888] [cf82ff30] [c0002c6c] kernel_init+0x18/0x114
[   11.694043] [cf82ff40] [c000f2f0] ret_from_kernel_thread+0x14/0x1c
[   11.724430] BUG: sleeping function called from invalid context at kernel/nsproxy.c:221
[   11.724657] in_atomic(): 0, irqs_disabled(): 0, pid: 1, name: swapper
[   11.724821] INFO: lockdep is turned off.
[   11.724932] Preemption disabled at:
[   11.724977] [<00000000>]   (null)
[   11.725184] CPU: 0 PID: 1 Comm: swapper Tainted: G      D W         5.0.0-rc6-next-20190218+ #2
[   11.725430] Call Trace:
[   11.725521] [cf82fb10] [c0060c38] ___might_sleep+0x210/0x284 (unreliable)
[   11.725729] [cf82fb30] [c005a0cc] switch_task_namespaces+0x3c/0xb8
[   11.725905] [cf82fb50] [c0034264] do_exit+0x32c/0xb20
[   11.726049] [cf82fba0] [c000b59c] die+0x214/0x274
[   11.726195] [cf82fbd0] [c000f44c] handle_page_fault+0x34/0x38
[   11.726389] --- interrupt: 300 at blk_mq_run_hw_queue+0x28/0x114
[   11.726389]     LR = blk_mq_run_hw_queue+0x24/0x114
[   11.726730] [cf82fcc0] [c04315bc] blk_mq_run_hw_queues+0x50/0x7c
[   11.726907] [cf82fce0] [c0422b24] blk_set_queue_dying+0x30/0x68
[   11.727075] [cf82fcf0] [c0423ec0] blk_cleanup_queue+0x34/0x14c
[   11.727243] [cf82fd10] [c054d73c] ace_probe+0x3dc/0x508
[   11.727391] [cf82fd50] [c052d740] platform_drv_probe+0x4c/0xb8
[   11.727552] [cf82fd70] [c052abb0] really_probe+0x20c/0x32c
[   11.727702] [cf82fda0] [c052ae58] driver_probe_device+0x68/0x464
[   11.727910] [cf82fdc0] [c052b500] device_driver_attach+0xb4/0xe4
[   11.728095] [cf82fde0] [c052b5dc] __driver_attach+0xac/0xfc
[   11.728322] [cf82fe00] [c0528428] bus_for_each_dev+0x80/0xc0
[   11.728486] [cf82fe30] [c0529b3c] bus_add_driver+0x144/0x234
[   11.728639] [cf82fe50] [c052c46c] driver_register+0x88/0x15c
[   11.728806] [cf82fe60] [c09de288] ace_init+0x4c/0xac
[   11.728954] [cf82fe80] [c0002730] do_one_initcall+0xac/0x330
[   11.729135] [cf82fee0] [c09aafd0] kernel_init_freeable+0x34c/0x478
[   11.729319] [cf82ff30] [c0002c6c] kernel_init+0x18/0x114
[   11.729484] [cf82ff40] [c000f2f0] ret_from_kernel_thread+0x14/0x1c
[   11.729774] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
Reset PowerPC system
