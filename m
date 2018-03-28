Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752572AbeC1JTr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 05:19:47 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51563 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751840AbeC1JTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 05:19:44 -0400
Date: Wed, 28 Mar 2018 11:19:41 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Sean Wang <sean.wang@mediatek.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org,
        lee.jones@linaro.org, a.zummo@towertech.it, eddie.huang@mediatek.com,
        devicetree@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 02/16] dt-bindings: rtc: mediatek: add bindings for
 PMIC RTC
Message-ID: <20180328091941.GB13942@piout.net>
References: <cover.1521794176.git.sean.wang@mediatek.com>
 <5846e8be319c4836808c8127d5bb51b7e999e896.1521794177.git.sean.wang@mediatek.com>
 <20180323094118.GC3417@piout.net>
 <20180323101505.GF3417@piout.net>
 <1521920188.31197.13.camel@mtkswgap22>
 <20180327151848.GD22441@piout.net>
 <1522209197.18424.26.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522209197.18424.26.camel@mtkswgap22>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2018 at 11:53:17 +0800, Sean Wang wrote:
> On Tue, 2018-03-27 at 17:18 +0200, Alexandre Belloni wrote:
> > On 25/03/2018 at 03:36:28 +0800, Sean Wang wrote:
> > > just reply both replies in the same mail
> > > 
> > > 1.) the power-off device is a part of rtc, use the same registers rtc
> > > has and thus it is put as child nodes under the node rtc to reflect the
> > > reality of characteristics the rtc has.
> > > 
> > > Or am I wrong for a certain aspect in these opinions?
> > > 
> > 
> > My point is that it is also part of the PMIC so it may as well be
> > registers from the mfd driver which already registers a bunch of devices
> > instead of doing unusual stuff from the rtc driver.
> > 
> > mt6397_rtc->regmap is mt6397_chip->regmap anyway. You have the added
> > benefit that if the RTC driver probe fails for some reason, you may
> > still be able to probe the reset driver.
> > 
> > I don't tink there is any benefit having it as a child of the rtc
> > device.
> > 
> 
> 
> really thanks! it's an optional solution I thought it 's fine and worth
> doing
> 
> but so far I cannot fully make sure of whether mfd can accept two
> devices holding overlay IORESOURCE_MEM.
> 

There is no overlay because you are using a regmap which handles
concurrency for you.

What your patch is doing is:

struct mt6397_rtc *rtc = dev_get_drvdata(pdev->dev.parent);

then you use rtc->regmap

But in the rtc driver, you have:

struct mt6397_chip *mt6397_chip = dev_get_drvdata(pdev->dev.parent);
struct mt6397_rtc *rtc;

rtc->regmap = mt6397_chip->regmap;

So there is no benefit from being the child of the rtc, you could just
do the following in your reset driver:

struct mt6397_chip *mt6397_chip = dev_get_drvdata(pdev->dev.parent);

and then use mt6397_chip->regmap.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
