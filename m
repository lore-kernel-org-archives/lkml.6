Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DC9C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E3C2082D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11E3C2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbeJZQeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:34:31 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33598 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbeJZQeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:34:31 -0400
Received: by mail-oi1-f193.google.com with SMTP id c25-v6so245130oiy.0;
        Fri, 26 Oct 2018 00:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LEMctGivfUaWRV3meFewoip+NHGMBgzyB8RLzprBxzo=;
        b=az3iHMn/V8hOxn0gjsgP5R21HL76kQXAptQAhgVkDTEb0SYT5HwA+ndqwO6M3P1viM
         TF4PIbzhH+OD6w29zJimmOBa2zRVhFAN15/R4mTAXHLQW8YgrIa2S0o78jPlfwGFV3pb
         s4Hlu3Dnx99E9W/bPrbbe+y06HAszUXs75wIWVm+Qlmte7/zFAAlwbxeqdkP0/58AJXG
         gv8/m0bh9PdB+JWg1RvHbmtMT7xoZHWQH7gtRcRig/Ca1kcC/ICr1LZx2IU2AFJXZaBw
         Fu++fO9WDn9MI2Jhki6lguGF4Z5lL2UQp0XkfC8+btUWGXeZduWXTGmcOyPsjUCLmZ/G
         Y10w==
X-Gm-Message-State: AGRZ1gLvXWaGuc2VXwbLQfmLGNm/69jFN/8g+uMG02kZKC9l7CmuSDtP
        /ht4lRwsVvWDfZxRdoEYC+re63jR8RviCrNhXp8=
X-Google-Smtp-Source: AJdET5fe88Mh709Zs6SdczzVwITRsADjAS7m/lMXJpGbkbM3sC6Pp+2bsvtWwmTp+n3+7MUaYD3GPcNEHED8LtZr4dg=
X-Received: by 2002:aca:b655:: with SMTP id g82-v6mr1390705oif.195.1540540708456;
 Fri, 26 Oct 2018 00:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <6595711.BNhtJ5yyLe@aspire.rjw.lan> <1540198496.3333.4.camel@suse.cz>
