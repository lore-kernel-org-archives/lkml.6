Return-Path: <jack@suse.cz>
X-Google-Smtp-Source: AIpwx48h0AOYiNeagF1Ku+BRKK4veKje4CWc5vAQi5L34maX6EphRP0eZdXFlanT00L7l63X5rDH
ARC-Seal: i=1; a=rsa-sha256; t=1523357869; cv=none;
        d=google.com; s=arc-20160816;
        b=v2J2IKTaog7InHEjVK9QuHgZ3prhwWaLRq7Pnb6+2lVSH2v0foRyPvwKxgXOOERvMl
         jr/G9XE+zb2NCqJLqvNvteEvm8u+D1IflhB6+rLAyZNkPu58rbcS2Sh3qeixB3exn2Yr
         GhvQgPp4i6SksLYFUrISi5qxm4dG8UL0o0LaQ7KGyvaGQw5td4uzFgwcOx3Z8IvQsE6V
         zCKs9K1tk/yU9Ii0Aq+Lq1xIw8xXGxMsiCYCHzgQkEMmdUrXj2Z4r1Pv13waFHCtCp5B
         783LplFc1/iXWA+x9rZNodHiOPCYPCMZN9wrNcSKQhTzIh5LwH4HG54g+kc18TCYrh+L
         NYwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=hnk8zScfTjZXmEaa/vCqZ6db3exrz5FASbNCPcNSSZI=;
        b=uI67zArxrZPN3cC84Dl4sGUiYjKcjaxAgpXhEl+PuFZfWnKEesWoCX8YGmXUKqlOef
         TXyzdbhzhb8XgP1Rzqjd2328K5VtywOF7RSJt9W/xVr3Ohz0fzT/30zULGJelfc79aPt
         jPyTCoqCZzxr86vYvnPt0gUchfrL73beaosuH38JPWMLDtxHbhV2SbFLwmzNPkC6dM2F
         IjHWvE2Z1yDV8u3+har40WUWk3+laBaBVUkdsfwd8ajNqLUZaB3R6+Bf0Iag3VWnM65h
         pogSpolzRzhanvotZQfHf7NMXHPcf7SMCKrUgHdAAYqThYrdhGoYDdwqJu4bbglseLYZ
         qAHQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jack@suse.cz designates 195.135.220.15 as permitted sender) smtp.mailfrom=jack@suse.cz
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jack@suse.cz designates 195.135.220.15 as permitted sender) smtp.mailfrom=jack@suse.cz
Date: Tue, 10 Apr 2018 12:57:44 +0200
From: Jan Kara <jack@suse.cz>
To: Kyle Spiers <ksspiers@google.com>
Cc: jack@suse.cz, arnd@arndb.de, dhowells@redhat.com,
	viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
	keescook@chromium.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] isofs compress: Remove VLA usage
Message-ID: <20180410105744.iwtcuevcfkmwyal4@quack2.suse.cz>
References: <20180405181720.9659-1-ksspiers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405181720.9659-1-ksspiers@google.com>
User-Agent: NeoMutt/20170421 (1.8.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596931173009580849?=
X-GMAIL-MSGID: =?utf-8?q?1597356500763785577?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu 05-04-18 11:17:20, Kyle Spiers wrote:
> As part of the effort to remove VLAs from the kernel[1], this changes
> the allocation of the bhs and pages arrays from being on the stack to being
> kcalloc()ed. This also allows for the removal of the explicit zeroing
> of bhs.
> 
> https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Kyle Spiers <ksspiers@google.com>

This is a good cleanup but the error recovery is hosed. See below...

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
>  				>> bufshift;
>  	int haveblocks;
>  	blkcnt_t blocknum;
> -	struct buffer_head *bhs[needblocks + 1];
> +	struct buffer_head **bhs;
>  	int curbh, curpage;
>  
>  	if (block_size > deflateBound(1UL << zisofs_block_shift)) {
> @@ -80,7 +81,9 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
>  
>  	/* Because zlib is not thread-safe, do all the I/O at the top. */
>  	blocknum = block_start >> bufshift;
> -	memset(bhs, 0, (needblocks + 1) * sizeof(struct buffer_head *));
> +	bhs = kcalloc(needblocks + 1, sizeof(*bhs), GFP_KERNEL);
> +	if (!bhs)
> +		return -ENOMEM;

As Joe pointed out this needs to be:

	if (!bhs) {
		*errp = -ENOMEM;
		return 0;
	}

> @@ -330,6 +334,10 @@ static int zisofs_readpage(struct file *file, struct page *page)
>  		full_page = 0;
>  		pcount = 1;
>  	}
> +	pages = kcalloc(max_t(unsigned int, zisofs_pages_per_cblock, 1),
> +					sizeof(*pages), GFP_KERNEL);
> +	if (!pages)
> +		return -ENOMEM;

And this is wrong as well. You need to do:

	if (!pages) {
		unlock_page(page);
		return -ENOMEM;
	}


								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
