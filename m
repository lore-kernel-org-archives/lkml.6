Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754263AbeDTDnD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 23:43:03 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:20815 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754126AbeDTDnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 23:43:02 -0400
X-UUID: 1db965937d504fe59e61249bca3ef203-20180420
Message-ID: <1524195774.26454.1.camel@mtkswgap22>
Subject: Re: [PATCH v1 4/7] soc: mediatek: reuse regmap_read_poll_timeout
 helpers
From: Sean Wang <sean.wang@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
CC: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <marcel@holtmann.org>,
        <johan.hedberg@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-bluetooth@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Date: Fri, 20 Apr 2018 11:42:54 +0800
In-Reply-To: <6fd85b96-f076-36c7-8ff4-8e8ed252edb2@gmail.com>
References: <cover.1522736996.git.sean.wang@mediatek.com>
         <2f84f7695ea3223b8626a8369aa4ae5e0d03fdce.1522736996.git.sean.wang@mediatek.com>
         <6fd85b96-f076-36c7-8ff4-8e8ed252edb2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-04-19 at 12:23 +0200, Matthias Brugger wrote:
> 
> On 04/03/2018 09:15 AM, sean.wang@mediatek.com wrote:
> > From: Sean Wang <sean.wang@mediatek.com>
> > 
> > Reuse the common helpers regmap_read_poll_timeout provided by Linux core
> > instead of an open-coded handling.
> > 
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Weiyi Lu <weiyi.lu@mediatek.com>
> > ---
> >  drivers/soc/mediatek/mtk-infracfg.c | 45 +++++++++----------------------------
> >  1 file changed, 10 insertions(+), 35 deletions(-)
> > 
> > diff --git a/drivers/soc/mediatek/mtk-infracfg.c b/drivers/soc/mediatek/mtk-infracfg.c
> > index 8c310de..b849aa5 100644
> > --- a/drivers/soc/mediatek/mtk-infracfg.c
> > +++ b/drivers/soc/mediatek/mtk-infracfg.c
> > @@ -12,6 +12,7 @@
> >   */
> >  
> >  #include <linux/export.h>
> > +#include <linux/iopoll.h>
> >  #include <linux/jiffies.h>
> >  #include <linux/regmap.h>
> >  #include <linux/soc/mediatek/infracfg.h>
> > @@ -37,7 +38,6 @@
> >  int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask,
> >  		bool reg_update)
> >  {
> > -	unsigned long expired;
> >  	u32 val;
> >  	int ret;
> >  
> > @@ -47,22 +47,11 @@ int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask,
> >  	else
> >  		regmap_write(infracfg, INFRA_TOPAXI_PROTECTEN_SET, mask);
> >  
> > -	expired = jiffies + HZ;
> > +	ret = regmap_read_poll_timeout(infracfg, INFRA_TOPAXI_PROTECTSTA1,
> > +				       val, (val & mask) == mask, 10,
> > +				       jiffies_to_usecs(HZ));
> 
> To align with the changes in scpsys, please define MTK_POLL_DELAY_US and
> MTK_POLL_TIMEOUT. I'm not really fan of passing macros as function arguments.
> 

Agreed on. will have an improve on it

thanks!

> Other then that, the patch looks good.
> 
> Thanks a lot,
> Matthias
> 
> >  
> > -	while (1) {
> > -		ret = regmap_read(infracfg, INFRA_TOPAXI_PROTECTSTA1, &val);
> > -		if (ret)
> > -			return ret;
> > -
> > -		if ((val & mask) == mask)
> > -			break;
> > -
> > -		cpu_relax();
> > -		if (time_after(jiffies, expired))
> > -			return -EIO;
> > -	}
> > -
> > -	return 0;
> > +	return ret;
> >  }
> >  
> >  /**
> > @@ -80,30 +69,16 @@ int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask,
> >  int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask,
> >  		bool reg_update)
> >  {
> > -	unsigned long expired;
> >  	int ret;
> > +	u32 val;
> >  
> >  	if (reg_update)
> >  		regmap_update_bits(infracfg, INFRA_TOPAXI_PROTECTEN, mask, 0);
> >  	else
> >  		regmap_write(infracfg, INFRA_TOPAXI_PROTECTEN_CLR, mask);
> >  
> > -	expired = jiffies + HZ;
> > -
> > -	while (1) {
> > -		u32 val;
> > -
> > -		ret = regmap_read(infracfg, INFRA_TOPAXI_PROTECTSTA1, &val);
> > -		if (ret)
> > -			return ret;
> > -
> > -		if (!(val & mask))
> > -			break;
> > -
> > -		cpu_relax();
> > -		if (time_after(jiffies, expired))
> > -			return -EIO;
> > -	}
> > -
> > -	return 0;
> > +	ret = regmap_read_poll_timeout(infracfg, INFRA_TOPAXI_PROTECTSTA1,
> > +				       val, !(val & mask), 10,
> > +				       jiffies_to_usecs(HZ));
> > +	return ret;
> >  }
> > 