In-Reply-To: <1540198496.3333.4.camel@suse.cz>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 26 Oct 2018 09:58:17 +0200
Message-ID: <CAJZ5v0g3p1TJkkyn4eqN1iq+eJRF0=gDGALmj9tuDvdSYg7Byg@mail.gmail.com>
Subject: Re: [RFC/RFT/[PATCH] cpuidle: New timer events oriented governor for
 tickless systems
To:     ggherdovich@suse.cz
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        srinivas.pandruvada@linux.intel.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, frederic@kernel.org, mgorman@suse.de,
        dsmythies@telus.net, daniel.lezcano@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Giovanni,

On Mon, Oct 22, 2018 at 10:51 AM Giovanni Gherdovich
<ggherdovich@suse.cz> wrote:
>
> Hello Rafael,
>
> I ran some benchmarks and will send you a detailed report later;

Thanks a lot, much appreciated!

Even though I'm about to send a v2 of the $subject patch which is a
complete rewrite of some parts of the code, results from the previous
one will be good to see anyway.

> for now I have some questions to make sure I understand the code.
>
> First off, I like your algorithm and you make an excellent job at
> documenting it with comments. Since it's a heuristic, it's not "obvious"
> code and comments help a lot.
>
> On Thu, 2018-10-11 at 23:01 +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >

[cut]

> > +static void teo_update(struct cpuidle_driver *drv,
> > +                        struct cpuidle_device *dev)
> > +{
> > +     struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
> > +     unsigned int measured_us = dev->last_residency;
>
> question: how reliable is the value "dev->last_residency"? does it come
> "from the hardware" somehow? I'm asking because I'm more familiar with
> CPUfreq than CPUidle, and there you have a bit of a disconnect between what
> the OS think and what the hardware actually does. So I wonder if there is a
> similar situation with the last_residency value, and ask if it comes from
> some sort of feedback from the processor itself (if that makes any
> sense). I see it's written to in the cpuidle_enter_state() function in
> cpuidle.c, but I couldn't clearly understand that function either.

It is measured by the kernel, so it is not very precise, but it should
be precise enough for idle duration estimation on average.

> > +     int i = cpu_data->last_state;
> > +
> > +     if (measured_us >= 2 * drv->states[i].exit_latency)
> > +             measured_us -= drv->states[i].exit_latency;
> > +     else
> > +             measured_us /= 2;
> > +
> > +     /* Find the state matching the measured idle duration. */
> > +     for (i = drv->state_count - 1; i > 0; i--) {
> > +             if (drv->states[i].target_residency <= measured_us)
> > +                     break;
> > +     }
>
> Wait, I'm lost here. You just initialized "int i = cpu_data->last_state;"
> ten lines above, and here you're computing "given how much we idled, what
> would have been the best state to enter?". Was the initialization of i a
> mistake? what's the intention?

It's intentional, but just because of the measured_us computation
earlier that would need to refer to
drv->states[cpu_data->last_state].exit_latency twice.  "i" serves as
auxiliary index storage for that.

> > +
> > +     cpu_data->recent_wakeups++;
> > +
> > +     /*
> > +      * If the state matches the time till the closest timer event used
> > +      * during the most recent state selection too, it would be sufficient
> > +      * to use that time alone for the idle state selection, so increment
> > +      * the "hits" number for the matching state and clear the "early series"
> > +      * data.
> > +      *
> > +      * Note that sleep_length_us cannot be less than measured_us (or it
> > +      * would mean a late timer event), so it is sufficient to check the
> > +      * lower boundary here.
> > +      */
> > +     if (i == drv->state_count - 1 ||
> > +         drv->states[i+1].target_residency > cpu_data->sleep_length_us)
> > {
>
> Correct me if I'm wrong: we know that states[i+1].target_residency > measured_us,
> because that's just how we've chosen i. We know that sleep_length_us >= measured_us,
> because that's how timers work.
>
> Now, the naive way if we're in a "hit" situation would be to check is
> measured_us is equal (or, well, "close") to sleep_length_us. If, on the
> other side, measured_us is a lot smaller than sleep_length_us, it's an
> "early". But you don't check it that way, what you do is to see if
> target_residency[i+1] is in between measured_us and sleep_length_us or
> not. Like this (sorry for the sloppy notation:
>
> target_residency[i] < measured_us <= sleep_length_us < target_residency[i+1]
>
> and that would be a hit. Otherwise:
>
> target_residency[i] < measured_us < target_residency[i+1] <= sleep_length_us
>
> and that's an "early". Right?

The idea here is for "early" to mean "so much earlier than it makes a
real difference", where "a real difference" is when different idle
states need to be used in both cases.

For example, say you have two idle states, X with the target residency
of 20 and Y with the target residency of 150.  Say that your
sleep_length is 300 and your measured_us (idle duration) is 100.
Then, you should have used idle state X and knowing sleep_length
upfront wouldn't have helped, so it is a "miss".  Now, if your
sleep_length is (again) 300 and your measured_us is 200 (say), you
could still use idle state Y (as indicated by the sleep_length value),
so relying on sleep_length alone would give you a correct outcome, so
it is a "hit".

Generally, a "hit" is when you could rely on sleep_length alone for
the current outcome.

I'm afraid I cannot explain this much better, sorry. :-)

> Again, no guarantee that i is actually the state we idle-ed in, it's just
> one we make up for this bookkeeping.

[cut]

> > +     early_count = 0;
> > +     max_count = 0;
> > +     max_count_idx = -1;
> > +     prev_count = 0;
> > +     prev_idx = -1;
> > +     idx = -1;
> > +
> > +     for (i = 0; i < drv->state_count; i++) {
> > +             struct cpuidle_state *s = &drv->states[i];
> > +             struct cpuidle_state_usage *su = &dev->states_usage[i];
> > +             u64 count = cpu_data->states[i].early_wakeups +
> > +                             cpu_data->states[i].early_wakeups_old;
> > +
> > +             if (s->disabled || su->disable) {
> > +                     /*
> > +                      * This state is disabled, so add its count of matched
> > +                      * "early" wakeups to the last enabled state's count.
> > +                      */
> > +                     if (prev_idx >= 0) {
> > +                             prev_count += count;
> > +                             if (prev_count > max_count) {
> > +                                     max_count = prev_count;
> > +                                     max_count_idx = prev_idx;
> > +                             }
> > +                     }
> > +                     continue;
>
> I'm not sure I get this part: I have the impression you introduced the
> prev_idx variable exactly for its use in this check (skip disabled states),
> but it looks to me you had to use idx instead. At every iteration, idx is
> the last enabled state. Why prev_idx?

Well, this is a bit messy, sorry about that.

The idea is that if one of the states was disabled, it can't be
selected as the one with the maximum count of "early" hits, so its
count of "early" hits is kind of "stolen" by the first enabled
shallower state to make it look more "important".

I've dropped this in the new version of the patch as it covers a
corner case that may not be worth the effort.

> > +             }
> > +
> > +             if (idx < 0)
> > +                     idx = i; /* first enabled state */
> > +
> > +             if (s->target_residency > duration_us) {
> > +                     /*
> > +                      * If the next wakeup is expected to be "early", the
> > +                      * time frame of it is known already.
> > +                      */
> > +                     if (duration_us < cpu_data->sleep_length_us) {
> > +                             /*
> > +                              * Use a physical idle state, not busy polling,
> > +                              * unless a timer will trigger really soon.
> > +                              */
> > +                             if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
> > +                                 s->exit_latency <= latency_req &&
> > +                                 s->target_residency <= cpu_data->sleep_length_us) {
>
> Just to be clear: 0 is a polling idle state; can there be any other? You
> seem to keep it generic here, but seems to me you're actually checking if
> idx so far is zero and try to see if there is another option.

The polling state has to be state 0.

> Also: you put this check "may I convince you not to poll?" inside the
> branch that handle the 3-or-more case (where duration_us has been changed
> to avg_us). My question is: don't you need the check also outside of the
> branch? (where, if I understand correctly, duration_us is equal to
> sleep_length_us).

No, because if s->target_residency == cpu_data->sleep_length_us, we'll
still use polling and duration_us cannot be greater than the sleep
length.

> > +                                     duration_us = s->target_residency;
> > +                                     idx = i;
> > +                             }
> > +                             break;
> > +                     }
> > +
> > +                     /*
> > +                      * If the number of "hits" for the state matching the
> > +                      * sleep length is greater than the total number of
> > +                      * "early" wakeups for all of the shallower states, the
> > +                      * state selected so far is the one to use.
> > +                      */
> > +                     if (early_count <= cpu_data->states[idx].hits +
> > +                                        cpu_data->states[idx].hits_old)
> > +                             break;
> > +
> > +                     /*
> > +                      * It is more likely that one of the shallower states
> > +                      * will match the idle duration measured after wakeup,
> > +                      * so take the one with the maximum count of matched
> > +                      * "early" wakeups.
> > +                      */
> > +                     idx = max_count_idx;
> > +                     duration_us = drv->states[idx].target_residency;
> > +                     break;
> > +             }
> > +             if (s->exit_latency > latency_req) {
> > +                     /*
> > +                      * If we break out of the loop for latency reasons, use
> > +                      * the target residency of the selected state as the
> > +                      * expected idle duration to avoid stopping the tick
> > +                      * as long as that target residency is low enough.
> > +                      */
> > +                     duration_us = drv->states[idx].target_residency;
> > +                     break;
> > +             }
> > +
> > +             early_count += prev_count;
>
> I have the slight feeling that here you wanted "early_count += count;"
> instead. As I understand early_count is meant to be "one iteration behind"
> in the loop (meaning it accumulates up to i-1). If you update it with
> prev_count instead of count, that would make it two iterations
> behind. Wrong?

So that's because of the "stealing" idea described above, but I might
have made a mistake here now looking at it again.

[cut]

>
> Just a curiosity: why isn't the disable() function from the
> cpuidle_governor interface implemented? I see it isn't in "menu" as well,
> so I wonder what disable() is supposed to do.

Clean up if any allocations have been made in ->enable(), for example.

Thanks,
Rafael
