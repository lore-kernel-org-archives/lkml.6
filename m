Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D75C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B49B21848
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="B+HgC0MV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbfBSJYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:24:15 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43309 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbfBSJYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:24:15 -0500
Received: by mail-ed1-f67.google.com with SMTP id m35so12126261ede.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 01:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lJU/fJXNcb/Zph8+8eeZOOhDAUkdJM37dCiIWrHqNbs=;
        b=B+HgC0MVDTvCT/NqjS8YMR+9xBPkNNDxCwzG2QVyBNPe70TtHKhfbKJn99ZCLWIZfI
         lLl6anIPMiZtg4gVnbP60fWjy0FQ6fXeam/hPS5d6u3ZYm5/ytBkLVgxQsCKJdLnLyJY
         o/FqzJRt3NwTzuHFJ6kbipxzzR/lZV0m3XTMr0k0Hp9QQ6TUb/0w5Yj3pxPDrM/2RkVH
         hV01KnQeHIMh2PAZu01hDGPUIuqv6ie9QrFIlFr5FuamqkTNEa76Z0JKxc95a+K/weOg
         +Y8rJEPRUjdTVoMPJMEKaLI7lXici9EzQkwJF5VwIpIxupqbuYMxmvXNpzko759CGzbS
         qDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lJU/fJXNcb/Zph8+8eeZOOhDAUkdJM37dCiIWrHqNbs=;
        b=PmUl4itaw6JzIW/CMAyh0wFYlb4m/H5LymbUD/qeo1T1op68f8eP7jrjtSFH1rAQft
         P9auLUxk4iMUlTz+dSHEan8tunpOSTXNoPMWtDpL2OuKcpu2MUpNeyPMsk7T5M+K5zT8
         8+9g/pCimPEt0B44SBaGJQVvnw6UB0Sn9zuUZCVM26rpWdoZuZlNRgSjhkFqierXZlMu
         CWPJKC5a2hGLYejxQoCvgvevmdW3ERNBh1UJBbHGLqi96EPIli4vHcN6Fw0/8P1ftPUF
         axewqictfhtA0/bSwwA+P/gHzEzHfCX81+XPIXG1eY6tBP9ngcGkWI6kCScZvGAtWPG8
         DbrQ==
X-Gm-Message-State: AHQUAuYI0KwRvEcGVaGvhRFPxtM2dZ6ik/k1dKdsKh+cJjD+wLDwX/hy
        ipeuTAh4/nQy8i7EFcsnuSLyFR8VMJmK/A==
X-Google-Smtp-Source: AHgI3Ia1UoKS989OSrFIG351jKZ3mwF+ThQzb9n/Ewt83O2um3yChrOnbXRIU4oBdL07x9Y7Ul257A==
X-Received: by 2002:a17:906:49c7:: with SMTP id w7mr4998399ejv.226.1550568252875;
        Tue, 19 Feb 2019 01:24:12 -0800 (PST)
Received: from brauner.io ([2a02:8109:b6c0:76e:98b0:e7d6:f97c:a75f])
        by smtp.gmail.com with ESMTPSA id b46sm4833068edd.94.2019.02.19.01.24.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 19 Feb 2019 01:24:12 -0800 (PST)
Date:   Tue, 19 Feb 2019 10:24:11 +0100
From:   Christian Brauner <christian@brauner.io>
To:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, ebiederm@xmission.com,
        ebiggers@google.com, willy@infradead.org, dhowells@redhat.com
Subject: Re: [PATCH 1/2] devpts: remove unneeded inode_lock in mknod_ptmx
Message-ID: <20190219092410.ottcfwsgt7734vx7@brauner.io>
References: <20190128171133.539-1-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190128171133.539-1-christian@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 06:11:32PM +0100, Christian Brauner wrote:
> Afaict, the mknod_ptmx() call is a no-op on subsequent calls and the first
> call is done before we unlock the suberblock. If I'm not mistaken this is
> exactly parallel to what Al pointed out for binderfs 29ef1c8e16a
> ("binderfs: drop lock in binderfs_binder_ctl_create"). In both filesystems
> it should not be necessary to take inode_lock() in there. Let's remove it
> and remove the goto.
> 
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Christian Brauner <christian@brauner.io>

Since the merge window is coming up: are you fine with this patch, Al?

Christian

> ---
>  fs/devpts/inode.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
> index c53814539070..8fa1492f9712 100644
> --- a/fs/devpts/inode.c
> +++ b/fs/devpts/inode.c
> @@ -325,7 +325,6 @@ static int parse_mount_options(char *data, int op, struct pts_mount_opts *opts)
>  static int mknod_ptmx(struct super_block *sb)
>  {
>  	int mode;
> -	int rc = -ENOMEM;
>  	struct dentry *dentry;
>  	struct inode *inode;
>  	struct dentry *root = sb->s_root;
> @@ -334,18 +333,14 @@ static int mknod_ptmx(struct super_block *sb)
>  	kuid_t ptmx_uid = current_fsuid();
>  	kgid_t ptmx_gid = current_fsgid();
>  
> -	inode_lock(d_inode(root));
> -
>  	/* If we have already created ptmx node, return */
> -	if (fsi->ptmx_dentry) {
> -		rc = 0;
> -		goto out;
> -	}
> +	if (fsi->ptmx_dentry)
> +		return 0;
>  
>  	dentry = d_alloc_name(root, "ptmx");
>  	if (!dentry) {
>  		pr_err("Unable to alloc dentry for ptmx node\n");
> -		goto out;
> +		return -ENOMEM;
>  	}
>  
>  	/*
> @@ -355,7 +350,7 @@ static int mknod_ptmx(struct super_block *sb)
>  	if (!inode) {
>  		pr_err("Unable to alloc inode for ptmx node\n");
>  		dput(dentry);
> -		goto out;
> +		return -ENOMEM;
>  	}
>  
>  	inode->i_ino = 2;
> @@ -369,10 +364,8 @@ static int mknod_ptmx(struct super_block *sb)
>  	d_add(dentry, inode);
>  
>  	fsi->ptmx_dentry = dentry;
> -	rc = 0;
> -out:
> -	inode_unlock(d_inode(root));
> -	return rc;
> +
> +	return 0;
>  }
>  
>  static void update_ptmx_mode(struct pts_fs_info *fsi)
> -- 
> 2.20.1
> 
