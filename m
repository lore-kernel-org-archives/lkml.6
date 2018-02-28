Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752346AbeB1MgJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 07:36:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:35568 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752195AbeB1MgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 07:36:08 -0500
Date: Wed, 28 Feb 2018 13:36:06 +0100
From: Jan Kara <jack@suse.cz>
To: Chengguang Xu <cgxu519@icloud.com>
Cc: jack@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udf: fix potential refcnt problem of nls module
Message-ID: <20180228123606.z3zcwawbvh4g72ym@quack2.suse.cz>
References: <1519565107-213857-1-git-send-email-cgxu519@icloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519565107-213857-1-git-send-email-cgxu519@icloud.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 25-02-18 21:25:07, Chengguang Xu wrote:
> When specifiying iocharset multiple times in a mount
> or once/multiple in a remount, current option parsing
> may cause inaccurate refcount of nls module.
> Also, in the failure cleanup of option parsing,
> the condition of calling unload_nls is not sufficient.
> 
> Signed-off-by: Chengguang Xu <cgxu519@icloud.com>
> ---
> 
> Hi Jan,
> 
> I found this issue by checking code so now post the fix for rewiew,
> but sorry I did't get enough resource to fully test it, I can only
> make sure the fix can successfuly comiple with no error.

Thanks for the patch. I have added it to my tree.

								Honza

> 
>  fs/udf/super.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/udf/super.c b/fs/udf/super.c
> index 7b27b06..7e73a98 100644
> --- a/fs/udf/super.c
> +++ b/fs/udf/super.c
> @@ -523,8 +523,12 @@ static int udf_parse_options(char *options, struct udf_options *uopt,
>  			break;
>  #ifdef CONFIG_UDF_NLS
>  		case Opt_iocharset:
> -			uopt->nls_map = load_nls(args[0].from);
> -			uopt->flags |= (1 << UDF_FLAG_NLS_MAP);
> +			if (!remount) {
> +				if (uopt->nls_map)
> +					unload_nls(uopt->nls_map);
> +				uopt->nls_map = load_nls(args[0].from);
> +				uopt->flags |= (1 << UDF_FLAG_NLS_MAP);
> +			}
>  			break;
>  #endif
>  		case Opt_uignore:
> @@ -2082,8 +2086,8 @@ error_out:
>  		for (i = 0; i < sbi->s_partitions; i++)
>  			udf_free_partition(&sbi->s_partmaps[i]);
>  #ifdef CONFIG_UDF_NLS
> -	if (UDF_QUERY_FLAG(sb, UDF_FLAG_NLS_MAP))
> -		unload_nls(sbi->s_nls_map);
> +	if (uopt.nls_map)
> +		unload_nls(uopt.nls_map);
>  #endif
>  	if (!(sb->s_flags & MS_RDONLY))
>  		udf_close_lvid(sb);
> -- 
> 1.8.3.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
