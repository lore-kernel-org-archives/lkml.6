Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E936C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2ED218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548929657;
	bh=xBRR9j2BXe+TUI9qsGa8DM1JP7gqPgKr2KsiuyuKTAw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YVISbuhNU8mx3ptl4p12dOC9GJHBfKsuxGAqkdx0ErY9apoYLdUyezooV5Desn1x3
	 HQpAt+6gn9kKR6ImbGSunDvPJNGZ5Dei0OCC4hbWvPQY3RLMuoSiit6aKT9Pzv5VY6
	 QL+T6OCpAbJa2bY3SdRnJyy7JJBWznaemii24UlE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732034AbfAaKOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:14:15 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45288 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729635AbfAaKOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:14:14 -0500
Received: by mail-oi1-f193.google.com with SMTP id y1so2217220oie.12;
        Thu, 31 Jan 2019 02:14:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P/Jws6e3aN00SQWrPyj3MGR+rd8FXHf3OC9KUt0eqsg=;
        b=Nozow7BYqGqXiwdEkwddmK4enNwZOPLE1YLH2ZoeW1rIC3XpueeNJ0KELR3+e4+u94
         HlxHCMhl4m9cSIs1fcqGwe3CyguEN+KUxhuGYjTsHNZJftjsDlG/uN2BM7Pdt8D1s16S
         iP8KXR08/NKI1ESTzhJUixpYQSFxDJTTel/0ZhOMvMZA3p66+e4exQgtuQgDK6n/a262
         ens7gYRwmpb3wLK3LPst3H7YMx/uDRUlrpTn/PRTXvPSm3FmQ+UsIsZxHKTP8v54rCas
         bEGjPsfDGYE3koCW2P7T5lmuvyEb+u9VdHpKeL2GngLQBPGR8Z1ynjgMkK7AFoFrIePW
         YwOA==
X-Gm-Message-State: AJcUukfOydoO8I3cmtE7xwHY5vBU91wUanXUN+70Qu0fSChfAbh4tb3K
        +H3TEtHfs+KGl/bsT+InONyGTQkukAcEOAU/AvtSZA==
X-Google-Smtp-Source: ALg8bN6sGH65zJscAIgUZ31Smv2Zb4q+rRpHG8h2kXhs3NOa76Susi8g5xDrLdK7DRk+lU9Q6g5nRy/1mZ9TgDbSLY4=
X-Received: by 2002:aca:e715:: with SMTP id e21mr15153294oih.76.1548929653827;
 Thu, 31 Jan 2019 02:14:13 -0800 (PST)
MIME-Version: 1.0
References: <20190131015139.126890-1-mka@chromium.org> <20190131083004.rkxehycu4pbbx52s@vireshk-i7>
 <CAJZ5v0hgBNY8cZgkn-u1qCCBrLxkS6T=srjMqsX50_H5V=ofHA@mail.gmail.com> <20190131100753.fjh6o3smmcjedxmz@vireshk-i7>
In-Reply-To: <20190131100753.fjh6o3smmcjedxmz@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 31 Jan 2019 11:14:03 +0100
Message-ID: <CAJZ5v0gp2tqMR1vOvzakhMRmG15OqMZ=ndKoAkmxLbzohn8VbA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Record stats when fast switching is enabled
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 11:07 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 31-01-19, 11:03, Rafael J. Wysocki wrote:
> > On Thu, Jan 31, 2019 at 9:30 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 30-01-19, 17:51, Matthias Kaehlcke wrote:
> > > > When fast switching is enabled currently no cpufreq stats are
> > > > recorded and the corresponding sysfs attributes appear empty (see
> > > > also commit 1aefc75b2449 ("cpufreq: stats: Make the stats code
> > > > non-modular")).
> > > >
> > > > Record the stats after a successful fast switch and re-enable access
> > > > through sysfs when fast switching is enabled. Since
> > > > cpufreq_stats_update() can now be called in interrupt context (during
> > > > a fast switch) disable local IRQs while holding the stats spinlock.
> > > >
> > > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > > ---
> > > > The change is so simple that I wonder if I'm missing some important
> > > > reason why the stats can't/shouldn't be updated during/after a fast
> > > > switch ...
> > > >
> > > > I would expect that holding the stats spinlock briefly in
> > > > cpufreq_stats_update() shouldn't be a problem. In theory it would
> > > > also be an option to have a per stats lock, though it seems overkill
> > > > from my (possibly ignorant) point of view.
> > > > ---
> > > >  drivers/cpufreq/cpufreq.c       |  8 +++++++-
> > > >  drivers/cpufreq/cpufreq_stats.c | 11 +++--------
> > > >  2 files changed, 10 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > > index e35a886e00bcf..63aadb0bbddfe 100644
> > > > --- a/drivers/cpufreq/cpufreq.c
> > > > +++ b/drivers/cpufreq/cpufreq.c
> > > > @@ -1857,9 +1857,15 @@ EXPORT_SYMBOL(cpufreq_unregister_notifier);
> > > >  unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
> > > >                                       unsigned int target_freq)
> > > >  {
> > > > +     unsigned int freq;
> > > > +
> > > >       target_freq = clamp_val(target_freq, policy->min, policy->max);
> > > >
> > > > -     return cpufreq_driver->fast_switch(policy, target_freq);
> > > > +     freq = cpufreq_driver->fast_switch(policy, target_freq);
> > > > +     if (freq)
> > > > +             cpufreq_stats_record_transition(policy, freq);
> > > > +
> > > > +     return freq;
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
> > > >
> > > > diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> > > > index 1572129844a5b..21b919bfaeccf 100644
> > > > --- a/drivers/cpufreq/cpufreq_stats.c
> > > > +++ b/drivers/cpufreq/cpufreq_stats.c
> > > > @@ -30,11 +30,12 @@ struct cpufreq_stats {
> > > >  static void cpufreq_stats_update(struct cpufreq_stats *stats)
> > > >  {
> > > >       unsigned long long cur_time = get_jiffies_64();
> > > > +     unsigned long flags;
> > > >
> > > > -     spin_lock(&cpufreq_stats_lock);
> > > > +     spin_lock_irqsave(&cpufreq_stats_lock, flags);
> > > >       stats->time_in_state[stats->last_index] += cur_time - stats->last_time;
> > > >       stats->last_time = cur_time;
> > > > -     spin_unlock(&cpufreq_stats_lock);
> > > > +     spin_unlock_irqrestore(&cpufreq_stats_lock, flags);
> > > >  }
> > >
> > > The only problem that I can think of (or recall) is that this routine
> > > also gets called when time_in_state sysfs file is read and that can
> > > end up taking lock which the scheduler's hotpath will wait for.
> >
> > What about the extra locking overhead in the scheduler context?
>
> What about using READ_ONCE/WRITE_ONCE here ? Not sure if we really
> need locking in this particular case.

If that works, then fine, but ISTR some synchronization issues related to that.
