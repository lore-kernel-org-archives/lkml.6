Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752177AbeEPSF2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 14:05:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:50340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751227AbeEPSFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 14:05:25 -0400
Date: Wed, 16 May 2018 19:05:20 +0100
From: James Hogan <jhogan@kernel.org>
To: Matt Redfearn <matt.redfearn@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>, linux-mips@linux-mips.org,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v3 5/7] MIPS: perf: Allocate per-core counters on demand
Message-ID: <20180516180518.GB12837@jamesdev>
References: <1524219789-31241-1-git-send-email-matt.redfearn@mips.com>
 <1524219789-31241-6-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="V0207lvV8h4k8FAm"
Content-Disposition: inline
In-Reply-To: <1524219789-31241-6-git-send-email-matt.redfearn@mips.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 20, 2018 at 11:23:07AM +0100, Matt Redfearn wrote:
> Previously when performance counters are per-core, rather than
> per-thread, the number available were divided by 2 on detection, and the
> counters used by each thread in a core were "swizzled" to ensure
> separation. However, this solution is suboptimal since it relies on a
> couple of assumptions:
> a) Always having 2 VPEs / core (number of counters was divided by 2)
> b) Always having a number of counters implemented in the core that is
>    divisible by 2. For instance if an SoC implementation had a single
>    counter and 2 VPEs per core, then this logic would fail and no
>    performance counters would be available.
> The mechanism also does not allow for one VPE in a core using more than
> it's allocation of the per-core counters to count multiple events even
> though other VPEs may not be using them.
>=20
> Fix this situation by instead allocating (and releasing) per-core
> performance counters when they are requested. This approach removes the
> above assumptions and fixes the shortcomings.
>=20
> In order to do this:
> Add additional logic to mipsxx_pmu_alloc_counter() to detect if a
> sibling is using a per-core counter, and to allocate a per-core counter
> in all sibling CPUs.
> Similarly, add a mipsxx_pmu_free_counter() function to release a
> per-core counter in all sibling CPUs when it is finished with.
> A new spinlock, core_counters_lock, is introduced to ensure exclusivity
> when allocating and releasing per-core counters.
> Since counters are now allocated per-core on demand, rather than being
> reserved per-thread at boot, all of the "swizzling" of counters is
> removed.
>=20
> The upshot is that in an SoC with 2 counters / thread, counters are
> reported as:
> Performance counters: mips/interAptiv PMU enabled, 2 32-bit counters
> available to each CPU, irq 18
>=20
> Running an instance of a test program on each of 2 threads in a
> core, both threads can use their 2 counters to count 2 events:
>=20
> taskset 4 perf stat -e instructions:u,branches:u ./test_prog & taskset 8
> perf stat -e instructions:u,branches:u ./test_prog
>=20
>  Performance counter stats for './test_prog':
>=20
>              30002      instructions:u
>              10000      branches:u
>=20
>        0.005164264 seconds time elapsed
>  Performance counter stats for './test_prog':
>=20
>              30002      instructions:u
>              10000      branches:u
>=20
>        0.006139975 seconds time elapsed
>=20
> In an SoC with 2 counters / core (which can be forced by setting
> cpu_has_mipsmt_pertccounters =3D 0), counters are reported as:
> Performance counters: mips/interAptiv PMU enabled, 2 32-bit counters
> available to each core, irq 18
>=20
> Running an instance of a test program on each of 2 threads in a
> core, now only one thread manages to secure the performance counters to
> count 2 events. The other thread does not get any counters.
>=20
> taskset 4 perf stat -e instructions:u,branches:u ./test_prog & taskset 8
> perf stat -e instructions:u,branches:u ./test_prog
>=20
>  Performance counter stats for './test_prog':
>=20
>      <not counted>       instructions:u
>      <not counted>       branches:u
>=20
>        0.005179533 seconds time elapsed
>=20
>  Performance counter stats for './test_prog':
>=20
>              30002      instructions:u
>              10000      branches:u
>=20
>        0.005179467 seconds time elapsed
>=20
> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>

While this sounds like an improvement in practice, being able to use
more counters on single threaded stuff than otherwise, I'm a little
concerned what would happen if a task was migrated to a different CPU
and the perf counters couldn't be obtained on the new CPU due to
counters already being in use. Would the values be incorrectly small?

Cheers
James

--V0207lvV8h4k8FAm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWvxy3QAKCRA1zuSGKxAj
8tkAAP0WI8Ai9zj9o9qA7EMW3EHQBEcuicBa7FVsRmwP/GPRwQD/VYsbpp7Whbh1
7p38EwuqwfxsypFa10m8oEjEHeXzmA4=
=eiea
-----END PGP SIGNATURE-----

--V0207lvV8h4k8FAm--
