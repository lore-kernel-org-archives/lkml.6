Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D64C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C498620827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="aMhK7rLB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C498620827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbeKGXvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 18:51:18 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:33064 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbeKGXvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 18:51:18 -0500
Received: by mail-it1-f195.google.com with SMTP id p11-v6so13189932itf.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 06:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UysIRM1+s3ufQpuvCORn3iMWOhSABN5WwdkCPVKKkrY=;
        b=aMhK7rLBmfZ/wBM+cXqOSVSveFoxRbs7Rji6eFqpzdO2yXFXS+raKYT0jo+GCj6wFU
         9x4LAg8Q9q2LWadfey0wwexjLssNSVBJxAlWssdI/s42JphIHGOhu2282MdkHGMZKzrV
         7x7DysAfavS3uge2xbx75VEcIREcMkUm2/HQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UysIRM1+s3ufQpuvCORn3iMWOhSABN5WwdkCPVKKkrY=;
        b=mfs+VDN2fI/u8alyUt2PjmOpLMwzmG+LUJ/hiQDPzAooIojUmIfPcdReLZ1QOdTW/s
         4XNd+H6ldOc7BbKVSEAIk8wSgzIS3f6jhqzk1Vhd77BbpJ5vti/oGhQuN+OhOHwvLYFZ
         6izAq8typSGkf9buEVozxcq3mwioqjh1zFohk8dY6q69BiKZ0ERnzAmtL73lt27bXSMe
         KRurY/ahs5w+SLEsj9nI+ATSMmW/LOovNuSKxRDcAonvRjROSYU8xrBIyEMAn5uwbivI
         07+HHkD8pyfNvhy7ermd3Vq4HoI1AaSPz0OlVaf80fenjRVkocK+jSO6jYfv4u5v20Vw
         Ik1A==
X-Gm-Message-State: AGRZ1gIhgaKG2CDJgxZe34JK485aSzOaJbQjuPYvO5H/SbBYbPic7AOT
        +xgDxZJDZ38zJWGlMso5WnRybJQ39OmJpATX79xpnIyO
X-Google-Smtp-Source: AJdET5d7eJac1CQi3pw4yoNqfhuA1d9sqXeDPkCSbMzul1lZMkF8sPKs7u62fgNrEjjoTlzJrv/2nI15K0VTLMZi4dk=
X-Received: by 2002:a24:fe88:: with SMTP id w130-v6mr320641ith.69.1541600443235;
 Wed, 07 Nov 2018 06:20:43 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:ac42:0:0:0:0:0 with HTTP; Wed, 7 Nov 2018 06:20:42 -0800 (PST)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <154149744356.18189.13444618369955494886.stgit@localhost.localdomain>
References: <154149673368.18189.14752124997476502777.stgit@localhost.localdomain>
 <154149744356.18189.13444618369955494886.stgit@localhost.localdomain>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 7 Nov 2018 15:20:42 +0100
Message-ID: <CAJfpegtnCTY_eWsyNPRPaE0=wPeyMPAXScWQ4scV7vXXcWyamA@mail.gmail.com>
Subject: Re: [PATCH 5/6] fuse: Protect fuse_inode::nlookup with fuse_inode::lock
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 10:44 AM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> This continues previous patch and introduces the same
> protection for nlookup field. It goes as separate patch
> since it's separate logic change (sadly, but it looks
> impossible to split previous patch more then in this way).

Well, the way you can split things up better is to just add the fine
grained lock first, which you can do in multiple patches, since all of
it is going to be a no-op.  And when that is done, remove the coarse
grained lock in yet another patch, which hopefully will result in
better performance and no other change.

>
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  fs/fuse/dir.c     |    4 ++--
>  fs/fuse/inode.c   |    4 ++--
>  fs/fuse/readdir.c |    4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 35f3b3d1e044..ac8519285327 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -222,9 +222,9 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
>                                 fuse_queue_forget(fc, forget, outarg.nodeid, 1);
>                                 goto invalid;
>                         }
> -                       spin_lock(&fc->lock);
> +                       spin_lock(&fi->lock);
>                         fi->nlookup++;
> -                       spin_unlock(&fc->lock);
> +                       spin_unlock(&fi->lock);
>                 }
>                 kfree(forget);
>                 if (ret == -ENOMEM)
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 5f488b019cd9..b8092d49a4b2 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -327,9 +327,9 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
>         }
>
>         fi = get_fuse_inode(inode);
> -       spin_lock(&fc->lock);
> +       spin_lock(&fi->lock);
>         fi->nlookup++;
> -       spin_unlock(&fc->lock);
> +       spin_unlock(&fi->lock);
>         fuse_change_attributes(inode, attr, attr_valid, attr_version);
>
>         return inode;
> diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
> index ab18b78f4755..574d03f8a573 100644
> --- a/fs/fuse/readdir.c
> +++ b/fs/fuse/readdir.c
> @@ -213,9 +213,9 @@ static int fuse_direntplus_link(struct file *file,
>                 }
>
>                 fi = get_fuse_inode(inode);
> -               spin_lock(&fc->lock);
> +               spin_lock(&fi->lock);
>                 fi->nlookup++;
> -               spin_unlock(&fc->lock);
> +               spin_unlock(&fi->lock);
>
>                 forget_all_cached_acls(inode);
>                 fuse_change_attributes(inode, &o->attr,
>
