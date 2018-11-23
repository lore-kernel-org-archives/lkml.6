Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18910C04EBA
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D15EE20663
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Aue0hr8t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D15EE20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503029AbeKWUjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:39:23 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38441 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387933AbeKWUjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:39:22 -0500
Received: by mail-pl1-f195.google.com with SMTP id e5so10429104plb.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 01:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QDvtC0mIdS4m4GcMRDD4C/kofDxcQ4hIy3Z7eWU5fss=;
        b=Aue0hr8tuCw8KO6I5IXZtcmeyBwmHmoNFuIuwkmCMXhcdOVo9688zh9T8JvGJhpY7d
         6x1gRzu37RzgijrzsKRXyibIsEUTcgVxtcYsxHi1wd8hUZfGwhWwtlJpa6Bs6N8DPsem
         3hemE9HcJxJAZruQV60SgD7D2Y2itg66PB/YM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QDvtC0mIdS4m4GcMRDD4C/kofDxcQ4hIy3Z7eWU5fss=;
        b=nv1pQ8b0gjc47wFPfR64rA0Wt+u/mxljCAkN7MHmjcbtH2fcpoPXRWQAg6jlEUnLyc
         QUmVBMe1nQMoYQEaimlOHPUQkntIeyhiRJIJ/YpVJaiwQo6Q/tchn7/sgTo+6rmRanr+
         +mPhe6taEvYl+LCcDle/6YvmElGTcMs0mhcaG4kKJH0AVKMdvbQksBKPhCxszrk2G79S
         DI373n7Un/3xS8pCX6aGoA9DC/q4kNCwMZHQedF3d9LVLLOPXKl1+g0MbJ0NNy4SzOB1
         590DfY0Aq7XRH3qymWac0ZWklAxZRYktNgeNB06z1oBgRRVbem3dg0lxxsjwpW6P9QIa
         LiqA==
X-Gm-Message-State: AA+aEWbf8ujEiHUzqdG8ZOdQGopfkqLYwJcbjXNGhJFiQYzCox2BMH79
        t+eK2sisNX5U2FQCNWQcyJ6R4+EVzA4=
X-Google-Smtp-Source: AFSGD/VN3bH4oMIL3wlklkkCugF9qi9zyNpvbcFzj/I4sJAub2axruJVh2/2mAOMUm5em5wI2KiQFQ==
X-Received: by 2002:a17:902:b494:: with SMTP id y20mr13322960plr.178.1542966948551;
        Fri, 23 Nov 2018 01:55:48 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id r4sm68149589pgn.54.2018.11.23.01.55.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 01:55:47 -0800 (PST)
Date:   Fri, 23 Nov 2018 15:25:44 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     ulf.hansson@linaro.org, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        niklas.cassel@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] OPP: Add dev_pm_opp_xlate_performance_state() helper
Message-ID: <20181123095544.qu4r6hjd2hakitth@vireshk-i7>
References: <cover.1541399301.git.viresh.kumar@linaro.org>
 <cedbfc3a7fffc4c400908c4c3af518bea408d318.1541399301.git.viresh.kumar@linaro.org>
 <45c19ad3-6039-9152-6e5a-51a5c062bdf4@codeaurora.org>
 <20181121051718.a5yo3ibhaihgrwra@vireshk-i7>
 <20181121060622.blnlvydbc4wo5y3y@vireshk-i7>
 <0b40a76d-f779-391a-2770-4a3d368679a9@codeaurora.org>
 <20181122060839.socq3vuaa4ycftzn@vireshk-i7>
 <20181123091118.x73s345xhhr4simo@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123091118.x73s345xhhr4simo@vireshk-i7>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-11-18, 14:41, Viresh Kumar wrote:
> On 22-11-18, 11:38, Viresh Kumar wrote:
> > So there are few complexities in the case where an OPP table points to itself in
> > the required-opp field. I looked at solving it up in the opp core but that gets
> > more and more messy.
> > 
> > Now there is actually a assumption within the OPP core. Your Mx domain should
> > get initialized before the Cx domain, as that is when the OPP tables are created
> > as well. This is because Cx's OPP table will point to Mx's OPP table (doesn't
> > matter if they share the same table or not) and so Mx's OPP table should come
> > first.
> > 
> > Can you check if that is already the case for you? If not, please try doing it
> > and lemme know if it works. It should.
> > 
> > I just want to avoid too much complexity in OPP core without much use.
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 7f338d39809a..09df3fbdb555 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1734,7 +1734,7 @@ unsigned int dev_pm_opp_xlate_performance_state(struct opp_table *src_table,
>         int i;
>  
>         for (i = 0; i < src_table->required_opp_count; i++) {
> -               if (src_table->required_opp_tables[i] == dst_table)
> +               if (src_table->required_opp_tables[i]->np == dst_table->np)
>                         break;
>         }
> 
> Try this fix and it should make it work for you.
> 
> Having said that, the way you are representing all your domains with a
> single OPP table look incorrect. You are using the same OPP table for
> around 10 power domains, all provided by a single provider. This is
> absolutely fine. But the Mx domain doesn't have any dependency on any
> other domain actually and so its OPPs should never have the
> "required-opps" property, but it has those properties in your setup as
> you are trying to use the same OPP table. That may all work fine with
> the above patch (which is required anyway as it fixes a valid issue),
> but you may see a error warning that something failed for Mx domain,
> as it has required-opps property but no required device or genpd.
> 
> Anyway, please test above first and then you can fix your tables :)

Here is the fix you need for the case where cx and mx have 1:1 mapping
and we don't need to duplicate OPP tables in DT.

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index ad944d75b40b..99b71f60b6d8 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1727,6 +1727,16 @@ unsigned int dev_pm_opp_xlate_performance_state(struct opp_table *src_table,
        unsigned int dest_pstate = 0;
        int i;
 
+       /*
+        * Normally the src_table will have the "required_opps" property set to
+        * point to one of the OPPs in the dst_table, but in some cases the
+        * genpd and its master have one to one mapping of performance states
+        * and so none of them have the "required-opps" property set. Return the
+        * pstate of the src_table as it is in such cases.
+        */
+       if (!src_table->required_opp_count)
+               return pstate;
+
        for (i = 0; i < src_table->required_opp_count; i++) {
                if (src_table->required_opp_tables[i]->np == dst_table->np)
                        break;

-- 
viresh
