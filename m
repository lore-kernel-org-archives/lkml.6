Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753943AbeCFRNf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 12:13:35 -0500
Received: from mail-ot0-f169.google.com ([74.125.82.169]:43591 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753852AbeCFRNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 12:13:32 -0500
X-Google-Smtp-Source: AG47ELtvecqfFrIVi38YNJpAONojeeNysVaZhpA5+x1Plwc9zJ7d+KisuESUsnbOj2yEynKwzW38o0gEo06ol97kM7E=
MIME-Version: 1.0
In-Reply-To: <CALyZvKxORRjBurwj7+YV5fwJfwjMVWif+zpjC9AVM3z3WTVDaA@mail.gmail.com>
References: <CALyZvKx=kOaUqTWFK5gZXNTcY9+jCaKRqaH6VAJAOXmp-JJ2Bg@mail.gmail.com>
 <alpine.DEB.2.21.1803060953230.1630@nanos.tec.linutronix.de> <CALyZvKxORRjBurwj7+YV5fwJfwjMVWif+zpjC9AVM3z3WTVDaA@mail.gmail.com>
From: Jason Vas Dias <jason.vas.dias@gmail.com>
Date: Tue, 6 Mar 2018 17:13:30 +0000
Message-ID: <CALyZvKxEEKyOT7wTC35et6E5NtuvQDOkQHYMnaojs2ae_s3Myw@mail.gmail.com>
Subject: Fwd: [PATCH v4.15.7 1/1] on Intel, VDSO should handle
 CLOCK_MONOTONIC_RAW and export 'tsc_calibration' pointer
To: x86@kernel.org, linux-kernel@vger.kernel.org,
        andi <andi@firstfloor.org>, tglx@linutronix.de
Content-Type: multipart/mixed; boundary="f40304355c44d2355b0566c18f9d"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--f40304355c44d2355b0566c18f9d
Content-Type: text/plain; charset="UTF-8"

On 06/03/2018, Thomas Gleixner <tglx@linutronix.de> wrote:
> Jason,
>
> On Mon, 5 Mar 2018, Jason Vas Dias wrote:
>
> thanks for providing this. A few formal nits first.
>
> Please read Documentation/process/submitting-patches.rst
>
> Patches need a concise subject line and the subject line wants a prefix, in
> this case 'x86/vdso'.
>
> Please don't put anything past the patch. Your delimiters are human
> readable, but cannot be handled by tools.
>
> Also please follow the kernel coding style guide lines.
>
>> It also provides a new function in the VDSO :
>>
>> struct linux_timestamp_conversion
>> { u32 mult;
>> u32 shift;
>> };
>> extern
>> const struct linux_timestamp_conversion *
>> __vdso_linux_tsc_calibration(void);
>>
>> which can be used by user-space rdtsc / rdtscp issuers
>> by using code such as in
>> tools/testing/selftests/vDSO/parse_vdso.c
>> to call vdso_sym("LINUX_2.6", "__vdso_linux_tsc_calibration"),
>> which returns a pointer to the function in the VDSO, which
>> returns the address of the 'mult' field in the vsyscall_gtod_data.
>
> No, that's just wrong. The VDSO data is solely there for the VDSO accessor
> functions and not to be exposed to random user space.
>
>> Thus user-space programs can use rdtscp and interpret its return values
>> in exactly the same way the kernel would, but without entering the
>> kernel.
>
> The VDSO clock_gettime() functions are providing exactly this mechanism.
>
>> As pointed out in Bug # 198961 :
>> https://bugzilla.kernel.org/show_bug.cgi?id=198961
>> which contains extra test programs and the full story behind this
>> change,
>> using CLOCK_MONOTONIC_RAW without the patch results in
>> a minimum measurable time (latency) of @ 300 - 700ns because of
>> the syscall used by vdso_fallback_gtod() .
>>
>> With the patch, the latency falls to @ 100ns .
>>
>> The latency would be @ 16 - 32 ns if the do_monotonic_raw()
>> handler could record its previous TSC value and seconds return value
>> somewhere, but since the VDSO has no data region or writable page,
>> of course it cannot .
>
> And even if it could, it's not as simple as you want it to be. Clocksources
> can change during runtime and without effective protection the values are
> just garbage.
>
>> Hence, to enable effective use of TSC by user space programs, Linux must
>> provide a way for them to discover the calibration mult and shift values
>> the kernel uses for the clock source ; only by doing so can user-space
>> get values that are comparable to kernel generated values.
>
> Linux must not do anything. It can provide a vdso implementation of
> CLOCK_MONOTONIC_RAW, which does not enter the kernel, but not exposure to
> data which is not reliably accessible by random user space code.
>
>> And I'd really like to know: why does the gtod->mult value change ?
>> After TSC calibration, it and the shift are calculated to render the
>> best approximation of a nanoseconds value from the TSC value.
>>
>> The TSC is MEANT to be monotonic and to continue in sleep states
>> on modern Intel CPUs . So why does the gtod->mult change ?
>
> You are missing the fact that gtod->mult/shift are used for CLOCK_MONOTONIC
> and CLOCK_REALTIME, which are adjusted by NTP/PTP to provide network
> synchronized time. That means CLOCK_MONOTONIC is providing accurate
> and slope compensated nanoseconds.
>
> The raw TSC conversion, even if it is sane hardware, provides just some
> approximation of nanoseconds which can be off by quite a margin.
>
>> But the mult value does change. Currently there is no way for user-space
>> programs to discover that such a change has occurred, or when . With this
>> very tiny simple patch, they could know instantly when such changes
>> occur, and could implement TSC readers that perform the full conversion
>> with latencies of 15-30ns (on my CPU).
>
> No. Accessing the mult/shift pair without protection is racy and can lead
> to completely erratic results.
>
>> +notrace static int __always_inline do_monotonic_raw( struct timespec
>> *ts)
>> +{
>> + volatile u32 tsc_lo=0, tsc_hi=0, tsc_cpu=0; // so same instrs
>> generated for 64-bit as for 32-bit builds
>> + u64 ns;
>> + register u64 tsc=0;
>> + if (gtod->vclock_mode == VCLOCK_TSC)
>> + { asm volatile
>> + ( "rdtscp"
>> + : "=a" (tsc_lo)
>> + , "=d" (tsc_hi)
>> + , "=c" (tsc_cpu)
>> + ); // : eax, edx, ecx used - NOT rax, rdx, rcx
>
> If you look at the existing VDSO time getters then you'll notice that
> they use accessor functions and not open coded asm constructs.
>
>> +	 tsc = ((((u64)tsc_hi) & 0xffffffffUL) << 32) | (((u64)tsc_lo)
>> & 0xffffffffUL);
>> +	 tsc *= gtod->mult;
>> +	 tsc >>= gtod->shift;
>> +	 ts->tv_sec = __iter_div_u64_rem(tsc, NSEC_PER_SEC, &ns);
>> +	 ts->tv_nsec = ns;
>
> This is horrible. Please look at the kernel side implementation of
> clock_gettime(CLOCK_MONOTONIC_RAW). The VDSO side can be implemented in the
> same way. All what is required is to expose the relevant information in the
> existing vsyscall_gtod_data data structure.
>
>> +struct linux_timestamp_conversion
>> +{ u32 mult;
>> + u32 shift;
>> +};
>
> This wont happen because unprotected access is bad. But even if it would go
> anywhere defining the structure which should be accessible by user space
> code in the C-file is just wrong. If at all it needs to be defined in a
> user space exposed header.
>
>> +extern
>> + const struct linux_timestamp_conversion *
>> + __vdso_linux_tsc_calibration(void);
>> +
>> +notrace
>> + const struct linux_timestamp_conversion *
>> + __vdso_linux_tsc_calibration(void)
>> +{ if( gtod->vclock_mode == VCLOCK_TSC )
>> + return ((struct linux_timestamp_conversion*) &gtod->mult);
>> + return 0UL;
>
> This is the most horrible coding style I saw in a long time. The kernel has
> a very well defined coding style.....
>
>> That multiplication and shift really doesn't leave very many
>> significant seconds bits!
>
> It's the wrong way to do that.
>
>> Please, can the VDSO include some similar functionality to NOT always
>> enter the kernel for CLOCK_MONOTONIC_RAW ,
>
> Yes, this can be done if properly implemented.
>
>> and to export a pointer to the LIVE (kernel updated) gtod->mult and
>> gtod->shift values somehow .
>
> No. That's not going to happen.
>
>> The documentation states for CLOCK_MONOTONIC_RAW that it is the
>> same as CLOCK_MONOTONIC except it is NOT subject to NTP adjustments .
>> This is very far from the case currently, without a patch like the one
>> above.
>
> Errm. The syscall based implementation provides exactly that, so your claim
> is just wrong.
>
>> And the kernel should not restrict user-space programs to only being able
>> to either measure an NTP adjusted time value, or a time value difference
>> of greater than 1000ns with any accuracy, on a modern Intel CPU whose TSC
>> ticks 2.8 times per nanosecond (picosecond resolution is theoretically
>> possible).
>
> The kernel does not restrict anything. It provides a fast CLOCK_MONOTONIC
> time getter in the VDSO and as nobody so far asked for a fast
> CLOCK_MONOTONIC_RAW time getter, it just has never been implemented. It can
> be done, but it has to be done by following the rules of the VDSO and not
> by randomly exposing data.
>
> Thanks,
>
> 	tglx
>


Thank you very much for your guidance, Thomas.

I will prepare a new patch that meets submission + coding style guidelines and
does not expose pointers within the vsyscall_gtod_data region to
user-space code -
but I don't really understand why not, since only the gtod->mult value will
change as long as the clocksource remains TSC, and updates to it by the kernel
are atomic and partial values cannot be read .

The code in the patch reverts to old behavior for clocks which are not the
TSC and provides a way for users to determine if the  clock is still the TSC
by calling '__vdso_linux_tsc_calibration()', which would return NULL if
the clock is not the TSC .

I have never seen Linux on a modern intel box spontaneously decide to
switch from the TSC clocksource after calibration succeeds and
it has decided to use the TSC as the system / platform clock source -
what would make it do this ?

But for the highly controlled systems I am doing performance testing on,
I can guarantee that the clocksource does not change.

There is no way user code can write those pointers or do anything other
than read them, so I see no harm in exposing them to user-space ; then
user-space programs can issue rdtscp and use the same calibration values
as the kernel, and use some cached 'previous timespec value' to avoid
doing the long division every time.

If the shift & mult are not accurate TSC calibration values, then the
kernel should put other more accurate calibration values in the gtod .

RE:
> Please look at the kernel side implementation of
> clock_gettime(CLOCK_MONOTONIC_RAW).
> The VDSO side can be implemented in the
> same way.
> All what is required is to expose the relevant information in the
> existing vsyscall_gtod_data data structure.

I agree - that is my point entirely , & what I was trying to do .

 The code in the kernel that handles clock_gettime
 CLOCK_MONOTONIC_RAW syscall, when the
 clock source is TSC, does in fact seem to use the mult & shift
 values in the same way :

AFAICS, the call chain for clock_gettime(CLOCK_MONOTONIC_RAW, &ts)
is :

kernel/time/posix-timers.c , @ line 233

static int posix_get_monotonic_raw(clockid_t which_clock, struct timespec64 *tp)
{
	getrawmonotonic64(tp);
	return 0;
}

...
@line 1058:
 SYSCALL_DEFINE2(clock_gettime, const clockid_t, which_clock,
		struct timespec __user *,tp)
{
	const struct k_clock *kc = clockid_to_kclock(which_clock);
	...
	error = kc->clock_get(which_clock, &kernel_tp);
	if (!error && put_timespec64(&kernel_tp, tp))
 ...
}
...
static const struct k_clock clock_monotonic_raw = {
	.clock_getres		= posix_get_hrtimer_res,
	.clock_get		= posix_get_monotonic_raw,
};
...

getmonotonicraw64() is in kernel/time/timekeeping.c , @ line 1418:

void getrawmonotonic64(struct timespec64 *ts)
{
	struct timekeeper *tk = &tk_core.timekeeper;
	unsigned long seq;
	u64 nsecs;

	do {
		seq = read_seqcount_begin(&tk_core.seq);
#                       ^-- I think this is the source of the locking
#                            and the very long latencies !
#
		ts->tv_sec = tk->raw_sec;
		nsecs = timekeeping_get_ns(&tk->tkr_raw);

	} while (read_seqcount_retry(&tk_core.seq, seq));

	ts->tv_nsec = 0;
	timespec64_add_ns(ts, nsecs);
}

this uses, from an earlier part of timekeeping.c , @ line 346:

static inline u64 timekeeping_delta_to_ns(struct tk_read_base *tkr, u64 delta)
{
	u64 nsec;

	nsec = delta * tkr->mult + tkr->xtime_nsec;
	nsec >>= tkr->shift;

	/* If arch requires, add in get_arch_timeoffset() */
	return nsec + arch_gettimeoffset();
}

static inline u64 timekeeping_get_delta(struct tk_read_base *tkr)
{
	u64 cycle_now, delta;

	/* read clocksource */
	cycle_now = tk_clock_read(tkr);

	/* calculate the delta since the last update_wall_time */
	delta = clocksource_delta(cycle_now, tkr->cycle_last, tkr->mask);

	return delta;
}

static inline u64 timekeeping_get_ns(struct tk_read_base *tkr)
{
	u64 delta;

	delta = timekeeping_get_delta(tkr);
	return timekeeping_delta_to_ns(tkr, delta);
}


So the kernel is basically doing, in timekeeping_delta_to_ns :

        nsec_delta = delta * gtod->mult;
	nsec_delta >>= gtod->shift;
        add_nsec_delta_to_previous_value( previous_value, nsec_delta);



So in fact, when the clock source is TSC, the value recorded in 'ts'
by clock_gettime(CLOCK_MONOTONIC_RAW, &ts) is very similar to
      u64 tsc = rdtscp();
      tsc *= gtod->mult;
      tsc >>= gtod->shift;
      ts.tv_sec=tsc / NSEC_PER_SEC;
      ts.tv_nsec=tsc % NSEC_PER_SEC;

which is the algorithm I was using in the VDSO fast TSC reader,
do_monotonic_raw() .

Please, suggest a better algorithm using available data in the
gtod, and I'll use it.

The problem with doing anything more in the VDSO is that there
is of course nowhere in the VDSO to store any data, as it has
no data section or writable pages . So some kind of writable
page would need to be added to the vdso , complicating its
vdso/vma.c, etc., which is not desirable.

But it is equally not desirable to have the clock_gettime
system call have a latency exceeding 300ns for CLOCK_MONOTONIC_RAW
clocks, nor to measure all the adjustments & previous value dependencies
that the current implementation is prone to .

Perhaps I should instead use the calibrated TSC frequency and just do
a multiply divide ?

ie. the calibrated TSC frequency is 2893.300 MHz , so each TSC tick
has a period of  1/2,893,300,000 seconds or 1 / 2.8933 nanoseconds ,
or 3.4562 NS.

So, if that number was communicated somehow to the VDSO, it could do:

 do_monotonic_raw() { ...
       u64 tsc = rdtscp();
       tsc = ((tsc * 1000)  / gtod->pico_period); /* period of clock
in picoseconds */
       ts.tv_sec=tsc / NSEC_PER_SEC;
       ts.tv_nsec=tsc % NSEC_PER_SEC;
}

But there is no other communication of TSC calibration data currently
in the gtod
other than 'shift' and 'mult' ,which do actually give results which correlate
approximately to the pico_period division above.

Attempts to change the vsyscall_gtod_data structure in any way have resulted
in nasty core dumps of clock_gettime() using processes.
I'd much appreciate any tips on how to change its layout without breaking
everything.

One currently needs to parse the system log messages to get the
'Refined TSC clocksource calibration', or lookup its value in the
live kernel by looking up the 'tsc_khz' symbol at its
address given in System.map  with gdb / objdump ,
converting to offset into data region, and using
lseek() on /proc/kcore (as root).

The point is, user-space must rely on the kernel to perform
TSC calibration properly, and the only data in the gtod that
reflects the result of that calibration are the mult and shift values.
If linux wants to support user-space TSC readers, it needs to communicate
the TSC calibration somehow in the VDSO gtod area.

I've been getting good low-latency time values using my current patch under both
Linux 4.15.7 and 3.10.0-693.17.1.el7.jvd - I've attached a log of 100
consecutive
calls and a printout of the sum and averages :

#define N_SAMPLES 10

  unsigned int cnt=N_SAMPLES, s=0;
  do
    clock_gettime( CLOCK_MONOTONIC_RAW, &sample_ts[s++] );
  while(--cnt);
#define TS2NS(_TS_) ((((unsigned long
long)(_TS_).tv_sec)*1000000000ULL) + (((unsigned long
long)((_TS_).tv_nsec))))
  unsigned long long sum = 0;
  std::cerr <<  sample_ts[0].tv_sec << " " << sample_ts[0].tv_nsec <<
