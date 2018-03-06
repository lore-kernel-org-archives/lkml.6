Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751113AbeCFJdi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 04:33:38 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:33444 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750730AbeCFJdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 04:33:35 -0500
Date: Tue, 6 Mar 2018 10:33:31 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jason Vas Dias <jason.vas.dias@gmail.com>
cc: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4.15.7 1/1] on Intel, VDSO should handle CLOCK_MONOTONIC_RAW
 and export 'tsc_calibration' pointer
In-Reply-To: <CALyZvKx=kOaUqTWFK5gZXNTcY9+jCaKRqaH6VAJAOXmp-JJ2Bg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1803060953230.1630@nanos.tec.linutronix.de>
References: <CALyZvKx=kOaUqTWFK5gZXNTcY9+jCaKRqaH6VAJAOXmp-JJ2Bg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason,

On Mon, 5 Mar 2018, Jason Vas Dias wrote:

thanks for providing this. A few formal nits first.

Please read Documentation/process/submitting-patches.rst

Patches need a concise subject line and the subject line wants a prefix, in
this case 'x86/vdso'.

Please don't put anything past the patch. Your delimiters are human
readable, but cannot be handled by tools.

Also please follow the kernel coding style guide lines.

> It also provides a new function in the VDSO :
> 
> struct linux_timestamp_conversion
> { u32  mult;
>   u32  shift;
> };
> extern
>   const struct linux_timestamp_conversion *
>   __vdso_linux_tsc_calibration(void);
> 
> which can be used by user-space rdtsc / rdtscp issuers
> by using code such as in
>    tools/testing/selftests/vDSO/parse_vdso.c
> to call vdso_sym("LINUX_2.6", "__vdso_linux_tsc_calibration"),
> which returns a pointer to the function in the VDSO, which
> returns the address of the 'mult' field in the vsyscall_gtod_data.

No, that's just wrong. The VDSO data is solely there for the VDSO accessor
functions and not to be exposed to random user space.

> Thus user-space programs can use rdtscp and interpret its return values
> in exactly the same way the kernel would, but without entering the kernel.

The VDSO clock_gettime() functions are providing exactly this mechanism.

>  As pointed out in Bug # 198961 :
>    https://bugzilla.kernel.org/show_bug.cgi?id=198961
>  which contains extra test programs and the full story behind this change,
>  using CLOCK_MONOTONIC_RAW without the patch results in
>  a minimum measurable time (latency) of @ 300 - 700ns because of
>  the syscall used by vdso_fallback_gtod() .
> 
> With the patch, the latency falls to @ 100ns .
> 
> The latency would be @ 16 - 32 ns  if the do_monotonic_raw()
> handler could record its previous TSC value and seconds return value
> somewhere, but since the VDSO has no data region or writable page,
> of course it cannot .

And even if it could, it's not as simple as you want it to be. Clocksources
can change during runtime and without effective protection the values are
just garbage.

> Hence, to enable effective use of TSC by user space programs, Linux must
> provide a way for them to discover the calibration mult and shift values
> the kernel uses for the clock source ; only by doing so can user-space
> get values that are comparable to kernel generated values.

Linux must not do anything. It can provide a vdso implementation of
CLOCK_MONOTONIC_RAW, which does not enter the kernel, but not exposure to
data which is not reliably accessible by random user space code.

> And I'd really like to know: why does the gtod->mult value change ?
> After TSC calibration, it and the shift are calculated to render the
> best approximation of a nanoseconds value from the TSC value.
> 
> The TSC is MEANT to be monotonic and to continue in sleep states
> on modern Intel CPUs . So why does the gtod->mult change ?

You are missing the fact that gtod->mult/shift are used for CLOCK_MONOTONIC
and CLOCK_REALTIME, which are adjusted by NTP/PTP to provide network
synchronized time. That means CLOCK_MONOTONIC is providing accurate
and slope compensated nanoseconds.

