Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754143AbeEOPS7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 11:18:59 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36025 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754123AbeEOPS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 11:18:58 -0400
X-Google-Smtp-Source: AB8JxZr0nwPDQryhfALKwbqIl/7wh+vCH4q8R4zOcCUlccDfb3L1xVgQ+NnDSM9rhvp5FHkU+RVu4A==
Date: Tue, 15 May 2018 08:18:53 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: Frederic Weisbecker <frederic@kernel.org>
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
Message-ID: <20180515151853.GB169754@joelaf.mtv.corp.google.com>
References: <1525634395-23380-1-git-send-email-frederic@kernel.org>
 <1525634395-23380-9-git-send-email-frederic@kernel.org>
 <CAEi0qNkSUig2i92qEpPekO1Z0kDTVB+95UKbJy5b+9YKQHfciA@mail.gmail.com>
 <20180515135259.GB24389@lerouge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515135259.GB24389@lerouge>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 03:53:00PM +0200, Frederic Weisbecker wrote:
> On Mon, May 07, 2018 at 12:46:06AM +0000, Joel Fernandes wrote:
> > On Sun, May 6, 2018 at 12:22 PM Frederic Weisbecker <frederic@kernel.org>
> > wrote:
> > 
> > > arch_validate_hwbkpt_settings() mixes up attribute check and commit into
> > > a single code entity. Therefore the validation may return an error due to
> > > incorrect atributes while still leaving halfway modified architecture
> > > breakpoint struct.
> > 
> > > Now that we have split its logic on all archs, we can remove this
> > > misdesigned function and call directly the arch check and commit
> > > functions instead. This allows us to later avoid commiting
> > > a breakpoint to architecture when its slot couldn't be allocated.
> > 
> > [...]
> > > diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> > > index 6e28d28..6896ceeb 100644
> > > --- a/kernel/events/hw_breakpoint.c
> > > +++ b/kernel/events/hw_breakpoint.c
> > > @@ -402,11 +402,12 @@ int dbg_release_bp_slot(struct perf_event *bp)
> > 
> > >   static int validate_hw_breakpoint(struct perf_event *bp)
> > >   {
> > > -       int ret;
> > > +       int err;
> > 
> > > -       ret = arch_validate_hwbkpt_settings(bp);
> > > -       if (ret)
> > > -               return ret;
> > > +       err = hw_breakpoint_arch_check(bp, &bp->attr);
> > > +       if (err)
> > > +               return err;
> > > +       hw_breakpoint_arch_commit(bp);
> > 
> > minor nit:
> > To preserve bisectability, shouldn't this be the following in this and
> > earlier patches?
> > 
> >         err = hw_breakpoint_arch_check(bp, &bp->attr);
> >         hw_breakpoint_arch_commit(bp);
> >         if (err)
> >                 return err;
> > 
> > And then in patch 9/9 you can fix it the right way?
> 
> I don't see how it was breaking bisectability.

Sorry may be I used wrong words, I meant keeping the restructure patch as
just for restvructuring and then changing the logic later. But I'm Ok with
what you have, and also like Peter's __weak thing suggestion.

> Anyway I'm rewriting it entirely to use:
> 
>     struct arch_hw_breakpoint hw;
>     int err;
> 
>     err = hw_breakpoint_arch_parse(bp, attr, &hw);
>     if (err)
>         return err;

Cool, if you don't mind do CC me on patches, Thanks.

Just to update you about my email address change, the new one is: joel@joelfernandes.org

thanks,

- Joel
