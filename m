Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C20CC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1348E20869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:19:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1348E20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388441AbeKGDqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 22:46:06 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44945 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730749AbeKGDqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 22:46:06 -0500
Received: by mail-ot1-f66.google.com with SMTP id z33so12212640otz.11;
        Tue, 06 Nov 2018 10:19:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KZ74CHLhK1hxcn/viInaBLWqh2t5W4BGMiFBbDQtMmI=;
        b=QBXXJgYTtq5WHkX99XU654MEH0t5UKezcHjIcr5euVE65yhzwumvY/kzdLFPHDsOXq
         gV26cWKhojR4ZbdlWVgRvfo2SQxlLOTcLoUOld/+MXgAZsbzYtRtNwnClj+IHvi3eMta
         vLGsa8tih0vil7295awnawSpPeEgTB4UYB2oZKTVqKksR+MniD7yj3dfH/2GMngLmBKl
         b6+uiCDakmiAv15pfNbdOS5+g0FVXvL/ZLLloy8gK7oiFzO1YIPfcvw8gYXGS4ideQD1
         ZSHHHsOFaK6MROoWYomUalrMmxvcBhrwIqxjqUiLdusdxWO/pVr8bw+GCmhknkSuN5AI
         wN1Q==
X-Gm-Message-State: AGRZ1gKoRZXsnBrAiMbJwMZOpL972dbhc5OiAK645Cr3T11Azo94DXLE
        vj6TT1xL4cC6t+Mu67H6mf4EBQm7FWgBn4sdt4k=
X-Google-Smtp-Source: AJdET5dvmWAN5zQbsS7cuqI5svyLRFJ7JL7sskdWzPSc+r9oeMOLHA5VU9hoQ/5m79nnhA/tbaFgphWigO70IO4/a0A=
X-Received: by 2002:a9d:64ce:: with SMTP id n14mr17554673otl.343.1541528375872;
 Tue, 06 Nov 2018 10:19:35 -0800 (PST)
MIME-Version: 1.0
References: <1556808.yKVbhZSazi@aspire.rjw.lan> <20181106170442.GC9781@hirez.programming.kicks-ass.net>
In-Reply-To: <20181106170442.GC9781@hirez.programming.kicks-ass.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 6 Nov 2018 19:19:24 +0100
Message-ID: <CAJZ5v0hmm2UWRt1j6hQo14nZLgPrE3DZkOznfo2kMxsZ1spo-Q@mail.gmail.com>
Subject: Re: [RFC/RFT][PATCH v3] cpuidle: New timer events oriented governor
 for tickless systems
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 6:04 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sun, Nov 04, 2018 at 05:31:20PM +0100, Rafael J. Wysocki wrote:
> > + * - If there is a pattern of 5 or more recent non-timer wakeups earlier than
> > + *   the closest timer event, expect one more of them to occur and use the
> > + *   average of the idle duration values corresponding to them to select an
> > + *   idle state for the CPU.
>
>
> > +/**
> > + * teo_idle_duration - Estimate the duration of the upcoming CPU idle time.
> > + * @drv: cpuidle driver containing state data.
> > + * @cpu_data: Governor data for the target CPU.
> > + * @sleep_length_us: Time till the closest timer event in microseconds.
> > + */
> > +unsigned int teo_idle_duration(struct cpuidle_driver *drv,
> > +                            struct teo_cpu *cpu_data,
> > +                            unsigned int sleep_length_us)
> > +{
> > +     u64 range, max_spread, max, sum;
> > +     unsigned int count;
> > +
> > +     /*
> > +      * If the sleep length is below the target residency of idle state 1,
> > +      * the only viable choice is to select the first available (enabled)
> > +      * idle state, so return immediately in that case.
> > +      */
> > +     if (sleep_length_us < drv->states[1].target_residency)
> > +             return sleep_length_us;
> > +
> > +     /*
> > +      * The purpose of this function is to check if there is a pattern of
> > +      * wakeups indicating that it would be better to select a state
> > +      * shallower than the deepest one matching the sleep length or the
> > +      * deepest one at all if the sleep lenght is long.  Larger idle duration
> > +      * values are beyond the interesting range.
> > +      *
> > +      * Narrowing the range of interesting values down upfront also helps to
> > +      * avoid overflows during the computation below.
> > +      */
> > +     range = drv->states[drv->state_count-1].target_residency;
> > +     range = min_t(u64, sleep_length_us, range + (range >> 2));
> > +
> > +     /*
> > +      * This is the value to compare with the distance between the average
> > +      * and the greatest sample to decide whether or not it is small enough.
> > +      * Take 10 us as the total cap of it.
> > +      */
> > +     max_spread = max_t(u64, range >> MAX_SPREAD_SHIFT, 10);
> > +
> > +     max = range;
> > +
> > +     do {
> > +             u64 cap = max;
> > +             int i;
> > +
> > +             /*
> > +              * Compute the sum of the saved intervals below the cap and the
> > +              * sum of of their squares.  Count them and find the maximum
> > +              * interval below the cap.
> > +              */
> > +             count = 0;
> > +             sum = 0;
> > +             max = 0;
> > +
> > +             for (i = 0; i < INTERVALS; i++) {
> > +                     u64 val = cpu_data->intervals[i];
> > +
> > +                     if (val >= cap)
> > +                             continue;
> > +
> > +                     count++;
> > +                     sum += val;
> > +                     if (max < val)
> > +                             max = val;
> > +             }
> > +
> > +             /*
> > +              * Give up if the total number of interesting samples is too
> > +              * small.
> > +              */
> > +             if (cap == range && count <= INTERVALS / 2)
> > +                     return sleep_length_us;
> > +
> > +             /*
> > +              * If the distance between the max and the average is too large,
> > +              * discard the max an repeat.
> > +              */
> > +     } while (count > 3 && max > max_spread && (max - max_spread) * count > sum);
> > +
> > +     return div64_u64(sum, count);
> > +}
>
> Instead of this detector; why haven't you used the code from
> kernel/irq/timings.c ?

Because it doesn't help much AFAICS.

Wakeups need not be interrupts in particular and interrupt patterns
that show up when the CPU is busy may not be relevant for when it is
idle.
