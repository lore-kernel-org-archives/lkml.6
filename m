Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B52DC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF66B21A80
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="JrdMjMpK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfBKMGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:06:47 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:54901 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfBKMGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:06:47 -0500
Received: by mail-it1-f196.google.com with SMTP id i145so25638203ita.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 04:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z2Xh5zlpM8WIhAH4sklxUfsqKEREhJGqUEeIguWIA/Y=;
        b=JrdMjMpKUnaCUmmQbr1lleqQRlfzOG4vZXJCKK8US6k1LBqOoJDTkrzNR391jmrkVD
         Qs6jcMcqLq1eBUa1Q6v+iS+Bmx5lEHRal7q+H//NUhm4o/9gZQ04PFLMWrOaUq94Bgrl
         FP3xh7XM1NYnVTUFzPv7jmFxe6dWWKMfgTiiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z2Xh5zlpM8WIhAH4sklxUfsqKEREhJGqUEeIguWIA/Y=;
        b=cPAuSGuZgPIVnZL9l6q6O8Lyhfw089+AZ84HWFoiGh7y4sE9Lv7Hitj0tHlh/Kc4u7
         ETI8Lqt8injPEw2G30B68bf5lhmxTdrqbdn0HkLrY/q1wKc34+aYM5wk1fMIj8/Raah0
         +0FULY7VA325GEAZWh2RGFSXsLgNFpLOIqoaxHqdbJ09bhYxPBtobxP5CAoIeb5Xvk9N
         aFbalnBsajZ1QM4cMLYVJ4OqHuHxlT3jxm3evgC6cEKsY+BCTmKJ/2aXbpfOHAu6aNYH
         Rhejd3/lT/DbpPwl8MN5CD7KkvXOrruhACOisK/uOjVDxQfjdwR2xmGbMT1AhmQW8QVU
         FfXg==
X-Gm-Message-State: AHQUAuZRXkhY0UFQVZIcSPnREmQ3QQMw+sfpXllAmwSBgp9UKzmwm8D1
        p/UOmenAj/IgxrmuQWeVRN8eqJEr3i1pwnFpyCkCYg==
X-Google-Smtp-Source: AHgI3IZpVDGTBya17EYiTx3R1IkyWgSD77FXOPTzQGVFEreDyUwnKoeCbMH7hBG9sOrb0Ijj7zSYMdMdsjRHyvvGVMU=
X-Received: by 2002:a5e:d803:: with SMTP id l3mr13273864iok.144.1549886805856;
 Mon, 11 Feb 2019 04:06:45 -0800 (PST)
MIME-Version: 1.0
References: <000000000000701c3305818e4814@google.com> <CAOQ4uxhhRs6kBH2rgbPyjd=tXoxxuJG76Y2vpCYmD0c0HzLwhA@mail.gmail.com>
In-Reply-To: <CAOQ4uxhhRs6kBH2rgbPyjd=tXoxxuJG76Y2vpCYmD0c0HzLwhA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 11 Feb 2019 13:06:34 +0100
Message-ID: <CAJfpegvjLgXa1HOCZkz6RKup7UdioMGyY7W4miyqcRtn9PL4QA@mail.gmail.com>
Subject: Re: possible deadlock in pipe_lock (2)
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Al Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+31d8b84465a7cbfd8515@syzkaller.appspotmail.com>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 8:38 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Sun, Feb 10, 2019 at 8:23 PM syzbot
> <syzbot+31d8b84465a7cbfd8515@syzkaller.appspotmail.com> wrote:

> > -> #1 (&ovl_i_mutex_key[depth]){+.+.}:
> >         down_write+0x38/0x90 kernel/locking/rwsem.c:70
> >         inode_lock include/linux/fs.h:757 [inline]
> >         ovl_write_iter+0x148/0xc20 fs/overlayfs/file.c:231
> >         call_write_iter include/linux/fs.h:1863 [inline]
> >         new_sync_write fs/read_write.c:474 [inline]
> >         __vfs_write+0x613/0x8e0 fs/read_write.c:487
> > kobject: 'loop4' (000000009e2b886d): kobject_uevent_env
> >         __kernel_write+0x110/0x3b0 fs/read_write.c:506
> >         write_pipe_buf+0x15d/0x1f0 fs/splice.c:797
> >         splice_from_pipe_feed fs/splice.c:503 [inline]
> >         __splice_from_pipe+0x39a/0x7e0 fs/splice.c:627
> >         splice_from_pipe+0x108/0x170 fs/splice.c:662
> >         default_file_splice_write+0x3c/0x90 fs/splice.c:809

Irrelevant to the lockdep splat, but why isn't there an
ovl_splice_write() that just recurses into realfile->splice_write()?
Sounds like a much more efficient way to handle splice read and
write...

[...]

> Miklos,
>
> Its good that this report popped up again, because I went to
> look back at my notes from previous report [1].
> If I was right in my previous analysis then we must have a real
> deadlock in current "lazy copy up" WIP patches. Right?

Hmm, AFAICS this circular dependency translated into layman's terms:

pipe lock -> ovl inode lock  (splice to ovl file)

ovl inode lock -> upper freeze lock (truncate of ovl file)

upper freeze lock -> pipe lock (splice to upper file)

> "This looks like a false positive because lockdep is not aware of
> s_stack_depth of the file (fs) associated with the pipe.

But AFAICS the above dependency doesn't include copy up or stacked
overlay, so looks like a real deadlock.

Am I missing something?

Thanks,
Miklos
