Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74D0C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 01:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 727B020881
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 01:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCUd4T/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 727B020881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933364AbeGJBSB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 21:18:01 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35004 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754588AbeGJBRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 21:17:44 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6-v6so1621462pgv.2;
        Mon, 09 Jul 2018 18:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vo153coLu9EEasa537CpPxbKQej9n+mqzvgyXUU8RWQ=;
        b=RCUd4T/bHJtdlIyhyWGy5MWb8V6kX8Rb/dM9nxTrU0/bvxI77f490cvoTPtsHmI8NF
         pRZEzZ+KlNAIRyRxm1moBfZO6KKkHJd3EHPSn1p7ymqTVyCZYXqx8bb4KKDTTC6YrHnQ
         8XOUtl0I3PTSyZmMPptkCflQVPsdwxF/wk5sMdNb1VpokGGY06e7lZCgHPdaUQYzORQl
         K8PVhOuV3WQaoGuH3/vEPa8ISjMggtOKIH+yC4bofjyvsat25Mb3xbkzFG/+8UlTDvpg
         cH17nNy0pH3NYMc9iiOz9ud15SVoreOo1qvOppB4EeSVq2dV8G9v1fZCHLqoetQAPjUl
         XPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vo153coLu9EEasa537CpPxbKQej9n+mqzvgyXUU8RWQ=;
        b=KUiDu/qALoD+CyLShg1YfWhMKxiiWRKKvKH8ZQkJKfHRVCHQu+R2Cfm496RVG2Q84Q
         XLFgGecy3nIg3Lh99n+NfrQ1PkUuQlI7Yet4vs5yYFSsNWmC0081UD7pnssgwW4pckl9
         cooKA/vxRx92335T+xwG6dtwojIpq+kXvfxAm98gKNvIk6HF+31TerDG+zSZlF2JaIHI
         Lw2T0VyuBYwmmkw4wp9++g//cq7ELCzFIk3rg7IA0Qj0N0A0ARLxsCv38W94G73jXuxh
         hJtRw2EGOfqQJX497mbl3h1g2rucZeipDeiSxSDJd7W4P0rbtRgfsR57+pkQgvp0hjL2
         ZcCg==
X-Gm-Message-State: APt69E3HzXWgyoqLR573Dy8h5jFNv7gNewfsEtbUQ1qvE42TqmhVWwwj
        2OBlEuOQFTJA8XebxKEKSh0=
X-Google-Smtp-Source: AAOMgpfO7/lyZwWNHcSI3pft7y4oa0NH38UVPDeWnAC5H4fzpZMGyhkvilD7GmaRQ4DZ/GUcRtReNQ==
X-Received: by 2002:a65:6104:: with SMTP id z4-v6mr20672082pgu.361.1531185463558;
        Mon, 09 Jul 2018 18:17:43 -0700 (PDT)
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net. [67.185.97.198])
        by smtp.gmail.com with ESMTPSA id q78-v6sm22589575pfi.185.2018.07.09.18.17.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 18:17:42 -0700 (PDT)
Date:   Mon, 9 Jul 2018 18:17:41 -0700
From:   Eric Biggers <ebiggers3@gmail.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH 07/18] fs_context: fix double free of legacy_fs_context
 data
Message-ID: <20180710011741.GA1014@sol.localdomain>
References: <20180708210154.10423-8-ebiggers3@gmail.com>
 <20180708210154.10423-1-ebiggers3@gmail.com>
 <3014.1531139469@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3014.1531139469@warthog.procyon.org.uk>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 01:31:09PM +0100, David Howells wrote:
