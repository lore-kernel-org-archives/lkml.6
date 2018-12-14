Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A88C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA60020866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dmgfM+BH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA60020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbeLNGd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 01:33:26 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39538 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbeLNGd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 01:33:26 -0500
Received: by mail-pg1-f194.google.com with SMTP id w6so2229063pgl.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 22:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6U+wJFuXoipVhoUGdkktPfvuy5sqyOiWs46S7Vn1Em8=;
        b=dmgfM+BHGH0BhnNzTetNjBQyC1usVuwtG3ZldihpDqo+IzcB+zWCM8w1QJErkt1eYO
         37PgkRu3Bc/yMKqYFTAFMWZZq3KYVD5jakCV6ysoU+0g+qjfBFk0TW8yHl5qabKayeWi
         2H8i13vBw49N4n6bYL/la72EOji0vaXwZzg4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6U+wJFuXoipVhoUGdkktPfvuy5sqyOiWs46S7Vn1Em8=;
        b=lDif9agZ89di7XvGcr23DKrGaVrASV+Armi6L0u6eja+5UXG1/rXrVG6dLvejO9tzt
         bB3CXbym9kKPnA9tSmUezWOxcZiqs19hzH4Ol/rXRGArO34FoAoB1U7kX4/FT2BDl0tk
         oMykcdhi83YjtdB4AinTnAu4+hXi3TNA5MXnZ3r4Ky5hjiCQs06k2qqOdYXmLdgHzN5G
         5bLfz7XHODTgUUuobly0S6ktINIlL8nJnVnjJlqb/S2LjuNMl2/UeLCWhXlw90YZcAiR
         FVwh8U+PueeFNc/QZVrjby4Kt1JH2ShWMIsUc4TrZxquxR82XXrGNKZzQgCKduXqq1u8
         7WTg==
X-Gm-Message-State: AA+aEWajvRFG1qsfRsG0XN+t5muCGJMZXNqPmOMs6ObO1t/0GQvwzoU0
        CZBOJv3evzUE+6aVzDt0sMNCOgvi1Nc=
X-Google-Smtp-Source: AFSGD/XwIjUnSn8D3U9Qo98W+YpT79J6Gkr1WTE8cad1idNOiv86sS6/zNSPyeIiboTT0wjJryMFuQ==
X-Received: by 2002:a63:e20a:: with SMTP id q10mr1629746pgh.206.1544769205100;
        Thu, 13 Dec 2018 22:33:25 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id z191sm4480728pgd.74.2018.12.13.22.33.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 22:33:23 -0800 (PST)
Date:   Fri, 14 Dec 2018 12:03:21 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 6/6] PM / Domains: Propagate performance state updates
Message-ID: <20181214063321.5i2hqoufw7jc3a2i@vireshk-i7>
References: <cover.1544611890.git.viresh.kumar@linaro.org>
 <d138bd45d0eacc11ff90e27f83d8b47d692877ef.1544611890.git.viresh.kumar@linaro.org>
 <CAPDyKFpFn60O7W71v7b3fsCtmS520=GG0AQhs3GpdarVE+W--A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpFn60O7W71v7b3fsCtmS520=GG0AQhs3GpdarVE+W--A@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-12-18, 16:53, Ulf Hansson wrote:
> On Wed, 12 Dec 2018 at 11:58, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >  update_state:
> > -       return _genpd_set_performance_state(genpd, state);
> > +       return _genpd_set_performance_state(genpd, state, depth);
> 
> Instead of calling _genpd_set_performance_state() from here, I suggest
> to let the caller do it. Simply return the aggregated new state, if it
> needs to be updated - and zero if no update is needed.
> 
> Why? I think it may clarify and simplify the code, in regards to the
> actual set/propagation of state changes. Another side-effect, is that
> you should be able to avoid the forward declaration of
> _genpd_reeval_performance_state(), which I think is nice as well.

_genpd_reeval_performance_state() is currently called from 3 different
places and with the suggested change those sites will have this diff.

-               ret = _genpd_reeval_performance_state(master, master_state,
-                                                     depth + 1);
+               master_state = _genpd_reeval_performance_state(master,
+                                               master_state);
+               ret = _genpd_set_performance_state(genpd, master_state, depth);

To be honest, I don't like it. Probably because I don't find the extra
declaration of _genpd_reeval_performance_state() that bad. If two
routines are always going to get called together it is worth calling
the second one from the first one for me.

But anyway, I am fine with it if you are. Please let me know.

> >  }
> >
> >  /**
> > @@ -332,7 +407,7 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
> >         prev = gpd_data->performance_state;
> >         gpd_data->performance_state = state;
> >
> > -       ret = _genpd_reeval_performance_state(genpd, state);
> > +       ret = _genpd_reeval_performance_state(genpd, state, 0);
> >         if (ret)
> >                 gpd_data->performance_state = prev;
> >
> > diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> > index 9ad101362aef..dd364abb649a 100644
> > --- a/include/linux/pm_domain.h
> > +++ b/include/linux/pm_domain.h
> > @@ -136,6 +136,10 @@ struct gpd_link {
> >         struct list_head master_node;
> >         struct generic_pm_domain *slave;
> >         struct list_head slave_node;
> > +
> > +       /* Sub-domain's per-master domain performance state */
> > +       unsigned int performance_state;
> > +       unsigned int prev_performance_state;
> 
> Probably a leftover from the earlier versions, please remove.

No, these are still getting used.

-- 
viresh
