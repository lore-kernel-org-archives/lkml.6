Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E70CC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 10:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF58D21748
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 10:50:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF58D21748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbeHMNcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 09:32:24 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:34778 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728338AbeHMNcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 09:32:24 -0400
Received: by mail-wm0-f54.google.com with SMTP id l2-v6so7319120wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 03:50:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NkwmbVxmW5qQWHBsMIOCMC0MbVCk9XiGiMhn1RNYRzg=;
        b=Wb8YvajdH89OUN5BQeY1HwBEtNnnhWlzasIohdBJzsleUKx7Wp53+sRa99x1mIRk8j
         YkXMOFqflW8m2CEKJ2Za+Zd4ue31B6MyhzWq6MRX2E9qls9qK7G8oAjHVo4DDC9TRmeE
         mwFska7mkkwy0LyfPrJDA8AwRwZ8cR2YIY+lC7PpnHTnFFEUe6Ai4mVeNl5hwxA/ikR9
         WmgOTNMI+nukuT3hub15loq5HZnXRgtXUtv1ta8Tagi2frb5bAIOfEtjFEm1dWkUjow5
         23/WUYdQpqjuESbjHRjv+0U8gXsRX8uhxrHT1rNjLBW78zH43kxmT7azxXN7Rxtj/LEt
         D6ZA==
X-Gm-Message-State: AOUpUlGwyIRr5JgxFSpoQUwqyQqDJBcVcgIK35hgAuS0L+ISYHlbRIj7
        xMf7xoj6Nw7/P/oHlTsqCrziTw==
X-Google-Smtp-Source: AA+uWPzS/xknmrfVqIuQ6aMV5I3f4XJdQBN1VXHeSYhRiM5Ru4IDr5Svp4wgJps1ClXDuoU9Yxf/lg==
X-Received: by 2002:a1c:dc41:: with SMTP id t62-v6mr1417946wmg.137.1534157439330;
        Mon, 13 Aug 2018 03:50:39 -0700 (PDT)
Received: from localhost.localdomain (p200300EF2BCE7D88DAEEE59932720558.dip0.t-ipconnect.de. [2003:ef:2bce:7d88:daee:e599:3272:558])
        by smtp.gmail.com with ESMTPSA id r12-v6sm6061267wmc.27.2018.08.13.03.50.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 03:50:38 -0700 (PDT)
Date:   Mon, 13 Aug 2018 12:50:34 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        "Cc: Steve Muckle" <smuckle@google.com>, surenb@google.com
Subject: Re: [PATCH v3 06/14] sched/cpufreq: uclamp: add utilization clamping
 for RT tasks
Message-ID: <20180813105034.GB9851@localhost.localdomain>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-7-patrick.bellasi@arm.com>
 <20180807132630.GB3062@localhost.localdomain>
 <20180809153423.nsoepprhut3dv4u2@darkstar>
 <CAKfTPtCWcq2bOmaC5EDdhS8ih8Sv7Mwzn=84xerKA2tY6kXLkw@mail.gmail.com>
 <20180813101221.GA2605@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180813101221.GA2605@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/08/18 11:12, Patrick Bellasi wrote:
> Hi Vincent!
> 
> On 09-Aug 18:03, Vincent Guittot wrote:
> > > On 07-Aug 15:26, Juri Lelli wrote:
> 
> [...]
> 
> > > > > +   util_cfs = cpu_util_cfs(rq);
> > > > > +   util_rt  = cpu_util_rt(rq);
> > > > > +   if (sched_feat(UCLAMP_SCHED_CLASS)) {
> > > > > +           util = 0;
> > > > > +           if (util_cfs)
> > > > > +                   util += uclamp_util(cpu_of(rq), util_cfs);
> > > > > +           if (util_rt)
> > > > > +                   util += uclamp_util(cpu_of(rq), util_rt);
> > > > > +   } else {
> > > > > +           util  = cpu_util_cfs(rq);
> > > > > +           util += cpu_util_rt(rq);
> > > > > +           util  = uclamp_util(cpu_of(rq), util);
> > > > > +   }
> > >
> > > Regarding the two policies, do you have any comment?
> > 
> > Does the policy for (sched_feat(UCLAMP_SCHED_CLASS)== true) really
> > make sense as it is ?
> > I mean, uclamp_util doesn't make any difference between rt and cfs
> > tasks when clamping the utilization so why should be add twice the
> > returned value ?
> > IMHO, this policy would make sense if there were something like
> > uclamp_util_rt() and a uclamp_util_cfs()
> 
> The idea for the UCLAMP_SCHED_CLASS policy is to improve fairness on
> low-priority classese, especially when we have high RT utilization.
> 
> Let say we have:
> 
>  util_rt  = 40%, util_min=0%
>  util_cfs = 10%, util_min=50%
> 
> the two policies will select:
> 
>   UCLAMP_SCHED_CLASS: util = uclamp(40) + uclamp(10) = 50 + 50   = 100%
>  !UCLAMP_SCHED_CLASS: util = uclamp(40 + 10)         = uclmp(50) =  50%
> 
> Which means that, despite the CPU's util_min will be set to 50% when
> CFS is running, these tasks will have almost no boost at all, since
> their bandwidth margin is eclipsed by RT tasks.

Ah, right. But isn't possible to distinguish between classes? I mean, if
you would know that only CFS is clamped (boosted) in this case, you
could have:

 util = util_rt + uclamp(util_cfs) = 40 + 50 = 90%

Which should do what one expects w/o energy side effects?
