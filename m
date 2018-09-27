Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EA2C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 049B621580
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CDO0qHIP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 049B621580
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbeI0OxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 10:53:10 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38976 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbeI0OxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 10:53:10 -0400
Received: by mail-io1-f68.google.com with SMTP id l7-v6so1351426iok.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 01:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YoxIEzRN2JUS9VN4phS5kLf60/kQX19aSkYo+zr3DkM=;
        b=CDO0qHIPkfNlFR9YyG22K+pizcDAtLxGc5TEpt8wfnUmdq7wVeyytL6Vcqmx2F8IlY
         Nl9idsu9AG27DTGZSQ5ipXFIw4stdTRhRyOhv+DRT2ZOrVsboGxJC0RiSryYEDAfHLAU
         r3fYNblzmXKMySBw7i2x5uzgUBfKRs3lnOZxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YoxIEzRN2JUS9VN4phS5kLf60/kQX19aSkYo+zr3DkM=;
        b=qZ+pLgTLNemoI3DaD2vnJvOW90piuy2v055KDm1TmIxGBaThLYVMBygd9gD5G5MJo0
         YJJEetcEsRbpuGfH3FysP+opHhRCqQlGmerx+M3UE8N93p9KX9YSngAysP/iX9PHvlZh
         BYtikYpxEkFwm/mTimKwLp+aP+e9QAJ+oeDyY+uilg1rPBj19osW2XvvCQE6wHnkw3rm
         m/bXt2LUGBUmvn9hTeqgfhbqr2zdcSkMI35SV2Z1wCgE8wNCJcspZCpr5fcxIpGrJZLm
         WSuFYdt8tFBau0zn4wYsw74rVf+w1TyVw1wbl1nfV0Xxi9NDI9MC8XFhs0Wu+n0Hk2+Q
         MAPQ==
X-Gm-Message-State: ABuFfoiwQvtV5d6/nj+sm8G2WenIvKvCcwQakQ4mLlp8FjJD02ulyPQ2
        XAqqm5zFf9lymMHG9oDraeNxTnqjNa6RFsyVZamn2Q==
X-Google-Smtp-Source: ACcGV62xaTY55R1uwQV+Z0N5OEIZol70cecunC4RYtOjJnH4XvD6b2W2hSziaMS4DAgnErrV3ROkgpCfbd60LLa+fSs=
X-Received: by 2002:a6b:5d12:: with SMTP id r18-v6mr7864824iob.170.1538037363975;
 Thu, 27 Sep 2018 01:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d014010576cc00f4@google.com>
In-Reply-To: <000000000000d014010576cc00f4@google.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 27 Sep 2018 10:35:48 +0200
Message-ID: <CAKv+Gu-19YmphAWdv5owvBEno_U3+Z53_mUqdt6ZQn0mZP-Sgw@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in generic_gcmaes_encrypt
To:     syzbot+6d3612ba5e254e387153@syzkaller.appspotmail.com,
        Steffen Klassert <steffen.klassert@secunet.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+ Stefan)

