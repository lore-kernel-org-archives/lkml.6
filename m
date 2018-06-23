Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0F3C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 01:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1A524A88
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 01:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LDgjSVKY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1A524A88
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934583AbeFWBbs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 21:31:48 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35827 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934497AbeFWBbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 21:31:45 -0400
Received: by mail-pg0-f68.google.com with SMTP id i7-v6so3678658pgp.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 18:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3WmBgyx5cmvlLg+JI30mRW4noykptXXNtQEpnIsPots=;
        b=LDgjSVKY33B9Huu4VdOg+pekzqxDaVpHKDL3wrEq1TwISPdWm3ICPb4rTP5qhd001o
         U7VtjTyN5oTlpCyMh+z9alOQ1CWSYdVXlg1T6bZ3AkGJ5dg7tTZqApxMkuwrAsyAhne2
         D/3CVwilzTsVACCJEdbBBK1Xz44SI46YeVRjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3WmBgyx5cmvlLg+JI30mRW4noykptXXNtQEpnIsPots=;
        b=NSnkSOA75O2yCYkQNxjYYs8XarA9fBGMJOk0QSyMPgGFClm6MvPZUaJT8i+KmOZ571
         qbMThtbFEH/nsf0Rn/WXwXecPvcOB2cEqFDT4cm/80j6isL4kLhberz4y4eP8jM4s6/4
         sibJJDW8779/tSfFgsEy3YXyqtO/MR3thyFa073kCcuwrrkWQUWGuHMWWSAfGGlvcOoW
         ob4SxuLt0WnYnqHMUDqg/M05/sIQ8xOBAMFW9JmUrYAuBjmpRP/J6C2vfBrrPbpP8fsX
         554oRuzGyydXvLPLH31tZumOwfEQHYiFiggdGnXDxMwAXxYWG/tepD6ERfL/GhsdZzyP
         q6jQ==
X-Gm-Message-State: APt69E2UBOOb+Z8yHUpGm/lGQgb8D+sVFkII+YBjnzn3JEtjddPi5hik
        1gvMU7scvi30Y1usEYR1EzPWdLQf0OU=
X-Google-Smtp-Source: ADUXVKJGOKAromnhVw7XeD8bAFyv4fCyHQabwd8LBYf/WwqTCUZQnCACDJa9J7XdgdNnRxKuRIQFZg==
X-Received: by 2002:aa7:818b:: with SMTP id g11-v6mr3997116pfi.50.1529717504872;
        Fri, 22 Jun 2018 18:31:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id a23-v6sm20661019pfj.117.2018.06.22.18.31.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 18:31:43 -0700 (PDT)
Date:   Fri, 22 Jun 2018 18:31:43 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v4 10/12] misc: throttler: Add core support for
 non-thermal throttling
Message-ID: <20180623013143.GC129942@google.com>
References: <20180621015237.100100-1-mka@chromium.org>
 <20180621015237.100100-11-mka@chromium.org>
 <20180622020332.GA180395@ban.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180622020332.GA180395@ban.mtv.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 07:04:33PM -0700, Brian Norris wrote:
