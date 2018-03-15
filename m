Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752672AbeCOVlk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 17:41:40 -0400
Received: from mail-ot0-f174.google.com ([74.125.82.174]:42030 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751774AbeCOVli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 17:41:38 -0400
X-Google-Smtp-Source: AG47ELu0/bfwd3PBW9MwWIEFaqnGj23i08ixzwHuZuWEJwtlna5gSxZl2PZDXcNSvsFmYAoXWQfybJersDCgeJKCfHs=
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1803152047380.1520@nanos.tec.linutronix.de>
References: <1521129648-20889-1-git-send-email-jason.vas.dias@gmail.com> <alpine.DEB.2.21.1803152047380.1520@nanos.tec.linutronix.de>
From: Jason Vas Dias <jason.vas.dias@gmail.com>
Date: Thu, 15 Mar 2018 21:41:36 +0000
Message-ID: <CALyZvKwK9BEVHnS=SqU6j=aOsrcURjqWCRom1eMsz6Q8dbj9HQ@mail.gmail.com>
Subject: Re: [PATCH v4.16-rc5 (3)] x86/vdso: on Intel, VDSO should handle CLOCK_MONOTONIC_RAW
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, mingo@kernel.org,
        peterz@infradead.org, andi@firstfloor.org
Content-Type: multipart/mixed; boundary="001a1134f8363f554405677a5b29"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--001a1134f8363f554405677a5b29
Content-Type: text/plain; charset="UTF-8"

Hi Thomas -
RE:
On 15/03/2018, Thomas Gleixner <tglx@linutronix.de> wrote:
> Jason,
>
> On Thu, 15 Mar 2018, jason.vas.dias@gmail.com wrote:
>
>>   Resent to address reviewer comments.
>
> I was being patient so far and tried to guide you through the patch
> submission process, but unfortunately this turns out to be just waste of my
> time.
>
> You have not addressed any of the comments I made here:
>
> [1]
> https://lkml.kernel.org/r/alpine.DEB.2.21.1803141511340.2481@nanos.tec.linutronix.de
> [2]
> https://lkml.kernel.org/r/alpine.DEB.2.21.1803141527300.2481@nanos.tec.linutronix.de
>

I'm really sorry about that - I did not see those mails ,
and have searched for them in my inbox -
are you sure they were sent to 'linux-kernel@vger.kernel.org' ?
That is the only list I am subscribed to .
I clicked on the links , but the 'To:' field is just
'linux-kernel' .

If I had seen those messages before I re-submitted,
those issues would have been fixed.

checkpatch.pl did not report them -
I ran it with all patches and it reported
no errors .

And I did send the test results in a previous mail -

$ gcc -m64 -o timer timer.c

( must be compiled in 64-bit mode).

This is using the new rdtscp() function :
$ ./timer -r 100
...
Total time: 0.000002806S - Average Latency: 0.000000028S N zero
deltas: 0 N inconsistent deltas: 0
Average of 100 average latencies of 100 samples : 0.000000027S

This is using the rdtsc_ordered() function:

$ ./timer -m -r 100
Total time: 0.000005269S - Average Latency: 0.000000052S N zero
deltas: 0 N inconsistent deltas: 0
Average of 100 average latencies of 100 samples : 0.000000047S

timer.c is a very short program that just reads N_SAMPLES (a
compile-time option)
timespecs using either CLOCK_MONOTONIC_RAW (no -m) or CLOCK_MONOTONIC
first parameter to clock_gettime(),  then
computes the deltas as long long, then averages them , counting any
zero deltas, or deltas where the previous timespec is somehow
greater than the current timespec, which are reported as
inconsitencies (note 'inconistent deltas:0' and 'zero deltas: 0' in output).

So my initial claim that rdtscp() can be twice as fast as rdtsc_ordered()
was not far-fetched - this is what I am seeing .

I think this is because of the explicit barrier() call in rdtsc_ordered() .
This must be slower than than the internal processor pipeline
"cancellation point" (barrier) used by the rdtscp instruction itself.
This is the only reason for the rdtscp call  -  plus all modern Intel
& AMD CPUs support it, and it DOES solve the ordering problem,
whereby instructions in one pipeline of a task can get different
rdtsc() results than instructions in another pipeline.

I will document the results better in the ChangeLog , fix all issues
you identified, and resend .

I did not mean to ignore your comments -
those mails are nowhere in my Inbox -
please ,  confirm the actual email address
they are getting sent to.

Thanks & Regards,
Jason

--001a1134f8363f554405677a5b29
Content-Type: text/x-csrc; charset="US-ASCII"; name="timer.c"
Content-Disposition: attachment; filename="timer.c"
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
--001a1134f8363f554405677a5b29--
