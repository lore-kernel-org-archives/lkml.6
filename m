Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754610AbeCHQkP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 11:40:15 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:39223 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752094AbeCHQkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 11:40:14 -0500
Date: Thu, 8 Mar 2018 17:40:09 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jason Vas Dias <jason.vas.dias@gmail.com>
cc: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        andi <andi@firstfloor.org>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: Fwd: [PATCH v4.15.7 1/1] on Intel, VDSO should handle
 CLOCK_MONOTONIC_RAW and export 'tsc_calibration' pointer
In-Reply-To: <CALyZvKw05TriH83aJn3gnzvi46Do_K1UEDQkWU+A9n=UCsxjVA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1803081646300.8662@nanos.tec.linutronix.de>
References: <CALyZvKx=kOaUqTWFK5gZXNTcY9+jCaKRqaH6VAJAOXmp-JJ2Bg@mail.gmail.com> <alpine.DEB.2.21.1803060953230.1630@nanos.tec.linutronix.de> <CALyZvKxORRjBurwj7+YV5fwJfwjMVWif+zpjC9AVM3z3WTVDaA@mail.gmail.com> <CALyZvKxEEKyOT7wTC35et6E5NtuvQDOkQHYMnaojs2ae_s3Myw@mail.gmail.com>
 <alpine.DEB.2.21.1803081251380.8662@nanos.tec.linutronix.de> <CALyZvKw05TriH83aJn3gnzvi46Do_K1UEDQkWU+A9n=UCsxjVA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Mar 2018, Jason Vas Dias wrote:
> On 08/03/2018, Thomas Gleixner <tglx@linutronix.de> wrote:
> I'd appreciate clarification on few points :
> 
> > Well, you did not expose the raw conversion data in vsyscall_gtod_data. You
> > are using:
> >
> > +         tsc    *= gtod->mult;
> > +         tsc   >>= gtod->shift;
> >
> > That's is the adjusted mult/shift value which can change when NTP/PTP is
> > enabled and you _cannot_ use it unprotected.
> ...
> > vsyscall_gtod_data does not have the raw
> > information and it simply can be added.
> 
> 
> By "the raw information" here,  do you mean :
>   o   the 'tsc_khz'  "Refined TSC clocksource calibration" ?
>   o   or some other data ?

The raw conversion data which is used in getrawmonotonic64() as I pointed
out several times now.

