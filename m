Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E05C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67C8C20665
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cAbpcs8Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbfAJUAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 15:00:37 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39780 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfAJUAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 15:00:37 -0500
Received: by mail-pl1-f193.google.com with SMTP id 101so5644087pld.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 12:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ETLTTVmmGQjDSKo3kjr+5Xsy/UJX2sE6JAJ7UGzQDq0=;
        b=cAbpcs8QKu42ewNVszirk6vBbt2fCWldutBFi66uJM3b1qyNIV8TCAirSllcYLgBT/
         d+t2OK+iKBB210EiYV0LdpY2jEDVkNMGfVK9I+ojAEM3fET5KpXaS3fz7r7UPUZ344Xr
         BL7MXrFmjZpliEtJV5vxY4vnu8BXz76SSNwp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ETLTTVmmGQjDSKo3kjr+5Xsy/UJX2sE6JAJ7UGzQDq0=;
        b=LhnPIPpBpwgRZxEtaSvl6AtzlRQbR3/X2H0SACes7POPPh4pia5t/qMLmbgOtP1TQ0
         v5jUo43w63pXq1bxzHGfr/teffYGOo4+RhF0ylx96050LAlsQMpK5Ss1frRdpyfQEEiN
         je2op1IADMsSP7qK6+E4nxZA0Rgz7iRwpMzja6LRuUZtFIeP2s9Gyepj0fgq7cRZ1fMp
         KxkKIJvrD/gSCR+mnhF5pJ6JwzpBb8Gjz9jNTDnJllDl+RXQ4HPqIf7cjhz63G79KyIz
         +P++wSdkEl8UkNuRg3GT61Ysy/BffRYMgv8oadAnyibRVZmdJbNiqkFZ12MeTMuM7YXQ
         x9Ug==
X-Gm-Message-State: AJcUukd7YKbmKPVG582V6KHx4BWyJPGftr6HjLOZcBoZlWSS3WMpmEtp
        M4rb8SteBUmZ0M+xO+outyB7rg==
X-Google-Smtp-Source: ALg8bN4vjMs68o+NvUluZOWwIC2o+aVIQNMIuu5qYU1lWFQqijNuW0ouBP0cTdYgq6VgrrF6LS4zTw==
X-Received: by 2002:a17:902:29ab:: with SMTP id h40mr11597333plb.238.1547150436134;
        Thu, 10 Jan 2019 12:00:36 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id j197sm116343932pgc.76.2019.01.10.12.00.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 12:00:35 -0800 (PST)
Date:   Thu, 10 Jan 2019 12:00:34 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Taniya Das <tdas@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v1 6/7] arm64: dts: sdm845: Increase alert trip point to
 95 degrees
Message-ID: <20190110200034.GZ261387@google.com>
References: <cover.1547078153.git.amit.kucheria@linaro.org>
 <041258d65883df964890249a24d2a4788c419304.1547078153.git.amit.kucheria@linaro.org>
 <20190110011533.GV261387@google.com>
 <20190110021522.GW261387@google.com>
 <CAHLCerM+p+GkVsR_WuC0xF1oFvj=8cZ+OmU=pMssfZGGs-eS7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHLCerM+p+GkVsR_WuC0xF1oFvj=8cZ+OmU=pMssfZGGs-eS7w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 01:15:09AM +0530, Amit Kucheria wrote:
