Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88577C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC0020815
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545147088;
	bh=irxAc1gAJmBVCxb0IKwdtMrJnsl9Q0sx9NULbOiEMmw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uUy9d5Fx2PVpTFuG4chg1W6nhHagQyahFkba2+XaRzt2IdirP1lTlI8N5ZW+6HmfI
	 rROTeA4XEkVNeV0TpWnBxAaXNQmocNsOa4vgC7U+4aSUEn1LMDUp/zoIhcbjQtccWc
	 D8wI/C6URqXpZZ9t22uwBTVaF1sNRWkvX8RbVx28=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbeLRPb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:31:27 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44216 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbeLRPb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:31:27 -0500
Received: by mail-oi1-f194.google.com with SMTP id m6so2222268oig.11;
        Tue, 18 Dec 2018 07:31:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lU78jIBITPfHYTuACKvxKrErcFosEUB3qtzdn53z70M=;
        b=XBZcvV0lNwH+v7uKJMQdPq9JIrNbmwQp0OFuFh/8emGy3ojm0LiP1pTwQRzi8XhbXE
         HxWPMZyidK5QXaZR3NiC6i/+XOiCDjoB7rs+d+8kqDXjQICexX/jQEDz2/25iQPRjIZk
         2KPXK5nyy+/zXMLKLQLgkfQtMrr05ZrYDviZHBDVqjABxHB5Vccr4riAabdcMD7wbNCt
         zYne+kC9YcqGe2PozAGlC+/J9aPZt8hc9i4rde5GljOuA7qII8FTabkd9DCsy17UFVF1
         2iwRda9iDS9hukJOAtVIJ8G7QhxV6JYHhbs2mugVHovSYkJq4Gk05y9pA9uC/d1WhoZy
         HRCw==
X-Gm-Message-State: AA+aEWYTm3I8VIPJTGSFSKq6WfU4WPVF1vIzgIXw17IcSmFYe+whtSz5
        3DfuM4BsIfucqgmfJKDrTTHz/p1HgMyjAI+1nu8=
X-Google-Smtp-Source: AFSGD/UT2V5Zx32LbseEEQMwkoYMVdGsurZfetRFd1zE/Fa4seXuDHuMDklAbU/Ybvw0gCsAh1HUAD2MBEmhTheABJ0=
X-Received: by 2002:aca:3d42:: with SMTP id k63mr8384608oia.95.1545147084769;
 Tue, 18 Dec 2018 07:31:24 -0800 (PST)
