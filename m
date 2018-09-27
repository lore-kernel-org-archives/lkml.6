Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB960C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861FE216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="nQC0llW3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 861FE216FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbeI0URV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:17:21 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45476 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbeI0URU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:17:20 -0400
Received: by mail-io1-f65.google.com with SMTP id e12-v6so1976969iok.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 06:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gvpP0lbBoycAsX+Pfl/y1ATalMn2lcO+jpRaS6p3u+A=;
        b=nQC0llW3yeNprNQPhdObv+8RUx0BE8yaTRAT+rCh19EeQJr8PUahDaeqd1UigJNBHM
         2RNKM2LU0PgS5XcLPeYbS+xAqnA2+PBZRHT1AEQNM3rLsD1l3btuVimbkGy+MQ0h/gvy
         dJdYn1BRDjHzL/TBg8K0aY7ZGkpyyWiRYLPTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gvpP0lbBoycAsX+Pfl/y1ATalMn2lcO+jpRaS6p3u+A=;
        b=QerWZeKWX3lRsf8DxTOFbPSpuocZQRINIuxm9MtbaGnsTsKcV0+Md9J6DR3YDkUdHq
         2i/mGHaIoZLWgx6JjCZmd9oY+QXkpdM8Bxqw6JqTTtRzQDLEZAE17spnxj/Oi7fl+7t9
         s8sV1E2N7cDSDDfqtfz5NqGSUl5WEtO+lD/pTSzgSgohlToFQrSb9oNfTZ6xh14ZqvQc
         L227gktLz+3FHzQCccFmVK44efBuL4GCqb0Cu4H/qJWB9HnuAd9LxwMYsrdeplGKakPn
         ziUDgPXQc9dZ4cPqQYMWc/i5Zg8Bsq5qgGEZMXZC5LRN/59Yvi8OwzBaF1XRYblz4iD2
         OTbQ==
X-Gm-Message-State: ABuFfoiwpcsiGYfQj5XxdoekJH2yFzkrm0aabn35GcgRC3lDSfFYIpBR
        5kiwtzrQq+DywF7+jKQMs+hTtXNIv0eS41JftX+F2A==
X-Google-Smtp-Source: ACcGV60i3gALTQoxHbo45hjLIHWtYbTrwqr/QLZx5xUbeYSKAoWITpC4/+uItBKIE+M6fcUGtyiR6nqs8FTntpaOLYA=
X-Received: by 2002:a6b:acc4:: with SMTP id v187-v6mr8855692ioe.246.1538056736208;
 Thu, 27 Sep 2018 06:58:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bf41:0:0:0:0:0 with HTTP; Thu, 27 Sep 2018 06:58:55
 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <20180927135211.31641-1-dschatzberg@fb.com>
References: <20180927135211.31641-1-dschatzberg@fb.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 27 Sep 2018 15:58:55 +0200
Message-ID: <CAJfpegsRNv3Uby2w-B0+d4fE8ecSRkT0ef2AfQ_QnnEVT-nkmA@mail.gmail.com>
Subject: Re: [PATCH] fuse: enable caching of symlinks
To:     Dan Schatzberg <dschatzberg@fb.com>
Cc:     Tejun Heo <tj@kernel.org>, kernel-team <kernel-team@fb.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 3:52 PM, Dan Schatzberg <dschatzberg@fb.com> wrote:
> FUSE file reads are cached in the page cache, but symlink reads are
> not. This patch enables FUSE READLINK operations to be cached which
> can improve performance of some FUSE workloads.
>
> In particular, I'm working on a FUSE filesystem for access to source
> code and discovered that about a 10% improvement to build times is
> achieved with this patch (there are a lot of symlinks in the source
> tree).
>
> Please provide feedback, I'm looking to flesh this out more.

Need to think about how/when to invalidate the cached symlink
contents.  I think treating it like metadata (i.e. look at
attr_timeout for validity) would be the simplest.

Thanks,
Miklos

