Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBF0C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 03:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D2D208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 03:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZLKD8+Va"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72D2D208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbeK0OyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 09:54:10 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38714 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbeK0OyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 09:54:10 -0500
Received: by mail-pg1-f194.google.com with SMTP id g189so7206838pgc.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 19:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A6UfO+oJdZ1P+IsPRBoOiLqAI9Nv4/6Ir/YNpU7R1q0=;
        b=ZLKD8+Vavu0yciPF9ghmrzbEQxZUD1BotTVosngENg9tBUGte7waIRdRbMu24bZFvt
         L/y8oEiCivIXE8o/ouCAoiye/iVQgUe1NSmOPNVwtxrgBXVUUReWX8T1futnHlltot2l
         RzD1s7LZEn47CCfYW0fdKSrrSHiyetIa500lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A6UfO+oJdZ1P+IsPRBoOiLqAI9Nv4/6Ir/YNpU7R1q0=;
        b=kW5hzMGmkkKjUsXjQo2vhwUdwe3SwXWXbwlK2wuZZ7ryOGiXu/Qlek/bzMDx5y3wh0
         GNwNWHCZGAZAGyLQjP+buua15LG3PAhn2LWoOScKdm1R6JjYfK9Rx09K4Bd1vV3gyaPK
         9bL2aESFCtdDMyY2D1UjExOW8O50b50rA5EZMSxjjMlrLTRlZV4HnWcuECGJLuP3U61F
         fco09MAbgQHzM4Y54B7n2hRuCzJwKJuckAXzS2rJFph49p+7Re6b+kD6/1zHhLAKD+A/
         B29pgGr1r18JI3N77i74R7esMVXuYkCY16ijMzbwlhpv3uAR6rREWYnhLetgHrajvbu8
         gxYQ==
X-Gm-Message-State: AA+aEWZdeslqH/QL5O1fKpHQBZVBlSRa7cHtZ+Yu3sTsIHzZ8gQuAenp
        fqWw5YEpOsLP7ds1gZP1GnO4d5XE0Uo=
X-Google-Smtp-Source: AFSGD/U29dEpjozQ+fc/PqNihP8oEtbiRTIdcKkfYPQ7+pvLOb2jLDdSpV9cF6h3WMof7eB4zPSJdA==
X-Received: by 2002:a63:d5e:: with SMTP id 30mr27781494pgn.54.1543291059566;
        Mon, 26 Nov 2018 19:57:39 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id o8sm4503274pfa.42.2018.11.26.19.57.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 19:57:38 -0800 (PST)
Date:   Tue, 27 Nov 2018 09:27:35 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        Chris Redpath <chris.redpath@linaro.org>,
        Quentin Perret <quentin.perret@linaro.org>,
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
Message-ID: <20181127035735.keqirmzjfbw4cq64@vireshk-i7>
References: <1543234847-21611-1-git-send-email-daniel.lezcano@linaro.org>
 <1543234847-21611-2-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543234847-21611-2-git-send-email-daniel.lezcano@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-11-18, 13:20, Daniel Lezcano wrote:
> diff --git a/Documentation/devicetree/bindings/arm/cpu-capacity.txt b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
> index 84262cd..f53a3c9 100644
> --- a/Documentation/devicetree/bindings/arm/cpu-capacity.txt
> +++ b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
> @@ -54,6 +54,12 @@ fall back to the default capacity value for every CPU. If cpufreq is not
>  available, final capacities are calculated by directly using capacity-dmips-
>  mhz values (normalized w.r.t. the highest value found while parsing the DT).
>  
> +If capacity-dmips-mhz is not specified or if the parsing fails, the
> +default capacity value will be computed against the highest frequency.
> +When all CPUs have the same OPP, they will have the same capacity
> +value otherwise the capacity will be scaled down for CPUs having lower
> +frequencies.

I know you added this based on Quentin's feedback, but I wonder if this is
really required and if it is improving anything at all. This is what the
documentation says currently without this patch:

"
capacity-dmips-mhz is an optional cpu node [1] property: u32 value
representing CPU capacity expressed in normalized DMIPS/MHz. At boot time, the
maximum frequency available to the cpu is then used to calculate the capacity
value internally used by the kernel.

capacity-dmips-mhz property is all-or-nothing: if it is specified for a cpu
node, it has to be specified for every other cpu nodes, or the system will
fall back to the default capacity value for every CPU. If cpufreq is not
available, final capacities are calculated by directly using capacity-dmips-
mhz values (normalized w.r.t. the highest value found while parsing the DT).
"

So it already clearly says two things:
- If all CPUs don't have this property, we fallback to default capacity for
  every CPU.
- And the OS may also normalize the capacity based on the maximum frequency.

What more do we want to add here ?

-- 
viresh
