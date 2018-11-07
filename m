Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A37AC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23DC420827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="hWIZfDVZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23DC420827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbeKGXmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 18:42:49 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:40430 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbeKGXmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 18:42:49 -0500
Received: by mail-it1-f194.google.com with SMTP id e11so19562492itl.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 06:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TZGnFEmQgoGsHsuz6vt5dn/fNUdlCN38NGGqmcyYGNI=;
        b=hWIZfDVZq4sKtKt18Xd4PXWr88elFVcTyxXJWNzQUlUltnSnxK0uKTZYsKJAM9u1a4
         w6fsLzCyS9CYCK6AXZ+HOqjMmTsYFAso0QT1GCv36/lLuBJBYXw+Jase1OQgKbIxRm9O
         PGClADHhTgZvRiHeo7o/F+nKE77k1R67LE+C4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TZGnFEmQgoGsHsuz6vt5dn/fNUdlCN38NGGqmcyYGNI=;
        b=HgZYqXpTcYTD0tfmTdaSFoy8gcA63xdOJTN4suhMK8tmdQ5+Q/aKuofBSZ8QGHYA7W
         C+wXLKo2mQD3nk7K0I0AsSAhbkjqkyvgZ+eWFZ9v6+mgV7PUHyJDhPd+oNz5xytlmXDC
         sfOA6AAu30wTKgqmpY6DGaM9oqf/9NR9abcpgiU4ZIeFvZVIsGF3O3jMGxVqtJ+NBtEr
         YdZ4k7nbCnIXApoxfmWb7QP5C8u3AgS177yWfIHbuqn1a7x8oiD6FPZFnaedUHb9dHp9
         1h1PqOfh9Ehk5C+nF1Q7250qBAMTVQOFLuJKs1dudXOVkzduidaNPLtsoeBnRiI+og86
         AfZQ==
X-Gm-Message-State: AGRZ1gK1Eqeqt/64zUFcXUHv2NfVwUCAi4dVoW1zui5XPq9Yx6dmxnje
        h3IHe+i5yZEMGqbfC8tFCmpM82vS5fUOVDFstNfclQ==
X-Google-Smtp-Source: AJdET5eLkPzRBURur8NL8Ze8iUPn9sTECaxZnCszTqdlbtN+nvaML8cZ3yEJ+HOR30r71zXqbzhTbB0ARsKjC9fSYhY=
X-Received: by 2002:a24:fe88:: with SMTP id w130-v6mr291140ith.69.1541599936200;
 Wed, 07 Nov 2018 06:12:16 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:ac42:0:0:0:0:0 with HTTP; Wed, 7 Nov 2018 06:12:15 -0800 (PST)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <154149743811.18189.2448546280541143340.stgit@localhost.localdomain>
References: <154149673368.18189.14752124997476502777.stgit@localhost.localdomain>
 <154149743811.18189.2448546280541143340.stgit@localhost.localdomain>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 7 Nov 2018 15:12:15 +0100
