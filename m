Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E21C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 11:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AEB1218D3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 11:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NGrBaYUk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbfABLpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 06:45:45 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:42221 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729128AbfABLpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 06:45:43 -0500
Received: by mail-io1-f65.google.com with SMTP id x6so24285865ioa.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 03:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7WQ52uURSnY6f4c1wQ0H+EmS0YQTagogeXjXtMbJ5Uo=;
        b=NGrBaYUkgfQT+W/Fcw5vSRLqw0H/kic4MPUZhtdA6gO0I6tf2RO/gNu2VTI7arLxkq
         0nxNAT18+tjyQv/4Jn5FV9glkor7rnHSu39sfUkFe9YW4c9M76u2hV0Z6mceYXC7QaOG
         /t2Y0OGocrHBj1cfiyReasUfF1xE/fxXIzUXxDTchUJqO8vebxsg/k5SCwVzebL5G70P
         h1K9VPtgaVf05ZMiG/9pXbRYs9RaC892gCMuBZC3eDLjwQLFdtJPfPK58EBut2wjdcu4
         gupPmW3Rjzw4YpusQrwTz+N2+uYAzGM40rpc+RKHeviL/8zXWcEhrOzXWdyBHQGFjbm+
         jmsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7WQ52uURSnY6f4c1wQ0H+EmS0YQTagogeXjXtMbJ5Uo=;
        b=dYuLToKfhCcDRdlKjX4s+AmQ1UDu0MLD5MmABRQZhL8cvmUttuyYkBjLobG8eg4w+1
         7HTa+lrM2IWoN0OLJmI2fYCZlVmYa9ynvGBBpIdAz9Tql1Kl5XEB5YC74IyKo4bPhQW5
         ZWnfhUf6pN3z2mIoL4/3SbTTjtM00iVuqv97YppYLl1Vhk2l4dtUGj4sZsZdx0g6vCRp
         ejtumveJovJZrWFsFmpcrhfLPXsHn4RcDl7TfSbLguuhyOTXhOzJYaz7vTNPyZTS5EY/
         xX7xf21b9AB+PCkqCPi3Rw2+Sr0nqWuHUqgcDG8u1ML2ZCP/8JrdfFRVefJHwHdwvI1T
         N0vA==
X-Gm-Message-State: AJcUukc7NhYbHB2HSHJMPCrGHa4jbyettjTARe4ZjTyVF5A6zHusmw21
        Z4UK44d+/80byqzEIZMNdwgrWRpaRosximCcazZT4Q==
X-Google-Smtp-Source: ALg8bN45ds6JO0656f0mH9b19DfhgXcpTBpAnB3S5Q9xlngkkSZeZrDhmMYCkHwfgeDjuOTFyUP6xWw3bRsgPTdh/tI=
X-Received: by 2002:a5d:8491:: with SMTP id t17mr30307177iom.11.1546429540910;
 Wed, 02 Jan 2019 03:45:40 -0800 (PST)
MIME-Version: 1.0
References: <f9a2ac59-7580-ff80-9da9-c2659c8d2a92@trinnet.net> <27a9dfee-c589-18d1-1b65-a14c8c366edb@free.fr>
In-Reply-To: <27a9dfee-c589-18d1-1b65-a14c8c366edb@free.fr>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 2 Jan 2019 12:45:30 +0100
Message-ID: <CACT4Y+a3gLdXa_cQezTo5xJjPjk3XLbRtW-JcNH6-jcoF1+pFA@mail.gmail.com>
Subject: Re: Fwd: net/rose: GPF in rose_route_frame
To:     Bernard Pidoux <f6bvp@free.fr>
Cc:     David Ranch <dranch@trinnet.net>, ralf@linux-mips.org,
        David Miller <davem@davemloft.net>, linux-hams@vger.kernel.org,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 1, 2019 at 1:53 PM Bernard Pidoux <f6bvp@free.fr> wrote:
>
> Hi Dmitry,
>
> We noticed your message on Linux kernel, netdev and ham lists.
>
> Thank you for pointing  GPF due to a null pointer bug in rose module.
>
> Although I committed a patch about this AX25 NULL pointer in rose_route_frame, it has not been accepted yet and will probably not unless we found a simple way to reproduce the GPF. This is why we are interested in your description.
>
> I wonder how you could get the kernel GPF ?
> Trying to reproduce your test I first needed to modprobe rose module before creating rose device with :
>
> # ip link set dev rose0 address 11:22:33:44:55
> # ip link set dev rose0 up
>
> However nothing happened next !
>
> Did you set an AX.25 port in /etc/ax25/axports ?
> Could you describe more explicitely what application you are running to trigger the GPF ?
> Did you use rose_call or something else ?
>
> I am looking for a simpler way to trigger the bug than my usual ROSE configuration that is rather complicated in order to let maintainers be convinced as they just want to reproduce the bug conditions and watch by themselves.
>
> Regards,
>
> Bernard

+mailing lists again, let's not lose information

Hi Bernard,

I just did what I described (2 ip invocations) on the specified kernel/config.

Have you tried the kernel config that I provided? Using the same
kernel config looks like the lowest hanging fruit when something does
not reproduce. The fact that you need to modprobe suggests that you
used some different config.

You can download the image I am using here:
https://github.com/google/syzkaller/blob/master/docs/syzbot.md#crash-does-not-reproduce

I did not touch /etc/ax25/axports, it's empty in my image.

