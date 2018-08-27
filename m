Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE7EC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B85620835
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bLYBwZF5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B85620835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbeH0WH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:07:57 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:39287 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeH0WH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:07:57 -0400
Received: by mail-yb0-f194.google.com with SMTP id c4-v6so6380509ybl.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 11:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PF233pjCKiRZ1uOy07scUd2ksgBFhPyBX29ivkxtDao=;
        b=bLYBwZF5Q7pxH8dJDMoHP7YCKw36y5pFFeWt9T+SccMPZpo+CT7uMSWP/ZohUbtW0v
         uQFP6xJJso8nsEo8E95DXxwSSksHpTQfodcXoAy+toMwxZBnji65FI334juOcoX5e7mA
         YeuvqAk45iQACltk6bM66VYWQTdP5ygpjkPkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PF233pjCKiRZ1uOy07scUd2ksgBFhPyBX29ivkxtDao=;
        b=sCXGteoTWwK6avZS/A0BqjLr75s68yzKT72xq2F99OIgyqFPfhGbknAGNwSEHj1QlW
         miYLZ+913sq/RAqRgPYBHJtOvZlhG4mh5nKJec6SK1NKpGkSLufyREk9fRd8oEMxXI+1
         Fvns84iA3uqUJp2F63gtxywAUeIzmsxFQ3XkzxypZj/VUH4ShUe5XbCBqX6dNDpCdsoZ
         qfwK5IrO9b/f3CmHXEibyl1XAlopkMtRKlq2C1o+2HAEmBciD7HOy8qPO6jdNhrd/y/7
         TxGjJCXBW5Q/hBaISpT9sjUq7I879Rr6y9NblAbYZPwZeosCFgMNf1KYsM+T9HaQPYbl
         0l2A==
X-Gm-Message-State: APzg51BRS0rejkIwxC3ypBhKgLGo9walJ0A0A8gSlmgnN/nyRCsf2eSF
        G0/KkaR6oeDqGTyfs68F36rnSvVDXk4=
X-Google-Smtp-Source: ANB0VdZqlovZSSAYe2icWzI5/rwntvPJ3Km3GnVovIyBrsD2/jk18HVAQKCsyenYKL6VzEjtmoBz5A==
X-Received: by 2002:a25:2614:: with SMTP id m20-v6mr7426476ybm.251.1535394015798;
        Mon, 27 Aug 2018 11:20:15 -0700 (PDT)
Received: from mail-yb0-f180.google.com (mail-yb0-f180.google.com. [209.85.213.180])
        by smtp.gmail.com with ESMTPSA id d21-v6sm10332420ywb.16.2018.08.27.11.20.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 11:20:14 -0700 (PDT)
Received: by mail-yb0-f180.google.com with SMTP id o17-v6so6393986yba.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 11:20:13 -0700 (PDT)
X-Received: by 2002:a25:e5c3:: with SMTP id c186-v6mr7488033ybh.209.1535394013156;
 Mon, 27 Aug 2018 11:20:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:2c11:0:0:0:0:0 with HTTP; Mon, 27 Aug 2018 11:20:12
 -0700 (PDT)
In-Reply-To: <20171212220647.GJ185376@gmail.com>
References: <001a113f711ae2110c055f45acb8@google.com> <20171212220647.GJ185376@gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 27 Aug 2018 11:20:12 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLcuE-h9V04fTtoSfz9mZdVeH1zfJOpRncK2NZkv2gsnQ@mail.gmail.com>
Message-ID: <CAGXu5jLcuE-h9V04fTtoSfz9mZdVeH1zfJOpRncK2NZkv2gsnQ@mail.gmail.com>
Subject: Re: possible deadlock in seq_read
To:     Eric Biggers <ebiggers3@gmail.com>
Cc:     syzbot 
        <bot+e93a80c1bb7c5c56e522461c149f8bf55eab1b2b@syzkaller.appspotmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Al Viro <viro@zeniv.linux.org.uk>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2017 at 2:06 PM, Eric Biggers <ebiggers3@gmail.com> wrote:
