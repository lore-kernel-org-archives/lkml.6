Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9073C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 21:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EEB5208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 21:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EEB5208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbeJPEuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 00:50:23 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33639 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbeJPEuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 00:50:22 -0400
Received: by mail-ot1-f67.google.com with SMTP id q50so20362111otd.0;
        Mon, 15 Oct 2018 14:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oYT+Di1Qh0rrs/VeVc9aCr/oI6BBvWbNg51Y1/zNsAU=;
        b=A8Hq2J18Jfin6161AxyhBM7QFS1GAdndeMzgNl42w81xcJ3SA4BYTLEo5YR1PqekP7
         9dExkKKKIM+kudSKu83W67+xm5tPRkvD91oG20YzjXvXaQiwHfoBw3Xwd3FG99HY7V0v
         PDqBZrBhV2ekYGvKdjJUOXv0aXmqIRIpWDWm+/uJ5iakw5XKAaacOaujfNrb635N9s2Q
         VM5uFH1ukb3vcnMlg9ynh5a8k32SjNvaXKjXpV4cKpDTL09OyHTPfb8SbOVA3WYAuKn0
         dt4tHyxwEI9z+Mz1YOyh+GVym8ayMmoann5Smd9uTjdvpfq//vgyVSmDaygvCu/qHhRB
         RAMQ==
X-Gm-Message-State: ABuFfohb42YSEQWqDTYhbrgbn/aZe2q06741+tLCSm9zeoQ7beTnaZK4
        Qjy9Dm9/cOYoLValaFs0i6RaBf+KjESqVKNUD98=
X-Google-Smtp-Source: ACcGV63Zc6CGNmSioBTyJr9eF1g1H6IBQDJCD8YWyOqWUC9sYrFLStNkyeCdm+i/fctlO3hPGB8CbyishjmVNqyJAZI=
X-Received: by 2002:a9d:4c90:: with SMTP id m16mr11296383otf.124.1539637405370;
 Mon, 15 Oct 2018 14:03:25 -0700 (PDT)
MIME-Version: 1.0
References: <20181008150901.19667-1-waldemar.rymarkiewicz@gmail.com>
 <2671493.AgiGORq3CZ@aspire.rjw.lan> <CAHKzcEPuD7nnmvBjnUNn=wb-5LfN1nHoTYBekAiBFG8Je+oPwA@mail.gmail.com>
 <1926816.WaOCFmosuL@aspire.rjw.lan> <CAHKzcEOECQP8j6q=NKzuEjF+mc0s80fr6xWw-=NXsTtzCGGg_w@mail.gmail.com>
