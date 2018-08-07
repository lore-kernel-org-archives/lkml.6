Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E000C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0031C21757
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:15:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0031C21757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388921AbeHGPaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 11:30:08 -0400
Received: from gloria.sntech.de ([185.11.138.130]:51254 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728258AbeHGPaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 11:30:07 -0400
Received: from wd0970.dip.tu-dresden.de ([141.76.111.202] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fn1pr-0006Mr-HW; Tue, 07 Aug 2018 15:15:39 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH 1/2] iommu/rockchip: Handle errors returned from PM framework
Date:   Tue, 07 Aug 2018 15:15:39 +0200
Message-ID: <3265383.PcPThIO4HC@phil>
In-Reply-To: <94b6aab1-e8d3-6929-a2e6-2f06c564bc70@arm.com>
References: <20180807085406.3863-1-marc.zyngier@arm.com> <2940317.dDZy1L4CDY@phil> <94b6aab1-e8d3-6929-a2e6-2f06c564bc70@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 7. August 2018, 14:31:49 CEST schrieb Marc Zyngier:
> On 07/08/18 13:09, Heiko Stuebner wrote:
> > Hi Marc,
> > 
> > Am Dienstag, 7. August 2018, 10:54:05 CEST schrieb Marc Zyngier:
> >> pm_runtime_get_if_in_use can fail: either PM has been disabled
> >> altogether (-EINVAL), or the device hasn't been enabled yet (0).
> >> Sadly, the Rockchip IOMMU driver tends to conflate the two things
> >> by considering a non-zero return value as successful.
> >>
> >> This has the consequence of hiding other bugs, so let's handle this
> >> case throughout the driver, with a WARN_ON_ONCE so that we can try
> >> and work out what happened.
> >>
> >> Fixes: 0f181d3cf7d98 ("iommu/rockchip: Add runtime PM support")
> >> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > 
> > I'm still not sure about the !CONFIG_PM case, as it was probably silently
> > working in that case before
> 
> Do we agree that this is an orthogonal problem though?

Nope ;-) .... I.e. right now the code ignores the -EINVAL from disabled PM
and continues, possibly even handling the irq correctly.

If it actually worked is a different matter, as I guess nobody really tried
with !PM in the past.

Now with error-handling we always return IRQ_NONE for !PM.


> > But on the other hand we're also already running over it in other places
> > like in the iommu-shutdown and I guess if someone _really_ disabled
> > CONFIG_PM, a lot of additional stuff would fail anyway.
> > 
> > So should we wrap that in some #ifdef magic, just ignore it or simply
> > select PM similar to what Tegra, Renesas and Vexpress seem to do?
> > 
> > I guess I like the 3rd option best ;-)
> 
> It probably doesn't hurt. At what level do you want it? As a dependency
> to the IOMMU? or to the platform?

I guess it might be best to go the Tegra, etc way. Whoever in their right
mind would want to drive a mobile platform without any form for power
management ;-) .

I can do these patches for arm32+arm64 myself ... I just wanted to put
that thought out there - in case that was just a stupid idea of mine :-D .


Heiko


