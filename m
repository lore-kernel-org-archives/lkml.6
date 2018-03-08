Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755772AbeCHPRA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 10:17:00 -0500
Received: from mail-oi0-f52.google.com ([209.85.218.52]:43595 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754958AbeCHPQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 10:16:58 -0500
X-Google-Smtp-Source: AG47ELvj2QzRHUf/O9RfV7lQS/bDAoS7EzkBDeRBUNTR4Ft/nSXNC9UrBzYO/FD0bQTvxRZyDpkTf8n4v1HayMfCZ0M=
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1803081251380.8662@nanos.tec.linutronix.de>
References: <CALyZvKx=kOaUqTWFK5gZXNTcY9+jCaKRqaH6VAJAOXmp-JJ2Bg@mail.gmail.com>
 <alpine.DEB.2.21.1803060953230.1630@nanos.tec.linutronix.de>
 <CALyZvKxORRjBurwj7+YV5fwJfwjMVWif+zpjC9AVM3z3WTVDaA@mail.gmail.com>
 <CALyZvKxEEKyOT7wTC35et6E5NtuvQDOkQHYMnaojs2ae_s3Myw@mail.gmail.com> <alpine.DEB.2.21.1803081251380.8662@nanos.tec.linutronix.de>
From: Jason Vas Dias <jason.vas.dias@gmail.com>
Date: Thu, 8 Mar 2018 15:16:56 +0000
Message-ID: <CALyZvKw05TriH83aJn3gnzvi46Do_K1UEDQkWU+A9n=UCsxjVA@mail.gmail.com>
Subject: Re: Fwd: [PATCH v4.15.7 1/1] on Intel, VDSO should handle
 CLOCK_MONOTONIC_RAW and export 'tsc_calibration' pointer
To: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
        andi <andi@firstfloor.org>
Content-Type: multipart/mixed; boundary="001a113de570a8cff50566e82aa4"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--001a113de570a8cff50566e82aa4
Content-Type: text/plain; charset="UTF-8"

On 08/03/2018, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Tue, 6 Mar 2018, Jason Vas Dias wrote:
>> I will prepare a new patch that meets submission + coding style guidelines
>> and
>> does not expose pointers within the vsyscall_gtod_data region to
>> user-space code -
>> but I don't really understand why not, since only the gtod->mult value
>> will
>> change as long as the clocksource remains TSC, and updates to it by the
>> kernel
>> are atomic and partial values cannot be read .
>>
>> The code in the patch reverts to old behavior for clocks which are not
>> the
>> TSC and provides a way for users to determine if the  clock is still the
>> TSC
>> by calling '__vdso_linux_tsc_calibration()', which would return NULL if
>> the clock is not the TSC .
>>
>> I have never seen Linux on a modern intel box spontaneously decide to
>> switch from the TSC clocksource after calibration succeeds and
>> it has decided to use the TSC as the system / platform clock source -
>> what would make it do this ?
>>
>> But for the highly controlled systems I am doing performance testing on,
>> I can guarantee that the clocksource does not change.
>
> We are not writing code for a particular highly controlled system. We
> expose functionality which operates under all circumstances. There are
> various reasons why TSC can be disabled at runtime, crappy BIOS/SMI,
> sockets getting out of sync .....
>
>> There is no way user code can write those pointers or do anything other
>> than read them, so I see no harm in exposing them to user-space ; then
>> user-space programs can issue rdtscp and use the same calibration values
>> as the kernel, and use some cached 'previous timespec value' to avoid
>> doing the long division every time.
>>
>> If the shift & mult are not accurate TSC calibration values, then the
>> kernel should put other more accurate calibration values in the gtod .
>
> The raw calibration values are as accurate as the kernel can make them. But
> they can be rather far off from converting to real nanoseconds for various
> reasons. The NTP/PTP adjusted conversion is matching real units and is
> obviously more accurate.
>
>> > Please look at the kernel side implementation of
>> > clock_gettime(CLOCK_MONOTONIC_RAW).
>> > The VDSO side can be implemented in the
>> > same way.
>> > All what is required is to expose the relevant information in the
>> > existing vsyscall_gtod_data data structure.
>>
>> I agree - that is my point entirely , & what I was trying to do .
>
> Well, you did not expose the raw conversion data in vsyscall_gtod_data. You
> are using:
>
> +         tsc    *= gtod->mult;
> +         tsc   >>= gtod->shift;
>
> That's is the adjusted mult/shift value which can change when NTP/PTP is
> enabled and you _cannot_ use it unprotected.
>
>> void getrawmonotonic64(struct timespec64 *ts)
>> {
>> 	struct timekeeper *tk = &tk_core.timekeeper;
>> 	unsigned long seq;
>> 	u64 nsecs;
>>
>> 	do {
>> 		seq = read_seqcount_begin(&tk_core.seq);
>> #                       ^-- I think this is the source of the locking
>> #                            and the very long latencies !
>
> This protects tk->raw_sec from changing which would result in random time
> stamps. Yes, it can cause slightly larger latencies when the timekeeper is
> updated on another CPU concurrently, but that's not the main reason why
> this is slower in general than the VDSO functions. The syscall overhead is
> there for every invocation and it's substantial.
>
>> So in fact, when the clock source is TSC, the value recorded in 'ts'
>> by clock_gettime(CLOCK_MONOTONIC_RAW, &ts) is very similar to
>>       u64 tsc = rdtscp();
>>       tsc *= gtod->mult;
>>       tsc >>= gtod->shift;
>>       ts.tv_sec=tsc / NSEC_PER_SEC;
>>       ts.tv_nsec=tsc % NSEC_PER_SEC;
>>
>> which is the algorithm I was using in the VDSO fast TSC reader,
>> do_monotonic_raw() .
>
> Except that you are using the adjusted conversion values and not the raw
> ones. So your VDSO implementation of monotonic raw access is just wrong and
> not matching the syscall based implementation in any way.
>
>> The problem with doing anything more in the VDSO is that there
>> is of course nowhere in the VDSO to store any data, as it has
>> no data section or writable pages . So some kind of writable
>> page would need to be added to the vdso , complicating its
>> vdso/vma.c, etc., which is not desirable.
>
> No, you don't need any writeable memory in the VDSO. Look at how the
> CLOCK_MONOTONIC and CLOCK_REALTIME functions are implemented in the VDSO.
>
>> But it is equally not desirable to have the clock_gettime
>> system call have a latency exceeding 300ns for CLOCK_MONOTONIC_RAW
>
> I said before and I do it once more: CLOCK_MONOTONIC_RAW can be implemented
> in the VDSO by adding the relevant data to vsyscall_gtod_data and by using
> the proper accessor functions which are there for a reason.
>
>> clocks, nor to measure all the adjustments & previous value dependencies
>> that the current implementation is prone to .
>
> I have no idea what you are talking about. If done right,
> CLOCK_MONOTONIC_RAW does not have any adjustments.
>
>> But there is no other communication of TSC calibration data currently
>> in the gtod
>> other than 'shift' and 'mult' ,which do actually give results which
>> correlate
>> approximately to the pico_period division above.
>
> Even if I'm repeating myself. vsyscall_gtod_data does not have the raw
> information and it simply can be added.
>
>> Attempts to change the vsyscall_gtod_data structure in any way have
>> resulted
>> in nasty core dumps of clock_gettime() using processes.
>> I'd much appreciate any tips on how to change its layout without breaking
>> everything.
>
> I have no idea what you have done, but vsyscall_gtod_data is a purely
> kernel internal data structure and can be changed as the kernel requires.
>
>> One currently needs to parse the system log messages to get the
>> 'Refined TSC clocksource calibration', or lookup its value in the
>> live kernel by looking up the 'tsc_khz' symbol at its
>> address given in System.map  with gdb / objdump ,
>> converting to offset into data region, and using
>> lseek() on /proc/kcore (as root).
>
> Groan.
>
>> The point is, user-space must rely on the kernel to perform
>> TSC calibration properly, and the only data in the gtod that
>> reflects the result of that calibration are the mult and shift values.
>> If linux wants to support user-space TSC readers, it needs to communicate
>> the TSC calibration somehow in the VDSO gtod area.
>
> I'm getting tired of this slowly. The kernel supports user space TSC access
> with CLOCK_MONOTONIC and CLOCK_REALTIME today in the VDSO.
>
>> And please consider SOME patch to the VDSO to implement user-space TSC
>> reading on the intel / AMD , to return a completely unadjusted value for
>> CLOCK_MONOTONIC_RAW, as documented, but not as Linux currently does.
>
> clock_gettime(CLOCK_MONOTONIC_RAW) returns the raw and unadjusted
> nanosecond time from any clocksource (TSC or whatever) today. It does so as
> documented.
>
> The only missing piece is a VDSO counterpart which avoids the syscall
> overhead.
>
>> BTW, it is not my 'editor's word-wrap corruping your patch', it is the
>> Gmail IMAP server, which believes all lines in plain-text messages
>> must be wrapped to 72 characters max, and  enforces this belief,
>> correct or not.  I think kernel.org needs to update its tools to parse
>> mime attachments or handle email server  line-wrapping, which I have
>> no control over - I wish I could move from the gmail server, but it would
>> be too much trouble.
>
> Sorry, a lot of people use gmail for kernel work and I think there is
> enough documentation out there how to do that.
>
> Thanks,
>
> 	tglx
>



Thanks Thomas -

I'd appreciate clarification on few points :

> Well, you did not expose the raw conversion data in vsyscall_gtod_data. You
> are using:
>
> +         tsc    *= gtod->mult;
> +         tsc   >>= gtod->shift;
>
> That's is the adjusted mult/shift value which can change when NTP/PTP is
> enabled and you _cannot_ use it unprotected.
...
> vsyscall_gtod_data does not have the raw
> information and it simply can be added.


By "the raw information" here,  do you mean :
  o   the 'tsc_khz'  "Refined TSC clocksource calibration" ?
  o   or some other data ?

The shift and mult values are calculated from
tsc_khz by :
<quote><code>
tsc_refine_calibration_work() , in arch/x86/kernel/tsc.c , @ line 1164:
{ ...
  	tsc_khz = freq;
	pr_info("Refined TSC clocksource calibration: %lu.%03lu MHz\n",
		(unsigned long)tsc_khz / 1000,
		(unsigned long)tsc_khz % 1000);

	/* Inform the TSC deadline clockevent devices about the recalibration */
	lapic_update_tsc_freq();

	/* Update the sched_clock() rate to match the clocksource one */
	for_each_possible_cpu(cpu)
		set_cyc2ns_scale(tsc_khz, cpu, tsc_stop);

  ...
}

static void set_cyc2ns_scale(unsigned long khz, int cpu, unsigned long
long tsc_now)
{ ...
	clocks_calc_mult_shift(&data.cyc2ns_mul, &data.cyc2ns_shift, khz,
			       NSEC_PER_MSEC, 0);
  ...
}


kernel/clocksource.c, @ line 64:

void
clocks_calc_mult_shift(u32 *mult, u32 *shift, u32 from, u32 to, u32 maxsec)
{ ...
}
</code></quote>


So by "the raw information"  do you mean this  initial mult & shift  ,
calculated from the Refined TSC Frequency (tsc_khz) which does not change ?

I understand that the vsyscall_gtod_data contains the adjusted mult & shift ,
but since this is the only data available there, and the kernel
syscall implementation
of clock_gettime(CLOCK_MONOTONIC_RAW) does seem to access
these same adjusted shift & mult values - as I showed in previous post,
kernel/time/timekeeping.c's getmonotonicraw64() does use these same
mult and shift values:

timekeeping_delta_to_ns(struct tk_read_base *tkr, u64 delta)
{...
        u64 nsec;
...
        nsec = delta * tkr->mult + tkr->xtime_nsec;
        nsec >>= tkr->shift;
...
}

Are the vdso gtod->mult and gtod->shift values somehow different from
  'tkr->mult' and 'tkr->shift' ?
I thought they were actually pointers to the same calibration data.
Yes, as noted in previous posts, the 'mult' value does seem to
change by small increments . I guess this is purely because of NTP / PTP ?
So the syscall implementation of clock_gettime(CLOCK_MONOTONIC_RAW,&ts)
actually does return an NTP / PTP adjusted value ?
Then it is  even worse than I thought - not only does it
have an unusably high latency, but it does not do what
it is documented to do at all, if those mult/shift values
are changed by NTP/PTP / CPU frequency adjustments.

I did redo the patches yesterday , addressing the formatting issues
and adding a header for the 'struct linux_tsc_calibration' structure -
see mail subject:
    '[PATCH v4.15.7 1/1] x86/vdso: handle
clock_gettime(CLOCK_MONOTONIC_RAW, &ts) in VDSO' .

I also enclose the updated patch as an attachment to this mail .

I do strongly believe that if the VDSO is going to support accessing the TSC
from user-space,
it should provide some access to the  TSC calibration values that would
permit user-space TSC readers to convert the TSC value to nanoseconds
accurately and efficiently, in a way not prone to NTP or PTP adjustments ;
otherwise the VDSO do_monotonic_raw must be used, and as it has nowhere
to cache previous values, it must do the long division every time,
which enforces
a latency of >= @ 100ns.
My  user-space TSC reader in 'test_vdso_tsc.c' (sent as attachments to
previous mails)  uses the pointer returned by
__vdso_linux_tsc_calibration() , and a
cached previous value, to achieve latencies of 10-20ns .

I can't see how the contents pointed to by the pointer returned by
__vdso_linux_tsc_calibration()
will be "garbage" , as long as the clock source remains TSC .

Updates to 64 bit memory locations are atomic on x86_64 , so either
an updated valid 'mult' value is read, or the previous valid 'mult' value
is read (the shift does not change) - I can't see the harm in that.

Yes, users do need to check that the clocksource is still 'TSC' ,
by checking that __vdso_linux_tsc_calibration() still returns non-null ,
or that /sys/devices/system/clocksource/clocksource0/current_clocksource
is still 'tsc'  .

By 'Controlled' I just mean I can control whether the clocksource will change
during a run of given test program that uses the TSC or not - I
believe any other user would also be in the same position - don't
change the clock source during
a run of your test program, and it will yield valid results.  It is
difficult to imagine
a time measurement program that could be expected to withstand a change
of the system clocksource and still provide valid results - one would want to
discard results from a program that experienced a system clock-source change.

Programs which want to withstand system-clock source changes can use
Events or the value of the __vdso_linux_tsc_calibration() function to determine
if the clock source has changed.

So I don't agree that it is a priori wrong to return a pointer into
the VDSO vvar
page to user-space, which can only be used in a read-only way, and
whose contents
will be valid as long as the clock source does not change, when users
can easily determine if the clock source has changed or not before using
the pointer - I don't see how the contents can spontaneously become 'garbage'
if the clock source does not change, and if it does change, users can easily
find out about it.

So I guess it comes down to what TSC calibration data should be put in
the VDSO -
I guess these are the initial unchanging 'mult' and 'shift' values ?
Or just 'tsc_khz'  ?

The only reason I use the mult & shift is because this is the way
Linux does it ,
and we'd like to obtain TSC time values that correlate well with those generated
by the kernel.
It does discard alot of resolution and seconds bits , but the values do appear
to correlate well to the calculated TSC frequency  - here's a PERL program
that demonstrates accuracy of mult+shift conversion method:

<quote><code>
#!/usr/bin/perl
#
# This demonstrates that the  Linux TSC 'mult' and 'shift'
# values really do provide a close approximation to precise nanosecond
# conversion:
#
$tsc_cal_msg='';
if     ( -r '/var/log/messages' )
{
    $tsc_cal_msg = `grep -F 'Refined TSC clocksource calibration'
/var/log/messages  | tail -n 1`;
}elsif ( -x '/usr/bin/journalctl' )
{
    $tsc_cal_msg = `journalctl -b -0 | grep -F 'Refined TSC
clocksource calibration' | tail -n 1`;
}
$tsc_freq_mhz = 0.0;
if ( $tsc_cal_msg =~ /([0-9\.]+)[[:space:]]*MHz[[:space:]]*$/ )
{  $tsc_freq_mhz = $1;
}
$tsc_freq_ghz = $tsc_freq_mhz/1000;
print STDERR "Calibrated TSC Frequency: $tsc_freq_mhz MHz :
$tsc_freq_ghz GHz\n";
$lnx_kern_mult  = 4945810;
$lnx_kern_shift = 24;
# the last shift & mult values read from kernel vsyscall_gtod_data -
# you'll need to run 'test/tts.cpp' - the first output line is like:
# High Resolution TimeStamps Enabled - Got TSC calibration @
0xffffffffff5ff0a0: mult: 4945820 shift: 24
# and plug in the mult and shift values above. Doing this by examining
the live kernel is really complicated -
# this is in a way the whole point of the patch.
#
$tsc_val = 1000000000;
$c=0;
do
{
$tsc_nanos_1 = int($tsc_val / $tsc_freq_ghz); # not nice for Linux to
do long division, also it does not have floating point support in
kernel.
# so linux has computed the shift and mult to give a close approximation:
$tsc_nanos_2 = ($tsc_val * $lnx_kern_mult) >> $lnx_kern_shift;
$diff_pc = sprintf("%1.3e",(abs($tsc_nanos_2 - $tsc_nanos_1) /
$tsc_nanos_2) * 100.0);
print STDERR "TSC: $tsc_val Calculated nanos: $tsc_nanos_1 (by
tsc/$tsc_freq_ghz ) ; $tsc_nanos_2 (by (tsc*mult)>>shift) - difference
as percentage: $diff_pc\% \n";
$tsc_val += $tsc_val + (10**$c++);
} while ($c <= 10);
</code></quote>

This prints, on my system:

$ cat tsc_numbers.log
Calibrated TSC Frequency: 3392.144 MHz : 3.392144 GHz
TSC: 1000000000 Calculated nanos: 294798805 (by tsc/3.392144 ) ;
294792652 (by (tsc*mult)>>shift) - difference as percentage:
2.087e-03%
TSC: 2000000001 Calculated nanos: 589597611 (by tsc/3.392144 ) ;
589585304 (by (tsc*mult)>>shift) - difference as percentage:
2.087e-03%
TSC: 4000000012 Calculated nanos: 1179195226 (by tsc/3.392144 ) ;
1179170612 (by (tsc*mult)>>shift) - difference as percentage:
2.087e-03%
TSC: 8000000124 Calculated nanos: 2358390482 (by tsc/3.392144 ) ;
2358341253 (by (tsc*mult)>>shift) - difference as percentage:
2.087e-03%
TSC: 16000001248 Calculated nanos: 4716781259 (by tsc/3.392144 ) ;
4716682801 (by (tsc*mult)>>shift) - difference as percentage:
2.087e-03%
TSC: 32000012496 Calculated nanos: 9433565466 (by tsc/3.392144 ) ;
9433368551 (by (tsc*mult)>>shift) - difference as percentage:
2.087e-03%
TSC: 64000124992 Calculated nanos: 18867160413 (by tsc/3.392144 ) ;
18866766583 (by (tsc*mult)>>shift) - difference as percentage:
2.087e-03%
TSC: 128001249984 Calculated nanos: 37734615624 (by tsc/3.392144 ) ;
37733827958 (by (tsc*mult)>>shift) - difference as percentage:
2.087e-03%
TSC: 256012499968 Calculated nanos: 75472179237 (by tsc/3.392144 ) ;
75470603844 (by (tsc*mult)>>shift) - difference as percentage:
2.087e-03%
TSC: 512124999936 Calculated nanos: 150973838355 (by tsc/3.392144 ) ;
150970686953 (by (tsc*mult)>>shift) - difference as percentage:
2.087e-03%
TSC: 1025249999872 Calculated nanos: 302242475517 (by tsc/3.392144 ) ;
302236166558 (by (tsc*mult)>>shift) - difference as percentage:
2.087e-03%

So they look accurate enough to me - a constant 0.002087% difference beween
the value calculated by ( tsc / tsc_ticks_per_nanosecond) is
sufficiently close to
( (tsc * mult) >> shift )  .   But there are not many bits left for
seconds values
in either calculation :    @  10, by my estimate : (64 - (24 +30)) == 10
- a 24 bit right shift plus @ 30 bits of nanosecond leaves 10
effective seconds bits.
If there is a better way of converting  TSC to nanoseconds, let me know .
I'd much prefer to use the TSC value as an exact number of picoseconds ,
but use of 'struct timespec' , which must contain a nanosecond resolution
value, precludes this.

Please, I'm not saying my patch must be integrated as-is into Linux, I'm
just saying we really need a low-latency TSC reader in the VDSO for
   clock_gettime(CLOCK_MONOTONIC_RAW, &ts)
under Linux on Intel / AMD, and presenting one way I've found to provide one.
If you find a better way, please let me know.

Thanks & Best Regards,
Jason

--001a113de570a8cff50566e82aa4
Content-Type: application/octet-stream;
	name="vdso_vclock_gettime_userspace_tsc.patch"
Content-Disposition: attachment;
	filename="vdso_vclock_gettime_userspace_tsc.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: file0

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2VudHJ5L3Zkc28vdmNsb2NrX2dldHRpbWUuYyBiL2FyY2gv
eDg2L2VudHJ5L3Zkc28vdmNsb2NrX2dldHRpbWUuYwppbmRleCBmMTk4NTZkLi5lODQwNjAwIDEw
MDY0NAotLS0gYS9hcmNoL3g4Ni9lbnRyeS92ZHNvL3ZjbG9ja19nZXR0aW1lLmMKKysrIGIvYXJj
aC94ODYvZW50cnkvdmRzby92Y2xvY2tfZ2V0dGltZS5jCkBAIC0yMSw2ICsyMSw3IEBACiAjaW5j
bHVkZSA8bGludXgvbWF0aDY0Lmg+CiAjaW5jbHVkZSA8bGludXgvdGltZS5oPgogI2luY2x1ZGUg
PGxpbnV4L2tlcm5lbC5oPgorI2luY2x1ZGUgPHVhcGkvYXNtL3Zkc29fdHNjX2NhbGlicmF0aW9u
Lmg+CiAKICNkZWZpbmUgZ3RvZCAoJlZWQVIodnN5c2NhbGxfZ3RvZF9kYXRhKSkKIApAQCAtMjQ2
LDYgKzI0NywyOSBAQCBub3RyYWNlIHN0YXRpYyBpbnQgX19hbHdheXNfaW5saW5lIGRvX21vbm90
b25pYyhzdHJ1Y3QgdGltZXNwZWMgKnRzKQogCXJldHVybiBtb2RlOwogfQogCitub3RyYWNlIHN0
YXRpYyBpbnQgX19hbHdheXNfaW5saW5lIGRvX21vbm90b25pY19yYXcoIHN0cnVjdCB0aW1lc3Bl
YyAqdHMpCit7ICAgICAgIAorICAgICAgICB2b2xhdGlsZSB1MzIgdHNjX2xvPTAsIHRzY19oaT0w
LCB0c2NfY3B1PTA7IC8vIHNvIHNhbWUgaW5zdHJzIGdlbmVyYXRlZCBmb3IgNjQtYml0IGFzIGZv
ciAzMi1iaXQgYnVpbGRzCisgICAgICAgIHU2NCBuczsKKyAgICAgICAgcmVnaXN0ZXIgdTY0IHRz
Yz0wOworICAgICAgICBpZiAoZ3RvZC0+dmNsb2NrX21vZGUgPT0gVkNMT0NLX1RTQykKKyAgICAg
ICAgeworICAgICAgICAgICAgICAgIGFzbSB2b2xhdGlsZQorICAgICAgICAgICAgICAgICggInJk
dHNjcCIKKyAgICAgICAgICAgICAgICA6ICI9YSIgKHRzY19sbykKKyAgICAgICAgICAgICAgICAs
ICI9ZCIgKHRzY19oaSkKKyAgICAgICAgICAgICAgICAsICI9YyIgKHRzY19jcHUpCisgICAgICAg
ICAgICAgICAgKTsgLy8gOiBlYXgsIGVkeCwgZWN4IHVzZWQgLSBOT1QgcmF4LCByZHgsIHJjeAor
ICAgICAgICAgICAgICAgIHRzYyAgICAgPSAoKCgodTY0KXRzY19oaSkgJiAweGZmZmZmZmZmVUwp
IDw8IDMyKSB8ICgoKHU2NCl0c2NfbG8pICYgMHhmZmZmZmZmZlVMKTsKKyAgICAgICAgICAgICAg
ICB0c2MgICAgKj0gZ3RvZC0+bXVsdDsKKyAgICAgICAgICAgICAgICB0c2MgICA+Pj0gZ3RvZC0+
c2hpZnQ7CisgICAgICAgICAgICAgICAgdHMtPnR2X3NlYyAgPSBfX2l0ZXJfZGl2X3U2NF9yZW0o
dHNjLCBOU0VDX1BFUl9TRUMsICZucyk7ICAgICAgICAgICAgCisgICAgICAgICAgICAgICAgdHMt
PnR2X25zZWMgPSBuczsgICAgICAgICAgCisgICAgICAgICAgICAgICAgcmV0dXJuIFZDTE9DS19U
U0M7ICAgICAgICAgICAgICAgIAorICAgICAgICB9CisgICAgICAgIHJldHVybiBWQ0xPQ0tfTk9O
RTsKK30KKwogbm90cmFjZSBzdGF0aWMgdm9pZCBkb19yZWFsdGltZV9jb2Fyc2Uoc3RydWN0IHRp
bWVzcGVjICp0cykKIHsKIAl1bnNpZ25lZCBsb25nIHNlcTsKQEAgLTI3Nyw2ICszMDEsMTAgQEAg
bm90cmFjZSBpbnQgX192ZHNvX2Nsb2NrX2dldHRpbWUoY2xvY2tpZF90IGNsb2NrLCBzdHJ1Y3Qg
dGltZXNwZWMgKnRzKQogCQlpZiAoZG9fbW9ub3RvbmljKHRzKSA9PSBWQ0xPQ0tfTk9ORSkKIAkJ
CWdvdG8gZmFsbGJhY2s7CiAJCWJyZWFrOworCWNhc2UgQ0xPQ0tfTU9OT1RPTklDX1JBVzoKKwkJ
aWYgKGRvX21vbm90b25pY19yYXcodHMpID09IFZDTE9DS19OT05FKQorCQkJZ290byBmYWxsYmFj
azsKKwkJYnJlYWs7CiAJY2FzZSBDTE9DS19SRUFMVElNRV9DT0FSU0U6CiAJCWRvX3JlYWx0aW1l
X2NvYXJzZSh0cyk7CiAJCWJyZWFrOwpAQCAtMzI2LDMgKzM1NCwxOCBAQCBub3RyYWNlIHRpbWVf
dCBfX3Zkc29fdGltZSh0aW1lX3QgKnQpCiB9CiB0aW1lX3QgdGltZSh0aW1lX3QgKnQpCiAJX19h
dHRyaWJ1dGVfXygod2VhaywgYWxpYXMoIl9fdmRzb190aW1lIikpKTsKKworZXh0ZXJuIGNvbnN0
IHN0cnVjdCBsaW51eF90c2NfY2FsaWJyYXRpb24gKgorICAgICAgICBfX3Zkc29fbGludXhfdHNj
X2NhbGlicmF0aW9uKHZvaWQpOworCitub3RyYWNlICBjb25zdCBzdHJ1Y3QgbGludXhfdHNjX2Nh
bGlicmF0aW9uICoKKyAgX192ZHNvX2xpbnV4X3RzY19jYWxpYnJhdGlvbih2b2lkKQoreworICAg
ICAgICBpZiggZ3RvZC0+dmNsb2NrX21vZGUgPT0gVkNMT0NLX1RTQyApIAorICAgICAgICAgICAg
ICAgIHJldHVybiAoKGNvbnN0IHN0cnVjdCBsaW51eF90c2NfY2FsaWJyYXRpb24qKSAmZ3RvZC0+
bXVsdCk7CisgICAgICAgIHJldHVybiAwVUw7Cit9CisKK2NvbnN0IHN0cnVjdCBsaW51eF90c2Nf
Y2FsaWJyYXRpb24gKiBsaW51eF90c2NfY2FsaWJyYXRpb24odm9pZCkKKyAgICAgICAgX19hdHRy
aWJ1dGUoKHdlYWssIGFsaWFzKCJfX3Zkc29fbGludXhfdHNjX2NhbGlicmF0aW9uIikpKTsKKwpk
aWZmIC0tZ2l0IGEvYXJjaC94ODYvZW50cnkvdmRzby92ZHNvLmxkcy5TIGIvYXJjaC94ODYvZW50
cnkvdmRzby92ZHNvLmxkcy5TCmluZGV4IGQzYTJkY2UuLjQxYTJjYTUgMTAwNjQ0Ci0tLSBhL2Fy
Y2gveDg2L2VudHJ5L3Zkc28vdmRzby5sZHMuUworKysgYi9hcmNoL3g4Ni9lbnRyeS92ZHNvL3Zk
c28ubGRzLlMKQEAgLTI0LDcgKzI0LDkgQEAgVkVSU0lPTiB7CiAJCWdldGNwdTsKIAkJX192ZHNv
X2dldGNwdTsKIAkJdGltZTsKLQkJX192ZHNvX3RpbWU7CisJICAgICAgICBfX3Zkc29fdGltZTsK
KyAgICAgICAgICAgICAgICBsaW51eF90c2NfY2FsaWJyYXRpb247CisJCV9fdmRzb19saW51eF90
c2NfY2FsaWJyYXRpb247CiAJbG9jYWw6ICo7CiAJfTsKIH0KZGlmZiAtLWdpdCBhL2FyY2gveDg2
L2VudHJ5L3Zkc28vdmRzbzMyL3Zkc28zMi5sZHMuUyBiL2FyY2gveDg2L2VudHJ5L3Zkc28vdmRz
bzMyL3Zkc28zMi5sZHMuUwppbmRleCA0MjI3NjRhLi5kNTNiZDczIDEwMDY0NAotLS0gYS9hcmNo
L3g4Ni9lbnRyeS92ZHNvL3Zkc28zMi92ZHNvMzIubGRzLlMKKysrIGIvYXJjaC94ODYvZW50cnkv
dmRzby92ZHNvMzIvdmRzbzMyLmxkcy5TCkBAIC0yNSw3ICsyNSw4IEBAIFZFUlNJT04KIAlnbG9i
YWw6CiAJCV9fdmRzb19jbG9ja19nZXR0aW1lOwogCQlfX3Zkc29fZ2V0dGltZW9mZGF5OwotCQlf
X3Zkc29fdGltZTsKKwkgICAgICAgIF9fdmRzb190aW1lOworICAgICAgICAgICAgICAgIF9fdmRz
b19saW51eF90c2NfY2FsaWJyYXRpb247CiAJfTsKIAogCUxJTlVYXzIuNSB7CmRpZmYgLS1naXQg
YS9hcmNoL3g4Ni9lbnRyeS92ZHNvL3Zkc294MzIubGRzLlMgYi9hcmNoL3g4Ni9lbnRyeS92ZHNv
L3Zkc294MzIubGRzLlMKaW5kZXggMDVjZDFjNS4uZmIxM2IxNiAxMDA2NDQKLS0tIGEvYXJjaC94
ODYvZW50cnkvdmRzby92ZHNveDMyLmxkcy5TCisrKyBiL2FyY2gveDg2L2VudHJ5L3Zkc28vdmRz
b3gzMi5sZHMuUwpAQCAtMjAsNyArMjAsOCBAQCBWRVJTSU9OIHsKIAkJX192ZHNvX2Nsb2NrX2dl
dHRpbWU7CiAJCV9fdmRzb19nZXR0aW1lb2ZkYXk7CiAJCV9fdmRzb19nZXRjcHU7Ci0JCV9fdmRz
b190aW1lOworCSAgICAgICAgX192ZHNvX3RpbWU7CisgICAgICAgICAgICAgICAgX192ZHNvX2xp
bnV4X3RzY19jYWxpYnJhdGlvbjsKIAlsb2NhbDogKjsKIAl9OwogfQpkaWZmIC0tZ2l0IGEvYXJj
aC94ODYvaW5jbHVkZS91YXBpL2FzbS92ZHNvX3RzY19jYWxpYnJhdGlvbi5oIGIvYXJjaC94ODYv
aW5jbHVkZS91YXBpL2FzbS92ZHNvX3RzY19jYWxpYnJhdGlvbi5oCm5ldyBmaWxlIG1vZGUgMTAw
NjQ0CmluZGV4IDAwMDAwMDAuLjZmZWJiODQKLS0tIC9kZXYvbnVsbAorKysgYi9hcmNoL3g4Ni9p
bmNsdWRlL3VhcGkvYXNtL3Zkc29fdHNjX2NhbGlicmF0aW9uLmgKQEAgLTAsMCArMSw0NyBAQAor
LyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAgV0lUSCBMaW51eC1zeXNjYWxsLW5v
dGUgKi8KKyNpZm5kZWYgX0FTTV9YODZfVkRTT19UU0NfQ0FMSUJSQVRJT05fSAorI2RlZmluZSBf
QVNNX1g4Nl9WRFNPX1RTQ19DQUxJQlJBVElPTl9ICisvKiAKKyAqIFByb2dyYW1zIHRoYXQgd2Fu
dCB0byB1c2UgcmR0c2MgLyByZHRzY3AgaW5zdHJ1Y3Rpb25zCisgKiBmcm9tIHVzZXItc3BhY2Ug
Y2FuIG1ha2UgdXNlIG9mIHRoZSBMaW51eCBrZXJuZWwgVFNDIGNhbGlicmF0aW9uCisgKiBieSBj
YWxsaW5nIDoKKyAqICAgIF9fdmRzb19saW51eF90c2NfY2FsaWJyYXRpb24odm9pZCk7CisgKiAo
IG9uZSBoYXMgdG8gcmVzb2x2ZSB0aGlzIHN5bWJvbCBhcyBpbiAKKyAqICAgdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvdkRTTy9wYXJzZV92ZHNvLmMKKyAqICkKKyAqIHdoaWNoIHJldHVybnMgYSBw
b2ludGVyIGludG8gdGhlIHJlYWQtb25seQorICogdnZhcl9wYWdlICh0aGUgdnN5c2NhbGxfZ3Rv
ZF9kYXRhIHN0cnVjdHVyZSksCisgKiB3aXRoIHRoZSBmb2xsb3dpbmcgbGF5b3V0IDoKKyAqLwor
CitzdHJ1Y3QgbGludXhfdHNjX2NhbGlicmF0aW9uCit7CisgICAgICAgIHVuc2lnbmVkIGludCBt
dWx0OyAgIC8qIGFtb3VudCB0byBtdWx0aXBseSA2NC1iaXQgVFNDIHZhbHVlIGJ5ICovCisKKyAg
ICAgICAgdW5zaWduZWQgaW50IHNoaWZ0OyAgLyogdGhlIHJpZ2h0IHNoaWZ0IHRvIGFwcGx5IHRv
IChtdWx0KlRTQykgeWllbGRpbmcgbmFub3NlY29uZHMgKi8gCit9OworCisvKiBUbyB1c2U6Cisg
KgorICogIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbG54X3RzY19jYWxpYnJhdGlvbl9zKgorICogICgq
bGludXhfdHNjX2NhbCkodm9pZCkgPSB2ZHNvX3N5bSgiTElOVVhfMi42IiwgIl9fdmRzb19saW51
eF90c2NfY2FsaWJyYXRpb24iKTsKKyAqICBpZiggbGludXhfdHNjX2NhbCA9PSAwVUwgKQorICog
IHsgZnByaW50ZihzdGRlcnIsInRoZSBwYXRjaCBwcm92aWRpbmcgX192ZHNvX2xpbnV4X3RzY19j
YWxpYnJhdGlvbiBpcyBub3QgYXBwbGllZCB0byB0aGUga2VybmVsLlxuIik7CisgKiAgICByZXR1
cm4gRVJST1I7CisgKiAgfQorICogIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbG54X3RzY19jYWxpYnJh
dGlvbl9zICpjbG9ja19zb3VyY2UgPSAoKmxpbnV4X3RzY19jYWwpKCk7CisgKiAgaWYoIGNsb2Nr
X3NvdXJjZSA9PSAoKHZvaWQqKTBVTCkpCisgKiAgICBmcHJpbnRmKHN0ZGVyciwiVFNDIGlzIG5v
dCB0aGUgc3lzdGVtIGNsb2Nrc291cmNlLlxuIik7CisgKiAgdm9sYXRpbGUgdW5zaWduZWQgaW50
IHRzY19sbywgdHNjX2hpLCB0c2NfY3B1OworICogIGFzbSB2b2xhdGlsZQorICogICggInJkdHNj
cCIgOiAoPWEpIHRzY19oaSwgICg9ZCkgdHNjX2xvLCAoPWMpIHRzY19jcHUgKTsKKyAqICB1bnNp
Z25lZCBsb25nIHRzYyA9ICgoKHVuc2lnbmVkIGxvbmcpdHNjX2hpKSA8PCAzMikgfCB0c2NfbG87
CisgKiAgdW5zaWduZWQgbG9uZyBuYW5vc2Vjb25kcyA9CisgKiAgICgoIGNsb2NrX3NvdXJjZSAt
PiBtdWx0ICkgKiB0c2MgKSA+PiAoY2xvY2tfc291cmNlIC0+IHNoaWZ0KTsKKyAqICAKKyAqICBu
YW5vc2Vjb25kcyBpcyBub3cgVFNDIHZhbHVlIGNvbnZlcnRlZCB0byBuYW5vc2Vjb25kcywgCisg
KiAgYWNjb3JkaW5nIHRvIExpbnV4JyBjbG9ja3NvdXJjZSBjYWxpYnJhdGlvbiB2YWx1ZXMuIAor
ICogIAorICovCisKKyNlbmRpZgo=
--001a113de570a8cff50566e82aa4--
