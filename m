Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0DAC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E6C20844
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=online.net header.i=@online.net header.b="3rg6qNAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730713AbfBFNZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:25:22 -0500
Received: from smtpauth-dc2.online.net ([62.210.16.40]:41112 "EHLO
        smtpauth-dc2-1.online.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728673AbfBFNZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:25:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=online.net; s=folays2;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:In-Reply-To:References:To:From; bh=JZpG9OzZfpZQJ5Il9kqVBmckmBoxtphHKJjG3plyGlo=;
        b=3rg6qNAxp5TmNg7bAlNOLSyx0vSwuJZfz9dXinGPadwQv2Qe8erXMqahYVDChrJHpVIBXACS5U+Qd06rN0MJNIjPmqgvf3F5wtdoTGA7X82iaAu9R7ZhviFA+yWPKtFnpFE58JRgWLaqK2QEKAqVuv/hLuq0XXVdH3lAkZaj6a4=;
Received: from [185.18.169.48] (helo=FMAPORT)
        by smtpauth-dc2-1.online.net with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA256:256)
        (Exim 4.82)
        (envelope-from <frederic.mathieu@dualis.com>)
        id 1grNCY-0004rw-8P; Wed, 06 Feb 2019 14:25:18 +0100
From:   =?utf-8?Q?Fr=C3=A9d=C3=A9ric_Mathieu?= 
        <frederic.mathieu@dualis.com>
To:     "'Dietmar Eggemann'" <dietmar.eggemann@arm.com>,
        <linux-kernel@vger.kernel.org>
References: <016801d4bd40$35c226e0$a14674a0$@dualis.com> <0c3a5c51-9694-fc3e-3cbb-abdbe398a09f@arm.com>
In-Reply-To: <0c3a5c51-9694-fc3e-3cbb-abdbe398a09f@arm.com>
Subject: RE: Kernel 4.9: strange behavior with fifo scheduler
Date:   Wed, 6 Feb 2019 14:25:18 +0100
Message-ID: <001c01d4be1f$67f74930$37e5db90$@dualis.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Content-Language: fr
Thread-Index: AQFAhKHPJ5+e53DwF6m03vUSRLNF7gH/m93XpusxwvA=
X-auth-smtp-user: frederic.mathieu@dualis.com
X-online-auth-user: FLEX_Q0Nxd0tVU0lrMm13S3FPSw==6qkTy6AqBrUYDaWjdJBILwIGvv4IgBoPcxkE
X-online-auth-smtp: FLEX_MldTOHN5dzBHdXM0cUtTbw==bwvUr7sRiJeSB8DCh40Fb4m5DF+QcalenXEClA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dietmar,

Attention !, these tests were executed on a kernel with the patch RT and =
the option CONFIG_PREEMPT_RT_FULL =3D y. I confirm the truth of my =
priority settings
On a vanilla kernel, I get the same results as you.

After talking with mike Galbraith, I turned my attention to the priority =
of kernel threads. The following link explains in the behavior of the =
scheduler :=20
https://wiki.linuxfoundation.org/realtime/documentation/technical_details=
/hr_timers

Contrary to what I thought, there is no dynamic adjustment of the =
priority according to the priority of the calling task.

-----Message d'origine-----
De : linux-kernel-owner@vger.kernel.org =
[mailto:linux-kernel-owner@vger.kernel.org] De la part de Dietmar =
Eggemann
Envoy=C3=A9 : mercredi 6 f=C3=A9vrier 2019 11:55
=C3=80 : Fr=C3=A9d=C3=A9ric Mathieu <frederic.mathieu@dualis.com>; =
linux-kernel@vger.kernel.org
Objet : Re: Kernel 4.9: strange behavior with fifo scheduler

Hi Fr=C3=A9d=C3=A9ric,

On 2/5/19 11:47 AM, Fr=C3=A9d=C3=A9ric Mathieu wrote:
> Hi,
>=20
> on an X86_64 architecture (Intel(R) Core(TM) i3-6100U CPU @ 2.30GHz),=20
> I use the linux kernel 4.9.146 with patch rt 125.
> uname -a: Linux 4.9.146-rt125 #1 SMP PREEMPT RT Tue Jan 29 14:17:55=20
> CET 2019
> x86_64 GNU/Linux
>=20
> I observed a strange behavior of the scheduler when several tasks are=20
> executed in FIFO mode on a CPU core and a significant CPU activity.
>=20
> first test (reference: cpu load=3D0%):
> cyclictest -m -D 5 -i 1000 -p 50 -a 0
>        	# / dev / cpu_dma_latency set to 0us
>        	policy: fifo: loadavg: 1.95 1.06 0.43 1/159 14305
>        	T: 0 (14145) P: 50 I: 1000 C: 4997 Min: 7 Act: 7 Avg: 7 Max:=20
> 18 work fine
>=20
> now, i'm loading the system on the cpu core 0 with a homemade process:
>        cpu load 60%, sched FIFO prio 1, cpu 0

Are you sure that your test app runs with prio 1? Is this in the range =
of the SCHED_FIFO (userspace) priorities shown by chrt -m?

...
SCHED_FIFO min/max priority	: 1/99
...

If I run your setup (test and cyclictest affine to CPU0) on 4.15.0-43
(i7-4750HQ) with:

(1) test prio > cyclictest prio

# chrt -p $PID_TEST

pid 28489's current scheduling policy: SCHED_FIFO pid 28489's current =
scheduling priority: 51

# cat /proc/$PID_TEST/stat

28489 (test) R 28488 28487 8664 34828 28487 4194304 86 0 0 0 0 0 0 0 -52

I get your behaviour:

# /dev/cpu_dma_latency set to 0us
Thread 0 Interval: 1500
        0:       0:       6
        0:       1:       5
        0:       2:       2
        0:       3:    5419
        0:       4:       3
        0:       5:       2
        0:       6:       2
        0:       7:       2
        0:       8:    5422
        0:       9:       3
...

whereas with:

(2) test prio < cyclictest prio

# chrt -p $PID_TEST

pid 28811's current scheduling policy: SCHED_FIFO pid 28811's current =
scheduling priority: 49

# cat /proc/$PID_TEST/stat

28811 (test) S 28810 28809 8664 34828 28809 1077936128 90 0 0 0 0 0 0 0 =
-50

I get:

# /dev/cpu_dma_latency set to 0us
Thread 0 Interval: 1500
        0:       0:       7
        0:       1:       4
        0:       2:       3
        0:       3:       5
        0:       4:       4
        0:       5:       2
        0:       6:       2
        0:       7:       2
        0:       8:       2
        0:       9:       3
...

[...]

> In this case cyclictest detects very long latencies
>        cyclictest -m -D 5 -i 1000 -p 50 -a 0 -v
>=20
> Max CPUs =3D 2
> # /dev/cpu_dma_latency set to 0us
> Thread 0 Interval: 1500
>         0:       0:      13
>         0:       1:       8
>         0:       2:       7
>         0:       3:    5648
>         0:       4:       8
>         0:       5:       7
>         0:       6:       7
>         0:       7:       7
>         0:       8:    5649

[...]

> After verification, although no other process is running with real=20
> time scheduler, I see a latency of about 5.6 ms at regular intervals.
>=20
> it seems that the priority task 1 (fifo) is not pre-empted by the=20
> cyclictest process with a priority of 50 (fifo) when the low priority =
task is active.
> This  corresponds to the cycle recorded in the file: 6 ms of latency=20
> followed by 4 "normal" latencies of 7 us.
>=20
> Does anyone have any idea of this problem?
>=20
> Best regards
> Frederic MATHIEU

