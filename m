Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBBDECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D0D2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:47:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9D0D2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731098AbeGRKYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:24:35 -0400
Received: from foss.arm.com ([217.140.101.70]:59284 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729126AbeGRKYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:24:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDE8780D;
        Wed, 18 Jul 2018 02:47:30 -0700 (PDT)
Received: from red-moon (red-moon.cambridge.arm.com [10.1.206.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5E103F318;
        Wed, 18 Jul 2018 02:47:27 -0700 (PDT)
Date:   Wed, 18 Jul 2018 10:49:24 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Honghui Zhang <honghui.zhang@mediatek.com>
Cc:     marc.zyngier@arm.com, bhelgaas@google.com, matthias.bgg@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        ryder.lee@mediatek.com, hongkun.cao@mediatek.com,
        youlin.pei@mediatek.com, yong.wu@mediatek.com,
        yt.shen@mediatek.com, sean.wang@mediatek.com, rjw@rjwysocki.net,
        khilman@kernel.org, ulf.hansson@linaro.org
Subject: Re: [PATCH v3 3/4] PCI: mediatek: Add system pm support for MT2712
 and MT7622
Message-ID: <20180718094924.GA21463@red-moon>
References: <1530518264-6125-1-git-send-email-honghui.zhang@mediatek.com>
 <1530518264-6125-4-git-send-email-honghui.zhang@mediatek.com>
 <20180717171543.GA20991@red-moon>
 <1531893761.31406.15.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531893761.31406.15.camel@mhfsdcap03>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 02:02:41PM +0800, Honghui Zhang wrote:

<snip>

> > > +static int __maybe_unused mtk_pcie_resume_noirq(struct device *dev)
> > > +{
> > > +	struct mtk_pcie *pcie = dev_get_drvdata(dev);
> > > +	const struct mtk_pcie_soc *soc = pcie->soc;
> > > +	struct mtk_pcie_port *port, *tmp;
> > > +
> > > +	if (!soc->pm_support)
> > > +		return 0;
> > > +
> > > +	if (list_empty(&pcie->ports))
> > > +		return 0;
> > > +
> > > +	if (dev->pm_domain) {
> > > +		pm_runtime_enable(dev);
> > > +		pm_runtime_get_sync(dev);
> > > +	}
> > 
> > Are these runtime PM calls needed/abused here ?
> > 
> > Mind explaining the logic ?
> > 
> > There is certainly an asymmetry with the suspend callback which made me
> > suspicious, I am pretty certain Rafael/Kevin/Ulf can help me clarify so
> > that we can make progress with this patch.
> > 
> > Lorenzo
> > 
> Hi Lorenzo, thanks for your comments.
> Sorry I don't get you.
> I believe that in suspend callbacks the pm_runtime_put_sync and
> pm_runtime_disable should be called to gated the CMOS for this module,
> while the pm_rumtime_enable and pm_rumtime_get_sync should be called
> in resume callback.

That's why I CC'ed Rafael, Kevin and Ulf, to answer this question
thoroughly, I am not sure it is needed and that's the right way
of doing it in system suspend callbacks.

> That's exactly this patch doing.
> But the pm_rumtime_put_sync and pm_runtime_disable functions was wrapped
> in the mtk_pcie_subsys_powerdown.

Ah, sorry, I missed that.

> I did not call mtk_pcie_subsys_powerup since it does not just wrapped
> pm_rumtime related functions but also do the platform_resource_get,
> devm_ioremap, and free_ck clock get which I do not needed in resume
> callback.
> 
> Do you think it will be much clear if I abstract the
> platform_resource_get, devm_ioremap functions from
> mtk_pcie_subsys_powerup and put it to a new functions like
> mtk_pcie_subsys_resource_get, and then we may call the
> mtk_pcie_subsys_powerup in the resume function?

I think so but let's wait first for feedback on whether those
runtime PM calls are needed in the first place.

Lorenzo
