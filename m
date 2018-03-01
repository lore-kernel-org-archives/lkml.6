Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965798AbeCADsP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 22:48:15 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:34227 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S965674AbeCADsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 22:48:13 -0500
X-UUID: 81c265c3520b45b49a5f84a667465b38-20180301
Message-ID: <1519876072.23198.17.camel@mhfsdcap03>
Subject: Re: [PATCH v2 4/4] pintcrl: support bias-disable of generic and
 special pins simultaneously
From: Zhiyong Tao <zhiyong.tao@mediatek.com>
To: Sean Wang <sean.wang@mediatek.com>
CC: <robh+dt@kernel.org>, <linus.walleij@linaro.org>,
        <mark.rutland@arm.com>, <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <hongkun.cao@mediatek.com>,
        <srv_heupstream@mediatek.com>, <linux-gpio@vger.kernel.org>,
        <biao.huang@mediatek.com>, <erin.lo@mediatek.com>,
        <liguo.zhang@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <hongzhou.yang@mediatek.com>, <linux-mediatek@lists.infradead.org>,
        <yingjoe.chen@mediatek.com>, <linux-arm-kernel@lists.infradead.org>
Date: Thu, 1 Mar 2018 11:47:52 +0800
In-Reply-To: <1519804157.23198.9.camel@mhfsdcap03>
References: <1519634042-12063-1-git-send-email-zhiyong.tao@mediatek.com>
         <1519634042-12063-5-git-send-email-zhiyong.tao@mediatek.com>
         <1519803217.8089.31.camel@mtkswgap22> <1519804157.23198.9.camel@mhfsdcap03>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-02-28 at 15:49 +0800, Zhiyong Tao wrote:
> On Wed, 2018-02-28 at 15:33 +0800, Sean Wang wrote:
> > On Mon, 2018-02-26 at 16:34 +0800, Zhiyong Tao wrote:
> > > For generic pins, parameter "arg" is 0 or 1.
> > > For special pins, bias-disable is set by R0R1,
> > > so we need transmited "00" to set bias-disable
> > > When we set "bias-disable" as high-z property,
> > > the parameter should be "MTK_PUPD_SET_R1R0_00".
> > > 
> > > Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > > ---
> > >  drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 13 +++++++++++--
> > >  1 file changed, 11 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> > > index 3cf384f..e88ba04 100644
> > > --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> > > +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> > > @@ -301,8 +301,17 @@ static int mtk_pconf_set_pull_select(struct mtk_pinctrl *pctl,
> > >  	 * resistor bit, so we need this special handle.
> > >  	 */
> > >  	if (pctl->devdata->spec_pull_set) {
> > > -		ret = pctl->devdata->spec_pull_set(mtk_get_regmap(pctl, pin),
> > > -			pin, pctl->devdata->port_align, isup, arg);
> > > +		if (enable) {
> > > +			ret = pctl->devdata->spec_pull_set(
> > > +				mtk_get_regmap(pctl, pin), pin,
> > > +				pctl->devdata->port_align, isup,
> > > +				arg);
> > > +		} else {
> > > +			ret = pctl->devdata->spec_pull_set(
> > > +				mtk_get_regmap(pctl, pin), pin,
> > > +				pctl->devdata->port_align, isup,
> > > +				MTK_PUPD_SET_R1R0_00);
> > > +		}
> > 
> > 
> > it looks like you can use as following snippet with reusing original
> > logic and less effort on maintaining these common code (?)
> ==> Thanks for your suggestion very much. It seems better.
> I will change it in v3.

==>
 Hi sean,

we try it in our site. we can't change like this.
Because we will check "arg" after setting "arg = MTK_PUPD_SET_R1R0_00;".
following snippet which check "arg" value is o or 1. If it not, which
will print error. so we can't change like this.
/* For generic pull config, default arg value should be 0 or 1. */
if (arg != 0 && arg != 1) {
	dev_err(pctl->dev, "invalid pull-up argument %d on pin %d .\n", arg,
pin);
	return -EINVAL;
}

Thanks.
> > 
> > 
> > if (pctl->devdata->spec_pull_set) {
> > 	+ if (!enable)
> > 	+ 	arg = MTK_PUPD_SET_R1R0_00;
> > 
> > 	ret = pctl->devdata->spec_pull_set(mtk_get_regmap(pctl, pin),
> > 		pin, pctl->devdata->port_align, isup, arg);
> > 
> > 
> > Also, it's better to add more comments to such kind of special path for
> > allowing future SoCs to follow and extend more easily.
> 
> ==> Thanks for your suggestion very much. I will add more comments here.
> > 
> > >  		if (!ret)
> > >  			return 0;
> > >  	}
> > 
> > 
> 
