Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0953C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E96217C6
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E96217C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730100AbeHIMOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 08:14:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35375 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbeHIMOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 08:14:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id g1-v6so4607782wru.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 02:50:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i5Jr1LfDxInYdZWLslIxXL3LNdZ6Lf1WSFgYwnQQMi4=;
        b=F8789eELwK1PNNXsPnI+luD0yXbSdaAxlKaAARXAp9jeNk9FmBsAr7SbLBMNJAMznT
         L3HF1LRE3M7mLiTg7iPXsH0CQyxWd0LmfkD/KbnaJei5K1w7U5otf3wc8VAwAVAgpMuP
         IUtBV03I5CDcHjS6oymYTjAOzf9ABfiKI8RZftAjgSMj4genSKmI5IoBt/FYp5O6KPyV
         xXVBHbHa44cz9eIuwNEY6DjQ882GomeyW1ivr8UKDw6QlJ4hIi4oCYGe0rO+BWeOhMxR
         MCdUjd9GbZiE/24JIXGQDljqamuyyOjn5tQuPQoo3WpVKqdGPKcZoPPne/HHAkRp6Yth
         gz7w==
X-Gm-Message-State: AOUpUlHZxNKIPzqjfZ3uzZa0slH7gQpcFV8A/9Vf6xHp0kMbT4dvUd53
        U3nsRmJRv2mLtid+SDnip6N7mA==
X-Google-Smtp-Source: AA+uWPw296GVQf/0nt046qYtjTgit2k8nCMO2IQwYUxH2V5IQMB7SKfF1oFpeaY3W1q4W67QOV/wDg==
X-Received: by 2002:adf:f188:: with SMTP id h8-v6mr1031696wro.214.1533808245785;
        Thu, 09 Aug 2018 02:50:45 -0700 (PDT)
Received: from localhost.localdomain (hsvpn34.hotsplots.net. [176.74.57.181])
        by smtp.gmail.com with ESMTPSA id l11-v6sm9265098wru.25.2018.08.09.02.50.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 02:50:45 -0700 (PDT)
Date:   Thu, 9 Aug 2018 11:50:43 +0200
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
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v3 01/14] sched/core: uclamp: extend sched_setattr to
 support utilization clamping
Message-ID: <20180809095043.GC22465@localhost.localdomain>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-2-patrick.bellasi@arm.com>
 <20180807123550.GA3062@localhost.localdomain>
 <20180809091427.4p2c4fbxocpkjaby@darkstar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809091427.4p2c4fbxocpkjaby@darkstar>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/18 10:14, Patrick Bellasi wrote:
> On 07-Aug 14:35, Juri Lelli wrote:
> > On 06/08/18 17:39, Patrick Bellasi wrote:
> > 
> > [...]
> > 
> > > @@ -4218,6 +4245,13 @@ static int __sched_setscheduler(struct task_struct *p,
> > >  			return retval;
> > >  	}
> > >  
> > > +	/* Configure utilization clamps for the task */
> > > +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP) {
> > > +		retval = __setscheduler_uclamp(p, attr);
> > > +		if (retval)
> > > +			return retval;
> > > +	}
> > > +
> > 
> > IIUC, this is available to root and non-root users. In the latter case,
> > how do we cope with the fact that some user might occupy all the
> > available clamping groups configured for the system?
> 
> That's a very good point, glad you noticed it.
> 
> What concern me most is that we set constraints to the cgroups
> delegation model. If all clamp groups have been used it could be
> not possible for a parent group to shrink resources for its subgroups.

Right, when groups are in use the problem might actually be even more
serious.

> In both cases however, in principle, I think we can live with the idea
> that the "System Management Software" (SMS) can pre-allocate all the
> required boost groups at boot time;  malicious tasks and dependent
> groups will eventually get an -ENOSPC error.
> 
> These are the main reason why I did not posted a more "safe" solution:
> this series is already big enough, a properly (pre)configured system
> is still reasonably functional safe and  this feature can be added in
> a second step.

I see, but I also fear that there will be times and usages of this new
interface where no SMS is present.

> However, I already have a couple of possible extensions/fixes which I
> can add on top on the next respin. They are along these lines:

These are exactly what I was thinking about as well. :-)

> 1) make CAP_SYS_NICE protected the clamp groups, with an optional boot
>    time parameter to relax this check

It seems to me that this might work well with that the intended usage of
the interface that you depict above. SMS only (or any privileged user)
will be in control of how groups are configured, so no problem for
normal users.

> 2) add discretization support to clamp groups allocation

And this might also work well if we feel that we don't want to restrict
usage of the interface to admin only, however...

> This second feature specifically, will ensure that clamp values are
> always mapped into one of the available clamp groups. While the exact
> clamp value can always be used for tasks placement biasing, when it
> comes to frequency selection biasing, depending on concurrently
> running tasks, you can end up with an effective clamp value which is a
> rounded up.

what I'm not so sure about is that we might lose in flexibility if the
number of available discrete clamp groups is too small compared to the
number of available OPP on the platform.

> Will likely add a couple of additional patches on v4 posting.
> Do you have any other possible idea?

As said, I though as well about the two options you mentioned.
