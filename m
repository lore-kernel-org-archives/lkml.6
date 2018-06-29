Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404EAC6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D1A278BB
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MUp9yQ1l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4D1A278BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936732AbeF2SvL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:51:11 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40440 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936682AbeF2SvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:51:04 -0400
Received: by mail-pl0-f65.google.com with SMTP id t6-v6so4868737plo.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 11:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=eM3YVBkgyE2jRQZKwU2L9rlhR1D8qi6jFxmVE8pLDnw=;
        b=MUp9yQ1lCKJ1lPaPzXNSZWhKmEt4IVkltIe/1bxaMxqvtlfSHpbT3d/1w5uLxKBJ6U
         ric7dEunW34kp2rRqFvmSwXkramcNlYBFLrIptYdbTZSDWQDbe27ZWs8XHhkcECHXX79
         TnTHCiTBsWF9odx92EQoMyw1BYY+/S7hQYxSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=eM3YVBkgyE2jRQZKwU2L9rlhR1D8qi6jFxmVE8pLDnw=;
        b=fIJKxwnyEtN5rdSzZX9vXLXeoVSevcJeMIO2k+Q1CZpO0boPMXOlIOUF4hQzKRYTPE
         XEKH2IRkZvLxTh2VTVzUA8hSpjM2vTnZGKu/ZUlYsJHt5tUTPv6gGX2uEjzca39t107v
         E3G9+sHdIzhcImZJsU5AZilFO4lxQCNuMYQNUf1++ck+OtIkjqeZ23uKx2xksOA84J9q
         OkNB/0ErvrPGgGVKfjXN6z/Cj4PjJJa6YmvKznqHC+3GrQnFXBrLdpc1h3ZEkNSvZw1k
         5ib7ESfCRFlFYYH7pNysir8J2hTTVFUs+V9jchMP/OBonvZWKjb1bxlFs9ry2ZIDjXFB
         TZ9w==
X-Gm-Message-State: APt69E1mcSj3+puRe2CU6jD2+j2DelZnvD5PVXU0eAof75xngjg3K1Qw
        Im/PrckybcRHq1sK9URE5VeKhA==
X-Google-Smtp-Source: AAOMgpfx5bVzHN4YfFXtUYlf0BxbWUVYBuRTTQmIP5c6MKsCGWVaATLis+HgVaSMMH6fhneVstvbZQ==
X-Received: by 2002:a17:902:24a5:: with SMTP id w34-v6mr3477463pla.52.1530298263799;
        Fri, 29 Jun 2018 11:51:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id t192-v6sm14283170pgc.74.2018.06.29.11.51.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 11:51:03 -0700 (PDT)
Date:   Fri, 29 Jun 2018 11:51:02 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: pm8998: Add thermal zone
Message-ID: <20180629185102.GV129942@google.com>
References: <20180628210915.160893-1-mka@chromium.org>
 <20180628210915.160893-3-mka@chromium.org>
 <CAD=FV=Wo4wc_QZYr0a2_Ge=B6T4RNJDnOyxAd8r6sT4iZJjCKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=Wo4wc_QZYr0a2_Ge=B6T4RNJDnOyxAd8r6sT4iZJjCKg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 03:58:41PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Thu, Jun 28, 2018 at 2:09 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> > Add pm8998 thermal zone based on the examples in the spmi-temp-alarm
> > bindings.
> >
> > Note: devices with the pm8998 need to have a 'thermal-zones' node (which
> > may be empty) with a label 'thermal_zones'.
> >
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  arch/arm64/boot/dts/qcom/pm8998.dtsi | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> 
> Do you know if this patch actually does anything since you didn't
> define a cooling-maps?  Hopefully at least the critical shuts things
> down?

I need to do some additional testing, currently waiting to get the
heat gun back ...

I would expect the critical trip point to shut the system down, though
I'm not sure whether the HW temperature watchdog wouldn't cut power
before that. The documentation I have access to contains some register
descriptions, but isn't very verbose about the overall behavior and
from the driver code that's also not really clear to me. The driver
"disables software override of stage 2 and 3 shutdowns" which make me
guess that a hardware shutdown kicks in at stage 2 (135°C ?). This
would be roughly in line with a system reset I observed in an earlier
test at a temperature > 125°C. If that's correct the trip points need
to be revisited.

Maybe David Collins who recently extended the driver to add support
for GEN2 PMIC peripherals can provide more details.

> Do you have any idea how we'll eventually want to specify a
> cooling-maps?  Are we just going to assume we're included by an sdm845
> device and refer to the big/little CPU phandles?

No clear idea on my side at this point, but limiting CPU frequencies
seems likely, potentially also devfreq devices.

> > diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> > index f2d39074ed74..d85ceb4f976b 100644
> > --- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> > @@ -3,6 +3,7 @@
> >
> >  #include <dt-bindings/spmi/spmi.h>
> >  #include <dt-bindings/interrupt-controller/irq.h>
> > +#include <dt-bindings/thermal/thermal.h>
> >
> >  &spmi_bus {
> >         pm8998_lsid0: pmic@0 {
> > @@ -59,3 +60,30 @@
> >                 #size-cells = <0>;
> >         };
> >  };
> > +
> > +&thermal_zones {
> 
> As per comments in patch #1, don't rely on a label.  Just put your
> stuff in a top-level "thermal-zones" node.

ack

> > +       pm8998 {
> > +               polling-delay-passive = <250>;
> > +               polling-delay = <1000>;
> > +
> > +               thermal-sensors = <&pm8998_temp>;
> > +
> > +               trips {
> > +                       passive {
> 
> IMO you should proactively put a label on these trips even if there's
> no cooling device yet.  It's expected that at some point someone will
> add a cooling device and refer to them, right?

ok
