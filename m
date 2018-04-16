Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753164AbeDPHsP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 03:48:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:45302 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752177AbeDPHsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 03:48:14 -0400
Date: Mon, 16 Apr 2018 09:48:11 +0200
From: Jan Kara <jack@suse.cz>
To: Chengguang Xu <cgxu519@gmx.com>
Cc: jack@suse.cz, dhowells@redhat.com, elfring@users.sourceforge.net,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isofs: fix potential memory leak in mount option parsing
Message-ID: <20180416074811.4wqibq6woptzcwfh@quack2.suse.cz>
References: <1523708166-32728-1-git-send-email-cgxu519@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523708166-32728-1-git-send-email-cgxu519@gmx.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 14-04-18 20:16:06, Chengguang Xu wrote:
> When specifying string type mount option (e.g., iocharset)
> several times in a mount, current option parsing may
> cause memory leak. Hence, call kfree for previous one
> in this case. Meanwhile, check memory allocation result
> for it.
> 
> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>

Thanks. I've added the patch to my tree.

								Honza

> ---
>  fs/isofs/inode.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
> index bc258a4..ec3fba7 100644
> --- a/fs/isofs/inode.c
> +++ b/fs/isofs/inode.c
> @@ -394,7 +394,10 @@ static int parse_options(char *options, struct iso9660_options *popt)
>  			break;
>  #ifdef CONFIG_JOLIET
>  		case Opt_iocharset:
> +			kfree(popt->iocharset);
>  			popt->iocharset = match_strdup(&args[0]);
> +			if (!popt->iocharset)
> +				return 0;
>  			break;
>  #endif
>  		case Opt_map_a:
> -- 
> 1.8.3.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
