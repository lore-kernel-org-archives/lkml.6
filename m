Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942EAC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60697218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QoOCYTyz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfAaShf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:37:35 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45539 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbfAaShc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 13:37:32 -0500
Received: by mail-pf1-f193.google.com with SMTP id g62so1850851pfd.12
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 10:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CNzffobzHxpFkjaVZ1LtsNvdUdh1F9uCbF5xY4A5XwQ=;
        b=QoOCYTyzrPXY+TrYrYsLp14/5BUuK/wCcdx4cme7XGn1OSg6mSj6Jd1XgIIg8Rv08X
         ESSJSMvJfa5TmEQyhdndoziMBKV1QhMPyj+hn+Tthv4YEXLQeMFAqAHIE4tpNn3BhVQh
         pivm7NzVMPmDDU+5mTRYb+hgeb+cRauRw6IW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CNzffobzHxpFkjaVZ1LtsNvdUdh1F9uCbF5xY4A5XwQ=;
        b=nV538mEG67nfp7hF0CcA2Q3PWsQoh6gdw2oCtYF0vXfLacKVjbcXOOA/oryCaCxFAG
         dZBOjOaK63uG5EBEdeP5WeFZRERMc/vWhQJnHHtnoAX6cNzj1xJZ+jMiSMo/rWwRvNtB
         b8ncSZ4nhcVci5DY/SDUNbvqP9rRyj/i1MCXeti7iyWVvBE15YiA0Y4pJmyjy6YfbHSD
         jAmw8QgdZkQRBFVuvORsNMr061tz9ZkEqdIlN1oR5uVFUxktKW7hwbh1i8VGhgPOwH1h
         ZjXugNN+AANdZKfR/vQudJoxSnEwnUOepf/0hBHIzz/urj/og5V0jmMI4POW+BVsGnZt
         kNaQ==
X-Gm-Message-State: AJcUukeJNuzKOqUl+WmVLFgZrkYOd0otzlSiHmeYPePfgWi+GwsHa3X2
        PgCyMLrVDlZFgQgkauvwqkfQSw==
X-Google-Smtp-Source: ALg8bN5sjU2qXzmJTaG47odupXS7koymqSIn5rOahKVnZKJglet0WPB5eREEFKn1RswWLzLkHCLVFw==
X-Received: by 2002:a63:9501:: with SMTP id p1mr32532511pgd.149.1548959851582;
        Thu, 31 Jan 2019 10:37:31 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id k64sm13986716pfc.122.2019.01.31.10.37.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 10:37:30 -0800 (PST)
Date:   Thu, 31 Jan 2019 10:37:30 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] cpufreq: Record stats when fast switching is enabled
Message-ID: <20190131183730.GN81583@google.com>
References: <20190131015139.126890-1-mka@chromium.org>
 <20190131083004.rkxehycu4pbbx52s@vireshk-i7>
 <CAJZ5v0hgBNY8cZgkn-u1qCCBrLxkS6T=srjMqsX50_H5V=ofHA@mail.gmail.com>
 <20190131100753.fjh6o3smmcjedxmz@vireshk-i7>
 <CAJZ5v0gp2tqMR1vOvzakhMRmG15OqMZ=ndKoAkmxLbzohn8VbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gp2tqMR1vOvzakhMRmG15OqMZ=ndKoAkmxLbzohn8VbA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 11:14:03AM +0100, Rafael J. Wysocki wrote:
