Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752513AbeA3NYC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 08:24:02 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:41853 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751764AbeA3NYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 08:24:00 -0500
Date: Tue, 30 Jan 2018 14:23:48 +0100
From: Boris Brezillon <boris.brezillon@free-electrons.com>
To: Stefan Agner <stefan@agner.ch>
Cc: han.xu@nxp.com, max.oss.09@gmail.com, richard@nod.at,
        linux-kernel@vger.kernel.org, marek.vasut@gmail.com,
        linux-mtd@lists.infradead.org, cyrille.pitchen@wedev4u.fr,
        dwmw2@infradead.org
Subject: Re: [PATCH] mtd: nand: gpmi: fall back to legacy mode if no ECC
 information present
Message-ID: <20180130142348.35f1bce3@bbrezillon>
In-Reply-To: <20180129144440.13648-1-stefan@agner.ch>
References: <20180129144440.13648-1-stefan@agner.ch>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On Mon, 29 Jan 2018 15:44:40 +0100
Stefan Agner <stefan@agner.ch> wrote:

> In case fsl,use-minimum-ecc is set, the driver tries to determine
> ECC layout by using the ECC information provided by the MTD stack.
> However, in case the NAND chip does not provide any information,
> the driver currently fails with:
>   nand: device found, Manufacturer ID: 0xc2, Chip ID: 0xf1
>   nand: Macronix NAND 128MiB 3,3V 8-bit
>   nand: 128 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
>   gpmi-nand 1806000.gpmi-nand: Error setting BCH geometry : 1
>   gpmi-nand: probe of 1806000.gpmi-nand failed with error 1
> 
> Fall back to implementation specific default mode if no ECC
> information are provided by the NAND chip and fsl,use-minimum-ecc
> is specified.

Hm, this sounds a bit fragile: if we ever fix the Macronix driver
(which should be done BTW) to set the appropriate ECC requirements, it
will break all platforms that were relying on this 'fall back to legacy
logic'.
So, if what you really want is legacy_set_geometry(), don't specify
"fsl,use-minimum-ecc" in your DT and you should be good. Otherwise, fix
the Macronix driver to initialize ->ecc_{strength,step_size}_ds
appropriately.

Regards,

Boris

> 
> This is more in line with what the device tree binding documentation
> promises:
>   "However, note that if this strength is not
>   discoverable or this property is not enabled,
>   the software may chooses an implementation-defined
>   ECC scheme."
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/mtd/nand/gpmi-nand/gpmi-nand.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> index 50f8d4a1b983..7b8e8c629081 100644
> --- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> +++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> @@ -206,7 +206,7 @@ static int set_geometry_by_ecc_info(struct gpmi_nand_data *this)
>  	unsigned int block_mark_bit_offset;
>  
>  	if (!(chip->ecc_strength_ds > 0 && chip->ecc_step_ds > 0))
> -		return -EINVAL;
> +		return -ENOTSUPP;
>  
>  	switch (chip->ecc_step_ds) {
>  	case SZ_512:
> @@ -423,11 +423,15 @@ static int legacy_set_geometry(struct gpmi_nand_data *this)
>  
>  int common_nfc_set_geometry(struct gpmi_nand_data *this)
>  {
> -	if ((of_property_read_bool(this->dev->of_node, "fsl,use-minimum-ecc"))
> -				|| legacy_set_geometry(this))
> -		return set_geometry_by_ecc_info(this);
> +	int ret = -ENOTSUPP;
>  
> -	return 0;
> +	if (of_property_read_bool(this->dev->of_node, "fsl,use-minimum-ecc"))
> +		ret = set_geometry_by_ecc_info(this);
> +
> +	if (ret == -ENOTSUPP)
> +		return legacy_set_geometry(this);
> +
> +	return ret;
>  }
>  
>  struct dma_chan *get_dma_chan(struct gpmi_nand_data *this)