On Wed, 26 Sep 2018 at 22:24, syzbot
<syzbot+6d3612ba5e254e387153@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    739d0def85ca Merge branch 'hv_netvsc-Support-LRO-RSC-in-th..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1146ffae400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e79b9299baeb2298
> dashboard link: https://syzkaller.appspot.com/bug?extid=6d3612ba5e254e387153
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16200b9e400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=102311c6400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+6d3612ba5e254e387153@syzkaller.appspotmail.com
>
> random: sshd: uninitialized urandom read (32 bytes read)
> ==================================================================
> BUG: KASAN: use-after-free in memcpy include/linux/string.h:345 [inline]
> BUG: KASAN: use-after-free in generic_gcmaes_encrypt+0xc6/0x186
> arch/x86/crypto/aesni-intel_glue.c:1291
> Read of size 12 at addr ffff8801d7ad0900 by task kworker/0:1/14
>
> CPU: 0 PID: 14 Comm: kworker/0:1 Not tainted 4.19.0-rc4+ #228
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Workqueue: pencrypt padata_parallel_worker
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
>   print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
>   kasan_report_error mm/kasan/report.c:354 [inline]
>   kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
>   check_memory_region_inline mm/kasan/kasan.c:260 [inline]
>   check_memory_region+0x13e/0x1b0 mm/kasan/kasan.c:267
>   memcpy+0x23/0x50 mm/kasan/kasan.c:302
>   memcpy include/linux/string.h:345 [inline]
>   generic_gcmaes_encrypt+0xc6/0x186 arch/x86/crypto/aesni-intel_glue.c:1291
>   crypto_aead_encrypt include/crypto/aead.h:335 [inline]
>   gcmaes_wrapper_encrypt+0x162/0x200 arch/x86/crypto/aesni-intel_glue.c:1127
>   crypto_aead_encrypt include/crypto/aead.h:335 [inline]
>   pcrypt_aead_enc+0xcb/0x190 crypto/pcrypt.c:143
>   padata_parallel_worker+0x49d/0x760 kernel/padata.c:86
>   process_one_work+0xc90/0x1b90 kernel/workqueue.c:2153
>   worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
>   kthread+0x35a/0x420 kernel/kthread.c:246
>   ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413
>
> Allocated by task 5474:
>   save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>   set_track mm/kasan/kasan.c:460 [inline]
>   kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
>   kmem_cache_alloc_trace+0x152/0x750 mm/slab.c:3620
>   kmalloc include/linux/slab.h:513 [inline]
>   tls_set_sw_offload+0xcc4/0x14b0 net/tls/tls_sw.c:1741
>   do_tls_setsockopt_conf net/tls/tls_main.c:467 [inline]
>   do_tls_setsockopt net/tls/tls_main.c:514 [inline]
>   tls_setsockopt+0x689/0x770 net/tls/tls_main.c:533
>   sock_common_setsockopt+0x9a/0xe0 net/core/sock.c:3038
>   __sys_setsockopt+0x1ba/0x3c0 net/socket.c:1902
>   __do_sys_setsockopt net/socket.c:1913 [inline]
>   __se_sys_setsockopt net/socket.c:1910 [inline]
>   __x64_sys_setsockopt+0xbe/0x150 net/socket.c:1910
>   do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> Freed by task 5472:
>   save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>   set_track mm/kasan/kasan.c:460 [inline]
>   __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
>   kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
>   __cache_free mm/slab.c:3498 [inline]
>   kfree+0xcf/0x230 mm/slab.c:3813
>   tls_sk_proto_close+0x5fd/0x750 net/tls/tls_main.c:277
>   inet_release+0x104/0x1f0 net/ipv4/af_inet.c:428
>   inet6_release+0x50/0x70 net/ipv6/af_inet6.c:458
>   __sock_release+0xd7/0x250 net/socket.c:579
>   sock_close+0x19/0x20 net/socket.c:1141
>   __fput+0x385/0xa30 fs/file_table.c:278
>   ____fput+0x15/0x20 fs/file_table.c:309
>   task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
>   tracehook_notify_resume include/linux/tracehook.h:193 [inline]
>   exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
>   prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
>   syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
>   do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> The buggy address belongs to the object at ffff8801d7ad0900
>   which belongs to the cache kmalloc-32 of size 32
> The buggy address is located 0 bytes inside of
>   32-byte region [ffff8801d7ad0900, ffff8801d7ad0920)
> The buggy address belongs to the page:
> page:ffffea00075eb400 count:1 mapcount:0 mapping:ffff8801da8001c0
> index:0xffff8801d7ad0fc1
> flags: 0x2fffc0000000100(slab)
> raw: 02fffc0000000100 ffffea00075eb948 ffffea00075ff688 ffff8801da8001c0
> raw: ffff8801d7ad0fc1 ffff8801d7ad0000 000000010000003f 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>   ffff8801d7ad0800: fb fb fb fb fc fc fc fc 00 00 fc fc fc fc fc fc
>   ffff8801d7ad0880: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
> > ffff8801d7ad0900: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
>                     ^
>   ffff8801d7ad0980: fb fb fb fb fc fc fc fc 00 00 fc fc fc fc fc fc
>   ffff8801d7ad0a00: 00 00 00 00 fc fc fc fc 00 00 00 00 fc fc fc fc
> ==================================================================
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
