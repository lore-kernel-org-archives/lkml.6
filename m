Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752174AbeECDx7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 23:53:59 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:37120 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751872AbeECDxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 23:53:55 -0400
X-UUID: b33b96efee7f4ae190b89e7d56616a22-20180503
Message-ID: <1525319630.14792.91.camel@mtkswgap22>
Subject: Re: [PATCH V4 7/8] soc: mediatek: pwrap: add mt6351 for mt6797 SoCs
From: Sean Wang <sean.wang@mediatek.com>
To: <argus.lin@mediatek.com>
CC: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Chenglin Xu <chenglin.xu@mediatek.com>, <wsd_upstream@mediatek.com>,
        <henryc.chen@mediatek.com>, <flora.fu@mediatek.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        "shailendra . v" <shailendra.v@samsung.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date: Thu, 3 May 2018 11:53:50 +0800
In-Reply-To: <20180502092112.3991-8-argus.lin@mediatek.com>
References: <20180502092112.3991-1-argus.lin@mediatek.com>
         <20180502092112.3991-8-argus.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Argus

On Wed, 2018-05-02 at 17:21 +0800, argus.lin@mediatek.com wrote:
> From: Argus Lin <argus.lin@mediatek.com>
> 
> mt6351 is a new power management IC and it is
> used for mt6797 SoCs. We need to add mt6351_regs for
> pmic register mapping and pmic_mt6351 for
> register accessing by regmap.
> 

suggest line wrapping closely at 75 columns

> Signed-off-by: Argus Lin <argus.lin@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-pmic-wrap.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index 285bfa76249f..26076900eee0 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -152,6 +152,21 @@ static const u32 mt6397_regs[] = {
>  	[PWRAP_DEW_CIPHER_SWRST] =	0xbc24,
>  };
>  
> +static const u32 mt6351_regs[] = {
> +	[PWRAP_DEW_DIO_EN] =		0x02F2,
> +	[PWRAP_DEW_READ_TEST] =		0x02F4,
> +	[PWRAP_DEW_WRITE_TEST] =	0x02F6,
> +	[PWRAP_DEW_CRC_EN] =		0x02FA,
> +	[PWRAP_DEW_CRC_VAL] =		0x02FC,
> +	[PWRAP_DEW_CIPHER_KEY_SEL] =	0x0300,
> +	[PWRAP_DEW_CIPHER_IV_SEL] =	0x0302,
> +	[PWRAP_DEW_CIPHER_EN] =		0x0304,
> +	[PWRAP_DEW_CIPHER_RDY] =	0x0306,
> +	[PWRAP_DEW_CIPHER_MODE] =	0x0308,
> +	[PWRAP_DEW_CIPHER_SWRST] =	0x030A,
> +	[PWRAP_DEW_RDDMY_NO] =		0x030C,
> +};
> +

trim the unused registers if any

>  enum pwrap_regs {
>  	PWRAP_MUX_SEL,
>  	PWRAP_WRAP_EN,
> @@ -684,6 +699,7 @@ static int mt8135_regs[] = {
>  
>  enum pmic_type {
>  	PMIC_MT6323,
> +	PMIC_MT6351,
>  	PMIC_MT6380,
>  	PMIC_MT6397,
>  };
> @@ -1150,6 +1166,7 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
>  			    0x1);
>  		break;
>  	case PMIC_MT6323:
> +	case PMIC_MT6351:
>  		pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_EN],
>  			    0x1);
>  		break;
> @@ -1435,6 +1452,15 @@ static const struct pwrap_slv_type pmic_mt6397 = {
>  	.pwrap_write = pwrap_write16,
>  };
>  
> +static const struct pwrap_slv_type pmic_mt6351 = {
> +	.dew_regs = mt6351_regs,
> +	.type = PMIC_MT6351,
> +	.regmap = &pwrap_regmap_config16,
> +	.caps = 0,

the caps should be

PWRAP_SLV_CAP_SPI | PWRAP_SLV_CAP_DUALIO |
                 PWRAP_SLV_CAP_SECURITY,
 
otherwise, the registers you defined here cannot be accessed by its
function.


> +	.pwrap_read = pwrap_read16,
> +	.pwrap_write = pwrap_write16,
> +};
> +
>  static const struct of_device_id of_slave_match_tbl[] = {
>  	{
>  		.compatible = "mediatek,mt6323",
> @@ -1449,6 +1475,9 @@ static const struct of_device_id of_slave_match_tbl[] = {
>  		.compatible = "mediatek,mt6397",
>  		.data = &pmic_mt6397,
>  	}, {
> +		.compatible = "mediatek,mt6351",
> +		.data = &pmic_mt6351,
> +	}, {

need to be sorted din alphabetical order

>  		/* sentinel */
>  	}
>  };
