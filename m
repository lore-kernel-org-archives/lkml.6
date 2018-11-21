Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D85C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 05:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A53D2087E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 05:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rh0hdhqt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A53D2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbeKUPuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 10:50:16 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40534 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbeKUPuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 10:50:16 -0500
Received: by mail-pl1-f195.google.com with SMTP id b22-v6so3705850pls.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 21:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zJJjDp6oYuzAF/m4Ht3Uh/YeJXQHqgQ0cuKbakpyRYQ=;
        b=Rh0hdhqtBpeMhxJhwHcSHhNoqL3tCPpG2GAqYSZQ9geP4dc3yAV/ILuHc3ba1N9uEg
         GEIJYSP5MZoyZbl8bfzlMzkSNi1UWLQ2RqnAT1+mn57Q5z3yv43U9F6kQNvlj430CxLA
         9JUsvfECcO12XQTZA3wBz8K8442T+0akYSWtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zJJjDp6oYuzAF/m4Ht3Uh/YeJXQHqgQ0cuKbakpyRYQ=;
        b=tep/C+cTBS+0emDiAfFGTnb+xvNMu0MR//WyEtEIhobJox/p8JwVljWjkAoO6LjXi7
         cJKDrIUtyhuXaiqnFqp0DBBgzLJqASvjBgJ2KXkBH7ztBCpKr8Uxpe/3VNOvp83lVsT5
         PFET+zwMDdyrUtN88Wc8tfs0vnwCZ5fEZBWeyDY5zFzQZ4CPFTHVQUoumw6hF/hmI3L2
         LaOVk62S0zl4fMw3JakBpRw9pgzaoZ86TMudL79qQIff3q45cRCanNCbJtCmgTO8aW4R
         bidF4MNP1xiKoVNNLhm/DvX0rXRsbxUVRH6FHkaZ0IwrqqZn2EqWQkdgAjuzLJ6yMPcV
         tJ+Q==
X-Gm-Message-State: AA+aEWZqQ8LK2tQBuBQFbMyhkKXHVg+Wg66KAODFJDAK6OMyAql4oLUZ
        t5BbzYph2RukizBARXeGJYBqbw==
X-Google-Smtp-Source: AFSGD/U9+LBqLZhFbzFFKofDTP3Crmxq2fCT38Dj5wMsfO8Jjm/rTo6FUDtzl7zmuqbXdjQYQuMcjA==
X-Received: by 2002:a17:902:2887:: with SMTP id f7mr5183420plb.176.1542777441415;
        Tue, 20 Nov 2018 21:17:21 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id s2sm16073391pfa.167.2018.11.20.21.17.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 21:17:20 -0800 (PST)
Date:   Wed, 21 Nov 2018 10:47:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     ulf.hansson@linaro.org, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        niklas.cassel@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] OPP: Add dev_pm_opp_xlate_performance_state() helper
Message-ID: <20181121051718.a5yo3ibhaihgrwra@vireshk-i7>
References: <cover.1541399301.git.viresh.kumar@linaro.org>
 <cedbfc3a7fffc4c400908c4c3af518bea408d318.1541399301.git.viresh.kumar@linaro.org>
 <45c19ad3-6039-9152-6e5a-51a5c062bdf4@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45c19ad3-6039-9152-6e5a-51a5c062bdf4@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-11-18, 10:34, Rajendra Nayak wrote:
> 
> 
> On 11/5/2018 12:06 PM, Viresh Kumar wrote:
> > Introduce a new helper dev_pm_opp_xlate_performance_state() which will
> > be used to translate from pstate of a device to another one.
> > 
> > Initially this will be used by genpd to find pstate of a master domain
> > using its sub-domain's pstate.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >   drivers/opp/core.c     | 49 ++++++++++++++++++++++++++++++++++++++++++
> >   include/linux/pm_opp.h |  7 ++++++
> >   2 files changed, 56 insertions(+)
> > 
> > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > index 0eaa954b3f6c..010a4268e8dd 100644
> > --- a/drivers/opp/core.c
> > +++ b/drivers/opp/core.c
> > @@ -1707,6 +1707,55 @@ void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table,
> >   		dev_err(virt_dev, "Failed to find required device entry\n");
> >   }
> > +/**
> > + * dev_pm_opp_xlate_performance_state() - Find required OPP's pstate for src_table.
> > + * @src_table: OPP table which has dst_table as one of its required OPP table.
> 
> So I have a case where the src_table and dst_table are shared/same. Can you explain how would
> it work in such a case?

Can you give the example, as I am finding some issues with such shared
tables. Though the code may work just fine btw.

-- 
viresh
