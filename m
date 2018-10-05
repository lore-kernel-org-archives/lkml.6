Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A1CC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD4820652
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZWpeaUOw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AD4820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbeJFDoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 23:44:55 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39671 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbeJFDoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 23:44:54 -0400
Received: by mail-lf1-f66.google.com with SMTP id w21-v6so10260085lff.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 13:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PlgUK/bgq4+y4TDgJKJYZS6MsIztcwRebAwiHKwX5HM=;
        b=ZWpeaUOwjJDKaZh1qMjAo81+37Wq7FOd0F9zIHue1VhvzLTCAo4+fHGyPBS/YB9Yke
         miGEyZezKaOcnNdPzT/klu5Da5ieOnxY+/6TuYK5QmGpMe+i7sWmHtbn/5VaLzZ0aIDl
         h60A+tZMxP6a1KIaZYgo8SB3x5YxwdVnkhRUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PlgUK/bgq4+y4TDgJKJYZS6MsIztcwRebAwiHKwX5HM=;
        b=fOzcLl+CKZsUjXOk+jOhVexCbOS2fPYZtOUpYRYFiKF+CMf+vwtWwVnTtNxIxRq2pH
         Uf7oyMli+s8ly/X3sXewI58Jg2a9tAYP57vkXvQbi4B74NI14dkHk7uC6cXdj666L0dR
         bqDMj4Ng9VQr3LXEg9Sw5zwpzP4p8ZRZiAkxHM3ciXvwY8t+XLZwt1JVHhAggyt+DM4M
         viADMenG/bnDSSIoxJwmhcGeAauUA+tAcO6jvx0JwidFzKwD5DtEsUYTabcPeed+G4Vk
         SRujsze2ufThHF+8zEif1o8HF6QrFfjqjCAoJr+11q597D1E1UZKIU1omsBQK0MQLP1I
         Ygog==
X-Gm-Message-State: ABuFfognYO8/T/x2D/ECacQJt4KmwOWZ6urUs5MgY9Ut0JwtWsZmibyN
        vAKN/5DaOE5fJL8wJ4ked8zN8A==
X-Google-Smtp-Source: ACcGV60IUpo553WUS2wzQ6PktcgLjycL09/oPANZ4WinQv8Bi4jVcIq21UEcnDMQJ2Fz/eKtvdeNwg==
X-Received: by 2002:a19:5d56:: with SMTP id p22-v6mr7824633lfj.34.1538772267933;
        Fri, 05 Oct 2018 13:44:27 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id p9-v6sm2054770ljh.0.2018.10.05.13.44.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 13:44:27 -0700 (PDT)
Date:   Fri, 5 Oct 2018 22:44:24 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Collins <collinsd@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/6] dt-bindings: power: Add qcom rpm power domain
 driver bindings
Message-ID: <20181005204424.GA29500@centauri.lan>
References: <20180703223554.GA32313@rob-hp-laptop>
 <20180704055757.4li26b6poxllmh2k@vireshk-i7>
 <1463d24b-481d-eecd-9e44-e7a5a993e5fc@codeaurora.org>
 <CAL_JsqJe+m4hD3nxQDjOT1JzRoSMXppy1r6APV1w=NtgCr-X_A@mail.gmail.com>
 <271db7b1-f65b-f42d-b00b-9362429b3749@codeaurora.org>
 <CAL_JsqJQypZbeZRa2u2+nM96p0ZHMHgDSpMbXqZx6zn+OiZSrw@mail.gmail.com>
 <20181004083637.xlz26rpn4qtsvdk7@vireshk-i7>
 <CAL_JsqKSiT15sn_jXy0FRp_YG5XbkREUeHf-98A61iN-TKxWpQ@mail.gmail.com>
 <20181004191725.GA7926@centauri.lan>
 <CAL_JsqJOf6y1ZwcYk_LcL=-XShW2ME=aPTgho2fEQSDmHqE0eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJOf6y1ZwcYk_LcL=-XShW2ME=aPTgho2fEQSDmHqE0eQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 05:17:42PM -0500, Rob Herring wrote:
