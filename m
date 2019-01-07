Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5446AC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2301B2054F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUe0MzL/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfAGSrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:47:33 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33864 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfAGSrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:47:32 -0500
Received: by mail-pl1-f194.google.com with SMTP id w4so570351plz.1;
        Mon, 07 Jan 2019 10:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Jxd8J/ipn4Rj0Z4RlMK6OeDAR8/WmqROpXZc8ikhNg=;
        b=GUe0MzL/WxosR4l3HbdlpYWYq8pCM7/cf7jShqYx8g3aMLSLfZwwRQIZjmaaDrciOu
         kBzDbQLLb5NVKoQ4emFP2OuVnJHOE6fB20CpGOCwL4LuWV5p8tb/rZwGFcVSAGxRZfBY
         8jxxzkm2sM33y4pOrz664v3b82mATmHXuaeNf9MSjUzTxbG4yW+Isb6L+cUQ0Dbst5GW
         q71pcRyp13FUz//V4UssnQ3pqotg7uau5LUrfuNq0KHkDrXOQV3z/gFV/Bcw4rYGLRLL
         Khh0P7VVmbHwqEVQMAJuzi9O1KVlUdK0Wjtts899AlBBUD2FHMD1kxhrZQdMrJszbnVQ
         jDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Jxd8J/ipn4Rj0Z4RlMK6OeDAR8/WmqROpXZc8ikhNg=;
        b=AmFQ9AhplYndevAwmRmlVA9DiBS70mCasSayh5ZPUkcUSJOPHAwLMywZz9i+5uR0yT
         C61myNnkUS2AeIHjGP9pyje8fW9F2DwW5yfV1CoOu2vsBvohTm1MITJ6yq6WG505lX7P
         TS/5Ebh3J9VSLYTysidA4Q9t5YJVPpzSh31RSWG6hiDYtlHMrSVyUooUeso3QlWTHhRK
         iY4D4nNiXt0tyNRMtZ0q5A3OYQyTqlem9cPvhbB5RbuWtp6yHU4cC58dK43nLCOj5tVI
         V1CFraWO7BLx+B07wb3Hk8AmSxWWB4Xe9Qtrt9wEA7lGulw6h4Q1PlhvDdae4pg4mfnd
         KxAg==
X-Gm-Message-State: AJcUukeU5rVk+mPqZMwhso9Da82jbkSVHGSfgJfvSVT8PMU8EAeN5A2I
        0kon0TEBAZTc9ipPULkE6Ourw8SCtI3wsELtJPE=
X-Google-Smtp-Source: ALg8bN4hXSoluQCQs3Yfb9HCKi2uZWZGmtmHztDOq2xPbAkrB91cb7AEBTXaywiVwbritu2O3vftTu4RyBk08YnprR8=
X-Received: by 2002:a17:902:e10a:: with SMTP id cc10mr63115354plb.165.1546886851694;
 Mon, 07 Jan 2019 10:47:31 -0800 (PST)
MIME-Version: 1.0
References: <000000000000612b51057edb2e2d@google.com>
In-Reply-To: <000000000000612b51057edb2e2d@google.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Mon, 7 Jan 2019 10:47:19 -0800
Message-ID: <CAM_iQpUO9iJO2+vxaEjkFUVU7en7SVsDVE7Ekzd2y86pOC8P=w@mail.gmail.com>
Subject: Re: WARNING: locking bug in nr_release
To:     syzbot <syzbot+23f5ac6e7c0b6cc63734@syzkaller.appspotmail.com>
Cc:     David Miller <davem@davemloft.net>, linux-hams@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        ralf@linux-mips.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 1:52 AM syzbot
<syzbot+23f5ac6e7c0b6cc63734@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    574823bfab82 Change mincore() to count "mapped" pages rath..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=121dc980c00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d55557b516c45456
> dashboard link: https://syzkaller.appspot.com/bug?extid=23f5ac6e7c0b6cc63734
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+23f5ac6e7c0b6cc63734@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> DEBUG_LOCKS_WARN_ON(class_idx > MAX_LOCKDEP_KEYS)
> WARNING: CPU: 1 PID: 30980 at kernel/locking/lockdep.c:3315
> __lock_acquire+0x14cd/0x4a30 kernel/locking/lockdep.c:3315
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 1 PID: 30980 Comm: syz-executor5 Not tainted 4.20.0+ #13
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
>   panic+0x2cb/0x65c kernel/panic.c:214
>   __warn.cold+0x20/0x48 kernel/panic.c:571
>   report_bug+0x263/0x2b0 lib/bug.c:186
>   fixup_bug arch/x86/kernel/traps.c:178 [inline]
>   fixup_bug arch/x86/kernel/traps.c:173 [inline]
>   do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
>   do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:290
>   invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
> RIP: 0010:__lock_acquire+0x14cd/0x4a30 kernel/locking/lockdep.c:3315
> Code: 8b 1d 3b eb f7 08 45 85 db 0f 85 f0 f3 ff ff 48 c7 c6 60 a1 4b 88 48
> c7 c7 80 76 4b 88 44 89 9c 24 98 00 00 00 e8 f3 5f e7 ff <0f> 0b 44 8b 9c
> 24 98 00 00 00 e9 c9 f3 ff ff 8b 0d 2e 9c f2 09 85
> RSP: 0018:ffff8880710cf0c0 EFLAGS: 00010086
> RAX: 0000000000000000 RBX: 00000000fffe4386 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff81684ce6 RDI: 0000000000000006
> RBP: ffff8880710cf350 R08: ffff888081d582c0 R09: fffffbfff1333299
> R10: fffffbfff1333298 R11: ffffffff899994c3 R12: ffff888081d582c0
> R13: ffff888081d58b8a R14: 0000000000000001 R15: 00000000fffe4386
> kobject: 'kvm' (00000000d564ee4d): kobject_uevent_env
>   lock_acquire+0x1db/0x570 kernel/locking/lockdep.c:3841
> kobject: 'kvm' (00000000d564ee4d): fill_kobj_path: path
> = '/devices/virtual/misc/kvm'
>   __raw_write_lock_bh include/linux/rwlock_api_smp.h:203 [inline]
>   _raw_write_lock_bh+0x33/0x50 kernel/locking/spinlock.c:312
>   sock_orphan include/net/sock.h:1796 [inline]

This is probably a consequence of the use-after-free bug,
so:

#syz dup: WARNING: refcount bug in nr_release
