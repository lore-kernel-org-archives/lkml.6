Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755898AbeCHOHf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 09:07:35 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:38851 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755026AbeCHOHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 09:07:34 -0500
Date: Thu, 8 Mar 2018 15:07:31 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jason Vas Dias <jason.vas.dias@gmail.com>
cc: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        andi <andi@firstfloor.org>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4.15.7 1/1] x86/vdso: handle clock_gettime(CLOCK_MONOTONIC_RAW,
 &ts) in VDSO
In-Reply-To: <CALyZvKxPr1ZsRmHCuhbQJ1ZDjpe4CMXmRQKbyu8tHNf9eb5fdw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1803081358220.8662@nanos.tec.linutronix.de>
References: <CALyZvKxPr1ZsRmHCuhbQJ1ZDjpe4CMXmRQKbyu8tHNf9eb5fdw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Mar 2018, Jason Vas Dias wrote:

Please don't submit patches against randomly chosen stable kernel
versions. Development happens on top of Linus tree or of a subsystem
specific tree.

> +notrace static int __always_inline do_monotonic_raw( struct timespec *ts)
> +{
> +        volatile u32 tsc_lo=0, tsc_hi=0, tsc_cpu=0; // so same instrs
> generated for 64-bit as for 32-bit builds

volatile is wrong to begin with. And tail comments are horrible.

> +        u64 ns;
> +        register u64 tsc=0;

Lacks a new line between variable declaration and code. Documentation
surely told you that you should run checkpatch.pl on your patch....

> +        if (gtod->vclock_mode == VCLOCK_TSC)
> +        {

Opening bracket goes in the same line as the condition.

> +                asm volatile
> +                ( "rdtscp"
> +                : "=a" (tsc_lo)
> +                , "=d" (tsc_hi)
> +                , "=c" (tsc_cpu)
> +                ); // : eax, edx, ecx used - NOT rax, rdx, rcx

I surely asked for using the proper accessor for a reason.

> +                tsc     = ((((u64)tsc_hi) & 0xffffffffUL) << 32) |
> (((u64)tsc_lo) & 0xffffffffUL);
> +                tsc    *= gtod->mult;
> +                tsc   >>= gtod->shift;

And again this is using the _adjusted_ mult/shift values. So the result is
not CLOCK_MONOTONIC_RAW. Aside of that the mult shift values are accessed
completely unprotected against concurrent changes.

Vs. the multiplication: Any RDTSC value which results in a 64bit
multiplication overflow will result in crap output. That is bound to happen
after a certain amount of uptime....

> +                ts->tv_sec  = __iter_div_u64_rem(tsc, NSEC_PER_SEC,
> &ns);

And this falls apart once tsc >= (1 << 32) simply because
__iter_div_u64_rem() returns the integer divison result as u32 ...

Aside of that for large values of @tsc this will result in a loop repeating
exactly int(tsc / NSEC_PER_SEC) times. That's surely fast for anything > 1.

Just for the record: It's well documented that
clock_gettime(CLOCK_MONOTONIC_RAW) returns monotonically increasing time
stamps based on the raw hardware clock.

While your implementation might be way faster than the syscall based
implementation it is not providing the same data and semantics.

Performance benchmark results are only interesting when the underlying
implementation is correct. Sorry, but it wouldn't have been rocket science
to figure out that the result wraps around after 4.29497 seconds....

   tools/testing/selftests/timers/inconsistency-check

would have certainly detected this, but any serious test program which does
not only do blindly performance benchmarking would have noticed as well.

> +                ts->tv_nsec = ns;
> +                return VCLOCK_TSC;
> +        }
> +        return VCLOCK_NONE;
> +}
> +
>  notrace static void do_realtime_coarse(struct timespec *ts)
>  {
>  	unsigned long seq;
> @@ -277,6 +301,10 @@ notrace int __vdso_clock_gettime(clockid_t clock,
> struct timespec *ts)
>  		if (do_monotonic(ts) == VCLOCK_NONE)
>  			goto fallback;
>  		break;
> +	case CLOCK_MONOTONIC_RAW:
> +		if (do_monotonic_raw(ts) == VCLOCK_NONE)
> +			goto fallback;
> +		break;
>  	case CLOCK_REALTIME_COARSE:
>  		do_realtime_coarse(ts);
>  		break;
> @@ -326,3 +354,18 @@ notrace time_t __vdso_time(time_t *t)
>  }
>  time_t time(time_t *t)
>  	__attribute__((weak, alias("__vdso_time")));
> +
> +extern const struct linux_tsc_calibration *
> +        __vdso_linux_tsc_calibration(void);

