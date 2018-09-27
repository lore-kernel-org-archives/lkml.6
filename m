Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FBCC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E5B20836
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:12:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07E5B20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbeI0P3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:29:15 -0400
Received: from a.mx.secunet.com ([62.96.220.36]:35902 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727032AbeI0P3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:29:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id 469FD201A1;
        Thu, 27 Sep 2018 13:11:41 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id A9SaN_kJ_dLF; Thu, 27 Sep 2018 13:11:40 +0200 (CEST)
Received: from mail-essen-01.secunet.de (mail-essen-01.secunet.de [10.53.40.204])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id 8E31520184;
        Thu, 27 Sep 2018 13:11:40 +0200 (CEST)
Received: from gauss2.secunet.de (10.182.7.193) by mail-essen-01.secunet.de
 (10.53.40.204) with Microsoft SMTP Server id 14.3.408.0; Thu, 27 Sep 2018
 11:11:57 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)      id 29B173182A36;
 Thu, 27 Sep 2018 11:11:57 +0200 (CEST)
Date:   Thu, 27 Sep 2018 11:11:57 +0200
From:   Steffen Klassert <steffen.klassert@secunet.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC:     <syzbot+6d3612ba5e254e387153@syzkaller.appspotmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: KASAN: use-after-free Read in generic_gcmaes_encrypt
Message-ID: <20180927091157.GF3823@gauss3.secunet.de>
References: <000000000000d014010576cc00f4@google.com>
 <CAKv+Gu-19YmphAWdv5owvBEno_U3+Z53_mUqdt6ZQn0mZP-Sgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-19YmphAWdv5owvBEno_U3+Z53_mUqdt6ZQn0mZP-Sgw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: 8F12404B-EC3F-40B7-AC63-5ED101DE2E9F
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 10:35:48AM +0200, Ard Biesheuvel wrote:
> (+ Stefan)
> 
> On Wed, 26 Sep 2018 at 22:24, syzbot
> <syzbot+6d3612ba5e254e387153@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    739d0def85ca Merge branch 'hv_netvsc-Support-LRO-RSC-in-th..
> > git tree:       net-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1146ffae400000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=e79b9299baeb2298
> > dashboard link: https://syzkaller.appspot.com/bug?extid=6d3612ba5e254e387153
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16200b9e400000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=102311c6400000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+6d3612ba5e254e387153@syzkaller.appspotmail.com
> >
> > random: sshd: uninitialized urandom read (32 bytes read)
> > ==================================================================
> > BUG: KASAN: use-after-free in memcpy include/linux/string.h:345 [inline]
> > BUG: KASAN: use-after-free in generic_gcmaes_encrypt+0xc6/0x186
> > arch/x86/crypto/aesni-intel_glue.c:1291
> > Read of size 12 at addr ffff8801d7ad0900 by task kworker/0:1/14
> >
> > CPU: 0 PID: 14 Comm: kworker/0:1 Not tainted 4.19.0-rc4+ #228
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > Workqueue: pencrypt padata_parallel_worker
> > Call Trace:
> >   __dump_stack lib/dump_stack.c:77 [inline]
> >   dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
> >   print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
> >   kasan_report_error mm/kasan/report.c:354 [inline]
> >   kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
> >   check_memory_region_inline mm/kasan/kasan.c:260 [inline]
> >   check_memory_region+0x13e/0x1b0 mm/kasan/kasan.c:267
> >   memcpy+0x23/0x50 mm/kasan/kasan.c:302
> >   memcpy include/linux/string.h:345 [inline]
> >   generic_gcmaes_encrypt+0xc6/0x186 arch/x86/crypto/aesni-intel_glue.c:1291
> >   crypto_aead_encrypt include/crypto/aead.h:335 [inline]
> >   gcmaes_wrapper_encrypt+0x162/0x200 arch/x86/crypto/aesni-intel_glue.c:1127
> >   crypto_aead_encrypt include/crypto/aead.h:335 [inline]
> >   pcrypt_aead_enc+0xcb/0x190 crypto/pcrypt.c:143
> >   padata_parallel_worker+0x49d/0x760 kernel/padata.c:86
> >   process_one_work+0xc90/0x1b90 kernel/workqueue.c:2153
> >   worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
> >   kthread+0x35a/0x420 kernel/kthread.c:246
> >   ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413
> >
> > Allocated by task 5474:
> >   save_stack+0x43/0xd0 mm/kasan/kasan.c:448
> >   set_track mm/kasan/kasan.c:460 [inline]
> >   kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
> >   kmem_cache_alloc_trace+0x152/0x750 mm/slab.c:3620
> >   kmalloc include/linux/slab.h:513 [inline]
> >   tls_set_sw_offload+0xcc4/0x14b0 net/tls/tls_sw.c:1741
> >   do_tls_setsockopt_conf net/tls/tls_main.c:467 [inline]
> >   do_tls_setsockopt net/tls/tls_main.c:514 [inline]
> >   tls_setsockopt+0x689/0x770 net/tls/tls_main.c:533
> >   sock_common_setsockopt+0x9a/0xe0 net/core/sock.c:3038
> >   __sys_setsockopt+0x1ba/0x3c0 net/socket.c:1902
> >   __do_sys_setsockopt net/socket.c:1913 [inline]
> >   __se_sys_setsockopt net/socket.c:1910 [inline]
> >   __x64_sys_setsockopt+0xbe/0x150 net/socket.c:1910
> >   do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
> >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >
> > Freed by task 5472:
> >   save_stack+0x43/0xd0 mm/kasan/kasan.c:448
> >   set_track mm/kasan/kasan.c:460 [inline]
> >   __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
> >   kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
> >   __cache_free mm/slab.c:3498 [inline]
> >   kfree+0xcf/0x230 mm/slab.c:3813
> >   tls_sk_proto_close+0x5fd/0x750 net/tls/tls_main.c:277

I'd say tls_sk_proto_close does not handle asynchronous crypto properly.
The pcrypt template is used here, so all crypto requests are processed
asynchronously. tls_sk_proto_close frees the needed recources before
the remaining crypto requests are finalized.
