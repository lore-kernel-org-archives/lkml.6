Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755520AbeCHM50 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 07:57:26 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:38718 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754724AbeCHM5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 07:57:24 -0500
Date: Thu, 8 Mar 2018 13:57:21 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jason Vas Dias <jason.vas.dias@gmail.com>
cc: x86@kernel.org, linux-kernel@vger.kernel.org,
        andi <andi@firstfloor.org>
Subject: Re: Fwd: [PATCH v4.15.7 1/1] on Intel, VDSO should handle
 CLOCK_MONOTONIC_RAW and export 'tsc_calibration' pointer
In-Reply-To: <CALyZvKxEEKyOT7wTC35et6E5NtuvQDOkQHYMnaojs2ae_s3Myw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1803081251380.8662@nanos.tec.linutronix.de>
References: <CALyZvKx=kOaUqTWFK5gZXNTcY9+jCaKRqaH6VAJAOXmp-JJ2Bg@mail.gmail.com> <alpine.DEB.2.21.1803060953230.1630@nanos.tec.linutronix.de> <CALyZvKxORRjBurwj7+YV5fwJfwjMVWif+zpjC9AVM3z3WTVDaA@mail.gmail.com>
 <CALyZvKxEEKyOT7wTC35et6E5NtuvQDOkQHYMnaojs2ae_s3Myw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Mar 2018, Jason Vas Dias wrote:
> I will prepare a new patch that meets submission + coding style guidelines and
> does not expose pointers within the vsyscall_gtod_data region to
> user-space code -
> but I don't really understand why not, since only the gtod->mult value will
> change as long as the clocksource remains TSC, and updates to it by the kernel
> are atomic and partial values cannot be read .
> 
> The code in the patch reverts to old behavior for clocks which are not the
> TSC and provides a way for users to determine if the  clock is still the TSC
> by calling '__vdso_linux_tsc_calibration()', which would return NULL if
> the clock is not the TSC .
> 
> I have never seen Linux on a modern intel box spontaneously decide to
> switch from the TSC clocksource after calibration succeeds and
> it has decided to use the TSC as the system / platform clock source -
> what would make it do this ?
> 
> But for the highly controlled systems I am doing performance testing on,
> I can guarantee that the clocksource does not change.

We are not writing code for a particular highly controlled system. We
expose functionality which operates under all circumstances. There are
various reasons why TSC can be disabled at runtime, crappy BIOS/SMI,
sockets getting out of sync .....

> There is no way user code can write those pointers or do anything other
> than read them, so I see no harm in exposing them to user-space ; then
> user-space programs can issue rdtscp and use the same calibration values
> as the kernel, and use some cached 'previous timespec value' to avoid
> doing the long division every time.
> 
> If the shift & mult are not accurate TSC calibration values, then the
> kernel should put other more accurate calibration values in the gtod .

The raw calibration values are as accurate as the kernel can make them. But
they can be rather far off from converting to real nanoseconds for various
reasons. The NTP/PTP adjusted conversion is matching real units and is
obviously more accurate.

> > Please look at the kernel side implementation of
> > clock_gettime(CLOCK_MONOTONIC_RAW).
> > The VDSO side can be implemented in the
> > same way.
> > All what is required is to expose the relevant information in the
> > existing vsyscall_gtod_data data structure.
> 
> I agree - that is my point entirely , & what I was trying to do .

Well, you did not expose the raw conversion data in vsyscall_gtod_data. You
are using:

+         tsc    *= gtod->mult;
+         tsc   >>= gtod->shift;

That's is the adjusted mult/shift value which can change when NTP/PTP is
enabled and you _cannot_ use it unprotected.

