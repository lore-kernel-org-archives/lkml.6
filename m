Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752900AbeBFTGZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 14:06:25 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39169 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752792AbeBFTGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 14:06:18 -0500
X-Google-Smtp-Source: AH8x226Ngx0GV8MT+Eg5NCD5izGD9PFdniPoJBND+zjUcsVAqGFNWYH+Qcca4Mm2F3EEuiviBDKGBQ==
Date: Tue, 6 Feb 2018 11:06:14 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: sdm845: Add serial console support
Message-ID: <20180206190614.GL9465@builder>
References: <20180125163216.29018-1-rnayak@codeaurora.org>
 <20180125163216.29018-3-rnayak@codeaurora.org>
 <20180126221808.GE28313@codeaurora.org>
 <CAD=FV=WcCnQJc25=sKWtOi=ZWi=ium6DVsexuQnsLDL=aJE6-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=WcCnQJc25=sKWtOi=ZWi=ium6DVsexuQnsLDL=aJE6-Q@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 06 Feb 10:37 PST 2018, Doug Anderson wrote:

> Hi,
> 
> On Fri, Jan 26, 2018 at 2:18 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > On 01/25, Rajendra Nayak wrote:
> >> diff --git a/arch/arm64/boot/dts/qcom/sdm845-pins.dtsi b/arch/arm64/boot/dts/qcom/sdm845-pins.dtsi
> >> new file mode 100644
> >> index 000000000000..b97f99e6f4b4
> >> --- /dev/null
> >> +++ b/arch/arm64/boot/dts/qcom/sdm845-pins.dtsi
> >> @@ -0,0 +1,32 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> >> + */
> >> +
> >> +&tlmm {
> >
> > I'm not the maintainer, but I find this approach to the pins
> > really annoying. I have to flip to another file to figure out how
> > a board has configured the pins. And we may bring in a bunch of
> > settings that we don't ever use on some board too. Why can't we
> > put the settings in the board file directly?
> 
> I'm not so familiar with how things work with Qualcomm, but in general
> I think putting this in the "board" file is a bad idea.  I'd be OK
> with putting this directly in the SoC file (though it might get
> unwieldy?), but not moving things to the board file as was done with
> v2 of this patch.
> 
> Said another way: nearly board that uses SDM845 that uses UART2 will
> have the same definitions for these pins so we shouldn't be
> duplicating it across every board, right?
> 

We've run into several cases where different boards uses the same
function but requires board specific electrical configuration.

So what we decided was to keep the pinmux in the soc-file (where e.g.
the uart definition is) and then extend it with the board specific
electrical properties (the pinconf), in the board files.

This does come with the complexity of having the pinctrl nodes split in
two places, but the responsibilities of the two parts is clear and we
remove the need for all board files to ensure the appropriate pinmux is
in place.


NB. We did discuss adding "sane defaults" for the pinconf in the soc
dtsi, but we end up spending considerable time debugging issues stemming
from not having the right pinconf; so better make this explicit and say
that the board has to specify it's config.

Regards,
Bjorn