> On Fri, Dec 01, 2017 at 03:29:01AM -0800, syzbot wrote:
>> Hello,
>>
>> syzkaller hit the following crash on
>> df8ba95c572a187ed2aa7403e97a7a7f58c01f00
>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/master
>> compiler: gcc (GCC) 7.1.1 20170620
>> .config is attached
>> Raw console output is attached.
>>
>> Unfortunately, I don't have any reproducer for this bug yet.
>>
>>
>>
>> ======================================================
>> WARNING: possible circular locking dependency detected
>> 4.15.0-rc1+ #202 Not tainted
>> ------------------------------------------------------
>> syz-executor4/26476 is trying to acquire lock:
>>  (&p->lock){+.+.}, at: [<0000000040185b66>] seq_read+0xd5/0x13d0
>> fs/seq_file.c:165
>>
>> but task is already holding lock:
>>  (&pipe->mutex/1){+.+.}, at: [<00000000c644bcdc>] pipe_lock_nested
>> fs/pipe.c:67 [inline]
>>  (&pipe->mutex/1){+.+.}, at: [<00000000c644bcdc>]
>> pipe_lock+0x56/0x70 fs/pipe.c:75
>>
>> which lock already depends on the new lock.
>>
>>
>> the existing dependency chain (in reverse order) is:
>>
>> -> #2 (&pipe->mutex/1){+.+.}:
>>        lock_acquire+0x1d5/0x580 kernel/locking/lockdep.c:4004
>>        __mutex_lock_common kernel/locking/mutex.c:756 [inline]
>>        __mutex_lock+0x16f/0x1a80 kernel/locking/mutex.c:893
>>        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:908
>>        __pipe_lock fs/pipe.c:88 [inline]
>>        fifo_open+0x15c/0xa40 fs/pipe.c:916
>>        do_dentry_open+0x682/0xd70 fs/open.c:752
>>        vfs_open+0x107/0x230 fs/open.c:866
>>        do_last fs/namei.c:3379 [inline]
>>        path_openat+0x1157/0x3530 fs/namei.c:3519
>>        do_filp_open+0x25b/0x3b0 fs/namei.c:3554
>>        do_open_execat+0x1b9/0x5c0 fs/exec.c:849
>>        do_execveat_common.isra.30+0x90c/0x23c0 fs/exec.c:1741
>>        do_execveat fs/exec.c:1859 [inline]
>>        SYSC_execveat fs/exec.c:1940 [inline]
>>        SyS_execveat+0x4f/0x60 fs/exec.c:1932
>>        do_syscall_64+0x26c/0x920 arch/x86/entry/common.c:285
>>        return_from_SYSCALL_64+0x0/0x75
>>
>> -> #1 (&sig->cred_guard_mutex){+.+.}:
>>        lock_acquire+0x1d5/0x580 kernel/locking/lockdep.c:4004
>>        __mutex_lock_common kernel/locking/mutex.c:756 [inline]
>>        __mutex_lock+0x16f/0x1a80 kernel/locking/mutex.c:893
>>        mutex_lock_killable_nested+0x16/0x20 kernel/locking/mutex.c:923
>>        do_io_accounting+0x1c2/0xf50 fs/proc/base.c:2682
>>        proc_tid_io_accounting+0x1f/0x30 fs/proc/base.c:2725
>>        proc_single_show+0xf8/0x170 fs/proc/base.c:744
>>        seq_read+0x385/0x13d0 fs/seq_file.c:234
>>        __vfs_read+0xef/0xa00 fs/read_write.c:411
>>        vfs_read+0x124/0x360 fs/read_write.c:447
>>        SYSC_read fs/read_write.c:573 [inline]
>>        SyS_read+0xef/0x220 fs/read_write.c:566
>>        entry_SYSCALL_64_fastpath+0x1f/0x96
>>
>
> So the problem with all these deadlocks involving pipe->mutex and
> sig->cred_guard_mutex is that execve() ranks pipe->mutex below
> sig->cred_guard_mutex when it tries to open a fifo, whereas reading or writing
> some of the /proc files result in ->cred_guard_mutex being taken which may be
> underneath pipe->mutex from splice().  Here's a program which causes an actual
> deadlock using this bug (in addition to reproducing the lockdep report):
>
>         #define _GNU_SOURCE
>         #include <fcntl.h>
>         #include <pthread.h>
>         #include <sys/stat.h>
>         #include <unistd.h>
>
>         static void *exec_thread(void *_arg)
>         {
>                 for (;;)
>                         execl("fifo", "fifo", NULL);
>         }
>
>         int main()
>         {
>                 int readend, writeend;
>                 int syscallfd;
>                 pthread_t t;
>
>                 mknod("fifo", 0777|S_IFIFO, 0);
>                 readend = open("fifo", O_RDONLY|O_NONBLOCK);
>                 writeend = open("fifo", O_WRONLY);
>                 syscallfd = open("/proc/self/syscall", O_RDONLY);
>
>                 pthread_create(&t, NULL, exec_thread, NULL);
>
>                 for (;;) {
>                         char buffer[16];
>                         loff_t off_in = 0;
>                         splice(syscallfd, &off_in, writeend, NULL, 16, 0);
>                         read(readend, buffer, 16);
>                 }
>         }
>
> I'm not sure what the fix will be.  Maybe the proc handlers should take a
> different lock instead of cred_guard_mutex.  Or perhaps execve should check that
> the file is a regular file before it attempts to open it.

This cleaner reproducer still generates the lockdep warning (but I can
ctrl-C out of it without leaving behind a zombie), but I see that
syzbot isn't seeing this any more. Why did it stop? (And can we feed a
reproducer in to syzbot?)

Was this creating an uninterruptible deadlock before? (Perhaps
something did change here?)

-Kees

-- 
Kees Cook
Pixel Security