> On Thu, Oct 4, 2018 at 2:17 PM Niklas Cassel <niklas.cassel@linaro.org> wrote:
> >
> > On Thu, Oct 04, 2018 at 10:18:22AM -0500, Rob Herring wrote:
> > > On Thu, Oct 4, 2018 at 3:36 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > >
> > > > On 25-09-18, 14:43, Rob Herring wrote:
> > > > > On Tue, Sep 25, 2018 at 5:25 AM Rajendra Nayak <rnayak@codeaurora.org> wrote:
> > > > > >
> > > > > > Hi Rob,
> > > > > >
> > > > > > []...
> > > > > > >>>>> +   rpmhpd_opp_table: opp-table {
> > > > > > >>>>> +           compatible = "operating-points-v2-qcom-level";
> > > > > > >>>>> +
> > > > > > >>>>> +           rpmhpd_opp_ret: opp1 {
> > > > > > >>>>> +                   qcom,level = <RPMH_REGULATOR_LEVEL_RETENTION>;
> > > > > > >>>>> +           };
> > > > > > >>>>
> > > > > > >>>> I don't see the point in using the OPP binding here when you aren't
> > > > > > >>>> using *any* of the properties from it.
> > > > > > >>>
> > > > > > >>> Yeah, that's the case for now. But there are cases (as Stephen
> > > > > > >>> mentioned earlier [1]) where the voltage values (and maybe other
> > > > > > >>> values like current, etc) would be known and filled in DT. And that's
> > > > > > >>> why we all agreed to use OPP tables for PM domains as well, as these
> > > > > > >>> are really "operating performance points" of these PM domains.
> > > > > > >>
> > > > > > >> Rob, are you fine with these bindings then?
> > > > > > >
> > > > > > > Okay, my only thought is whether we should just use 'reg' here, or do
> > > > > > > we need 'level' for anything else and should make it common?
> > > > > >
> > > > > > I am not quite sure I understood what you are suggesting here :(
> > > > >
> > > > > You could use the  'reg' property instead of 'qcom,level'. Any reason
> > > > > not to do that?
> > > >
> > > > They can use any property which uniquely identifies the OPP nodes in
> > > > the table. Though I never thought we can use 'reg' property in such a
> > > > way. I always thought it must be related to registers somehow :)
> > >
> > > That's almost certainly where the name originates from back in the
> > > 90s. I view 'reg' as how you identify or address a device. This can be
> > > channels of something like an ADC.
> > >
> > > It's perhaps a stretch for OPP nodes as they aren't really a device,
> > > but if the levels are part of the h/w then perhaps reg is a good
> > > match.
> > >
> >
> > FWIW, I actually have a use case on qcom SoCs.
> >
> > I'm working on reviving an old patch series from Stephen Boyd:
> > https://lkml.org/lkml/2015/9/18/833
> >
> >
> > Rajendra's Documentation/devicetree/bindings/opp/qcom-opp.txt currently has:
> >
> > Required properties:
> > - qcom,level: On Qualcomm platforms an OPP node can describe a positive value
> > representing a corner/level that's communicated with a remote microprocessor
> > (usually called the RPM) which then translates it into a certain voltage on
> > a voltage rail
> >
> >
> > I'm planning on extending it with something like:
> >
> > Optional properties:
> > -qcom,fuse-level: On Qualcomm platforms, not all corners/levels are real
> > corners/levels, i.e., not all corners/levels have a unique eFuse associated.
> > Usually more than one corner/level uses the same eFuse corner/level.
> 
> Is that because there's additional parameters not covered as part of a corner?


Turns out that while qcom,fuse-level is a good idea for msm8916,
it will not suffice for msm8996.. Feel free to jump the the TL;DR below.


Looking at downstream, a corner is just something virtual:

https://source.codeaurora.org/quic/la/kernel/msm-3.10/tree/Documentation/devicetree/bindings/regulator/cpr-regulator.txt?h=msm-3.10#n362

In this example there are 9 virtual corners, but only 3 fuse-corners:

https://source.codeaurora.org/quic/la/kernel/msm-3.10/tree/arch/arm/boot/dts/qcom/msm8916-regulator.dtsi?h=msm-3.10#n90

qcom,cpr-corner-frequency-map = each frequency gets a virtual corner (probably
for simplicity).

qcom,cpr-corner-map = has a member for each virtual corner, defining what
fuse-corner each virtual corner really maps to.

Looking at the code:

https://source.codeaurora.org/quic/la/kernel/msm-3.10/tree/drivers/regulator/cpr-regulator.c?h=msm-3.10#n5460

These fuse-corners are really just efuses, where each fuse-corner
contains e.g. ref_uV, min_uV, max_uV.

> 
> > So for each OPP I would have:
> >
> > opp1 {
> >         qcom,level = <foo>;
> >         qcom,fuse-level = <bar>;
> > }
> >
> >
> > Not sure if this changes your opinion about using reg,
> > but I thought that it was worth mentioning.
> 
> 'reg' is probably not the right fit then.
> 
> Does any of this fuse-level apply to platforms using this binding? If
> so, then it should be incorporated here. I don't want incomplete
> bindings that get one property added at a time.

This binding is new, but Rajendra uses it for RPM in msm8996 and sdm845.

RPM does not need the fuse-corner property. (Not sure why it doesn't.)

Looking at the downstream CPR DT bindings for msm8996, they still have
a fuse-corner for each corner. However, the DT binding has changed
compared to msm8916. They now have:

https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/arch/arm/boot/dts/qcom/msm8996-regulator.dtsi?h=msm-4.4#n646

qcom,cpr-corner-fmax-map = array for each fuse-corner, defining the
maximum virtual corner that this fuse-corner maps to.

Each speed bin has a different number of supported OPPs.

In upstream we use opp-supported-hw, together with the speedbin efuse,
to determine what subset of OPPs the hardware supports.

The problem with msm8996, compared to msm8916, is that each speed bin
has its own qcom,cpr-corner-fmax-map.

So for msm8996, it will not be enough to simply have a single
qcom,fuse-level property for each OPP.
We could add a qcom,fuse-level property for each speedbin, for each OPP.

Like this:

opp1 {
     qcom,level = <foo>;
     qcom-fuse-level-speed0 = <bar>;
     qcom-fuse-level-speed1 = <bax>;
     qcom-fuse-level-speed2 = <baz>;
}



TL;DR:

Perhaps I should just try to add something like
qcom,cpr-corner-fmax-map, where there is an array per speedbin,
to Documentation/devicetree/bindings/opp/qcom-opp.txt
Like "compatible", it could be a property in the opp-table node.

Something like:

qcom,speed-bins = <3>;
qcom,fuse-level-to-max-level-map =
					/* Speed bin 0 */
					<1 2 7 12 16>,

					/* Speed bin 1 */
					<1 2 7 12 13>,

					/* Speed bin 2 */
					<1 2 7 12 16>;

Since this would work for both msm8916 and msm8996.
And this way you could still change qcom,level to use
reg if you want.


Kind regards,
Niklas
