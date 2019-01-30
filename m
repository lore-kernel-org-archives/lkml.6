Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63622C282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 05:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23AC820989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 05:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EK7iarqz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbfA3FSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 00:18:12 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38250 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfA3FSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 00:18:12 -0500
Received: by mail-pg1-f194.google.com with SMTP id g189so9839388pgc.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 21:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r90Ei89M9VCYw+F9gfVdb+3hF3vLe++X0fdeOzuBcy4=;
        b=EK7iarqz3qTWQcKrL8cW6cnL3P3Kn2/CLUpaFNpZG8LN4rD8OfUjjGlvf7+hkfNWYr
         n1os1kh0paJ0J9fKb4JdU7FeNJVclYT55FWhCYZ9vpBT/gPzNUhApyB9q3EEPfgWt6gl
         ZWLI4E6Y74v1SvorOd9d1E3yHsQeG+kiL4MME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r90Ei89M9VCYw+F9gfVdb+3hF3vLe++X0fdeOzuBcy4=;
        b=O5bQ//vO4hUoTd7olZx5gHat/z39Et9ujwo6jmnnkDwSdRZWtgz+k5EiIq8FGZOaqs
         GS9n0YfnsPXGCO3FLv+xFU9a5CZs7/UgiWFXF/TZ9WUPjbZk8xES7xPHkSfwQSFnQf5X
         m1Ov9weWSkms1w4/Hh1pcD3X/sE3at9oLZtguo86QOfDXN4WwSdbewzZ74gg8RxR4drl
         ZuDkhVBn56JBvpCEZxP+6WDPDKC0KXfcOPMLCdCYJYEm+WuNHHVW7NiaSQLHbaztRbR5
         kN8GIu2987TPXwDxLvcBQgL2/WRO3e2js3GkfH3I5ckrsJA5nn73EwWNHJKH210m3RNl
         /yZQ==
X-Gm-Message-State: AJcUukfWXLoLAnClhvfeXiIWbwDVSiE8u15Q3poeYT4eNrQHBVThMwBE
        a6KfaTPlpBNygwHDb3VUdttSgg==
X-Google-Smtp-Source: ALg8bN55EWmGYlADnjBHJFR98WUCk2laXakjNm1DLjDRFm1IXKZcAT8MUJ8Qn3yehiFvVZB2gQ7+TA==
X-Received: by 2002:a65:4683:: with SMTP id h3mr25211736pgr.225.1548825490876;
        Tue, 29 Jan 2019 21:18:10 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id h64sm632868pfc.142.2019.01.29.21.18.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 21:18:09 -0800 (PST)
Date:   Wed, 30 Jan 2019 10:48:06 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>, rjw@rjwysocki.net,
        sudeep.holla@arm.com, liviu.dudau@arm.com,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        mark.rutland@arm.com, nm@ti.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH 2/7] cpufreq: dt: Register an Energy Model
Message-ID: <20190130051806.fdsos27jaekkwgbs@vireshk-i7>
References: <20190128165522.31749-1-quentin.perret@arm.com>
 <20190128165522.31749-3-quentin.perret@arm.com>
 <20190128193656.GI81583@google.com>
 <20190129052144.plicqu4vozh3l3ss@vireshk-i7>
 <20190129091546.tfh3lo4w4sosfuba@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129091546.tfh3lo4w4sosfuba@queper01-lin>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-01-19, 09:15, Quentin Perret wrote:
> On Tuesday 29 Jan 2019 at 10:51:44 (+0530), Viresh Kumar wrote:
> > On 28-01-19, 11:36, Matthias Kaehlcke wrote:
> > > I think this patch will result in error messages at registration on
> > > platforms that use the cpufreq-dt driver and don't specify
> > > 'dynamic-power-coefficient' for the CPUs in the DT. Not sure if that's
> > > a problem as long as the cpufreq initialization succeeds regardless,
> > > it could be seen as a not-so-gentle nudge to add the values.
> > 
> > That wouldn't be acceptable.
> 
> Fair enough. What I can propose in this case is to have in PM_OPP a
> helper called 'dev_pm_opp_of_register_em()' or something like this. This
> function will check all prerequisites are present (we have the right
> values in DT, and so on) and then call (or not) em_register_perf_domain().
> Then we can make the CPUFreq drivers use that instead of calling
> em_register_perf_domain() directly.

That should be fine.

> That would also make it easy to implement Matthias' suggestion to not
> call em_register_perf_domain() if an EM is already present.

So you will track registration state within the OPP core for that ?
Sorry but that doesn't sound right. What's wrong with having an
unregister helper in energy-model to keep proper code flow everywhere
?

-- 
viresh
