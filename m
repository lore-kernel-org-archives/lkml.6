Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752684AbeCMNVt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 09:21:49 -0400
Received: from osg.samsung.com ([64.30.133.232]:56968 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752030AbeCMNVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 09:21:43 -0400
Date: Tue, 13 Mar 2018 10:21:33 -0300
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] EDAC, sb_edac: Remove VLA usage
Message-ID: <20180313102133.7e505e2b@vento.lan>
In-Reply-To: <20180313112034.GA28234@embeddedgus>
References: <20180313112034.GA28234@embeddedgus>
Organization: Samsung
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 13 Mar 2018 06:20:34 -0500
"Gustavo A. R. Silva" <gustavo@embeddedor.com> escreveu:

> In preparation to enabling -Wvla, remove VLA and replace it
> with a fixed-length array instead.
> 
> Fixed as part of the directive to remove all VLAs from
> the kernel: https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> Changes in v2:
>  - Use macro max_t to compute the max of all three array sizes.
>    This change is based on Borislav's feedback.
> 
>  drivers/edac/sb_edac.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
> index 8721002..196b012 100644
> --- a/drivers/edac/sb_edac.c
> +++ b/drivers/edac/sb_edac.c
> @@ -110,6 +110,10 @@ static const u32 knl_interleave_list[] = {
>  	0xdc, 0xe4, 0xec, 0xf4, 0xfc, /* 15-19 */
>  	0x104, 0x10c, 0x114, 0x11c,   /* 20-23 */
>  };
> +#define MAX_INTERLEAVE (max_t(unsigned int, ARRAY_SIZE(sbridge_interleave_list),\
> +			max_t(unsigned int, ARRAY_SIZE(ibridge_interleave_list),\
> +					    ARRAY_SIZE(knl_interleave_list))))
> +

In order to avoid too long lines, it would be better to do it as:

#define MAX_INTERLEAVE						        \
	(max_t(unsigned int, ARRAY_SIZE(sbridge_interleave_list),       \
	       max_t(unsigned int, ARRAY_SIZE(ibridge_interleave_list), \
		     ARRAY_SIZE(knl_interleave_list))))


With that:

Reviewed-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>

>  
>  struct interleave_pkg {
>  	unsigned char start;
> @@ -1899,7 +1903,7 @@ static int get_memory_error_data(struct mem_ctl_info *mci,
>  	int			n_rir, n_sads, n_tads, sad_way, sck_xch;
>  	int			sad_interl, idx, base_ch;
>  	int			interleave_mode, shiftup = 0;
> -	unsigned		sad_interleave[pvt->info.max_interleave];
> +	unsigned int		sad_interleave[MAX_INTERLEAVE];
>  	u32			reg, dram_rule;
>  	u8			ch_way, sck_way, pkg, sad_ha = 0;
>  	u32			tad_offset;



Thanks,
Mauro
