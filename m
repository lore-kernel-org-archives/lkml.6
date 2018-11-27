Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203B6C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5D4208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XpE2oEbw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB5D4208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbeK0UG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:06:58 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53761 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729559AbeK0UG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:06:58 -0500
Received: by mail-wm1-f67.google.com with SMTP id y1so17679006wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 01:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qdi18onzQsPudJsZtwdaQneYGL6kSh9lH/kSiRg6hYA=;
        b=XpE2oEbwoTxYY0Kndo+QwpHGVn+AYSDcNQLVi2vZMBlxotkyO3Pnx+cuMcDPGSyiT/
         ztda/YUD6BaH+gb150ptMajuAsgei4ix4hL/zViUlwLIDadc37ikKDx4MH2L4ZOJSIHn
         oxzhUaeIlFQBJPyQen0mIdMWSqI2nxvtBoE+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qdi18onzQsPudJsZtwdaQneYGL6kSh9lH/kSiRg6hYA=;
        b=h+MR0OPrpg5sWw4PaU3q36OzaYhVIMUnLRWHyxowmStySUj6hP38A4RjHlseu+JSRZ
         3CY6fN5plfMMX/Iz/Q2Tp7jOhJ/2X79+KQPVxfjfX28flgkWF89l3BYNggWp/4892y4Z
         9Z8GgY3KKeAmLGRcItGUfJEOI37wjDlnckVZmFs3LGz2Nt6zzpshQ19MB4Siq71TxKVB
         yVoC2awsUooyX4AMIJ/WodIuRs/3KHdWWjRjwC1QlQq4hVmT1dZf+H84J4ETtsUgCDf0
         QrY/p6mdkzMITarxnMxYCm4Sc23mNtTgeUdbXr6/6dZAuG7A23Up3ebZ0g/QnIVgfeZG
         y3IA==
X-Gm-Message-State: AA+aEWavEcRiX1kCFsnc0hfV9Hf7dQH7um/GV+Z9nZIw65uSxCcNNU3Q
        88eQhuslCV+it2ey2k+olVQEzQ==
X-Google-Smtp-Source: AFSGD/W0O+ebd5hwjS0357xbXkoLnLipGV8oq1hmkVYuZhyW0G9nhhIZ8Z7qOqK8lQyWZgI1dN6cSw==
X-Received: by 2002:a1c:2007:: with SMTP id g7mr22587751wmg.79.1543309782935;
        Tue, 27 Nov 2018 01:09:42 -0800 (PST)
Received: from queper01-ThinkPad-T460s ([217.140.96.141])
        by smtp.gmail.com with ESMTPSA id y81-v6sm3086190wmd.11.2018.11.27.01.09.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 01:09:42 -0800 (PST)
Date:   Tue, 27 Nov 2018 09:09:40 +0000
From:   Quentin Perret <quentin.perret@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
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
Message-ID: <20181127090940.feegcsxmyxdzbk27@queper01-ThinkPad-T460s>
References: <1543234847-21611-1-git-send-email-daniel.lezcano@linaro.org>
 <1543234847-21611-2-git-send-email-daniel.lezcano@linaro.org>
 <20181127035735.keqirmzjfbw4cq64@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127035735.keqirmzjfbw4cq64@vireshk-i7>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 Nov 2018 at 09:27:35 (+0530), Viresh Kumar wrote:
> On 26-11-18, 13:20, Daniel Lezcano wrote:
> > diff --git a/Documentation/devicetree/bindings/arm/cpu-capacity.txt b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
> > index 84262cd..f53a3c9 100644
> > --- a/Documentation/devicetree/bindings/arm/cpu-capacity.txt
> > +++ b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
> > @@ -54,6 +54,12 @@ fall back to the default capacity value for every CPU. If cpufreq is not
> >  available, final capacities are calculated by directly using capacity-dmips-
> >  mhz values (normalized w.r.t. the highest value found while parsing the DT).
> >  
> > +If capacity-dmips-mhz is not specified or if the parsing fails, the
> > +default capacity value will be computed against the highest frequency.
> > +When all CPUs have the same OPP, they will have the same capacity
> > +value otherwise the capacity will be scaled down for CPUs having lower
> > +frequencies.
> 
> I know you added this based on Quentin's feedback, but I wonder if this is
> really required and if it is improving anything at all. This is what the
> documentation says currently without this patch:
> 
> "
> capacity-dmips-mhz is an optional cpu node [1] property: u32 value
> representing CPU capacity expressed in normalized DMIPS/MHz. At boot time, the
> maximum frequency available to the cpu is then used to calculate the capacity
> value internally used by the kernel.
> 
> capacity-dmips-mhz property is all-or-nothing: if it is specified for a cpu
> node, it has to be specified for every other cpu nodes, or the system will
> fall back to the default capacity value for every CPU. If cpufreq is not
> available, final capacities are calculated by directly using capacity-dmips-
> mhz values (normalized w.r.t. the highest value found while parsing the DT).
> "
> 
> So it already clearly says two things:
> - If all CPUs don't have this property, we fallback to default capacity for
>   every CPU.

Which is not what we do with this patch any more. We fallback to
scaling with frequency. So I do think the doc needs updating one way or
another. You could define more clearly what "default capacity" means if
you want and say that is scaled with frequency, that'd be fine by me.

Thanks,
Quentin
