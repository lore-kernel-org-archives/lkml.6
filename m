Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753468AbeDKP3J (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 11:29:09 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33549 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752879AbeDKP3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 11:29:06 -0400
X-Google-Smtp-Source: AIpwx49CkXNYAf46K96ge5bQ2Kqt5Iowp93chYF1H47mReE/qDJSO+y/P7Px/ksJJ1FdEQWCQ5fgIA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Lina Iyer <ilina@codeaurora.org>
From: Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180409160800.GC19682@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, evgreen@chromium.org,
        dianders@chromium.org, devicetree@vger.kernel.org
References: <20180405161834.3850-1-ilina@codeaurora.org>
 <20180405161834.3850-3-ilina@codeaurora.org>
 <152306368031.94378.14957212064809086345@swboyd.mtv.corp.google.com>
 <20180409160800.GC19682@codeaurora.org>
Message-ID: <152346054406.180276.4468371342222361883@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 02/10] dt-bindings: introduce RPMH RSC bindings for Qualcomm
 SoCs
Date: Wed, 11 Apr 2018 08:29:04 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3BFTF5I028206

Quoting Lina Iyer (2018-04-09 09:08:00)
> On Fri, Apr 06 2018 at 19:14 -0600, Stephen Boyd wrote:
> >Quoting Lina Iyer (2018-04-05 09:18:26)
> >> diff --git a/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt b/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
> >> new file mode 100644
> >> index 000000000000..dcf71a5b302f
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
> >> @@ -0,0 +1,127 @@
> >> +
> >> +Example 1:
> >> +
> >> +For a TCS whose RSC base address is is 0x179C0000 and is at a DRV id of 2, the
> >> +register offsets for DRV2 start at 0D00, the register calculations are like
> >> +this -
> >> +First tuple: 0x179C0000 + 0x10000 * 2 = 0x179E0000
> >> +Second tuple: 0x179E0000 + 0xD00 = 0x179E0D00
> >> +
> >> +       apps_rsc: rsc@179e000 {
> >> +               label = "apps_rsc";
> >> +               compatible = "qcom,rpmh-rsc";
> >> +               reg = <0x179e0000 0x10000>, <0x179e0d00 0x3000>;
> >
> >The first reg property overlaps the second one. Does this second one
> >ever move around? I would hardcode it in the driver to be 0xd00 away
> >from the drv base instead of specifying it in DT if it's the same all
> >the time.
> >
> >Also, the example shows 0x179c0000 which I guess is the actual beginning
> >of the RSC block. So the binding seems to be for one DRV inside of an
> >RSC. Can we get the full description of the RSC in the binding instead?
> >I imagine that means there's a DRV0,1,2 and those probably have an
> >interrupt per each DRV and then a different TCS config per each one too?
> >If the binding can describe all of the RSC then we can use different
> >DRVs by changing the qcom,drv-id property.
> >
> >       rsc@179c0000 {
> >               compatible = "qcom,rpmh-rsc";
> >               reg = <0x179c0000 0x10000>,
> >                     <0x179d0000 0x10000>,
> >                     <0x179e0000 0x10000>;
> >               qcom,tcs-offset = <0xd00>;
> >               qcom,drv-id = <0/1/2>;
> >               interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> >                            <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> >                            <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
> >       }
> >
> >This is sort of what I imagine it would look like. I have no idea how
> >the tcs config would work unless each DRV has the same TCS config
> >though. Otherwise, if each node is for a drv, then I would expect the
> >node would be called 'drv' and we wouldn't need the drv-id property and
> >the compatible string would say drv instead of rsc?
> >
> >BTW, what are the other DRVs used for in the apps RSC?
> >
> The DRV is the voter for an execution environment (Linux, Hypervisor,
> ATF) in the RSC. The RSC has a lot of other registers that Linux is not
> privy to. They are access restricted.

Alright. Well sometimes access restrictions aren't there, so this isn't
a good assumption to make.

> The memory organization of the RSC
> mandates that we know the DRV id to access registers specific to the
> DRV.

I think qcom,drv-id covers that, no?

> Unfortunately, not all RSC have identical DRV configuration and the
> register space is also variable depending on the capability of the RSC.
> There are functionalities supported by other RSCs in the SoC that are
> not supported by the RSC associated with the application processor,
> while not many RSCs' support multiple DRVs. Therefore it doesn't benefit
> describing the whole RSC as it is not usable from Linux (because of
> access restrictions).

If we're not describing the whole RSC in the RSC binding then we're not
going to get very far. From what I can tell, this binding describes one
DRV inside of an RSC instead of the whole RSC. Yes we'll probably never
use the ATF part of the RSC in Linux, but we may use the hypervisor part
if we use KVM/Xen so the binding should be describing as much as it can
about this device in case some software needs to use it.

Put another way, even if the "apps" RSC is complicated, we should be
describing it to the best of our abilities in the binding so that when
it is used by non-linux OSes things still work by simply tweaking the
drv-id that we use to pick the right things out of the node.

Or we're describing the RSC but it's really a container node that
doesn't do much besides hold DRVs? So this is described at the wrong
level?