> Eric Biggers <ebiggers3@gmail.com> wrote:
> 
> > sys_fsmount() calls fc->ops->free() to free the data, zeroes
> > ->fs_private, then proceeds to reuse the context.  But legacy_fs_context
> > doesn't use ->fs_private, so we need to handle zeroing it too; otherwise
> > there's a double free of legacy_fs_context::{legacy_data,secdata}.
> 
> I think the attached is better.  I stopped embedding the fs_context in the
> xxx_fs_context to make certain things simpler, but I missed the legacy
> wrapper.
> 
> David
> ---
> diff --git a/fs/fs_context.c b/fs/fs_context.c
> index f91facc769f7..ab93a0b73dc6 100644
> --- a/fs/fs_context.c
> +++ b/fs/fs_context.c
> @@ -34,7 +34,6 @@ enum legacy_fs_param {
>  };
>  
>  struct legacy_fs_context {
> -	struct fs_context	fc;
>  	char			*legacy_data;	/* Data page for legacy filesystems */
>  	char			*secdata;
>  	size_t			data_size;
> @@ -239,12 +238,21 @@ struct fs_context *vfs_new_fs_context(struct file_system_type *fs_type,
>  				      enum fs_context_purpose purpose)
>  {
>  	struct fs_context *fc;
> -	int ret;
> +	int ret = -ENOMEM;
>  
> -	fc = kzalloc(sizeof(struct legacy_fs_context), GFP_KERNEL);
> +	fc = kzalloc(sizeof(struct fs_context), GFP_KERNEL);
>  	if (!fc)
>  		return ERR_PTR(-ENOMEM);
>  
> +	if (!fs_type->init_fs_context) {
> +		fc->fs_private = kzalloc(sizeof(struct legacy_fs_context),
> +					 GFP_KERNEL);
> +		if (!fc->fs_private)
> +			goto err_fc;
> +
> +		fc->ops = &legacy_fs_context_ops;
> +	}
> +

Why isn't this done in the same place that ->init_fs_context() would otherwise
be called?  It logically does the same thing, right?

>  	fc->purpose	= purpose;
>  	fc->sb_flags	= sb_flags;
>  	fc->fs_type	= get_filesystem(fs_type);
> @@ -277,8 +285,6 @@ struct fs_context *vfs_new_fs_context(struct file_system_type *fs_type,
>  		ret = fc->fs_type->init_fs_context(fc, reference);
>  		if (ret < 0)
>  			goto err_fc;
> -	} else {
> -		fc->ops = &legacy_fs_context_ops;
>  	}
>  
>  	/* Do the security check last because ->init_fs_context may change the
> @@ -395,7 +401,7 @@ EXPORT_SYMBOL(put_fs_context);
>   */
>  static void legacy_fs_context_free(struct fs_context *fc)
>  {
> -	struct legacy_fs_context *ctx = container_of(fc, struct legacy_fs_context, fc);
> +	struct legacy_fs_context *ctx = fc->fs_private;
>  
>  	free_secdata(ctx->secdata);
>  	switch (ctx->param_type) {
> @@ -408,6 +414,8 @@ static void legacy_fs_context_free(struct fs_context *fc)
>  		kfree(ctx->legacy_data);
>  		break;
>  	}
> +
> +	kfree(ctx);
>  }

Okay, but now there's a NULL pointer dereference because fc->ops->free() can be
called with NULL fc->fs_private.  Probably fc->ops->free() shouldn't be called
in that case.

int main()
{
        int fd = syscall(__NR_fsopen, "tmpfs", 0);
        write(fd, "x create", 8);
        syscall(__NR_fsmount, fd, 0, 0);
}

BUG: unable to handle kernel NULL pointer dereference at 0000000000000018
PGD 0 P4D 0 
Oops: 0000 [#1] SMP
CPU: 1 PID: 186 Comm: fsopen Not tainted 4.18.0-rc1-00001-g0f067bdbfeca0 #29
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-20171110_100015-anatol 04/01/2014
RIP: 0010:legacy_fs_context_free+0xc/0x40 fs/fs_context.c:500
Code: 02 75 08 48 c7 42 08 01 00 00 00 31 c0 c3 c7 42 18 01 00 00 00 31 c0 c3 66 0f 1f 44 00 00 55 48 89 e5 53 48 8b 9f 90 00 00 00 <8b> 4b 18 83 f9 04 77 0c b8 01 00 00 00 48 d3 e0 a8 13 75 08 48 8b 
RSP: 0018:ffffc9000079bd88 EFLAGS: 00010282
RAX: ffffffff8118fbe0 RBX: 0000000000000000 RCX: 0000000000000001
RDX: ffff88007c82c0f4 RSI: 0000000000000001 RDI: ffff88007be77700
RBP: ffffc9000079bd90 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88007c82c000
R13: 0000000000060003 R14: ffff88007d34d020 R15: ffff88007ab8aea8
FS:  00007fee62b79740(0000) GS:ffff88007fc80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000018 CR3: 0000000001c0f000 CR4: 00000000003406e0
Call Trace:
 put_fs_context+0x4c/0x180 fs/fs_context.c:479
 fscontext_release+0x20/0x30 fs/fsopen.c:196
 __fput+0xbb/0x210 fs/file_table.c:210
 ____fput+0x9/0x10 fs/file_table.c:246
 task_work_run+0x86/0xc0 kernel/task_work.c:113
 exit_task_work include/linux/task_work.h:22 [inline]
 do_exit+0x27a/0xa30 kernel/exit.c:865
 do_group_exit+0x3c/0xc0 kernel/exit.c:968
 __do_sys_exit_group kernel/exit.c:979 [inline]
 __se_sys_exit_group kernel/exit.c:977 [inline]
 __x64_sys_exit_group+0x13/0x20 kernel/exit.c:977
 do_syscall_64+0x4a/0x180 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7fee6224eee8
Code: Bad RIP value.
RSP: 002b:00007ffc3efc0cd8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fee6224eee8
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 00007fee625386d8 R08: 00000000000000e7 R09: ffffffffffffff80
R10: 00007fee62745100 R11: 0000000000000246 R12: 00007fee625386d8
R13: 00007fee6253dbe0 R14: 0000000000000000 R15: 0000000000000000
CR2: 0000000000000018
---[ end trace 8ac26865cb821d07 ]---
