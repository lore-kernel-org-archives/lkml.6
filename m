Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750904AbeCZEHy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 00:07:54 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:38741 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750713AbeCZEHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 00:07:52 -0400
X-UUID: 3ef8356837a84ec982a10f41a722de32-20180326
Message-ID: <1522037265.18424.14.camel@mtkswgap22>
Subject: Re: [PATCH v1 09/16] rtc: mediatek: convert to use device managed
 functions
From: Sean Wang <sean.wang@mediatek.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <sre@kernel.org>,
        <lee.jones@linaro.org>, <a.zummo@towertech.it>,
        <eddie.huang@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Date: Mon, 26 Mar 2018 12:07:45 +0800
In-Reply-To: <20180323105017.GI3417@piout.net>
References: <cover.1521794176.git.sean.wang@mediatek.com>
         <fbfb1852838820c198d55bc74940a74f1d0b53ed.1521794177.git.sean.wang@mediatek.com>
         <20180323105017.GI3417@piout.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23742.001
X-TM-AS-Result: No-16.411000-8.000000-10
X-TMASE-MatchedRID: y/2oPz6gbvgOwH4pD14DsPHkpkyUphL9+Vb3woyMZbue9toQ6h6LExRE
        XZwhDuFxsDSpqyZY4zQkFyQegp0Snp7oe7OF0U2WEhGH3CRdKUXSde/CNbaZJSAWlErg1VlPjmK
        ERq7fTSFOJB5wP1oqhFJaDhgFzZsBqH7dGVt6/4nKl4yJoI+fG9O4VcbrqWuqTUobVis5Bb+wV7
        nfUWvsNMrqJH3Kw4BA118ZC33GdOuny6BdO4dlIWA/V00XWjDtwx0jRRxcQfNtPXRTHBlYsEBIC
        Rren7xC4ImvYyRqEBzl2rMeR1tlaPGU4m5A0eV9ngIgpj8eDcC063Wh9WVqgtZE3xJMmmXc+gtH
        j7OwNO0CpgETeT0ynA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.411000-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23742.001
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-03-23 at 11:50 +0100, Alexandre Belloni wrote:
> On 23/03/2018 at 17:15:06 +0800, sean.wang@mediatek.com wrote:
> > From: Sean Wang <sean.wang@mediatek.com>
> > 
> > Use device managed operation to simplify error handling, reduce source
> > code size, and reduce the likelyhood of bugs, and remove our removal
> > callback which contains anything already done by device managed functions.
> > 
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > ---
> >  drivers/rtc/rtc-mt6397.c | 31 ++++++++-----------------------
> >  1 file changed, 8 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
> > index cefb83b..bfc5d6f 100644
> > --- a/drivers/rtc/rtc-mt6397.c
> > +++ b/drivers/rtc/rtc-mt6397.c
> > @@ -14,6 +14,7 @@
> >  
> >  #include <linux/delay.h>
> >  #include <linux/init.h>
> > +#include <linux/interrupt.h>
> >  #include <linux/module.h>
> >  #include <linux/regmap.h>
> >  #include <linux/rtc.h>
> > @@ -328,10 +329,10 @@ static int mtk_rtc_probe(struct platform_device *pdev)
> >  
> >  	platform_set_drvdata(pdev, rtc);
> >  
> > -	ret = request_threaded_irq(rtc->irq, NULL,
> > -				   mtk_rtc_irq_handler_thread,
> > -				   IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
> > -				   "mt6397-rtc", rtc);
> > +	ret = devm_request_threaded_irq(&pdev->dev, rtc->irq, NULL,
> > +					mtk_rtc_irq_handler_thread,
> > +					IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
> > +					"mt6397-rtc", rtc);
> >  	if (ret) {
> >  		dev_err(&pdev->dev, "Failed to request alarm IRQ: %d: %d\n",
> >  			rtc->irq, ret);
> > @@ -340,30 +341,15 @@ static int mtk_rtc_probe(struct platform_device *pdev)
> >  
> >  	device_init_wakeup(&pdev->dev, 1);
> >  
> > -	rtc->rtc_dev = rtc_device_register("mt6397-rtc", &pdev->dev,
> > -					   &mtk_rtc_ops, THIS_MODULE);
> > +	rtc->rtc_dev = devm_rtc_device_register(&pdev->dev, "mt6397-rtc",
> > +						&mtk_rtc_ops, THIS_MODULE);
> 
> You should probably switch to devm_rtc_allocate_device() and
> rtc_register_device instead of devm_rtc_device_register.
> 

Just would like to know something details

It seems you just encourage me to switch into the new registration
method and currently devm_rtc_device_register I used for the driver
shouldn't cause any harm. right?

> >  	if (IS_ERR(rtc->rtc_dev)) {
> >  		dev_err(&pdev->dev, "register rtc device failed\n");
> >  		ret = PTR_ERR(rtc->rtc_dev);
> > -		goto out_free_irq;
> > +		return ret;
> 
> ret doesn't seem necessary anymore here.


okay, it'll be removed

> 
> 
