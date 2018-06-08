Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id mF5MF498Gls5FgAAmS7hNA
	; Fri, 08 Jun 2018 12:54:55 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D0EBC608B8; Fri,  8 Jun 2018 12:54:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3EC54607A4;
	Fri,  8 Jun 2018 12:54:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3EC54607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbeFHMyx (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 08:54:53 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37315 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751549AbeFHMyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 08:54:52 -0400
Received: by mail-wr0-f194.google.com with SMTP id d8-v6so13313634wro.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 05:54:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N3UWDhXUJwXibFweqs7AZnmEnDLQt+SA0gLXNCOh75Q=;
        b=cDd0RHjFDGSYaZZUfVgZWWXQtosnA9qTDykR9FO6GxJRTEIvsHJIjWmWF347U79x49
         raVRMn4CQWKFCn0wXQIzgHTJEpko3Ctld7vyUQ9SeePuSC/9GpStOVxJ6ENq5jOzs8Kf
         uc/Mgs1KLQtUM8LM3VXH72REnDhXktwlpcz4s1+MTtfUGvW4jBt1ID+JjJQl8aoNU52F
         EDDSoGt6Yx3PMdmlKk2j8dl67II9tBoOv4ozykP71kQ1oiavBcd5b2xbv/A/0PNyM+x/
         jy/Vi9jtMiDSOMacnjIHsQn7CgnVX5gDwXrffyx+poWQkD/AUJU/+CNCPEZBUqPZ43gk
         IrlA==
X-Gm-Message-State: APt69E1hjsAIX7RDaqGCo9ADJW0x5uG5OCKN9l+MH8WYWFZVxHc62C7A
        C/ddkh6uLDecMaTadqLJLE4vZA==
X-Google-Smtp-Source: ADUXVKJUZICDcinl0MLdlA+62isGzaW1/ICikC8lW1twIuANKmGk0hqbVtmz3CoWBl8vthxE1V7X1A==
X-Received: by 2002:adf:8290:: with SMTP id 16-v6mr4871981wrc.38.1528462491071;
        Fri, 08 Jun 2018 05:54:51 -0700 (PDT)
Received: from localhost.localdomain ([151.15.207.242])
        by smtp.gmail.com with ESMTPSA id a9-v6sm1324437wmh.38.2018.06.08.05.54.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Jun 2018 05:54:50 -0700 (PDT)
Date: Fri, 8 Jun 2018 14:54:48 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v6 06/11] cpufreq/schedutil: use dl utilization tracking
Message-ID: <20180608125448.GR16089@localhost.localdomain>
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
 <1528459794-13066-7-git-send-email-vincent.guittot@linaro.org>
 <20180608123959.GE16089@localhost.localdomain>
 <CAKfTPtCTMFN2Hed9Ku=VLH2Uwm4sC1kBBa5yRbb20r0o=-R7jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCTMFN2Hed9Ku=VLH2Uwm4sC1kBBa5yRbb20r0o=-R7jw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/18 14:48, Vincent Guittot wrote:
> On 8 June 2018 at 14:39, Juri Lelli <juri.lelli@redhat.com> wrote:
> > Hi Vincent,
> >
> > On 08/06/18 14:09, Vincent Guittot wrote:
> >> Now that we have both the dl class bandwidth requirement and the dl class
> >> utilization, we can detect when CPU is fully used so we should run at max.
> >> Otherwise, we keep using the dl bandwidth requirement to define the
> >> utilization of the CPU
> >>
> >> Cc: Ingo Molnar <mingo@redhat.com>
> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> >> ---
> >
> > [...]
> >
> >> @@ -190,20 +192,24 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
> >>       if (rq->rt.rt_nr_running)
> >>               return sg_cpu->max;
> >>
> >> -     util = sg_cpu->util_dl;
> >> -     util += sg_cpu->util_cfs;
> >> +     util = sg_cpu->util_cfs;
> >>       util += sg_cpu->util_rt;
> >>
> >> +     if ((util + sg_cpu->util_dl) >= sg_cpu->max)
> >> +             return sg_cpu->max;
> >> +
> >
> > Mmm, won't we run at max (or reach max) with a, say, 100ms/500ms DL task
> > running alone?
> 
> not for a 100ms running task. You have to run more than 320ms to reach max value
> 
> 100ms/500ms will vary between 0 and 907

OK, right, my point I guess is still that such a task will run fine at
~250 and it might be save more energy by doing so?

Also, less freq switches (consider for example a few background CFS
tasks waking up from time to time).