Message-ID: <CAJfpegspUywVumOs-HcJVdm7CiGAHeNGfn4Kqg0dLup_5ufi8Q@mail.gmail.com>
Subject: Re: [PATCH 4/6] fuse: Implement fuse_attr_version_inc()
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 10:43 AM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> For cleanup purpose archive repeating pattern:
>
>         spin_lock(&fc->lock);
>         fi->attr_version = ++fc->attr_version;
>         spin_unlock(&fc->lock);
>
> into separate function.
>
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  fs/fuse/dir.c    |    8 ++------
>  fs/fuse/file.c   |   16 ++++------------
>  fs/fuse/fuse_i.h |   11 +++++++++++
>  fs/fuse/inode.c  |    4 +---
>  4 files changed, 18 insertions(+), 21 deletions(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 794b9f48fb8e..35f3b3d1e044 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -674,9 +674,7 @@ static int fuse_unlink(struct inode *dir, struct dentry *entry)
>                 struct fuse_inode *fi = get_fuse_inode(inode);
>
>                 spin_lock(&fi->lock);
> -               spin_lock(&fc->lock);
> -               fi->attr_version = ++fc->attr_version;
> -               spin_unlock(&fc->lock);
> +               fi->attr_version = fuse_attr_version_inc_return(fc);
>                 /*
>                  * If i_nlink == 0 then unlink doesn't make sense, yet this can
>                  * happen if userspace filesystem is careless.  It would be
> @@ -830,9 +828,7 @@ static int fuse_link(struct dentry *entry, struct inode *newdir,
>                 struct fuse_inode *fi = get_fuse_inode(inode);
>
>                 spin_lock(&fi->lock);
> -               spin_lock(&fc->lock);
> -               fi->attr_version = ++fc->attr_version;
> -               spin_unlock(&fc->lock);
> +               fi->attr_version = fuse_attr_version_inc_return(fc);
>                 inc_nlink(inode);
>                 spin_unlock(&fi->lock);
>                 fuse_invalidate_attr(inode);
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 48e2889ba6a6..1164d3580c62 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -186,9 +186,7 @@ void fuse_finish_open(struct inode *inode, struct file *file)
>                 struct fuse_inode *fi = get_fuse_inode(inode);
>
>                 spin_lock(&fi->lock);
> -               spin_lock(&fc->lock);
> -               fi->attr_version = ++fc->attr_version;
> -               spin_unlock(&fc->lock);
> +               fi->attr_version = fuse_attr_version_inc_return(fc);
>                 i_size_write(inode, 0);
>                 spin_unlock(&fi->lock);
>                 fuse_invalidate_attr(inode);
> @@ -604,9 +602,7 @@ static void fuse_aio_complete(struct fuse_io_priv *io, int err, ssize_t pos)
>                         struct fuse_inode *fi = get_fuse_inode(inode);
>
>                         spin_lock(&fi->lock);
> -                       spin_lock(&fc->lock);
> -                       fi->attr_version = ++fc->attr_version;
> -                       spin_unlock(&fc->lock);
> +                       fi->attr_version = fuse_attr_version_inc_return(fc);
>                         spin_unlock(&fi->lock);
>                 }
>
> @@ -685,9 +681,7 @@ static void fuse_read_update_size(struct inode *inode, loff_t size,
>         spin_lock(&fi->lock);
>         if (attr_ver == fi->attr_version && size < inode->i_size &&
>             !test_bit(FUSE_I_SIZE_UNSTABLE, &fi->state)) {
> -               spin_lock(&fc->lock);
> -               fi->attr_version = ++fc->attr_version;
> -               spin_unlock(&fc->lock);
> +               fi->attr_version = fuse_attr_version_inc_return(fc);
>                 i_size_write(inode, size);
>         }
>         spin_unlock(&fi->lock);
> @@ -1006,9 +1000,7 @@ bool fuse_write_update_size(struct inode *inode, loff_t pos)
>         bool ret = false;
>
>         spin_lock(&fi->lock);
> -       spin_lock(&fc->lock);
> -       fi->attr_version = ++fc->attr_version;
> -       spin_unlock(&fc->lock);
> +       fi->attr_version = fuse_attr_version_inc_return(fc);
>         if (pos > inode->i_size) {
>                 i_size_write(inode, pos);
>                 ret = true;
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 075da40499b8..f7442bcecbb0 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -775,6 +775,17 @@ static inline int invalid_nodeid(u64 nodeid)
>         return !nodeid || nodeid == FUSE_ROOT_ID;
>  }
>
> +static inline u64 fuse_attr_version_inc_return(struct fuse_conn *fc)
> +{
> +       u64 attr_version;
> +
> +       spin_lock(&fc->lock);
> +       attr_version = ++fc->attr_version;
> +       spin_unlock(&fc->lock);
> +
> +       return attr_version;
> +}

atomic64_t?

And move this patch one up, 3/6 is complicated as is without having to
add extra locking around fc->attr_version.



> +
>  /** Device operations */
>  extern const struct file_operations fuse_dev_operations;
>
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index f62d45686b42..5f488b019cd9 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -167,9 +167,7 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
>
>         lockdep_assert_held(&fi->lock);
>
> -       spin_lock(&fc->lock);
> -       fi->attr_version = ++fc->attr_version;
> -       spin_unlock(&fc->lock);
> +       fi->attr_version = fuse_attr_version_inc_return(fc);
>
>         fi->i_time = attr_valid;
>         WRITE_ONCE(fi->inval_mask, 0);
>
