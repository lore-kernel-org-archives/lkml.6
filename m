Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4BEC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 862B7208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JYNrQI+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 862B7208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbeK0VNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:13:15 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40229 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeK0VNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 16:13:15 -0500
Received: by mail-pl1-f195.google.com with SMTP id u18so2812562plq.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 02:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F329N+zHICYytFvBuX8Dr07FqS2esU5pqM7Zss3uQO8=;
        b=JYNrQI+M0Gi5PUd0UnFUVcNBtMB8gyPZB5FNpb32bGIew2i+Qugyk6ypf5bGqSS3z1
         r8FjlRcN6rzea1k6gjMClSa4oj9hwxopUf3n0AXsoV8AdsxpWDFNeG4WJ9TkB4D8JXNI
         UZ8l3BuytD+pahk+USKPRgJ4JhWtEBCACiQ9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F329N+zHICYytFvBuX8Dr07FqS2esU5pqM7Zss3uQO8=;
        b=DphAnd8V8NlYrmO0vRUd4z0ioYm7G+ALnBs5GCnlikhuNieefkeCGyP2d5ftXtrgPV
         6sEdfBqHUqGs8l2FZPqjJDl2E+ILCURBqQylI4I8kBGPwEoUYf9HYu0aLwUvA/xEeq2P
         6epqr5CYymHKzVYSmnIU+hRSCyu/8mtBLZd6n9SYKs3ESDWy1Qi3huMuBH2vjgXc4wnN
         JZmHtpvcwaZbhWI2OQ2WYbqlD6ihFc6tkOHXhBRm/JBfsSpbegemJX4axtgKeHxydtfN
         K2JC5991CN8xAJWMQbEkZD22sRZt0vmF8uOmD+zbirBP1zFBIPOmNYJuBF4fxwTSVIYv
         UK0A==
X-Gm-Message-State: AA+aEWbIrurbu6GRAzExbaI3gyOl+A4XrnFhsufVt0fFQStnACFPj2yt
        8uq0fmbW/vXURGBhLHw+NwdrtnhIn5w=
X-Google-Smtp-Source: AFSGD/WX8H3+pX01M7OPgasE0m3l7DYHF4njNeFq3ZVoM72iLx0Nbe+xRrYAJfeFB+hd6l33olO1pQ==
X-Received: by 2002:a17:902:76c2:: with SMTP id j2mr32219521plt.339.1543313750757;
        Tue, 27 Nov 2018 02:15:50 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id 125sm4251449pfd.124.2018.11.27.02.15.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 02:15:49 -0800 (PST)
Date:   Tue, 27 Nov 2018 15:45:47 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <quentin.perret@linaro.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org,
        Chris Redpath <chris.redpath@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Li Yang <leoyang.li@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH V4 2/2] base/drivers/arch_topology: Default dmips-mhz if
 they are not set in DT
Message-ID: <20181127101547.pjdqmkc5agwm7a77@vireshk-i7>
References: <1543234847-21611-1-git-send-email-daniel.lezcano@linaro.org>
 <1543234847-21611-2-git-send-email-daniel.lezcano@linaro.org>
 <20181127035735.keqirmzjfbw4cq64@vireshk-i7>
 <20181127090940.feegcsxmyxdzbk27@queper01-ThinkPad-T460s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127090940.feegcsxmyxdzbk27@queper01-ThinkPad-T460s>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-11-18, 09:09, Quentin Perret wrote:
> On Tuesday 27 Nov 2018 at 09:27:35 (+0530), Viresh Kumar wrote:
> > On 26-11-18, 13:20, Daniel Lezcano wrote:
> > > diff --git a/Documentation/devicetree/bindings/arm/cpu-capacity.txt b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
> > > index 84262cd..f53a3c9 100644
> > > --- a/Documentation/devicetree/bindings/arm/cpu-capacity.txt
> > > +++ b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
> > > @@ -54,6 +54,12 @@ fall back to the default capacity value for every CPU. If cpufreq is not
> > >  available, final capacities are calculated by directly using capacity-dmips-
> > >  mhz values (normalized w.r.t. the highest value found while parsing the DT).
> > >  
> > > +If capacity-dmips-mhz is not specified or if the parsing fails, the
> > > +default capacity value will be computed against the highest frequency.
> > > +When all CPUs have the same OPP, they will have the same capacity
> > > +value otherwise the capacity will be scaled down for CPUs having lower
> > > +frequencies.
> > 
> > I know you added this based on Quentin's feedback, but I wonder if this is
> > really required and if it is improving anything at all. This is what the
> > documentation says currently without this patch:
> > 
> > "
> > capacity-dmips-mhz is an optional cpu node [1] property: u32 value
> > representing CPU capacity expressed in normalized DMIPS/MHz. At boot time, the
> > maximum frequency available to the cpu is then used to calculate the capacity
> > value internally used by the kernel.
> > 
> > capacity-dmips-mhz property is all-or-nothing: if it is specified for a cpu
> > node, it has to be specified for every other cpu nodes, or the system will
> > fall back to the default capacity value for every CPU. If cpufreq is not
> > available, final capacities are calculated by directly using capacity-dmips-
> > mhz values (normalized w.r.t. the highest value found while parsing the DT).
> > "
> > 
> > So it already clearly says two things:
> > - If all CPUs don't have this property, we fallback to default capacity for
> >   every CPU.
> 
> Which is not what we do with this patch any more. We fallback to
> scaling with frequency.

I read it as that the documentation always said that OS shall do freq based
normalization at boot time and we weren't doing the right thing earlier. On
partially filled DT we used to fallback to the default capacity but never did
the freq based normalization, which was the second step to be done after reading
the capacity-dmips-mhz value.

Anyway, its fine if all other are in sync to get this included :)

-- 
viresh
