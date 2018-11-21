Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC52C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 06:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E87AE2145D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 06:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kIuKzt/D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E87AE2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbeKUQja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 11:39:30 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34605 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbeKUQja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 11:39:30 -0500
Received: by mail-pl1-f193.google.com with SMTP id f12-v6so3895905plo.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 22:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+cvrx70X568xYmU2zk2nLXqGEeSsOraTE/I7eR8OXKI=;
        b=kIuKzt/DRRkJVrxkN79i3IEDOaWD6WgHfm3+GTw55FDpTClsueGcZgO4F2vUmTRqMq
         gRXhnRjlcz+q3Rc8ciQztLDadcHRX4Z2kyrJ3a32zNxNPvc8vhAAmcWfA10qkUpN4v4h
         Khy96ZVQh4theJD52BWjTFh1Gpvf3dp/px/9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+cvrx70X568xYmU2zk2nLXqGEeSsOraTE/I7eR8OXKI=;
        b=rU7Y1XPKJYv006+51tIrSekBrHhsQ9JwDXC5mx+6qPEBtMVnoH+Y9a6TqLI5nFxYU2
         0MnsHKx490g6XT3ZP989Lg8z+lze2gimtY5pO/U+lJcz5bPsos+F/Dj4/rPpNau7JfOw
         T9vooBr4HaSt5xTb7uWPP1Uapn9mEF8egwzEgDdPn2kBPhsG8iFjsPGSh1q3u7uB7MEM
         FyO7+Ov43HvpAopVvXVhrSomU9wUskkDHy4GFwjJUrEj26XgqKV2dMlyDtErNhxDSJnA
         pIf4/rgj+NKo4mOzpEiqmX2Ca3wfIIjCdkwu0TvpR6pGPASeW17bxKlBMh8T9qugGLYf
         39nA==
X-Gm-Message-State: AGRZ1gIfQJr83JV+TRatUKKobhfJtROSEnRtEe7yaqswzzWAOs/wMwrI
        kB8iu7dhAO+/SJVaXYX9fA09sg==
X-Google-Smtp-Source: AJdET5fBZYFATz9a1HT+76GbB3LjehiJ7ua0QRc/ua1PdT/6igmefUqd4sLgVf1ItSNtzrxVJO8DxQ==
X-Received: by 2002:a62:1709:: with SMTP id 9mr5341700pfx.249.1542780385127;
        Tue, 20 Nov 2018 22:06:25 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id z30-v6sm41670930pfg.41.2018.11.20.22.06.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 22:06:24 -0800 (PST)
Date:   Wed, 21 Nov 2018 11:36:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     ulf.hansson@linaro.org, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        niklas.cassel@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] OPP: Add dev_pm_opp_xlate_performance_state() helper
Message-ID: <20181121060622.blnlvydbc4wo5y3y@vireshk-i7>
References: <cover.1541399301.git.viresh.kumar@linaro.org>
 <cedbfc3a7fffc4c400908c4c3af518bea408d318.1541399301.git.viresh.kumar@linaro.org>
 <45c19ad3-6039-9152-6e5a-51a5c062bdf4@codeaurora.org>
 <20181121051718.a5yo3ibhaihgrwra@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121051718.a5yo3ibhaihgrwra@vireshk-i7>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-11-18, 10:47, Viresh Kumar wrote:
> On 21-11-18, 10:34, Rajendra Nayak wrote:
> > 
> > 
> > On 11/5/2018 12:06 PM, Viresh Kumar wrote:
> > > Introduce a new helper dev_pm_opp_xlate_performance_state() which will
> > > be used to translate from pstate of a device to another one.
> > > 
> > > Initially this will be used by genpd to find pstate of a master domain
> > > using its sub-domain's pstate.
> > > 
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > ---
> > >   drivers/opp/core.c     | 49 ++++++++++++++++++++++++++++++++++++++++++
> > >   include/linux/pm_opp.h |  7 ++++++
> > >   2 files changed, 56 insertions(+)
> > > 
> > > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > > index 0eaa954b3f6c..010a4268e8dd 100644
> > > --- a/drivers/opp/core.c
> > > +++ b/drivers/opp/core.c
> > > @@ -1707,6 +1707,55 @@ void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table,
> > >   		dev_err(virt_dev, "Failed to find required device entry\n");
> > >   }
> > > +/**
> > > + * dev_pm_opp_xlate_performance_state() - Find required OPP's pstate for src_table.
> > > + * @src_table: OPP table which has dst_table as one of its required OPP table.
> > 
> > So I have a case where the src_table and dst_table are shared/same. Can you explain how would
> > it work in such a case?
> 
> Can you give the example, as I am finding some issues with such shared
> tables. Though the code may work just fine btw.

I may have found the problem you are facing here. Please try this diff
and tell me if you hitting it, check this in dmesg.

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 3740822b4197..6c45774306b0 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -225,6 +225,7 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
 free_required_tables:
        _opp_table_free_required_tables(opp_table);
 put_np:
+       dev_err(dev, "Failed to allocate required OPP tables\n");
        of_node_put(np);
 }


-- 
viresh
