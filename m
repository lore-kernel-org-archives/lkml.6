Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE5CC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A04E24A5D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A04E24A5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753192AbeGBRwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 13:52:44 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:40509 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752728AbeGBRwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 13:52:42 -0400
Received: by mail-it0-f66.google.com with SMTP id 188-v6so13083311ita.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 10:52:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yOlBoc0ZpzuUaB545V9h0qZmwcxepsk02o/wZ9V2z0o=;
        b=AfOmmgm76iptRmMGSyH7RjaF9eCsCIdxJEpTvZDH4mWQTe7C6soQofLzU6f7GXrBGR
         V64uVs298o6ukWEUOk2KBCcTSaHXMA++TcRy+GDRjgJWJYL0Nsj0K7FO2zIiiOrJ30Sb
         p+ywQhYlOVsLlwcnr6uryAPhT+t3T2Bn2JpcqqwzISq5T4L2QTSvGQeksL/dTw9NwUrO
         Tvl60Rt5yWWInmWoailRFFbqWzKCneMYwcUHmoL1VN0FIKrJcWyTGykvyUghce5GpBi4
         UulNmwVoqaSBcW7+bvW6Hab4vAQHgJVXmBGOEWyMvDR8lW4FXM6iqdU6wrK+RI97L9G/
         j+jQ==
X-Gm-Message-State: APt69E3Mz+kCOQUSqKqM6C0yGLf5qYneWF18X4pRhCT/j8aSNu1RiLrv
        KIg+uH754yLyf8EgnfsAEefmlVmecCrFKNzIIwbSUg==
X-Google-Smtp-Source: AAOMgpetjZeleNOuCslqgkoqmJjVBBsz917qXEfajz3nKzWmizX9y02wGUlpY72rMtpKUHt72w6jOt+AJkpRDn1T+14=
X-Received: by 2002:a24:d484:: with SMTP id x126-v6mr6249779itg.64.1530553962166;
 Mon, 02 Jul 2018 10:52:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:5186:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 10:52:41 -0700 (PDT)
In-Reply-To: <20180702154354.GA3919@jordon-HP-15-Notebook-PC>
References: <20180702154354.GA3919@jordon-HP-15-Notebook-PC>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 2 Jul 2018 19:52:41 +0200
Message-ID: <CAHc6FU6CVaT3W15n4jSiy6F4cZEFa9HdrZ8NRrU2GppTXr7p8A@mail.gmail.com>
Subject: Re: [PATCH] fs: iomap: Change return type to vm_fault_t
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>, Dave Chinner <dchinner@redhat.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Bob Peterson <rpeterso@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 July 2018 at 17:43, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> Return type has been changed to vm_fault_t type for
> iomap_page_mkwrite().
>
> see commit 1c8f422059ae ("mm: change return type to
> vm_fault_t") for reference.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
> ---
>  fs/iomap.c            | 2 +-
>  include/linux/iomap.h | 4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/iomap.c b/fs/iomap.c
> index afd1635..58477ee 100644
> --- a/fs/iomap.c
> +++ b/fs/iomap.c
> @@ -443,7 +443,7 @@ static int iomap_dax_zero(loff_t pos, unsigned offset, unsigned bytes,
>         return length;
>  }
>
> -int iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
> +vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
>  {
>         struct page *page = vmf->page;
>         struct inode *inode = file_inode(vmf->vma->vm_file);
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 19a07de..666b717 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -3,6 +3,7 @@
>  #define LINUX_IOMAP_H 1
>
>  #include <linux/types.h>
> +#include <linux/mm_types.h>
>
>  struct fiemap_extent_info;
>  struct inode;
> @@ -88,7 +89,8 @@ int iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
>                 bool *did_zero, const struct iomap_ops *ops);
>  int iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
>                 const struct iomap_ops *ops);
> -int iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops);
> +vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf,
> +                       const struct iomap_ops *ops);
>  int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>                 loff_t start, loff_t len, const struct iomap_ops *ops);
>  loff_t iomap_seek_hole(struct inode *inode, loff_t offset,
> --
> 1.9.1
>

Added to for-next, thanks.

Andreas
