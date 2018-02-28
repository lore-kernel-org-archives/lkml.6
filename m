Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751658AbeB1APf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 19:15:35 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35094 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbeB1APe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 19:15:34 -0500
X-Google-Smtp-Source: AH8x227KPJlxKk2DrPxj46EYaajMN78/N8TAVqHd3CP44gy58lJytKG/Qcu7tISbHEDD6QNvzrC4cA==
Date: Wed, 28 Feb 2018 01:15:24 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Daniel Lustig <dlustig@nvidia.com>
Cc: Palmer Dabbelt <palmer@sifive.com>, albert@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv/barrier: Define __smp_{store_release,load_acquire}
Message-ID: <20180228001524.GA3999@andrea>
References: <mhng-d0fc25e5-9a3f-4988-9260-3d584b8f4606@palmer-si-x1c4>
 <e482049c-70b5-3b4f-a818-0740bec9a4fa@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e482049c-70b5-3b4f-a818-0740bec9a4fa@nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 02:20:37PM -0800, Daniel Lustig wrote:
> On 2/27/2018 10:21 AM, Palmer Dabbelt wrote:
> > On Mon, 26 Feb 2018 18:24:11 PST (-0800), parri.andrea@gmail.com wrote:
> >> Introduce __smp_{store_release,load_acquire}, and rely on the generic
> >> definitions for smp_{store_release,load_acquire}. This avoids the use
> >> of full ("rw,rw") fences on SMP.
> >>
> >> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> >> ---
> >>  arch/riscv/include/asm/barrier.h | 15 +++++++++++++++
> >>  1 file changed, 15 insertions(+)
> >>
> >> diff --git a/arch/riscv/include/asm/barrier.h b/arch/riscv/include/asm/barrier.h
> >> index 5510366d169ae..d4628e4b3a5ea 100644
> >> --- a/arch/riscv/include/asm/barrier.h
> >> +++ b/arch/riscv/include/asm/barrier.h
> >> @@ -38,6 +38,21 @@
> >>  #define __smp_rmb()    RISCV_FENCE(r,r)
> >>  #define __smp_wmb()    RISCV_FENCE(w,w)
> >>
> >> +#define __smp_store_release(p, v)                    \
> >> +do {                                    \
> >> +    compiletime_assert_atomic_type(*p);                \
> >> +    RISCV_FENCE(rw,w);                        \
> >> +    WRITE_ONCE(*p, v);                        \
> >> +} while (0)
> >> +
> >> +#define __smp_load_acquire(p)                        \
> >> +({                                    \
> >> +    typeof(*p) ___p1 = READ_ONCE(*p);                \
> >> +    compiletime_assert_atomic_type(*p);                \
> >> +    RISCV_FENCE(r,rw);                        \
> >> +    ___p1;                                \
> >> +})
> >> +
> >>  /*
> >>   * This is a very specific barrier: it's currently only used in two places in
> >>   * the kernel, both in the scheduler.  See include/linux/spinlock.h for the two
> > 
> > I'm adding Daniel just in case I misunderstood what's going on here,
> > but these look good to me.  As this is a non-trivial memory model
> > change I'm going to let it bake in linux-next for a bit just so it
> > gets some visibility.
> 
> Looks good to me too.  In particular, it also covers the
> Write->release(p)->acquire(p)->Write ordering that we were debating
> in the broader LKMM thread, which is good.

Yeah, I think that other changes would be required to completely cover
the issues debated in that thread: I plan to prepare and to post a new
series/RFC to address those (unless someone precedes me of course ;-).

  Andrea


> 
> Dan
> 
> > 
> > Thanks