std::endl;
  for( s=1; s< N_SAMPLES; s+=1)
  { sum += TS2NS(sample_ts[s]) - TS2NS(sample_ts[s-1]);
    std::cerr <<  sample_ts[s].tv_sec << " " << sample_ts[s].tv_nsec
<< std::endl;
  }
  std::cerr << "Sum: " << sum  << " avg: " << (sum/N_SAMPLES) << std::endl;


I enclose a log of the above program's output (tts.log) .


The print outs of the timespec structure values show monotonically increasing
values with very similar deltas (@ 16ns in this case) , eg:
       871 255831891
       871 255831911
       871 255831928
       871 255831949
       871 255831966
       871 255831986
       871 255832004
and end with a low latency average (minimum measurable time):
       Sum: 1920 avg: 19

The deltas for clock_gettime(CLOCK_MONOTONIC_RAW) under a kernel
without the patch are @ 300-700ns  :

$ ./timer
sum: 69234
Total time: 0.000069234S - Average Latency: 0.000000692S

The timer program source is also attached, as are the patches
for linux-4.15.7 and 3.10.0 I am testing with .

I've also attached the user-space tsc-reading
  'clock_get_time_raw()' function (in test_vdso_tsc.c) ,
which illustrates user-space use of the TSC calibration
shift and mult in the gtod, and a way to avoid long division
every time, which achieves much lower latencies than
the VDSO do_monotonic_raw() function .


