Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D79C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF0020862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WsghXJG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DF0020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405461AbeHAT0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:26:35 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38162 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390100AbeHAT0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:26:34 -0400
Received: by mail-pf1-f196.google.com with SMTP id x17-v6so8221322pfh.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 10:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=eT0jBOSDQ7VQsjYNxFtSRnon0T4Tn0VpVud680Vo7GU=;
        b=WsghXJG+uojeuT+tQF80OXFhTap4x7LFrtvLQXE7kz4nPjCurbSEdwu19QAvw19bKo
         gekhnl4bAMBuUvItWLtTAmNjfr8afhgIqyS7lVIUSJ9OJ6K2YsrQ/RJY2xnKBK4qajgv
         uQtekN7NBAAQsSx4vo8fhRXXYmpa8AyQVvYu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=eT0jBOSDQ7VQsjYNxFtSRnon0T4Tn0VpVud680Vo7GU=;
        b=fDF9iME2p9x1PfqeAlm5MnKzHwPpNWb02PWOeL64E11hPpob/DdLKmUq3gJ8tUEEQ7
         yRwKcGO3rAFT2hXhnlRTZQ6F8f9+ZyvuMV8cIi4/NeKjJ/1/bctQn+P9CEtLg1oulZ/3
         Y5nPQg4eVevLpulbuEf3ttIuHYxf5S//L80kK3l87C1QCrhnpA8EYl0F2Xa+SEk96i4c
         ay5hwDGBkWnOJuRiRyPWpmrd1dG1/9/sazDS9c71+9nfjM0SonA3hEkcL2SPvQh2L0A2
         nIJifujbjXOoGhW5D6sMfn8QV7/dzMdi73Nl8tw2LQNV6nWXQj5cWiBFfVMLGmmIydr6
         N39w==
X-Gm-Message-State: AOUpUlGsP9ULwfvDi1I0y3md/fhCfIjJBO75s47/O/b8xbTeKNTtj61f
        cPjeDHId4mTnhg1Wn5quA+pDkBJT9as=
X-Google-Smtp-Source: AAOMgpd73VvX2E6vZ7/B1Z0sE5Qfrhml4p4fAtXQjlIUQJ6tvd5YqR53Q5PrS2jGngbolvtWIEgn8A==
X-Received: by 2002:a63:e318:: with SMTP id f24-v6mr25068924pgh.175.1533145187830;
        Wed, 01 Aug 2018 10:39:47 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id l71-v6sm22465268pgd.70.2018.08.01.10.39.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 10:39:47 -0700 (PDT)
Date:   Wed, 1 Aug 2018 10:39:46 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v5 09/12] dt-bindings: misc: add bindings for throttler
Message-ID: <20180801173946.GL68975@google.com>
References: <20180703234705.227473-1-mka@chromium.org>
 <CGME20180703234851epcas2p366dcf068db0a7761d7cdccabc4f1fb6e@epcas2p3.samsung.com>
 <20180703234705.227473-10-mka@chromium.org>
 <5B616F0D.1050901@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5B616F0D.1050901@samsung.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On Wed, Aug 01, 2018 at 05:27:57PM +0900, Chanwoo Choi wrote:
> Hi Matthias,
> 
> On 2018년 07월 04일 08:47, Matthias Kaehlcke wrote:
> > The Throttler is used for non-thermal throttling of system components
> > like CPUs or devfreq devices.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> 
> If possible, I hope the more detailed example for "cpu0_opp03, &cpu1_opp02, &gpu_opp03"
> because I'm confusing the meaning of 'cpu0_opp03' phandle.

I omitted the OPP definitions to avoid cluttering the example. I'm
happy to add them if DT folks also think it would add value.

> cpu0_opp03 indicates the only one specific OPP entry among set of
> OPP entries of CPU0 cpufreq? or cpu0_opp03 indicates the set of OPP
> entries for CPU0 cpufreq ?

cpu0_opp03 and the other phandles are specific OPP entries, that
indicate the throttler which frequencies/OPPs should be used for
throttling. For devices/CPUs with multiple levels of throttling
multiple entries from its OPP set are listed. In the example a single
level of throttling is used for all devices/CPUs.

