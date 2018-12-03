Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6F8C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750CE20850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:47:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 750CE20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbeLCXry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:47:54 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:64228 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeLCXrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 18:47:53 -0500
Received: from 79.184.252.87.ipv4.supernova.orange.pl (79.184.252.87) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.157)
 id b5e424915e71a5cf; Tue, 4 Dec 2018 00:47:41 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     Giovanni Gherdovich <ggherdovich@suse.cz>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [RFC/RFT][PATCH v6] cpuidle: New timer events oriented governor for tickless systems
Date:   Tue, 04 Dec 2018 00:47:31 +0100
Message-ID: <2107394.tME3olEdyg@aspire.rjw.lan>
In-Reply-To: <CAJZ5v0j6AEjztoFfpQAc3NgQ5JtsWgRqscoE_u1eespVM-Cnmw@mail.gmail.com>
References: <001901d48881$29ea59d0$7dbf0d70$@net> <CAJZ5v0j6AEjztoFfpQAc3NgQ5JtsWgRqscoE_u1eespVM-Cnmw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, November 30, 2018 9:51:19 AM CET Rafael J. Wysocki wrote:
> Hi Doug,
> 
> On Fri, Nov 30, 2018 at 8:49 AM Doug Smythies <dsmythies@telus.net> wrote:
> >
> > Hi Rafael,
> >
> > On 2018.11.23 02:36 Rafael J. Wysocki wrote:
> >
> > ... [snip]...
> >
> > > +/**
> > > + * teo_find_shallower_state - Find shallower idle state matching given duration.
> > > + * @drv: cpuidle driver containing state data.
> > > + * @dev: Target CPU.
> > > + * @state_idx: Index of the capping idle state.
> > > + * @duration_us: Idle duration value to match.
> > > + */
> > > +static int teo_find_shallower_state(struct cpuidle_driver *drv,
> > > +                                 struct cpuidle_device *dev, int state_idx,
> > > +                                 unsigned int duration_us)
> > > +{
> > > +     int i;
> > > +
> > > +     for (i = state_idx - 1; i > 0; i--) {
> > > +             if (drv->states[i].disabled || dev->states_usage[i].disable)
> > > +                     continue;
> > > +
> > > +             if (drv->states[i].target_residency <= duration_us)
> > > +                     break;
> > > +     }
> > > +     return i;
> > > +}
> >
> > I think this subroutine has a problem when idle state 0
> > is disabled.
> 
> You are right, thanks!
> 
> > Perhaps something like this might help:
> >
> > diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
> > index bc1c9a2..5b97639 100644
> > --- a/drivers/cpuidle/governors/teo.c
> > +++ b/drivers/cpuidle/governors/teo.c
> > @@ -196,7 +196,8 @@ static void teo_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
> >  }
> >
> >  /**
> > - * teo_find_shallower_state - Find shallower idle state matching given duration.
> > + * teo_find_shallower_state - Find shallower idle state matching given
> > + * duration, if possible.
> >   * @drv: cpuidle driver containing state data.
> >   * @dev: Target CPU.
> >   * @state_idx: Index of the capping idle state.
> > @@ -208,13 +209,15 @@ static int teo_find_shallower_state(struct cpuidle_driver *drv,
> >  {
> >         int i;
> >
> > -       for (i = state_idx - 1; i > 0; i--) {
> > +       for (i = state_idx - 1; i >= 0; i--) {
> >                 if (drv->states[i].disabled || dev->states_usage[i].disable)
> >                         continue;
> >
> >                 if (drv->states[i].target_residency <= duration_us)
> >                         break;
> >         }
> > +       if (i < 0)
> > +               i = state_idx;
> >         return i;
> >  }
> 
> I'll do something slightly similar, but equivalent.

I actually ended up fixing it differently, as the above will cause state_idx
to be returned even if some states shallower than state_idx are enabled, but
their target residencies are higher than duration_us.  In that case, though,
it still is more correct to return the shallowest enabled state rather than
state_idx.

> >
> > @@ -264,7 +267,6 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
> >                         if (max_early_idx >= 0 &&
> >                             count < cpu_data->states[i].early_hits)
> >                                 count = cpu_data->states[i].early_hits;
> > -
> >                         continue;
> >                 }
> >
> > There is an additional issue where if idle state 0 is disabled (with the above suggested code patch),
> > idle state usage seems to fall to deeper states than idle state 1.
> > This is not the expected behaviour.
> 
> No, it isn't.
> 
> > Kernel 4.20-rc3 works as expected.
> > I have not figured this issue out yet, in the code.
> >
> > Example (1 minute per sample. Number of entries/exits per state):
> >     State 0     State 1     State 2     State 3     State 4    Watts
> >    28235143,         83,         26,         17,        837,  64.900
> >     5583238,     657079,    5884941,    8498552,   30986831,  62.433 << Transition sample, after idle state 0 disabled
> >           0,     793517,    7186099,   10559878,   38485721,  61.900 << ?? should have all gone into Idle state 1
> >           0,     795414,    7340703,   10553117,   38513456,  62.050
> >           0,     807028,    7288195,   10574113,   38523524,  62.167
> >           0,     814983,    7403534,   10575108,   38571228,  62.167
> >           0,     838302,    7747127,   10552289,   38556054,  62.183
> >     9664999,     544473,    4914512,    6942037,   25295361,  63.633 << Transition sample, after idle state 0 enabled
> >    27893504,         96,         40,          9,        912,  66.500
> >    26556343,         83,         29,          7,        814,  66.683
> >    27929227,         64,         20,         10,        931,  66.683
> 
> I see.
> 
> OK, I'll look into this too, thanks!

This probably is the artifact of the fix for the teo_find_shallower_state()
issue.

Anyway, I'm not able to reproduce this with the teo_find_shallower_state() issue
fixed differently.

Thanks,
Rafael

