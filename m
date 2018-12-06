Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_RHS_DOB,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80161C65BAF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D8E820892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D8E820892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbeLFUeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 15:34:22 -0500
Received: from mail.bootlin.com ([62.4.15.54]:58104 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbeLFUeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 15:34:21 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A4A3920731; Thu,  6 Dec 2018 21:34:19 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 486C220510;
        Thu,  6 Dec 2018 21:34:19 +0100 (CET)
Date:   Thu, 6 Dec 2018 21:34:19 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rtc@vger.kernel.org, linux-clk <linux-clk@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 00/14] rtc: sun6i: clock rework and pre-H6 SoC support
Message-ID: <20181206203419.GD8952@piout.net>
References: <20181203145825.20511-1-wens@csie.org>
 <CAGb2v65GwzEHZnRJysp=qE4HjrTa+TzCeyQ_j_Q=RrwtnC617g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGb2v65GwzEHZnRJysp=qE4HjrTa+TzCeyQ_j_Q=RrwtnC617g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2018 13:49:10+0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Mon, Dec 3, 2018 at 10:58 PM Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > Hi everyone,
> >
> > This is v2 of my rtc-sun6i clean-up series.
> >
> > Changes since v1:
> >
> >   - Collected tags
> >   - Dropped patch "clk: sunxi-ng: r40: Force LOSC parent to RTC LOSC
> >     output"; already merged
> >   - Removed H6 compatible CLK_OF_DECLARE_DRIVER entry that wasn't
> >     overlooked
> >   - Only export IOSC clock for A64/H3/H5
> >
> > Original cover letter, with patch numbers corrected, follows:
> >
> > This series was started as part of enabling Bluetooth on various
> > Allwinner SBCs. The bluetooth controller requires a precise 32.768 kHz
> > clock fed to it to correctly detect the frequency of its main oscillator.
> > This clock signal is provided by the RTC, either directly from a special
> > pin on the SoC, or some clock output function from the clock controllers.
> > I found that the clock-related properties of the RTC on later SoCs were
> > incorrect or missing.
> >
> > This series reworks the compatible strings and clock parts of the device
> > tree bindings for sun6i-rtc. Currently we assume most Allwinner SoCs use
> > the same sun6i-rtc variant, when in fact they do not. The differences
> > that matter with regards to clocks are a) the A31 does not have an extra
> > external output for the RTC 32K clock, while most of the others do;
> > b) the clock frequency of the internal RC oscillator is different on
> > some SoCs; c) on the H6 the RTC also handles the 24 MHz DCXO, which
> > feeds the system HOSC. The last difference, and by extension the H6, are
> > not covered in this series.
> >
> > Patch 1 cleans up the clock-related section of the RTC device tree
> > binding. This would make it easier to read and easier to add additional
> > clocks.
> >
> > Patch 2 adds compatible strings for all identified variants introduced
> > prior to the H6.
> >
> > Patch 3 deprecates the external clock output for the A31. The A31 does
> > not have this output, so it's introduction and usage was an error.
> >
> > Patch 4 adds a clock output for the RTC's internal oscillator to the
> > device tree binding. This feeds the PRCM in some SoCs.
> >
> > Patch 5 adds a default clock name for the LOSC to the RTC driver.
> >
> > Patch 6 adds support for different hardware variants to the RTC driver.
> >
> > Patch 7 adds support for all known pre-H6 variants.
> >
> > Patch 8 exposes the RTC's internal oscillator through the device tree.
> >
> > Patch 9 through 14 adds an RTC node or fixes up the RTC device node
> > address ranges, clock properties, names of existing clocks, and adds
> > accuracy properties for the external fixed oscillators.
> >
> > The clock names require fixing because the sunxi clock driver implicitly
> > depends on the HOSC and LOSC being named "osc24M" and "osc32k". The
> > "fixes" to the clock hierarchy introduced in this series means the names
> > must also be shuffled around or the in kernel representation would be
> > incorrect. This has been the case since the sunxi-ng drivers were
> > introduced. There are plans to address this, but the code is still in its
> > early stages.
> >
> > Please have a look.
> >
> > Thanks
> > ChenYu
> >
> > Chen-Yu Tsai (14):
> >   dt-bindings: rtc: sun6i-rtc: Rewrite clock outputs as a list
> >   dt-bindings: rtc: sun6i-rtc: Add compatible strings for pre-H6
> >     variants
> >   dt-bindings: rtc: sun6i-rtc: Deprecate external clock output for A31
> >   dt-bindings: rtc: sun6i-rtc: Export internal RC oscillator
> >   rtc: sun6i: Add default clock name for LOSC
> >   rtc: sun6i: Add support for different variants
> >   rtc: sun6i: Add support for all known pre-H6 variants
> >   rtc: sun6i: Expose internal oscillator through device tree

I've applied the above patches. However, for whatever reason, patch 3
didn't apply without some fuzz, please check.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