>
> Signed-off-by: Dan Schatzberg <dschatzberg@fb.com>
> ---
>  fs/fuse/dir.c | 70 +++++++++++++++++++++++++++++++--------------------
>  1 file changed, 43 insertions(+), 27 deletions(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 0979609d6eba..3c0a81ef5bca 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -1398,38 +1398,46 @@ static int fuse_readdir(struct file *file, struct dir_context *ctx)
>         return err;
>  }
>
> -static const char *fuse_get_link(struct dentry *dentry,
> -                                struct inode *inode,
> -                                struct delayed_call *done)
> +static int fuse_symlink_readpage(struct file *file, struct page *page)
>  {
> +       struct inode *inode = page->mapping->host;
>         struct fuse_conn *fc = get_fuse_conn(inode);
> -       FUSE_ARGS(args);
> -       char *link;
> -       ssize_t ret;
> -
> -       if (!dentry)
> -               return ERR_PTR(-ECHILD);
> +       struct fuse_req *req;
> +       int err;
> +       size_t num_read;
>
> -       link = kmalloc(PAGE_SIZE, GFP_KERNEL);
> -       if (!link)
> -               return ERR_PTR(-ENOMEM);
> +       err = -EIO;
> +       if (is_bad_inode(inode))
> +               goto out;
>
> -       args.in.h.opcode = FUSE_READLINK;
> -       args.in.h.nodeid = get_node_id(inode);
> -       args.out.argvar = 1;
> -       args.out.numargs = 1;
> -       args.out.args[0].size = PAGE_SIZE - 1;
> -       args.out.args[0].value = link;
> -       ret = fuse_simple_request(fc, &args);
> -       if (ret < 0) {
> -               kfree(link);
> -               link = ERR_PTR(ret);
> -       } else {
> -               link[ret] = '\0';
> -               set_delayed_call(done, kfree_link, link);
> +       req = fuse_get_req(fc, 1);
> +       if (IS_ERR(req)) {
> +               err = PTR_ERR(req);
> +               goto out;
>         }
> +
> +       req->out.page_zeroing = 1;
> +       req->out.argpages = 1;
> +       req->num_pages = 1;
> +       req->pages[0] = page;
> +       req->page_descs[0].length = PAGE_SIZE - 1;
> +       req->in.h.opcode = FUSE_READLINK;
> +       req->in.h.nodeid = get_node_id(inode);
> +       req->out.argvar = 1;
> +       req->out.numargs = 1;
> +       req->out.args[0].size = PAGE_SIZE - 1;
> +       fuse_request_send(fc, req);
> +       num_read = req->out.args[0].size;
> +       err = req->out.h.error;
> +
> +       if (!err)
> +               SetPageUptodate(page);
> +
> +       fuse_put_request(fc, req);
>         fuse_invalidate_atime(inode);
> -       return link;
> +out:
> +       unlock_page(page);
> +       return err;
>  }
>
>  static int fuse_dir_open(struct inode *inode, struct file *file)
> @@ -1855,7 +1863,7 @@ static const struct inode_operations fuse_common_inode_operations = {
>
>  static const struct inode_operations fuse_symlink_inode_operations = {
>         .setattr        = fuse_setattr,
> -       .get_link       = fuse_get_link,
> +       .get_link       = page_get_link,
>         .getattr        = fuse_getattr,
>         .listxattr      = fuse_listxattr,
>  };
> @@ -1871,7 +1879,15 @@ void fuse_init_dir(struct inode *inode)
>         inode->i_fop = &fuse_dir_operations;
>  }
>
> +static const struct address_space_operations fuse_symlink_aops = {
> +       .readpage       = fuse_symlink_readpage,
> +};
> +
>  void fuse_init_symlink(struct inode *inode)
>  {
>         inode->i_op = &fuse_symlink_inode_operations;
> +       inode->i_data.a_ops = &fuse_symlink_aops;
> +       mapping_set_gfp_mask(inode->i_mapping,
> +                       mapping_gfp_constraint(inode->i_mapping,
> +                                       ~(__GFP_FS | __GFP_HIGHMEM)));
>  }
> --
> 2.17.1
>
