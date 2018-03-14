Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751988AbeCNSDo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 14:03:44 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37264 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750950AbeCNSDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 14:03:42 -0400
Date: Wed, 14 Mar 2018 19:03:06 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] EDAC, sb_edac: Remove VLA usage
Message-ID: <20180314180305.GI16605@pd.tnic>
References: <20180313134449.GA24398@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180313134449.GA24398@embeddedgus>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 08:44:49AM -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wvla, remove VLA and replace it
> with a fixed-length array instead.
> 
> Fixed as part of the directive to remove all VLAs from
> the kernel: https://lkml.org/lkml/2018/3/7/621
> 
> Reviewed-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> Changes in v3:
>  - Update macro MAX_INTERLEAVE in order to avoid too long lines.
>    This change is based on Mauro's feedback.
>  - Update changelog with Mauro's Reviewed-by.
> 
> Changes in v2:
>  - Use macro max_t to compute the max of all three array sizes.
>    This change is based on Borislav's feedback.
> 
>  drivers/edac/sb_edac.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
> index 8721002..aff4778 100644
> --- a/drivers/edac/sb_edac.c
> +++ b/drivers/edac/sb_edac.c
> @@ -110,6 +110,11 @@ static const u32 knl_interleave_list[] = {
>  	0xdc, 0xe4, 0xec, 0xf4, 0xfc, /* 15-19 */
>  	0x104, 0x10c, 0x114, 0x11c,   /* 20-23 */
>  };
> +#define MAX_INTERLEAVE							\
> +	(max_t(unsigned int, ARRAY_SIZE(sbridge_interleave_list),	\
> +	       max_t(unsigned int, ARRAY_SIZE(ibridge_interleave_list),	\
> +		     ARRAY_SIZE(knl_interleave_list))))
> +
>  
>  struct interleave_pkg {
>  	unsigned char start;
> @@ -1899,7 +1904,7 @@ static int get_memory_error_data(struct mem_ctl_info *mci,
>  	int			n_rir, n_sads, n_tads, sad_way, sck_xch;
>  	int			sad_interl, idx, base_ch;
>  	int			interleave_mode, shiftup = 0;
> -	unsigned		sad_interleave[pvt->info.max_interleave];

Where's the hunk removing ->max_interleave ?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
