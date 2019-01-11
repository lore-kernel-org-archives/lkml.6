Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5C2C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A417B2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lV3cO032"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390546AbfAKT6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:58:16 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36732 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388913AbfAKT6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:58:16 -0500
Received: by mail-pl1-f194.google.com with SMTP id g9so7214123plo.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 11:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T/UuOZQz1q2LZujBJ1f3FAd7NotydTH3SwAts21JKYc=;
        b=lV3cO032VUNPUo/EjCMMIS9JaEzW+vNbeZFQu8bXMYsxsw5Xfn6gd2Q6ColyCgVUW2
         gPkU0vyabNuISdiMN+UCdefu8IpvWtPC8/XvXi49X+QUfEgo8xAAE4SaXBTOQE72dcE4
         iIDgZDuu8uUazM7yH0Q1Pj7tQU0z428wNI6gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T/UuOZQz1q2LZujBJ1f3FAd7NotydTH3SwAts21JKYc=;
        b=Rug3dHXtiucigZFLMjG63irRG9gaiBbDDSMKoozJ75yO2m6ntVtTYV7WqMCfCgwxT1
         knfHM630pn6nRtKEBuw4f9Pn7u6kiu/cjCh94i21kL9Z9UkgLhiJQJTt94mke8ll9ONd
         ONv80YrFXRFV+bWUETiHSXDo645wos0AIue6mPz50T5Ze5cCME8mpTpP7UEBnaP1ksjE
         IWRb8sRc5Ih2e9Q46CVthkqz33VQWRn/uXaCXMSXRjWQb/AO8nLNAN8Xpv4Un+9RdbV+
         FZ0uwj7F8rN3Mh0l/scmy8Hg1oi/dZSIh2YdLRvkq6ZX1VrfO6uEsWoc1rUzHBdrphyX
         O0/Q==
X-Gm-Message-State: AJcUukfL2uUtnSJJLgQo7jSvzBMlL89gUSNncTiwC2O91XYRXK6BosVU
        ZHNUJm1O/7yTKJPF4bmgjPht6Q==
X-Google-Smtp-Source: ALg8bN62XeITWF8Y9LC4zDm+uKZWVN+ZYTpF6wIz9nUFIfaH3aNcFanaRosuaWh13/CrbqZ9sq6EGQ==
X-Received: by 2002:a17:902:112c:: with SMTP id d41mr15418954pla.144.1547236695107;
        Fri, 11 Jan 2019 11:58:15 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id w10sm91058880pgi.81.2019.01.11.11.58.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 11:58:13 -0800 (PST)
Date:   Fri, 11 Jan 2019 11:58:13 -0800
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
Message-ID: <20190111195813.GF261387@google.com>
References: <cover.1547078153.git.amit.kucheria@linaro.org>
 <6c5b26e65be18222587724e066fc2e39b9f60397.1547078153.git.amit.kucheria@linaro.org>
 <20190110022217.GX261387@google.com>
 <20190110062359.aea3tic5aw3iuocr@vireshk-i7>
 <20190110184241.GY261387@google.com>
 <20190111034653.6dstox4c6hpjum4f@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190111034653.6dstox4c6hpjum4f@vireshk-i7>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 09:16:53AM +0530, Viresh Kumar wrote:
> On 10-01-19, 10:42, Matthias Kaehlcke wrote:
> > Thanks for the pointer, there's always something new to learn!
> > 
> > Ok, so the policy CPU and hence the CPU registered as cooling
> > device may vary. I understand that this requires to list all possible
> > cooling devices,
> 
> I won't say that I changed DT because of a design issue with kernel,
> rather the DT shall be complete by itself and that's why that change
> was made.

fair enough

> And then we can have more things going on. For example with cpuidle
> cooling, we can individually control each CPU (and force idle on that)
> even if all CPUs are part of the same freq-domain. Each CPU shall
> expose its capabilities.

Just to gain a better understanding: is cpuidle cooling already
available for arm64 (or is there a patch set)? I came across the
relatively new idle injecting framework but it seems currently the
only user is the Intel powerclamp driver.

> > even though only one will be active at any given
> > time. However I wonder if we could change this:
> 
> I won't say it that way. I see it as all the CPUs are active during a
> cooling state, i.e. they are all participating.

agreed, I was referring to the CPU cooling device, which (without
cpuidle injection) could be considered a single device per freq domain.

> > For device tree based platform the above implies that cooling maps
> > must include a list of all possible cooling devices of a frequency
> > domain, even though only one of them will exist at any given time.
> > 
> > For example:
> > 
> > cooling-maps {
> > 	map0 {
> > 		trip = <&cpu_alert0>;
> > 		cooling-device = <&CPU0 THERMAL_NO_LIMIT 4>,
> > 				 <&CPU1 THERMAL_NO_LIMIT 4>,
> > 				 <&CPU2 THERMAL_NO_LIMIT 4>,
> > 				 <&CPU3 THERMAL_NO_LIMIT 4>;
> > 	};
> > 	map1 {
> > 		trip = <&cpu_crit0>;
> > 		cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > 				 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > 				 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > 				 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> 
> This is the right thing to do hardware description wise, no matter
> what the kernel does.

Not sure I would call it a hardware description. I'd say we pretend
the thermal configuration is a hardware description so the DT folks
don't yell at us ;-) IMO a CPU cooling device is an abstraction, I
think there is no such IP block on most systems.

It seems with cpuidle injection CPUs can perform cooling actions
individually, with that I agree that representing them as individual
cooling devices in the DT makes sense. Without that a cooling device
per freq domain would seem a resonable abstraction.

One of the reasons I dislike the above list of cooling devices is that
it is repeated for different thermal-zone/cooling-maps, but I guess
we have to live with that, would be nice if the DT would allow to do
something like this:

thermal-zones {
	cooling_maps_fd0 : cooling-maps {
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

	cpu0-thermal {
		...
		cooling-maps = @cooling_maps_fd0;
		...
	};

	cpu1-thermal {
		...
		cooling-maps = @cooling_maps_fd0;
		...
	};

	...
};

Cheers

Matthias
