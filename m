Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0743ECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29EA921521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="kCKxNXlu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29EA921521
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732381AbeITILs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:11:48 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37707 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbeITILr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:11:47 -0400
Received: by mail-qk1-f195.google.com with SMTP id c13-v6so3989992qkm.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 19:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zAdUMdq2SvVUUOBqjyOgckIpaCcoyxrO+2VQHD4AZCE=;
        b=kCKxNXluZYdKIktG7BO3OtbrzEOjLCjeqMH7gT/U+78iVLC1VOEGHepm3RfJ+7g1++
         kZbXunD5qTbTpv7WlSE+Hk3Ifff9eFABfPz+KgVxbcGGKUr7RtrIwSfOj5i4G4TYSQbR
         VCVHyHNme9zd3sZzeXLfk92YHAMelyRsL7uv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zAdUMdq2SvVUUOBqjyOgckIpaCcoyxrO+2VQHD4AZCE=;
        b=Gq2IGTiYCX97vpcTSiNGWGtEaG3ii9LXKvjAgxnc4GlE1mLD3+kLWglmp6FnZZ0/II
         3UidlzZPiocPpL8k/32QNt7pN9NFDNfb/THF/4jtyX0mYubWIfHptarJBtrPUOOk0M9H
         9ID5V0f59oZvbqUIgPt5UycmKwzOnJ/k0AoIIS5jc9zMKYETF1MVBseRq2ETwvNsjFMM
         T7XNIfDL/TS+10LDDJlP64LCEFrzJOmf7BBHWLqsJwAcBkMCdFgQQbl6399H3oKvS1qv
         L+nb0MU4vWkRcEX9QuOgWq8mX1syvaXz0a6IgiPK/74xy4G0R1MjXdh8ukR3UuPnLq+d
         /0OQ==
X-Gm-Message-State: ABuFfog9KNl4TPZoqpDcqGYMFupvsb3iqvH4ny3Dd9hlMbGZzP3OBd0R
        9HiooEpa2MmT4pIfWgYK7mggiuC5k2AlGF67DSg=
X-Google-Smtp-Source: ANB0VdbCPsJT8ZQxkRPJ9gCarBfFbAm9kAYsezbqcPD2K+1p3xtedmp8o5m5uvjSPGtCCtuSDq0a40kkXXmvaOIAbBo=
X-Received: by 2002:a37:d7c5:: with SMTP id t66-v6mr1733969qkt.336.1537410652558;
 Wed, 19 Sep 2018 19:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180916215735.31393-1-richard@nod.at>
In-Reply-To: <20180916215735.31393-1-richard@nod.at>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 20 Sep 2018 12:00:41 +0930
Message-ID: <CACPK8Xd_fNNEYbtY6HEnB6kOnqTWBC5stPVUbc2gMHpne4J6jQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "ubifs: xattr: Don't operate on deleted inodes"
To:     Richard Weinberger <richard@nod.at>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        koen.vandeputte@ncentric.com, Eddie James <eajames.ibm@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Sep 2018 at 07:30, Richard Weinberger <richard@nod.at> wrote:
>
> This reverts commit 11a6fc3dc743e22fb50f2196ec55bee5140d3c52.
> UBIFS wants to assert that xattr operations are only issued on files
> with positive link count. The said patch made this operations return
> -ENOENT for unlinked files such that the asserts will no longer trigger.
> This was wrong since xattr operations are perfectly fine on unlinked
> files.
> Instead the assertions need to be fixed/removed.
>
> Cc: <stable@vger.kernel.org>
> Fixes: 11a6fc3dc743 ("ubifs: xattr: Don't operate on deleted inodes")
> Reported-by: Koen Vandeputte <koen.vandeputte@ncentric.com>
> Signed-off-by: Richard Weinberger <richard@nod.at>

The bad commit 11a6fc3dc743 was included in 4.18.7, and broke our
systems which use overlayfs on top of ubifs.

This patch didn't apply cleanly for me to 4.18.8 (an encoding issue?),
but I did a revert of the offending commit which did the trick.

Tested-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel


> ---
>  fs/ubifs/xattr.c | 24 ------------------------
>  1 file changed, 24 deletions(-)
>
> diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
> index 61afdfee4b28..f5ad1ede7990 100644
> --- a/fs/ubifs/xattr.c
> +++ b/fs/ubifs/xattr.c
> @@ -152,12 +152,6 @@ static int create_xattr(struct ubifs_info *c, struct inode *host,
>         ui->data_len = size;
>
>         mutex_lock(&host_ui->ui_mutex);
> -
> -       if (!host->i_nlink) {
> -               err = -ENOENT;
> -               goto out_noent;
> -       }
> -
>         host->i_ctime = current_time(host);
>         host_ui->xattr_cnt += 1;
>         host_ui->xattr_size += CALC_DENT_SIZE(fname_len(nm));
> @@ -190,7 +184,6 @@ static int create_xattr(struct ubifs_info *c, struct inode *host,
>         host_ui->xattr_size -= CALC_XATTR_BYTES(size);
>         host_ui->xattr_names -= fname_len(nm);
>         host_ui->flags &= ~UBIFS_CRYPT_FL;
> -out_noent:
>         mutex_unlock(&host_ui->ui_mutex);
>  out_free:
>         make_bad_inode(inode);
> @@ -242,12 +235,6 @@ static int change_xattr(struct ubifs_info *c, struct inode *host,
>         mutex_unlock(&ui->ui_mutex);
>
>         mutex_lock(&host_ui->ui_mutex);
> -
> -       if (!host->i_nlink) {
> -               err = -ENOENT;
> -               goto out_noent;
> -       }
> -
>         host->i_ctime = current_time(host);
>         host_ui->xattr_size -= CALC_XATTR_BYTES(old_size);
>         host_ui->xattr_size += CALC_XATTR_BYTES(size);
> @@ -269,7 +256,6 @@ static int change_xattr(struct ubifs_info *c, struct inode *host,
>  out_cancel:
>         host_ui->xattr_size -= CALC_XATTR_BYTES(size);
>         host_ui->xattr_size += CALC_XATTR_BYTES(old_size);
> -out_noent:
>         mutex_unlock(&host_ui->ui_mutex);
>         make_bad_inode(inode);
>  out_free:
> @@ -496,12 +482,6 @@ static int remove_xattr(struct ubifs_info *c, struct inode *host,
>                 return err;
>
>         mutex_lock(&host_ui->ui_mutex);
> -
> -       if (!host->i_nlink) {
> -               err = -ENOENT;
> -               goto out_noent;
> -       }
> -
>         host->i_ctime = current_time(host);
>         host_ui->xattr_cnt -= 1;
>         host_ui->xattr_size -= CALC_DENT_SIZE(fname_len(nm));
> @@ -521,7 +501,6 @@ static int remove_xattr(struct ubifs_info *c, struct inode *host,
>         host_ui->xattr_size += CALC_DENT_SIZE(fname_len(nm));
>         host_ui->xattr_size += CALC_XATTR_BYTES(ui->data_len);
>         host_ui->xattr_names += fname_len(nm);
> -out_noent:
>         mutex_unlock(&host_ui->ui_mutex);
>         ubifs_release_budget(c, &req);
>         make_bad_inode(inode);
> @@ -561,9 +540,6 @@ static int ubifs_xattr_remove(struct inode *host, const char *name)
>
>         ubifs_assert(c, inode_is_locked(host));
>
> -       if (!host->i_nlink)
> -               return -ENOENT;
> -
>         if (fname_len(&nm) > UBIFS_MAX_NLEN)
>                 return -ENAMETOOLONG;
>
> --
> 2.19.0
>