> On Thu, Jan 10, 2019 at 7:45 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > On Wed, Jan 09, 2019 at 05:15:33PM -0800, Matthias Kaehlcke wrote:
> > > Hi Amit,
> > >
> > > On Thu, Jan 10, 2019 at 05:30:55AM +0530, Amit Kucheria wrote:
> > > > 75 degrees is too aggressive for throttling the CPU. After speaking to
> > > > Qualcomm engineers, increase it to 95 degrees.
> > > >
> > > > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > > > ---
> > > >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 16 ++++++++--------
> > > >  1 file changed, 8 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > > index c27cbd3bcb0a..29e823b0caf4 100644
> > > > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > > @@ -1692,7 +1692,7 @@
> > > >
> > > >                     trips {
> > > >                             cpu_alert0: trip0 {
> > > > -                                   temperature = <75000>;
> > > > +                                   temperature = <95000>;
> > > >                                     hysteresis = <2000>;
> > > >                                     type = "passive";
> > > >                             };
> > > > @@ -1713,7 +1713,7 @@
> > > >
> > > >                     trips {
> > > >                             cpu_alert1: trip0 {
> > > > -                                   temperature = <75000>;
> > > > +                                   temperature = <95000>;
> > > >                                     hysteresis = <2000>;
> > > >                                     type = "passive";
> > > >                             };
> > > > @@ -1734,7 +1734,7 @@
> > > >
> > > >                     trips {
> > > >                             cpu_alert2: trip0 {
> > > > -                                   temperature = <75000>;
> > > > +                                   temperature = <95000>;
> > > >                                     hysteresis = <2000>;
> > > >                                     type = "passive";
> > > >                             };
> > > > @@ -1755,7 +1755,7 @@
> > > >
> > > >                     trips {
> > > >                             cpu_alert3: trip0 {
> > > > -                                   temperature = <75000>;
> > > > +                                   temperature = <95000>;
> > > >                                     hysteresis = <2000>;
> > > >                                     type = "passive";
> > > >                             };
> > > > @@ -1776,7 +1776,7 @@
> > > >
> > > >                     trips {
> > > >                             cpu_alert4: trip0 {
> > > > -                                   temperature = <75000>;
> > > > +                                   temperature = <95000>;
> > > >                                     hysteresis = <2000>;
> > > >                                     type = "passive";
> > > >                             };
> > > > @@ -1797,7 +1797,7 @@
> > > >
> > > >                     trips {
> > > >                             cpu_alert5: trip0 {
> > > > -                                   temperature = <75000>;
> > > > +                                   temperature = <95000>;
> > > >                                     hysteresis = <2000>;
> > > >                                     type = "passive";
> > > >                             };
> > > > @@ -1818,7 +1818,7 @@
> > > >
> > > >                     trips {
> > > >                             cpu_alert6: trip0 {
> > > > -                                   temperature = <75000>;
> > > > +                                   temperature = <95000>;
> > > >                                     hysteresis = <2000>;
> > > >                                     type = "passive";
> > > >                             };
> > > > @@ -1839,7 +1839,7 @@
> > > >
> > > >                     trips {
> > > >                             cpu_alert7: trip0 {
> > > > -                                   temperature = <75000>;
> > > > +                                   temperature = <95000>;
> > > >                                     hysteresis = <2000>;
> > > >                                     type = "passive";
> > > >                             };
> > >
> > > The change itself looks good to me, however I wonder if it would be
> > > worth to eliminate redundancy and merge the current 8 thermal zones
> > > into 2, one for the Silver and one for the Gold cluster (as done by
> > > http://crrev.com/c/1381752). There is a single cooling device for
> > > each cluster, so it's not clear to me if there is any gain from having
> > > a separate thermal zone for each CPU. If it is important to monitor
> > > the temperatures of the individual cores this can still be done by
> > > configuring the thermal zone of the cluster with multiple thermal
> > > sensors.
> >
> > I see your idea is to have a cooling device per CPU ("arm64: dts:
> > sdm845: wireup the thermal trip points to cpufreq" /
> > https://lore.kernel.org/patchwork/patch/1030742/), however that
> > doesn't work as intended. Only two cpufreq 'devices' are created,
> > one for CPU0 and one for CPU4. In consequence cpufreq->ready() only
> > runs for these cores and only two cooling devices are
> > registered. Since the cores of a cluster all run at the same
> > frequency I also doubt if having multiple cooling devices would
> > bring any benefits.
> 
> I actually only intended for two cooling devices - one for each
> frequency domain. I'll clarify it better in the patch description.

Viresh helped me understand that we currently need to add cooling
device entries for all CPUs to the DT, even though at most one will be
active per freq domain at any time (I wonder if this could be changed
though).

Independently of the cooling devices, is there any value in having a
thermal zone for each CPU instead of having only one per freq domain?

Thanks

Matthias
