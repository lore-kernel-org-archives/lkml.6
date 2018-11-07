Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCC2C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 362F82085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="cKLFBNoZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 362F82085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbeKGXbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 18:31:02 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:46589 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbeKGXbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 18:31:02 -0500
Received: by mail-io1-f66.google.com with SMTP id y22-v6so11904217ioj.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 06:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CwCH3raObH2S1rhqUVX/A2JT7LcCOiz2vy4oIzv/N+s=;
        b=cKLFBNoZSmQdOrnNmQk+bp9iKVO/PnjKgU9YVfm4L1lfO215CNYlaQMJ6ebStqPxIe
         j3dPvwYOcwdnQyaeI80ZPIWGwVarHn//R04UwYZAZ8AJbT6nwVk6SeqEaNcSyPX9U95a
         ofMXO08dIucMMQeoNMxPrS5Rj7tgufAjki1d8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CwCH3raObH2S1rhqUVX/A2JT7LcCOiz2vy4oIzv/N+s=;
        b=K3XSRq0dxl+v/OGbSGOf8MlsncDbPwHllhw4z3TY35kuzECqvZS0XWBxKFg6QJyMRM
         luf3oDfyLTdaG/LSbTmCkEYJFcZq6Kkg2XcBzyz2ctJ5CQ/h7auScWByKOAtYm03I78Y
         vAfzXEDmnM8DJoMJvDEqKBSEGfZQC8GM3uSo0A9TgLaENtAEOJ+bkKvRuGwEf8uNs6ke
         F6kkRVAsEtyPuxUq2zmrawUst8X7yxjgm+yN54LC9PO/S1+DTgd64Vw+SO2xcQZ70UiC
         rFvkzcazttwfE6zYcQ/HwevlHYcMnwq1nbjIw4T00cGSKqZN8AuDzpeMGBfuh3LCVewB
         IHvg==
X-Gm-Message-State: AGRZ1gIYFCZjAdhzHWGcJnS9loXROfmDYTRzUTobxtlV9V2Na5WeWCIC
        tqfu5IoqO7GwfSrpPCZBcF+nXarBbB0h6c/TBpWtAMy4
X-Google-Smtp-Source: AJdET5fEoO2XthhkRE1Ai3xRbiT4pp6unZuL6ulmC2U4ZFBCO9d4OmJmnZ+OsRBS2x8W+9cWney7jr7dB4PbrbF1MO4=
X-Received: by 2002:a5e:8b42:: with SMTP id z2-v6mr236163iom.144.1541599231607;
 Wed, 07 Nov 2018 06:00:31 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:ac42:0:0:0:0:0 with HTTP; Wed, 7 Nov 2018 06:00:30 -0800 (PST)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <154149742122.18189.7228444587279544540.stgit@localhost.localdomain>
References: <154149673368.18189.14752124997476502777.stgit@localhost.localdomain>
 <154149742122.18189.7228444587279544540.stgit@localhost.localdomain>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 7 Nov 2018 15:00:30 +0100
Message-ID: <CAJfpegsJzRPB0vYJehh4wb6TPai9Bit7=dveTv0ha9eg0UMPDw@mail.gmail.com>
Subject: Re: [PATCH 1/6] fuse: Change argument of fuse_flush_writepages()
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 10:43 AM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> Next patches introduce fuse_inode::lock, which will be used
> in __releases() and __acquires() instead of fc->lock.
> This patch makes this function to use argument fuse_inode
> instead of inode as preparation for that.

This patch seems like perfectly useless, just change fc->lock to
fi->lock in the next patch and be done with that.


>
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  fs/fuse/dir.c    |    2 +-
>  fs/fuse/file.c   |    8 ++++----
>  fs/fuse/fuse_i.h |    2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 47395b0c3b35..c71f7e9ee0f7 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -1360,7 +1360,7 @@ static void __fuse_release_nowrite(struct inode *inode)
>
>         BUG_ON(fi->writectr != FUSE_NOWRITE);
>         fi->writectr = 0;
> -       fuse_flush_writepages(inode);
> +       fuse_flush_writepages(fi);
>  }
>
>  void fuse_release_nowrite(struct inode *inode)
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index cc2121b37bf5..d5bd29610875 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1522,12 +1522,12 @@ __acquires(fc->lock)
>   *
>   * Called with fc->lock
>   */
> -void fuse_flush_writepages(struct inode *inode)
> +void fuse_flush_writepages(struct fuse_inode *fi)
>  __releases(fc->lock)
>  __acquires(fc->lock)
>  {
> +       struct inode *inode = &fi->inode;
>         struct fuse_conn *fc = get_fuse_conn(inode);
> -       struct fuse_inode *fi = get_fuse_inode(inode);
>         size_t crop = i_size_read(inode);
>         struct fuse_req *req;
>
> @@ -1670,7 +1670,7 @@ static int fuse_writepage_locked(struct page *page)
>         spin_lock(&fc->lock);
>         list_add(&req->writepages_entry, &fi->writepages);
>         list_add_tail(&req->list, &fi->queued_writes);
> -       fuse_flush_writepages(inode);
> +       fuse_flush_writepages(fi);
>         spin_unlock(&fc->lock);
>
>         end_page_writeback(page);
> @@ -1728,7 +1728,7 @@ static void fuse_writepages_send(struct fuse_fill_wb_data *data)
>         req->ff = fuse_file_get(data->ff);
>         spin_lock(&fc->lock);
>         list_add_tail(&req->list, &fi->queued_writes);
> -       fuse_flush_writepages(inode);
> +       fuse_flush_writepages(fi);
>         spin_unlock(&fc->lock);
>
>         for (i = 0; i < num_pages; i++)
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index e9f712e81c7d..38bd7ca1908a 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -995,7 +995,7 @@ void fuse_update_ctime(struct inode *inode);
>
>  int fuse_update_attributes(struct inode *inode, struct file *file);
>
> -void fuse_flush_writepages(struct inode *inode);
> +void fuse_flush_writepages(struct fuse_inode *fi);
>
>  void fuse_set_nowrite(struct inode *inode);
>  void fuse_release_nowrite(struct inode *inode);
>
