Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752555AbeB1K4A (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 05:56:00 -0500
Received: from mga14.intel.com ([192.55.52.115]:5465 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752173AbeB1Kz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 05:55:59 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,405,1515484800";
   d="asc'?scan'208";a="33465944"
From: Felipe Balbi <felipe.balbi@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: HRTimer causing rtctest to fail
In-Reply-To: <alpine.DEB.2.21.1802281043050.1886@nanos.tec.linutronix.de>
References: <87vaei601x.fsf@linux.intel.com> <alpine.DEB.2.21.1802271640010.1886@nanos.tec.linutronix.de> <87muzt5usg.fsf@linux.intel.com> <alpine.DEB.2.21.1802281043050.1886@nanos.tec.linutronix.de>
Date: Wed, 28 Feb 2018 12:55:08 +0200
Message-ID: <87k1ux5qpf.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Thomas Gleixner <tglx@linutronix.de> writes:

> On Wed, 28 Feb 2018, Felipe Balbi wrote:
>> Thomas Gleixner <tglx@linutronix.de> writes:
>> > Enable the hrtimer and scheduling tracepoints. That should give you a =
hint
>> > what's going on.
>>=20
>> Thanks, that does give me a lot more information. So here you go:
>>=20
>>          rtctest-1348  [003] d..2   313.766141: hrtimer_start: hrtimer=
=3D00000000667ce595 function=3Drtc_pie_update_irq expires=3D313573983010 so=
ftexpires=3D313573983010 mode=3DREL
>>           <idle>-0     [003] d.h1   313.767189: hrtimer_expire_entry: hr=
timer=3D00000000667ce595 function=3Drtc_pie_update_irq now=3D313574053764
>>=20
>> We still have a 70754 nS deviation. After changing to absolute time,
>> the deviation remains:
>>
>>           <idle>-0     [000] dNh2    29.303251: hrtimer_start: hrtimer=
=3D000000006858b496 function=3Drtc_pie_update_irq expires=3D28765551360 sof=
texpires=3D28765551360 mode=3DABS
>>           <idle>-0     [000] d.h1    29.303565: hrtimer_expire_entry: hr=
timer=3D000000006858b496 function=3Drtc_pie_update_irq now=3D28765621916
>
> Changing REL/ABS in the kernel does not make a difference because periodic
> mode just forwards by period so even if the first timer is started with R=
EL
> it results in a absolute timeline. What I meant is the user space
> measurement as it cannot figure out when the first event was supposed to
> happen so it's hard to calculate latency information.
>
> The interesting information is that the timer fires late and the system is
> idle. Now the question is in which idle state did the machine go?
>
> Wake up from deeper C-states can be slow. On my laptop the wakeup latenci=
es
> are:
>
> POLL	   0
> C1	   2
> C1E	  10
> C3	  33
> C6	 133
> C7S	 166
> C8	 300
> C9	 600
> C10	2600
>
> All numbers in micro seconds! What happens if you load the system or
> restrict C-States?

added intel_idle.max_cstate=3D0 to cmdline. Still see some failures,
albeit a lot more rare, for example, caught one on iteration 8 of
8192Hz:

8192Hz:	 1 2 3 4 5 6 7
PIE delta error: 0.000135 should be close to 0.000122

That is, however, only 13 uS late. Is that within the limits of "we
don't quite care"? BTW, it took some effort to get that one
failure. I'll leave rtctest running in a long loop and try to figure out
approximately how frequently it fails, but it seems like it's within the
realm of "don't care", would you agree?

cheers

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlqWiowACgkQzL64meEa
mQaCEg//XtObRzDtTuf9V/AQbZG9s4lUCdFWt6XletjGgrsnXKctP7e3eH0zNxkV
j/XIMybaTnRBn/1m9g4eHS3SL3bFJCSOXq8dEs8fFUBipSbv7NZi8uKL9kxgxaHa
IRG4cTl1iEMU22jXZDZzWtyZ3+IJoPQ1FYs4Y5Qk0ATabziU0MpS9B9diJS+CUs7
X8zLc/3IleJCtlo387b644xj7q8g+Q4BMxKPUSbjqSoLvRwpfELgnr//I+sbNP7Z
cqtzlES8FvaAu/basTC57JtVSaDdp/ZYWXg7WzRM8fszvmXTEXuIzmHRHIpjCShm
sZlPc/my4Gc13OwcvnLN8uMFamvGofCxZPIaltW8UFmcncgEyGXM/z/R53WR2CJA
zvwqbKRttdAtJDfzsksoUr9W8Ea4yM1R921cziywW6vs/2gkeC04BbXq4JfOV1Ni
dRgFWC9StXaKFlZ7sGE5WfDo5VeeFK5FNLNVKLCYq3cFihVpF2AqJBotdr+Yti/J
6zn4vGLOWNm1X0zJeWtmco1u5IqlViGsaxvV0IwUwp8yFqTZIjB3r9thgPKA+gmR
8nij/rFl/0kFBpOm5PbqfIII3Pcl6wI185Ei9HnJrTGSf689qr5swvBS/T8ryw04
OoQZC88MJEU8vK/2/SzdayAVzryegMvYXIABjQfAWQrr7FKnYQY=
=8BHA
-----END PGP SIGNATURE-----
--=-=-=--
