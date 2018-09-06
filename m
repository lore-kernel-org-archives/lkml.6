Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFE2C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F502075E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a7r+veI4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46F502075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbeIGBN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 21:13:27 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44133 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbeIGBN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 21:13:26 -0400
Received: by mail-pl1-f196.google.com with SMTP id ba4-v6so5498856plb.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 13:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VWJSkrDseIFWwmHUHCP0fIBCgd+mASwWH3pkQvWW+qQ=;
        b=a7r+veI4mJqcA0vvMJtP5Z5wP9mteHl9Ey6FnN5v7mdNxRBByceninHm0+d00IPmv0
         b1pdcP4omourQX5exeu0vYK/GRQ9hL0C3gfQ3WFDrWehPCureLeowZzSSnWYrCLwvThz
         l+Ygq6NQC3mgrOaxGSMtGebvnqJWZoMVA1bTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VWJSkrDseIFWwmHUHCP0fIBCgd+mASwWH3pkQvWW+qQ=;
        b=EAw0wSZY8QKdrzarDCwYp7M+4zmsuCyhzHEg0ghBCIw88z0J2hd1fFtf/ZuHWQ/OEa
         JkvZc9DNdsUaiXO/mc+pLH6LVtWcEIPbJL05Zsw9kO/rzKpYg7gtQ7xAIvACoN0GBJde
         KC21r+YJmgaXeWjjYLBBcKyDE131wt195QUF/yO3XvSKcxpXTN7jxCQn7xwf+m95j2ly
         Kz4aNdyR7FkY9BhonXRIBEhkUsOehMof4WCZxWdGfSNWHTS986Jitn5G2rhSD6D3pGZ8
         KhGVo6yTeUcUv+NTGH8OXiHFIQAmjNIEgs7fx9VXDW/+ZpFwMXrUHtNf23Nd+S7JXtk3
         Sz7Q==
X-Gm-Message-State: APzg51B79YE8OY5rs51xGsOUrEk58O/c5o00BwFGZbCRnDudXqYnjJ+/
        9WnCVTRXbEJNcQlN+ZIIJXHyyw==
X-Google-Smtp-Source: ANB0VdYljOdvoAjaKMVygIIn8jESeoHRccein6/36jPw6/kUCHXABMdDX+cU/3MQV2p5R0L63l838w==
X-Received: by 2002:a17:902:4a0c:: with SMTP id w12-v6mr4533607pld.289.1536266176924;
        Thu, 06 Sep 2018 13:36:16 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id g66-v6sm8893650pfk.39.2018.09.06.13.36.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 13:36:16 -0700 (PDT)
Date:   Thu, 6 Sep 2018 13:36:15 -0700
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
Message-ID: <20180906203615.GD22824@google.com>
References: <20180808191339.16875-1-mka@chromium.org>
 <20180808191339.16875-3-mka@chromium.org>
 <CAD=FV=Ug3oiHOLxYRXtr0LbBUyXjBB=92fAYfpfhEQ8Xih6PNA@mail.gmail.com>
 <20180827171003.GU160295@google.com>
 <CAD=FV=Vvhjcs9UwLkyHJ+nxwRCk70SBC3eVxBXwK7DFcPeu8wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=Vvhjcs9UwLkyHJ+nxwRCk70SBC3eVxBXwK7DFcPeu8wQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 11:34:32AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Mon, Aug 27, 2018 at 10:10 AM, Matthias Kaehlcke <mka@chromium.org> wrote:
> > On Fri, Aug 10, 2018 at 05:09:17PM -0700, Doug Anderson wrote:
> >> Hi,
> >>
> >> On Wed, Aug 8, 2018 at 12:13 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> >> > This adds the adc node to pm8998 based on the examples in the
> >> > bindings. It also fixes the order of the included headers.
> >> >
> >> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> >> > ---
> >> >  arch/arm64/boot/dts/qcom/pm8998.dtsi | 13 ++++++++++++-
> >> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> >> > index 92bed1e7d4bb..f70f6101bceb 100644
> >> > --- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
> >> > +++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> >> > @@ -1,8 +1,9 @@
> >> >  // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> >> >  /* Copyright 2018 Google LLC. */
> >> >
> >> > -#include <dt-bindings/spmi/spmi.h>
> >> > +#include <dt-bindings/iio/qcom,spmi-vadc.h>
> >> >  #include <dt-bindings/interrupt-controller/irq.h>
> >> > +#include <dt-bindings/spmi/spmi.h>
> >> >
> >> >  &spmi_bus {
> >> >         pm8998_lsid0: pmic@0 {
> >> > @@ -11,6 +12,16 @@
> >> >                 #address-cells = <1>;
> >> >                 #size-cells = <0>;
> >> >
> >> > +               pm8998_adc: adc@3100 {
> >> > +                       compatible = "qcom,spmi-adc-rev2";
> >> > +                       reg = <0x3100>;
> >> > +                       interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
> >> > +                       #address-cells = <1>;
> >> > +                       #size-cells = <0>;
> >> > +                       #io-channel-cells = <1>;
> >> > +                       io-channel-ranges;
> >> > +               };
> >>
> >> I'm a little confused about what the "io-channel-ranges" does here.
> >> The documentation isn't clear at all to me for it.  If I'm reading it
> >> right it's also supposed to be for iio-consumers, but you're using it
> >> in a provider.  I see you copied this from the example.  Maybe the
> >> example is wrong?  ...or I'm just confused...
> >
> > Yes, I copied it from the example, its use here is also not clear to
> > me, other ADC providers like adc@126c0000 in exynos3250.dtsi or
> > adc@180a6000 in bcm-cygnus.dtsi also specify it ...
> >
> > Siddartha/Jonathan, could you help to clarify if "io-channel-ranges"
> > should really be specified here as the DT example suggests?
> 
> Does everything work if you just remove the "io-channel-ranges"?

Yes, the ADC channels are still available within the kernel and
through sysfs and provide reasonable values.

> We could remove it and always add it back in later if someone could
> explain what it's for or if we find a reason why it was needed?  ...or
> we have any other ideas for how to get this resolved?  :(

Sounds good, I'll respin with 'io-channel-ranges' removed.
