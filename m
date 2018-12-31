Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B3CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 10:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC20A21738
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 10:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gEikk3hl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbeLaKo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 05:44:56 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:33326 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbeLaKo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 05:44:56 -0500
Received: by mail-io1-f66.google.com with SMTP id t24so21126750ioi.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 02:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X4ptc1+o2qKwFMRy0Ztxm6pBTMKhv1UyUWGrhFH/wrY=;
        b=gEikk3hlCV8SNNjPyHbbsz7QUYG0vTdEj0fXr53xlNlSG0dKVpZbTwufHzoiEGwbpb
         oPxJj1Y/Cv0gjYFZ3UlLJj5QKvDhnkwPaMmIWBZHTkbjBj3bpUUGSA1TvenqM+gJQZ1Z
         cSYMHUTFeswEmC93lukhzzi7zYTzOX2M3OhHXo9a4zidpSYT4lJh/f1kG2DSrKOcAA9B
         HTNwt/b/nPg/RGj/ExZQ115UWvSh2jg0hFOMMVhDK46fKG+YtldHlIYQwMQjgs391bOP
         WHJYLZycxLaHhxX2e2QeTRuuPYqCaw28Wcgez/jQf2XnAaMO0KY1B8SKea/rGYpFQyYK
         5Vow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X4ptc1+o2qKwFMRy0Ztxm6pBTMKhv1UyUWGrhFH/wrY=;
        b=oRUTbXoXOFxfy0BGpZXb7VRvSbsjkwl8uhrCXuuPHwIIVvPolm9BGS4cVTr3rGy81m
         8TIvQ3Wvz9oQTIvH4MxNkcBm1/kFyHjjFWlLWpYbDSGSQW3Lz8xB8VUaoMnEHtBu7v4L
         8WMzKErj6K7h6+u8kIIzxLjBW67CsBSSD0tsyIlS4RWINqY4ThYg2h2dUPqzPiqk4B+l
         MfSGKp2vKIi0ZjLUhoWBi6fPGMtcBFWcTuzOtBwiJXyy1hHo00BJgtQRfTVYjdAwPPwO
         xEtOIBW8ZO7BZZPN7eK03BpdYTBEGCFzUf6xavQRWr51Xz/HDWgYLQoSgaZLo41qxLM6
         tQ6A==
X-Gm-Message-State: AJcUukf+4xBlQCC3g/n50JrW28IQ7FvMMEQzfoEIsjJ3uoEt/Qb+aCjG
        rnb8DvA+UL1Wyg7i5DM+4WUuko/cgJIXyRWgPvpzFw==
X-Google-Smtp-Source: ALg8bN5tlWIxF3FBofAuKHrDiAv7Prdd03m93G2d/iMQWoeRqqZryPPSZGaSyFMLDNXdFVFYfElrzcB84S9+gUEngiU=
X-Received: by 2002:a6b:fa0e:: with SMTP id p14mr23555548ioh.271.1546253094702;
 Mon, 31 Dec 2018 02:44:54 -0800 (PST)
MIME-Version: 1.0
References: <0000000000002cdabf057685027b@google.com> <CACT4Y+avdGM3bTCCHFxgH-4BpgA4KtGz6c=7R=Kwm5aGiq8zOg@mail.gmail.com>
In-Reply-To: <CACT4Y+avdGM3bTCCHFxgH-4BpgA4KtGz6c=7R=Kwm5aGiq8zOg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 31 Dec 2018 11:44:43 +0100
Message-ID: <CACT4Y+ZVeybp_cPNwgAscPGjNDYktd9MiXk+MrBJ+y6MSsnxQw@mail.gmail.com>
Subject: Re: net build error
To:     syzbot <syzbot+a72ba31e3224309179d4@syzkaller.appspotmail.com>,
        netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2018 at 10:14 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Sun, Sep 23, 2018 at 9:42 AM, syzbot
> <syzbot+a72ba31e3224309179d4@syzkaller.appspotmail.com> wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    474ff2600889 net-ethtool: ETHTOOL_GUFO did not and should ..
> > git tree:       net
> > console output: https://syzkaller.appspot.com/x/log.txt?x=164c4059400000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=5fa12be50bca08d8
> > dashboard link: https://syzkaller.appspot.com/bug?extid=a72ba31e3224309179d4
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+a72ba31e3224309179d4@syzkaller.appspotmail.com
>
> +netdev
>
> The root cause:

Turns out +David fixed this in September with:

#syz fix: rds: Fix build regression.

> net/rds/ib.o:(.data..percpu..shared_aligned+0x0): multiple definition
> of `rds_ib_stats'
> net/rds/rdma_transport.o:(.data..percpu..shared_aligned+0x0): first defined here
> net/rds/ib_cm.o:(.data..percpu..shared_aligned+0x0): multiple
> definition of `rds_ib_stats'
> net/rds/rdma_transport.o:/syzkaller/managers/upstream-net-this-kasan-gce/kernel/net/rds/rdma_transport.c:284:
> first defined here
> net/rds/ib_recv.o:(.data..percpu..shared_aligned+0x0): multiple
> definition of `rds_ib_stats'
> net/rds/rdma_transport.o:/syzkaller/managers/upstream-net-this-kasan-gce/kernel/net/rds/rdma_transport.c:284:
> first defined here
> net/rds/ib_ring.o:(.data..percpu..shared_aligned+0x0): multiple
> definition of `rds_ib_stats'
> net/rds/rdma_transport.o:/syzkaller/managers/upstream-net-this-kasan-gce/kernel/net/rds/rdma_transport.c:284:
> first defined here
> net/rds/ib_send.o:(.data..percpu..shared_aligned+0x0): multiple
> definition of `rds_ib_stats'
> net/rds/rdma_transport.o:/syzkaller/managers/upstream-net-this-kasan-gce/kernel/net/rds/rdma_transport.c:284:
> first defined here
> net/rds/ib_stats.o:(.data..percpu..shared_aligned+0x0): multiple
> definition of `rds_ib_stats'
> net/rds/rdma_transport.o:/syzkaller/managers/upstream-net-this-kasan-gce/kernel/net/rds/rdma_transport.c:284:
> first defined here
> net/rds/ib_sysctl.o:(.data..percpu..shared_aligned+0x0): multiple
> definition of `rds_ib_stats'
> net/rds/rdma_transport.o:/syzkaller/managers/upstream-net-this-kasan-gce/kernel/net/rds/rdma_transport.c:284:
> first defined here
> net/rds/ib_rdma.o:(.data..percpu..shared_aligned+0x0): multiple
> definition of `rds_ib_stats'
> net/rds/rdma_transport.o:/syzkaller/managers/upstream-net-this-kasan-gce/kernel/net/rds/rdma_transport.c:284:
> first defined here
> net/rds/ib_fmr.o:(.data..percpu..shared_aligned+0x0): multiple
> definition of `rds_ib_stats'
> net/rds/rdma_transport.o:/syzkaller/managers/upstream-net-this-kasan-gce/kernel/net/rds/rdma_transport.c:284:
> first defined here
> net/rds/ib_frmr.o:(.data..percpu..shared_aligned+0x0): multiple
> definition of `rds_ib_stats'
> net/rds/rdma_transport.o:/syzkaller/managers/upstream-net-this-kasan-gce/kernel/net/rds/rdma_transport.c:284:
> first defined here
> Makefile:1030: recipe for target 'vmlinux' failed
> make: *** [vmlinux] Error 1
>
>
> > ---
> > This bug is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this bug report. See:
> > https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> > syzbot.
