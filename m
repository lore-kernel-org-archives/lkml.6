Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752107AbeA3Mzx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 07:55:53 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35733 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751609AbeA3Mzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 07:55:51 -0500
X-Google-Smtp-Source: AH8x224od1/9ArMDTGR1TXDTSF9HWWxVakgTp65cBAQjUk0PlmKDXslexXF/zLZUhWUViiBHEL46pw==
Subject: Re: [PATCH v2 3/5] soc: mediatek: pwrap: add int1_en_all and
 capability flag
To: argus.lin@mediatek.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc: Chenglin Xu <chenglin.xu@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, wsd_upstream@mediatek.com,
        henryc.chen@mediatek.com, flora.fu@mediatek.com,
        Chen Zhong <chen.zhong@mediatek.com>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        "shailendra . v" <shailendra.v@samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20180129090944.28687-1-argus.lin@mediatek.com>
 <20180129090944.28687-3-argus.lin@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <3f4ce745-32e0-2ae6-1463-af041d608d8c@gmail.com>
Date: Tue, 30 Jan 2018 13:55:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180129090944.28687-3-argus.lin@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/29/2018 10:09 AM, argus.lin@mediatek.com wrote:
> From: Argus Lin <argus.lin@mediatek.com>
> 
> New pwrap support int1_en flag for starvation and channel
> request exception. We need to register it for interrupt
> handler.
> We also add pwrap capability flag used to declare if we

"We also" wording is nearly always a hint, that this should be done
in two independent patches.

> support BRIDGE, RESET, DCM, PRIORITY_SEL and INT1_EN
> or not.
> 
> Signed-off-by: Argus Lin <argus.lin@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-pmic-wrap.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index e9e054a15b7d..9f924d3f8645 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -76,6 +76,13 @@
>  #define PWRAP_SLV_CAP_SECURITY	BIT(2)
>  #define HAS_CAP(_c, _x)	(((_c) & (_x)) == (_x))
>  
> +/* Group of bits used for shown pwrap capability */
> +#define PWRAP_CAP_BRIDGE	BIT(0)
> +#define PWRAP_CAP_RESET		BIT(1)
> +#define PWRAP_CAP_DCM		BIT(2)

As you told me the driver will be upstreamed in April, please add this flag when
you upstream the driver, as this will be in a different kernel version.

> +#define PWRAP_CAP_PRIORITY_SEL	BIT(3)
> +#define PWRAP_CAP_INT1_EN	BIT(4)
> +

Add each flag when you add the user of the flag.

>  /* defines for slave device wrapper registers */
>  enum dew_regs {
>  	PWRAP_DEW_BASE,
> @@ -681,9 +688,11 @@ struct pmic_wrapper_type {
>  	enum pwrap_type type;
>  	u32 arb_en_all;
>  	u32 int_en_all;
> +	u32 int1_en_all;
>  	u32 spi_w;
>  	u32 wdt_src;
> -	unsigned int has_bridge:1;
> +	/* Flags indicating the capability for the target pwrap */
> +	u32 caps;

NAK, this will not compile. Please make sure that every patch on it's own does
not break compilation.

Regards,
Matthias

>  	int (*init_reg_clock)(struct pmic_wrapper *wrp);
>  	int (*init_soc_specific)(struct pmic_wrapper *wrp);
>  };
> -- 
> 2.12.5
> 
> ************* Email Confidentiality Notice
>  ********************
> The information contained in this e-mail message (including any 
> attachments) may be confidential, proprietary, privileged, or otherwise
> exempt from disclosure under applicable laws. It is intended to be 
> conveyed only to the designated recipient(s). Any use, dissemination, 
> distribution, printing, retaining or copying of this e-mail (including its 
> attachments) by unintended recipient(s) is strictly prohibited and may 
> be unlawful. If you are not an intended recipient of this e-mail, or believe
>  
> that you have received this e-mail in error, please notify the sender 
> immediately (by replying to this e-mail), delete any and all copies of 
> this e-mail (including any attachments) from your system, and do not
> disclose the content of this e-mail to any other person. Thank
>  you!
> 