> The shift and mult values are calculated from
> tsc_khz by :
> <quote><code>
> tsc_refine_calibration_work() , in arch/x86/kernel/tsc.c , @ line 1164:
> { ...
>   	tsc_khz = freq;
> 	pr_info("Refined TSC clocksource calibration: %lu.%03lu MHz\n",
> 		(unsigned long)tsc_khz / 1000,
> 		(unsigned long)tsc_khz % 1000);

There is really no point in copying tons of code in your replies. I already
know how that works, really.

> I understand that the vsyscall_gtod_data contains the adjusted mult & shift ,
> but since this is the only data available there, and the kernel
> syscall implementation
> of clock_gettime(CLOCK_MONOTONIC_RAW) does seem to access
> these same adjusted shift & mult values - as I showed in previous post,
> kernel/time/timekeeping.c's getmonotonicraw64() does use these same
> mult and shift values:

It really does not and if you can't be bothered to actually look at the
difference of:

void getrawmonotonic64(struct timespec64 *ts)
{
	...
	nsecs = timekeeping_get_ns(&tk->tkr_raw);

versus:

void ktime_get_ts64(struct timespec64 *ts)
{
	...
	nsec = timekeeping_get_ns(&tk->tkr_mono);

then I really can't help it.

> Are the vdso gtod->mult and gtod->shift values somehow different from
>   'tkr->mult' and 'tkr->shift' ?

They are the adjusted values used for CLOCK_MONOTONIC and they are updated
when the kernel side timekeeper->tkr_mono data is updated. What's not
stored in the VDSO data right now is the raw data. As I told you a
gazillion times now, it can be stored there and then the VDSO based mono
raw accessor can be implemented similar to the monotonic/realtime
implementations.

> I thought they were actually pointers to the same calibration data.

Care to look at how the vdso data is updated?

> Yes, as noted in previous posts, the 'mult' value does seem to
> change by small increments . I guess this is purely because of NTP / PTP ?
> So the syscall implementation of clock_gettime(CLOCK_MONOTONIC_RAW,&ts)
> actually does return an NTP / PTP adjusted value ?
> Then it is  even worse than I thought - not only does it
> have an unusably high latency, but it does not do what
> it is documented to do at all, if those mult/shift values
> are changed by NTP/PTP / CPU frequency adjustments.

Once again: CLOCK_MONOTONIC_RAW does exactly what is documented and the
conversion values are not the same as those for CLOCK_MONOTONIC.

> I do strongly believe that if the VDSO is going to support accessing the TSC
> from user-space,
> it should provide some access to the  TSC calibration values that would
> permit user-space TSC readers to convert the TSC value to nanoseconds
> accurately and efficiently, in a way not prone to NTP or PTP adjustments ;

You surely are free to believe what you want.

> otherwise the VDSO do_monotonic_raw must be used, and as it has nowhere
> to cache previous values, it must do the long division every time,
> which enforces
> a latency of >= @ 100ns.

I told you before that there is neither a requirement to store anything nor
a requirement to use a long division. I gave you the pointers to the
monotonic/realtime accessors which do neither store anything nor do long
divisions.

> My  user-space TSC reader in 'test_vdso_tsc.c' (sent as attachments to
> previous mails)  uses the pointer returned by
> __vdso_linux_tsc_calibration() , and a
> cached previous value, to achieve latencies of 10-20ns .

I don't care about that as this is a completely different thing. Providing
the raw TSC conversion factors to user space might be a worthwhile
exercise, but has nothing to do with the VDSO based clock_gettime()
implementation at all. And as I pointed out in the other reply, it's not
going to happen in a prone to be broken way.

> I can't see how the contents pointed to by the pointer returned by
> __vdso_linux_tsc_calibration()
> will be "garbage" , as long as the clock source remains TSC .

There is no guarantee that the clock source remains TSC. And I don't care
about your 'controlled' system at all. Interfaces have to be usable on all
systems and cannot be implemented on a 'might work if you know what you are
doing' basis. That's not the way the kernel implements interfaces ever.

> Updates to 64 bit memory locations are atomic on x86_64 , so either
> an updated valid 'mult' value is read, or the previous valid 'mult' value
> is read (the shift does not change) - I can't see the harm in that.

Again: Trying to implement MONOTONIC_RAW with the adjusted mult value is
wrong. You cannot even implement MONOTONIC with just looking at gtod->mult.
Please study the underlying algorithm of the monotonic accessor before
making claims like that.

> By 'Controlled' I just mean I can control whether the clocksource will change
> during a run of given test program that uses the TSC or not - I
> believe any other user would also be in the same position - don't
> change the clock source during
> a run of your test program, and it will yield valid results.  It is
> difficult to imagine
> a time measurement program that could be expected to withstand a change
> of the system clocksource and still provide valid results - one would want to
> discard results from a program that experienced a system clock-source change.

Well, no. An interface exported by the kernel has to provide safe data
under all circumstances and the existing syscall and VDSO based accessors
provide correct time stamps even accross a clocksource change.

> So I don't agree that it is a priori wrong to return a pointer into
> the VDSO vvar
> page to user-space, which can only be used in a read-only way, and
> whose contents
> will be valid as long as the clock source does not change, when users
> can easily determine if the clock source has changed or not before using
> the pointer - I don't see how the contents can spontaneously become 'garbage'
> if the clock source does not change, and if it does change, users can easily
> find out about it.

It's already garbage to use the changing mult value blindy on the TSC
readout. The conversion is only valid for a given time slice and if you
look at the clock monotonic access (condensed):

     do {
     	seq = gtod_read_begin(gtod);
	ts->tv_sec = gtod->monotonic_time_sec;
	ns = gtod->monotonic_time_snsec;
	  cycles = vread_tsc();
	  v = (cycles - gtod->cycle_last) & gtod->mask;
	  v *= gtod->mult;
	ns += v;
     } while (unlikely(gtod_read_retry(gtod, seq)));

     ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
     ts->tv_nsec += ns;
     
which is the same algorithm as in the syscall based implementation then
you'll notice that this calculates the delta between the TSC value and
gtod->cycle_last. __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns) is actually not
a division, it's just making sure that the nsec part does not get larger
than NSEC_PER_SEC and it's guaranteed by the underlying update mechanism
that this is not a unbound loop, but at max ONE adjustment step.

This is accurate, fast and safe against changes of both the conversion
factor and the underlying clocksource.

> The only reason I use the mult & shift is because this is the way Linux
> does it , and we'd like to obtain TSC time values that correlate well
> with those generated by the kernel.

The right way to do that is to put the raw conversion values and the raw
seconds base value into the vdso data and implement the counterpart of
getrawmonotonic64(). And if that is done, then it can be done for _ALL_
clocksources which support VDSO access and not just for the TSC.

> It does discard alot of resolution and seconds bits , but the values do appear

The kernel does not lose bits at all and the accuracy is determined by the
shift value, which is usually about 24. So the internal resolution of
timekeeping is 1/(1 << 24) nanoseconds, which more than sufficient to
maintain accuracy.

> Please, I'm not saying my patch must be integrated as-is into Linux, I'm
> just saying we really need a low-latency TSC reader in the VDSO for
>    clock_gettime(CLOCK_MONOTONIC_RAW, &ts)
> under Linux on Intel / AMD, and presenting one way I've found to provide one.

Just that it does neither provide CLOCK_MONOTONIC_RAW time stamps nor does
it work for more than 4 seconds straight.

> If you find a better way, please let me know.

I think I gave you enough hints by now, how this should be done. If you
don't feel up to the task to make it work, then please let me know and just
ask for a VDSO implementation of clock_gettime(CLOCK_MONOTONIC_RAW) instead
of making completely false claims about the correctness of the kernel
timekeeping infrastructure.

Thanks,

	tglx
