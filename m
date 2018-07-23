Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A03ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE96B20779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="NvcX3HH0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE96B20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388159AbeGWQK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:10:57 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:42107 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388042AbeGWQK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:10:57 -0400
Received: by mail-oi0-f66.google.com with SMTP id n84-v6so1700205oib.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 08:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gOIU6Fx97Gx3e5QXaoHB5ib9jh9Ws2P+yxqInVKs3G8=;
        b=NvcX3HH0NEyWZ1b/7Wmrn0vM0R/2YjpK0zk+BHoEIhu4HkeIoe1SAfCUQeivFANw0f
         /Zzwefc2g9xk6qfVahkZG1eUcd2DXdkaMjaVkXHDimwqtnICuXWS/ZuRRX/aXKOI6nC4
         s1CWECN7j+wiDcF5f1ksm/vGLXT+YVQyNVjMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gOIU6Fx97Gx3e5QXaoHB5ib9jh9Ws2P+yxqInVKs3G8=;
        b=kWlqda+vAu3hlZwlzauZrPkXnHiJXLS6aPvSDujAoMW3lOeGVjTn5G2SlKv3avqEcE
         oPJ2GKM56mXApWU0XwnuFvZ23A1c1fastOnmjACx+wZMaC182kWJlL99XruE4zZjGvyU
         powhdcL9R198qCE2o/kZfVWk/M7rUG8hxCD+1Te41j+rfiDVZ1QdOfpojHn3q945ZeOR
         jDiVFSX9Cn1yOTRdh0Ui6rvROpH6GDq74BXoxwBgu5/QfyFMTbH7OWodVJxR/I3YTqC5
         f1fvshczILlJrhS/fYJPLeaA/FtoqNNIiGjHBHef9yyhmUSHLXljRxhpae1CjMCT+Vdu
         KeUg==
X-Gm-Message-State: AOUpUlG56IzWa4KnV46o5EPj/H0nacm4IbJ+3wuHa8UVNZyGgEKgnZPv
        ygR3ar5njy5eQCQzwA+fjicoalM4FdFyQlUmXuwDJg==
X-Google-Smtp-Source: AAOMgpdtBebd0z4zUKCISWCiedJxiUZk7xOo/pkcLc9/dEIOlbEGZY1ajuBAZY2hYngE9SIhTmWv85x7C2ysKpSfJsA=
X-Received: by 2002:aca:ce0f:: with SMTP id e15-v6mr9428763oig.13.1532358556720;
 Mon, 23 Jul 2018 08:09:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:113c:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 08:09:15
 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <CACT4Y+Y2ec4-ywG+FWocir6XXkwt-11qD+SAFwswtG2Ng6BS4A@mail.gmail.com>
References: <000000000000bc17b60571a60434@google.com> <CACT4Y+bKU8f4jVENYHX=fzNVd95A4vce2F=UCV12paVNFv-LNg@mail.gmail.com>
 <CAJfpegsKWGZ4LVeQXrrCr47+Bch4yfOWcWMFSniQsRzjRof=RQ@mail.gmail.com>
 <CACT4Y+ZbRi=0kRiR-j-SkngsB_QuALfnOX5nGF4agQD-weFsew@mail.gmail.com>
 <CAJfpegs0by5OJ7iqtg6L3T1w2RrFRiU6yRufVNbt=tNpJCbf2A@mail.gmail.com>
 <CACT4Y+bSnJjtgeLdusj6czbH8080XfRs2b8L0V4R0TAixqxX6Q@mail.gmail.com>
 <CAJfpegvYHYUMdo14J_of10rmg0krjd_eiATJ3D4+XqaNys9bqQ@mail.gmail.com> <CACT4Y+Y2ec4-ywG+FWocir6XXkwt-11qD+SAFwswtG2Ng6BS4A@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 23 Jul 2018 17:09:15 +0200
Message-ID: <CAJfpeguni8JReXKXU_yUFqBfHav1-JFHfHzhxc=kaXu3ME6Qsw@mail.gmail.com>
Subject: Re: INFO: task hung in fuse_reverse_inval_entry
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+bb6d800770577a083f8c@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 3:37 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Mon, Jul 23, 2018 at 3:05 PM, Miklos Szeredi <miklos@szeredi.hu> wrote:

>> Biggest conceptual problem: your definition of fuse-server is weak.
>> Take the following example: process A is holding the fuse device fd
>> and is forwarding requests and replies to/from process B via a pipe.
>> So basically A is just a proxy that does nothing interesting, the
>> "real" server is B.  But according to your definition B is not a
>> server, only A is.
>
> I proposed to abort fuse conn when all fuse device fd's are "killed"
> (all processes having the fd opened are killed). So if _only_ process
> B is killed, then, yes, it will still hang. However if A is killed or
> both A and B (say, process group, everything inside of pid namespace,
> etc) then the deadlock will be autoresolved without human
> intervention.

Okay, so you're saying:

1) when process gets SIGKILL and is uninterruptible sleep mark process as doomed
2) for a particular fuse instance find set of fuse device fd
references that are in non-doomed tasks; if there are none then abort
fuse instance

Right?

The above is not an implementation proposal, just to get us on the
same page regarding the concept.

>> And this is just a simple example, parts of the server might be on
>> different machines, etc...  It's impossible to automatically detect if
>> a process is acting as a fuse server or not.
>
> It does not seem we need the precise definition. If no one ever can
> write anything into the fd, we can safely abort the connection (?).

Seems to me so.

> If
> we don't, we can either get that the process exits normally and the
> connection is doomed anyway, so no difference in behavior, or we can
> get a deadlock.
>
>> We could let the fuse server itself notify the kernel that it's a fuse
>> server.  That might help in the cases where the deadlock is
>> accidental, but obviously not in the case when done by a malicious
>> agent.  I'm not sure it's worth the effort.   Also I have no idea how
>> the respective maintainers would take the idea of "kill hooks"...   It
>> would probably be a lot of work for little gain.
>
> What looks wrong to me here is that fuse is only (?) subsystem in
> kernel that stops SIGKILL from working and requires complex custom
> dance performed by a human operator (which is not necessary there at
> all). Say, if a process has opened a socket, whatever, I don't need to
> locate and abort something in socketctl fs, just SIGKILL. If a
> processes has opened a file, I don't need to locate the fd in /proc
> and abort it, just SIGKILL. If a process has created an ipc object, I
> don't need to do any special dance, just SIGKILL. fuse is somehow very
> special, if we have more such cases, it definitely won't scale.
> I understand that there can be implementation difficulties, but
> fundamentally that's how things should work -- choose target
> processes, kill, done, right?

Yes, it would be nice.

But I'm not sure it will fly due to implementation difficulties.  It's
definitely not  a high prio feature currently for me, but I'll happily
accept patches.

Thanks,
Miklos
