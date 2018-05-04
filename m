Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751302AbeEDDES (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 23:04:18 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:44858 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751236AbeEDDEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 23:04:16 -0400
X-UUID: f68bc0debf1a401dba9b012370727092-20180504
Message-ID: <1525403052.14792.131.camel@mtkswgap22>
Subject: Re: [PATCH V4 5/8] soc: mediatek: pwrap: add pwrap for mt6797 SoCs
From: Sean Wang <sean.wang@mediatek.com>
To: Argus Lin <argus.lin@mediatek.com>
CC: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Chenglin Xu <chenglin.xu@mediatek.com>, <wsd_upstream@mediatek.com>,
        <henryc.chen@mediatek.com>, <flora.fu@mediatek.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date: Fri, 4 May 2018 11:04:12 +0800
In-Reply-To: <1525328436.6214.10.camel@mtkswgap22>
References: <20180502092112.3991-1-argus.lin@mediatek.com>
         <20180502092112.3991-6-argus.lin@mediatek.com>
         <1525320067.14792.95.camel@mtkswgap22>
         <1525328436.6214.10.camel@mtkswgap22>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-05-03 at 14:20 +0800, Argus Lin wrote:
> On Thu, 2018-05-03 at 12:01 +0800, Sean Wang wrote:
> >  };

[...]

> > > @@ -1503,11 +1581,13 @@ static int pwrap_probe(struct platform_device *pdev)
> > >  	if (IS_ERR(wrp->base))
> > >  		return PTR_ERR(wrp->base);
> > >  
> > > -	wrp->rstc = devm_reset_control_get(wrp->dev, "pwrap");
> > > -	if (IS_ERR(wrp->rstc)) {
> > > -		ret = PTR_ERR(wrp->rstc);
> > > -		dev_dbg(wrp->dev, "cannot get pwrap reset: %d\n", ret);
> > > -		return ret;
> > > +	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_RESET)) {
> > > +		wrp->rstc = devm_reset_control_get(wrp->dev, "pwrap");
> > 
> > there should be a reset bit present for pwrap on infrasys.
> > 
> > the specific condition can be dropped when the reset cell is exported from infrasys and then the device has a reference to it.
> hmm, I think it need to keep here.
> because after pwrap initialized, it can't be reset alone.
> It needs to reset PMIC simultaneously, too.

Reset a pair, either a master or its slave, all had been a part of
pwrap_init.

The reset controller provided here is just to reset pwrap device.
And for its slave reset, it should be done by pwrap_reset_spislave. 

So for MT6397, it should be able to fall into the same procedure.

> > 
> > > +		if (IS_ERR(wrp->rstc)) {
> > > +			ret = PTR_ERR(wrp->rstc);
> > > +			dev_dbg(wrp->dev, "cannot get pwrap reset: %d\n", ret);
> > > +			return ret;
> > > +		}
> > >  	}
> > >  
> > >  	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_BRIDGE)) {
> > > @@ -1549,9 +1629,17 @@ static int pwrap_probe(struct platform_device *pdev)
> > >  	if (ret)
> > >  		goto err_out1;
> > >  
> > > -	/* Enable internal dynamic clock */
> > > -	pwrap_writel(wrp, 1, PWRAP_DCM_EN);
> > > -	pwrap_writel(wrp, 0, PWRAP_DCM_DBC_PRD);
> > > +	/*
> > > +	 * add dcm capability check
> > > +	 */
> > > +	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_DCM)) {
> > 
> > the specific condition can be dropped since so far all devices the driver can support are owning PWRAP_CAP_DCM
> We did not support DCM for future chips.
> MT6797 is the last one.
> This why I want to add judgement here.

The series is only for MT6797 pwrap, so it's fine with only adding these
things the SoC actually relies on. 

PWRAP_CAP_DCM should not be added until a new SoC without dcm is really
introduced.

> > 
> > > +		if (wrp->master->type == PWRAP_MT6797)
> > > +			pwrap_writel(wrp, 3, PWRAP_DCM_EN);
> > 
> > the setup for MT6797 can be moved into .init_soc_specific callback ?
> 
> I think put it here is more generally.
> > 
> > > +		else
> > > +			pwrap_writel(wrp, 1, PWRAP_DCM_EN);
> > > +
> > > +		pwrap_writel(wrp, 0, PWRAP_DCM_DBC_PRD);
> > > +	}
> > >  
> > >  	/*
> > >  	 * The PMIC could already be initialized by the bootloader.
> > > @@ -1580,6 +1668,12 @@ static int pwrap_probe(struct platform_device *pdev)
> > >  	pwrap_writel(wrp, wrp->master->wdt_src, PWRAP_WDT_SRC_EN);
> > >  	pwrap_writel(wrp, 0x1, PWRAP_TIMER_EN);
> > >  	pwrap_writel(wrp, wrp->master->int_en_all, PWRAP_INT_EN);
> > > +	/*
> > > +	 * We add INT1 interrupt to handle starvation and request exception
> > > +	 * If we support it, we should enable them here.
> > > +	 */
> > > +	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_INT1_EN))
> > > +		pwrap_writel(wrp, wrp->master->int1_en_all, PWRAP_INT1_EN);
> > >  
> > 
> > if there is no explicitly enabling on INT1, then ISR handling for INT1 is also unnecessary
> 
> It's ok for me.
> > 
> > >  	irq = platform_get_irq(pdev, 0);
> > >  	ret = devm_request_irq(wrp->dev, irq, pwrap_interrupt,
> > 
> > 
> > 
> 
> 
