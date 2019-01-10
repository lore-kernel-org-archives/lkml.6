Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42DAC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89694208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aqIKBydO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbfAJSmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 13:42:44 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43616 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728553AbfAJSmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 13:42:44 -0500
Received: by mail-pg1-f195.google.com with SMTP id v28so5170528pgk.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 10:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+ChpzuumKUvOlv8AlEUsD9rxuhOXdKjPxVxXvtOhCC0=;
        b=aqIKBydOl2wtTRtkCbuXnohr7GmyQs9nTnBp3R2l+crL2ebV/pQ0chh5VkE4VzGbKp
         IL/ukTGTxGdhFLPn7BzZ3DllkC1woq1sFqLzfIKEZ4HHkhkdOr0E0ODSunpswhLBVfbF
         ykEPefkqfVE4R1wH5hmFBpsiQNjAbLNdDciyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+ChpzuumKUvOlv8AlEUsD9rxuhOXdKjPxVxXvtOhCC0=;
        b=ZGNCihyRGX+6T2xD4p6tKUaJguYFUMouI+ooOc5zbuOoeKa1uzyH5kQU8px3bv8vYo
         ixXo6OpHibwp5lZkDwXt4lTDL4qjMFe3q/WZ2cbT2Uo20xRM5Wm7eGQ2or3tm+VsD1SP
         RXFmwkJfHIDlZxXs4lCRfmnfPx0viqqaS5ZdXMO5O5hiU1oG0k6SafkGnOKpa1JgtTyg
         LNdHqJNb38zAv4yD40yJSISZ7up8EEFXT6lyDOoRQfpPyPcmf5CIyLdpuhehJ+OBaAag
         IBfqfOEgv0bzhWbUc8w6I2asorX1ngcR05kLow/3VyveApV+qdOJUj8XcN/LgkO/Z1td
         zSgA==
X-Gm-Message-State: AJcUukcd/yhjRYFs8JpQgHbV1VGpbPleepBmPS4MOhI9/IAbto5Jvi72
        P5s5qd8h+Ni1NHNT4piP71Zf8EVNsHassg==
X-Google-Smtp-Source: ALg8bN4G9nW+CCOrmisAl+QjUk8YjmbPRDKFyYNhvbA21AykNXR3Lel7oI120z35okH+CYlN4N5s1w==
X-Received: by 2002:a63:1157:: with SMTP id 23mr10450003pgr.245.1547145762770;
        Thu, 10 Jan 2019 10:42:42 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id l19sm173303538pfi.71.2019.01.10.10.42.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 10:42:42 -0800 (PST)
Date:   Thu, 10 Jan 2019 10:42:41 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, tdas@codeaurora.org, swboyd@chromium.org,
        dianders@chromium.org, David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v1 7/7] arm64: dts: sdm845: wireup the thermal trip
 points to cpufreq
Message-ID: <20190110184241.GY261387@google.com>
References: <cover.1547078153.git.amit.kucheria@linaro.org>
 <6c5b26e65be18222587724e066fc2e39b9f60397.1547078153.git.amit.kucheria@linaro.org>
 <20190110022217.GX261387@google.com>
 <20190110062359.aea3tic5aw3iuocr@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190110062359.aea3tic5aw3iuocr@vireshk-i7>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 11:53:59AM +0530, Viresh Kumar wrote:
