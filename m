Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DD7C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D55920B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BAjHNDMv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731852AbfAaKH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:07:58 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41124 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfAaKH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:07:57 -0500
Received: by mail-pf1-f193.google.com with SMTP id b7so1249926pfi.8
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 02:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h1wdf+H62wX3SvTA/nPqdW0PpVoISzhXuV/VKcNWBnU=;
        b=BAjHNDMv+tTR989hDvw2czbHz6npz3WZORx+UxsdOFA1s9TcYfiR9YqJ8tC4QTeOrc
         Crpp4S17aM9D1BGD0zDUVuWG8R6ykApMizPybP3uQYtVq5bEfp1TTKNQPEwW4W41RTWq
         WzCnZqrhOyiquRoadyiWeMe53kyjkl9G/wUuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h1wdf+H62wX3SvTA/nPqdW0PpVoISzhXuV/VKcNWBnU=;
        b=VjUjRsYqmIYfS82x5r34RPvi/0HQbpdrYPqcknurIpMeH8KnKmaAUycwUtUdYe98qU
         a1sTutGpbzFAxdyqrIXp/rR/mb4smFcRGuA25XggZzWXBoPMr/LzAE2EZYb4BWszS/AZ
         YtSMVCU8fftT7RZy+xX1NCeVUK26jFxkPEH3phaUrt/V5MAHtkYMswueZOTxV6FHjNr+
         EcSAMcGxwH2/PCESbx3AgqCTq3Ky9fdaf0pOtTWleBbwiYAt7N0H2+CsihI398T95F/M
         XgQNwQhRCxTJBcTuHC1r70qwRoKSV2el2mQJzu3ryqKentIw9tWVLjzYdfIzosLUWO3w
         h55w==
X-Gm-Message-State: AJcUukdJ8TQPFH4w3RVXfo2xzeVT+AmKoz7htvzd8xJZV6XLm6Xg4RRC
        OqUUZVro42lgboERFndkJ5/E3A==
X-Google-Smtp-Source: ALg8bN6IXQIHaFHUkuWGgKYNTBLCTccmZ0fBwnv4yluw1s8t0rsjQeiZkstswRwfdVpGPblEvO8Tkw==
X-Received: by 2002:a63:3d49:: with SMTP id k70mr30932849pga.191.1548929276202;
        Thu, 31 Jan 2019 02:07:56 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id w136sm7103696pfd.169.2019.01.31.02.07.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 02:07:55 -0800 (PST)
Date:   Thu, 31 Jan 2019 15:37:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] cpufreq: Record stats when fast switching is enabled
Message-ID: <20190131100753.fjh6o3smmcjedxmz@vireshk-i7>
References: <20190131015139.126890-1-mka@chromium.org>
 <20190131083004.rkxehycu4pbbx52s@vireshk-i7>
 <CAJZ5v0hgBNY8cZgkn-u1qCCBrLxkS6T=srjMqsX50_H5V=ofHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hgBNY8cZgkn-u1qCCBrLxkS6T=srjMqsX50_H5V=ofHA@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-01-19, 11:03, Rafael J. Wysocki wrote:
> On Thu, Jan 31, 2019 at 9:30 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 30-01-19, 17:51, Matthias Kaehlcke wrote:
> > > When fast switching is enabled currently no cpufreq stats are
> > > recorded and the corresponding sysfs attributes appear empty (see
> > > also commit 1aefc75b2449 ("cpufreq: stats: Make the stats code
> > > non-modular")).
> > >
> > > Record the stats after a successful fast switch and re-enable access
> > > through sysfs when fast switching is enabled. Since
> > > cpufreq_stats_update() can now be called in interrupt context (during
> > > a fast switch) disable local IRQs while holding the stats spinlock.
> > >
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> > > The change is so simple that I wonder if I'm missing some important
> > > reason why the stats can't/shouldn't be updated during/after a fast
> > > switch ...
> > >
> > > I would expect that holding the stats spinlock briefly in
> > > cpufreq_stats_update() shouldn't be a problem. In theory it would
> > > also be an option to have a per stats lock, though it seems overkill
> > > from my (possibly ignorant) point of view.
> > > ---
> > >  drivers/cpufreq/cpufreq.c       |  8 +++++++-
> > >  drivers/cpufreq/cpufreq_stats.c | 11 +++--------
> > >  2 files changed, 10 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > index e35a886e00bcf..63aadb0bbddfe 100644
> > > --- a/drivers/cpufreq/cpufreq.c
> > > +++ b/drivers/cpufreq/cpufreq.c
> > > @@ -1857,9 +1857,15 @@ EXPORT_SYMBOL(cpufreq_unregister_notifier);
> > >  unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
> > >                                       unsigned int target_freq)
> > >  {
> > > +     unsigned int freq;
> > > +
> > >       target_freq = clamp_val(target_freq, policy->min, policy->max);
> > >
> > > -     return cpufreq_driver->fast_switch(policy, target_freq);
> > > +     freq = cpufreq_driver->fast_switch(policy, target_freq);
> > > +     if (freq)
> > > +             cpufreq_stats_record_transition(policy, freq);
> > > +
> > > +     return freq;
> > >  }
> > >  EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
> > >
> > > diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> > > index 1572129844a5b..21b919bfaeccf 100644
> > > --- a/drivers/cpufreq/cpufreq_stats.c
> > > +++ b/drivers/cpufreq/cpufreq_stats.c
> > > @@ -30,11 +30,12 @@ struct cpufreq_stats {
> > >  static void cpufreq_stats_update(struct cpufreq_stats *stats)
> > >  {
> > >       unsigned long long cur_time = get_jiffies_64();
> > > +     unsigned long flags;
> > >
> > > -     spin_lock(&cpufreq_stats_lock);
> > > +     spin_lock_irqsave(&cpufreq_stats_lock, flags);
> > >       stats->time_in_state[stats->last_index] += cur_time - stats->last_time;
> > >       stats->last_time = cur_time;
> > > -     spin_unlock(&cpufreq_stats_lock);
> > > +     spin_unlock_irqrestore(&cpufreq_stats_lock, flags);
> > >  }
> >
> > The only problem that I can think of (or recall) is that this routine
> > also gets called when time_in_state sysfs file is read and that can
> > end up taking lock which the scheduler's hotpath will wait for.
> 
> What about the extra locking overhead in the scheduler context?

What about using READ_ONCE/WRITE_ONCE here ? Not sure if we really
need locking in this particular case.

-- 
viresh
