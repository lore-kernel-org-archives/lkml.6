Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752948AbeCQWwY (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 18:52:24 -0400
Received: from mail-ot0-f182.google.com ([74.125.82.182]:35956 "EHLO
        mail-ot0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751809AbeCQWwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 18:52:22 -0400
X-Google-Smtp-Source: AG47ELsecyRXmM8uw+7l4BK+qBND11CS/TdnVwK0cZlMwgnae3a73ZJAVtGkKm4rcWp83thtMGI5Ucs/saMWtC36z1I=
MIME-Version: 1.0
From: Jason Vas Dias <jason.vas.dias@gmail.com>
Date: Sat, 17 Mar 2018 22:52:20 +0000
Message-ID: <CALyZvKx0aqhobdrvSUNptE4m3Gsf6+mZgm4G3BnVWKtwKSMfwg@mail.gmail.com>
Subject: re: [PATCH v4.16-rc5 (2)] x86/vdso: VDSO should handle
 clock_gettime(CLOCK_MONOTONIC_RAW) without syscall
To: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, mingo@kernel.org, peterz@infradead.org,
        andi@firstfloor.org
Content-Type: multipart/mixed; boundary="000000000000de81f90567a3935d"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000de81f90567a3935d
Content-Type: text/plain; charset="UTF-8"

Hi -

I submitted a new stripped-down to bare essentials version of
the patch, (see LKML emails with $subject)  which passes all
checkpatch.pl tests and addresses all concerns raised by reviewers,
which uses only rdtsc_ordered(), and which only only updates in
  vsyscall_gtod_data the new fields:
    u32 raw_mult,  raw_shift ; ...
    gtod_long_t  monotonic_time_raw_sec   /* == tk->raw_sec */ ,
		          monotonic_time_raw_nsec /* == tk->tkr_raw.nsec */;
(this is NOT the formatting used in vgtod.h - sorry about previous
 formatting issues .
) .

I don't see how one could present the raw timespec in user-space
properly without tk->tkr_raw.xtime_nsec and and tk->raw_sec ;
monotonic has gtod->monotonic_time_sec and gtod->monotonic_time_snsec,
and I am only trying to follow exactly the existing algorithm in
timekeeping.c's
getrawmonotonic64() .

When I submitted the initial version of this stripped down patch,
I got an email back from robot<lkp@intel.com> reporting a compilation
error saying :

>
>   arch/x86/entry/vdso/vclock_gettime.o: In function `__vdso_clock_gettime':
>   vclock_gettime.c:(.text+0xf7): undefined reference to >`__x86_indirect_thunk_rax'
>   /usr/bin/ld: arch/x86/entry/vdso/vclock_gettime.o: relocation R_X86_64_PC32 >against undefined symbol `__x86_indirect_thunk_rax' can not be used when making >a shared object; recompile with -fPIC
>   /usr/bin/ld: final link failed: Bad value
>>> collect2: error: ld returned 1 exit status
>--
>>> arch/x86/entry/vdso/vdso32.so.dbg: undefined symbols found
>--
>>> objcopy: 'arch/x86/entry/vdso/vdso64.so.dbg': No such file
>---


I had fixed this problem with the patch to the RHEL kernel attached to
bug #198161 (attachment #274751:
https://bugzilla.kernel.org/attachment.cgi?id=274751) ,
 by simply reducing the number of clauses in __vdso_clock_gettime's
switch(clock) from 6 to 5 , but at the cost of an extra test of clock
& second switch(clock).

I reported this as GCC bug :
  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84908
because I don't think GCC should fail to do anything
for a switch with 6 clauses and not for one with 5, but
the response I got from H.J. Liu was:

H.J. Lu wrote @ 2018-03-16 22:13:27 UTC:
>
> vDSO isn't compiled with $(KBUILD_CFLAGS).  Why does your kernel do it?
>
> Please try my kernel patch at comment 4..
>

So that patch to the arch/x86/vdso/Makefile only prevents it enabling the
RETPOLINE_CFLAGS for building  the vDSO .

I defer to H.J.'s expertise on GCC + binutils & advisability of enabling
RETPOLINE_CFLAGS in the VDSO - GCC definitely behaves strangely
for the vDSO when RETPOLINE _CFLAGS  are enabled.

Please provide something like the patch in a future version of Linux ,
and I suggest not compiling the vDSO with RETPOLINE_CFLAGS
as does H.J. .

The inconsistency_check program in tools/testing/selftests/timers produces
no errors for long runs and the timer_latency.c program (attached) also
produces no errors and latencies of @ 20ns for CLOCK_MONOTONIC_RAW
and latencies of @ 40ns for CLOCK_MONOTONIC - this is however
with the additional rdtscp patches , and under 4.15.9, for use on my system ;
the 4.16-rc5 version submitted still uses barrier() + rdtsc  , and
that has  a latency
of @ 30ns for CLOCK_MONOTONIC_RAW and @40ns for CLOCK_MONOTONIC ; but
both are much, much better that
200-1000ns for CLOCK_MONOTONIC_RAW that the unpatched
kernels have (all times refer to 'Average Latency' output produced
by 'timer_latency.c').

I do apologize for whitespace errors, unread emails and resends and confusion
of previous emails - I now understand the process and standards much better
and will attempt to adhere to them more closely in future.

Thanks & Best Regards,
Jason Vas Dias

--000000000000de81f90567a3935d
Content-Type: text/x-csrc; charset="US-ASCII"; name="timer_latency.c"
Content-Disposition: attachment; filename="timer_latency.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: file0

LyogCiAqIFByb2dyYW0gdG8gbWVhc3VyZSBoaWdoLXJlcyB0aW1lciBsYXRlbmN5LgogKgogKi8K
I2luY2x1ZGUgPHN0ZGludC5oPgojaW5jbHVkZSA8c3RkYm9vbC5oPgojaW5jbHVkZSA8c3lzL3R5
cGVzLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KI2luY2x1ZGUgPHRpbWUuaD4KI2luY2x1ZGUgPGVy
cm5vLmg+CiNpbmNsdWRlIDxhbGxvY2EuaD4KI2luY2x1ZGUgPHN0cmluZy5oPgojaW5jbHVkZSA8
c3RkaW8uaD4KI2luY2x1ZGUgPHN0ZGxpYi5oPgoKI2lmbmRlZiBOX1NBTVBMRVMKI2RlZmluZSBO
X1NBTVBMRVMgMTAwCiNlbmRpZgojZGVmaW5lIF9TVFIoX1NfKSAjX1NfCiNkZWZpbmUgU1RSKF9T
XykgX1NUUihfU18pCgojZGVmaW5lIFRTMk5TKF9UU18pICgoKCh1bnNpZ25lZCBsb25nIGxvbmcp
KF9UU18pLnR2X3NlYykqMTAwMDAwMDAwMFVMTCkgKyAoKCh1bnNpZ25lZCBsb25nIGxvbmcpKChf
VFNfKS50dl9uc2VjKSkpKSAKCmludCBtYWluKGludCBhcmdjLCBjaGFyICpjb25zdCogYXJndiwg
Y2hhciAqY29uc3QqIGVudnApCnsgc3RydWN0IHRpbWVzcGVjIHNhbXBsZVtOX1NBTVBMRVMrMV07
CiAgdW5zaWduZWQgaW50IGNudD1OX1NBTVBMRVMsIHM9MCAsIGF2Z19uPTA7CiAgdW5zaWduZWQg
bG9uZyBsb25nCiAgICBkZWx0YXMgWyBOX1NBTVBMRVMgXQogICAgLCB0MSwgdDIsIHN1bT0wLCB6
ZD0wLCBpYz0wLCBkCiAgICAsIHRfc3RhcnQsIGF2Z19ucywgKmF2Z3M9MDsKICBjbG9ja2lkX3Qg
Y2xrID0gQ0xPQ0tfTU9OT1RPTklDX1JBVzsKICBib29sIGRvX2R1bXAgPSBmYWxzZTsKICBpbnQg
YXJnbj0xLCByZXBlYXQ9MTsKICBmb3IoOyBhcmduIDwgYXJnYzsgYXJnbis9MSkKICAgIGlmKCBh
cmd2W2FyZ25dICE9IE5VTEwgKQogICAgICBpZiggKihhcmd2W2FyZ25dKSA9PSAnLScpCglzd2l0
Y2goICooYXJndlthcmduXSsxKSApCgl7IGNhc2UgJ20nOgoJICBjYXNlICdNJzoKCSAgICBjbGsg
PSBDTE9DS19NT05PVE9OSUM7CgkgICAgYnJlYWs7CgkgIGNhc2UgJ2QnOgoJICBjYXNlICdEJzoK
CSAgICBkb19kdW1wID0gdHJ1ZTsKCSAgICBicmVhazsKICAgICAJICBjYXNlICdyJzoKICAgICAg
CSAgY2FzZSAnUic6CgkgICAgaWYoIChhcmduIDwgYXJnYykgJiYgKGFyZ3ZbYXJnbisxXSAhPSBO
VUxMKSkKCSAgICAgIHJlcGVhdCA9IGF0b2koYXJndlthcmduKz0xXSk7CgkgICAgYnJlYWs7Cgkg
IGNhc2UgJz8nOgoJICBjYXNlICdoJzoKCSAgY2FzZSAndSc6CgkgIGNhc2UgJ1UnOgoJICBjYXNl
ICdIJzoKCSAgICBmcHJpbnRmKHN0ZGVyciwiVXNhZ2U6IHRpbWVyX2xhdGVuY3kgW1xuXHQtbSA6
IHVzZSBDTE9DS19NT05PVE9OSUMgY2xvY2sgKG5vdCBDTE9DS19NT05PVE9OSUNfUkFXKVxuXHQt
ZCA6IGR1bXAgdGltZXNwZWMgY29udGVudHMuIE5fU0FNUExFUzogIiBTVFIoTl9TQU1QTEVTKSAi
XG5cdCIKCSAgICAgICAgICAgICItciA8cmVwZWF0IGNvdW50PlxuXVx0IiAKCSAgICAgICAgICAg
ICJDYWxjdWxhdGVzIGF2ZXJhZ2UgdGltZXIgbGF0ZW5jeSAobWluaW11bSB0aW1lIHRoYXQgY2Fu
IGJlIG1lYXN1cmVkKSBvdmVyIE5fU0FNUExFUy5cbiIKCSAgICAgICAgICAgKTsKCSAgICByZXR1
cm4gMDsKCX0KICBpZiggcmVwZWF0ID4gMSApCiAgeyBhdmdzPWFsbG9jYShzaXplb2YodW5zaWdu
ZWQgbG9uZyBsb25nKSAqIChOX1NBTVBMRVMgKyAxKSk7CiAgICBpZiggKCh1bnNpZ25lZCBsb25n
KSBhdmdzKSAmIDcgKQogICAgICBhdmdzID0gKCh1bnNpZ25lZCBsb25nIGxvbmcqKSgoKHVuc2ln
bmVkIGNoYXIqKWF2Z3MpKyg4LSgodW5zaWduZWQgbG9uZykgYXZncykgJiA3KSkpOwogIH0KICBk
byB7CiAgICBjbnQ9Tl9TQU1QTEVTOwogICAgcz0wOwogIGRvCiAgeyBpZiggMCAhPSBjbG9ja19n
ZXR0aW1lKGNsaywgJnNhbXBsZVtzKytdKSApCiAgICB7IGZwcmludGYoc3RkZXJyLCJvb3BzLCBj
bG9ja19nZXR0aW1lKCkgZmFpbGVkOiAlZDogJyVzJy5cbiIsIGVycm5vLCBzdHJlcnJvcihlcnJu
bykpOwogICAgICByZXR1cm4gMTsKICAgIH0KICB9d2hpbGUoIC0tY250ICk7CiAgY2xvY2tfZ2V0
dGltZShjbGssICZzYW1wbGVbc10pOwogIGZvcihzPTE7IHMgPCAoTl9TQU1QTEVTKzEpOyBzKz0x
KQogIHsgdDEgPSBUUzJOUyhzYW1wbGVbcy0xXSk7CiAgICB0MiA9IFRTMk5TKHNhbXBsZVtzXSk7
CiAgICBpZiAoICh0MSA+IHQyKQogICAgICAgfHwoc2FtcGxlW3MtMV0udHZfc2VjID4gc2FtcGxl
W3NdLnR2X3NlYykKICAgICAgIHx8KChzYW1wbGVbcy0xXS50dl9zZWMgPT0gc2FtcGxlW3NdLnR2
X3NlYykKICAgICAgICAmJihzYW1wbGVbcy0xXS50dl9uc2VjID4gc2FtcGxlW3NdLnR2X25zZWMp
CiAgICAgICAgICkKICAgICAgICkKICAgIHsgZnByaW50ZihzdGRlcnIsIkluY29uc2lzdGVuY3k6
ICVsbHUgJWxsdSAlbHUuJWx1ICVsdS4lbHVcbiIsIHQxICwgdDIKICAgICAgICAgICAgLCBzYW1w
bGVbcy0xXS50dl9zZWMsIHNhbXBsZVtzLTFdLnR2X25zZWMKICAgICAgICAgICAgLCBzYW1wbGVb
c10udHZfc2VjLCAgIHNhbXBsZVtzXS50dl9uc2VjCiAgICAgICk7CiAgICAgIGljKz0xOwogICAg
ICBjb250aW51ZTsKICAgIH0KICAgIGQgPSB0MiAtIHQxOwogICAgaWYgKCBkID09IDAgKQogICAg
eyAgemQgKz0gMTsKICAgIH0KICAgIGRlbHRhc1tzLTFdID0gZDsKICAgIGlmKGRvX2R1bXApCiAg
ICAgIGZwcmludGYoc3RkZXJyLCAiJWx1ICVsdSAlbGx1XG4iLAogICAgICAgICAgICAgIHNhbXBs
ZVtzXS50dl9zZWMsIHNhbXBsZVtzXS50dl9uc2VjLCBkCiAgICAgICAgICAgICApOwogIH0KICBm
b3IocyA9IDAsIHN1bT0wOyBzIDwgTl9TQU1QTEVTOyBzKz0xKQogICAgc3VtICs9IGRlbHRhc1tz
XTsKICBmcHJpbnRmKHN0ZGVyciwic3VtOiAlbGx1XG4iLHN1bSk7CiAgYXZnX25zID0gc3VtIC8g
Tl9TQU1QTEVTOwogIHRfc3RhcnQgPSBUUzJOUyhzYW1wbGVbMF0pOwogIHQxPSh0MiAtIHRfc3Rh
cnQpOwogIHByaW50ZigiVG90YWwgdGltZTogJTEuMWxsdS4lOS45bGx1UyAtIEF2ZXJhZ2UgTGF0
ZW5jeTogJTEuMWxsdS4lOS45bGx1UyBOIHplcm8gZGVsdGFzOiAldSBOIGluY29uc2lzdGVudCBk
ZWx0YXM6ICV1XG4iLAogICAgICAgICAgdDEgLyAxMDAwMDAwMDAwLCAgICAgICB0MSAlIDEwMDAw
MDAwMDAsCiAgICAgICAgICBhdmdfbnMgLyAxMDAwMDAwMDAwLCAgIGF2Z19ucyAlIDEwMDAwMDAw
MDAgLAogICAgICAgICAgemQsIGljCiAgICAgICAgKTsKICBpZiAoYXZncyAhPSAoKHZvaWQqKTBV
TCkpCiAgICBhdmdzW2F2Z19uKytdID0gYXZnX25zOwogIH0gd2hpbGUgKC0tcmVwZWF0KTsKICBp
ZiAoYXZncyAhPSAoKHZvaWQqKTBVTCkpCiAgeyBmb3IoIHM9MCwgc3VtPTA7IHMgPCBhdmdfbjsg
cys9MSkKICAgICAgc3VtICs9IGF2Z3Nbc107CiAgICBwcmludGYoIkF2ZXJhZ2Ugb2YgJXUgYXZl
cmFnZSBsYXRlbmNpZXMgb2YgIiBTVFIoTl9TQU1QTEVTKSAiIHNhbXBsZXMgOiAlMS4xbGx1LiU5
LjlsbHVTXG4iCiAgICAgICAgICAsIGF2Z19uLCAoc3VtIC8gTl9TQU1QTEVTKSAvIDEwMDAwMDAw
MDAsIChzdW0gLyBOX1NBTVBMRVMpICUgMTAwMDAwMDAwMAogICAgICAgICAgKTsKICB9CiAgcmV0
dXJuIDA7Cn0KCg==
--000000000000de81f90567a3935d--
