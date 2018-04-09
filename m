Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753070AbeDIPtS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 11:49:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:56647 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751902AbeDIPtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 11:49:17 -0400
Date: Mon, 9 Apr 2018 17:49:16 +0200
From: Jan Kara <jack@suse.cz>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: jack@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: quota: Replace GFP_ATOMIC with GFP_KERNEL in
 dquot_init
Message-ID: <20180409154916.mp5jznkgvxk4a4ti@quack2.suse.cz>
References: <1523284279-25940-1-git-send-email-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523284279-25940-1-git-send-email-baijiaju1990@gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09-04-18 22:31:19, Jia-Ju Bai wrote:
> dquot_init() is never called in atomic context.
> This function is only set as a parameter of fs_initcall().
> 
> Despite never getting called from atomic context,
> dquot_init() calls __get_free_pages() with GFP_ATOMIC,
> which waits busily for allocation.
> GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
> to avoid busy waiting and improve the possibility of sucessful allocation.
> 
> This is found by a static analysis tool named DCNS written by myself.
> And I also manually check it.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Thanks, I have added the patch to my tree.

								Honza


> ---
>  fs/quota/dquot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index 8381db9..d6e111e 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -2944,7 +2944,7 @@ static int __init dquot_init(void)
>  			NULL);
>  
>  	order = 0;
> -	dquot_hash = (struct hlist_head *)__get_free_pages(GFP_ATOMIC, order);
> +	dquot_hash = (struct hlist_head *)__get_free_pages(GFP_KERNEL, order);
>  	if (!dquot_hash)
>  		panic("Cannot create dquot hash table");
>  
> -- 
> 1.9.1
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