In-Reply-To: <CAHKzcEOECQP8j6q=NKzuEjF+mc0s80fr6xWw-=NXsTtzCGGg_w@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 15 Oct 2018 23:03:13 +0200
Message-ID: <CAJZ5v0gFjBoFi=cpC2gPkZTDZof8dxdCCVx0XoAv2XuPmTfWPA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: conservative: Fix requested_freq handling
To:     Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        t.bartholomae@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 2:51 PM Waldemar Rymarkiewicz
<waldemar.rymarkiewicz@gmail.com> wrote:
>
> On Mon, 15 Oct 2018 at 13:34, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > On Monday, October 15, 2018 11:34:33 AM CEST Waldemar Rymarkiewicz wrote:
> > > On Thu, 11 Oct 2018 at 23:10, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > >
> > > > On Tuesday, October 9, 2018 6:06:08 PM CEST Waldemar Rymarkiewicz wrote:
> > > > > On Tue, 9 Oct 2018 at 09:47, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > > >
> > > > > > On Mon, Oct 8, 2018 at 5:11 PM Waldemar Rymarkiewicz
> > > > > > <waldemar.rymarkiewicz@gmail.com> wrote:
> > > > > > >
> > > > > > > From: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>
> > > > > > >
> > > > > > > The governor updates dbs_info->requested_freq only after increasing or
> > > > > > > decreasing frequency. There is, however, an use case when this is not
> > > > > > > sufficient.
> > > > > > >
> > > > > > > Imagine, external module constraining cpufreq policy in a way that policy->max
> > > > > >
> > > > > > Is the "external module" here a utility or a demon running in user space?
> > > > >
> > > > > No, this is a driver that communicates with a firmware and makes sure
> > > > > CPU is running at the highest rate in specific time.
> > > > > It uses verify_within_limits  and update_policy, a standard way to
> > > > > constraint cpufreq policy limits.
> > > > >
> > > > > > > @@ -136,10 +135,10 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
> > > > > > >                         requested_freq = policy->min;
> > > > > > >
> > > > > > >                 __cpufreq_driver_target(policy, requested_freq, CPUFREQ_RELATION_L);
> > > > > > > -               dbs_info->requested_freq = requested_freq;
> > > > > > >         }
> > > > > > >
> > > > > > >   out:
> > > > > > > +       dbs_info->requested_freq = requested_freq;
> > > > > >
> > > > > > This will have a side effect when requested_freq is updated before the
> > > > > > thresholds checks due to the policy_dbs->idle_periods < UINT_MAX
> > > > > > check.
> > > > > >
> > > > > > Shouldn't that be avoided?
> > > > >
> > > > > I would say we should.
> > > > >
> > > > > A hardware design I use is running 4.9 kernel where the check does not
> > > > > exist yet, so there is not a problem.
> > > > > Anyway, the check policy_dbs->idle_periods < UINT_MAX  can change
> > > > > requested_freq  either to requested_freq = policy->min or
> > > > > requested_freq -= freq_steps;. The first case will not change anything
> > > > > for us as policy->max=min=cur. The second, however, will force to
> > > > > update freq which is definitely not expected when limits are set to
> > > > > min=max. Simply it will not go out  here:
> > > > >
> > > > > if (load < cs_tuners->down_threshold) {
> > > > >       if (requested_freq == policy->min)
> > > > >            goto out;   <---
> > > > > ...
> > > > > }
> > > > >
> > > > > Am I right here? If so, shouldn't we check explicitly
> > > > >
> > > > > /*
> > > > > * If requested_freq is out of range, it is likely that the limits
> > > > > * changed in the meantime, so fall back to current frequency in that
> > > > > * case.
> > > > > */
> > > > > if (requested_freq > policy->max || requested_freq < policy->min)
> > > > >        requested_freq = policy->cur;
> > > > >
> > > > > +/*
> > > > > +* If the the new limits min,max are equal, there is no point to process further
> > > > > +*/
> > > > > +
> > > > > +if (requested_freq == policy->max  &&  requested_freq == policy->min)
> > > > > +     goto out;
> > > >
> > > > If my understanding of the problem is correct, it would be better to simply
> > > > update dbs_info->requested_freq along with requested_freq when that is found
> > > > to be out of range.  IOW, something like the appended patch (untested).
> > >
> > > Yes, this will solve the original problem as well.
> > >
> > > I think there could also be a  problem with policy_dbs->idle_periods <
> > > UINT_MAX  check. It it's true it  can modify requested_freq (
> > > requested_freq -= freq_steps) and further it can result in a change of
> > > the freq,  requested_freq == policy->max is not anymore true. I would
> > > expect governor not to change freq (requested_freq) when
> > > policy->max=policy->min=policy->cur.
> >
> > Well, that's because there is a bug in that code IMO.  It should never
> > decrease requested_freq below policy->min in particular.
> >
> > Please find a patch with that fixed below.
> >
> > ---
> >  drivers/cpufreq/cpufreq_conservative.c |    6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > Index: linux-pm/drivers/cpufreq/cpufreq_conservative.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpufreq/cpufreq_conservative.c
> > +++ linux-pm/drivers/cpufreq/cpufreq_conservative.c
> > @@ -80,8 +80,10 @@ static unsigned int cs_dbs_update(struct
> >          * changed in the meantime, so fall back to current frequency in that
> >          * case.
> >          */
> > -       if (requested_freq > policy->max || requested_freq < policy->min)
> > +       if (requested_freq > policy->max || requested_freq < policy->min) {
> >                 requested_freq = policy->cur;
> > +               dbs_info->requested_freq = requested_freq;
> > +       }
> >
> >         freq_step = get_freq_step(cs_tuners, policy);
> >
> > @@ -92,7 +94,7 @@ static unsigned int cs_dbs_update(struct
> >         if (policy_dbs->idle_periods < UINT_MAX) {
> >                 unsigned int freq_steps = policy_dbs->idle_periods * freq_step;
> >
> > -               if (requested_freq > freq_steps)
> > +               if (requested_freq > policy->min + freq_steps)
> >                         requested_freq -= freq_steps;
> >                 else
> >                         requested_freq = policy->min;
>
> Yes looks good now. Will you apply this patch?

Yes, I will, but let me resend it with a proper changelog first.

Thanks,
Rafael
