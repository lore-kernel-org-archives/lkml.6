Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA9EC46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD3652086C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="QmP8xmVG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD3652086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbeKET7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 14:59:46 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:41184 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728983AbeKET7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 14:59:45 -0500
Received: by mail-io1-f68.google.com with SMTP id a5-v6so6110878ioq.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 02:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+1jpJyS+61EDhtmubHqx1H4A26JAsgUpvaVqS91pUq4=;
        b=QmP8xmVG8wLlzbBqQO7GDz5sBPmwuvSFkRzsouGnw0wOTMlMPv/T9ButDxkzUH6AAL
         KoniyvKXR1PX9fDIwH9uVCt3UXhfnmhGt+tg6+vU73nMXq8kVnVPweLt3RnKXCiyIPgk
         2jS+IFOtQkXwebnWwqTAu0RGN/qgKQUSTr5ME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+1jpJyS+61EDhtmubHqx1H4A26JAsgUpvaVqS91pUq4=;
        b=CZoHMWIzLWBGJX2RDri8gAkh7wTAfIZUSXQi+GVQQccf0HmOPGqZSCgekQdlbEqisL
         QAyNDjfb7fhauEe4vsD8CaeCZVDMC+KivzVBG9NfbCuEgZ5pUoYsdxI3JZJyZ8+TOHb0
         7ajWS7cqe6Ihxv4NHxvepZOdd1ZeNa8sAhI1TSWYl1iFZ12m4MPTx7VHfhFwqm1kTsXX
         Eci2TDT8YneePrYcURgkmhhHWtNssoEw+LGy3CJ6Qc4APDz4+zITwE/vd3UkYEgNl5WE
         6kw35QOHY6k/1cIEMu/7ZyNuGcmUZR7RIUmnyy04FeVazdO7v96mb6I+Blw9xpz9OlRZ
         zl5Q==
X-Gm-Message-State: AGRZ1gIw65BGUXCfjdYs2eEiDf6UuzarCNYF0hU4mtknkx2USWzPBJh9
        OO9Hl7fMKiADrN/2XNzCDbLfRdlqLDDSCnMgoHGrcw==
X-Google-Smtp-Source: AJdET5e8Xr7+Pa70Hep7EWyGUHVUlzEIYre5tgu/gG/fflVoxr6ZXL4PFVo7Sgwhix3cF+9mtDHbQX7/lziqBeZJLmA=
X-Received: by 2002:a5e:8b42:: with SMTP id z2-v6mr14786581iom.144.1541414441444;
 Mon, 05 Nov 2018 02:40:41 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:ac42:0:0:0:0:0 with HTTP; Mon, 5 Nov 2018 02:40:40 -0800 (PST)
X-Originating-IP: [94.21.144.184]
In-Reply-To: <CACT4Y+YLFp4OXRyroL8coE5Mw6yMdbajKPeu8kzkHunVGypx0Q@mail.gmail.com>
References: <000000000000c25cca0579982a05@google.com> <CACT4Y+YLFp4OXRyroL8coE5Mw6yMdbajKPeu8kzkHunVGypx0Q@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 5 Nov 2018 11:40:40 +0100
Message-ID: <CAJfpegsNzxc3c=ojjYHgdiKiHXXutOkKCUAO131cifwKyLhqOg@mail.gmail.com>
Subject: Re: INFO: task hung in fuse_sb_destroy
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+6339eda9cb4ebbc4c37b@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 12:05 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Thu, Nov 1, 2018 at 11:49 AM, syzbot
> <syzbot+6339eda9cb4ebbc4c37b@syzkaller.appspotmail.com> wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    59fc453b21f7 Merge branch 'akpm' (patches from Andrew)
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=15fb2447400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=ea045471e4c756e8
>> dashboard link: https://syzkaller.appspot.com/bug?extid=6339eda9cb4ebbc4c37b
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=178a105d400000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16651133400000
>
>
> I can easily reproduce this.

I can't reproduce on my meager dual core notebook.

>
> The repro gives me a task hanged at:
>
> # cat /proc/7563/task/*/stack
> [<0>] fuse_wait_aborted+0x20b/0x320
> [<0>] fuse_sb_destroy+0xe2/0x1d0
> [<0>] fuse_kill_sb_anon+0x15/0x20
> [<0>] deactivate_locked_super+0x97/0x100
> [<0>] deactivate_super+0x2bb/0x320
> [<0>] cleanup_mnt+0xbf/0x160
> [<0>] __cleanup_mnt+0x16/0x20
> [<0>] task_work_run+0x1e8/0x2a0
> [<0>] exit_to_usermode_loop+0x318/0x380
> [<0>] do_syscall_64+0x6be/0x820
> [<0>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [<0>] 0xffffffffffffffff
>
> I double checked that writing to /sys/fs/fuse/connections/44/abort did
> not help (the only entry in fuse/connections). Wrote multiple times,
> and tried to kill the task, nothing helps.

What's the output of

cat /sys/fs/fuse/connections/NN/waiting

?

Thanks,
Miklos
