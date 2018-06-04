Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751950AbeFDGxZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 02:53:25 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53357 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751409AbeFDGxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 02:53:24 -0400
Date: Mon, 4 Jun 2018 08:53:07 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Fabio Estevam <fabio.estevam@nxp.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: mxc: set spare area size register
 explicitly
Message-ID: <20180604065307.ipq3qvktq3ppxw2r@pengutronix.de>
References: <1528025495-14443-1-git-send-email-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528025495-14443-1-git-send-email-martin@kaiser.cx>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-IRC: #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:52:08 up 164 days, 15:10, 94 users,  load average: 0.23, 0.24,
 0.20
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 03, 2018 at 01:31:35PM +0200, Martin Kaiser wrote:
> The v21 version of the NAND flash controller contains a Spare Area Size
> Register (SPAS) at offset 0x10. Its setting defaults to the maximum
> spare area size of 218 bytes. The size that is set in this register is
> used by the controller when it calculates the ECC bytes internally in
> hardware.
> 
> Usually, this register is updated from settings in the IIM fuses when
> the system is booting from nand flash. For other boot media, however,
> the SPAS register remains at the default setting, which may not work for
> the particular flash chip on the board. The same goes for flash chips
> whose configuration cannot be set in the IIM fuses (e.g. chips with 2k
> sector size and 128 bytes spare area size can't be configured in the IIM
> fuses on imx25 systems).
> 
> Set the SPAS register explicitly during the preset operation. Derive the
> register value from mtd->oobsize that was detected during probe by
> decoding the flash chip's ID bytes.
> 
> While at it, rename the define for the spare area register's offset to
> NFC_V21_RSLTSPARE_AREA. The register at offset 0x10 on v1 controllers is
> different from the register on v21 controllers.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> Cc: stable@vger.kernel.org

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> ---
>  drivers/mtd/nand/raw/mxc_nand.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
> index 45786e7..c2f8572 100644
> --- a/drivers/mtd/nand/raw/mxc_nand.c
> +++ b/drivers/mtd/nand/raw/mxc_nand.c
> @@ -48,7 +48,7 @@
>  #define NFC_V1_V2_CONFIG		(host->regs + 0x0a)
>  #define NFC_V1_V2_ECC_STATUS_RESULT	(host->regs + 0x0c)
>  #define NFC_V1_V2_RSLTMAIN_AREA		(host->regs + 0x0e)
> -#define NFC_V1_V2_RSLTSPARE_AREA	(host->regs + 0x10)
> +#define NFC_V21_RSLTSPARE_AREA		(host->regs + 0x10)
>  #define NFC_V1_V2_WRPROT		(host->regs + 0x12)
>  #define NFC_V1_UNLOCKSTART_BLKADDR	(host->regs + 0x14)
>  #define NFC_V1_UNLOCKEND_BLKADDR	(host->regs + 0x16)
> @@ -1274,6 +1274,9 @@ static void preset_v2(struct mtd_info *mtd)
>  	writew(config1, NFC_V1_V2_CONFIG1);
>  	/* preset operation */
>  
> +	/* spare area size in 16bit words */
> +	writew(mtd->oobsize >> 1, NFC_V21_RSLTSPARE_AREA);
> +
>  	/* Unlock the internal RAM Buffer */
>  	writew(0x2, NFC_V1_V2_CONFIG);
>  
> -- 
> 2.1.4
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
