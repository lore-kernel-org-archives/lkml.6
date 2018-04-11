Return-Path: <jack@suse.cz>
X-Google-Smtp-Source: AIpwx48SIIzh9UrlRw2ysfpaBDs3rmERVZ2szB2RW9eAltVjjadcfI3tdE+jfhJgB7FlCUlrR1db
ARC-Seal: i=1; a=rsa-sha256; t=1523433426; cv=none;
        d=google.com; s=arc-20160816;
        b=QyK0TmuTwSGgYUcCottbKmhxvUSO+v27e88uMuUS9O9jAX66FvJ+z61Vw37ZR2hlq+
         aJlplOcJQv2v/d9xU/UdqeNZ4Orhhj9givl7N54ZiojDG/TBeY3igz+Rvah/Uv3BGkv5
         BJ0053YOamQtySVer0hXGCHC6imfJmmc7VbD54rJ+/+yEy8sCs0h7WouG8DvwPm7jCtS
         fWnFG7vuPYc7f9ocuOiznCYH/0RVUhs5v98qErUqb1i3uN/5wwxbh2KEniIH3qUrL8dZ
         fZa+OsaQ0+lnbK2TXAQdet3ml2V3B3aomQWds1HOemLHhgmJeoq9xwZ7IqLHvM4lanQi
         fPrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=MK915xUiq7jf3NH5jKAZHpGxLRdgxn5c1/x0YbQuRJk=;
        b=vD0UmvFzQ41k5Gp+pSx/144gv2SP1/B8uCETtt5wFqNLQnRWmwuStL4W019Kec9T6H
         3FQkCdxSh0/x1GyRRWPEQuQAt2+eWTB7VpBZ7fXIMHp5dWzEuZL/Y9wPm43Fd3JKXf+h
         x6bqrPi9RPA1QFWudlm0AaE1ZX0iCuQ5l+JifkPESdbC4R1nJtlagrs9vJRlGAZwjff6
         EWTmwHiOxOIN24IjHpV0g4qovPjic9g3T+c9EBRnzqQlxMH91geAUdFZ8JjG+5d8ZuKh
         ObzpYJvTeS1PrVGi8OaDy1Mgh93YqFPl6qmO2C4Vf1Js8SNP9pmr4Q0eCwZbZ8tJ+SlU
         Bcpw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jack@suse.cz designates 195.135.220.15 as permitted sender) smtp.mailfrom=jack@suse.cz
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jack@suse.cz designates 195.135.220.15 as permitted sender) smtp.mailfrom=jack@suse.cz
Date: Wed, 11 Apr 2018 09:57:03 +0200
From: Jan Kara <jack@suse.cz>
To: Kyle Spiers <ksspiers@google.com>
Cc: jack@suse.cz, arnd@arndb.de, dhowells@redhat.com,
	viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
	keescook@chromium.org, joe@perches.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] isofs compress: Remove VLA usage
Message-ID: <20180411075703.uimpgcxsasxsm5sh@quack2.suse.cz>
References: <20180411000229.188137-1-ksspiers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180411000229.188137-1-ksspiers@google.com>
User-Agent: NeoMutt/20170421 (1.8.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597404821961766971?=
X-GMAIL-MSGID: =?utf-8?q?1597435728158043172?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue 10-04-18 17:02:29, Kyle Spiers wrote:
> As part of the effort to remove VLAs from the kernel[1], this changes
> the allocation of the bhs and pages arrays from being on the stack to being
> kcalloc()ed. This also allows for the removal of the explicit zeroing
> of bhs.
> 
> https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Kyle Spiers <ksspiers@google.com>
> ---
> Fix sparc64 build
> Fix Error recovery Mistakes

Thanks, the patch looks good now and I've merged it to my tree and will
push it to Linus (likely for rc2).

								Honza

> ---
>  fs/isofs/compress.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/isofs/compress.c b/fs/isofs/compress.c
> index 9bb2fe35799d..10205ececc27 100644
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
>  				>> bufshift;
>  	int haveblocks;
>  	blkcnt_t blocknum;
> -	struct buffer_head *bhs[needblocks + 1];
> +	struct buffer_head **bhs;
>  	int curbh, curpage;
>  
>  	if (block_size > deflateBound(1UL << zisofs_block_shift)) {
> @@ -80,7 +81,11 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
>  
>  	/* Because zlib is not thread-safe, do all the I/O at the top. */
>  	blocknum = block_start >> bufshift;
> -	memset(bhs, 0, (needblocks + 1) * sizeof(struct buffer_head *));
> +	bhs = kcalloc(needblocks + 1, sizeof(*bhs), GFP_KERNEL);
> +	if (!bhs) {
> +		*errp = -ENOMEM;
> +		return 0;
> +	}
>  	haveblocks = isofs_get_blocks(inode, blocknum, bhs, needblocks);
>  	ll_rw_block(REQ_OP_READ, 0, haveblocks, bhs);
>  
> @@ -190,6 +195,7 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
>  b_eio:
>  	for (i = 0; i < haveblocks; i++)
>  		brelse(bhs[i]);
> +	kfree(bhs);
>  	return stream.total_out;
>  }
>  
> @@ -305,7 +311,7 @@ static int zisofs_readpage(struct file *file, struct page *page)
>  	unsigned int zisofs_pages_per_cblock =
>  		PAGE_SHIFT <= zisofs_block_shift ?
>  		(1 << (zisofs_block_shift - PAGE_SHIFT)) : 0;
> -	struct page *pages[max_t(unsigned, zisofs_pages_per_cblock, 1)];
> +	struct page **pages;
>  	pgoff_t index = page->index, end_index;
>  
>  	end_index = (inode->i_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
> @@ -330,6 +336,12 @@ static int zisofs_readpage(struct file *file, struct page *page)
>  		full_page = 0;
>  		pcount = 1;
>  	}
> +	pages = kcalloc(max_t(unsigned int, zisofs_pages_per_cblock, 1),
> +					sizeof(*pages), GFP_KERNEL);
> +	if (!pages) {
> +		unlock_page(page);
> +		return -ENOMEM;
> +	}
>  	pages[full_page] = page;
>  
>  	for (i = 0; i < pcount; i++, index++) {
> @@ -357,6 +369,7 @@ static int zisofs_readpage(struct file *file, struct page *page)
>  	}			
>  
>  	/* At this point, err contains 0 or -EIO depending on the "critical" page */
> +	kfree(pages);
>  	return err;
>  }
>  
> -- 
> 2.17.0.484.g0c8726318c-goog
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
