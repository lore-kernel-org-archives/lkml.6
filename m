Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F0EC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D0D2146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2D0D2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbeK3UAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 15:00:08 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34406 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeK3UAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 15:00:08 -0500
Received: by mail-ot1-f68.google.com with SMTP id t5so4472693otk.1;
        Fri, 30 Nov 2018 00:51:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AOGEzKjod3n9ZFb5ZO1X+72H+eEAhGVDXB5CRxjcJLg=;
        b=a7rOagjZK0l14TLt1M1q0zmdF80g2ZcwPV2QTheCCKzCqcX9veE15tYsShmWD1jd5x
         LA6XJKI/UlAe6WQPzbHza/aZY7kDA7lgk+8RLCEz55t54OwXV0IpBJwK2WKhm6t9U/rv
         IIltervfUJBTVQROnss4LqJvNsskMCmBP7qhaQNLJGbvT8ePV7hF+j0dQUlVv52bc3JH
         7bCw8j3ZcL9N5GXnljP798bKxE+OOVPvcic8e3XcP4gFfLc46SGkk/zrJB8Mz6EVwsZg
         rkpcdrNdGjwlWSM1ywLhg7K906sejdx4CDKp37dDnwKjaGBdXKjSZGVp8jK1t+ME/WP/
         7uag==
X-Gm-Message-State: AA+aEWalytphHm5991q5YxmAPIz0KSx4Q+Bp5bebVyUY/JBRObjmOg8w
        gJqqiOAX69xYpfYPEv3Jx8x0mO/fuRQlov+5TR8rWQ==
X-Google-Smtp-Source: AFSGD/WQWnlpYgPOhv5ogWl/d4GIRR3mmQZNJ0nuIW3HXDA+KlHyoMhbQox7+8A4C30eoGGTxlLauSILEwhiCTPsHmA=
X-Received: by 2002:a9d:60b:: with SMTP id 11mr2915257otn.200.1543567892580;
 Fri, 30 Nov 2018 00:51:32 -0800 (PST)
MIME-Version: 1.0
References: <001901d48881$29ea59d0$7dbf0d70$@net>
In-Reply-To: <001901d48881$29ea59d0$7dbf0d70$@net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Nov 2018 09:51:19 +0100
Message-ID: <CAJZ5v0j6AEjztoFfpQAc3NgQ5JtsWgRqscoE_u1eespVM-Cnmw@mail.gmail.com>
Subject: Re: [RFC/RFT][PATCH v6] cpuidle: New timer events oriented governor
 for tickless systems
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On Fri, Nov 30, 2018 at 8:49 AM Doug Smythies <dsmythies@telus.net> wrote:
>
> Hi Rafael,
>
> On 2018.11.23 02:36 Rafael J. Wysocki wrote:
>
> ... [snip]...
>
> > +/**
> > + * teo_find_shallower_state - Find shallower idle state matching given duration.
> > + * @drv: cpuidle driver containing state data.
> > + * @dev: Target CPU.
> > + * @state_idx: Index of the capping idle state.
> > + * @duration_us: Idle duration value to match.
> > + */
> > +static int teo_find_shallower_state(struct cpuidle_driver *drv,
> > +                                 struct cpuidle_device *dev, int state_idx,
> > +                                 unsigned int duration_us)
> > +{
> > +     int i;
> > +
> > +     for (i = state_idx - 1; i > 0; i--) {
> > +             if (drv->states[i].disabled || dev->states_usage[i].disable)
> > +                     continue;
> > +
> > +             if (drv->states[i].target_residency <= duration_us)
> > +                     break;
> > +     }
> > +     return i;
> > +}
>
> I think this subroutine has a problem when idle state 0
> is disabled.

You are right, thanks!

> Perhaps something like this might help:
>
> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
> index bc1c9a2..5b97639 100644
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -196,7 +196,8 @@ static void teo_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
>  }
>
>  /**
> - * teo_find_shallower_state - Find shallower idle state matching given duration.
> + * teo_find_shallower_state - Find shallower idle state matching given
> + * duration, if possible.
>   * @drv: cpuidle driver containing state data.
>   * @dev: Target CPU.
>   * @state_idx: Index of the capping idle state.
> @@ -208,13 +209,15 @@ static int teo_find_shallower_state(struct cpuidle_driver *drv,
>  {
>         int i;
>
> -       for (i = state_idx - 1; i > 0; i--) {
> +       for (i = state_idx - 1; i >= 0; i--) {
>                 if (drv->states[i].disabled || dev->states_usage[i].disable)
>                         continue;
>
>                 if (drv->states[i].target_residency <= duration_us)
>                         break;
>         }
> +       if (i < 0)
> +               i = state_idx;
>         return i;
>  }

I'll do something slightly similar, but equivalent.

>
> @@ -264,7 +267,6 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>                         if (max_early_idx >= 0 &&
>                             count < cpu_data->states[i].early_hits)
>                                 count = cpu_data->states[i].early_hits;
> -
>                         continue;
>                 }
>
> There is an additional issue where if idle state 0 is disabled (with the above suggested code patch),
> idle state usage seems to fall to deeper states than idle state 1.
> This is not the expected behaviour.

No, it isn't.

> Kernel 4.20-rc3 works as expected.
> I have not figured this issue out yet, in the code.
>
> Example (1 minute per sample. Number of entries/exits per state):
>     State 0     State 1     State 2     State 3     State 4    Watts
>    28235143,         83,         26,         17,        837,  64.900
>     5583238,     657079,    5884941,    8498552,   30986831,  62.433 << Transition sample, after idle state 0 disabled
>           0,     793517,    7186099,   10559878,   38485721,  61.900 << ?? should have all gone into Idle state 1
>           0,     795414,    7340703,   10553117,   38513456,  62.050
>           0,     807028,    7288195,   10574113,   38523524,  62.167
>           0,     814983,    7403534,   10575108,   38571228,  62.167
>           0,     838302,    7747127,   10552289,   38556054,  62.183
>     9664999,     544473,    4914512,    6942037,   25295361,  63.633 << Transition sample, after idle state 0 enabled
>    27893504,         96,         40,          9,        912,  66.500
>    26556343,         83,         29,          7,        814,  66.683
>    27929227,         64,         20,         10,        931,  66.683

I see.

OK, I'll look into this too, thanks!
