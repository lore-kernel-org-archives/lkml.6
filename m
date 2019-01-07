Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C960C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361BC2147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbfAGQUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:20:00 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45574 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfAGQT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 11:19:59 -0500
Received: by mail-qt1-f193.google.com with SMTP id e5so1003761qtr.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 08:19:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HJcowvApmzRQEhIKW5Rb7qo8MRcZCLGaqZmcZCW/QAE=;
        b=rcfhcQ33hZyE0N8sUbzTCi/tEFJ/kWaZcvd6shBtSQ7b53ph6kq7ehM321xWduOA7i
         qOMOxnDXKR8wfrJMRLucLwXohHceq98IM9SedOB85Rtv6eFvuLYme6k/XosrW+qN9O8l
         mrVtQydUofcBsuBegzynw3FWGwQWDXCRf/VRZzMVMBRxVSE51WrjUvHFvdo3OUooAuc/
         f26SVpke9SNFaE0bHqsbEMgj9f9+UpKWmJZGRZoYffgbcPuh9wPZ55DrCOEJQr0d/ui3
         mP+T8bWS2KfmHWCZf6QJ/hfQkx/yscXTcJglmJRoTjwJrZkn1a2A3eJPvLvEnpgpBTcT
         mH1A==
X-Gm-Message-State: AJcUukfvAQQFLri///1LudPbM6Z/G+hZpA8ZEZgZaRJzJ8JZTPj+DzO4
        nJYAatFLvJFTwlpYztf0/6H3HA==
X-Google-Smtp-Source: ALg8bN4pMFON+rCM05fnVfUHTE3rS9uM05Tc++5iMOD2UyWElBLO7Q68hk23IRJWuLkdrw47bdgFkw==
X-Received: by 2002:aed:2946:: with SMTP id s64mr59578869qtd.383.1546877997936;
        Mon, 07 Jan 2019 08:19:57 -0800 (PST)
Received: from t460s.bristot.redhat.com ([177.72.25.22])
        by smtp.gmail.com with ESMTPSA id u67sm31085597qki.22.2019.01.07.08.19.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 08:19:56 -0800 (PST)
Subject: Re: WARNING in enqueue_task_dl
To:     Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     luca abeni <luca.abeni@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        syzbot <syzbot+119ba87189432ead09b4@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, x86@kernel.org
References: <000000000000b5e346057af4da06@google.com>
 <alpine.DEB.2.21.1811190921190.9459@nanos.tec.linutronix.de>
 <20181119130718.69eddf46@luca64>
 <20181119125241.GC9761@hirez.programming.kicks-ass.net>
 <20181119134349.GA2119@localhost.localdomain>
 <20181119153201.GB2119@localhost.localdomain>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <a9d18394-250b-98e4-e66d-57622dbaf247@redhat.com>
