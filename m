Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751912AbeCWJoe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 05:44:34 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:27319 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750789AbeCWJoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 05:44:32 -0400
X-UUID: beffa107f12e4b25a610c4e448fdc6ce-20180323
Message-ID: <1521798262.28226.12.camel@mtkswgap22>
Subject: Re: [PATCH v4 4/5] pintcrl: support bias-disable of generic and
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
Date: Fri, 23 Mar 2018 17:44:22 +0800
In-Reply-To: <1521687523-1604-5-git-send-email-zhiyong.tao@mediatek.com>
References: <1521687523-1604-1-git-send-email-zhiyong.tao@mediatek.com>
         <1521687523-1604-5-git-send-email-zhiyong.tao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23736.005
X-TM-AS-Result: No-8.294700-8.000000-10
X-TMASE-MatchedRID: +c13yJDs9016DVqDv3PkveKXIfYoQh97jLOy13Cgb4+iUP5F9sCEMAJj
        LDMzzZnzvc7C3gy8W89iSVnIdboij5Coy9iDotiw2Ud/1nepkpOZ2scyRQcer9vpj5+dNlQvezY
        C/kiT9SZBy76K08Yp1Uoy5WLoLWsKTX7PJ/OU3vKDGx/OQ1GV8rHlqZYrZqdI+gtHj7OwNO1/FU
        QjcNJIg6gO76/Uu0kPfzHD7texLIG71Xng+2qL1RQc0V8V6TO6C2eA6MOI5eE7bU7W+0S4QAO7O
        crK3BRIKuayjtbtUMvKGt2hOkaVr67hrSPr/veNEVQxz6vAprzRXFNhnxxSrFC5mAq4+G1LwL6S
        xPpr1/I=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.294700-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23736.005
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-22 at 10:58 +0800, Zhiyong Tao wrote:
> For generic pins, parameter "arg" is 0 or 1.
> For special pins, bias-disable is set by R0R1,
> so we need transmited "00" to set bias-disable
> When we set "bias-disable" as high-z property,
> the parameter should be "MTK_PUPD_SET_R1R0_00".
> 
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> ---
>  drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> index 3cf384f..f991ff3 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> @@ -293,7 +293,7 @@ static int mtk_pconf_set_pull_select(struct mtk_pinctrl *pctl,
>  		unsigned int pin, bool enable, bool isup, unsigned int arg)
>  {
>  	unsigned int bit;
> -	unsigned int reg_pullen, reg_pullsel;
> +	unsigned int reg_pullen, reg_pullsel, r1r0;
>  	int ret;
>  
>  	/* Some pins' pull setting are very different,
> @@ -301,8 +301,12 @@ static int mtk_pconf_set_pull_select(struct mtk_pinctrl *pctl,
>  	 * resistor bit, so we need this special handle.
>  	 */
>  	if (pctl->devdata->spec_pull_set) {
> +		/* For special pins, bias-disable is set by R1R0,
> +		 * the parameter should be "MTK_PUPD_SET_R1R0_00".
> +		 */
> +		r1r0 = enable ? arg : MTK_PUPD_SET_R1R0_00;
>  		ret = pctl->devdata->spec_pull_set(mtk_get_regmap(pctl, pin),
> -			pin, pctl->devdata->port_align, isup, arg);
> +			pin, pctl->devdata->port_align, isup, r1r0);
>  		if (!ret)
>  			return 0;
>  	}

Reviewed-by: Sean Wang <sean.wang@mediatek.com>
