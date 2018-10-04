Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A205C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 435F32083F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kAyZT0JX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 435F32083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbeJECMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 22:12:08 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37945 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbeJECMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 22:12:08 -0400
Received: by mail-lj1-f193.google.com with SMTP id v7-v6so8968629ljg.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 12:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fpt6reqnvvcKFO1AtR3KmtjoWsEMUCRwVILq7p5txxU=;
        b=kAyZT0JXDXStplrLSkJ7+00J2ievMSXUiBb0KhOIfYMOj5Hq8+mQpIs+4DwUOgeOwv
         d8VggslFV6R/YcLYOWc/YY4XQ60DCuHMFvLpb3wQeWe3md+aih4kobT/S704wrVYFHrL
         J3IG9SfXmoj0igPs0zuNJvXHu2fS2uyV+QbYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fpt6reqnvvcKFO1AtR3KmtjoWsEMUCRwVILq7p5txxU=;
        b=B4ixBvlOoHkbQzyWqJ7ixU0hD4NV2MYdMhM5bCBJ+jh0bazZiZLinXr99VQY3HEMkf
         Siq5Jm2UPxpbdPCDQlCo/VRZYQ+3iKN5kZLqa1xwWg5fQ/Vtl2lpLMNxU0qfjErmH01N
         ATvpd+hiuU8PyjsGVHhNrSToN+U6rxKEnlUno3kXikkkEyKadytD6m9k4GXfjn3078/I
         A32V6GJDOT/o3nJ8eatDsWPXARkvJrbwJkoy0olzyeT3nMnCmPgahCN42ufE1w1GHgS+
         n8tiZxHZOTiUT8Dbm3xRtv9miARCIg29HeZy87jkSL1L3YKv3G/zlNcEy47VdTN1paN7
         kvwg==
X-Gm-Message-State: ABuFfojRrTrXKhog++WdxDuEO3C3Dm/RqzaDsYhNOBV/2XihpAEFXSrC
        ipvec8kcGVt2tkW8IYPDw/gPig==
X-Google-Smtp-Source: ACcGV60gQW3qKIZqcM/PDAwnRiZtLD5aMD5ifTL7J21HXGwsQHezVrT96X9eenVtdtUyDL35mxcPyg==
X-Received: by 2002:a2e:9e99:: with SMTP id f25-v6mr5008326ljk.142.1538680648017;
        Thu, 04 Oct 2018 12:17:28 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id g92-v6sm1285877lji.24.2018.10.04.12.17.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 12:17:27 -0700 (PDT)
Date:   Thu, 4 Oct 2018 21:17:25 +0200
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
Message-ID: <20181004191725.GA7926@centauri.lan>
References: <20180627045234.27403-1-rnayak@codeaurora.org>
 <20180627045234.27403-3-rnayak@codeaurora.org>
 <20180703223554.GA32313@rob-hp-laptop>
 <20180704055757.4li26b6poxllmh2k@vireshk-i7>
 <1463d24b-481d-eecd-9e44-e7a5a993e5fc@codeaurora.org>
 <CAL_JsqJe+m4hD3nxQDjOT1JzRoSMXppy1r6APV1w=NtgCr-X_A@mail.gmail.com>
 <271db7b1-f65b-f42d-b00b-9362429b3749@codeaurora.org>
 <CAL_JsqJQypZbeZRa2u2+nM96p0ZHMHgDSpMbXqZx6zn+OiZSrw@mail.gmail.com>
 <20181004083637.xlz26rpn4qtsvdk7@vireshk-i7>
 <CAL_JsqKSiT15sn_jXy0FRp_YG5XbkREUeHf-98A61iN-TKxWpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKSiT15sn_jXy0FRp_YG5XbkREUeHf-98A61iN-TKxWpQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 10:18:22AM -0500, Rob Herring wrote:
> On Thu, Oct 4, 2018 at 3:36 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 25-09-18, 14:43, Rob Herring wrote:
> > > On Tue, Sep 25, 2018 at 5:25 AM Rajendra Nayak <rnayak@codeaurora.org> wrote:
> > > >
> > > > Hi Rob,
> > > >
> > > > []...
> > > > >>>>> +   rpmhpd_opp_table: opp-table {
> > > > >>>>> +           compatible = "operating-points-v2-qcom-level";
> > > > >>>>> +
> > > > >>>>> +           rpmhpd_opp_ret: opp1 {
> > > > >>>>> +                   qcom,level = <RPMH_REGULATOR_LEVEL_RETENTION>;
> > > > >>>>> +           };
> > > > >>>>
> > > > >>>> I don't see the point in using the OPP binding here when you aren't
> > > > >>>> using *any* of the properties from it.
> > > > >>>
> > > > >>> Yeah, that's the case for now. But there are cases (as Stephen
> > > > >>> mentioned earlier [1]) where the voltage values (and maybe other
> > > > >>> values like current, etc) would be known and filled in DT. And that's
> > > > >>> why we all agreed to use OPP tables for PM domains as well, as these
> > > > >>> are really "operating performance points" of these PM domains.
> > > > >>
> > > > >> Rob, are you fine with these bindings then?
> > > > >
> > > > > Okay, my only thought is whether we should just use 'reg' here, or do
> > > > > we need 'level' for anything else and should make it common?
> > > >
> > > > I am not quite sure I understood what you are suggesting here :(
> > >
> > > You could use the  'reg' property instead of 'qcom,level'. Any reason
> > > not to do that?
> >
> > They can use any property which uniquely identifies the OPP nodes in
> > the table. Though I never thought we can use 'reg' property in such a
> > way. I always thought it must be related to registers somehow :)
> 
> That's almost certainly where the name originates from back in the
> 90s. I view 'reg' as how you identify or address a device. This can be
> channels of something like an ADC.
> 
> It's perhaps a stretch for OPP nodes as they aren't really a device,
> but if the levels are part of the h/w then perhaps reg is a good
> match.
> 

FWIW, I actually have a use case on qcom SoCs.

I'm working on reviving an old patch series from Stephen Boyd:
https://lkml.org/lkml/2015/9/18/833


Rajendra's Documentation/devicetree/bindings/opp/qcom-opp.txt currently has:

Required properties:
- qcom,level: On Qualcomm platforms an OPP node can describe a positive value
representing a corner/level that's communicated with a remote microprocessor
(usually called the RPM) which then translates it into a certain voltage on
a voltage rail


I'm planning on extending it with something like:

Optional properties:
-qcom,fuse-level: On Qualcomm platforms, not all corners/levels are real
corners/levels, i.e., not all corners/levels have a unique eFuse associated.
Usually more than one corner/level uses the same eFuse corner/level.


So for each OPP I would have:

opp1 {
	qcom,level = <foo>;
	qcom,fuse-level = <bar>;
}


Not sure if this changes your opinion about using reg,
but I thought that it was worth mentioning.


Kind regards,
Niklas