> On 09-01-19, 18:22, Matthias Kaehlcke wrote:
> > Hi Amit,
> > 
> > On Thu, Jan 10, 2019 at 05:30:56AM +0530, Amit Kucheria wrote:
> > > Since the big and little cpus are in the same frequency domain, use all
> > > of them for mitigation in the cooling-map. At the lower trip points we
> > > restrict ourselves to throttling only a few OPPs. At higher trip
> > > temperatures, allow ourselves to be throttled to any extent.
> > > 
> > > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 145 +++++++++++++++++++++++++++
> > >  1 file changed, 145 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > index 29e823b0caf4..cd6402a9aa64 100644
> > > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > @@ -13,6 +13,7 @@
> > >  #include <dt-bindings/reset/qcom,sdm845-aoss.h>
> > >  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> > >  #include <dt-bindings/clock/qcom,gcc-sdm845.h>
> > > +#include <dt-bindings/thermal/thermal.h>
> > >  
> > >  / {
> > >  	interrupt-parent = <&intc>;
> > > @@ -99,6 +100,7 @@
> > >  			compatible = "qcom,kryo385";
> > >  			reg = <0x0 0x0>;
> > >  			enable-method = "psci";
> > > +			#cooling-cells = <2>;
> > >  			next-level-cache = <&L2_0>;
> > >  			L2_0: l2-cache {
> > >  				compatible = "cache";
> > > @@ -114,6 +116,7 @@
> > >  			compatible = "qcom,kryo385";
> > >  			reg = <0x0 0x100>;
> > >  			enable-method = "psci";
> > > +			#cooling-cells = <2>;
> > 
> > This is not needed (also applies to other for other non-policy
> > cores). A single cpufreq device is created per frequency domain /
> > cluster, hence a single cooling device is registered per cluster,
> > which IMO makes sense given that the CPUs of a cluster can't change
> > their frequencies independently.
>  
> > As per above, there are no cooling devices for CPU1-3 and CPU5-7.
> 
> lore.kernel.org/lkml/cover.1527244200.git.viresh.kumar@linaro.org
> lore.kernel.org/lkml/b687bb6035fbb010383f4511a206abb4006679fa.1527244201.git.viresh.kumar@linaro.org

Thanks for the pointer, there's always something new to learn!

Ok, so the policy CPU and hence the CPU registered as cooling
device may vary. I understand that this requires to list all possible
cooling devices, even though only one will be active at any given
time. However I wonder if we could change this:


From 103703a46495ff210a521b5b6fbf32632053c64f Mon Sep 17 00:00:00 2001
From: Matthias Kaehlcke <mka@chromium.org>
Date: Thu, 10 Jan 2019 09:48:38 -0800
Subject: [PATCH] thermal: cpu_cooling: always use first CPU of a freq domain
 as cooling device

For all CPUs of a frequency domain a single cooling device is
registered, since the CPUs can't switch their frequencies
independently from each other. The cpufreq policy CPU is used to
represent cooling device of the frequency domain. Which CPU is the
policy CPU may vary based on the order of initialization or CPU
hotplug.

For device tree based platform the above implies that cooling maps
must include a list of all possible cooling devices of a frequency
domain, even though only one of them will exist at any given time.

For example:

cooling-maps {
	map0 {
		trip = <&cpu_alert0>;
		cooling-device = <&CPU0 THERMAL_NO_LIMIT 4>,
				 <&CPU1 THERMAL_NO_LIMIT 4>,
				 <&CPU2 THERMAL_NO_LIMIT 4>,
				 <&CPU3 THERMAL_NO_LIMIT 4>;
	};
	map1 {
		trip = <&cpu_crit0>;
		cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
				 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
				 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
				 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
	};
};

This can be avoided by using always the first CPU of a frequency
domain as cooling device. It may happen that the first CPU is offline
when the cooling device is registered (e.g. CPU2 is initialized
first in the above example), hence the nominal cooling device might
be offline. This may seem odd, however it is not really different from
the current behavior: when the policy CPU is taking offline the cooling
device corresponding to it remains active, unless it is unregistered
because all other CPUs of the frequency domain are offline too.

A single cooling device associated with a specific CPU of the frequency
domain reduces redundant device tree clutter in CPU nodes and cooling
maps.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/thermal/cpu_cooling.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index dfd23245f778a..bb5ea06f893a2 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -758,13 +758,14 @@ EXPORT_SYMBOL_GPL(cpufreq_cooling_register);
 struct thermal_cooling_device *
 of_cpufreq_cooling_register(struct cpufreq_policy *policy)
 {
-	struct device_node *np = of_get_cpu_node(policy->cpu, NULL);
+	unsigned int first_cpu = cpumask_first(policy->related_cpus);
+	struct device_node *np = of_get_cpu_node(first_cpu, NULL);
 	struct thermal_cooling_device *cdev = NULL;
 	u32 capacitance = 0;
 
 	if (!np) {
 		pr_err("cpu_cooling: OF node not available for cpu%d\n",
-		       policy->cpu);
+		       first_cpu);
 		return NULL;
 	}
 
@@ -775,7 +776,7 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
 		cdev = __cpufreq_cooling_register(np, policy, capacitance);
 		if (IS_ERR(cdev)) {
 			pr_err("cpu_cooling: cpu%d is not running as cooling device: %ld\n",
-			       policy->cpu, PTR_ERR(cdev));
+			       first_cpu, PTR_ERR(cdev));
 			cdev = NULL;
 		}
 	}


Would that make sense or is there something I'm overlooking?

Cheers

Matthias
