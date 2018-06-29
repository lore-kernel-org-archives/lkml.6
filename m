Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651B8C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 23:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D5E24F6F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 23:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gRrdOw85"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12D5E24F6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936571AbeF2XyX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 19:54:23 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38363 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936131AbeF2XyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 19:54:19 -0400
Received: by mail-pl0-f65.google.com with SMTP id d10-v6so5159146plo.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 16:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=24Ey+gmb6R582QBzNaKviCkBbNHZhRq2DxHTONhwfW0=;
        b=gRrdOw85FIbD1aA1ZqBf0I7cAhw3hDu8+LdsFvQvUNbJftmZNMhF6iMQGjsL7RCn8x
         q76rb/v5pZ6Ywry3PBnE6pCtjoJX2SVlj2TyMkvmfo6ekmGTf69X0FlkFylTivpYTSr5
         zQNvlHHopcaHdAjQF3+c30s83dhGsridxoIrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=24Ey+gmb6R582QBzNaKviCkBbNHZhRq2DxHTONhwfW0=;
        b=fSwcQj4mbrCEOzoVjq6ensfV8jtZg+7Jnt6BMvUHJ4ZeiYR4Po59lgU4ahskmfBvZO
         1gCgqhVZ9ztTGtelPEpzEJBOd2X32F7bBoc+Qz9EmgmwaF8HFdk0sbXtef9PrhevVr9T
         q6K98ak1YxgMibuib+BtFxdYhO8h29ceWK2N91N1koFUqLXmNuEvwyZOlDhZFeAHEnMK
         3WpRrr4wuffuOSQa3mxu4piHpX1Dpunjl3sJJ3/JcuwFxWMWZ5KlsrIPUF8PVP/zXcjt
         kIIEHVapBzzQ6zCKklHP9ojnp+ly53s3QOLV4A46Xkbd5qa7TWEFg6YFK3Bjjuf0oQQf
         aLcg==
X-Gm-Message-State: APt69E3KoczE0hHEZRFRajXFGwPcBoHfk/ZEO+D9mnm+P1V9P1ebp+2A
        oopHlLPJgrMTKCQomDy16qooiw==
X-Google-Smtp-Source: ADUXVKIx1248cHllzXPvYXnXOXyeIYB6sBuDzYSpbZnH7O3QQb38G4m79MHMj0xKl3MgK+Cd8ZQX9A==
X-Received: by 2002:a17:902:7896:: with SMTP id q22-v6mr16443544pll.243.1530316458589;
        Fri, 29 Jun 2018 16:54:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id f128-v6sm17642881pfg.176.2018.06.29.16.54.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 16:54:17 -0700 (PDT)
Date:   Fri, 29 Jun 2018 16:54:17 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     David Collins <collinsd@codeaurora.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: pm8998: Add thermal zone
Message-ID: <20180629235417.GY129942@google.com>
References: <20180628210915.160893-1-mka@chromium.org>
 <20180628210915.160893-3-mka@chromium.org>
 <CAD=FV=Wo4wc_QZYr0a2_Ge=B6T4RNJDnOyxAd8r6sT4iZJjCKg@mail.gmail.com>
 <20180629185102.GV129942@google.com>
 <3b5054bb-76e4-a06f-54bb-e6ea7bbbcc69@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b5054bb-76e4-a06f-54bb-e6ea7bbbcc69@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 02:29:55PM -0700, David Collins wrote:
> Hello Matthias,
> 
> On 06/29/2018 11:51 AM, Matthias Kaehlcke wrote:
> > On Thu, Jun 28, 2018 at 03:58:41PM -0700, Doug Anderson wrote:
> >> Hi,
> >>
> >> On Thu, Jun 28, 2018 at 2:09 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> >>> Add pm8998 thermal zone based on the examples in the spmi-temp-alarm
> >>> bindings.
> >>>
> >>> Note: devices with the pm8998 need to have a 'thermal-zones' node (which
> >>> may be empty) with a label 'thermal_zones'.
> >>>
> >>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> >>> ---
> >>>  arch/arm64/boot/dts/qcom/pm8998.dtsi | 28 ++++++++++++++++++++++++++++
> >>>  1 file changed, 28 insertions(+)
> >>
> >> Do you know if this patch actually does anything since you didn't
> >> define a cooling-maps?  Hopefully at least the critical shuts things
> >> down?
> > 
> > I need to do some additional testing, currently waiting to get the
> > heat gun back ...
> > 
> > I would expect the critical trip point to shut the system down, though
> > I'm not sure whether the HW temperature watchdog wouldn't cut power
> > before that. The documentation I have access to contains some register
> > descriptions, but isn't very verbose about the overall behavior and
> > from the driver code that's also not really clear to me. The driver
> > "disables software override of stage 2 and 3 shutdowns" which make me
> > guess that a hardware shutdown kicks in at stage 2 (135°C ?). This
> > would be roughly in line with a system reset I observed in an earlier
> > test at a temperature > 125°C. If that's correct the trip points need
> > to be revisited.
> > 
> > Maybe David Collins who recently extended the driver to add support
> > for GEN2 PMIC peripherals can provide more details.
> 
> The PMIC TEMP_ALARM hardware peripheral will perform an automatic partial
> PMIC shutdown upon hitting over-temperature stage 2 (125 C).  This turns
> off peripherals within the PMIC that are expected to draw significant
> current.  The set of peripherals included varies between PMICs.  This
> partial shutdown will occur simultaneously with the triggering of an
> interrupt to the APPS processor that informs the qcom-spmi-temp-alarm
> driver that an over-temperature threshold has been crossed.
> 
> The TEMP_ALARM peripheral will perform an automatic full PMIC shutdown
> upon hitting over-temperature stage 3 (145 C).  Software won't receive an
> interrupt in this case because all power is cut.

This information is very useful, thanks David!

The (partial) hardware shutdown seems like a good measure of last
resort, however I suppose we prefer Linux to initiate a shutdown
before losing part of the peripherals (drivers might not be happy
about this and probably not revover even when the temperature goes
down again) or reach a full PMIC shutdown.

Please let me know if there are reasons to prefer to go the hardware
limits, it's also an option for device makers to overwrite these
settings if they want different behavior.

> If you are not specifying an ADC channel for the qcom-spmi-temp-alarm
> device (which would allow for polling of the real-time PMIC die
> temperature), then notifications about stage 0 -> 1 and 1 -> 0 transitions
> (105 C) are the only time that software could take meaningful corrective
> action to avoid a PMIC automatic partial or full shutdown.

Thanks, I already experimented a a bit with this. For the record, the
driver is https://patchwork.kernel.org/patch/10494771/ (this version
is broken though).

Cheers

Matthias
