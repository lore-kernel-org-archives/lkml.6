Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E86C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 05:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CB172146D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 05:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SNTWkuuI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CB172146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbeKUPtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 10:49:24 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38764 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeKUPtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 10:49:24 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so3708949plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 21:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T4XEwnJi7neMSCpZcncwWzn+mvd0Yh7DPPNc9ETmYDc=;
        b=SNTWkuuIzFj8gR2DGN0DBhfeSGZ26yJHdprSmFGuYqKeI2GiYRxyWX5V763j6zqp6E
         UqVUlmzHYmthPbD+2zavQDH14L8KOIKiNbHzYy/ikPHknWy0Vk5LN2x5uqz+X1J3AcPa
         StGsS9Pi/9qAoaK0JNBhvyBFhG2lDd87eRZQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T4XEwnJi7neMSCpZcncwWzn+mvd0Yh7DPPNc9ETmYDc=;
        b=fOA5wl0QIqPOHlS3E2VVK1weAZUcUvgJrGw9BPykICZepZThx8viN3OkLks6rrnOxy
         myngWRAiupttSlV05PSC/h1/+zJCXRG2eBCUlzbj4/Mkqd1UD4yxyTY8jiN0bQvPH42N
         aQ7Bj9edio0durHHIEw/XcaR7SrOV7aQ5G/uicY14c7DFKLELOjWLphwlPABLm94mHjf
         Ngr7MzAulWkf6rMkKew+AmezJ0RU+YGJ3zjbXY0fYaqj1SUf2hhIMA4fuEd0d9jnStqo
         dwYdZ4GXLYW1UCkqTqrZvAIqUBXYSTNeo182tTBxgSG/Z36sPPGEUgbNDB5sZgPiRbak
         V39w==
X-Gm-Message-State: AGRZ1gIt4ny95ZIroxLBV2bM+wAcQY/UnqVZplZr8nGcjhKIEh0Upt6i
        PKVXD7OFeIDXV87zAKtLqfoQIA1TBEw=
X-Google-Smtp-Source: AJdET5ePg51oqf5l7u97ivIgYYFZNuQ5sf0ZH1PnkabD3XES7oMhjjL5YQMMDikES62QSN+N9sHoMw==
X-Received: by 2002:a62:114c:: with SMTP id z73-v6mr5204278pfi.192.1542777389616;
        Tue, 20 Nov 2018 21:16:29 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id p83sm61698587pfi.85.2018.11.20.21.16.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 21:16:28 -0800 (PST)
Date:   Wed, 21 Nov 2018 10:46:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     ulf.hansson@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        niklas.cassel@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] PM / Domains: Propagate performance state updates
Message-ID: <20181121051626.izb6dem62zoaf2c4@vireshk-i7>
References: <cover.1541399301.git.viresh.kumar@linaro.org>
 <7e1ea283f9eebce081af80ddb8d3ca5c9c76cd3b.1541399301.git.viresh.kumar@linaro.org>
 <71530b01-eefa-4778-0b17-d7774eb48356@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71530b01-eefa-4778-0b17-d7774eb48356@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-11-18, 10:33, Rajendra Nayak wrote:
> Hi Viresh,
> 
> On 11/5/2018 12:06 PM, Viresh Kumar wrote:
> > This commit updates genpd core to start propagating performance state
> > updates to master domains that have their set_performance_state()
> > callback set.
> > 
> > A genpd handles two type of performance states now. The first one is the
> > performance state requirement put on the genpd by the devices and
> > sub-domains under it, which is already represented by
> > genpd->performance_state. The second type, introduced in this commit, is
> > the performance state requirement(s) put by the genpd on its master
> > domain(s). There is a separate value required for each master that the
> > genpd has and so a new field is added to the struct gpd_link
> > (link->performance_state), which represents the link between a genpd and
> > its master. The struct gpd_link also got another field
> > prev_performance_state, which is used by genpd core as a temporary
> > variable during transitions.
> > 
> > We need to propagate setting performance state while powering-on a genpd
> > as well, as we ignore performance state requirements from sub-domains
> > which are powered-off. For this reason _genpd_power_on() also received
> > the additional parameter, depth, which is used for hierarchical locking
> > within genpd.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >   drivers/base/power/domain.c | 107 +++++++++++++++++++++++++++++-------
> >   include/linux/pm_domain.h   |   4 ++
> >   2 files changed, 92 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 6d2e9b3406f1..81e02c5f753f 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -239,28 +239,86 @@ static void genpd_update_accounting(struct generic_pm_domain *genpd)
> >   static inline void genpd_update_accounting(struct generic_pm_domain *genpd) {}
> >   #endif
> > +static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
> > +					   unsigned int state, int depth);
> > +
> >   static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
> > -					unsigned int state)
> > +					unsigned int state, int depth)
> >   {
> > +	struct generic_pm_domain *master;
> > +	struct gpd_link *link;
> > +	unsigned int mstate;
> >   	int ret;
> >   	if (!genpd_status_on(genpd))
> >   		goto out;
> 
> This check here would mean we only propogate performance state
> to masters if the genpd is ON?

Yeah, isn't that what should we do anyway? It is similar to clk-enable
etc. Why increase the reference count if the device isn't enabled and
isn't using the clock ?

Also you can see that I have updated the genpd power-on code to start
propagation to make sure we don't miss anything.

-- 
viresh
