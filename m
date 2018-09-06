Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FACAC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0087F2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0087F2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730239AbeIFTfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 15:35:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34568 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730019AbeIFTfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 15:35:36 -0400
Received: by mail-wr1-f66.google.com with SMTP id g33-v6so11791977wrd.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 07:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EFZ/YfG285fp414VYT3Xuw3Eo9I3KHix5exx7Jl6Jms=;
        b=MB2uyoU16NCt5DDk6nr6REWh1iXags0ZOKyjD0O1/inlNXLKYnvj9t7fjIdeZsnrln
         ttHz1R7ZSx/qto/WzBC+z9N0ASC3fxYip2KdxWeSc/YVVRkE4Arr4+nH293DZFUGY7hl
         hva5VGdKKIa2Hb7mqADfKlfHLYt1wK03eupx0VknJjF8YroL4ZaGQJ0aFx2Iygs70+42
         wufvMCBLVU1qoRtsYDnqNxy1KgQfgw12/UXtcVinAdx/OtHrpgAz7xIfvkwTuShQi0BC
         bcrbKkgyOu/kvKxWeVTwJJv80ZwDkfS+XkAJJskeeTqEA+TmRnZvf718iiejxY+7OHcj
         RrKA==
X-Gm-Message-State: APzg51AoklYZc5LCOcXoKTU8FZgHs2cQSS8Q9IKV5TCOVXS/Q+1cOeO7
        SmUz10V1SpiZbQ7kM8/TxansrQ==
X-Google-Smtp-Source: ANB0VdbfRDupo733eBy2nw6jyHryUZQPxpqhjFSEX+q8P/G04W/OLqe1seN6pw3ol0u7ga7T5ctWHQ==
X-Received: by 2002:a5d:5450:: with SMTP id w16-v6mr2927926wrv.4.1536245980171;
        Thu, 06 Sep 2018 07:59:40 -0700 (PDT)
Received: from localhost.localdomain ([151.15.227.30])
        by smtp.gmail.com with ESMTPSA id p89-v6sm7625873wrc.97.2018.09.06.07.59.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 07:59:39 -0700 (PDT)
Date:   Thu, 6 Sep 2018 16:59:36 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v4 14/16] sched/core: uclamp: request CAP_SYS_ADMIN by
 default
Message-ID: <20180906145936.GF27626@localhost.localdomain>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-15-patrick.bellasi@arm.com>
 <20180904134748.GA4974@localhost.localdomain>
 <20180906144053.GD25636@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906144053.GD25636@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/18 15:40, Patrick Bellasi wrote:
> On 04-Sep 15:47, Juri Lelli wrote:

[...]

> > Wondering if you want to fold the check below inside the
> > 
> >  if (user && !capable(CAP_SYS_NICE)) {
> >    ...
> >  }
> > 
> > block. It would also save you from adding another parameter to the
> > function.
> 
> So, there are two reasons for that:
> 
> 1) _I think_ we don't want to depend on capable(CAP_SYS_NICE) but
>    instead on capable(CAP_SYS_ADMIN)
> 
>    Does that make sense ?
> 
>    If yes, the I cannot fold it in the block you reported above
>    because we will not check for users with CAP_SYS_NICE.

Ah, right, not sure though. Looks like CAP_SYS_NICE is used for settings
that relates to priorities, affinity, etc.: CPU related stuff. Since
here you are also dealing with something that seems to fall into the
same realm, it might actually fit more than CAP_SYS_ADMIN?

Now that I think more about it, would it actually make sense to allow
unpriviledged users to lower their assigned umin/umax properties if they
want? Something alike what happens for nice values or RT priorities.

> 2) Then we could move it after that block, where there is another
>    set of checks with just:
> 
>       if (user) {
> 
>    We can potentially add the check there yes... but when uclamp is
>    not enabled we will still perform those checks or we have to add
>    some compiler guards...
> 
> 3) ... or at least check for:
> 
>      if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
> 
>    Which is what I'm doing right after the block above (2).
> 
>    But, at this point, by passing in the parameter to the
>    __setscheduler_uclamp() call, I get the benefits of:
> 
>    a) reducing uclamp specific code in the caller
>    b) avoiding the checks on !CONFIG_UCLAMP_TASK build
> 
> > >  {
> > >  	int group_id[UCLAMP_CNT] = { UCLAMP_NOT_VALID };
> > >  	int lower_bound, upper_bound;
> > >  	struct uclamp_se *uc_se;
> > >  	int result = 0;
> > >  
> > > +	if (!capable(CAP_SYS_ADMIN) &&
> > > +	    user && !uclamp_user_allowed) {
> > > +		return -EPERM;
> > > +	}
> > > +
> 
> Does all the above makes sense ?

If we agree on CAP_SYS_ADMIN, however, your approach looks cleaner yes.
