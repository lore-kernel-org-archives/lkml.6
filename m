Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5F4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD85205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AD85205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbeK0G1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:27:24 -0500
Received: from muru.com ([72.249.23.125]:55254 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbeK0G1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 01:27:24 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 64D458068;
        Mon, 26 Nov 2018 19:32:17 +0000 (UTC)
Date:   Mon, 26 Nov 2018 11:32:12 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Thierry Reding <treding@nvidia.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Belisko Marek <marek.belisko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org,
        "Dr. H. Nikolaus Schaller" <hns@goldelico.com>,
        Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: omap5 fixing palmas IRQ_TYPE_NONE warning leads to gpadc timeouts
Message-ID: <20181126193212.GN53235@atomide.com>
References: <CAAfyv37F1s8Cg=pfxiN0dA6YEX7KMB-+uifjRoqAdKGWLeYEwA@mail.gmail.com>
 <20181113180656.GE53235@atomide.com>
 <46d271b2-35d3-6353-c530-3292cdac53ab@ti.com>
 <20181119161906.GP53235@atomide.com>
 <20181119171406.GQ53235@atomide.com>
 <725df8e7-4aff-3751-d0b0-809b89e882e5@nvidia.com>
 <20181123164827.GE53235@atomide.com>
 <20181126093625.GA10878@ulmo>
 <d3f17ac6-c13b-5b5f-a482-b565b130f1ba@ti.com>
 <20181126102541.GC10878@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126102541.GC10878@ulmo>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Thierry Reding <treding@nvidia.com> [181126 10:25]:
> On Mon, Nov 26, 2018 at 11:49:54AM +0200, Peter Ujfalusi wrote:
> > The register map documentation I have states the following:
> > bit7 INT_POLARITY Select the polarity of the INT output line
> > 0: Interrupt line (INT) is low when interrupt is pending (default) RW
> > 1: Interrupt line (INT) is high when interrupt is pending
> > 
> > By default the Palmas irq is active low.
> 
> That would confirm that the driver code is correct. My understanding is
> that the PMC on Tegra expects a low-active IRQ from the PMIC, so we need
> to invert the interrupt again in the PMC.

But then why Tegra need to set PALMAS_POLARITY_CTRL_INT_POLARITY
if dts has IRQ_TYPE_LEVEL_HIGH? Shouldn't the Palmas default low
setting be correct for Tegra if PMC expects active-low interrupt
and then inverts it for GIC?

What seems to make most sense for me right now is either
this option A:

1. Palmas TRM has the INT_POLARITY register misdocumented
   the wrong way around

2. Tegra really gets a level-low interrupt now from
   Palmas with PALMAS_POLARITY_CTRL_INT_POLARITY set and
   then inverts it to level-high for GIC

3. Omap5 wakeupgen does not invert the interrupt for GIC
   and needs PALMAS_POLARITY_CTRL_INT_POLARITY cleared
   for level-high interrupt from Palmas that gets passed
   as level-high interrupt to GIC

Or else option B:

1. Palmas TRM is correct for INT_POLARITY register

2. Tegra should not set PALMAS_POLARITY_CTRL_INT_POLARITY
   as Tegra PMC already translates Palmas level-low interrupt
   to level-high for GIC

3. Omap5 wkupgen also translates palmas interrupt and must
   not set PALMAS_POLARITY_CTRL_INT_POLARITY

Anybody got better explanations?

BTW, this interrupt is pretty easy to test with the
rtctest tool in Linux kernel:

tools/testing/selftests/rtc/rtctest.c

Regards,

Tony