MIME-Version: 1.0
References: <128769314.7imKxugEn6@aspire.rjw.lan> <20181218114949.c6npu357fj65l5iv@queper01-ThinkPad-T460s>
In-Reply-To: <20181218114949.c6npu357fj65l5iv@queper01-ThinkPad-T460s>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 18 Dec 2018 16:31:13 +0100
Message-ID: <CAJZ5v0grJJi7572vdT7eudMTSW6h+9KT8WSNXa-z8rWqp-Fikw@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: New timer events oriented governor for tickless systems
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, hu1.chen@intel.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 18, 2018 at 12:50 PM Quentin Perret <quentin.perret@arm.com> wrote:
>
> Hi Rafael,
>
> I skimmed through the previous versions, but apologies if some of these
> things have been discussed already :-)
>
> On Tuesday 18 Dec 2018 at 12:09:05 (+0100), Rafael J. Wysocki wrote:
> <...>
> > + * - Find an idle state on the basis of the sleep length and state statistics
> > + *   collected over time:
> > + *
> > + *   o Find the deepest idle state whose target residency is less than or euqal
>
> s/euqal/equal
>
>
> <...>
> > +/**
> > + * struct teo_idle_state - Idle state data used by the TEO cpuidle governor.
> > + * @early_hits: "Early" CPU wakeups "matching" this state.
> > + * @hits: "On time" CPU wakeups "matching" this state.
> > + * @misses: CPU wakeups "missing" this state.
> > + *
> > + * A CPU wakeup is "matched" by a given idle state if the idle duration measured
> > + * after the wakeup is between the target residency of that state and the target
> > + * residnecy of the next one (or if this is the deepest available idle state, it
>
> s/residnecy/residency
>
> > + * "matches" a CPU wakeup when the measured idle duration is at least equal to
> > + * its target residency).
> > + *
> > + * Also, from the TEO governor prespective, a CPU wakeup from idle is "early" if
>
> s/prespective/perspective

Thanks for the typo fixes (ongoing spellchecker issues here).

> > + * it occurs significantly earlier than the closest expected timer event (that
> > + * is, early enough to match an idle state shallower than the one matching the
> > + * time till the closest timer event).  Otherwise, the wakeup is "on time", or
> > + * it is a "hit".
> > + *
> > + * A "miss" occurs when the given state doesn't match the wakeup, but it matches
> > + * the time till the closest timer event used for idle state selection.
> > + */
>
>
> <...>
> > +static void teo_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
> > +{
> > +     struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
> > +     unsigned int sleep_length_us = ktime_to_us(cpu_data->sleep_length_ns);
> > +     int i, idx_hit = -1, idx_timer = -1;
> > +     unsigned int measured_us;
> > +
> > +     if (cpu_data->time_span_ns >= cpu_data->sleep_length_ns) {
> > +             /*
> > +              * One of the safety nets has triggered or this was a timer
> > +              * wakeup (or equivalent).
> > +              */
> > +             measured_us = sleep_length_us;
> > +     } else {
> > +             unsigned int lat = drv->states[cpu_data->last_state].exit_latency;
> > +
> > +             measured_us = ktime_to_us(cpu_data->time_span_ns);
> > +             /*
> > +              * The delay between the wakeup and the first instruction
> > +              * executed by the CPU is not likely to be worst-case every
> > +              * time, so take 1/2 of the exit latency as a very rough
> > +              * approximation of the average of it.
> > +              */
> > +             if (measured_us >= lat)
> > +                     measured_us -= lat / 2;
> > +             else
> > +                     measured_us /= 2;
>
> I'm not sure to understand this; why not removing lat/2 in all cases and
> cap at 0 ?

Well, 0 is special on platforms where state 0 is a "polling" one, so
it's better to avoid it.  So this is the reason, but that's a matter
of handling the corner case this way or another.

> > +     }
>
>
> <...>
> > +     /*
> > +      * Save idle duration values corresponding to non-timer wakeups for
> > +      * pattern detection.
> > +      *
> > +      * If the total time span between idle state selection and the "reflect"
> > +      * callback is greater than or equal to the sleep length determined at
> > +      * the idle state selection time, the wakeup is likely to be due to a
> > +      * timer event.
>
> Should this paragraph go above the first 'if' of this function ?

Of course I can move it.

> It checks the same thing and it took me some time to understand what you
> were doing while the explanation I needed was down here all along :-)

Fair enough.

> > +      */
> > +     if (cpu_data->time_span_ns >= cpu_data->sleep_length_ns)
> > +             measured_us = UINT_MAX;
> > +
> > +     cpu_data->intervals[cpu_data->interval_idx++] = measured_us;
> > +     if (cpu_data->interval_idx > INTERVALS)
> > +             cpu_data->interval_idx = 0;
> > +}
>
>
> <...>
> > +             /*
> > +              * Count and sum the most recent idle duration values less than
> > +              * the target residency of the state selected so far, find the
> > +              * max.
> > +              */
> > +             for (i = 0; i < INTERVALS; i++) {
> > +                     unsigned int val = cpu_data->intervals[i];
> > +
> > +                     if (val >= drv->states[idx].target_residency)
> > +                             continue;
> > +
> > +                     count++;
> > +                     sum += val;
> > +             }
> > +
> > +             /*
> > +              * Give up unless the majority of the most recent idle duration
> > +              * values are in the interesting range.
> > +              */
> > +             if (count > INTERVALS / 2) {
>
> I understand this probably works well enough in practice, but how 'robust'
> is supposed to be this filtering here ? If you have, say, 2 tasks with
> prime periods, then the hyper-period (which is when the pattern repeats)
> can get high really quickly, and you'll never see the full extent of
> that pattern with this mechanism.

That's correct, but this is just about whether or not there is a
reason to select an idle state shallower than the one selected
already.  How the pattern looks like exactly doesn't matter too much
here AFAICS.

> Yes, it's hard to do much better without introducing tons of complexity
> in here, but how did you define INTERVALS=8 and so ?

I blatantly stole this number from the menu governor. :-)

> Is this something you'd like to make configurable at some point ?

Maybe?

> I guess this could always be done later if need be.

Precisely.

> > +                     unsigned int avg_us = div64_u64(sum, count);
> > +
> > +                     /*
> > +                      * Avoid spending too much time in an idle state that
> > +                      * would be too shallow.
> > +                      */
> > +                     if (!(tick_nohz_tick_stopped() && avg_us < TICK_USEC)) {
>
> IIUC, this is saying we shouldn't trust the predicted sleep time if it
> is shorter than the tick and the tick is stopped. What is the use case
> you have in mind for this ?
>
> In other words, in which scenario do you expect to see a lot of high
> frequency non-timer-related wake-ups and have the tick disabled ?

It is mostly theoretical, but the rationale here is that the cost of
using a shallow idle state with the tick stopped is potentially very
high (the CPU may stay in that idle state for a very long time then),
so it is better to assume misprediction in that case to avoid that
cost.

> > +                             idx = teo_find_shallower_state(drv, dev, idx, avg_us);
> > +                             duration_us = avg_us;
> > +                     }
> > +             }
> > +     }

Cheers,
Rafael
