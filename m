Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A71C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C4623E84
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:58:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66C4623E84
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751342AbeFVH6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 03:58:23 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35696 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751170AbeFVH6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 03:58:21 -0400
Received: by mail-wr0-f195.google.com with SMTP id y12-v6so723145wrs.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 00:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CEdqP+cDZVCmWCqL4D+wjkdF5hnvZzUOA1NqMrkjCu8=;
        b=VOHTvTjlATm4eRY40cTruX/D5F5ciwQJQnkJDBAZ+MYB37JGqo9vG3QuPRIA6gzJ42
         sCujSoopl3HuJao0OC0H/TGzVGJXbCkPvjRqDcfhDfuQ9t0NFHSXZvcEF6E7HA7c07e3
         hKpTVFUUQJShNMZk6jVWYhWA1jO2XsEZu82TYO7fXEQibFS0Z2KGZhQ2wbWdv57HvplF
         Q50Lq6qImtsBmolL+8L3rS9AQokpPWgUq492SJ19g54GmONl/LS62jHDMTLVAVTlYKK7
         KbqD+9ncxyncl0kAY1sAlQrGQf5mBhQSlMXU+E6fD5HHw1VU6T5LeuH9QiqnFiUi4urU
         H6nA==
X-Gm-Message-State: APt69E2wvwn1pQwbt/EpmMwNH53qsDgFM8+I7iD5hcPUSBZUAHREVXaa
        dR653Q0XB019m7iUkfEf1wXm8iLUDQ8=
X-Google-Smtp-Source: AAOMgpcOM5p/M/U2oHjzGuoPzpE8e0ocARpFuoW3bF4JMIksH+cRHPogDm2PBIRsTwfFF+IL7rH18g==
X-Received: by 2002:adf:ca03:: with SMTP id o3-v6mr626658wrh.148.1529654300549;
        Fri, 22 Jun 2018 00:58:20 -0700 (PDT)
Received: from localhost.localdomain ([151.15.207.242])
        by smtp.gmail.com with ESMTPSA id b6-v6sm343547wro.52.2018.06.22.00.58.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 00:58:19 -0700 (PDT)
Date:   Fri, 22 Jun 2018 09:58:17 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        viresh.kumar@linaro.org, valentin.schneider@arm.com,
        patrick.bellasi@arm.com, joel@joelfernandes.org,
        daniel.lezcano@linaro.org, quentin.perret@arm.com,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v6 04/11] cpufreq/schedutil: use rt utilization tracking
Message-ID: <20180622075817.GC17737@localhost.localdomain>
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
 <1528459794-13066-5-git-send-email-vincent.guittot@linaro.org>
 <20180621184524.GB27616@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621184524.GB27616@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/18 20:45, Peter Zijlstra wrote:
> On Fri, Jun 08, 2018 at 02:09:47PM +0200, Vincent Guittot wrote:
> >  static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
> >  {
> >  	struct rq *rq = cpu_rq(sg_cpu->cpu);
> > +	unsigned long util;
> >  
> >  	if (rq->rt.rt_nr_running)
> >  		return sg_cpu->max;
> >  
> > +	util = sg_cpu->util_dl;
> > +	util += sg_cpu->util_cfs;
> > +	util += sg_cpu->util_rt;
> > +
> >  	/*
> >  	 * Utilization required by DEADLINE must always be granted while, for
> >  	 * FAIR, we use blocked utilization of IDLE CPUs as a mechanism to
> > @@ -197,7 +204,7 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
> >  	 * util_cfs + util_dl as requested freq. However, cpufreq is not yet
> >  	 * ready for such an interface. So, we only do the latter for now.
> >  	 */
> > -	return min(sg_cpu->max, (sg_cpu->util_dl + sg_cpu->util_cfs));
> > +	return min(sg_cpu->max, util);
> >  }
> 
> So this (and the dl etc. equivalents) result in exactly the problems
> complained about last time, no?
> 
> What I proposed was something along the lines of:
> 
> 	util = 1024 * sg_cpu->util_cfs;
> 	util /= (1024 - (sg_cpu->util_rt + sg_cpu->util_dl + ...));
> 
> 	return min(sg_cpu->max, util + sg_cpu->bw_dl);
> 
> Where we, instead of directly adding the various util signals.
> 
> I now see an email from Quentin asking if these things are not in fact
> the same, but no, they are not. The difference is that the above only
> affects the CFS signal and will re-normalize the utilization of an
> 'always' running task back to 1 by compensating for the stolen capacity.
> 
> But it will not, like these here patches, affect the OPP selection of
> other classes. If there is no CFS utilization (or very little), then the
> renormalization will not matter, and the existing DL bandwidth
> compuation will be unaffected.

IIUC, even with very little CFS utilization, the final OPP selection
will still be "inflated" w.r.t. bw_dl in case util_dl is big (like for a
DL task with a big period and not so big runtime). But I guess that's
OK, since we agreed that such DL tasks should be the exception anyway.
