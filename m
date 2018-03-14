Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751488AbeCNMzY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 08:55:24 -0400
Received: from mail-ot0-f171.google.com ([74.125.82.171]:38551 "EHLO
        mail-ot0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751366AbeCNMzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 08:55:22 -0400
X-Google-Smtp-Source: AG47ELvz0cBheR8XU97xedCznTi/yeB3039Ys4llx6KhK6Pj0FA4cslSA2lKWf2jevdwBrDsyxvsF4u33s8y1oDcN5k=
MIME-Version: 1.0
In-Reply-To: <20180314094519.GD4082@hirez.programming.kicks-ass.net>
References: <d109ixq7.fsf@gmail.com> <20180312082741.GD4064@hirez.programming.kicks-ass.net>
 <CALyZvKxKXWiFF9OYtykXEfnx-k+xaAM7XREEQ+N58oJtOTZhew@mail.gmail.com> <20180314094519.GD4082@hirez.programming.kicks-ass.net>
From: Jason Vas Dias <jason.vas.dias@gmail.com>
Date: Wed, 14 Mar 2018 12:55:20 +0000
Message-ID: <CALyZvKzbLi6K9DFwOXu7h--MdxWFv9A3==0xORuQ=KwtJx3ZrQ@mail.gmail.com>
Subject: Re: [PATCH v4.16-rc4 2/2] x86/vdso: on Intel, VDSO should handle CLOCK_MONOTONIC_RAW
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, andi <andi@firstfloor.org>
Content-Type: multipart/mixed; boundary="f40304355c444c1cb405675ee355"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--f40304355c444c1cb405675ee355
Content-Type: text/plain; charset="UTF-8"

Thanks for the helpful comments, Peter -
re:
On 14/03/2018, Peter Zijlstra <peterz@infradead.org> wrote:
>
>> Yes, I am sampling perf counters,
>
> You're not in fact sampling, you're just reading the counters.

Correct, using Linux-ese terminology - but "sampling" in looser English.


>> Reading performance counters does involve  2 ioctls and a read() ,
>
> So you can avoid the whole ioctl(ENABLE), ioctl(DISABLE) nonsense and
> just let them run and do:
>
> 	read(group_fd, &buf_pre, size);
> 	/* your code section */
> 	read(group_fd, &buf_post, size);
>
> 	/* compute buf_post - buf_pre */
>
> Which is only 2 system calls, not 4.

But I can't, really - I am trying to restrict the
performance counter measurements
to only a subset of the code, and exclude
performance measurement result processing  -
so the timeline is like:
                      struct timespec t_start, t_end;
                      perf_event_open(...);
                      thread_main_loop() { ... do {
          t     _    clock_gettime(CLOCK_MONOTONIC_RAW, &t_start);
          t+x _   enable_perf  ();
                      total_work = do_some_work();
                      disable_perf ();
                      clock_gettime(CLOCK_MONOTONIC_RAW, &t_end);
           t+y_
                      read_perf_counters_and_store_results
                       ( perf_grp_fd, &results ,  total_work,
                         TS2T( &t_end ) - TS2T( &t_start)
                        );
           } while (.... );
        }

   Now. here the bandwidth / performance results recorded by
   my 'read_perf_counters_and_store_results' method
   is very sensitive to the measurement of the OUTER
   elapsed time .

>
> Also, a while back there was the proposal to extend the mmap()
> self-monitoring interface to groups, see:
>
> https://lkml.kernel.org/r/20170530172555.5ya3ilfw3sowokjz@hirez.programming.kicks-ass.net
>
> I never did get around to writing the actual code for it, but it
> shouldn't be too hard.
>

Great, I'm looking forward to trying it - but meanwhile,
to get NON-MULTIPLEXED measurements for the SAME CODE SEQUENCE
over the SAME TIME I believe the group FD method is what is implemented
and what works.


>> The CPU_CLOCK software counter should give the converted TSC cycles
>> seen between the ioctl( grp_fd, PERF_EVENT_IOC_ENABLE , ...)
>> and the  ioctl( grp_fd, PERF_EVENT_IOC_DISABLE ), and the
>> difference between the event->time_running and time_enabled
>> should also measure elapsed time .
>
> While CPU_CLOCK is TSC based, there is no guarantee it has any
> correlation to CLOCK_MONOTONIC_RAW (even if that is also TSC based).
>
> (although, I think I might have fixed that recently and it might just
> work, but it's very much not guaranteed).

Yes, I believe the CPU_CLOCK is effectively the converted TSC -
it does appear to correlate well with the new CLOCK_MONOTONIC_RAW
values from the patched VDSO.

> If you want to correlate to CLOCK_MONOTONIC_RAW you have to read
> CLOCK_MONOTONIC_RAW and not some random other clock value.
>

Exactly ! Hence the need for the patch so that users can get
CLOCK_MONOTONIC_RAW values with low latency and correlate them
with PERF CPU_CLOCK values.

>> This gives the "inner" elapsed time, from the perpective of the kernel,
>> while the measured code section had the counters enabled.
>>
>> But unless the user-space program  also has a way of measuring elapsed
>> time from the CPU's perspective , ie. without being subject to
>> operator or NTP / PTP adjustment, it has no way of correlating this
>> inner elapsed time with any "outer"
>
> You could read the time using the group_fd's mmap() page. That actually
> includes the TSC mult,shift,offset as used by perf clocks.
>

Yes, but as mentioned earlier, that presupposes I want to use the mmap()
sample method - I don't - I want to use the Group FD method, so
that I can be sure the measurements are for the same code sequence
over the same period of time.

>> Currently, users must parse the log file or use gdb / objdump to
>> inspect /proc/kcore to get the TSC calibration and exact
>> mult+shift values for the TSC value conversion.
>
> Which ;-) there's multiple floating around..
>

Yes, but why must Linux make it so difficult ?
I think it has to be recognized that the vDSO or user-space program
are the only places in which low-latency clock values can be generated
for use by user-space programs with sufficiently low latencies to be useful.
So why does it not export the TSC calibration which is so complex to
calibrate when such calibration information is available nowhere else ?


>> Intel does not publish, nor does the CPU come with in ROM or firmware,
>> the actual precise TSC frequency - this must be calibrated against the
>> other clocks , according to a complicated procedure in section 18.2 of
>> the SDM . My TSC has a "rated" / nominal TSC frequency , which one
>> can compute from CPUID leaves, of 2.3ghz, but the "Refined TSC frequency"
>> is 2.8333ghz .
>
> You might want to look at commit:
>
>   b51120309348 ("x86/tsc: Fix erroneous TSC rate on Skylake Xeon")
>
> There is no such thing as a precise TSC frequency, there's a reason we
> have NTP/PTP.
>

By my reading of the SDM, yes, the TSC frequency IS quite precise and
fixed ,  especially on modern CPUs with Always Running Timer (ART)
hardware,  but its precise frequency is not known in advance and
must be calibrated - but once known, it is quite precise & fixed at
that value.

I want to count the number of ticks the CPU thinks has elapsed,
regardless of how fast or slow it is currently running , NOT the
NTP / PTP time.


ntpd itself is running very happily and is reporting MUCH lower
offsets and drift with the VDSO CLOCK_MONOTONIC_RAW
patch applied.

>> Hence I think Linux should export this calibrated frequency somehow ;
>> its "calibration" is expressed as the raw clocksource 'mult' and 'shift'
>> values, and is exported to the VDSO .
>>
>> I think the VDSO should read the TSC and use the calibration
>> to render the raw, unadjusted time from the CPU's perspective.
>>
>> Hence, the patch I am preparing , which is again attached.
>
> I have no objection to adding CLOCK_MONOTONIC_RAW support to the VDSO,
> but you seem to be rather confused on how things work.
>
> Now, if you wanted to actually have CLOCK_MONOTONIC_RAW times from perf
> you'd need something like the below patch.
>
> You'd need to create your events with:
>
> 	attr.use_clockid = 1;
> 	attr.clockid = CLOCK_MONOTONIC_RAW;
> 	attr.read_format |= PERF_FORMAT_TIME;
>

Yes, I am doing this, but I want to also be able to read
CLOCK_MONOTONIC_RAW using clock_gettime()
with low latency. I do not think this is an unreasonable desire
or an expectation not encouraged by the documentation.

> But whatever you do, you really have to stop mixing clocks, that's
> broken, even if it magically works for now.
>

That is precisely what I am trying to avoid.

When comparing the CPU-perspective CPU_CLOCK values
with any other time values, I want to make sure a low-latency
non NTP / PTP adjusted value is  used.

I hope someone other than me can see the sense in above.

This is the latency I measure now with the timer_latency program
under 4.15.9 with the patch applied:
<quote><pre>
$ ./timer_latency
sum: 2313
Total time: 0.000002313S - Average Latency: 0.000000023S
$ ./timer_latency -m
sum: 5556
Total time: 0.000005556S - Average Latency: 0.000000055S


whereas before the patch was applied I measured latencies
of 300-1000ns for the CLOCK_MONOTONIC_RAW clock source.

This in itself to me makes the patch worth applying. I hope others
can see the sense in that.

Thanks & Best Regards,
Jason

--f40304355c444c1cb405675ee355
Content-Type: text/x-csrc; charset="US-ASCII"; name="timer_latency.c"
Content-Disposition: attachment; filename="timer_latency.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: file0

LyogCiAqIFByb2dyYW0gdG8gbWVhc3VyZSBoaWdoLXJlcyB0aW1lciBsYXRlbmN5LgogKgogKi8K
I2luY2x1ZGUgPHN0ZGludC5oPgojaW5jbHVkZSA8c3RkYm9vbC5oPgojaW5jbHVkZSA8c3lzL3R5
cGVzLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KI2luY2x1ZGUgPHRpbWUuaD4KI2luY2x1ZGUgPGVy
cm5vLmg+CiNpbmNsdWRlIDxzdHJpbmcuaD4KI2luY2x1ZGUgPHN0ZGlvLmg+CgojaWZuZGVmIE5f
U0FNUExFUwojZGVmaW5lIE5fU0FNUExFUyAxMDAKI2VuZGlmCiNkZWZpbmUgX1NUUihfU18pICNf
U18KI2RlZmluZSBTVFIoX1NfKSBfU1RSKF9TXykKCmludCBtYWluKGludCBhcmdjLCBjaGFyICpj
b25zdCogYXJndiwgY2hhciAqY29uc3QqIGVudnApCnsgY2xvY2tpZF90IGNsayA9IENMT0NLX01P
Tk9UT05JQ19SQVc7CiAgYm9vbCBkb19kdW1wID0gZmFsc2U7CiAgaW50IGFyZ249MTsKICBmb3Io
OyBhcmduIDwgYXJnYzsgYXJnbis9MSkKICAgIGlmKCBhcmd2W2FyZ25dICE9IE5VTEwgKQogICAg
ICBpZiggKihhcmd2W2FyZ25dKSA9PSAnLScpCglzd2l0Y2goICooYXJndlthcmduXSsxKSApCgl7
IGNhc2UgJ20nOgoJICBjYXNlICdNJzoKCSAgICBjbGsgPSBDTE9DS19NT05PVE9OSUM7CgkgICAg
YnJlYWs7CgkgIGNhc2UgJ2QnOgoJICBjYXNlICdEJzoKCSAgICBkb19kdW1wID0gdHJ1ZTsKCSAg
ICBicmVhazsKCWNhc2UgJz8nOgoJY2FzZSAnaCc6CgljYXNlICd1JzoKCWNhc2UgJ1UnOgoJY2Fz
ZSAnSCc6CgkgIGZwcmludGYoc3RkZXJyLCJVc2FnZTogdGltZXJfbGF0ZW5jeSBbIC1tIDogdXNl
IENMT0NLX01PTk9UT05JQyBjbG9jayAobm90IENMT0NLX01PTk9UT05JQ19SQVcpIDsgIC1kIDog
ZHVtcCB0aW1lc3BlYyBjb250ZW50cy4gTl9TQU1QTEVTOiAiIFNUUihOX1NBTVBMRVMpICJcblx0
IgoJICAgICAgICAgICJDYWxjdWxhdGVzIGF2ZXJhZ2UgdGltZXIgbGF0ZW5jeSAobWluaW11bSB0
aW1lIHRoYXQgY2FuIGJlIG1lYXN1cmVkKSBvdmVyIE5fU0FNUExFUy5cbiIKCSAgKTsKCSAgcmV0
dXJuIDA7Cgl9CiAgc3RydWN0IHRpbWVzcGVjIHNhbXBsZVtOX1NBTVBMRVMrMV07CiAgdW5zaWdu
ZWQgaW50IGNudD1OX1NBTVBMRVMsIHM9MCA7CiAgZG8KICB7IGlmKCAwICE9IGNsb2NrX2dldHRp
bWUoY2xrLCAmc2FtcGxlW3MrK10pICkKICAgIHsgZnByaW50ZihzdGRlcnIsIm9vcHMsIGNsb2Nr
X2dldHRpbWUoKSBmYWlsZWQ6ICVkOiAnJXMnLlxuIiwgZXJybm8sIHN0cmVycm9yKGVycm5vKSk7
CiAgICAgIHJldHVybiAxOwogICAgfQogIH13aGlsZSggLS1jbnQgKTsKICBjbG9ja19nZXR0aW1l
KGNsaywgJnNhbXBsZVtzXSk7CiNkZWZpbmUgVFMyTlMoX1RTXykgKCgoKHVuc2lnbmVkIGxvbmcg
bG9uZykoX1RTXykudHZfc2VjKSoxMDAwMDAwMDAwVUxMKSArICgoKHVuc2lnbmVkIGxvbmcgbG9u
ZykoKF9UU18pLnR2X25zZWMpKSkpIAogIHVuc2lnbmVkIGxvbmcgbG9uZwogICAgZGVsdGFzIFsg
Tl9TQU1QTEVTIF0KICAsIHQxLCB0Miwgc3VtPTAsIHpkPTAKICAsIHRfc3RhcnQgPSBUUzJOUyhz
YW1wbGVbMF0pOwogIGZvcihzPTE7IHMgPCAoTl9TQU1QTEVTKzEpOyBzKz0xKQogIHsgdDEgPSBU
UzJOUyhzYW1wbGVbcy0xXSk7CiAgICB0MiA9IFRTMk5TKHNhbXBsZVtzXSk7CiAgICBpZiAoIHQx
ID4gdDIgKQogICAgeyBmcHJpbnRmKHN0ZGVyciwiSW5jb25zaXN0ZW5jeTogJWxsdSAlbGx1ICVs
dS4lbHUgJWx1LiVsdVxuIiwgdDEgLCB0MgogICAgICAgICAgICAsIHNhbXBsZVtzLTFdLnR2X3Nl
Yywgc2FtcGxlW3MtMV0udHZfbnNlYwogICAgICAgICAgICAsIHNhbXBsZVtzXS50dl9zZWMsICAg
c2FtcGxlW3NdLnR2X25zZWMKICAgICAgKTsKICAgICAgY29udGludWU7CiAgICB9CiAgICB1bnNp
Z25lZCBsb25nIGxvbmcgZCA9dDItdDE7CiAgICBpZiAoIGQgPT0gMCApCiAgICB7IGlmKCB6ZCA9
PSAwICkKCWZwcmludGYoc3RkZXJyLCAiMCBkZWx0YSFcbiIpOwogICAgICB6ZCArPSAxOwogICAg
fQogICAgZGVsdGFzW3MtMV0gPSBkOwogICAgaWYoZG9fZHVtcCkKICAgICAgZnByaW50ZihzdGRl
cnIsICIlbHUgJWx1ICVsbHVcbiIsCiAgICAgICAgICAgICAgc2FtcGxlW3NdLnR2X3NlYywgc2Ft
cGxlW3NdLnR2X25zZWMsIGQKICAgICAgICAgICAgICk7CiAgfQogIGlmKCB6ZCA+IDAgKQogICAg
ZnByaW50ZihzdGRlcnIsIiV1IDAgZGVsdGFzXG4iKTsKICBmb3IocyA9IDA7IHMgPCBOX1NBTVBM
RVM7IHMrPTEpCiAgICBzdW0gKz0gZGVsdGFzW3NdOwogIGZwcmludGYoc3RkZXJyLCJzdW06ICVs
bHVcbiIsc3VtKTsKICB1bnNpZ25lZCBsb25nIGxvbmcgYXZnX25zID0gc3VtIC8gTl9TQU1QTEVT
OwogIHQxPSh0MiAtIHRfc3RhcnQpOwogIHByaW50ZigiVG90YWwgdGltZTogJTEuMWxsdS4lOS45
bGx1UyAtIEF2ZXJhZ2UgTGF0ZW5jeTogJTEuMWxsdS4lOS45bGx1U1xuIiwKICAgICAgICAgIHQx
IC8gMTAwMDAwMDAwMCwgICAgICAgdDEgJSAxMDAwMDAwMDAwLAogICAgICAgICAgYXZnX25zIC8g
MTAwMDAwMDAwMCwgICBhdmdfbnMgJSAxMDAwMDAwMDAwCiAgICAgICAgKTsKICByZXR1cm4gMDsK
fQoK
--f40304355c444c1cb405675ee355--