> On Thu, Jan 31, 2019 at 11:07 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 31-01-19, 11:03, Rafael J. Wysocki wrote:
> > > On Thu, Jan 31, 2019 at 9:30 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > >
> > > > On 30-01-19, 17:51, Matthias Kaehlcke wrote:
> > > > > When fast switching is enabled currently no cpufreq stats are
> > > > > recorded and the corresponding sysfs attributes appear empty (see
> > > > > also commit 1aefc75b2449 ("cpufreq: stats: Make the stats code
> > > > > non-modular")).
> > > > >
> > > > > Record the stats after a successful fast switch and re-enable access
> > > > > through sysfs when fast switching is enabled. Since
> > > > > cpufreq_stats_update() can now be called in interrupt context (during
> > > > > a fast switch) disable local IRQs while holding the stats spinlock.
> > > > >
> > > > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > > > ---
> > > > > The change is so simple that I wonder if I'm missing some important
> > > > > reason why the stats can't/shouldn't be updated during/after a fast
> > > > > switch ...
> > > > >
> > > > > I would expect that holding the stats spinlock briefly in
> > > > > cpufreq_stats_update() shouldn't be a problem. In theory it would
> > > > > also be an option to have a per stats lock, though it seems overkill
> > > > > from my (possibly ignorant) point of view.
> > > > > ---
> > > > >  drivers/cpufreq/cpufreq.c       |  8 +++++++-
> > > > >  drivers/cpufreq/cpufreq_stats.c | 11 +++--------
> > > > >  2 files changed, 10 insertions(+), 9 deletions(-)
> > > > >
> > > > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > > > index e35a886e00bcf..63aadb0bbddfe 100644
> > > > > --- a/drivers/cpufreq/cpufreq.c
> > > > > +++ b/drivers/cpufreq/cpufreq.c
> > > > > @@ -1857,9 +1857,15 @@ EXPORT_SYMBOL(cpufreq_unregister_notifier);
> > > > >  unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
> > > > >                                       unsigned int target_freq)
> > > > >  {
> > > > > +     unsigned int freq;
> > > > > +
> > > > >       target_freq = clamp_val(target_freq, policy->min, policy->max);
> > > > >
> > > > > -     return cpufreq_driver->fast_switch(policy, target_freq);
> > > > > +     freq = cpufreq_driver->fast_switch(policy, target_freq);
> > > > > +     if (freq)
> > > > > +             cpufreq_stats_record_transition(policy, freq);
> > > > > +
> > > > > +     return freq;
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
> > > > >
> > > > > diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> > > > > index 1572129844a5b..21b919bfaeccf 100644
> > > > > --- a/drivers/cpufreq/cpufreq_stats.c
> > > > > +++ b/drivers/cpufreq/cpufreq_stats.c
> > > > > @@ -30,11 +30,12 @@ struct cpufreq_stats {
> > > > >  static void cpufreq_stats_update(struct cpufreq_stats *stats)
> > > > >  {
> > > > >       unsigned long long cur_time = get_jiffies_64();
> > > > > +     unsigned long flags;
> > > > >
> > > > > -     spin_lock(&cpufreq_stats_lock);
> > > > > +     spin_lock_irqsave(&cpufreq_stats_lock, flags);
> > > > >       stats->time_in_state[stats->last_index] += cur_time - stats->last_time;
> > > > >       stats->last_time = cur_time;
> > > > > -     spin_unlock(&cpufreq_stats_lock);
> > > > > +     spin_unlock_irqrestore(&cpufreq_stats_lock, flags);
> > > > >  }
> > > >
> > > > The only problem that I can think of (or recall) is that this routine
> > > > also gets called when time_in_state sysfs file is read and that can
> > > > end up taking lock which the scheduler's hotpath will wait for.
> > >
> > > What about the extra locking overhead in the scheduler context?
> >
> > What about using READ_ONCE/WRITE_ONCE here ? Not sure if we really
> > need locking in this particular case.
> 
> If that works, then fine, but ISTR some synchronization issues related to that.

I also think there would be synchronization issues :(

Is your main concern with the spin lock the contention case or the
general overhead of locking?

It would be really nice to have cpufreq stats with schedutil. We
initially considered a sysfs attribute to allow to temporarily disable
fast switching, but at closer sight this seems messy (would require
quite some rework in cpufreq_schedutil.c), besides not recording the
actual behavior.

If another (rarely and only shortly held) lock in scheduler context is
a no-go deferred recording could be an option, if that can be
implemented without locks in scheduler context.