> void getrawmonotonic64(struct timespec64 *ts)
> {
> 	struct timekeeper *tk = &tk_core.timekeeper;
> 	unsigned long seq;
> 	u64 nsecs;
> 
> 	do {
> 		seq = read_seqcount_begin(&tk_core.seq);
> #                       ^-- I think this is the source of the locking
> #                            and the very long latencies !

This protects tk->raw_sec from changing which would result in random time
stamps. Yes, it can cause slightly larger latencies when the timekeeper is
updated on another CPU concurrently, but that's not the main reason why
this is slower in general than the VDSO functions. The syscall overhead is
there for every invocation and it's substantial.

> So in fact, when the clock source is TSC, the value recorded in 'ts'
> by clock_gettime(CLOCK_MONOTONIC_RAW, &ts) is very similar to
>       u64 tsc = rdtscp();
>       tsc *= gtod->mult;
>       tsc >>= gtod->shift;
>       ts.tv_sec=tsc / NSEC_PER_SEC;
>       ts.tv_nsec=tsc % NSEC_PER_SEC;
> 
> which is the algorithm I was using in the VDSO fast TSC reader,
> do_monotonic_raw() .

Except that you are using the adjusted conversion values and not the raw
ones. So your VDSO implementation of monotonic raw access is just wrong and
not matching the syscall based implementation in any way.

> The problem with doing anything more in the VDSO is that there
> is of course nowhere in the VDSO to store any data, as it has
> no data section or writable pages . So some kind of writable
> page would need to be added to the vdso , complicating its
> vdso/vma.c, etc., which is not desirable.

No, you don't need any writeable memory in the VDSO. Look at how the
CLOCK_MONOTONIC and CLOCK_REALTIME functions are implemented in the VDSO.

> But it is equally not desirable to have the clock_gettime
> system call have a latency exceeding 300ns for CLOCK_MONOTONIC_RAW

I said before and I do it once more: CLOCK_MONOTONIC_RAW can be implemented
in the VDSO by adding the relevant data to vsyscall_gtod_data and by using
the proper accessor functions which are there for a reason.

> clocks, nor to measure all the adjustments & previous value dependencies
> that the current implementation is prone to .

I have no idea what you are talking about. If done right,
CLOCK_MONOTONIC_RAW does not have any adjustments.

> But there is no other communication of TSC calibration data currently
> in the gtod
> other than 'shift' and 'mult' ,which do actually give results which correlate
> approximately to the pico_period division above.

Even if I'm repeating myself. vsyscall_gtod_data does not have the raw
information and it simply can be added.

> Attempts to change the vsyscall_gtod_data structure in any way have resulted
> in nasty core dumps of clock_gettime() using processes.
> I'd much appreciate any tips on how to change its layout without breaking
> everything.

I have no idea what you have done, but vsyscall_gtod_data is a purely
kernel internal data structure and can be changed as the kernel requires.

> One currently needs to parse the system log messages to get the
> 'Refined TSC clocksource calibration', or lookup its value in the
> live kernel by looking up the 'tsc_khz' symbol at its
> address given in System.map  with gdb / objdump ,
> converting to offset into data region, and using
> lseek() on /proc/kcore (as root).

Groan.

> The point is, user-space must rely on the kernel to perform
> TSC calibration properly, and the only data in the gtod that
> reflects the result of that calibration are the mult and shift values.
> If linux wants to support user-space TSC readers, it needs to communicate
> the TSC calibration somehow in the VDSO gtod area.

I'm getting tired of this slowly. The kernel supports user space TSC access
with CLOCK_MONOTONIC and CLOCK_REALTIME today in the VDSO.

> And please consider SOME patch to the VDSO to implement user-space TSC
> reading on the intel / AMD , to return a completely unadjusted value for
> CLOCK_MONOTONIC_RAW, as documented, but not as Linux currently does.

clock_gettime(CLOCK_MONOTONIC_RAW) returns the raw and unadjusted
nanosecond time from any clocksource (TSC or whatever) today. It does so as
documented.

The only missing piece is a VDSO counterpart which avoids the syscall
overhead.

> BTW, it is not my 'editor's word-wrap corruping your patch', it is the
> Gmail IMAP server, which believes all lines in plain-text messages
> must be wrapped to 72 characters max, and  enforces this belief,
> correct or not.  I think kernel.org needs to update its tools to parse
> mime attachments or handle email server  line-wrapping, which I have
> no control over - I wish I could move from the gmail server, but it would
> be too much trouble.

Sorry, a lot of people use gmail for kernel work and I think there is
enough documentation out there how to do that.

Thanks,

	tglx