The raw TSC conversion, even if it is sane hardware, provides just some
approximation of nanoseconds which can be off by quite a margin.

> But the mult value does change.  Currently there is no way for user-space
> programs to discover that such a change has occurred, or when . With this
> very tiny simple patch, they could know instantly when such changes
> occur, and could implement TSC readers that perform the full conversion
> with latencies of 15-30ns (on my CPU).

No. Accessing the mult/shift pair without protection is racy and can lead
to completely erratic results.

> +notrace static int __always_inline do_monotonic_raw( struct timespec *ts)
> +{
> +        volatile u32 tsc_lo=0, tsc_hi=0, tsc_cpu=0; // so same instrs
> generated for 64-bit as for 32-bit builds
> +        u64 ns;
> +        register u64 tsc=0;
> +        if (gtod->vclock_mode == VCLOCK_TSC)
> +        { asm volatile
> +            ( "rdtscp"
> +            : "=a" (tsc_lo)
> +            , "=d" (tsc_hi)
> +            , "=c" (tsc_cpu)
> +            ); // : eax, edx, ecx used - NOT rax, rdx, rcx

If you look at the existing VDSO time getters then you'll notice that
they use accessor functions and not open coded asm constructs.

> +	  tsc     = ((((u64)tsc_hi) & 0xffffffffUL) << 32) | (((u64)tsc_lo)
> & 0xffffffffUL);
> +	  tsc    *= gtod->mult;
> +	  tsc   >>= gtod->shift;
> +	  ts->tv_sec  = __iter_div_u64_rem(tsc, NSEC_PER_SEC, &ns);
> +	  ts->tv_nsec = ns;

This is horrible. Please look at the kernel side implementation of
clock_gettime(CLOCK_MONOTONIC_RAW). The VDSO side can be implemented in the
same way. All what is required is to expose the relevant information in the
existing vsyscall_gtod_data data structure.

> +struct linux_timestamp_conversion
> +{ u32  mult;
> +  u32  shift;
> +};

This wont happen because unprotected access is bad. But even if it would go
anywhere defining the structure which should be accessible by user space
code in the C-file is just wrong. If at all it needs to be defined in a
user space exposed header.

> +extern
> +  const struct linux_timestamp_conversion *
> +  __vdso_linux_tsc_calibration(void);
> +
> +notrace
> +  const struct linux_timestamp_conversion *
> +  __vdso_linux_tsc_calibration(void)
> +{ if( gtod->vclock_mode == VCLOCK_TSC )
> +    return ((struct linux_timestamp_conversion*) &gtod->mult);
> +  return 0UL;

This is the most horrible coding style I saw in a long time. The kernel has
a very well defined coding style.....

> That multiplication and shift really doesn't leave very many
> significant seconds bits!

It's the wrong way to do that.

> Please, can the VDSO include some similar functionality to NOT always
> enter the kernel for CLOCK_MONOTONIC_RAW ,

Yes, this can be done if properly implemented.

> and to export a pointer to the LIVE (kernel updated) gtod->mult and
> gtod->shift values somehow .

No. That's not going to happen.

> The documentation states for CLOCK_MONOTONIC_RAW that it is the
> same as CLOCK_MONOTONIC except it is NOT subject to NTP adjustments .
> This is very far from the case currently, without a patch like the one above.

Errm. The syscall based implementation provides exactly that, so your claim
is just wrong.

> And the kernel should not restrict user-space programs to only being able
> to either measure an NTP adjusted time value, or a time value difference
> of greater than 1000ns with any accuracy, on a modern Intel CPU whose TSC
> ticks 2.8 times per nanosecond (picosecond resolution is theoretically
> possible).

The kernel does not restrict anything. It provides a fast CLOCK_MONOTONIC
time getter in the VDSO and as nobody so far asked for a fast
CLOCK_MONOTONIC_RAW time getter, it just has never been implemented. It can
be done, but it has to be done by following the rules of the VDSO and not
by randomly exposing data.

Thanks,

	tglx