Sorry, but I urgently need to use the TSC from user-space to
obtain nanosecond resolution unadjusted timer values,
with latencies of less than 30ns,
which are comparable to those returned by linux , and
this appears to be the only way to do it .

Please, if there is a better way to read the TSC and convert
its value in the same way linux does, using its calibration, and
rendering comparable results, but in user-space, let me know
and I'll  use it .

And please consider SOME patch to the VDSO to implement
user-space TSC reading on the intel / AMD , to return a completely
unadjusted value for CLOCK_MONOTONIC_RAW, as
documented, but not as Linux currently does.

BTW, reading the Documentation/process/submitting-patches.rst file:
       6) No MIME, no links, no compression, no attachments.  Just plain text
       ...
       For this reason, all patches should be submitted by e-mail "inline".
       Be wary of your editor's word-wrap corrupting your patch,
       if you choose to cut-n-paste your patch.
       Do not attach the patch as a MIME attachment, compressed or not.

So I'm a bit confused as to how to attach patches.
How do you attach a patch without mime ?
Where is the inline patch submission format defined ?
BTW, it is not my 'editor's word-wrap corruping your patch', it is the
Gmail IMAP server, which believes all lines in plain-text messages
must be wrapped to 72 characters max, and  enforces this belief,
correct or not.  I think kernel.org needs to update its tools to parse
mime attachments or handle email server  line-wrapping, which I have
no control over - I wish I could move from the gmail server, but it would
be too much trouble.

Thanks & Best Regards,
Jason

--f40304355c44d2355b0566c18f9d
Content-Type: text/plain; charset="US-ASCII"; name="tts.log"
Content-Disposition: attachment; filename="tts.log"
Content-Transfer-Encoding: base64
X-Attachment-Id: file1

SGlnaCBSZXNvbHV0aW9uIFRpbWVTdGFtcHMgRW5hYmxlZCAtIEdvdCBUU0MgY2FsaWJyYXRpb24g
QCAweGZmZmZmZmZmZmY1ZmYwYTA6IG11bHQ6IDQ5NDU3NTcgc2hpZnQ6IDI0Cjg3MSAyNTU4MzEy
MzYKODcxIDI1NTgzMTI4MQo4NzEgMjU1ODMxMzE5Cjg3MSAyNTU4MzEzNDcKODcxIDI1NTgzMTM2
NQo4NzEgMjU1ODMxMzgzCjg3MSAyNTU4MzE0MDEKODcxIDI1NTgzMTQyMAo4NzEgMjU1ODMxNDM4
Cjg3MSAyNTU4MzE0NTgKODcxIDI1NTgzMTQ3Ngo4NzEgMjU1ODMxNDk2Cjg3MSAyNTU4MzE1MTMK
ODcxIDI1NTgzMTUzMwo4NzEgMjU1ODMxNTUxCjg3MSAyNTU4MzE1NzEKODcxIDI1NTgzMTU4OQo4
NzEgMjU1ODMxNjA5Cjg3MSAyNTU4MzE2MjcKODcxIDI1NTgzMTY0Nwo4NzEgMjU1ODMxNjY0Cjg3
MSAyNTU4MzE2ODQKODcxIDI1NTgzMTcwMgo4NzEgMjU1ODMxNzIyCjg3MSAyNTU4MzE3NDAKODcx
IDI1NTgzMTc2MAo4NzEgMjU1ODMxNzc4Cjg3MSAyNTU4MzE3OTgKODcxIDI1NTgzMTgxNQo4NzEg
MjU1ODMxODM1Cjg3MSAyNTU4MzE4NTMKODcxIDI1NTgzMTg3Mwo4NzEgMjU1ODMxODkxCjg3MSAy
NTU4MzE5MTEKODcxIDI1NTgzMTkyOAo4NzEgMjU1ODMxOTQ5Cjg3MSAyNTU4MzE5NjYKODcxIDI1
NTgzMTk4Ngo4NzEgMjU1ODMyMDA0Cjg3MSAyNTU4MzIwMjQKODcxIDI1NTgzMjA0Mgo4NzEgMjU1
ODMyMDYyCjg3MSAyNTU4MzIwNzkKODcxIDI1NTgzMjA5OQo4NzEgMjU1ODMyMTE3Cjg3MSAyNTU4
MzIxMzcKODcxIDI1NTgzMjE1NQo4NzEgMjU1ODMyMTc1Cjg3MSAyNTU4MzIxOTMKODcxIDI1NTgz
MjIxMwo4NzEgMjU1ODMyMjMwCjg3MSAyNTU4MzIyNTAKODcxIDI1NTgzMjI2OAo4NzEgMjU1ODMy
Mjg4Cjg3MSAyNTU4MzIzMDYKODcxIDI1NTgzMjMyNgo4NzEgMjU1ODMyMzQ0Cjg3MSAyNTU4MzIz
NjQKODcxIDI1NTgzMjM4MQo4NzEgMjU1ODMyNDAxCjg3MSAyNTU4MzI0MTkKODcxIDI1NTgzMjQz
OQo4NzEgMjU1ODMyNDU3Cjg3MSAyNTU4MzI0NzcKODcxIDI1NTgzMjQ5NAo4NzEgMjU1ODMyNTE1
Cjg3MSAyNTU4MzI1MzIKODcxIDI1NTgzMjU1Mgo4NzEgMjU1ODMyNTcwCjg3MSAyNTU4MzI1OTAK
ODcxIDI1NTgzMjYwOAo4NzEgMjU1ODMyNjI4Cjg3MSAyNTU4MzI2NDUKODcxIDI1NTgzMjY2NQo4
NzEgMjU1ODMyNjgzCjg3MSAyNTU4MzI3MDMKODcxIDI1NTgzMjcyMQo4NzEgMjU1ODMyNzQxCjg3
MSAyNTU4MzI3NTkKODcxIDI1NTgzMjc3OQo4NzEgMjU1ODMyNzk2Cjg3MSAyNTU4MzI4MTYKODcx
IDI1NTgzMjgzNAo4NzEgMjU1ODMyODU0Cjg3MSAyNTU4MzI4NzIKODcxIDI1NTgzMjg5Mgo4NzEg
MjU1ODMyOTEwCjg3MSAyNTU4MzI5MzAKODcxIDI1NTgzMjk0Nwo4NzEgMjU1ODMyOTY3Cjg3MSAy
NTU4MzI5ODUKODcxIDI1NTgzMzAwNQo4NzEgMjU1ODMzMDIzCjg3MSAyNTU4MzMwNDMKODcxIDI1
NTgzMzA2MAo4NzEgMjU1ODMzMDgxCjg3MSAyNTU4MzMwOTgKODcxIDI1NTgzMzExOAo4NzEgMjU1
ODMzMTM2Cjg3MSAyNTU4MzMxNTYKU3VtOiAxOTIwIGF2ZzogMTkKCg==
--f40304355c44d2355b0566c18f9d
Content-Type: text/x-csrc; charset="US-ASCII"; name="timer.c"
Content-Disposition: attachment; filename="timer.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: file2

