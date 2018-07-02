Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624CBC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A92925AB7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A6c1soku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A92925AB7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753143AbeGBUqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 16:46:15 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38911 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752437AbeGBUqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 16:46:13 -0400
Received: by mail-pg0-f68.google.com with SMTP id c9-v6so7642416pgf.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 13:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+oi2o+UwNxCT+2z22KX/c5ygiORAaYFFW5S3r9NguRw=;
        b=A6c1sokuM3nc63VqK7wp99Q4b+m4MUWOP8FFpULrQf6C+/dOUTIg0y5ADNorhMntUa
         ehRWYlwF3gLLkxw4M0g+rWCUIMZsccBPOyZkqrTM42xW2L8P6bAyvA5L7QsOUAYfkM1C
         d22EbetlFPNSoIQ2o5hZ+VRbVV3zQnccRHhMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+oi2o+UwNxCT+2z22KX/c5ygiORAaYFFW5S3r9NguRw=;
        b=VtQlTQ9PlMCjsbICWQVl0g5Bi0FElGVLMffRO1fLACsRSGGKbwaVx5sYIBooeKZ4db
         4YZQKw8IDCQvR+2WiYytHW6HSY8oLKdjSTjEMTeouDtxPI/qyQYHvlciaqwiNA8aUMl1
         KIcOVvkqOWs35ONGupdc+9RV+iCPpdRuAnRwhL+qjPLrNd/9WbxDo/k67r2qf5uneV+R
         kMRoF0p1llNZsNDO58ypmY8w2wfsvqlVeVvzBcZtiwp8EndnMdogmRFR4CWm1zhi2PuM
         zLls3G/BkVNMdEk7dmppcCjZTscAhQjInpJfH0u347SNfiP6Iux75l8dh3k60rbOqzm7
         hvyQ==
X-Gm-Message-State: APt69E0Y7VP87uwDqu8HMUnMJA41raaHv6n7hLPFzz3gsTtnjWNPk3rf
        RmVxoSuNgT4qd8eu5ykoT4AjRQ==
X-Google-Smtp-Source: AAOMgpc5IEx45dWKkIoduMm6wv6n3zcX1hY64kwm23YsICrKa9A3HpPhcq2Chymb9MmrPiTxeU4eag==
X-Received: by 2002:a63:5624:: with SMTP id k36-v6mr2734932pgb.146.1530564372821;
        Mon, 02 Jul 2018 13:46:12 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id r89-v6sm10483326pfa.75.2018.07.02.13.46.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 13:46:12 -0700 (PDT)
Date:   Mon, 2 Jul 2018 13:46:11 -0700
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
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: pm8998: Add pm8998 thermal zone
Message-ID: <20180702204611.GZ129942@google.com>
References: <20180702181005.18247-1-mka@chromium.org>
 <20180702181005.18247-2-mka@chromium.org>
 <CAD=FV=WH8q-3Rt89Get0N357+hWmKiEsruaKtWzo_JoE6gd_3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=WH8q-3Rt89Get0N357+hWmKiEsruaKtWzo_JoE6gd_3g@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 12:53:44PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Mon, Jul 2, 2018 at 11:10 AM, Matthias Kaehlcke <mka@chromium.org> wrote:
> > The thermal zone uses spmi-temp-alarm as sensor. If the sensor is
> > configured without an IIO input it always reports 37°C for temperatures
> > below the first hardware trip point at 105°C. This hardware trip point
> > is configured as critical trip point, to initiate a system shutdown
> > before the temperature reaches the next hardware trip point at 125°C,
> > where the PMIC performs a partial shutdown.
> >
> > The temperature of the critical trip point can be raised after adding
> > the die temperature ADC as IIO input for spmi-temp-alarm, which
> > significantly increases the precision of the temperature measurements.
> >
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > Changes in v2:
> > - defined 'thermal-zones' node in pm8998.dtsi instead of using a label
> >   to refer to it
> > - use 105°C hardware trip point as critical trip point
> 
> I'm not sure this was right.  I guess you're trying to avoid
> Temperature Stage 2?

Indeed

> From Davi'd email in response to v1:
> 
> > The PMIC TEMP_ALARM hardware peripheral will perform an automatic partial
> > PMIC shutdown upon hitting over-temperature stage 2 (125 C).  This turns
> > off peripherals within the PMIC that are expected to draw significant
> > current.  The set of peripherals included varies between PMICs.  This
> > partial shutdown will occur simultaneously with the triggering of an
> > interrupt to the APPS processor that informs the qcom-spmi-temp-alarm
> > driver that an over-temperature threshold has been crossed.
> 
> I think it's actually OK to use Temperature Stage 2 as the "critical"
> point, which is why it still interrupts the CPU.  At "critical" the
> system will shut down, right?  ...so presumably it's OK if the drivers
> can't recover from having the power yanked out from underneath them as
> long as they don't hang/crash the system in this case.  If I had to
> guess the whole point of this stage is to give the system shutdown a
> better chance of succeeding without getting to stage 3.

That was my starting point, however in my tests the system reset
several times when the temperature got close to 125°C, not allowing
for a proper shutdown. Apparently the partial shutdown of the PMIC can
result in a full reset at least on some systems.

> I do agree, however, that removing the "145" from the device tree was
> the right thing to do since software will never see that.  The system
> will just shut down.
> 
> 
> > - reduced number of trip points to 2
> > - lowered temperature of passive trip point
> 
> This won't actually do anything until the ADC gets hooked up, right?

Correct

> I guess I would have expected:
> - 105: passive
> - 125: critical
> 
> ...and then we could add (if we wanted) a "hot" between passive and
> critical once we have the ADC hooked up?

Exactly, once we have more granularity we could add (an)other trip point(s).

> > - updated trip point names and added labels
> > - updated commit message
> >
> >  arch/arm64/boot/dts/qcom/pm8998.dtsi | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> > index 2f4989e7ef68..e7caa334e6c7 100644
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
> > @@ -60,3 +61,27 @@
> >                 #size-cells = <0>;
> >         };
> >  };
> > +
> > +/ {
> > +       thermal-zones {
> > +               pm8998 {
> > +                       polling-delay-passive = <250>;
> > +                       polling-delay = <1000>;
> > +
> > +                       thermal-sensors = <&pm8998_temp>;
> > +
> > +                       trips {
> > +                               pm8998_alert0: pm8998-alert0 {
> > +                                       temperature = <95000>;
> > +                                       hysteresis = <2000>;
> > +                                       type = "passive";
> > +                               };
> > +                               pm8998_crit: pm8998-crit {
> > +                                       temperature = <105000>;
> > +                                       hysteresis = <2000>;
> > +                                       type = "critical";
> > +                               };
> > +                       };
> > +               };
> > +       };
> > +};
> 
> A nit, but I think convention is to actually put additions straight to
> the root node before reference to phandles, so I would have put this
> above the "&spmi_bus" part.

Ok, thanks, will do in v3
