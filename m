Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932895AbeCMXps (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 19:45:48 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:42131 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932511AbeCMXpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 19:45:47 -0400
X-Google-Smtp-Source: AG47ELsLZhZS2pP40oL8fvclt5ssMJHUOPH0pMmXY9uToore4zQrFIdgvR9PslmekIJCqjHUVxO8OCaZp2MyKpPrmEg=
MIME-Version: 1.0
In-Reply-To: <20180312082741.GD4064@hirez.programming.kicks-ass.net>
References: <d109ixq7.fsf@gmail.com> <20180312082741.GD4064@hirez.programming.kicks-ass.net>
From: Jason Vas Dias <jason.vas.dias@gmail.com>
Date: Tue, 13 Mar 2018 23:45:45 +0000
Message-ID: <CALyZvKxKXWiFF9OYtykXEfnx-k+xaAM7XREEQ+N58oJtOTZhew@mail.gmail.com>
Subject: Re: [PATCH v4.16-rc4 2/2] x86/vdso: on Intel, VDSO should handle CLOCK_MONOTONIC_RAW
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, andi <andi@firstfloor.org>
Content-Type: multipart/mixed; boundary="f4f5e808eae0837e5b056753db46"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--f4f5e808eae0837e5b056753db46
Content-Type: text/plain; charset="UTF-8"

On 12/03/2018, Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Mar 12, 2018 at 07:01:20AM +0000, Jason Vas Dias wrote:
>>   Sometimes, particularly when correlating elapsed time to performance
>>   counter values,
>
> So what actual problem are you tring to solve here? Perf can already
> give you sample time in various clocks, including MONOTONIC_RAW.
>
>

Yes, I am sampling perf counters, including CPU_CYCLES , INSTRUCTIONS,
CPU_CLOCK, TASK_CLOCK, etc, in a Group FD I open with
perf_event_open() , for the current thread on the current CPU -
I am doing this for 4 threads , on Intel & ARM cpus.

Reading performance counters does involve  2 ioctls and a read() ,
which takes time that  already far exceeds the time required to read
the TSC or CNTPCT in the VDSO .

The CPU_CLOCK software counter should give the converted TSC cycles
seen between the ioctl( grp_fd, PERF_EVENT_IOC_ENABLE , ...)
and the  ioctl( grp_fd, PERF_EVENT_IOC_DISABLE ), and the
difference between the event->time_running and time_enabled
should also measure elapsed time .

This gives the "inner" elapsed time, from the perpective of the kernel,
while the measured code section had the counters enabled.

But unless the user-space program  also has a way of measuring elapsed time
from the CPU's perspective , ie. without being subject to operator or NTP / PTP
adjustment, it has no way of correlating this inner elapsed time with
any "outer"
elapsed time measurement it may have made - I also measure the time
taken by I/O operations between threads, for instance.

So that is my primary motivation - for each thread's main run loop, I
enable performance counters and count several PMU counters
and the CPU_CLOCK & TASK_CLOCK .  I want to determine
with maximal accuracy how much elapsed time was used
actually executing the task's instructions on the CPU ,
and how long they took to execute.
I want to try to exclude the time spent gathering and making
and analysing the performance measurements from the
time spent running the threads' main loop .

To do this accurately, it is best to exclude variations in time
that occur because of operator or NTP / PTP adjustments .

The CLOCK_MONOTONIC_RAW clock is the ONLY
clock that is MEANT to be immune from any adjustment.

It is meant to be high - resolution clock with 1ns resolution
that should be subject to no adjustment, and hence one would expect
it it have the lowest latency.

But the way Linux has up to now implemented it , CLOCK_MONOTONIC_RAW
has a resolution (minimum time that can be measured)
that varies from 300 - 1000ns .

I can read the TSC  and store a 16-byte timespec value in @ 8ns
on the same CPU .

I understand that linux must conform to the POSIX interface which
means it cannot provide sub-nanosecond resolution timers, but
it could allow user-space programs to easily discover the timer calibration
so that user-space programs can read the timers themselves.

Currently, users must parse the log file or use gdb / objdump to
inspect /proc/kcore to get the TSC calibration and exact
mult+shift values for the TSC value conversion.

Intel does not publish, nor does the CPU come with in ROM or firmware,
the actual precise TSC frequency - this must be calibrated against the
other clocks , according to a complicated procedure in section 18.2 of
the SDM . My TSC has a "rated" / nominal TSC frequency , which one
can compute from CPUID leaves, of 2.3ghz, but the "Refined TSC frequency"
is 2.8333ghz .

Hence I think Linux should export this calibrated frequency somehow ;
its "calibration" is expressed as the raw clocksource 'mult' and 'shift'
values, and is exported to the VDSO .

I think the VDSO should read the TSC and use the calibration
to render the raw, unadjusted time from the CPU's perspective.

Hence, the patch I am preparing , which is again attached.

I will submit it properly via email once I figure out
how to obtain the 'git-send-mail' tool, and how to
use it to send multiple patches, which seems
to be the only way to submit acceptable patches.

Also the attached timer program measures a latency
of @ 20ns with my patch 4.15.9 kernel, when it
measured a latency of 300-1000ns without it.

Thanks & Regards,

Jason

--f4f5e808eae0837e5b056753db46
Content-Type: application/octet-stream;
	name="vdso_clock_monotonic_raw_1.patch"
Content-Disposition: attachment; filename="vdso_clock_monotonic_raw_1.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: file1

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2VudHJ5L3Zkc28vdmNsb2NrX2dldHRpbWUuYyBiL2FyY2gv
eDg2L2VudHJ5L3Zkc28vdmNsb2NrX2dldHRpbWUuYwppbmRleCBmMTk4NTZkLi5mYmM3MzcxIDEw
MDY0NAotLS0gYS9hcmNoL3g4Ni9lbnRyeS92ZHNvL3ZjbG9ja19nZXR0aW1lLmMKKysrIGIvYXJj
aC94ODYvZW50cnkvdmRzby92Y2xvY2tfZ2V0dGltZS5jCkBAIC0xODIsNiArMTgyLDE4IEBAIG5v
dHJhY2Ugc3RhdGljIHU2NCB2cmVhZF90c2Modm9pZCkKIAlyZXR1cm4gbGFzdDsKIH0KIAorbm90
cmFjZSBzdGF0aWMgdTY0IHZyZWFkX3RzY19yYXcodm9pZCkKK3sKKwl1NjQgdHNjCisJICAsIGxh
c3QgPSBndG9kLT5yYXdfY3ljbGVfbGFzdDsKKworCXRzYwkgICAgICA9IHJkdHNjX29yZGVyZWQo
KTsKKwlpZiAobGlrZWx5KHRzYyA+PSBsYXN0KSkKKwkJcmV0dXJuIHRzYzsKKwlhc20gdm9sYXRp
bGUgKCIiKTsKKwlyZXR1cm4gbGFzdDsKK30KKwogbm90cmFjZSBzdGF0aWMgaW5saW5lIHU2NCB2
Z2V0c25zKGludCAqbW9kZSkKIHsKIAl1NjQgdjsKQEAgLTIwMyw2ICsyMTUsMjcgQEAgbm90cmFj
ZSBzdGF0aWMgaW5saW5lIHU2NCB2Z2V0c25zKGludCAqbW9kZSkKIAlyZXR1cm4gdiAqIGd0b2Qt
Pm11bHQ7CiB9CiAKK25vdHJhY2Ugc3RhdGljIGlubGluZSB1NjQgdmdldHNuc19yYXcoaW50ICpt
b2RlKQoreworCXU2NCB2OworCWN5Y2xlc190IGN5Y2xlczsKKworCWlmIChndG9kLT52Y2xvY2tf
bW9kZSA9PSBWQ0xPQ0tfVFNDKQorCQljeWNsZXMgPSB2cmVhZF90c2NfcmF3KCk7CisjaWZkZWYg
Q09ORklHX1BBUkFWSVJUX0NMT0NLCisJZWxzZSBpZiAoZ3RvZC0+dmNsb2NrX21vZGUgPT0gVkNM
T0NLX1BWQ0xPQ0spCisJCWN5Y2xlcyA9IHZyZWFkX3B2Y2xvY2sobW9kZSk7CisjZW5kaWYKKyNp
ZmRlZiBDT05GSUdfSFlQRVJWX1RTQ1BBR0UKKwllbHNlIGlmIChndG9kLT52Y2xvY2tfbW9kZSA9
PSBWQ0xPQ0tfSFZDTE9DSykKKwkJY3ljbGVzID0gdnJlYWRfaHZjbG9jayhtb2RlKTsKKyNlbmRp
ZgorCWVsc2UKKwkJcmV0dXJuIDA7CisJdiA9IChjeWNsZXMgLSBndG9kLT5yYXdfY3ljbGVfbGFz
dCkgJiBndG9kLT5yYXdfbWFzazsKKwlyZXR1cm4gdiAqIGd0b2QtPnJhd19tdWx0OworfQorCiAv
KiBDb2RlIHNpemUgZG9lc24ndCBtYXR0ZXIgKHZkc28gaXMgNGsgYW55d2F5KSBhbmQgdGhpcyBp
cyBmYXN0ZXIuICovCiBub3RyYWNlIHN0YXRpYyBpbnQgX19hbHdheXNfaW5saW5lIGRvX3JlYWx0
aW1lKHN0cnVjdCB0aW1lc3BlYyAqdHMpCiB7CkBAIC0yNDYsNiArMjc5LDI3IEBAIG5vdHJhY2Ug
c3RhdGljIGludCBfX2Fsd2F5c19pbmxpbmUgZG9fbW9ub3RvbmljKHN0cnVjdCB0aW1lc3BlYyAq
dHMpCiAJcmV0dXJuIG1vZGU7CiB9CiAKK25vdHJhY2Ugc3RhdGljIF9fYWx3YXlzX2lubGluZSBp
bnQgZG9fbW9ub3RvbmljX3JhdyhzdHJ1Y3QgdGltZXNwZWMgKnRzKQoreworCXVuc2lnbmVkIGxv
bmcgc2VxOworCXU2NCBuczsKKwlpbnQgbW9kZTsKKworCWRvIHsKKwkJc2VxID0gZ3RvZF9yZWFk
X2JlZ2luKGd0b2QpOworCQltb2RlID0gZ3RvZC0+dmNsb2NrX21vZGU7CisJCXRzLT50dl9zZWMg
PSBndG9kLT5tb25vdG9uaWNfdGltZV9yYXdfc2VjOworCQlucyA9IGd0b2QtPm1vbm90b25pY190
aW1lX3Jhd19uc2VjOworCQlucyArPSB2Z2V0c25zX3JhdygmbW9kZSk7CisJCW5zID4+PSBndG9k
LT5yYXdfc2hpZnQ7CisJfSB3aGlsZSAodW5saWtlbHkoZ3RvZF9yZWFkX3JldHJ5KGd0b2QsIHNl
cSkpKTsKKworCXRzLT50dl9zZWMgKz0gX19pdGVyX2Rpdl91NjRfcmVtKG5zLCBOU0VDX1BFUl9T
RUMsICZucyk7CisJdHMtPnR2X25zZWMgPSBuczsKKworCXJldHVybiBtb2RlOworfQorCiBub3Ry
YWNlIHN0YXRpYyB2b2lkIGRvX3JlYWx0aW1lX2NvYXJzZShzdHJ1Y3QgdGltZXNwZWMgKnRzKQog
ewogCXVuc2lnbmVkIGxvbmcgc2VxOwpAQCAtMjc3LDYgKzMzMSwxMCBAQCBub3RyYWNlIGludCBf
X3Zkc29fY2xvY2tfZ2V0dGltZShjbG9ja2lkX3QgY2xvY2ssIHN0cnVjdCB0aW1lc3BlYyAqdHMp
CiAJCWlmIChkb19tb25vdG9uaWModHMpID09IFZDTE9DS19OT05FKQogCQkJZ290byBmYWxsYmFj
azsKIAkJYnJlYWs7CisJY2FzZSBDTE9DS19NT05PVE9OSUNfUkFXOgorCQlpZiAoZG9fbW9ub3Rv
bmljX3Jhdyh0cykgPT0gVkNMT0NLX05PTkUpCisJCQlnb3RvIGZhbGxiYWNrOworCQlicmVhazsK
IAljYXNlIENMT0NLX1JFQUxUSU1FX0NPQVJTRToKIAkJZG9fcmVhbHRpbWVfY29hcnNlKHRzKTsK
IAkJYnJlYWs7CmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9lbnRyeS92c3lzY2FsbC92c3lzY2FsbF9n
dG9kLmMgYi9hcmNoL3g4Ni9lbnRyeS92c3lzY2FsbC92c3lzY2FsbF9ndG9kLmMKaW5kZXggZTEy
MTZkZC4uNWFmNzA5MyAxMDA2NDQKLS0tIGEvYXJjaC94ODYvZW50cnkvdnN5c2NhbGwvdnN5c2Nh
bGxfZ3RvZC5jCisrKyBiL2FyY2gveDg2L2VudHJ5L3ZzeXNjYWxsL3ZzeXNjYWxsX2d0b2QuYwpA
QCAtNDUsNiArNDUsMTEgQEAgdm9pZCB1cGRhdGVfdnN5c2NhbGwoc3RydWN0IHRpbWVrZWVwZXIg
KnRrKQogCXZkYXRhLT5tdWx0CQk9IHRrLT50a3JfbW9uby5tdWx0OwogCXZkYXRhLT5zaGlmdAkJ
PSB0ay0+dGtyX21vbm8uc2hpZnQ7CiAKKwl2ZGF0YS0+cmF3X2N5Y2xlX2xhc3QJPSB0ay0+dGty
X3Jhdy5jeWNsZV9sYXN0OworCXZkYXRhLT5yYXdfbWFzawkJPSB0ay0+dGtyX3Jhdy5tYXNrOwor
CXZkYXRhLT5yYXdfbXVsdAkJPSB0ay0+dGtyX3Jhdy5tdWx0OworCXZkYXRhLT5yYXdfc2hpZnQJ
PSB0ay0+dGtyX3Jhdy5zaGlmdDsKKwogCXZkYXRhLT53YWxsX3RpbWVfc2VjCQk9IHRrLT54dGlt
ZV9zZWM7CiAJdmRhdGEtPndhbGxfdGltZV9zbnNlYwkJPSB0ay0+dGtyX21vbm8ueHRpbWVfbnNl
YzsKIApAQCAtNzQsNSArNzksOCBAQCB2b2lkIHVwZGF0ZV92c3lzY2FsbChzdHJ1Y3QgdGltZWtl
ZXBlciAqdGspCiAJCXZkYXRhLT5tb25vdG9uaWNfdGltZV9jb2Fyc2Vfc2VjKys7CiAJfQogCisJ
dmRhdGEtPm1vbm90b25pY190aW1lX3Jhd19zZWMgID0gdGstPnJhd19zZWM7CisJdmRhdGEtPm1v
bm90b25pY190aW1lX3Jhd19uc2VjID0gdGstPnRrcl9yYXcueHRpbWVfbnNlYzsKKwogCWd0b2Rf
d3JpdGVfZW5kKHZkYXRhKTsKIH0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3Zn
dG9kLmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS92Z3RvZC5oCmluZGV4IGZiODU2YzkuLjI0ZTRk
NDUgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3ZndG9kLmgKKysrIGIvYXJjaC94
ODYvaW5jbHVkZS9hc20vdmd0b2QuaApAQCAtMjIsNiArMjIsMTAgQEAgc3RydWN0IHZzeXNjYWxs
X2d0b2RfZGF0YSB7CiAJdTY0CW1hc2s7CiAJdTMyCW11bHQ7CiAJdTMyCXNoaWZ0OworCXU2NAly
YXdfY3ljbGVfbGFzdDsKKwl1NjQJcmF3X21hc2s7CisJdTMyCXJhd19tdWx0OworCXUzMglyYXdf
c2hpZnQ7CiAKIAkvKiBvcGVuIGNvZGVkICdzdHJ1Y3QgdGltZXNwZWMnICovCiAJdTY0CQl3YWxs
X3RpbWVfc25zZWM7CkBAIC0zMiw2ICszNiw4IEBAIHN0cnVjdCB2c3lzY2FsbF9ndG9kX2RhdGEg
ewogCWd0b2RfbG9uZ190CXdhbGxfdGltZV9jb2Fyc2VfbnNlYzsKIAlndG9kX2xvbmdfdAltb25v
dG9uaWNfdGltZV9jb2Fyc2Vfc2VjOwogCWd0b2RfbG9uZ190CW1vbm90b25pY190aW1lX2NvYXJz
ZV9uc2VjOworCWd0b2RfbG9uZ190CW1vbm90b25pY190aW1lX3Jhd19zZWM7CisJZ3RvZF9sb25n
X3QJbW9ub3RvbmljX3RpbWVfcmF3X25zZWM7CiAKIAlpbnQJCXR6X21pbnV0ZXN3ZXN0OwogCWlu
dAkJdHpfZHN0dGltZTsK
--f4f5e808eae0837e5b056753db46
Content-Type: text/x-csrc; charset="US-ASCII"; name="timer_latency.c"
Content-Disposition: attachment; filename="timer_latency.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: file2

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
fQogICAgZGVsdGFzW3MtMV0gPSBkOwogIH0KICBpZiggemQgPiAwICkKICAgIGZwcmludGYoc3Rk
ZXJyLCIldSAwIGRlbHRhc1xuIik7CiAgZm9yKHMgPSAwOyBzIDwgTl9TQU1QTEVTOyBzKz0xKQog
ICAgc3VtICs9IGRlbHRhc1tzXTsKICBmcHJpbnRmKHN0ZGVyciwic3VtOiAlbGx1XG4iLHN1bSk7
CiAgdW5zaWduZWQgbG9uZyBsb25nIGF2Z19ucyA9IHN1bSAvIE5fU0FNUExFUzsKICB0MT0odDIg
LSB0X3N0YXJ0KTsKICBwcmludGYoIlRvdGFsIHRpbWU6ICUxLjFsbHUuJTkuOWxsdVMgLSBBdmVy
YWdlIExhdGVuY3k6ICUxLjFsbHUuJTkuOWxsdVNcbiIsCiAgICAgICAgICB0MSAvIDEwMDAwMDAw
MDAsICAgICAgIHQxICUgMTAwMDAwMDAwMCwKICAgICAgICAgIGF2Z19ucyAvIDEwMDAwMDAwMDAs
ICAgYXZnX25zICUgMTAwMDAwMDAwMAogICAgICAgICk7CiAgcmV0dXJuIDA7Cn0KCg==
--f4f5e808eae0837e5b056753db46--
