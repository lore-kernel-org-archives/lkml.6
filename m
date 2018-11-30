Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E62C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A3E22148E
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RZpXTlpK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A3E22148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbeK3UOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 15:14:02 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42894 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeK3UOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 15:14:02 -0500
Received: by mail-pf1-f193.google.com with SMTP id 64so2469772pfr.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 01:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eDwBtHxZJNt3YusW4CIPfDHzVEGCzJHU0hrPiMCu88Y=;
        b=RZpXTlpK9Hce5iN2JAqqQmrWmg+JGe97aztE5jmVf85PLfSfUpkwZgveAEmewNmQb+
         yR63uprQmoePhDvOy4PH1eczq9FbS7kUkFqXyMvlZEoPC/uO9UumCRvqtjXOdzlCxSPi
         GK4w9Ow8l3H4ID39ocVzytpjZPv71YHmR9GKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eDwBtHxZJNt3YusW4CIPfDHzVEGCzJHU0hrPiMCu88Y=;
        b=BU2D+8w2W9usieLima2Yzdc5QzffIUnbVYDdY9900UXFC7eUDoypYLxBLTntcxvUkB
         jNYk94Qqkg3z0ImECl3R7Mc7RxctedHmZu2butNT7G7duY+O23lo1gxCw9e8bJcEGMCJ
         I7oKJNUw4IaPl6ba3yjy2FxcReH+VUBO7tC/ln7CvmsIyLcIJmenLGI/fh3wJ53yXszb
         M9UQMKbQwxF6hZ5R/+CzfzZefkzf1XQI8Dync9mkX5ikh3z6O9VCbH0b95+7lLRdZfwp
         xuv3FEqOtdRaCXXWBek/eA9zXnMPFRVRvVBfrVMD3QsS9x73xJEiE7XcSsAOpBPpLz2E
         FSSQ==
X-Gm-Message-State: AA+aEWZ+akk1Y45TcZAaz0s1id9FpQMcZbkq+GcAEJLRgLQPNEl3cXLb
        EiKLHUWuHNzyzHUvIBrhsnC6qQ==
X-Google-Smtp-Source: AFSGD/UulmtgkVeymhYRRr2YMfCQWbQfs6//55njrwCEe71NRFcYElLACzQo4h9+riaKjpsjWXls/Q==
X-Received: by 2002:a62:5793:: with SMTP id i19mr4860173pfj.49.1543568724375;
        Fri, 30 Nov 2018 01:05:24 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id q199sm13896631pfc.97.2018.11.30.01.05.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 01:05:23 -0800 (PST)
Date:   Fri, 30 Nov 2018 14:35:21 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 3/5] PM / Domains: Save OPP table pointer in genpd
Message-ID: <20181130090521.etwm56dcvfgk5qkl@vireshk-i7>
References: <cover.1543219386.git.viresh.kumar@linaro.org>
 <f95b514f7b3b3ab6ac00c9871e91513c9c3a09a3.1543219386.git.viresh.kumar@linaro.org>
 <CAPDyKFrUBwagtfwCezqw2ujPBVVtQNqz4rKgAG0Yyy18FZv+wA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrUBwagtfwCezqw2ujPBVVtQNqz4rKgAG0Yyy18FZv+wA@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-11-18, 09:53, Ulf Hansson wrote:
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 8e554e6a82a2..0d928359b880 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -1907,12 +1907,21 @@ int of_genpd_add_provider_simple(struct device_node *np,
> >                                 ret);
> >                         goto unlock;
> >                 }
> > +
> > +               /*
> > +                * Save table for faster processing while setting performance
> > +                * state.
> > +                */
> > +               genpd->opp_table = dev_pm_opp_get_opp_table(&genpd->dev);
> > +               WARN_ON(!genpd->opp_table);
> 
> The WARN_ON seems lazy. Why not implement a proper error path?

We just added the table before this call and so we should get the table no
matter what. Initially I wanted to add a BUG_ON() but then I relaxed it a bit :)

There is no point of error path here as that will never run.

-- 
viresh
