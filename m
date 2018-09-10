Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B19C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C9D120865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="KsWbiiPA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C9D120865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbeIJOV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:21:56 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:44061 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeIJOV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:21:56 -0400
Received: by mail-oi0-f67.google.com with SMTP id l82-v6so38797638oih.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 02:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wKNViIvO1QwPyBuOVDlCe2ARkxs1nn+CjDgAg5AbrA4=;
        b=KsWbiiPAWtZufowQbVlI3CTDtw2EBOoPGaG5Q1uYKuNMk3+1KhwG77Y07cGDZhU9I2
         LuIJCGWYVcTgYTmizqkSH5wKyQL6hsgkhIFGNbjNFNmsqxvBWbsfSlSCzY8pNSSHxwH9
         fhTMDb4XJesFUw+Eh210iD0F2Z6o9NBUF1B38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wKNViIvO1QwPyBuOVDlCe2ARkxs1nn+CjDgAg5AbrA4=;
        b=KiqsALpoZbhK8dx7+lvEWRtMZAkgiNqmu+kcDYgNWkCJ4LHJq7PRTdRrMHZL1MyKik
         6YFQV6n4PRumUVMxbCeRLhTZjOG4Xp3HwC9vC+RTrTjJizW7txeElwdxui7oSMcT7jC8
         Rpd17LKj0g6SvqwKFFULSGW3Kl3+5cRqfE2+VLcck2TQs9WW8HGXZ9YYU/c3ttzQgpTW
         Db8bMF65UAgXsnXlNJQGEIE37gFptPTbud7Bl2aU+kFj1HpbKmH4N3EQJnPhnFV/3PiG
         lyQ7Tq93l4usF+kyeuFpoob3alufsLp/I8o2M9vt/FTxru95XZ4ja666xHnLQ2WdTlKg
         Wasg==
X-Gm-Message-State: APzg51By7EYCr4mzAGxcYgwiGAvrZ6ei4z10xBydpOkyxFz/uH8x27Sf
        m0tdan0l6KxEd4otdikfLPVuYiN29aYgbrEEyNT7uQ==
X-Google-Smtp-Source: ANB0VdZiWeGf3rT4xTpdY7caQEsH8wFV9v3vnrvA54azyXbjfziJcKXuAXyG84i7P1BlVkgqW1MqLKDpLqeXsCaXCrA=
X-Received: by 2002:aca:5043:: with SMTP id e64-v6mr19963122oib.111.1536571728912;
 Mon, 10 Sep 2018 02:28:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:24a3:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 02:28:48
 -0700 (PDT)
X-Originating-IP: [94.21.245.65]
In-Reply-To: <00000000000024df4605757495a8@google.com>
References: <00000000000024df4605757495a8@google.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 10 Sep 2018 11:28:48 +0200
Message-ID: <CAJfpegsqsESUft-azOkirq9363nUXM=Sx4YMX6XVQxquEbjS7Q@mail.gmail.com>
Subject: Re: possible deadlock in free_ioctx_users
To:     syzbot <syzbot+d86c4426a01f60feddc7@syzkaller.appspotmail.com>
Cc:     bcrl@kvack.org, linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 9, 2018 at 8:41 PM, syzbot
<syzbot+d86c4426a01f60feddc7@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    f8f65382c98a Merge tag 'for-linus' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=113260ae400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8f59875069d721b6
> dashboard link: https://syzkaller.appspot.com/bug?extid=d86c4426a01f60feddc7
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=120baa9e400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13979cbe400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+d86c4426a01f60feddc7@syzkaller.appspotmail.com
>
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
>
> ========================================================
> WARNING: possible irq lock inversion dependency detected
> 4.19.0-rc2+ #229 Not tainted
> --------------------------------------------------------
> swapper/0/0 just changed the state of lock:
> 00000000c02bddef (&(&ctx->ctx_lock)->rlock){..-.}, at: spin_lock_irq
> include/linux/spinlock.h:354 [inline]
> 00000000c02bddef (&(&ctx->ctx_lock)->rlock){..-.}, at:
> free_ioctx_users+0xbc/0x710 fs/aio.c:603
> but this lock took another, SOFTIRQ-unsafe lock in the past:
>  (&fiq->waitq){+.+.}
>
>
> and interrupts could create inverse lock ordering between them.
>
>
> other info that might help us debug this:
>  Possible interrupt unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(&fiq->waitq);
>                                local_irq_disable();
>                                lock(&(&ctx->ctx_lock)->rlock);
>                                lock(&fiq->waitq);
>   <Interrupt>
>     lock(&(&ctx->ctx_lock)->rlock);

Fuse device doesn't support AIO ops.  So false positive, AFAICS.

Thanks,
Miklos
