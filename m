Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C40C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 02:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9AF214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 02:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gP8T2mJx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfAJCPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 21:15:25 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41242 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfAJCPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 21:15:24 -0500
Received: by mail-pf1-f193.google.com with SMTP id b7so4562749pfi.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 18:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tWFDYhahir1R0mCqKfkSgNOuYf/yckRop+rHiVTpwdU=;
        b=gP8T2mJxzmxHl4wiumQraM/zazFd53+d5dpHi+xKNa5xkimR2nrejwaRBGsLBKEDAd
         D3N/EpNkWme8ImeZq3W10PKG6UJNxY4abp+nJd6lh3fbIcLJ7YuGcSFDjEyGoeelXl+f
         enmIdRHsouRf7C3OmrZZWdTZoGM8ASnK5yaqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tWFDYhahir1R0mCqKfkSgNOuYf/yckRop+rHiVTpwdU=;
        b=IgsMO+ncMvxgpcpcPoOgB5Lq6Oxs1MCcJjpbocnT+IOvTV1xMoekHRiXXhL07BPXfg
         1LZmctdcXfU3C4hybasMkG3dmnoQ/Q8k3i8L+lAoYesiaUsNKI0CIj66txQksFCzuKPo
         rPbcTJpNTL6/abjd2Vt89YAKtW+L3pzzkyxaLBvmh2vmJeJ6KYIuLbEVV8OdIzm3s06q
         MATBXQMGucqQ5WC/lG87VfC0OEmAdVCvuB8o6rrdpcXoAoPDfMtnRy51CvDULeVQDoC5
         70sG6lctipL7Eu+w04tC04uqwb8pdbqVJI+vHlW0YX7ObEozo9Vin8voiUX+S8nW/kEc
         zBbg==
X-Gm-Message-State: AJcUukes++WfiNaAu+Xw3OOYCksl14Zflxz10jrXLx6jbWjg6TSzVqvL
        MaktaEX+jtUfUzV8HmnI3bpqNnIjZKQhNg==
X-Google-Smtp-Source: ALg8bN5MomFWvY4hpBT2QOWQE6P/3CG4dNTuOwZcgyYoz55CO6tKvfLj37CesaADRo3D2za+Fxqy0w==
X-Received: by 2002:a63:f65:: with SMTP id 37mr7604550pgp.238.1547086523728;
        Wed, 09 Jan 2019 18:15:23 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id f13sm102036262pfa.132.2019.01.09.18.15.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 18:15:23 -0800 (PST)
Date:   Wed, 9 Jan 2019 18:15:22 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, andy.gross@linaro.org, tdas@codeaurora.org,
        swboyd@chromium.org, dianders@chromium.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v1 6/7] arm64: dts: sdm845: Increase alert trip point to
 95 degrees
Message-ID: <20190110021522.GW261387@google.com>
References: <cover.1547078153.git.amit.kucheria@linaro.org>
 <041258d65883df964890249a24d2a4788c419304.1547078153.git.amit.kucheria@linaro.org>
 <20190110011533.GV261387@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190110011533.GV261387@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 05:15:33PM -0800, Matthias Kaehlcke wrote:
> Hi Amit,
> 
> On Thu, Jan 10, 2019 at 05:30:55AM +0530, Amit Kucheria wrote:
> > 75 degrees is too aggressive for throttling the CPU. After speaking to
> > Qualcomm engineers, increase it to 95 degrees.
> > 
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > index c27cbd3bcb0a..29e823b0caf4 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > @@ -1692,7 +1692,7 @@
> >  
> >  			trips {
> >  				cpu_alert0: trip0 {
> > -					temperature = <75000>;
> > +					temperature = <95000>;
> >  					hysteresis = <2000>;
> >  					type = "passive";
> >  				};
> > @@ -1713,7 +1713,7 @@
> >  
> >  			trips {
> >  				cpu_alert1: trip0 {
> > -					temperature = <75000>;
> > +					temperature = <95000>;
> >  					hysteresis = <2000>;
> >  					type = "passive";
> >  				};
> > @@ -1734,7 +1734,7 @@
> >  
> >  			trips {
> >  				cpu_alert2: trip0 {
> > -					temperature = <75000>;
> > +					temperature = <95000>;
> >  					hysteresis = <2000>;
> >  					type = "passive";
> >  				};
> > @@ -1755,7 +1755,7 @@
> >  
> >  			trips {
> >  				cpu_alert3: trip0 {
> > -					temperature = <75000>;
> > +					temperature = <95000>;
> >  					hysteresis = <2000>;
> >  					type = "passive";
> >  				};
> > @@ -1776,7 +1776,7 @@
> >  
> >  			trips {
> >  				cpu_alert4: trip0 {
> > -					temperature = <75000>;
> > +					temperature = <95000>;
> >  					hysteresis = <2000>;
> >  					type = "passive";
> >  				};
> > @@ -1797,7 +1797,7 @@
> >  
> >  			trips {
> >  				cpu_alert5: trip0 {
> > -					temperature = <75000>;
> > +					temperature = <95000>;
> >  					hysteresis = <2000>;
> >  					type = "passive";
> >  				};
> > @@ -1818,7 +1818,7 @@
> >  
> >  			trips {
> >  				cpu_alert6: trip0 {
> > -					temperature = <75000>;
> > +					temperature = <95000>;
> >  					hysteresis = <2000>;
> >  					type = "passive";
> >  				};
> > @@ -1839,7 +1839,7 @@
> >  
> >  			trips {
> >  				cpu_alert7: trip0 {
> > -					temperature = <75000>;
> > +					temperature = <95000>;
> >  					hysteresis = <2000>;
> >  					type = "passive";
> >  				};
> 
> The change itself looks good to me, however I wonder if it would be
> worth to eliminate redundancy and merge the current 8 thermal zones
> into 2, one for the Silver and one for the Gold cluster (as done by
> http://crrev.com/c/1381752). There is a single cooling device for
> each cluster, so it's not clear to me if there is any gain from having
> a separate thermal zone for each CPU. If it is important to monitor
> the temperatures of the individual cores this can still be done by
> configuring the thermal zone of the cluster with multiple thermal
> sensors.

I see your idea is to have a cooling device per CPU ("arm64: dts:
sdm845: wireup the thermal trip points to cpufreq" /
https://lore.kernel.org/patchwork/patch/1030742/), however that
doesn't work as intended. Only two cpufreq 'devices' are created,
one for CPU0 and one for CPU4. In consequence cpufreq->ready() only
runs for these cores and only two cooling devices are
registered. Since the cores of a cluster all run at the same
frequency I also doubt if having multiple cooling devices would
bring any benefits.

Cheers

Matthias
