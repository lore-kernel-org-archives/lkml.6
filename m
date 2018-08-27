Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E74C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 17:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE5F9208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 17:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WhmvIW4f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE5F9208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbeH0U5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 16:57:31 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35691 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbeH0U5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 16:57:31 -0400
Received: by mail-pf1-f194.google.com with SMTP id p12-v6so8039704pfh.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 10:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X7xyYrLEGjCD9cZd0Fg3/J3UV79BVfjeLisH32dYsls=;
        b=WhmvIW4fJhYnuunoxdYLTVbcXiSiUWvcpF8jw+nBjYgRe1Iat7NR6qCdvSjQSvZx4P
         4iU//8nXWyfDYK8PR1oZ3/lEuR66UmSFr+/Nr5E2xSo1Ah3x3U+8a3PVBlidtkj5IaNx
         E5RY/HQW+w/HnPIf8MAVwJm9b1wqk5/ZL/XTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X7xyYrLEGjCD9cZd0Fg3/J3UV79BVfjeLisH32dYsls=;
        b=FrQmlto3j2OwdQ40MFLm0hvwaFBlxuScu0t8A862J1mA99OP/B5SWRyuEVPNnBk376
         3LVX/wEtgWvMClxvXtOC+aWm6UvbmfKLfza8wSLXT6oCG93ewQnKg96pWI5qTWCpwlla
         vid1FWJX6T4+IWFF+unaBrIqx/F7lEjPT02koog8RZG+N0NQc3qDPKtJd4ioS3wqDpHS
         PSCzsz889BOg1B1G3IjC3r/QLf5+7lfHjkq7vSXrazg8ExS+MjJc2umDWoK0GASnHUHG
         0uMPSqwHrainCmz2M/2LhMyxRRCWCJK0d+8L6/6qSC1gmSic/gdPuprL9QRlDQ4CpTAd
         fJUA==
X-Gm-Message-State: APzg51BQ1X2Y45/UIPvkjfr9QmGtm9jn7r/n+kOi6PZUengOnVcuibJd
        FpQZB8/NKTCMvGZgZdhYF8LvsQ==
X-Google-Smtp-Source: ANB0Vdb3sLqqKo5HPlIpI1jgwyvBfsI1EnbWtZBc9ZX+mL42sni+0H5GxzenRuS1aDnS+2aeqZvmGA==
X-Received: by 2002:a62:5cc1:: with SMTP id q184-v6mr15403095pfb.241.1535389804881;
        Mon, 27 Aug 2018 10:10:04 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id c88-v6sm25664429pfe.132.2018.08.27.10.10.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 10:10:04 -0700 (PDT)
Date:   Mon, 27 Aug 2018 10:10:03 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 2/3] arm64: dts: qcom: pm8998: Add adc node
Message-ID: <20180827171003.GU160295@google.com>
References: <20180808191339.16875-1-mka@chromium.org>
 <20180808191339.16875-3-mka@chromium.org>
 <CAD=FV=Ug3oiHOLxYRXtr0LbBUyXjBB=92fAYfpfhEQ8Xih6PNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=Ug3oiHOLxYRXtr0LbBUyXjBB=92fAYfpfhEQ8Xih6PNA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 05:09:17PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Wed, Aug 8, 2018 at 12:13 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> > This adds the adc node to pm8998 based on the examples in the
> > bindings. It also fixes the order of the included headers.
> >
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  arch/arm64/boot/dts/qcom/pm8998.dtsi | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> > index 92bed1e7d4bb..f70f6101bceb 100644
> > --- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> > @@ -1,8 +1,9 @@
> >  // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> >  /* Copyright 2018 Google LLC. */
> >
> > -#include <dt-bindings/spmi/spmi.h>
> > +#include <dt-bindings/iio/qcom,spmi-vadc.h>
> >  #include <dt-bindings/interrupt-controller/irq.h>
> > +#include <dt-bindings/spmi/spmi.h>
> >
> >  &spmi_bus {
> >         pm8998_lsid0: pmic@0 {
> > @@ -11,6 +12,16 @@
> >                 #address-cells = <1>;
> >                 #size-cells = <0>;
> >
> > +               pm8998_adc: adc@3100 {
> > +                       compatible = "qcom,spmi-adc-rev2";
> > +                       reg = <0x3100>;
> > +                       interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +                       #io-channel-cells = <1>;
> > +                       io-channel-ranges;
> > +               };
> 
> I'm a little confused about what the "io-channel-ranges" does here.
> The documentation isn't clear at all to me for it.  If I'm reading it
> right it's also supposed to be for iio-consumers, but you're using it
> in a provider.  I see you copied this from the example.  Maybe the
> example is wrong?  ...or I'm just confused...

Yes, I copied it from the example, its use here is also not clear to
me, other ADC providers like adc@126c0000 in exynos3250.dtsi or
adc@180a6000 in bcm-cygnus.dtsi also specify it ...

Siddartha/Jonathan, could you help to clarify if "io-channel-ranges"
should really be specified here as the DT example suggests?

Thanks

Matthias
