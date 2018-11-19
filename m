Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747C1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4711E208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:14:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4711E208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406805AbeKTDib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:38:31 -0500
Received: from muru.com ([72.249.23.125]:54492 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406744AbeKTDia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:38:30 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A386D80B6;
        Mon, 19 Nov 2018 17:14:10 +0000 (UTC)
Date:   Mon, 19 Nov 2018 09:14:06 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Belisko Marek <marek.belisko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org,
        "Dr. H. Nikolaus Schaller" <hns@goldelico.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
Subject: Re: omap5 fixing palmas IRQ_TYPE_NONE warning leads to gpadc timeouts
Message-ID: <20181119171406.GQ53235@atomide.com>
References: <CAAfyv35bat+t6awL-VRigAoaUTySwOgZkQMs=W9mEKQ6VDW3FA@mail.gmail.com>
 <20180703084516.GT112168@atomide.com>
 <CAAfyv37F1s8Cg=pfxiN0dA6YEX7KMB-+uifjRoqAdKGWLeYEwA@mail.gmail.com>
 <20181113180656.GE53235@atomide.com>
 <46d271b2-35d3-6353-c530-3292cdac53ab@ti.com>
 <20181119161906.GP53235@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119161906.GP53235@atomide.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Tony Lindgren <tony@atomide.com> [181119 16:19]:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [181119 10:16]:
> > On 2018-11-13 20:06, Tony Lindgren wrote:
> > > Looks like the IRQ_TYPE_NONE issue still is there for omap5 and
> > > should be fixed with IRQ_TYPE_HIGH.
> > > 
> > > No idea about why palmas interrupts would stop working though,
> > > Peter, do you have any ideas on this one?
> > 
> > No, I don't.
> > The INT polarity can be changed in Palmas.
> > based on the pdata->irq_flags (queried via irqd_get_trigger_type())
> > the code  configures it:
> > 
> > if (pdata->irq_flags & IRQ_TYPE_LEVEL_HIGH)
> > 	reg = PALMAS_POLARITY_CTRL_INT_POLARITY;
> > else
> > 	reg = 0;
> > 
> > and we pass the same irq_flags to the regmap_add_irq_chip()
> > IRQ_TYPE_LEVEL_HIGH == IRQF_TRIGGER_HIGH == 0x00000004
> > 
> > A change in DT should be enough, no need to patch palmas.c, imho.
> 
> But it's not. I'm now wondering if wakeupgen is inverting the
> polarity for this interrupt?
> 
> GIC docs say this about SPI interrupts:
> 
> "SPI is triggered on a rising edge or is active-HIGH level-sensitive."
> 
> So when setting IRQ_TYPE_LEVEL_HIGH in dts, we still must not
> invert the polarity in palmas while tegra needs to. So either
> tegra114 hardware is inverting the polarity, or omap5 wakeupgen
> is.
> 
> Does the palmas trm say which way PALMAS_POLARITY_CTRL
> triggers if PALMAS_POLARITY_CTRL_INT_POLARITY is set?
> 
> Also note that dra7 is using a gpio for palmas interrupt.

Well so commit 7e9d474954f4 ("ARM: tegra: Correct polarity for
Tegra114 PMIC interrupt") states that tegra114 inverts the
polarity of the PMIC interrupt. So adding Jon and Thierry to Cc.

So it seems that commit df545d1cd01a ("mfd: palmas: Provide
irq flags through DT/platform data") wrongly sets the
PALMAS_POLARITY_CTRL_INT_POLARITY on IRQ_TYPE_LEVEL_HIGH
while it should set it on IRQ_TYPE_LEVEL_LOW.

I think the fix needs to set the polarity using
of_machine_is_compatible() and probably also add a new
compatible to palmas.c for "ti,palmas-tegra114" to properly
deal with the inverted interrupt. Or add a property for
"interrupt-inverted". In any case, it seems that the
of_machine_is_compatible() is also needed too to avoid
breaking use with dtb files.

Jon & Thierry, can you guys please check and confirm this?

Regards,

Tony
