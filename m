Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751917AbeEKFDp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 01:03:45 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:43242 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750751AbeEKFDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 01:03:44 -0400
Subject: Re: [PATCH v2 2/2] mtd: rawnand: fsl_ifc: use bit-wise majority to
To: "Wan, Jane (Nokia - US/Sunnyvale)" <jane.wan@nokia.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc: "shreeya.patel23498@gmail.com" <shreeya.patel23498@gmail.com>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "Bos, Ties (Nokia - US/Sunnyvale)" <ties.bos@nokia.com>,
        "prabhakar.kushwaha@nxp.com" <prabhakar.kushwaha@nxp.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "jagdish.gediya@nxp.com" <jagdish.gediya@nxp.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
References: <VI1PR07MB161553DA5D3EF35C9052B1CA81860@VI1PR07MB1615.eurprd07.prod.outlook.com>
From: Chris Moore <moore@free.fr>
Message-ID: <d05c6b9d-4b67-9fa1-88f4-9cc3a01c1a71@free.fr>
Date: Fri, 11 May 2018 07:03:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <VI1PR07MB161553DA5D3EF35C9052B1CA81860@VI1PR07MB1615.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le 04/05/2018 à 04:09, Wan, Jane (Nokia - US/Sunnyvale) a écrit
> The following is the reposting of patch with v2 version indication based on comment on "[PATCH 1/2]" (also in the attachment).
>
> Subject: [PATCH v2 2/2] mtd: rawnand: fsl_ifc: use bit-wise majority to
>   recover the contents of ONFI parameter
>
> Per ONFI specification (Rev. 4.0), if all parameter pages have invalid
> CRC values, the bit-wise majority may be used to recover the contents of
> the parameter pages from the parameter page copies present.
>
> Signed-off-by: Jane Wan <Jane.Wan@nokia.com>
> ---
>   drivers/mtd/nand/raw/nand_base.c |   36 ++++++++++++++++++++++++++++++------
>   1 file changed, 30 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index 72f3a89..464c4fb 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c

[snip]

>   
> +		pr_info("Recover ONFI params with bit-wise majority\n");
> +		for (j = 0; j < pagesize; j++) {
> +			v = 0;
> +			for (k = 0; k < 8; k++) {
> +				m = 0;
> +				for (l = 0; l < 3; l++)
> +					m += GET_BIT(k, buf[l*pagesize + j]);
> +				if (m > 1)
> +					v |= BIT(k);
> +			}
> +			((u8 *)p)[j] = v;
> +		}

I am not familiar with the context of this but the three way bit-wise 
majority can be implemented much more efficiently  using the identity:
majority3(a, b, c) = (a & b) | (a & c) | (b & c)
This can be factorized slightly to (a & (b | c)) | (b & c)
This enables the operation to be performed 8, 16, 32 or even 64 bits at 
a time depending on the hardware.

Cheers,
Chris
