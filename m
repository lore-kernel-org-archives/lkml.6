Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753143AbeDJTg1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 15:36:27 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:42507 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751611AbeDJTgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 15:36:25 -0400
X-Google-Smtp-Source: AIpwx4/C5nOuMczH+nHZIAry8JfztJTa1Refxfe0bkI3w2yVqvu2VijW0C4n2ykftC+yWfWVWCSFqg==
Date: Tue, 10 Apr 2018 12:36:21 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Lina Iyer <ilina@codeaurora.org>
Cc: Stephen Boyd <swboyd@chromium.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, rnayak@codeaurora.org,
        linux-kernel@vger.kernel.org, evgreen@chromium.org,
        dianders@chromium.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 02/10] dt-bindings: introduce RPMH RSC bindings for
 Qualcomm SoCs
Message-ID: <20180410193621.GB6727@builder>
References: <20180405161834.3850-1-ilina@codeaurora.org>
 <20180405161834.3850-3-ilina@codeaurora.org>
 <152306368031.94378.14957212064809086345@swboyd.mtv.corp.google.com>
 <20180409160800.GC19682@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409160800.GC19682@codeaurora.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09 Apr 09:08 PDT 2018, Lina Iyer wrote:

> On Fri, Apr 06 2018 at 19:14 -0600, Stephen Boyd wrote:
> > Quoting Lina Iyer (2018-04-05 09:18:26)
> > > diff --git a/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt b/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
[..]
> > > +Example 1:
> > > +
> > > +For a TCS whose RSC base address is is 0x179C0000 and is at a DRV id of 2, the
> > > +register offsets for DRV2 start at 0D00, the register calculations are like
> > > +this -
> > > +First tuple: 0x179C0000 + 0x10000 * 2 = 0x179E0000
> > > +Second tuple: 0x179E0000 + 0xD00 = 0x179E0D00
> > > +
> > > +       apps_rsc: rsc@179e000 {
> > > +               label = "apps_rsc";
> > > +               compatible = "qcom,rpmh-rsc";
> > > +               reg = <0x179e0000 0x10000>, <0x179e0d00 0x3000>;
> > 
> > The first reg property overlaps the second one. Does this second one
> > ever move around? I would hardcode it in the driver to be 0xd00 away
> > from the drv base instead of specifying it in DT if it's the same all
> > the time.
[..]
> > 
> The DRV is the voter for an execution environment (Linux, Hypervisor,
> ATF) in the RSC. The RSC has a lot of other registers that Linux is not
> privy to. They are access restricted. The memory organization of the RSC
> mandates that we know the DRV id to access registers specific to the
> DRV. Unfortunately, not all RSC have identical DRV configuration and the
> register space is also variable depending on the capability of the RSC.
> There are functionalities supported by other RSCs in the SoC that are
> not supported by the RSC associated with the application processor,
> while not many RSCs' support multiple DRVs. Therefore it doesn't benefit
> describing the whole RSC as it is not usable from Linux (because of
> access restrictions).
> 

I generally prefer that we describe the hardware blocks as accurate as
possible, instead of applying current restrictions on Linux onto the
description. This ensures that we can reuse the binding and drivers in
configurations not considered today. However, afaict we still have the
problem that we need a way to express where in the RSC our TCS sits.

Regardless of what's right or not, the given example causes the driver
to fail probing, so something needs to be changed. (Making the drv size
0xd00 is functional but doesn't really relate to any bondary in the
register space).

Regards,
Bjorn
