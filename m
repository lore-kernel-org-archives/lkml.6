Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965896AbeEXJQd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 05:16:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57980 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965833AbeEXJQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 05:16:27 -0400
Date: Thu, 24 May 2018 11:16:19 +0200
From: Miroslav Lichvar <mlichvar@redhat.com>
To: John Stultz <john.stultz@linaro.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH RFC] timekeeping: Update multiplier when NTP frequency is
 set directly
Message-ID: <20180524091619.GC1177@localhost>
References: <20180523113321.20404-1-mlichvar@redhat.com>
 <CALAqxLVeOiLu+QAi6A_PGkvi9nxJXvy357kqYDATDnZO69WFqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLVeOiLu+QAi6A_PGkvi9nxJXvy357kqYDATDnZO69WFqw@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 11:05:34AM -0700, John Stultz wrote:
> On Wed, May 23, 2018 at 4:33 AM, Miroslav Lichvar <mlichvar@redhat.com> wrote:
> > This removes a hidden non-deterministic delay in setting of the
> > frequency and allows an extremely tight control of the system clock
> > with update rates close to or even exceeding the kernel HZ.

> I feel like we tried this years back, but had to revert it. But its
> been awhile. Am I confusing things?

IIRC we only talked about doing this. Before the recent changes in
timekeeping, namely c2cda2a5 (Don't align NTP frequency adjustments to
ticks), it wouldn't make much sense. There would still be a hidden
delay, it would just be negative (from the applications point of
view).

> > -       /* Check if there's really nothing to do */
> > -       if (offset < real_tk->cycle_interval)
> > -               goto out;
> > -
> 
> Apologies again, as I don't have a lot of context here these days, but
>  this could mean we end up doing unnecessary work on every
> update_wall_time, no?

I'm not sure. If I understand it correctly, update_wall_time() is
normally not called more than once per tick. Only when an update is
late and it happens to include the next tick, the subsequent call
might be unnecessary, right?

> Would a "force" flag be better to pass to update_wall_time() to only
> avoid the short-cut in the non-adjtimex case?

Yes, that makes sense.

Thanks,

-- 
Miroslav Lichvar