LyogCiAqIFByb2dyYW0gdG8gbWVhc3VyZSBoaWdoLXJlcyB0aW1lciBsYXRlbmN5LgogKgogKi8K
I2luY2x1ZGUgPHN0ZGludC5oPgojaW5jbHVkZSA8c3RkYm9vbC5oPgojaW5jbHVkZSA8c3lzL3R5
cGVzLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KI2luY2x1ZGUgPHRpbWUuaD4KI2luY2x1ZGUgPGVy
cm5vLmg+CiNpbmNsdWRlIDxzdHJpbmcuaD4KI2luY2x1ZGUgPHN0ZGlvLmg+CgojaWZuZGVmIE5f
U0FNUExFUwojZGVmaW5lIE5fU0FNUExFUyAxMDAKI2VuZGlmCgoKaW50IG1haW4oaW50IGFyZ2Ms
IGNoYXIgKmNvbnN0KiBhcmd2LCBjaGFyICpjb25zdCogZW52cCkKeyBjbG9ja2lkX3QgY2xrID0g
Q0xPQ0tfTU9OT1RPTklDX1JBVzsKICBpZigoYXJnYyA+IDEpICYmIChhcmd2WzFdICE9IE5VTEwp
ICYmICgwID09IHN0cmNtcChhcmd2WzFdLCItbSIpKSkKICAgIGNsayA9IENMT0NLX01PTk9UT05J
QzsgIAogIHN0cnVjdCB0aW1lc3BlYyBzYW1wbGVbTl9TQU1QTEVTKzFdOwogIHVuc2lnbmVkIGlu
dCBjbnQ9Tl9TQU1QTEVTLCBzPTAgOwogIGRvCiAgeyBpZiggMCAhPSBjbG9ja19nZXR0aW1lKENM
T0NLX01PTk9UT05JQ19SQVcsICZzYW1wbGVbcysrXSkgKQogICAgeyBmcHJpbnRmKHN0ZGVyciwi
b29wcywgY2xvY2tfZ2V0dGltZSgpIGZhaWxlZDogJWQ6ICclcycuXG4iLCBlcnJubywgc3RyZXJy
b3IoZXJybm8pKTsKICAgICAgcmV0dXJuIDE7CiAgICB9CiAgfXdoaWxlKCAtLWNudCApOwogIGNs
b2NrX2dldHRpbWUoQ0xPQ0tfTU9OT1RPTklDX1JBVywgJnNhbXBsZVtzXSk7CiNkZWZpbmUgVFMy
TlMoX1RTXykgKCgoKHVuc2lnbmVkIGxvbmcgbG9uZykoX1RTXykudHZfc2VjKSoxMDAwMDAwMDAw
VUxMKSArICgoKHVuc2lnbmVkIGxvbmcgbG9uZykoKF9UU18pLnR2X25zZWMpKSkpIAogIHVuc2ln
bmVkIGxvbmcgbG9uZwogICAgZGVsdGFzIFsgTl9TQU1QTEVTIF0KICAsIHQxLCB0Miwgc3VtPTAK
ICAsIHRfc3RhcnQgPSBUUzJOUyhzYW1wbGVbMF0pOwogIGZvcihzPTE7IHMgPCAoTl9TQU1QTEVT
KzEpOyBzKz0xKQogIHsgdDEgPSBUUzJOUyhzYW1wbGVbcy0xXSk7CiAgICB0MiA9IFRTMk5TKHNh
bXBsZVtzXSk7CiAgICBkZWx0YXNbcy0xXT10Mi10MTsKICB9ICAKICBmb3IocyA9IDA7IHMgPCBO
X1NBTVBMRVM7IHMrPTEpCiAgICBzdW0gKz0gZGVsdGFzW3NdOwogIGZwcmludGYoc3RkZXJyLCJz
dW06ICVsbHVcbiIsc3VtKTsKICB1bnNpZ25lZCBsb25nIGxvbmcgYXZnX25zID0gc3VtIC8gTl9T
QU1QTEVTOwogIHQxPSh0MiAtIHRfc3RhcnQpOwogIGZwcmludGYoc3RkZXJyLAoJICAiVG90YWwg
dGltZTogJTEuMWxsdS4lOS45bGx1UyAtIEF2ZXJhZ2UgTGF0ZW5jeTogJTEuMWxsdS4lOS45bGx1
U1xuIiwKICAgICAgICAgIHQxLzEwMDAwMDAwMDAsICAgICAgIHQxLSgodDEvMTAwMDAwMDAwMCkq
MTAwMDAwMDAwMCksCiAgICAgICAgICBhdmdfbnMvMTAwMDAwMDAwMCwgICBhdmdfbnMtKChhdmdf
bnMvMTAwMDAwMDAwMCkqMTAwMDAwMDAwMCkgICAKCSAgKTsJICAKICByZXR1cm4gMDsKfQoK
--f40304355c44d2355b0566c18f9d
Content-Type: application/octet-stream;
	name="vdso-vclock_gettime-4.15.7.patch"
