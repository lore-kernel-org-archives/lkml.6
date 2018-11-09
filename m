Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7352C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C43320818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SKX62EQW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C43320818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbeKJCUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:20:43 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34590 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728229AbeKJCUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:20:43 -0500
Received: by mail-lj1-f195.google.com with SMTP id u6-v6so2139992ljd.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 08:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wH0WAphCeq+hM9TtlKiDIUsVcfAaIXaTeHGdI7aJ7N4=;
        b=SKX62EQWzHwVTspukuKqx7Da8QHiDvqQ9M+xKaH5eT4bAtTCMYmY3VetpTZNxYca68
         RKPmjiAivEPmiQwT6i/4LsrpZRzsWXS4x1/WBzTxZeuhO2CQ4jeGJFaTOuh57p+XpqKy
         APR4UsBHYQ1gYag7e7NlY4iGLShqTPkzY5z4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wH0WAphCeq+hM9TtlKiDIUsVcfAaIXaTeHGdI7aJ7N4=;
        b=ayW9tBk86VFHw3rlkbFtCuOgyE5aisxYJOZpaMNdHndyhY1xCFa0qg/ElmLfCvFRHc
         gGSqCDt/wUhc9vhdJSWrG1kxWx6LEf8C4nX1OnrYXjQPjbOwVUpdlSYw/SFlwwzqCp5d
         Zss/DaYADAkx7M2YEtc+xD+CozSdqN6DC4LxPCsRYIz/J7pp3Dse0Hd6Mm8G29LFWQDU
         FIjjT2n/hjEmhcJ+u/144X6/Qi5OMSXdmvlBGFcjpn35T9bm0qU9lHyIMLxH6rlHjYwD
         NUfcKACt3JAEvhRyzzvKMYjX27X4byh/VBndzSy//fxHWou0GDNrfk50VDs0KHTuPchs
         f/xA==
X-Gm-Message-State: AGRZ1gKkIuzmYHCFa4IrmkmKBK+b5k/gTDV4Ac8iW/0JsJLhKZA4o/Xe
        5Gu4WEA/e6Hm89UMSKSFjMjcaQ==
X-Google-Smtp-Source: AJdET5e8lUuYhYvoZEMIL1g7N8a5+4QH1/ESVTErmqJgpgagEqpX1lnIanfsvShqEUoojtAcIAnU2w==
X-Received: by 2002:a2e:96c6:: with SMTP id d6-v6mr6455602ljj.35.1541781560808;
        Fri, 09 Nov 2018 08:39:20 -0800 (PST)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id l7-v6sm1389112ljh.5.2018.11.09.08.39.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 08:39:19 -0800 (PST)
Date:   Fri, 9 Nov 2018 17:39:17 +0100
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org, andy.gross@linaro.org,
        ulf.hansson@linaro.org, collinsd@codeaurora.org, mka@chromium.org,
        rnayak@codeaurora.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] dt-bindings: opp: Extend qcom-opp bindings with
 properties needed for CPR
Message-ID: <20181109163917.GA6673@centauri.lan>
References: <20180627045234.27403-3-rnayak@codeaurora.org>
 <20181015124749.27276-1-niklas.cassel@linaro.org>
 <20181105231745.GA25883@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105231745.GA25883@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 05:17:45PM -0600, Rob Herring wrote:
> On Mon, Oct 15, 2018 at 02:47:49PM +0200, Niklas Cassel wrote:
> > Extend qcom-opp bindings with properties needed for Core Power Reduction
> > (CPR).
> > 
> > CPR is included in a great variety of Qualcomm SoC, e.g. msm8916 and
> > msm8996, and was first introduced in msm8974.
> > 
> > Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> > ---
> > Hello Rob, Rajendra,
> > 
> > Sorry for not replying sooner.
> > Since Rob wanted the binding to be complete before merging,
> > this is my proposal to extend the OPP binding with properties
> > needed to support CPR (both for msm8916 and msm8996).
> > I've discussed the proposal with Viresh, and this proposal
> > seems better than what I previously suggested here:
> > https://lore.kernel.org/lkml/20181005204424.GA29500@centauri.lan/
> > 
> >  .../devicetree/bindings/opp/qcom-opp.txt      | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/opp/qcom-opp.txt b/Documentation/devicetree/bindings/opp/qcom-opp.txt
> > index db4d970c7ec7..3ab5dd84de86 100644
> > --- a/Documentation/devicetree/bindings/opp/qcom-opp.txt
> > +++ b/Documentation/devicetree/bindings/opp/qcom-opp.txt
> > @@ -23,3 +23,22 @@ Required properties:
> >  representing a corner/level that's communicated with a remote microprocessor
> >  (usually called the RPM) which then translates it into a certain voltage on
> >  a voltage rail.
> 
> I've lost the context here. Please send this all together.

Will do, as soon as I've gotten your feedback on this mail.

