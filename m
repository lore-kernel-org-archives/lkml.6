Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7DCECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D29F20875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="TFwZLITo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D29F20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387968AbeGWNNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:13:41 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34145 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387861AbeGWNNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:13:40 -0400
Received: by mail-oi0-f65.google.com with SMTP id 13-v6so693657ois.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 05:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZUE5mYUf3UVFVuA0Yt9wuWT1APpygM0z+Xja8I6EJw4=;
        b=TFwZLIToArlnBIICAiAYCh6ca9ExnNhljlyvmeHPb876rNPejf2jJOO1yK2ODVV8pW
         5/UK0cOtqi4Vf4HOQBNPA1DW8WXm0DSx1cjmp/EogUUUWR423qnXMhXeuHk1y3HwIbRN
         370nx798iXd+3JbvVNm0oQnbN+COQCIvfrGJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZUE5mYUf3UVFVuA0Yt9wuWT1APpygM0z+Xja8I6EJw4=;
        b=m5sFxf/bkBjS8FUQfMxkfdYtqJiAUDoJNiyGxHBUTs4GhHopyynJJTiLr4847Ov0xU
         wVNnO4+peFvJAc/EdVo0FU8D/mg29+QoEBG1tzkeonQUUl8Ae0gmX5JMXdWEYvfojRnZ
         p1RGeLg7upNc8DPRR5vD4F0WQb9OGqtOWYhABfokf8JRnZQrUPdACkmnCTZaxDwTR7kw
         99mpqeFPi3fcAukZmZjEv7vilbsnDE5qJ/T/EyAYn6mg8MumeqJyrFCPZ8cbCUKItj6T
         IjYow7MUtWmd5xuoUwhmsjgRA1Qqb7VxlryL0/FvGY2ipEfgOrbwOxzutO3T8ir+W022
         xNog==
X-Gm-Message-State: AOUpUlE1ltqKGeHjSlWMfkgXZRzsbn/5/382RYKtyd0AvoUfqKjJHQ5g
        LgvvIwv+u9pech3XOIn09TuQgYz1zKFN8O/e5lN8XA==
X-Google-Smtp-Source: AAOMgpeFQP21kEqnxicGBvX59iyqaG5+Ljtq0G8ekrS+vsfxtrM9fHI7EzOWNDzyvKFdsgcxAU6fSAuU3cLMr8SfJog=
X-Received: by 2002:aca:c257:: with SMTP id s84-v6mr8845721oif.104.1532347965577;
 Mon, 23 Jul 2018 05:12:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:113c:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 05:12:44
 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <CACT4Y+bKU8f4jVENYHX=fzNVd95A4vce2F=UCV12paVNFv-LNg@mail.gmail.com>
References: <000000000000bc17b60571a60434@google.com> <CACT4Y+bKU8f4jVENYHX=fzNVd95A4vce2F=UCV12paVNFv-LNg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 23 Jul 2018 14:12:44 +0200
Message-ID: <CAJfpegsKWGZ4LVeQXrrCr47+Bch4yfOWcWMFSniQsRzjRof=RQ@mail.gmail.com>
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

On Mon, Jul 23, 2018 at 10:11 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Mon, Jul 23, 2018 at 9:59 AM, syzbot
> <syzbot+bb6d800770577a083f8c@syzkaller.appspotmail.com> wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    d72e90f33aa4 Linux 4.18-rc6
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1324f794400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=68af3495408deac5
>> dashboard link: https://syzkaller.appspot.com/bug?extid=bb6d800770577a083f8c
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=11564d1c400000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16fc570c400000
>
>
> Hi fuse maintainers,
>
> We are seeing a bunch of such deadlocks in fuse on syzbot. As far as I
> understand this is mostly working-as-intended (parts about deadlocks
> in Documentation/filesystems/fuse.txt). The intended way to resolve
> this is aborting connections via fusectl, right?

Yes.  Alternative is with "umount -f".

> The doc says "Under
> the fuse control filesystem each connection has a directory named by a
> unique number". The question is: if I start a process and this process
> can mount fuse, how do I kill it? I mean: totally and certainly get
> rid of it right away? How do I find these unique numbers for the
> mounts it created?

It is the device number found in st_dev for the mount.  Other than
doing stat(2) it is possible to find out the device number by reading
/proc/$PID/mountinfo  (third field).

> Taking into account that there is usually no
> operator attached to each server, I wonder if kernel could somehow
> auto-abort fuse on kill?

Depends on what the fuse server is sleeping on.   If it's trying to
acquire an inode lock (e.g. unlink(2)), which is classical way to
deadlock a fuse filesystem, then it will go into an uninterruptible
sleep.  There's no way in which that process can be killed except to
force a release of the offending lock, which can only be done by
aborting the request that is being performed while holding that lock.

Thanks,
Miklos