> Hi,
> 
> A few more things I noticed; probably my last thoughts on this
> particular patch; and I think I reviewed the rest:
> 
> On Wed, Jun 20, 2018 at 06:52:35PM -0700, Matthias Kaehlcke wrote:
> > The purpose of the throttler is to provide support for non-thermal
> > throttling. Throttling is triggered by external event, e.g. the
> > detection of a high battery discharge current, close to the OCP limit
> > of the battery. The throttler is only in charge of the throttling, not
> > the monitoring, which is done by another (possibly platform specific)
> > driver.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > Changes in v4:
> > - removed OOM logs
> > - "does have no" => "has no" in log message
> > - changed 'level' to unsigned int
> > - hold mutex in throttler_set_level() when checking if level has changed
> > - removed debugfs dir in throttler_teardown()
> > - consolidated update of all devfreq devices in thr_update_devfreq()
> > - added field 'shutting_down' to struct throttler
> > - refactored teardown to avoid deadlocks
> > - minor change in introductory comment
> > 
> > Changes in v3:
> > - Kconfig: don't select CPU_FREQ and PM_DEVFREQ
> > - added CONFIG_THROTTLER_DEBUG option
> > - changed 'level' sysfs attribute to debugfs
> > - introduced thr_<level> macros for logging
> > - added debug logs
> > - added field clamp_freq to struct cpufreq_thrdev and devfreq_thrdev
> >   to keep track of the current frequency limits and avoid spammy logs
> > 
> > Changes in v2:
> > - completely reworked the driver to support configuration through OPPs, which
> >   requires a more dynamic handling
> > - added sysfs attribute to set the level for debugging and testing
> > - Makefile: depend on Kconfig option to traverse throttler directory
> > - Kconfig: removed 'default n'
> > - added SPDX line instead of license boiler-plate
> > - added entry to MAINTAINERS file
> > ---
> >  MAINTAINERS                     |   7 +
> >  drivers/misc/Kconfig            |   1 +
> >  drivers/misc/Makefile           |   1 +
> >  drivers/misc/throttler/Kconfig  |  23 ++
> >  drivers/misc/throttler/Makefile |   1 +
> >  drivers/misc/throttler/core.c   | 705 ++++++++++++++++++++++++++++++++
> >  include/linux/throttler.h       |  21 +
> >  7 files changed, 759 insertions(+)
> >  create mode 100644 drivers/misc/throttler/Kconfig
> >  create mode 100644 drivers/misc/throttler/Makefile
> >  create mode 100644 drivers/misc/throttler/core.c
> >  create mode 100644 include/linux/throttler.h
> > 
> 
> ...
> 
> > diff --git a/drivers/misc/throttler/core.c b/drivers/misc/throttler/core.c
> > new file mode 100644
> > index 000000000000..305964cfb0b7
> > --- /dev/null
> > +++ b/drivers/misc/throttler/core.c
> > @@ -0,0 +1,705 @@
> > +// SPDX-License-Identifier: GPL-2.0
> 
> ...
> 
> > +
> > +static int thr_handle_devfreq_event(struct notifier_block *nb,
> > +				    unsigned long event, void *data);
> > +
> > +static unsigned long thr_get_throttling_freq(struct thr_freq_table *ft,
> > +					     unsigned int level)
> > +{
> > +	if (level == 0) {
> > +		WARN(true, "level == 0");
> 
> It's possible to get here, if the level gets changed while you're
> handling a devfreq event. I'd think you can drop the WARN() entirely and
> just make sure to handle this case properly.

Right, I didn't take into account here that level could change. Will
adapt.

> > +		return ULONG_MAX;
> > +	}
> > +
> > +	if (level <= ft->n_entries)
> > +		return ft->freqs[level - 1];
> > +	else
> > +		return ft->freqs[ft->n_entries - 1];
> > +}
> > +
> 
> ...
> 
> > +static int thr_handle_cpufreq_event(struct notifier_block *nb,
> > +				unsigned long event, void *data)
> > +{
> > +	struct throttler *thr =
> > +		container_of(nb, struct throttler, cpufreq.nb);
> > +	struct cpufreq_policy *policy = data;
> > +	struct cpufreq_thrdev *cftd;
> > +
> > +	if ((event != CPUFREQ_ADJUST) || thr->shutting_down)
> > +		return 0;
> > +
> > +	mutex_lock(&thr->lock);
> > +
> > +	if (cpumask_test_cpu(policy->cpu, &thr->cpufreq.cm_ignore))
> > +		goto out;
> > +
> > +	if (!cpumask_test_cpu(policy->cpu, &thr->cpufreq.cm_initialized)) {
> > +		thr_cpufreq_init(thr, policy->cpu);
> > +
> > +		if (cpumask_test_cpu(policy->cpu, &thr->cpufreq.cm_ignore))
> > +			goto out;
> > +
> > +		thr_dbg(thr, "CPU%d is used for throttling\n", policy->cpu);
> > +	}
> > +
> > +	/*
> > +	 * Can't do this check earlier, otherwise we might miss CPU policies
> > +	 * that are added after setup().
> > +	 */
> > +	if (thr->level == 0) {
> > +		list_for_each_entry(cftd, &thr->cpufreq.list, node) {
> > +			if (cftd->cpu != policy->cpu)
> > +				continue;
> > +
> > +			if (cftd->clamp_freq != 0) {
> > +				thr_dbg(thr, "unthrottling CPU%d\n", cftd->cpu);
> > +				cftd->clamp_freq = 0;
> > +			}
> 
> Take it or leave it, but this entire 'level == 0' loop looks like it
> could be easily merged into the next (very similar) loop, and avoid the
> 'goto'.

Merging the two loops sounds good.

> > +		}
> > +
> > +		goto out;
> > +	}
> > +
> > +	list_for_each_entry(cftd, &thr->cpufreq.list, node) {
> > +		unsigned long clamp_freq;
> > +
> > +		if (cftd->cpu != policy->cpu)
> > +			continue;
> > +
> > +		clamp_freq = thr_get_throttling_freq(&cftd->freq_table,
> > +						     thr->level) / 1000;
> > +		if (cftd->clamp_freq != clamp_freq) {
> > +			thr_dbg(thr, "throttling CPU%d to %lu MHz\n", cftd->cpu,
> > +				clamp_freq / 1000);
> > +			cftd->clamp_freq = clamp_freq;
> > +		}
> > +
> > +		if (clamp_freq < policy->max)
> > +			cpufreq_verify_within_limits(policy, 0, clamp_freq);
> > +	}
> > +
> > +out:
> > +	mutex_unlock(&thr->lock);
> > +
> > +	return NOTIFY_DONE;
> > +}
> > +
> > +/*
> > + * Notifier called by devfreq. Can't acquire thr->lock since it might
> > + * already be held by throttler_set_level(). It isn't necessary to
> > + * acquire the lock for the following reasons:
> > + *
> > + * Only the devfreq_thrdev and thr->level are accessed in this function.
> > + * The devfreq device won't go away (or change) during the execution of
> > + * this function, since we are called from the devfreq core. Theoretically
> > + * thr->level could change and we'd apply an outdated setting, however in
> > + * this case the function would run again shortly after and apply the
> > + * correct value.
> > + */
> > +static int thr_handle_devfreq_event(struct notifier_block *nb,
> > +				    unsigned long event, void *data)
> > +{
> > +	struct devfreq_thrdev *dftd =
> > +		container_of(nb, struct devfreq_thrdev, nb);
> > +	struct throttler *thr = dftd->thr;
> > +	struct devfreq_policy *policy = data;
> > +	unsigned long clamp_freq;
> > +
> > +	if ((event != DEVFREQ_ADJUST) || thr->shutting_down)
> > +		return NOTIFY_DONE;
> > +
> > +	if (thr->level == 0) {
> > +		if (dftd->clamp_freq != 0) {
> > +			thr_dbg(thr, "unthrottling '%s'\n",
> > +				dev_name(&dftd->devfreq->dev));
> > +			dftd->clamp_freq = 0;
> > +		}
> > +
> > +		return NOTIFY_DONE;
> > +	}
> > +
> 
> Given that the level can change in between the last reading (thr->level
> == 0) and here...it seems like it would be better to really only read
> the level once, and ensure that the same logic can handle both zero and
> non-zero levels. e.g, you could try READ_ONCE(thr->level) and stash the
> value in a local?

Ack

> And you could probably eliminate the entire 'if'
> above, and just have a special case for 'clamp_freq == UINT_MAX'
> following here.

It might end up being a line shorter or so, but I'm not convinced it
would improve readability. I'd prefer to keep it as is.

Thanks

Matthias