> 
> > +
> > +Optional properties:
> > +- opp-hz: Frequency in Hz, expressed as a 64-bit big-endian integer. Even
> > +  though a power domain doesn't need a opp-hz, there can be devices in the
> > +  power domain that need to know the highest supported frequency for each
> > +  corner/level (e.g. CPR), in order to properly initialize the hardware.
> > +
> > +- qcom,fuse-level: A positive value representing the fuse corner/level
> > +  associated with this OPP node. Sometimes several corners/levels shares
> > +  a certain fuse corner/level. A fuse corner/level contains e.g. ref uV,
> > +  min uV, and max uV.
> > +
> > +- qcom,fuse-level-<name>: Named qcom,fuse-level property. This is exactly
> > +  similar to the above qcom,fuse-level property, but allows multiple
> > +  fuse corners/levels to be provided for the same OPP. At runtime, the
> > +  platform can pick a <name> and matching qcom,fuse-level-<name> property
> > +  will be enabled for all OPPs. If the platform doesn't pick a specific
> > +  <name> or the <name> doesn't match with any qcom,fuse-level-<name>
> > +  properties, then qcom,fuse-level property shall be used, if present.
> 
> We've generally moved away from having variable property names (gpio and 
> regulators are the big exceptions) as they are harder to parse.
> 
> I'm not clear why you'd need this. Just make qcom,fuse-level an array 
> and search each 'qcom,fuse-level' for the matching level number.

This was my first thought as well, but then Viresh told me that the OPP
framework already has logic for parsing and using this.

If we call dev_pm_opp_set_prop_name(<name>)

We will automatically use all the named-properties with that suffix (e.g.):
opp-microvolt-<name>
opp-microamp-<name>
opp-fuse-corner-<name>

if and only if they exist, otherwise the regular properties will be used:
opp-microvolt
opp-microamp
opp-fuse-corner

This also means that not all OPPs will need the named variants,
e.g. if all the speedbins have the same fuse-corner:
opp-fuse-corner-speedbin0 = <1>;
opp-fuse-corner-speedbin1 = <1>;
opp-fuse-corner-speedbin2 = <1>;
this can simplified to:
opp-fuse-corner = <1>;


Another reason why I think that using named-properties might be good is
because I recently found out that certain Qualcomm SoCs have several fuse
revisions for each speedbin, e.g. msm8996 SG has 8 fuse revisions per
speedbin:
https://source.codeaurora.org/quic/la/kernel/msm-3.18/tree/arch/arm/boot/dts/qcom/msm8996pro.dtsi?h=msm-3.18#n62
https://source.codeaurora.org/quic/la/kernel/msm-3.18/tree/drivers/regulator/cpr3-hmss-regulator.c?h=msm-3.18#n88

Which means that some SoCs (in worst case) will actually need:
opp-fuse-corner-speedbin0-rev0 = <x>;
opp-fuse-corner-speedbin0-rev1 = <x>;
opp-fuse-corner-speedbin0-rev2 = <x>;
opp-fuse-corner-speedbin0-rev3 = <x>;
opp-fuse-corner-speedbin0-rev4 = <x>;
opp-fuse-corner-speedbin0-rev5 = <x>;
opp-fuse-corner-speedbin0-rev6 = <x>;
opp-fuse-corner-speedbin0-rev7 = <x>;
opp-fuse-corner-speedbin1-rev0 = <x>;
opp-fuse-corner-speedbin1-rev1 = <x>;
opp-fuse-corner-speedbin1-rev2 = <x>;
opp-fuse-corner-speedbin1-rev3 = <x>;
opp-fuse-corner-speedbin1-rev4 = <x>;
opp-fuse-corner-speedbin1-rev5 = <x>;
opp-fuse-corner-speedbin1-rev6 = <x>;
opp-fuse-corner-speedbin1-rev7 = <x>;
opp-fuse-corner-speedbin2-rev0 = <x>;
opp-fuse-corner-speedbin2-rev1 = <x>;
opp-fuse-corner-speedbin2-rev2 = <x>;
opp-fuse-corner-speedbin2-rev3 = <x>;
opp-fuse-corner-speedbin2-rev4 = <x>;
opp-fuse-corner-speedbin2-rev5 = <x>;
opp-fuse-corner-speedbin2-rev6 = <x>;
opp-fuse-corner-speedbin2-rev7 = <x>;

For each OPP.
Fortunately, it's not always this messy, some SoCs only have a single
fuse revision.
I think that having named-properties probably helps if more speedbins or
fuse-revisions are added.


I guess the alternative would be to do like downstream, where they have a
bunch of arrays instead, but then we wouldn't be able to use the logic
from the OPP framework.

	qcom,cpr-corner-fmax-map =
		/* Speed bin 0 */
		<1 6 9 14 19>, //fuse rev0
		<1 6 9 14 19>, //fuse rev1
		<3 6 9 14 19>, //fuse rev2
		<3 6 9 14 19>, //fuse rev3
		<3 6 9 14 19>, //fuse rev4
		<3 6 9 14 19>, //fuse rev5
		<3 6 9 14 19>, //fuse rev6
		<3 6 9 14 19>, //fuse rev7

		/* Speed bin 1 */
		<1 6 9 14 19>, //fuse rev0
		<1 6 9 14 19>, //fuse rev1
		<3 6 9 14 19>, //fuse rev2
		<3 6 9 14 19>, //fuse rev3
		<3 6 9 14 19>, //fuse rev4
		<3 6 9 14 19>, //fuse rev5
		<3 6 9 14 19>, //fuse rev6
		<3 6 9 14 19>, //fuse rev7

		/* Speed bin 2 */
		<1 6 9 14 19>, //fuse rev0
		<1 6 9 14 19>, //fuse rev1
		<3 6 9 14 19>, //fuse rev2
		<3 6 9 14 19>, //fuse rev3
		<3 6 9 14 19>, //fuse rev4
		<3 6 9 14 19>, //fuse rev5
		<3 6 9 14 19>, //fuse rev6
		<3 6 9 14 19>; //fuse rev7


Kind regards,
Niklas