The application I am using is literally the ip command :)
I don't know what is rose and how it should be used, I've just looked
at possibility of covering rose testing with syzkaller
(https://github.com/google/syzkaller) at least in the most basic form.





>  --------
> Sujet : Fwd: net/rose: GPF in rose_route_frame
> Date : Mon, 24 Dec 2018 19:46:12 -0800
> De : David Ranch <dranch@trinnet.net>
> Pour : Bernard, f6bvp <f6bvp@free.fr>
>
>
> Hey Bernard,
>
> I assume you saw this one.  That address should be an IP address right?   What this person specified is neither a legal IP (not in octal) nor legal MAC (needs six fields).
>
> --David
>
>
> -------- Forwarded Message --------
> Subject: net/rose: GPF in rose_route_frame
> Date: Mon, 24 Dec 2018 11:25:22 +0100
> From: Dmitry Vyukov <dvyukov@google.com>
> To: ralf@linux-mips.org, David Miller <davem@davemloft.net>, linux-hams@vger.kernel.org, netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eric W. Biederman <ebiederm@xmission.com>
> CC: syzkaller <syzkaller@googlegroups.com>
>
>
> Hi,
>
> Rose device crashes kernel after several seconds after up'ping. I am doing just:
>
> # ip link set dev rose0 address 11:22:33:44:55
> # ip link set dev rose0 up
>
> Then after ~15 seconds or so:
>
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] PREEMPT SMP KASAN
> CPU: 3 PID: 2747 Comm: aoe_tx0 Not tainted 4.20.0-rc7-next-20181221 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> RIP: 0010:ax25cmp+0x3e/0x180 net/ax25/ax25_addr.c:122
> Code: f6 41 55 49 89 fd 41 54 49 89 f4 53 48 83 ec 10 48 89 7d d0 48
> 89 75 c8 e8 cf 73 6d fa 4c 89 e8 4c 89 ea 48 c1 e8 03 83 e2 07 <42> 0f
> b6 04 38 38 d0 7f 08 84 c0 0f 85 23 01 00 00 4c 89 e0 4c 89
> RSP: 0018:ffff888069ec73c8 EFLAGS: 00010202
> RAX: 0000000000000002 RBX: ffff888064ce8080 RCX: 0000000000000001
> RDX: 0000000000000007 RSI: ffffffff8711cd61 RDI: 0000000000000017
> RBP: ffff888069ec7400 R08: ffffed100d3d8e70 R09: ffffed100d3d8e6f
> R10: ffffed100d3d8e6f R11: 0000000000000003 R12: ffff888064ce8088
> R13: 0000000000000017 R14: 0000000000000000 R15: dffffc0000000000
> FS:  0000000000000000(0000) GS:ffff88806c780000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f2a68767000 CR3: 0000000068f90003 CR4: 00000000001606e0
> Call Trace:
>  rose_route_frame+0x2d0/0x19a0 net/rose/rose_route.c:885
>  rose_xmit+0x88/0x180 net/rose/rose_dev.c:110
>  __netdev_start_xmit include/linux/netdevice.h:4382 [inline]
>  netdev_start_xmit include/linux/netdevice.h:4391 [inline]
>  xmit_one net/core/dev.c:3278 [inline]
>  dev_hard_start_xmit+0x286/0xc80 net/core/dev.c:3294
>  __dev_queue_xmit+0x2efb/0x3940 net/core/dev.c:3864
>  dev_queue_xmit+0x17/0x20 net/core/dev.c:3897
>  tx+0x77/0xd0 drivers/block/aoe/aoenet.c:63
>  kthread+0x296/0x4a0 drivers/block/aoe/aoecmd.c:1239
>  kthread+0x35a/0x440 kernel/kthread.c:246
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
> Modules linked in:
> ---[ end trace 1e8c52d44c421a9f ]---
> RIP: 0010:ax25cmp+0x3e/0x180 net/ax25/ax25_addr.c:122
> Code: f6 41 55 49 89 fd 41 54 49 89 f4 53 48 83 ec 10 48 89 7d d0 48
> 89 75 c8 e8 cf 73 6d fa 4c 89 e8 4c 89 ea 48 c1 e8 03 83 e2 07 <42> 0f
> b6 04 38 38 d0 7f 08 84 c0 0f 85 23 01 00 00 4c 89 e0 4c 89
> RSP: 0018:ffff888069ec73c8 EFLAGS: 00010202
> RAX: 0000000000000002 RBX: ffff888064ce8080 RCX: 0000000000000001
> RDX: 0000000000000007 RSI: ffffffff8711cd61 RDI: 0000000000000017
> RBP: ffff888069ec7400 R08: ffffed100d3d8e70 R09: ffffed100d3d8e6f
> R10: ffffed100d3d8e6f R11: 0000000000000003 R12: ffff888064ce8088
> R13: 0000000000000017 R14: 0000000000000000 R15: dffffc0000000000
> FS:  0000000000000000(0000) GS:ffff88806c780000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f2a68767000 CR3: 0000000068f90003 CR4: 00000000001606e0
>
>
> Kernel is on today's linux-next head:
>
> commit 340ae71f9dd421227a58c14a909b63033745dca4 (HEAD, tag:
> next-20181221, next/master)
> Date:   Fri Dec 21 19:27:46 2018 +1100
>     Add linux-next specific files for 20181221
>
> Kernel config:
> https://gist.githubusercontent.com/dvyukov/fccf387306df8a1042949da46028302a/raw/f817219bdb8d5ef63fdd56f17e0cc13e620e1978/gistfile1.txt