Date:   Mon, 7 Jan 2019 17:19:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181119153201.GB2119@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/18 4:32 PM, Juri Lelli wrote:
> From 9326fd2b20269cffef7290bdc5b8173460d3c870 Mon Sep 17 00:00:00 2001
> From: Juri Lelli <juri.lelli@redhat.com>
> Date: Mon, 19 Nov 2018 16:04:42 +0100
> Subject: [PATCH] sched/core: Fix PI boosting between RT and DEADLINE
> 
> syzbot reported the following warning:
> 
>  WARNING: CPU: 1 PID: 6351 at kernel/sched/deadline.c:628
>  enqueue_task_dl+0x22da/0x38a0 kernel/sched/deadline.c:1504
>  PM: Basic memory bitmaps freed
>  Kernel panic - not syncing: panic_on_warn set ...
>  CPU: 1 PID: 6351 Comm: syz-executor0 Not tainted 4.20.0-rc2+ #338
>  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>  Google 01/01/2011
>  Call Trace:
>    __dump_stack lib/dump_stack.c:77 [inline]
>    dump_stack+0x244/0x39d lib/dump_stack.c:113
>    panic+0x2ad/0x55c kernel/panic.c:188
>    __warn.cold.8+0x20/0x45 kernel/panic.c:540
>    report_bug+0x254/0x2d0 lib/bug.c:186
>    fixup_bug arch/x86/kernel/traps.c:178 [inline]
>    do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
>    do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:290
>    invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:969
>  RIP: 0010:enqueue_task_dl+0x22da/0x38a0 kernel/sched/deadline.c:1504
>  Code: ff 48 8b 8d c8 fe ff ff 48 c1 e6 2a 4c 8b 9d d0 fe ff ff 8b 95 d8 fe
>  ff ff 48 8b 85 e0 fe ff ff e9 16 e4 ff ff e8 16 d0 ea ff <0f> 0b e9 17 f1
>  ff ff 48 8b bd e8 fe ff ff 4c 89 95 c8 fe ff ff 48
>  RSP: 0018:ffff8881ba39fa18 EFLAGS: 00010002
>  RAX: 0000000000000000 RBX: ffff8881b9d6c000 RCX: ffff8881b9d6c278
>  RDX: ffff8881b9d6c03c RSI: 0000000000000002 RDI: ffff8881daf2d710
>  RBP: ffff8881ba39fb78 R08: 0000000000000001 R09: ffff8881daf00000
>  R10: 0000001a4d4f1987 R11: ffff8881daf2db3b R12: 1ffff11037473f4e
>  R13: ffff8881b9d6c2cc R14: ffff8881daf2ccc0 R15: ffff8881daf2ccc0
>    enqueue_task+0x184/0x390 kernel/sched/core.c:730
>    __sched_setscheduler+0xe99/0x2190 kernel/sched/core.c:4336
>    sched_setattr kernel/sched/core.c:4394 [inline]
>    __do_sys_sched_setattr kernel/sched/core.c:4570 [inline]
>    __se_sys_sched_setattr kernel/sched/core.c:4549 [inline]
>    __x64_sys_sched_setattr+0x1b2/0x2f0 kernel/sched/core.c:4549
>    do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>    entry_SYSCALL_64_after_hwframe+0x49/0xbe
>  RIP: 0033:0x457569
>  Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
>  48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
>  ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
>  RSP: 002b:00007f05ce0a2c78 EFLAGS: 00000246 ORIG_RAX: 000000000000013a
>  RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457569
>  RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000000
>  RBP: 000000000072bfa0 R08: 0000000000000000 R09: 0000000000000000
>  R10: 0000000000000000 R11: 0000000000000246 R12: 00007f05ce0a36d4
>  R13: 00000000004c369f R14: 00000000004d5730 R15: 00000000ffffffff
> 
> At deadline.c:628 we have:
> 
>  623 static inline void setup_new_dl_entity(struct sched_dl_entity *dl_se)
>  624 {
>  625 	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
>  626 	struct rq *rq = rq_of_dl_rq(dl_rq);
>  627
>  628 	WARN_ON(dl_se->dl_boosted);
>  629 	WARN_ON(dl_time_before(rq_clock(rq), dl_se->deadline));
>         [...]
>      }
> 
> Which means that setup_new_dl_entity() has been called on a task
> currently boosted. This shouldn't happen though, as setup_new_
> dl_entity() is only called when the 'dynamic' deadline of the new entity
> is in the past w.r.t. rq_clock and boosted tasks shouldn't verify this
> condition.
> 
> Digging through PI code I noticed that what above might in fact happen
> if an RT tasks blocks on an rt_mutex hold by a DEADLINE task. In the
> first branch of boosting conditions we check only if a pi_task 'dynamic'
> deadline is earlier than mutex holder's and in this case we set mutex
> holder to be dl_boosted. However, since RT 'dynamic' deadlines are only
> initialized if such tasks get boosted at some point (or if they become
> DEADLINE of course), in general RT 'dynamic' deadlines are usually equal
> to 0 and this verifies the aforementioned condition.
> 
> Fix it by checking that the potential donor task is actually (even if
> temporary because in turn boosted) running at DEADLINE priority before
> using its 'dynamic' deadline value.
> 
> Reported-by: syzbot+119ba87189432ead09b4@syzkaller.appspotmail.com
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>

Thanks!
-- Daniel