If at all then this stuff wants to be in a separate patch because it has
absolutely nothing to do with the VDSO based CLOCK_MONOTONIC_RAW accessor.

Documentation is clear about that as well:

  The point to remember is that each patch should make an easily understood
  change that can be verified by reviewers.  Each patch should be
  justifiable on its own merits.

> +notrace  const struct linux_tsc_calibration *
> +  __vdso_linux_tsc_calibration(void)
> +{
> +        if( gtod->vclock_mode == VCLOCK_TSC )
> +                return ((const struct linux_tsc_calibration*) &gtod->mult);

Returning a pointer into a part of another data struture is completely
wrong. The data structure can change and as a result the pointer will point
at even more bogus data as it does anyway.

> +        return 0UL;

0UL is hardly a valid return value for a function returning a pointer.

> +}
> +
> +const struct linux_tsc_calibration * linux_tsc_calibration(void)
> +        __attribute((weak, alias("__vdso_linux_tsc_calibration")));
> +
> diff --git a/arch/x86/entry/vdso/vdso.lds.S b/arch/x86/entry/vdso/vdso.lds.S
> index d3a2dce..41a2ca5 100644
> --- a/arch/x86/entry/vdso/vdso.lds.S
> +++ b/arch/x86/entry/vdso/vdso.lds.S
> @@ -24,7 +24,9 @@ VERSION {
>  		getcpu;
>  		__vdso_getcpu;
>  		time;
> -		__vdso_time;
> +	        __vdso_time;

You are using spaces not tabs and that line is not supposed to be changed
anyway.

> +                linux_tsc_calibration;
> +		__vdso_linux_tsc_calibration;

More whitespace damage.

> diff --git a/arch/x86/include/uapi/asm/vdso_tsc_calibration.h \
> b/arch/x86/include/uapi/asm/vdso_tsc_calibration.h
> new file mode 100644
> index 0000000..6febb84
> --- /dev/null
> +++ b/arch/x86/include/uapi/asm/vdso_tsc_calibration.h
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _ASM_X86_VDSO_TSC_CALIBRATION_H
> +#define _ASM_X86_VDSO_TSC_CALIBRATION_H
> +/*
> + * Programs that want to use rdtsc / rdtscp instructions
> + * from user-space can make use of the Linux kernel TSC calibration
> + * by calling :
> + *    __vdso_linux_tsc_calibration(void);
> + * ( one has to resolve this symbol as in
> + *   tools/testing/selftests/vDSO/parse_vdso.c
> + * )
> + * which returns a pointer into the read-only
> + * vvar_page (the vsyscall_gtod_data structure),
> + * with the following layout :

Again. This returns a pointer to a data structure which is completely
decoupled from vsyscall_gtod_data and it just happens to work right now by
some definition of works.

> + */
> +
> +struct linux_tsc_calibration
> +{
> +        unsigned int mult;   /* amount to multiply 64-bit TSC value by */
> +
> +        unsigned int shift;  /* the right shift to apply to
> (mult*TSC) yielding \
>  nanoseconds */

If you want to document a data structure then please use the proper
kerneldoc comment on top of it.

Thanks,

	tglx
