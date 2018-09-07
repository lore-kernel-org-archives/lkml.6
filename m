Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9568C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A14C32077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:43:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A14C32077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbeIGOXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:23:45 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:22301 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726032AbeIGOXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:23:44 -0400
X-UUID: 3f9ffb336a1946b597a94aeb8c2276fa-20180907
Received: from mtkcas35.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1791854448; Fri, 07 Sep 2018 17:43:32 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Fri, 7 Sep
 2018 17:43:31 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Fri, 7 Sep 2018 17:43:30 +0800
Message-ID: <1536313410.31406.30.camel@mhfsdcap03>
Subject: Re: [PATCH v3 3/4] PCI: mediatek: Add system pm support for MT2712
 and MT7622
From:   Honghui Zhang <honghui.zhang@mediatek.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, <rjw@rjwysocki.net>,
        <khilman@kernel.org>, <ulf.hansson@linaro.org>
CC:     <weiyi.lu@mediatek.com>, <chen.zhong@mediatek.com>,
        <marc.zyngier@arm.com>, <bhelgaas@google.com>,
        <matthias.bgg@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <ryder.lee@mediatek.com>, <hongkun.cao@mediatek.com>,
        <youlin.pei@mediatek.com>, <yong.wu@mediatek.com>,
        <yt.shen@mediatek.com>, <sean.wang@mediatek.com>,
        <rjw@rjwysocki.net>, <khilman@kernel.org>, <ulf.hansson@linaro.org>
Date:   Fri, 7 Sep 2018 17:43:30 +0800
In-Reply-To: <20180718094924.GA21463@red-moon>
References: <1530518264-6125-1-git-send-email-honghui.zhang@mediatek.com>
         <1530518264-6125-4-git-send-email-honghui.zhang@mediatek.com>
         <20180717171543.GA20991@red-moon> <1531893761.31406.15.camel@mhfsdcap03>
         <20180718094924.GA21463@red-moon>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-18 at 10:49 +0100, Lorenzo Pieralisi wrote:
> On Wed, Jul 18, 2018 at 02:02:41PM +0800, Honghui Zhang wrote:
> 
> <snip>
> 
> > > > +static int __maybe_unused mtk_pcie_resume_noirq(struct device *dev)
> > > > +{
> > > > +	struct mtk_pcie *pcie = dev_get_drvdata(dev);
> > > > +	const struct mtk_pcie_soc *soc = pcie->soc;
> > > > +	struct mtk_pcie_port *port, *tmp;
> > > > +
> > > > +	if (!soc->pm_support)
> > > > +		return 0;
> > > > +
> > > > +	if (list_empty(&pcie->ports))
> > > > +		return 0;
> > > > +
> > > > +	if (dev->pm_domain) {
> > > > +		pm_runtime_enable(dev);
> > > > +		pm_runtime_get_sync(dev);
> > > > +	}
> > > 
> > > Are these runtime PM calls needed/abused here ?
> > > 
> > > Mind explaining the logic ?
> > > 
> > > There is certainly an asymmetry with the suspend callback which made me
> > > suspicious, I am pretty certain Rafael/Kevin/Ulf can help me clarify so
> > > that we can make progress with this patch.
> > > 
> > > Lorenzo
> > > 
> > Hi Lorenzo, thanks for your comments.
> > Sorry I don't get you.
> > I believe that in suspend callbacks the pm_runtime_put_sync and
> > pm_runtime_disable should be called to gated the CMOS for this module,
> > while the pm_rumtime_enable and pm_rumtime_get_sync should be called
> > in resume callback.

> That's why I CC'ed Rafael, Kevin and Ulf, to answer this question
> thoroughly, I am not sure it is needed and that's the right way
> of doing it in system suspend callbacks.
> 

hi, Rafael, Kevin and Ulf,

after reading of the power related documents in Documents/power/, I'm
still confused whether the runtime_pm callbacks should be called in
system suspend callbacks.

I believe that system suspend does not care about the device's CMOS
status. And the device's CMOS status is controlled by runtime pm.
That why I gated the CMOS through runtime pm in the system suspend
callbacks.

But I checked all existing system suspend callbacks and found there's no
runtime pm was executed in system suspend callbacks. Does that means
when system suspend, the system suspend framework does not care about
the power consume? Or does it gated each device's CMOS in somewhere
else?

Or should I just remove the runtime pm callbacks in the system suspend
flow?

Could someone kindly give me some comments?

Thanks in advance.

> > That's exactly this patch doing.
> > But the pm_rumtime_put_sync and pm_runtime_disable functions was wrapped
> > in the mtk_pcie_subsys_powerdown.
> 
> Ah, sorry, I missed that.
> 
> > I did not call mtk_pcie_subsys_powerup since it does not just wrapped
> > pm_rumtime related functions but also do the platform_resource_get,
> > devm_ioremap, and free_ck clock get which I do not needed in resume
> > callback.
> > 
> > Do you think it will be much clear if I abstract the
> > platform_resource_get, devm_ioremap functions from
> > mtk_pcie_subsys_powerup and put it to a new functions like
> > mtk_pcie_subsys_resource_get, and then we may call the
> > mtk_pcie_subsys_powerup in the resume function?
> 
> I think so but let's wait first for feedback on whether those
> runtime PM calls are needed in the first place.
> 
> Lorenzo


