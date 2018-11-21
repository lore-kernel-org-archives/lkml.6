Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171BDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 06:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4BA421479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 06:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U6MH4FnG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4BA421479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbeKURKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 12:10:02 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44357 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbeKURKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 12:10:01 -0500
Received: by mail-pl1-f195.google.com with SMTP id s5-v6so3992826plq.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 22:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ge2+rpVMSI1U2OE3wSpAYz8RwUeM3P2RnopoEmO8zLo=;
        b=U6MH4FnG8r7ueGmDLtj+gkID/ZvnX7I6t2nGxNrE9JK0tJaIUebxBvTx5toIqosXY4
         JtO3SP+7wE45iKVIxLnYrIxispDa4AQaARP5iQ6bHTzRwuz39hWS5vgnflrrHTUxEF7V
         JLo0BgHFjohYkSQ4SaI+r0n4AjVZsp2gLWl/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ge2+rpVMSI1U2OE3wSpAYz8RwUeM3P2RnopoEmO8zLo=;
        b=gGmFf0hY5B7kvoN6dvIJIMuSYdrX+gd03XFBd1+W2NtFwgmIGtmxJIVBh2/hVQGhId
         D5SZ06hJLoLpy6tZaSA06naWuql6ac5ZyFkgBh717i+RvDRZPWf7SilfxAoShH7/iBlr
         NjOXg8riMTfrp5z/5mzF5/IzTvwrfkk/Lctc0ipu6fKmSh+vdjRic6KPIKxbin5dr1i1
         2ibyyom1AtKekHVy7W6jO2o8qtNsMYmCMP5lS7rjdphZfCeZ8ZG3r3GS0ljcGx38eujF
         6g8P3qBaYE+beGUINjOzhcHbDhzeo11Absq2yFctqEdGsRL1JVcW8ApAxXzsb0dHGlOd
         RLWA==
X-Gm-Message-State: AA+aEWaWceVgOJDf2jX35GbZ7T73wdtS05eUQyvTq+X7fmyjQLZ5ZAF+
        GHPQUFiqX0//fNBqNEOXzN+UZg==
X-Google-Smtp-Source: AFSGD/WpAzkaMNkBYM7C8iUS4Go3N1xYxNozEdutq8vrpay7Xs4QBDzwMlKry4UD7MmAdymGAJdlTA==
X-Received: by 2002:a63:ee4c:: with SMTP id n12mr4675484pgk.21.1542782210192;
        Tue, 20 Nov 2018 22:36:50 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id b68sm29716513pfg.160.2018.11.20.22.36.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 22:36:49 -0800 (PST)
Date:   Wed, 21 Nov 2018 12:06:46 +0530
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
Message-ID: <20181121063646.37bha3vomxvzazzn@vireshk-i7>
References: <cover.1541399301.git.viresh.kumar@linaro.org>
 <7e1ea283f9eebce081af80ddb8d3ca5c9c76cd3b.1541399301.git.viresh.kumar@linaro.org>
 <71530b01-eefa-4778-0b17-d7774eb48356@codeaurora.org>
 <20181121051626.izb6dem62zoaf2c4@vireshk-i7>
 <68a3294f-5556-4b5f-f8c7-79c20b5c70fb@codeaurora.org>
 <5efc76bb-7732-52b6-4684-82b35ad52343@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5efc76bb-7732-52b6-4684-82b35ad52343@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-11-18, 11:12, Rajendra Nayak wrote:
> And the reason for that seems to be that we update the genpd status to GPD_STATE_ACTIVE
> *after* we try to set the performance state, so we always hit this check which bails out
> thinking the genpd is not ON.

Thanks for looking at it. Here is the (untested) fix, please try it
out.

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 84c13695af65..92be4a224b45 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -250,9 +250,6 @@ static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
        unsigned int mstate;
        int ret;
 
-       if (!genpd_status_on(genpd))
-               goto out;
-
        /* Propagate to masters of genpd */
        list_for_each_entry(link, &genpd->slave_links, slave_node) {
                master = link->master;
@@ -286,7 +283,6 @@ static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
        if (ret)
                goto err;
 
-out:
        genpd->performance_state = state;
        return 0;
 
@@ -361,6 +357,11 @@ static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
                return 0;
 
 update_state:
+       if (!genpd_status_on(genpd)) {
+               genpd->performance_state = state;
+               return 0;
+       }
+
        return _genpd_set_performance_state(genpd, state, depth);
 }

-- 
viresh
