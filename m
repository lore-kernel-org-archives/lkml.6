Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753401AbeDVR1E (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 13:27:04 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46656 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751564AbeDVR1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 13:27:03 -0400
Date: Sun, 22 Apr 2018 19:26:50 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: boris.brezillon@free-electrons.com, richard@nod.at,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, cyrille.pitchen@wedev4u.fr,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: nand: diskonchip: Replace mdelay with usleep_range
 in doc_probe
Message-ID: <20180422192650.45fcfa4e@bbrezillon>
In-Reply-To: <1523415477-2850-1-git-send-email-baijiaju1990@gmail.com>
References: <1523415477-2850-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Apr 2018 10:57:57 +0800
Jia-Ju Bai <baijiaju1990@gmail.com> wrote:

> doc_probe() is never called in atomic context.
> 
> doc_probe() is only called by init_nanddoc(), which is only set as 
> a parameter of module_init().
> This function is not called in atomic context.
> 
> Despite never getting called from atomic context, doc_probe()
> calls mdelay() to busily wait.
> This is not necessary and can be replaced with usleep_range() to
> avoid busy waiting.
> 
> This is found by a static analysis tool named DCNS written by myself.
> And I also manually check it.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/mtd/nand/diskonchip.c | 4 ++--

Applied to nand/next after fixing the subject prefix and the file path.

Thanks,

Boris

>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/diskonchip.c b/drivers/mtd/nand/diskonchip.c
> index c3aa53c..2679bc4 100644
> --- a/drivers/mtd/nand/diskonchip.c
> +++ b/drivers/mtd/nand/diskonchip.c
> @@ -1482,12 +1482,12 @@ static int __init doc_probe(unsigned long physadr)
>  		WriteDOC(tmp, virtadr, Mplus_DOCControl);
>  		WriteDOC(~tmp, virtadr, Mplus_CtrlConfirm);
>  
> -		mdelay(1);
> +		usleep_range(1000, 2000);
>  		/* Enable the Millennium Plus ASIC */
>  		tmp = DOC_MODE_NORMAL | DOC_MODE_MDWREN | DOC_MODE_RST_LAT | DOC_MODE_BDECT;
>  		WriteDOC(tmp, virtadr, Mplus_DOCControl);
>  		WriteDOC(~tmp, virtadr, Mplus_CtrlConfirm);
> -		mdelay(1);
> +		usleep_range(1000, 2000);
>  
>  		ChipID = ReadDOC(virtadr, ChipID);
>  