Content-Disposition: attachment; filename="vdso-vclock_gettime-4.15.7.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: file3

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2VudHJ5L3Zkc28vdmNsb2NrX2dldHRpbWUuYyBiL2FyY2gv
eDg2L2VudHJ5L3Zkc28vdmNsb2NrX2dldHRpbWUuYwppbmRleCBmMTk4NTZkLi42M2Y1ZjE4IDEw
MDY0NAotLS0gYS9hcmNoL3g4Ni9lbnRyeS92ZHNvL3ZjbG9ja19nZXR0aW1lLmMKKysrIGIvYXJj
aC94ODYvZW50cnkvdmRzby92Y2xvY2tfZ2V0dGltZS5jCkBAIC0yNDYsNiArMjQ2LDI4IEBAIG5v
dHJhY2Ugc3RhdGljIGludCBfX2Fsd2F5c19pbmxpbmUgZG9fbW9ub3RvbmljKHN0cnVjdCB0aW1l
c3BlYyAqdHMpCiAJcmV0dXJuIG1vZGU7CiB9CiAKK25vdHJhY2Ugc3RhdGljIGludCBfX2Fsd2F5
c19pbmxpbmUgZG9fbW9ub3RvbmljX3Jhdyggc3RydWN0IHRpbWVzcGVjICp0cykKK3sgICAgICAg
CisgICAgICAgIHZvbGF0aWxlIHUzMiB0c2NfbG89MCwgdHNjX2hpPTAsIHRzY19jcHU9MDsgLy8g
c28gc2FtZSBpbnN0cnMgZ2VuZXJhdGVkIGZvciA2NC1iaXQgYXMgZm9yIDMyLWJpdCBidWlsZHMK
KyAgICAgICAgdTY0IG5zOworICAgICAgICByZWdpc3RlciB1NjQgdHNjPTA7CisgICAgICAgIGlm
IChndG9kLT52Y2xvY2tfbW9kZSA9PSBWQ0xPQ0tfVFNDKQorICAgICAgICB7IGFzbSB2b2xhdGls
ZQorICAgICAgICAgICAgKCAicmR0c2NwIgorICAgICAgICAgICAgOiAiPWEiICh0c2NfbG8pCisg
ICAgICAgICAgICAsICI9ZCIgKHRzY19oaSkKKyAgICAgICAgICAgICwgIj1jIiAodHNjX2NwdSkK
KyAgICAgICAgICAgICk7IC8vIDogZWF4LCBlZHgsIGVjeCB1c2VkIC0gTk9UIHJheCwgcmR4LCBy
Y3gKKwkgIHRzYyAgICAgPSAoKCgodTY0KXRzY19oaSkgJiAweGZmZmZmZmZmVUwpIDw8IDMyKSB8
ICgoKHU2NCl0c2NfbG8pICYgMHhmZmZmZmZmZlVMKTsKKwkgIHRzYyAgICAqPSBndG9kLT5tdWx0
OworCSAgdHNjICAgPj49IGd0b2QtPnNoaWZ0OworCSAgdHMtPnR2X3NlYyAgPSBfX2l0ZXJfZGl2
X3U2NF9yZW0odHNjLCBOU0VDX1BFUl9TRUMsICZucyk7ICAgICAgICAgICAgCisJICB0cy0+dHZf
bnNlYyA9IG5zOyAgICAgICAgICAKKwkgIHJldHVybiBWQ0xPQ0tfVFNDOworICAgICAgICB9Cisg
ICAgICAgIHJldHVybiBWQ0xPQ0tfTk9ORTsKK30KKwogbm90cmFjZSBzdGF0aWMgdm9pZCBkb19y
ZWFsdGltZV9jb2Fyc2Uoc3RydWN0IHRpbWVzcGVjICp0cykKIHsKIAl1bnNpZ25lZCBsb25nIHNl
cTsKQEAgLTI3Nyw2ICsyOTksMTAgQEAgbm90cmFjZSBpbnQgX192ZHNvX2Nsb2NrX2dldHRpbWUo
Y2xvY2tpZF90IGNsb2NrLCBzdHJ1Y3QgdGltZXNwZWMgKnRzKQogCQlpZiAoZG9fbW9ub3Rvbmlj
KHRzKSA9PSBWQ0xPQ0tfTk9ORSkKIAkJCWdvdG8gZmFsbGJhY2s7CiAJCWJyZWFrOworCWNhc2Ug
Q0xPQ0tfTU9OT1RPTklDX1JBVzoKKwkJaWYgKGRvX21vbm90b25pY19yYXcodHMpID09IFZDTE9D
S19OT05FKQorCQkJZ290byBmYWxsYmFjazsKKwkJYnJlYWs7CiAJY2FzZSBDTE9DS19SRUFMVElN
RV9DT0FSU0U6CiAJCWRvX3JlYWx0aW1lX2NvYXJzZSh0cyk7CiAJCWJyZWFrOwpAQCAtMzI2LDMg
KzM1MiwyNSBAQCBub3RyYWNlIHRpbWVfdCBfX3Zkc29fdGltZSh0aW1lX3QgKnQpCiB9CiB0aW1l
X3QgdGltZSh0aW1lX3QgKnQpCiAJX19hdHRyaWJ1dGVfXygod2VhaywgYWxpYXMoIl9fdmRzb190
aW1lIikpKTsKKworCitzdHJ1Y3QgbGludXhfdGltZXN0YW1wX2NvbnZlcnNpb24KK3sgdTMyICBt
dWx0OworICB1MzIgIHNoaWZ0OworfTsKKworZXh0ZXJuCisgIGNvbnN0IHN0cnVjdCBsaW51eF90
aW1lc3RhbXBfY29udmVyc2lvbiAqCisgIF9fdmRzb19saW51eF90c2NfY2FsaWJyYXRpb24odm9p
ZCk7CisKK25vdHJhY2UKKyAgY29uc3Qgc3RydWN0IGxpbnV4X3RpbWVzdGFtcF9jb252ZXJzaW9u
ICoKKyAgX192ZHNvX2xpbnV4X3RzY19jYWxpYnJhdGlvbih2b2lkKQoreyBpZiggZ3RvZC0+dmNs
b2NrX21vZGUgPT0gVkNMT0NLX1RTQyApIAorICAgIHJldHVybiAoKHN0cnVjdCBsaW51eF90aW1l
c3RhbXBfY29udmVyc2lvbiopICZndG9kLT5tdWx0KTsKKyAgcmV0dXJuIDBVTDsKK30KKworY29u
c3Qgc3RydWN0IGxpbnV4X3RpbWVzdGFtcF9jb252ZXJzaW9uICoKKyAgbGludXhfdHNjX2NhbGli
cmF0aW9uKHZvaWQpIF9fYXR0cmlidXRlKCh3ZWFrLCBhbGlhcygiX192ZHNvX2xpbnV4X3RzY19j
YWxpYnJhdGlvbiIpKSk7CisKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2VudHJ5L3Zkc28vdmRzby5s
ZHMuUyBiL2FyY2gveDg2L2VudHJ5L3Zkc28vdmRzby5sZHMuUwppbmRleCBkM2EyZGNlLi40MWEy
Y2E1IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9lbnRyeS92ZHNvL3Zkc28ubGRzLlMKKysrIGIvYXJj
aC94ODYvZW50cnkvdmRzby92ZHNvLmxkcy5TCkBAIC0yNCw3ICsyNCw5IEBAIFZFUlNJT04gewog
CQlnZXRjcHU7CiAJCV9fdmRzb19nZXRjcHU7CiAJCXRpbWU7Ci0JCV9fdmRzb190aW1lOworCSAg
ICAgICAgX192ZHNvX3RpbWU7CisgICAgICAgICAgICAgICAgbGludXhfdHNjX2NhbGlicmF0aW9u
OworCQlfX3Zkc29fbGludXhfdHNjX2NhbGlicmF0aW9uOwogCWxvY2FsOiAqOwogCX07CiB9CmRp
ZmYgLS1naXQgYS9hcmNoL3g4Ni9lbnRyeS92ZHNvL3Zkc28zMi92ZHNvMzIubGRzLlMgYi9hcmNo
L3g4Ni9lbnRyeS92ZHNvL3Zkc28zMi92ZHNvMzIubGRzLlMKaW5kZXggNDIyNzY0YS4uZDUzYmQ3
MyAxMDA2NDQKLS0tIGEvYXJjaC94ODYvZW50cnkvdmRzby92ZHNvMzIvdmRzbzMyLmxkcy5TCisr
KyBiL2FyY2gveDg2L2VudHJ5L3Zkc28vdmRzbzMyL3Zkc28zMi5sZHMuUwpAQCAtMjUsNyArMjUs
OCBAQCBWRVJTSU9OCiAJZ2xvYmFsOgogCQlfX3Zkc29fY2xvY2tfZ2V0dGltZTsKIAkJX192ZHNv
X2dldHRpbWVvZmRheTsKLQkJX192ZHNvX3RpbWU7CisJICAgICAgICBfX3Zkc29fdGltZTsKKyAg
ICAgICAgICAgICAgICBfX3Zkc29fbGludXhfdHNjX2NhbGlicmF0aW9uOwogCX07CiAKIAlMSU5V
WF8yLjUgewpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvZW50cnkvdmRzby92ZHNveDMyLmxkcy5TIGIv
YXJjaC94ODYvZW50cnkvdmRzby92ZHNveDMyLmxkcy5TCmluZGV4IDA1Y2QxYzUuLmZiMTNiMTYg
MTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2VudHJ5L3Zkc28vdmRzb3gzMi5sZHMuUworKysgYi9hcmNo
L3g4Ni9lbnRyeS92ZHNvL3Zkc294MzIubGRzLlMKQEAgLTIwLDcgKzIwLDggQEAgVkVSU0lPTiB7
CiAJCV9fdmRzb19jbG9ja19nZXR0aW1lOwogCQlfX3Zkc29fZ2V0dGltZW9mZGF5OwogCQlfX3Zk
c29fZ2V0Y3B1OwotCQlfX3Zkc29fdGltZTsKKwkgICAgICAgIF9fdmRzb190aW1lOworICAgICAg
ICAgICAgICAgIF9fdmRzb19saW51eF90c2NfY2FsaWJyYXRpb247CiAJbG9jYWw6ICo7CiAJfTsK
IH0K
--f40304355c44d2355b0566c18f9d
Content-Type: application/octet-stream;
	name="linux-3.10.0-693.17.1.el7.jvd.vdso_vclock_gettime.patch"
