Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754734AbeDIUSc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 16:18:32 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:43582 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752369AbeDIUS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 16:18:26 -0400
X-Google-Smtp-Source: AIpwx49tK59rPBrO6bFPca0x7ZT2kN9Glim0t7FaMHkXP0YPKY0cvZjAfrAJC8hhBm2M9dT381sK/w==
Date: Mon, 9 Apr 2018 15:18:24 -0500
From: Rob Herring <robh@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Manu Gautam <mgautam@codeaurora.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>, linux-arm-msm@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v4 6/7] dt-bindings: phy-qcom-usb2: Add support to
 override tuning values
Message-ID: <20180409201824.adsnvqo4vv2waixc@rob-hp-laptop>
References: <1522321466-21755-1-git-send-email-mgautam@codeaurora.org>
 <1522321466-21755-7-git-send-email-mgautam@codeaurora.org>
 <CAD=FV=VGtmWTaa_aRG6UVAtCzy3cS8sTZDCqAgRMYeg7U02qTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=VGtmWTaa_aRG6UVAtCzy3cS8sTZDCqAgRMYeg7U02qTw@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 01:38:23PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Thu, Mar 29, 2018 at 4:04 AM, Manu Gautam <mgautam@codeaurora.org> wrote:
> > To improve eye diagram for PHYs on different boards of same SOC,
> > some parameters may need to be changed. Provide device tree
> > properties to override these from board specific device tree
> > files. While at it, replace "qcom,qusb2-v2-phy" with compatible
> > string for USB2 PHY on sdm845 which was earlier added for
> > sdm845 only.
> >
> > Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
> > ---
> >  .../devicetree/bindings/phy/qcom-qusb2-phy.txt        | 19 ++++++++++++++++++-
> >  1 file changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt
> > index 42c9742..0ed140a 100644
> > --- a/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt
> > +++ b/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt
> > @@ -6,7 +6,7 @@ QUSB2 controller supports LS/FS/HS usb connectivity on Qualcomm chipsets.
> >  Required properties:
> >   - compatible: compatible list, contains
> >                "qcom,msm8996-qusb2-phy" for 14nm PHY on msm8996,
> > -              "qcom,qusb2-v2-phy" for QUSB2 V2 PHY.
> > +              "qcom,sdm845-qusb2-phy" for 10nm PHY on sdm845.
> >
> >   - reg: offset and length of the PHY register set.
> >   - #phy-cells: must be 0.
> > @@ -27,6 +27,23 @@ Optional properties:
> >                 tuning parameter value for qusb2 phy.
> >
> >   - qcom,tcsr-syscon: Phandle to TCSR syscon register region.
> 
> Just to confirm: the new properties below work just fine on the old
> msm8996 PHY too, right?
> 
> 
> > + - qcom,imp-res-offset-value: It is a 6 bit value that specifies offset to be
> > +               added to PHY refgen RESCODE via IMP_CTRL1 register. It is a PHY
> > +               tuning paramter that may vary for different boards of same SOC.
> > + - qcom,hstx-trim-value: It is a 4 bit value that specifies tuning for HSTX
> > +               output current. 0x0 value corresponding to 24mA which is maximum
> > +               current and 0xf corresponds to lowest current which is 15mA.
> > + - qcom,preemphasis-level: It is a 2 bit value that specifies pre-emphasis level.
> > +               Possible values are:
> > +               00: NONE
> > +               01: +5%
> > +               10: +10%
> > +               11: +15%
> 
> The user of the device tree will expect to specify this in decimal,
> right?  So list the above as 0, 1, 2, 3.  ...not 00, 01, 10, 11.
> (though below I suggest that specifying 0, 1, 2, 3 is probably not
> quite the right way to describe this property).
> 
> 
> > +- qcom,preemphasis-width: It is a 1 bit value that specifies how long the HSTX
> > +               pre-emphasis (specified using qcom,preemphasis-level) must be in
> > +               effect. Possible values are:
> > +               0: Full-bit width
> > +               1: Half-bit width
> 
> Perhaps just make this a boolean property.  If it exists then you get
> the non-default case.  AKA: if the default is full bit width, then
> you'd allow a boolean property "qcom,preemphasis-half-width" to
> override.  If the default is half bit width then you'd allow
> "qcom,preemphasis-full-width" to override.
> 
> 
> For all the above optional bits, please indicate what the default is
> if they aren't specified.  If you have to specify a different default
> for sdm845 vs. msm8996 then so be it (though it would be nice to avoid
> it by changing the default for sdm845 unless that's totally crazy).
> 
> 
> Overall this looks pretty good to me.  Certainly the descriptions are
> very understandable and this will make tuning on a per-board /
> per-port basis much easier!  Thanks!
> 
> 
> One last overall comment is that ideally we could make the device tree
> a little bit more human readable.  Right now we'll have a set of
> properties that looks like this (numbers made up):
> 
> qcom,imp-res-offset-value = <0x13>;
> qcom,hstx-trim-value = <0x7>;
> qcom,preemphasis-level = <1>;
> qcom,preemphasis-width = <0>;
> 
> 
> One option to make that more readable would be to change the units, AKA:
> 
> qcom,hstx-trim-ma = <18>;
> qcom,preemphasis-percent = <5>;
> 
> ...then the code would translate from these human-readable values to
> the real numbers.

Yes, we often do that. However, there properties are very specific to 
this device and making the driver translate back to h/w values doesn't 
add much.

> Another option would be to add a #include to the bindings.  I'd defer
> to the wisdom of the bindings guys about if this is better or worse
> than adding the units, but personally I like it better because:
> * You get a compile-time error if you use an unsupported value.
> * You don't need to add the code to translate.

This is fine for me. Really, I'm fine with it as-is, but #defines make 
some people happy.

Rob
