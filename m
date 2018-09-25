Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3465FC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01782086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:07:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E01782086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbeIYTP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 15:15:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40784 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbeIYTP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 15:15:26 -0400
Received: by mail-wm1-f67.google.com with SMTP id o2-v6so6982174wmh.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 06:07:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GF+XEB65jKqEgZdH3Agl+Fnid9wAvbq7dE4B3GIiOU0=;
        b=mmSS2koYadRq09q9C+A7PZPHmdODXiXHlMmnoZeh5SNvfhI8XLTHXK5sFexWicDH38
         3DyxwlbYgj2qWrclBAuBoOjcsOaVXoV7S8jq2TogYisCGJbXICIz2o/nwnACh59hpMeV
         Vsn7iOsfhIT/hsIbVF6nfEe2sRfBPCQIFAbIcKilvnnu2uUugmOnAd2NIpDODpGd3U+Y
         yn6hzL5LyaDhgF2r4kxmR+EzRNmuVrWQvIT3eGWuEaJzfDIBmEfmRUOCojb1CyqMecJK
         wbfbu7fglXr3Z6K6K5bfixCyer/0sSGE1GkemRmogsjMqgJYAnJOwKjFT8ZY96KlHcX1
         dLlA==
X-Gm-Message-State: ABuFfohjLWQGVJt6ML3uzNPxGC77l9CY8vYWcR/VgtoAQSBuT8pvAgia
        OSde2Iy/6OFipzne+gH6/ls2sQ==
X-Google-Smtp-Source: ACcGV61RUzMGFNN5qNIftzwT4m8J4JUw6+UbhacprAeNxeli8M9HhmwAPta/cy/ThXY0H12+CmUb5Q==
X-Received: by 2002:a1c:de05:: with SMTP id v5-v6mr609583wmg.127.1537880876099;
        Tue, 25 Sep 2018 06:07:56 -0700 (PDT)
Received: from localhost.localdomain ([151.82.116.90])
        by smtp.gmail.com with ESMTPSA id h17-v6sm2649026wrq.73.2018.09.25.06.07.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 06:07:55 -0700 (PDT)
Date:   Tue, 25 Sep 2018 15:07:50 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v5 5/5] cpuset: Rebuild root domain deadline accounting
 information
Message-ID: <20180925130750.GA25664@localhost.localdomain>
References: <20180903142801.20046-1-juri.lelli@redhat.com>
 <20180903142801.20046-6-juri.lelli@redhat.com>
 <20180925123222.GA29985@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925123222.GA29985@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/18 14:32, Peter Zijlstra wrote:
> On Mon, Sep 03, 2018 at 04:28:01PM +0200, Juri Lelli wrote:
> > +/*
> > + * Called with cpuset_mutex held (rebuild_sched_domains())
> > + * Called with hotplug lock held (rebuild_sched_domains_locked())
> > + * Called with sched_domains_mutex held (partition_and_rebuild_domains())
> 
> Isn't that what we have lockdep_assert_held() for?

Indeed. I can put three of them inside the function, even though we have
a single path to here atm. Guess makes sense to protect any future change.

> > + */
> > +static void rebuild_root_domains(void)
> > +{
> > +	struct cpuset *cs = NULL;
> > +	struct cgroup_subsys_state *pos_css;
> > +
> > +	rcu_read_lock();
> > +
> > +	/*
> > +	 * Clear default root domain DL accounting, it will be computed again
> > +	 * if a task belongs to it.
> > +	 */
> > +	dl_clear_root_domain(&def_root_domain);
> > +
> > +	cpuset_for_each_descendant_pre(cs, pos_css, &top_cpuset) {
> > +
> > +		if (cpumask_empty(cs->effective_cpus)) {
> > +			pos_css = css_rightmost_descendant(pos_css);
> > +			continue;
> > +		}
> > +
> > +		css_get(&cs->css);
> > +
> > +		rcu_read_unlock();
> 
> That looks really dodgy, but I suppose the comment near
> css_next_descendant_pre() spells out that this is in fact OK.

Plus update_cpumasks_hier() seems to do something similar. Maybe I
should switch to use css_tryget_online() as well?

Thanks,

- Juri