Content-Disposition: attachment;
	filename="linux-3.10.0-693.17.1.el7.jvd.vdso_vclock_gettime.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: file4

ZGlmZiAtdXAga2VybmVsLTMuMTAuMC02OTMuMTcuMS5lbDcvbGludXgtMy4xMC4wLTY5My4xNy4x
LmVsNy54ODZfNjQvYXJjaC94ODYvdmRzby92Y2xvY2tfZ2V0dGltZS5jLjMuMTAuMC02OTMuMTcu
MS5lbDcga2VybmVsLTMuMTAuMC02OTMuMTcuMS5lbDcvbGludXgtMy4xMC4wLTY5My4xNy4xLmVs
Ny54ODZfNjQvYXJjaC94ODYvdmRzby92Y2xvY2tfZ2V0dGltZS5jCi0tLSBrZXJuZWwtMy4xMC4w
LTY5My4xNy4xLmVsNy9saW51eC0zLjEwLjAtNjkzLjE3LjEuZWw3Lng4Nl82NC9hcmNoL3g4Ni92
ZHNvL3ZjbG9ja19nZXR0aW1lLmMuMy4xMC4wLTY5My4xNy4xLmVsNwkyMDE4LTAxLTE0IDE1OjAy
OjU0LjAwMDAwMDAwMCArMDAwMAorKysga2VybmVsLTMuMTAuMC02OTMuMTcuMS5lbDcvbGludXgt
My4xMC4wLTY5My4xNy4xLmVsNy54ODZfNjQvYXJjaC94ODYvdmRzby92Y2xvY2tfZ2V0dGltZS5j
CTIwMTgtMDMtMDUgMTM6MjE6NTYuODM4Nzg0MjE3ICswMDAwCkBAIC0yMDAsNiArMjAwLDI4IEBA
IG5vdHJhY2Ugc3RhdGljIGludCBkb19tb25vdG9uaWMoc3RydWN0IHQKIAlyZXR1cm4gbW9kZTsK
IH0KIAorbm90cmFjZSBzdGF0aWMgaW50IGRvX21vbm90b25pY19yYXcoIHN0cnVjdCB0aW1lc3Bl
YyAqdHMpCit7ICAgICAgIAorICAgICAgICB2b2xhdGlsZSB1MzIgdHNjX2xvPTAsIHRzY19oaT0w
LCB0c2NfY3B1PTA7IC8vIHNvIHNhbWUgaW5zdHJzIGdlbmVyYXRlZCBmb3IgNjQtYml0IGFzIGZv
ciAzMi1iaXQgYnVpbGRzCisgICAgICAgIHU2NCBuczsKKyAgICAgICAgcmVnaXN0ZXIgdTY0IHRz
Yz0wOworICAgICAgICBpZiAoZ3RvZC0+Y2xvY2sudmNsb2NrX21vZGUgPT0gVkNMT0NLX1RTQykK
KyAgICAgICAgeyBhc20gdm9sYXRpbGUKKyAgICAgICAgICAgICggInJkdHNjcCIKKyAgICAgICAg
ICAgIDogIj1hIiAodHNjX2xvKQorICAgICAgICAgICAgLCAiPWQiICh0c2NfaGkpCisgICAgICAg
ICAgICAsICI9YyIgKHRzY19jcHUpCisgICAgICAgICAgICApOyAvLyA6IGVheCwgZWR4LCBlY3gg
dXNlZCAtIE5PVCByYXgsIHJkeCwgcmN4CisJICB0c2MgICAgID0gKCgoKHU2NCl0c2NfaGkpICYg
MHhmZmZmZmZmZlVMKSA8PCAzMikgfCAoKCh1NjQpdHNjX2xvKSAmIDB4ZmZmZmZmZmZVTCk7CisJ
ICB0c2MgICAgKj0gZ3RvZC0+Y2xvY2subXVsdDsKKwkgIHRzYyAgID4+PSBndG9kLT5jbG9jay5z
aGlmdDsKKwkgIHRzLT50dl9zZWMgID0gX19pdGVyX2Rpdl91NjRfcmVtKHRzYywgTlNFQ19QRVJf
U0VDLCAmbnMpOyAgICAgICAgICAgIAorCSAgdHMtPnR2X25zZWMgPSBuczsgICAgICAgICAgCisJ
ICByZXR1cm4gVkNMT0NLX1RTQzsKKyAgICAgICAgfQorICAgICAgICByZXR1cm4gVkNMT0NLX05P
TkU7Cit9CisKIG5vdHJhY2Ugc3RhdGljIGludCBkb19yZWFsdGltZV9jb2Fyc2Uoc3RydWN0IHRp
bWVzcGVjICp0cykKIHsKIAl1bnNpZ25lZCBsb25nIHNlcTsKQEAgLTIzNCw2ICsyNTYsOSBAQCBu
b3RyYWNlIGludCBfX3Zkc29fY2xvY2tfZ2V0dGltZShjbG9ja2lkCiAJY2FzZSBDTE9DS19NT05P
VE9OSUM6CiAJCXJldCA9IGRvX21vbm90b25pYyh0cyk7CiAJCWJyZWFrOworCWNhc2UgQ0xPQ0tf
TU9OT1RPTklDX1JBVzoKKwkJcmV0ID0gZG9fbW9ub3RvbmljX3Jhdyh0cyk7CisJCWJyZWFrOwog
CWNhc2UgQ0xPQ0tfUkVBTFRJTUVfQ09BUlNFOgogCQlyZXR1cm4gZG9fcmVhbHRpbWVfY29hcnNl
KHRzKTsKIAljYXNlIENMT0NLX01PTk9UT05JQ19DT0FSU0U6CkBAIC0yODYsMyArMzExLDI0IEBA
IG5vdHJhY2UgdGltZV90IF9fdmRzb190aW1lKHRpbWVfdCAqdCkKIH0KIGludCB0aW1lKHRpbWVf
dCAqdCkKIAlfX2F0dHJpYnV0ZV9fKCh3ZWFrLCBhbGlhcygiX192ZHNvX3RpbWUiKSkpOworCitz
dHJ1Y3QgbGludXhfdGltZXN0YW1wX2NvbnZlcnNpb24KK3sgdTMyICBtdWx0OworICB1MzIgIHNo
aWZ0OworfTsKKworZXh0ZXJuCisgIGNvbnN0IHN0cnVjdCBsaW51eF90aW1lc3RhbXBfY29udmVy
c2lvbiAqCisgIF9fdmRzb19saW51eF90c2NfY2FsaWJyYXRpb24odm9pZCk7CisKK25vdHJhY2UK
KyAgY29uc3Qgc3RydWN0IGxpbnV4X3RpbWVzdGFtcF9jb252ZXJzaW9uICoKKyAgX192ZHNvX2xp
bnV4X3RzY19jYWxpYnJhdGlvbih2b2lkKQoreyBpZiggZ3RvZC0+Y2xvY2sudmNsb2NrX21vZGUg
PT0gVkNMT0NLX1RTQyApIAorICAgIHJldHVybiAoKHN0cnVjdCBsaW51eF90aW1lc3RhbXBfY29u
dmVyc2lvbiopICZndG9kLT5jbG9jay5tdWx0KTsKKyAgcmV0dXJuIDBVTDsKK30KKworY29uc3Qg
c3RydWN0IGxpbnV4X3RpbWVzdGFtcF9jb252ZXJzaW9uICoKKyAgbGludXhfdHNjX2NhbGlicmF0
aW9uKHZvaWQpIF9fYXR0cmlidXRlKCh3ZWFrLCBhbGlhcygiX192ZHNvX2xpbnV4X3RzY19jYWxp
YnJhdGlvbiIpKSk7CisKZGlmZiAtdXAga2VybmVsLTMuMTAuMC02OTMuMTcuMS5lbDcvbGludXgt
My4xMC4wLTY5My4xNy4xLmVsNy54ODZfNjQvYXJjaC94ODYvdmRzby92ZHNvLmxkcy5TLjMuMTAu
MC02OTMuMTcuMS5lbDcga2VybmVsLTMuMTAuMC02OTMuMTcuMS5lbDcvbGludXgtMy4xMC4wLTY5
My4xNy4xLmVsNy54ODZfNjQvYXJjaC94ODYvdmRzby92ZHNvLmxkcy5TCi0tLSBrZXJuZWwtMy4x
MC4wLTY5My4xNy4xLmVsNy9saW51eC0zLjEwLjAtNjkzLjE3LjEuZWw3Lng4Nl82NC9hcmNoL3g4
Ni92ZHNvL3Zkc28ubGRzLlMuMy4xMC4wLTY5My4xNy4xLmVsNwkyMDE4LTAxLTE0IDE1OjAyOjU0
LjAwMDAwMDAwMCArMDAwMAorKysga2VybmVsLTMuMTAuMC02OTMuMTcuMS5lbDcvbGludXgtMy4x
MC4wLTY5My4xNy4xLmVsNy54ODZfNjQvYXJjaC94ODYvdmRzby92ZHNvLmxkcy5TCTIwMTgtMDMt
MDUgMTM6MjI6MjIuMTg5ODQ2NDg5ICswMDAwCkBAIC0yMyw4ICsyMywxMCBAQCBWRVJTSU9OIHsK
IAkJX192ZHNvX2dldHRpbWVvZmRheTsKIAkJZ2V0Y3B1OwogCQlfX3Zkc29fZ2V0Y3B1OwotCQl0
aW1lOworCSAgICAgICAgdGltZTsKIAkJX192ZHNvX3RpbWU7CisJCWxpbnV4X3RzY19jYWxpYnJh
dGlvbjsKKwkgCV9fdmRzb19saW51eF90c2NfY2FsaWJyYXRpb247CiAJbG9jYWw6ICo7CiAJfTsK
IH0KZGlmZiAtdXAga2VybmVsLTMuMTAuMC02OTMuMTcuMS5lbDcvbGludXgtMy4xMC4wLTY5My4x
Ny4xLmVsNy54ODZfNjQvYXJjaC94ODYvdmRzby92ZHNveDMyLmxkcy5TLjMuMTAuMC02OTMuMTcu
MS5lbDcga2VybmVsLTMuMTAuMC02OTMuMTcuMS5lbDcvbGludXgtMy4xMC4wLTY5My4xNy4xLmVs
Ny54ODZfNjQvYXJjaC94ODYvdmRzby92ZHNveDMyLmxkcy5TCi0tLSBrZXJuZWwtMy4xMC4wLTY5
My4xNy4xLmVsNy9saW51eC0zLjEwLjAtNjkzLjE3LjEuZWw3Lng4Nl82NC9hcmNoL3g4Ni92ZHNv
L3Zkc294MzIubGRzLlMuMy4xMC4wLTY5My4xNy4xLmVsNwkyMDE4LTAxLTE0IDE1OjAyOjU0LjAw
MDAwMDAwMCArMDAwMAorKysga2VybmVsLTMuMTAuMC02OTMuMTcuMS5lbDcvbGludXgtMy4xMC4w
LTY5My4xNy4xLmVsNy54ODZfNjQvYXJjaC94ODYvdmRzby92ZHNveDMyLmxkcy5TCTIwMTgtMDMt
MDUgMTM6MjI6NDcuNDUyMTk2MDMxICswMDAwCkBAIC0yMSw2ICsyMSw3IEBAIFZFUlNJT04gewog
CQlfX3Zkc29fZ2V0dGltZW9mZGF5OwogCQlfX3Zkc29fZ2V0Y3B1OwogCQlfX3Zkc29fdGltZTsK
KwkgICAgICAgIF9fdmRzb19saW51eF90c2NfY2FsaWJyYXRpb247CQogCWxvY2FsOiAqOwogCX07
CiB9Cg==
--f40304355c44d2355b0566c18f9d
Content-Type: text/x-csrc; charset="US-ASCII"; name="test_vdso_tsc.c"
Content-Disposition: attachment; filename="test_vdso_tsc.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: file5

