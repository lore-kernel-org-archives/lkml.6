Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751931AbeECEBS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 00:01:18 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:11979 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751674AbeECEBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 00:01:17 -0400
X-UUID: 6174f19ed85343a89abb5cddad8e4a6f-20180503
Message-ID: <1525320067.14792.95.camel@mtkswgap22>
Subject: Re: [PATCH V4 5/8] soc: mediatek: pwrap: add pwrap for mt6797 SoCs
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
Date: Thu, 3 May 2018 12:01:07 +0800
In-Reply-To: <20180502092112.3991-6-argus.lin@mediatek.com>
References: <20180502092112.3991-1-argus.lin@mediatek.com>
         <20180502092112.3991-6-argus.lin@mediatek.com>
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
> mt6797 is a highly integrated SoCs, it uses mt6351 for power
> management. We need to add pwrap support to access mt6351.
> Pwrap of mt6797 support new feature include starvation and channel
> request exception interrupt, dynamic starvation priority
> adjustment mechanism.

suggest line wrapping closely at 75 columns

> 
> Signed-off-by: Argus Lin <argus.lin@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-pmic-wrap.c | 110 ++++++++++++++++++++++++++++++++---
>  1 file changed, 102 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index a6366f147b79..0d4a2dae6912 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -284,6 +284,12 @@ enum pwrap_regs {
>  	PWRAP_DVFS_WDATA7,
>  	PWRAP_SPMINF_STA,
>  	PWRAP_CIPHER_EN,
> +
> +	/* MT6797 series regs */
> +	PWRAP_INT1_EN,
> +	PWRAP_INT1_FLG_RAW,
> +	PWRAP_INT1_FLG,
> +	PWRAP_INT1_CLR,
>  };
>  
>  static int mt2701_regs[] = {
> @@ -372,6 +378,43 @@ static int mt2701_regs[] = {
>  	[PWRAP_ADC_RDATA_ADDR2] =	0x154,
>  };
>  
> +static int mt6797_regs[] = {
> +	[PWRAP_MUX_SEL] =		0x0,
> +	[PWRAP_WRAP_EN] =		0x4,
> +	[PWRAP_DIO_EN] =		0x8,
> +	[PWRAP_SIDLY] =			0xC,
> +	[PWRAP_RDDMY] =			0x10,
> +	[PWRAP_CSHEXT_WRITE] =		0x18,
> +	[PWRAP_CSHEXT_READ] =		0x1C,
> +	[PWRAP_CSLEXT_START] =		0x20,
> +	[PWRAP_CSLEXT_END] =		0x24,
> +	[PWRAP_STAUPD_PRD] =		0x28,
> +	[PWRAP_HARB_HPRIO] =		0x50,
> +	[PWRAP_HIPRIO_ARB_EN] =		0x54,
> +	[PWRAP_MAN_EN] =		0x60,
> +	[PWRAP_MAN_CMD] =		0x64,
> +	[PWRAP_WACS0_EN] =		0x70,
> +	[PWRAP_WACS1_EN] =		0x84,
> +	[PWRAP_WACS2_EN] =		0x98,
> +	[PWRAP_INIT_DONE2] =		0x9C,
> +	[PWRAP_WACS2_CMD] =		0xA0,
> +	[PWRAP_WACS2_RDATA] =		0xA4,
> +	[PWRAP_WACS2_VLDCLR] =		0xA8,
> +	[PWRAP_INT_EN] =		0xC0,
> +	[PWRAP_INT_FLG_RAW] =		0xC4,
> +	[PWRAP_INT_FLG] =		0xC8,
> +	[PWRAP_INT_CLR] =		0xCC,
> +	[PWRAP_INT1_EN] =		0xD0,
> +	[PWRAP_INT1_FLG_RAW] =		0xD4,
> +	[PWRAP_INT1_FLG] =		0xD8,
> +	[PWRAP_INT1_CLR] =		0xDC,
> +	[PWRAP_TIMER_EN] =		0xF4,
> +	[PWRAP_WDT_UNIT] =		0xFC,
> +	[PWRAP_WDT_SRC_EN] =		0x100,
> +	[PWRAP_DCM_EN] =		0x1CC,
> +	[PWRAP_DCM_DBC_PRD] =		0x1D4,
> +};
> +

trim unused registers if any

>  static int mt7622_regs[] = {
>  	[PWRAP_MUX_SEL] =		0x0,
>  	[PWRAP_WRAP_EN] =		0x4,
> @@ -647,6 +690,7 @@ enum pmic_type {
>  
>  enum pwrap_type {
>  	PWRAP_MT2701,
> +	PWRAP_MT6797,
>  	PWRAP_MT7622,
>  	PWRAP_MT8135,
>  	PWRAP_MT8173,
> @@ -1006,6 +1050,12 @@ static void pwrap_init_chip_select_ext(struct pmic_wrapper *wrp, u8 hext_write,
>  static int pwrap_common_init_reg_clock(struct pmic_wrapper *wrp)
>  {
>  	switch (wrp->master->type) {
> +	case PWRAP_MT6797:
> +		pwrap_writel(wrp, 0x8, PWRAP_RDDMY);
> +		pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_RDDMY_NO],
> +			    0x8);
> +		pwrap_init_chip_select_ext(wrp, 0x88, 0x55, 3, 0);
> +		break;

the setup for timing is much similar to mt2701 + mt6323

so we can merge the both logic into one, and then hope to eliminate specific pwrap_mt2701_init_reg_clock totally

>  	case PWRAP_MT8173:
>  		pwrap_init_chip_select_ext(wrp, 0, 4, 2, 2);
>  		break;
> @@ -1076,11 +1126,14 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
>  		break;
>  	case PWRAP_MT2701:
>  	case PWRAP_MT8173:
> +	case PWRAP_MT6797:

need to be listed in alphabetical order

>  		pwrap_writel(wrp, 1, PWRAP_CIPHER_EN);
>  		break;
>  	case PWRAP_MT7622:
>  		pwrap_writel(wrp, 0, PWRAP_CIPHER_EN);
>  		break;
> +	default:
> +		break;
>  	}
>  
>  	/* Config cipher mode @PMIC */
> @@ -1325,6 +1378,15 @@ static irqreturn_t pwrap_interrupt(int irqno, void *dev_id)
>  
>  	pwrap_writel(wrp, 0xffffffff, PWRAP_INT_CLR);
>  
> +	/* If we support INT1 interrupt, we also need to clear it */
> +	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_INT1_EN)) {
> +		rdata = pwrap_readl(wrp, PWRAP_INT1_FLG);
> +
> +		dev_err(wrp->dev, "unexpected interrupt int1=0x%x\n", rdata);
> +
> +		pwrap_writel(wrp, rdata, PWRAP_INT1_CLR);
> +	}
> +

it seems no required to add PWRAP_CAP_INT1_EN:

the CAP is not to take any action for any INTs raised, instead, it can be disabled at initial.

>  	return IRQ_HANDLED;
>  }
>  
> @@ -1446,6 +1508,19 @@ static const struct pmic_wrapper_type pwrap_mt8173 = {
>  	.init_soc_specific = pwrap_mt8173_init_soc_specific,
>  };
>  
> +static const struct pmic_wrapper_type pwrap_mt6797 = {
> +	.regs = mt6797_regs,
> +	.type = PWRAP_MT6797,
> +	.arb_en_all = 0x01fff,
> +	.int_en_all = 0xffffffc6,
> +	.int1_en_all = 0x0001ffff,
> +	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
> +	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
> +	.caps = PWRAP_CAP_DCM | PWRAP_CAP_INT1_EN,
> +	.init_reg_clock = pwrap_common_init_reg_clock,
> +	.init_soc_specific = NULL,
> +};
> +
>  static const struct of_device_id of_pwrap_match_tbl[] = {
>  	{
>  		.compatible = "mediatek,mt2701-pwrap",
> @@ -1460,6 +1535,9 @@ static const struct of_device_id of_pwrap_match_tbl[] = {
>  		.compatible = "mediatek,mt8173-pwrap",
>  		.data = &pwrap_mt8173,
>  	}, {
> +		.compatible = "mediatek,mt6797-pwrap",
> +		.data = &pwrap_mt6797,

each entry needs to be sorted in alphabetical order

> +	}, {
>  		/* sentinel */
>  	}
>  };
> @@ -1503,11 +1581,13 @@ static int pwrap_probe(struct platform_device *pdev)
>  	if (IS_ERR(wrp->base))
>  		return PTR_ERR(wrp->base);
>  
> -	wrp->rstc = devm_reset_control_get(wrp->dev, "pwrap");
> -	if (IS_ERR(wrp->rstc)) {
> -		ret = PTR_ERR(wrp->rstc);
> -		dev_dbg(wrp->dev, "cannot get pwrap reset: %d\n", ret);
> -		return ret;
> +	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_RESET)) {
> +		wrp->rstc = devm_reset_control_get(wrp->dev, "pwrap");

there should be a reset bit present for pwrap on infrasys.

the specific condition can be dropped when the reset cell is exported from infrasys and then the device has a reference to it.

> +		if (IS_ERR(wrp->rstc)) {
> +			ret = PTR_ERR(wrp->rstc);
> +			dev_dbg(wrp->dev, "cannot get pwrap reset: %d\n", ret);
> +			return ret;
> +		}
>  	}
>  
>  	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_BRIDGE)) {
> @@ -1549,9 +1629,17 @@ static int pwrap_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_out1;
>  
> -	/* Enable internal dynamic clock */
> -	pwrap_writel(wrp, 1, PWRAP_DCM_EN);
> -	pwrap_writel(wrp, 0, PWRAP_DCM_DBC_PRD);
> +	/*
> +	 * add dcm capability check
> +	 */
> +	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_DCM)) {

the specific condition can be dropped since so far all devices the driver can support are owning PWRAP_CAP_DCM

> +		if (wrp->master->type == PWRAP_MT6797)
> +			pwrap_writel(wrp, 3, PWRAP_DCM_EN);

the setup for MT6797 can be moved into .init_soc_specific callback ?

> +		else
> +			pwrap_writel(wrp, 1, PWRAP_DCM_EN);
> +
> +		pwrap_writel(wrp, 0, PWRAP_DCM_DBC_PRD);
> +	}
>  
>  	/*
>  	 * The PMIC could already be initialized by the bootloader.
> @@ -1580,6 +1668,12 @@ static int pwrap_probe(struct platform_device *pdev)
>  	pwrap_writel(wrp, wrp->master->wdt_src, PWRAP_WDT_SRC_EN);
>  	pwrap_writel(wrp, 0x1, PWRAP_TIMER_EN);
>  	pwrap_writel(wrp, wrp->master->int_en_all, PWRAP_INT_EN);
> +	/*
> +	 * We add INT1 interrupt to handle starvation and request exception
> +	 * If we support it, we should enable them here.
> +	 */
> +	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_INT1_EN))
> +		pwrap_writel(wrp, wrp->master->int1_en_all, PWRAP_INT1_EN);
>  

if there is no explicitly enabling on INT1, then ISR handling for INT1 is also unnecessary

>  	irq = platform_get_irq(pdev, 0);
>  	ret = devm_request_irq(wrp->dev, irq, pwrap_interrupt,
