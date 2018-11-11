Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199B7C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDACE20871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:59:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDACE20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730888AbeKLFsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:48:37 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:40575 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730859AbeKLFsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:36 -0500
Received: by mail-io1-f72.google.com with SMTP id r14-v6so7978408ioc.7
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 11:59:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=+vYlW24TyC2nI352pJYmFh3sGCuFh3pJQ3IuK6rOgxA=;
        b=BgrQECZat8Vn0FCe1q2YFyPVIkxFzW5WvlmgfO3Iv3ZFn5XyGJQktzRClidN+4H3Ec
         ixwQmpb7+dmtiVEu26hoEgOS6MeghxC7qs5LDOtOXCQQxDT8v2MVxs8pQWWLUenk1UvT
         jV8eBjk44UfzI1O0Wc850TRjfGVQNt+HJRLXK6++27rnyo+HW5zdT/7QbTJHTF5mgIOc
         vgyUTdPr/EdTufyOgmJMmNSO2Fasta2r7phtfwa8rm24wydlM1bQvABEGmbbxhBmRjmR
         w20XoaWSVImd45vbSDPklQZLwMK3yttaWT+arbK+tB6w9tF1PSgMgq4DxL9RkmNYAUzc
         EEmw==
X-Gm-Message-State: AGRZ1gIR1FQrJnvmUlPw3CAWyMPWuC3TLuk2RJTDd4dNAhutiE03tO17
        olepEJBfxQaQNucusd/BLM3gyBgItdxv/6f8gaKDVbBqUi14
X-Google-Smtp-Source: AJdET5fLqCIlUQg3Ne5SWw17sryy5MxvlkuNu6nrxI9UoYQdvpdP5ucEKiXuoiWLpYeH696pqnavw5vgjC2NnyKWCjw6Nc2Z+Mia
MIME-Version: 1.0
X-Received: by 2002:a24:62c9:: with SMTP id d192-v6mr1830943itc.38.1541966347661;
 Sun, 11 Nov 2018 11:59:07 -0800 (PST)
Date:   Sun, 11 Nov 2018 11:59:07 -0800
In-Reply-To: <lsq.1541965745.239435396@decadent.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000687eda057a6904e9@google.com>
Subject: Re: [PATCH 3.16 213/366] vt: prevent leaking uninitialized data to
 userspace via /dev/vcs*
From:   syzbot <syzbot+17a8efdf800000@syzkaller.appspotmail.com>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     akpm@linux-foundation.org, ben@decadent.org.uk, glider@google.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 3.16.61-rc1 review patch.  If anyone has any objections, please let me  
> know.

> ------------------

> From: Alexander Potapenko <glider@google.com>

> commit 21eff69aaaa0e766ca0ce445b477698dc6a9f55a upstream.

> KMSAN reported an infoleak when reading from /dev/vcs*:

>    BUG: KMSAN: kernel-infoleak in vcs_read+0x18ba/0x1cc0
>    Call Trace:
>    ...
>     kmsan_copy_to_user+0x7a/0x160 mm/kmsan/kmsan.c:1253
>     copy_to_user ./include/linux/uaccess.h:184
>     vcs_read+0x18ba/0x1cc0 drivers/tty/vt/vc_screen.c:352
>     __vfs_read+0x1b2/0x9d0 fs/read_write.c:416
>     vfs_read+0x36c/0x6b0 fs/read_write.c:452
>    ...
>    Uninit was created at:
>     kmsan_save_stack_with_flags mm/kmsan/kmsan.c:279
>     kmsan_internal_poison_shadow+0xb8/0x1b0 mm/kmsan/kmsan.c:189
>     kmsan_kmalloc+0x94/0x100 mm/kmsan/kmsan.c:315
>     __kmalloc+0x13a/0x350 mm/slub.c:3818
>     kmalloc ./include/linux/slab.h:517
>     vc_allocate+0x438/0x800 drivers/tty/vt/vt.c:787
>     con_install+0x8c/0x640 drivers/tty/vt/vt.c:2880
>     tty_driver_install_tty drivers/tty/tty_io.c:1224
>     tty_init_dev+0x1b5/0x1020 drivers/tty/tty_io.c:1324
>     tty_open_by_driver drivers/tty/tty_io.c:1959
>     tty_open+0x17b4/0x2ed0 drivers/tty/tty_io.c:2007
>     chrdev_open+0xc25/0xd90 fs/char_dev.c:417
>     do_dentry_open+0xccc/0x1440 fs/open.c:794
>     vfs_open+0x1b6/0x2f0 fs/open.c:908
>    ...
>    Bytes 0-79 of 240 are uninitialized

> Consistently allocating |vc_screenbuf| with kzalloc() fixes the problem

> Reported-by: syzbot+17a8efdf800000@syzkaller.appspotmail.com
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
>   drivers/tty/vt/vt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -782,7 +782,7 @@ int vc_allocate(unsigned int currcons)	/
>   	if (!*vc->vc_uni_pagedir_loc)
>   		con_set_default_unimap(vc);

> -	vc->vc_screenbuf = kmalloc(vc->vc_screenbuf_size, GFP_KERNEL);
> +	vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_KERNEL);
>   	if (!vc->vc_screenbuf)
>   		goto err_free;

> @@ -869,7 +869,7 @@ static int vc_do_resize(struct tty_struc

>   	if (new_screen_size > (4 << 20))
>   		return -EINVAL;
> -	newscreen = kmalloc(new_screen_size, GFP_USER);
> +	newscreen = kzalloc(new_screen_size, GFP_USER);
>   	if (!newscreen)
>   		return -ENOMEM;



Can't find the corresponding bug.