LyogCiAqIHRoaXMgYSBhIGNvcHkgb2YgCiAqICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy92RFNP
L3BhcnNlX3Zkc28uYwogKiBmcm9tIHRoZSBMaW51eCBrZXJuZWwgdHJlZSwgd2l0aCBhIGxpdHRs
ZSBtYWluKCkgZnVuY3Rpb24gYXQgdGhlIGVuZAogKiB3aGljaCB1c2VzIHRoZSBuZXcgJ19fdmRz
b19saW51eF90c2NfY2FsaWJyYXRpb24nIGZ1bmN0aW9uIHRvIGdldCBhIHBvaW50ZXIgdG8KICog
dGhlIGtlcm5lbCBtYWludGFpbmVkIGNsb2Nrc291cmNlIG11bHQgYW5kIHNoaWZ0IHZhbHVlcyBp
biB0aGUgdnN5c2NhbGxfZ3RvZF9kYXRhIDogCiAqLwojaW5jbHVkZSA8c3RkYm9vbC5oPgojaW5j
bHVkZSA8c3RkaW50Lmg+CiNpbmNsdWRlIDxsaW1pdHMuaD4KI2luY2x1ZGUgPHRpbWUuaD4KI2lu
Y2x1ZGUgPHN5cy9hdXh2Lmg+CiNpbmNsdWRlIDxlcnJuby5oPgojaW5jbHVkZSA8c3RyaW5nLmg+
CiNpbmNsdWRlIDxzdGRpby5oPgoKI2lmbmRlZiAgUEFUSF9UT19QQVJTRV9WRFNPX0MKI2Vycm9y
ICAgUGxlYXNlIHNldCBjb21waWxhdGlvbiBmbGFnIC1EUEFUSF9UT19QQVJTRV9WRFNPX0M9Ii4u
LiIgLgojZW5kaWYKCiNpbmNsdWRlIFBBVEhfVE9fUEFSU0VfVkRTT19DCgp0eXBlZGVmCnN0cnVj
dCBsbnhfdHNjX2NhbGlicmF0aW9uX3MKeyB1bnNpZ25lZCBpbnQgbXVsdCwgc2hpZnQ7Cn0gTG54
VFNDQ2FsaWJyYXRpb25fdDsKCnR5cGVkZWYKc3RydWN0IHRzY19idWZmZXJfcwp7IHVuc2lnbmVk
IGxvbmcgdHNjLCBzZWMsIG5zZWM7Cn0gTG54VFNDQnVmZmVyX3Q7Cgp2b2lkIGNsb2NrX2dldF90
aW1lX3JhdyggcmVnaXN0ZXIgc3RydWN0IHRpbWVzcGVjICp0cyAsIHJlZ2lzdGVyIGNvbnN0IExu
eFRTQ0NhbGlicmF0aW9uX3QgKiB0c2NfY2FsLCByZWdpc3RlciBMbnhUU0NCdWZmZXJfdCAqbGFz
dCApCnsgdm9sYXRpbGUgdW5zaWduZWQgaW50ICB0c2NfbG89MCwgdHNjX2hpPTAsIHRzY19jcHU9
MDsgLy8gc28gc2FtZSBpbnN0cnMgZ2VuZXJhdGVkIGZvciA2NC1iaXQgYXMgZm9yIDMyLWJpdCBi
dWlsZHMKICByZWdpc3RlciB1bnNpZ25lZCBsb25nIHRzYz0wOyAKICBhc20gdm9sYXRpbGUKICAo
ICJyZHRzY3AiCiAgOiAiPWEiICh0c2NfbG8pCiAgLCAiPWQiICh0c2NfaGkpCiAgLCAiPWMiICh0
c2NfY3B1KQogICk7IC8vIDogZWF4LCBlZHgsIGVjeCB1c2VkIC0gTk9UIHJheCwgcmR4LCByY3gK
ICB0c2MgICAgID0gKCgoKHVuc2lnbmVkIGxvbmcpdHNjX2hpKSAmIDB4ZmZmZmZmZmZVTCkgPDwg
MzIpIHwgKCgodW5zaWduZWQgbG9uZyl0c2NfbG8pICYgMHhmZmZmZmZmZlVMKTsKICB0c2MgICAg
Kj0gdHNjX2NhbC0+bXVsdDsKICB0c2MgICA+Pj0gdHNjX2NhbC0+c2hpZnQ7CiAgaWYgKCBsYXN0
ICYmIGxhc3QtPnRzYyApCiAgeyByZWdpc3RlciB1bnNpZ25lZCBsb25nIHRzY19kaWZmID0gdHNj
IC0gbGFzdC0+dHNjOwogICAgaWYgKCAodHNjX2RpZmYgKyBsYXN0LT5uc2VjKSA+IDk5OTk5OTk5
OVVMICkKICAgIHsgdHMtPnR2X3NlYyAgPSB0c2MgLyAxMDAwMDAwMDAwOyAgICAgIAogICAgICB0
cy0+dHZfbnNlYyA9IHRzYyAlIDEwMDAwMDAwMDA7ICAgICAgICAgIAogICAgfWVsc2UKICAgIHsg
dHMtPnR2X3NlYyAgPSBsYXN0LT5zZWM7CiAgICAgIHRzLT50dl9uc2VjID0gdHNjX2RpZmYgKyBs
YXN0LT5uc2VjOwogICAgfQogICAgbGFzdC0+dHNjICAgICA9IHRzYzsKICAgIGxhc3QtPnNlYyAg
ICAgPSB0cy0+dHZfc2VjOwogICAgbGFzdC0+bnNlYyAgICA9IHRzLT50dl9uc2VjOyAgICAKICB9
ZWxzZQogIHsgdHMtPnR2X3NlYyAgICA9IHRzYyAvIDEwMDAwMDAwMDA7ICAgICAgCiAgICB0cy0+
dHZfbnNlYyAgID0gdHNjICUgMTAwMDAwMDAwMDsKICAgIGlmKGxhc3QpCiAgICB7IGxhc3QtPnRz
YyAgID0gdHNjOwogICAgICBsYXN0LT5zZWMgICA9IHRzLT50dl9zZWM7CiAgICAgIGxhc3QtPm5z
ZWMgID0gdHMtPnR2X25zZWM7ICAgIAogICAgfQogIH0KfQoKI2lmbmRlZiBOX1NBTVBMRVMKI2Rl
ZmluZSBOX1NBTVBMRVMgMTAwCiNlbmRpZgoKaW50IG1haW4oIGludCBhcmdjLCBjb25zdCBjaGFy
ICpjb25zdCogYXJndiAsIGNvbnN0IGNoYXIgKipjb25zdCBlbnZwICkKewogIHJlZ2lzdGVyIHVu
c2lnbmVkIGxvbmcgc3lzaW5mb19laGRyID0gZ2V0YXV4dmFsKCBBVF9TWVNJTkZPX0VIRFIgKTsK
ICBpZiggMCA9PSBzeXNpbmZvX2VoZHIgKQogIHsgZnByaW50ZihzdGRlcnIsImdldGF1eHZhbCBm
YWlsZWQ6ICVkIDogJyVzJy5cbiIsIGVycm5vLCBzdHJlcnJvcihlcnJubykpOwogICAgcmV0dXJu
IDE7CiAgfQogIHZkc29faW5pdF9mcm9tX3N5c2luZm9fZWhkciggc3lzaW5mb19laGRyICk7CiAg
aWYgKCAhIHZkc29faW5mby52YWxpZCApCiAgeyBmcHJpbnRmKHN0ZGVyciwidmRzb19pbml0X2Zy
b21fc3lzaW5mb19laGRyIGZhaWxlZFxuIik7CiAgICByZXR1cm4gMTsgIAogIH0gIAogIGNvbnN0
IHN0cnVjdCBsbnhfdHNjX2NhbGlicmF0aW9uX3MqCiAgICAoKmxpbnV4X3RzY19jYWwpKHZvaWQp
ID0gdmRzb19zeW0oIkxJTlVYXzIuNiIsICJfX3Zkc29fbGludXhfdHNjX2NhbGlicmF0aW9uIik7
CiAgaWYoIGxpbnV4X3RzY19jYWwgPT0gMFVMICkKICB7IGZwcmludGYoc3RkZXJyLCJ2ZHNvX3N5
bSBmYWlsZWRcbiIpOwogICAgcmV0dXJuIDE7CiAgfQogIGNvbnN0IHN0cnVjdCBsbnhfdHNjX2Nh
bGlicmF0aW9uX3MgKmNsb2NrX3NvdXJjZSA9ICgqbGludXhfdHNjX2NhbCkoKTsKICBmcHJpbnRm
KHN0ZGVyciwiR290IFRTQyBjYWxpYnJhdGlvbiBAICVwOiBtdWx0OiAldSBzaGlmdDogJXVcbiIs
CiAgICAgICAgICAodm9pZCopY2xvY2tfc291cmNlLCBjbG9ja19zb3VyY2UtPm11bHQsIGNsb2Nr
X3NvdXJjZS0+c2hpZnQKICAgICAgICAgKTsKI2RlZmluZSBUUzJOUyhfVFNfKSAoKCgodW5zaWdu
ZWQgbG9uZyBsb25nKShfVFNfKS50dl9zZWMpKjEwMDAwMDAwMDBVTEwpICsgKCgodW5zaWduZWQg
bG9uZyBsb25nKSgoX1RTXykudHZfbnNlYykpKSkgICAgIAogIHN0cnVjdCB0aW1lc3BlYyB0X3M9
ezAsMH07CiAgTG54VFNDQnVmZmVyX3QgIGxhc3RfdHNjID0gezAsMCwwfTsKICBjbG9ja19nZXRf
dGltZV9yYXcoICZ0X3MsIGNsb2NrX3NvdXJjZSwgJmxhc3RfdHNjKTsKICB1bnNpZ25lZCBsb25n
IGxvbmcKICAgIHNhbXBsZSBbIE5fU0FNUExFUyBdCiAgLCB0MSwgdDIKICAsIHRfc3RhcnQgPSBU
UzJOUyh0X3MpOwogIHVuc2lnbmVkIGludCBzPTA7CiAgZG8KICB7IGNsb2NrX2dldF90aW1lX3Jh
dyggJnRfcywgY2xvY2tfc291cmNlLCAmbGFzdF90c2MpOwogICAgdDEgPSBUUzJOUyh0X3MpOwog
ICAgY2xvY2tfZ2V0X3RpbWVfcmF3KCAmdF9zLCBjbG9ja19zb3VyY2UsICZsYXN0X3RzYyk7CiAg
ICB0MiA9IFRTMk5TKHRfcyk7CiAgICBzYW1wbGUgWyBzIF0gPSB0MiAtIHQxOyAgICAgICAgIAog
IH13aGlsZSgrK3MgPCBOX1NBTVBMRVMpOwogIHVuc2lnbmVkIGxvbmcgbG9uZyBzdW0gPSAwOwog
IGZvcihzID0gMDsgcyA8IE5fU0FNUExFUzsgcys9MSkKICAgIHN1bSArPSBzYW1wbGVbc107CiAg
ZnByaW50ZihzdGRlcnIsInN1bTogJWxsdVxuIixzdW0pOwogIHVuc2lnbmVkIGxvbmcgbG9uZyBh
dmdfbnMgPSBzdW0gLyBOX1NBTVBMRVM7CiAgdDE9KHQyIC0gdF9zdGFydCk7CiAgZnByaW50Zihz
dGRlcnIsCgkgICJUb3RhbCB0aW1lOiAlMS4xbGx1LiU5LjlsbHVTIC0gQXZlcmFnZSBMYXRlbmN5
OiAlMS4xbGx1LiU5LjlsbHVTXG4iLAogICAgICAgICAgdDEvMTAwMDAwMDAwMCwgICAgICAgdDEt
KCh0MS8xMDAwMDAwMDAwKSoxMDAwMDAwMDAwKSwKICAgICAgICAgIGF2Z19ucy8xMDAwMDAwMDAw
LCAgIGF2Z19ucy0oKGF2Z19ucy8xMDAwMDAwMDAwKSoxMDAwMDAwMDAwKSAgIAoJICApOwkgIAog
IHJldHVybiAwOwp9Cg==
--f40304355c44d2355b0566c18f9d--
