Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751868AbeB1Hdm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 02:33:42 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:47894 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751080AbeB1Hdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 02:33:41 -0500
X-UUID: 00f26e0338f84449b33d4b83d486e804-20180228
Message-ID: <1519803217.8089.31.camel@mtkswgap22>
Subject: Re: [PATCH v2 4/4] pintcrl: support bias-disable of generic and
 special pins simultaneously
From: Sean Wang <sean.wang@mediatek.com>
To: Zhiyong Tao <zhiyong.tao@mediatek.com>
CC: <robh+dt@kernel.org>, <linus.walleij@linaro.org>,
        <mark.rutland@arm.com>, <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <hongkun.cao@mediatek.com>,
        <srv_heupstream@mediatek.com>, <linux-gpio@vger.kernel.org>,
        <biao.huang@mediatek.com>, <erin.lo@mediatek.com>,
        <liguo.zhang@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <hongzhou.yang@mediatek.com>, <linux-mediatek@lists.infradead.org>,
        <yingjoe.chen@mediatek.com>, <linux-arm-kernel@lists.infradead.org>
Date: Wed, 28 Feb 2018 15:33:37 +0800
In-Reply-To: <1519634042-12063-5-git-send-email-zhiyong.tao@mediatek.com>
References: <1519634042-12063-1-git-send-email-zhiyong.tao@mediatek.com>
         <1519634042-12063-5-git-send-email-zhiyong.tao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-02-26 at 16:34 +0800, Zhiyong Tao wrote:
> For generic pins, parameter "arg" is 0 or 1.
> For special pins, bias-disable is set by R0R1,
> so we need transmited "00" to set bias-disable
> When we set "bias-disable" as high-z property,
> the parameter should be "MTK_PUPD_SET_R1R0_00".
> 
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> ---
>  drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> index 3cf384f..e88ba04 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> @@ -301,8 +301,17 @@ static int mtk_pconf_set_pull_select(struct mtk_pinctrl *pctl,
>  	 * resistor bit, so we need this special handle.
>  	 */
>  	if (pctl->devdata->spec_pull_set) {
> -		ret = pctl->devdata->spec_pull_set(mtk_get_regmap(pctl, pin),
> -			pin, pctl->devdata->port_align, isup, arg);
> +		if (enable) {
> +			ret = pctl->devdata->spec_pull_set(
> +				mtk_get_regmap(pctl, pin), pin,
> +				pctl->devdata->port_align, isup,
> +				arg);
> +		} else {
> +			ret = pctl->devdata->spec_pull_set(
> +				mtk_get_regmap(pctl, pin), pin,
> +				pctl->devdata->port_align, isup,
> +				MTK_PUPD_SET_R1R0_00);
> +		}


it looks like you can use as following snippet with reusing original
logic and less effort on maintaining these common code (?)


if (pctl->devdata->spec_pull_set) {
	+ if (!enable)
	+ 	arg = MTK_PUPD_SET_R1R0_00;

	ret = pctl->devdata->spec_pull_set(mtk_get_regmap(pctl, pin),
		pin, pctl->devdata->port_align, isup, arg);


Also, it's better to add more comments to such kind of special path for
allowing future SoCs to follow and extend more easily.

>  		if (!ret)
>  			return 0;
>  	}
