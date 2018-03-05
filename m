Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752586AbeCEPch (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 10:32:37 -0500
Received: from mail.bootlin.com ([62.4.15.54]:33515 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751486AbeCEPcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 10:32:36 -0500
Date: Mon, 5 Mar 2018 16:32:23 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: OuYang ZhiZhong <oyzhizhong@gmail.com>
Cc: dwmw2@infradead.org, computersforpeace@gmail.com,
        boris.brezillon@free-electrons.com, marek.vasut@gmail.com,
        richard@nod.at, vdavydov.dev@gmail.com, cyrille.pitchen@wedev4u.fr,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtdchar: fix usage of mtd_ooblayout_ecc()
Message-ID: <20180305163223.41ae1a6f@bbrezillon>
In-Reply-To: <1520261626-17395-1-git-send-email-oyzhizhong@gmail.com>
References: <1520261626-17395-1-git-send-email-oyzhizhong@gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi OuYang,

On Mon,  5 Mar 2018 22:53:46 +0800
OuYang ZhiZhong <oyzhizhong@gmail.com> wrote:

> Section was not properly computed. The value of OOB region definition is
> always ECC section 0 information in the OOB area, but we want to get all
> the ECC bytes information, so we should call
> mtd_ooblayout_ecc(mtd, section++, &oobregion) until it returns -ERANGE.

Oops, indeed.

> 
> This is fixed by using i instead of section.
> 

Fixes: c2b78452a9db ("mtd: use mtd_ooblayout_xxx() helpers where appropriate")
Cc: <stable@vger.kernel.org>


> Signed-off-by: OuYang ZhiZhong <oyzhizhong@gmail.com>
> ---
>  drivers/mtd/mtdchar.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
> index de8c902..0cc929e 100644
> --- a/drivers/mtd/mtdchar.c
> +++ b/drivers/mtd/mtdchar.c
> @@ -468,7 +468,7 @@ static int shrink_ecclayout(struct mtd_info *mtd,
>  			    struct nand_ecclayout_user *to)
>  {
>  	struct mtd_oob_region oobregion;
> -	int i, section = 0, ret;
> +	int i, ret;
>  
>  	if (!mtd || !to)
>  		return -EINVAL;
> @@ -479,7 +479,7 @@ static int shrink_ecclayout(struct mtd_info *mtd,
>  	for (i = 0; i < MTD_MAX_ECCPOS_ENTRIES;) {
>  		u32 eccpos;
>  
> -		ret = mtd_ooblayout_ecc(mtd, section, &oobregion);
> +		ret = mtd_ooblayout_ecc(mtd, i, &oobregion);

Nope, you're not fixing the problem with that: i is encoding the
->eccpos index, not the OOB section. You should really do section++,
either here, or in the for statement.

>  		if (ret < 0) {
>  			if (ret != -ERANGE)
>  				return ret;
> @@ -515,7 +515,7 @@ static int shrink_ecclayout(struct mtd_info *mtd,
>  static int get_oobinfo(struct mtd_info *mtd, struct nand_oobinfo *to)
>  {
>  	struct mtd_oob_region oobregion;
> -	int i, section = 0, ret;
> +	int i, ret;
>  
>  	if (!mtd || !to)
>  		return -EINVAL;
> @@ -526,7 +526,7 @@ static int get_oobinfo(struct mtd_info *mtd, struct nand_oobinfo *to)
>  	for (i = 0; i < ARRAY_SIZE(to->eccpos);) {
>  		u32 eccpos;
>  
> -		ret = mtd_ooblayout_ecc(mtd, section, &oobregion);
> +		ret = mtd_ooblayout_ecc(mtd, i, &oobregion);

Ditto.

>  		if (ret < 0) {
>  			if (ret != -ERANGE)
>  				return ret;

Thanks,

Boris

-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
