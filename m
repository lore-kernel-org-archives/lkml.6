Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958AAC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5107620873
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5107620873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752645AbeGDObO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:31:14 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47720 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752193AbeGDObN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:31:13 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1faioD-00008G-Bt; Wed, 04 Jul 2018 16:31:05 +0200
Date:   Wed, 4 Jul 2018 16:31:04 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andre Przywara <andre.przywara@arm.com>
cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Mark Rutland <Mark.Rutland@arm.com>
Subject: Re: [linux-sunxi] Re: [PATCH 0/2] Allwinner A64 timer workaround
In-Reply-To: <1a36f63c-0259-bdcd-bb96-d5230c2564ea@arm.com>
Message-ID: <alpine.DEB.2.21.1807041628440.1752@nanos.tec.linutronix.de>
References: <20180511022751.9096-1-samuel@sholland.org> <2c16d5ab-38f7-8f3e-875c-19e8032f440a@arm.com> <bdfb1a31-2c4a-d258-7bf6-aaab8cee4663@sholland.org> <5283f98e-6443-db7a-fe51-6379ed19002c@arm.com> <24b78819-5e3f-431f-3987-f7409742ef07@linaro.org>
 <1d75c538-9166-5eec-a08c-b168f9770bd1@arm.com> <alpine.DEB.2.21.1807041151530.1816@nanos.tec.linutronix.de> <1a36f63c-0259-bdcd-bb96-d5230c2564ea@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jul 2018, Andre Przywara wrote:
> On 04/07/18 11:00, Thomas Gleixner wrote:
> > On Wed, 4 Jul 2018, Marc Zyngier wrote:
> >> On 04/07/18 09:23, Daniel Lezcano wrote:
> >>>
> >>> If the patches fix a bug which already exist, it makes sense to
> >>> propagated the fix back to the stable versions.
> >>
> >> That's your call, but I'm not supportive of that decision, specially as
> >> we have information from the person developing the workaround that this
> >> doesn't fully address the issue.
> > 
> > The patches should not be applied at all. Simply because they don't fix the
> > issue completely.
> > 
> > From a quick glance at various links and information about this, this very
> > much smells like the FSL_ERRATUM_A008585.
> > Has that been tried? It looks way more robust than the magic 11 bit
> > crystal ball logic.
> 
> The Freescale erratum is similar, but not identical [1].
> It seems like the A64 is less variable, so we can use a cheaper
> workaround, which gets away with normally just one sysreg read. But then
> again the newer error reports may actually suggest otherwise ...
> 
> And as it currently stands, the Freescale erratum has the drawback of
> relying on the CPU running much faster than the timer. The A64 can run
> at 24 MHz (for power savings, or possibly during DVFS transitions),
> which is the timer frequency. So subsequent counter reads will never
> return the same value and the workaround times out.

If that's the case then you need to find a different functional timer for
time keeping. Having an erratic behaving timer for time keeping is not an
option at all.

Thanks,

	tglx
