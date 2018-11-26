Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBCEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 06:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D7D420672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 06:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MZjgW4FV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D7D420672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbeKZQyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 11:54:47 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38546 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbeKZQyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 11:54:47 -0500
Received: by mail-pl1-f195.google.com with SMTP id e5so13334087plb.5
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 22:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u718S6W5TiRJxH3T3cFH1MbanJYMD3kWOYB8vyU401Y=;
        b=MZjgW4FVvD6ZzjVFz9JanJqLeI8CTEMiBMKOmuiORETPMor835JIAeuQO5U2Ii5468
         hVKX9p5RO4zpwm6mIAFHNCv3H+XvRhv4lZY4hCjbsMkAnC1g3MIBZqmfuKYDbmgIYfSN
         qNHkLy00qaAeRQ2th+oSnf3s96f4xYVcW4yZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u718S6W5TiRJxH3T3cFH1MbanJYMD3kWOYB8vyU401Y=;
        b=R72Fovd8Czc77gNM21qxj2SKVrgKIdJ6RJJy1tFyDZ3Iq4EWK1ui4rcQuEaCQwt2xI
         Cf+VH/EkSBawZS94uSgYbi3c5Yk7fVdDe9ZBBr3m2ANo/xo6tglwXg7NHjJT/3JgTv2u
         QLeKMnaFgsqh4dlXuDqP3Z3CaqcxswV/AYUcIQ2aoo30e1ZP/CxY6tlLHwsOD12tp331
         BI04ff832ynNKKPC7jSf7ZjodUPVsw86uCZy1I9nJU8s6tklWoLLeEvEVDgy/fvZM/ya
         75M86GTz82y7FkKPHGC7fADVxZyradlwkoO0E/y0ekbBK5H2aKRpt9oQ0DO8Du9JiCyK
         ZGww==
X-Gm-Message-State: AA+aEWb2YgEzNnf/TvnGCC4rSl7BIQipdj2iVl1Mq9pSVduex0Lw9H+k
        f3raZNmGPmJ7eamB0vqm8O3uqR095bI=
X-Google-Smtp-Source: AFSGD/UT8XlU66zFU/JAmksC7H3E2Cln8cjieRjXLGWTbz0LHkt9K8KDT65KbZ+zbFzR4wV2ErjiSg==
X-Received: by 2002:a17:902:bd4a:: with SMTP id b10mr26259430plx.232.1543212105488;
        Sun, 25 Nov 2018 22:01:45 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id u186sm29580159pfu.51.2018.11.25.22.01.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 22:01:44 -0800 (PST)
Date:   Mon, 26 Nov 2018 11:31:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        Chris Redpath <chris.redpath@linaro.org>,
        Quentin Perret <quentin.perret@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V2 2/2] base/drivers/arch_topology: Default dmips-mhz if
 they are not set in DT
Message-ID: <20181126060142.skehankx7nzjpcdw@vireshk-i7>
References: <1542890209-3263-1-git-send-email-daniel.lezcano@linaro.org>
 <1542890209-3263-2-git-send-email-daniel.lezcano@linaro.org>
 <20181123100441.nlapxupdcqehwj6m@vireshk-i7>
 <400c34c5-18f4-70ab-d660-8b4c45c8eec4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <400c34c5-18f4-70ab-d660-8b4c45c8eec4@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-11-18, 11:32, Daniel Lezcano wrote:
> On 23/11/2018 11:04, Viresh Kumar wrote:
> > On 22-11-18, 13:36, Daniel Lezcano wrote:
> >> In the case of asymmetric SoC with the same micro-architecture, we
> >> have a group of CPUs with smaller OPPs than the other group. One
> >> example is the 96boards dragonboard 820c. There is no dmips/MHz
> >> difference between both groups, so no need to specify the values in
> >> the DT. Unfortunately, without these defined, there is no scaling
> >> capacity computation triggered, so we need to write
> >> 'capacity-dmips-mhz' for each CPU with the same value in order to
> >> force the scaled capacity computation.
> >>
> >> Fix this by setting a default capacity to SCHED_CAPACITY_SCALE, if no
> >> 'capacity-dmips-mhz' is defined in the DT.
> > 
> > We aren't doing this anymore. You should rather explain that we just
> > allocate raw_capacity now and rest is left for
> > init_cpu_capacity_callback() to fix.
> 
> What about?
> 
> "In the case of asymmetric SoC with the same micro-architecture, we
> have a group of CPUs with smaller OPPs than the other group. One
> example is the 96boards dragonboard 820c. There is no dmips/MHz
> difference between both groups, so no need to specify the values in
> the DT. Unfortunately, without these defined, there is no scaling
> capacity computation triggered, so we need to write
> 'capacity-dmips-mhz' for each CPU with the same value in order to
> force the scaled capacity computation.
> 
> In order to fix this situation, allocate 'raw_capacity' so the pointer
> is set and the init_cpu_capacity_callback() function can be called."

LGTM

-- 
viresh
