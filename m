Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753891AbeEONxF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 09:53:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:40766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752740AbeEONxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 09:53:04 -0400
Date: Tue, 15 May 2018 15:53:00 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Joel Fernandes <joel.opensrc@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jolsa@redhat.com, namhyung@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, torvalds@linux-foundation.org,
        ysato@users.sourceforge.jp, benh@kernel.crashing.org,
        Catalin Marinas <catalin.marinas@arm.com>, chris@zankel.net,
        paulus@samba.org, Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>, mpe@ellerman.id.au, dalias@libc.org,
        Ingo Molnar <mingo@kernel.org>, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, luto@kernel.org, acme@kernel.org,
        jcmvbkbc@gmail.com
Subject: Re: [PATCH 8/9] perf/breakpoint: Split breakpoint "check" and
 "commit"
Message-ID: <20180515135259.GB24389@lerouge>
References: <1525634395-23380-1-git-send-email-frederic@kernel.org>
 <1525634395-23380-9-git-send-email-frederic@kernel.org>
 <CAEi0qNkSUig2i92qEpPekO1Z0kDTVB+95UKbJy5b+9YKQHfciA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEi0qNkSUig2i92qEpPekO1Z0kDTVB+95UKbJy5b+9YKQHfciA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 12:46:06AM +0000, Joel Fernandes wrote:
> On Sun, May 6, 2018 at 12:22 PM Frederic Weisbecker <frederic@kernel.org>
> wrote:
> 
> > arch_validate_hwbkpt_settings() mixes up attribute check and commit into
> > a single code entity. Therefore the validation may return an error due to
> > incorrect atributes while still leaving halfway modified architecture
> > breakpoint struct.
> 
> > Now that we have split its logic on all archs, we can remove this
> > misdesigned function and call directly the arch check and commit
> > functions instead. This allows us to later avoid commiting
> > a breakpoint to architecture when its slot couldn't be allocated.
> 
> [...]
> > diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> > index 6e28d28..6896ceeb 100644
> > --- a/kernel/events/hw_breakpoint.c
> > +++ b/kernel/events/hw_breakpoint.c
> > @@ -402,11 +402,12 @@ int dbg_release_bp_slot(struct perf_event *bp)
> 
> >   static int validate_hw_breakpoint(struct perf_event *bp)
> >   {
> > -       int ret;
> > +       int err;
> 
> > -       ret = arch_validate_hwbkpt_settings(bp);
> > -       if (ret)
> > -               return ret;
> > +       err = hw_breakpoint_arch_check(bp, &bp->attr);
> > +       if (err)
> > +               return err;
> > +       hw_breakpoint_arch_commit(bp);
> 
> minor nit:
> To preserve bisectability, shouldn't this be the following in this and
> earlier patches?
> 
>         err = hw_breakpoint_arch_check(bp, &bp->attr);
>         hw_breakpoint_arch_commit(bp);
>         if (err)
>                 return err;
> 
> And then in patch 9/9 you can fix it the right way?

I don't see how it was breaking bisectability.
Anyway I'm rewriting it entirely to use:

    struct arch_hw_breakpoint hw;
    int err;

    err = hw_breakpoint_arch_parse(bp, attr, &hw);
    if (err)
        return err;

    .....

    bp->hw.info = hw;


Thanks.
