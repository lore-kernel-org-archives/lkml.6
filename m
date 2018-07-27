Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D08FC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 00:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A7E20857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 00:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="UInheXtX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A7E20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732005AbeG0B6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 21:58:37 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44223 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731918AbeG0B6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 21:58:37 -0400
Received: by mail-pl0-f65.google.com with SMTP id m16-v6so1534426pls.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 17:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4opr+/kHytBWMkdVdGM8uECAls6MsLpo+kmC9K8FzLs=;
        b=UInheXtXHoL+Wg8MZ02XJMAqu5psEr5g0313KlbI0MML96BqdGx2OEPawjbnMrUtlo
         IKSHeEGZArkdQruLrsgIrtH/4F94dmZ7D/UIxlASGU/ByqHB3Y4PjHyEozWWd/CB+UmJ
         +bq6RVwtIjUXUBIXEdlzS0LgaP1WN2dil5DsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4opr+/kHytBWMkdVdGM8uECAls6MsLpo+kmC9K8FzLs=;
        b=jDQWkp9iBmmcBvX1CNNJUbpGbAQiuN0VICdsAkxPWJWkk6+nrvZxiXe9sFL5FzktGw
         yTw5cNyJ/omOXB8yJ3yyuUEGmEEt690sK7V5I7r24XOQqJw4mSGVBE/BKbYv+aiWNfe0
         m5tZHwKxwLmOhDJ/NEScgzlSQlbCJETGRBZh2f5RF6cu1QX9Vud+mp+0NnkOJCHmQavy
         i4GkiByU2/KK3hQzf8hlwjopZfvMsBGvCGYk54En1pm+eHXc7DO77KAtuq1T6IBVx5/B
         PB866WHdVdGjkNwaBu+sACr8OGBPM+wO76CgoBIysXVulgtRJF2sMnWyxXJZ2nX46N7x
         o/wQ==
X-Gm-Message-State: AOUpUlFr2Q7a8+I6myc+1aQF9Mi2LJAV9n91XMFGKPYhc05hRbkCRAy9
        8nTc8XNR8ieo+t0G1u/JrfyYAQ==
X-Google-Smtp-Source: AAOMgpfal6HBLJi7ISYsQPO1YvCbp4gBhPyr/oIkr6zebew6P+Mmbjzdrcx5EU7SXUG4pcwtXMULbQ==
X-Received: by 2002:a17:902:9a06:: with SMTP id v6-v6mr3893781plp.21.1532651960915;
        Thu, 26 Jul 2018 17:39:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id u2-v6sm4065372pfn.59.2018.07.26.17.39.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 17:39:20 -0700 (PDT)
Date:   Thu, 26 Jul 2018 17:39:19 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Patrick Bellasi <patrick.bellasi@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v2 08/12] sched/core: uclamp: extend cpu's cgroup
 controller
Message-ID: <20180727003919.GA22416@joelaf.mtv.corp.google.com>
References: <20180716082906.6061-1-patrick.bellasi@arm.com>
 <20180716082906.6061-9-patrick.bellasi@arm.com>
 <20180723153040.GG1934745@devbig577.frc2.facebook.com>
 <20180723172215.GG2683@e110439-lin>
 <20180724132902.GI1934745@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724132902.GI1934745@devbig577.frc2.facebook.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 06:29:02AM -0700, Tejun Heo wrote:
> Hello, Patrick.
> 
> On Mon, Jul 23, 2018 at 06:22:15PM +0100, Patrick Bellasi wrote:
> > However, the "best effort" bandwidth control we have for CFS and RT
> > can be further improved if, instead of just looking at time spent on
> > CPUs, we provide some more hints to the scheduler to know at which
> > min/max "MIPS" we want to consume the (best effort) time we have been
> > allocated on a CPU.
> > 
> > Such a simple extension is still quite useful to satisfy many use-case
> > we have, mainly on mobile systems, like the ones I've described in the
> >    "Newcomer's Short Abstract (Updated)"
> > section of the cover letter:
> >    https://lore.kernel.org/lkml/20180716082906.6061-1-patrick.bellasi@arm.com/T/#u
> 
> So, that's all completely fine but then let's please not give it a
> name which doesn't quite match what it does.  We can just call it
> e.g. cpufreq range control.

But then what name can one give it if it does more than one thing, like
task-placement and CPU frequency control?

It doesn't make sense to name it cpufreq IMHO. Its a clamp on the utilization
of the task which can be used for many purposes.

thanks,

- Joel

