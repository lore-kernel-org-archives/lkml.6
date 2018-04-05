Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522952331; cv=none;
        d=google.com; s=arc-20160816;
        b=r+nyi/T//Vp9FE4sm6TXZZO0WxJh6BXYVMDwx2jrwrlF8m3IB4SUT84z7/QkAEcb17
         /VESGNdikGBV+Wt42cjbJcHqInTyLP6R+OCvIAiTrxMv8hAabxHLxS3slpCx5SM63ZrU
         6Yg/BID1wVLXiv+YiIeoP2AGwzuXhmwA3OdSpaUVMQSiTpi4mMm29/QJBQb0D+GFccZc
         N2ez4l69k/lN2ZTE85NQ35ZNi74hkRTxXtK0qJvYS2xedDidEB5LqCfdqt7Ygto1FD4h
         J9sNA81B5Lkq27UXgJu4K/47pWtF4WcPUmb7fgYuyGgFg1PdAWPWSue/bhjr51EgbZIw
         ZDUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=dsvgZ3w0CyjBjLkD/EmmwnxUGIk5BRxPVuKllyoMpzk=;
        b=EtmgxjwIEamgz1JS8devXlpI/LE2FIt7hCqBIh+scFNeQybmIrt472cbG6hPWmkmba
         3ktqi6mROt0XgIVw86GEZNLDu0DdhjnxJLOW7ewgZlQpUu/TDuC5Co9kZeQfM04wmfA2
         G1q+nbAHv7hCI3YG/9xGY28HyrNzCBTp4uQRHVBa95neOCxIxybgF7tBrccBFdQ3XZi3
         guOiGTD2DKMzZzdLXBOZD4WapE9tQWYiRDRHqXle7c15W53ULhq/oUoWG4V4hTOe4QcH
         Ml/JL2C5xiyfC4AGv23iW8iddSHXOHG/dle6DhaB0TuUYHZXWtJxw+9NS2PTewPyfwL1
         FzsQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=kKHOANgs;
       dkim=pass header.i=@chromium.org header.s=google header.b=j1oRpsU9;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=kKHOANgs;
       dkim=pass header.i=@chromium.org header.s=google header.b=j1oRpsU9;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx49dysTHIaiiyMx+dk1R2bF1gYE8SKSnwjsNs2uUnuPvdGL+HgkiWw51ppBtnW2d/IdxJTdUtnZ0Nj+1fJ33aY4=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180405181720.9659-1-ksspiers@google.com>
References: <20180405181720.9659-1-ksspiers@google.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 5 Apr 2018 11:18:50 -0700
X-Google-Sender-Auth: dSJ691Qt0AjP_AXp2uIzev-nhTo
Message-ID: <CAGXu5j++oA7Vdkt51TnS3GzvNTqkbPk_9upG3oyRtLj_0suCXQ@mail.gmail.com>
Subject: Re: [PATCH v2] isofs compress: Remove VLA usage
To: Kyle Spiers <ksspiers@google.com>
Cc: Jan Kara <jack@suse.cz>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Greg KH <gregkh@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596931173009580849?=
X-GMAIL-MSGID: =?utf-8?q?1596931264183289451?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 5, 2018 at 11:17 AM, Kyle Spiers <ksspiers@google.com> wrote:
> As part of the effort to remove VLAs from the kernel[1], this changes
> the allocation of the bhs and pages arrays from being on the stack to being
> kcalloc()ed. This also allows for the removal of the explicit zeroing
> of bhs.
>
> https://lkml.org/lkml/2018/3/7/621
>
> Signed-off-by: Kyle Spiers <ksspiers@google.com>

Looks good! Thanks for fixing the sparc64 build failure. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  fs/isofs/compress.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/fs/isofs/compress.c b/fs/isofs/compress.c
> index 9bb2fe35799d..4eba16bf173c 100644
> --- a/fs/isofs/compress.c
> +++ b/fs/isofs/compress.c
> @@ -20,6 +20,7 @@
>  #include <linux/init.h>
>  #include <linux/bio.h>
>
> +#include <linux/slab.h>
>  #include <linux/vmalloc.h>
>  #include <linux/zlib.h>
>
> @@ -59,7 +60,7 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
>                                 >> bufshift;
>         int haveblocks;
>         blkcnt_t blocknum;
> -       struct buffer_head *bhs[needblocks + 1];
> +       struct buffer_head **bhs;
>         int curbh, curpage;
>
>         if (block_size > deflateBound(1UL << zisofs_block_shift)) {
> @@ -80,7 +81,9 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
>
>         /* Because zlib is not thread-safe, do all the I/O at the top. */
>         blocknum = block_start >> bufshift;
> -       memset(bhs, 0, (needblocks + 1) * sizeof(struct buffer_head *));
> +       bhs = kcalloc(needblocks + 1, sizeof(*bhs), GFP_KERNEL);
> +       if (!bhs)
> +               return -ENOMEM;
>         haveblocks = isofs_get_blocks(inode, blocknum, bhs, needblocks);
>         ll_rw_block(REQ_OP_READ, 0, haveblocks, bhs);
>
> @@ -190,6 +193,7 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
>  b_eio:
>         for (i = 0; i < haveblocks; i++)
>                 brelse(bhs[i]);
> +       kfree(bhs);
>         return stream.total_out;
>  }
>
> @@ -305,7 +309,7 @@ static int zisofs_readpage(struct file *file, struct page *page)
>         unsigned int zisofs_pages_per_cblock =
>                 PAGE_SHIFT <= zisofs_block_shift ?
>                 (1 << (zisofs_block_shift - PAGE_SHIFT)) : 0;
> -       struct page *pages[max_t(unsigned, zisofs_pages_per_cblock, 1)];
> +       struct page **pages;
>         pgoff_t index = page->index, end_index;
>
>         end_index = (inode->i_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
> @@ -330,6 +334,10 @@ static int zisofs_readpage(struct file *file, struct page *page)
>                 full_page = 0;
>                 pcount = 1;
>         }
> +       pages = kcalloc(max_t(unsigned int, zisofs_pages_per_cblock, 1),
> +                                       sizeof(*pages), GFP_KERNEL);
> +       if (!pages)
> +               return -ENOMEM;
>         pages[full_page] = page;
>
>         for (i = 0; i < pcount; i++, index++) {
> @@ -357,6 +365,7 @@ static int zisofs_readpage(struct file *file, struct page *page)
>         }
>
>         /* At this point, err contains 0 or -EIO depending on the "critical" page */
> +       kfree(pages);
>         return err;
>  }
>
> --
> 2.17.0.484.g0c8726318c-goog
>



-- 
Kees Cook
Pixel Security
