Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D39C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 22:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D26652172F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 22:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D26652172F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=milianw.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbeJUG74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 02:59:56 -0400
Received: from dd17628.kasserver.com ([85.13.138.83]:51922 "EHLO
        dd17628.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeJUG74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 02:59:56 -0400
X-Greylist: delayed 473 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Oct 2018 02:59:54 EDT
Received: from agathebauer.localnet (p54A1B5EE.dip0.t-ipconnect.de [84.161.181.238])
        by dd17628.kasserver.com (Postfix) with ESMTPSA id 2EE046284181;
        Sun, 21 Oct 2018 00:39:58 +0200 (CEST)
From:   Milian Wolff <mail@milianw.de>
To:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        namhyung@kernel.org
Cc:     linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho <acme@kernel.org>
Subject: Broken dwarf unwinding - wrong stack pointer register value?
Date:   Sun, 21 Oct 2018 00:39:51 +0200
Message-ID: <2335309.gnWok9HYb4@agathebauer>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart85565125.iVgKRx2EaI"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart85565125.iVgKRx2EaI
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hey all,

I'm on the quest to figure out why perf regularly fails to unwind (some) 
samples. I am seeing very strange behavior, where an apparently wrong stack 
pointer value is read from the register - see below for more information and 
the end of this (long) mail for my open questions. Any help would be greatly 
appreciated.

I am currently using this trivial C++ code to reproduce the issue:

```
#include <cmath>
#include <complex>
#include <iostream>
#include <random>

using namespace std;

int main()
{
    uniform_real_distribution<double> uniform(-1E5, 1E5);
    default_random_engine engine;
    double s = 0;
    for (int i = 0; i < 10000000; ++i) {
        s += norm(complex<double>(uniform(engine), uniform(engine)));
    }
    cout << s << '\n';
    return 0;
}
```

I compile it with `g++ -O2 -g` and then record it with `perf record --call-
graph dwarf`. Using perf script, I then see e.g.:

```
$ perf script -v --no-inline --time 90229.12668,90229.127158 --ns
...
# first frame (working unwinding from __hypot_finite):
unwind: reg 16, val 7faf7dca2696
unwind: reg 7, val 7ffc80811ca0
unwind: find_proc_info dso /usr/lib/libm-2.28.so
unwind: access_mem addr 0x7ffc80811ce8 val 7faf7dc88af9, offset 72
unwind: find_proc_info dso /usr/lib/libm-2.28.so
unwind: access_mem addr 0x7ffc80811d08 val 56382b0fc129, offset 104
unwind: find_proc_info dso /home/milian/projects/kdab/rnd/hotspot/build/tests/
test-clients/cpp-inlining/cpp-inlining
unwind: access_mem addr 0x7ffc80811d58 val 7faf7dabf223, offset 184
unwind: find_proc_info dso /usr/lib/libc-2.28.so
unwind: access_mem addr 0x7ffc80811e18 val 56382b0fc1ee, offset 376
unwind: find_proc_info dso /home/milian/projects/kdab/rnd/hotspot/build/tests/
test-clients/cpp-inlining/cpp-inlining
unwind: __hypot_finite:ip = 0x7faf7dca2696 (0x29696)
unwind: hypotf32x:ip = 0x7faf7dc88af8 (0xfaf8)
unwind: main:ip = 0x56382b0fc128 (0x1128)
unwind: __libc_start_main:ip = 0x7faf7dabf222 (0x24222)
unwind: _start:ip = 0x56382b0fc1ed (0x11ed)
# second frame (unrelated)
unwind: reg 16, val 56382b0fc114
unwind: reg 7, val 7ffc80811d10
unwind: find_proc_info dso /home/milian/projects/kdab/rnd/hotspot/build/tests/
test-clients/cpp-inlining/cpp-inlining
unwind: access_mem addr 0x7ffc80811d58 val 7faf7dabf223, offset 72
unwind: access_mem addr 0x7ffc80811e18 val 56382b0fc1ee, offset 264
unwind: main:ip = 0x56382b0fc114 (0x1114)
unwind: __libc_start_main:ip = 0x7faf7dabf222 (0x24222)
unwind: _start:ip = 0x56382b0fc1ed (0x11ed)
# third frame (broken unwinding from __hypot_finite)
unwind: reg 16, val 7faf7dca2688
unwind: reg 7, val 7ffc80811ca0
unwind: find_proc_info dso /usr/lib/libm-2.28.so
unwind: access_mem addr 0x7ffc80811cc0 val 0, offset 32
unwind: __hypot_finite:ip = 0x7faf7dca2688 (0x29688)
unwind: '':ip = 0xffffffffffffffff (0x0)
cpp-inlining 24617 90229.126685606:     711026 cycles:uppp: 
	    7faf7dca2696 __hypot_finite+0x36 (/usr/lib/libm-2.28.so)
	    7faf7dc88af8 hypotf32x+0x18 (/usr/lib/libm-2.28.so)
	    56382b0fc128 main+0x88 (/home/milian/projects/kdab/rnd/hotspot/
build/tests/test-clients/cpp-inlining/cpp-inlining)
	    7faf7dabf222 __libc_start_main+0xf2 (/usr/lib/libc-2.28.so)
	    56382b0fc1ed _start+0x2d (/home/milian/projects/kdab/rnd/hotspot/
build/tests/test-clients/cpp-inlining/cpp-inlining)

cpp-inlining 24617 90229.126921551:     714657 cycles:uppp: 
	    56382b0fc114 main+0x74 (/home/milian/projects/kdab/rnd/hotspot/
build/tests/test-clients/cpp-inlining/cpp-inlining)
	    7faf7dabf222 __libc_start_main+0xf2 (/usr/lib/libc-2.28.so)
	    56382b0fc1ed _start+0x2d (/home/milian/projects/kdab/rnd/hotspot/
build/tests/test-clients/cpp-inlining/cpp-inlining)

cpp-inlining 24617 90229.127157818:     719976 cycles:uppp: 
	    7faf7dca2688 __hypot_finite+0x28 (/usr/lib/libm-2.28.so)
	ffffffffffffffff [unknown] ([unknown])
...
```

Now I'm trying to figure out why one __hypot_finite sample works but the other 
one breaks for no apparent reason. One thing I noticed so far is the following 
discrepancy in memory accesses, i.e. for the working sample we get:

```
unwind: reg 16, val 7faf7dca2696
unwind: reg 7, val 7ffc80811ca0
unwind: access_mem addr 0x7ffc80811ce8 val 7faf7dc88af9, offset 72
...
```

But the broken sample only produces:

```
unwind: reg 16, val 7faf7dca2688
unwind: reg 7, val 7ffc80811ca0
unwind: find_proc_info dso /usr/lib/libm-2.28.so
unwind: access_mem addr 0x7ffc80811cc0 val 0, offset 32
```

The user stack of the working sample starts with (in hex):

0000000000000000000000009c830441000000000000000000000000000000000000000000000000254a980000000000301d8180fc7f0000c0c10f2b3856000030

The user stack of the broken sample starts with (in hex):

0000000000000000000000002f64fd4000000000000000000000000000000000000000000000000073bb970000000000301d8180fc7f0000c0c10f2b3856000030

This is a 64bit machine, so word width is 8. So both user stacks start with 
`24 * 2 = 48` words of zeros. Hence offset 32 cannot possibly produce a 
meaningful value...

This offset is calculcated from LIBUNWIND__ARCH_REG_SP, cf. unwind-libunwind-
local.c. So is the stack pointer address in the register wrong? If I hackishly 
offset the value for the stack pointer by 40, i.e.:

```
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/
unwind-libunwind-local.c
index 79f521a552cf..a766ddaaa4dd 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -502,6 +502,7 @@ static int access_mem(unw_addr_space_t __maybe_unused as,
 	if (ret)
 		return ret;
 
+	start -= 40;
 	end = start + stack->size;
 
 	/* Check overflow. */
```

Then I can successfully unwind the broken sample:

```
$ perf script -v --no-inline --time 90229.127156,90229.127158 --ns
...
unwind: reg 16, val 7faf7dca2688
unwind: reg 7, val 7ffc80811ca0
unwind: find_proc_info dso /usr/lib/libm-2.28.so
unwind: access_mem addr 0x7ffc80811cc0 val 7faf7dc88af9, offset 72
unwind: find_proc_info dso /usr/lib/libm-2.28.so
unwind: access_mem addr 0x7ffc80811ce0 val 56382b0fc129, offset 104
unwind: find_proc_info dso /home/milian/projects/kdab/rnd/hotspot/build/tests/
test-clients/cpp-inlining/cpp-inlining
unwind: access_mem addr 0x7ffc80811d30 val 7faf7dabf223, offset 184
unwind: find_proc_info dso /usr/lib/libc-2.28.so
unwind: access_mem addr 0x7ffc80811df0 val 56382b0fc1ee, offset 376
unwind: find_proc_info dso /home/milian/projects/kdab/rnd/hotspot/build/tests/
test-clients/cpp-inlining/cpp-inlining
unwind: __hypot_finite:ip = 0x7faf7dca2688 (0x29688)
unwind: hypotf32x:ip = 0x7faf7dc88af8 (0xfaf8)
unwind: main:ip = 0x56382b0fc128 (0x1128)
unwind: __libc_start_main:ip = 0x7faf7dabf222 (0x24222)
unwind: _start:ip = 0x56382b0fc1ed (0x11ed)
cpp-inlining 24617 90229.127157818:     719976 cycles:uppp: 
	    7faf7dca2688 __hypot_finite+0x28 (/usr/lib/libm-2.28.so)
	    7faf7dc88af8 hypotf32x+0x18 (/usr/lib/libm-2.28.so)
	    56382b0fc128 main+0x88 (/home/milian/projects/kdab/rnd/hotspot/
build/tests/test-clients/cpp-inlining/cpp-inlining)
	    7faf7dabf222 __libc_start_main+0xf2 (/usr/lib/libc-2.28.so)
	    56382b0fc1ed _start+0x2d (/home/milian/projects/kdab/rnd/hotspot/
build/tests/test-clients/cpp-inlining/cpp-inlining)

```

So, what now? Here are my open questions:

Is this just working now by chance, or is this the real reason? I.e. is the 
register value for the stack pointer incorrectly recorded?

Can this be fixed somehow during record time?

Can we detect this scenario at analysis time and correct the stack pointer 
address automatically somehow? Should the first frame always try to read from 
offset 72 maybe?

Any help would be greatly appreciated, many thanks

-- 
Milian Wolff
mail@milianw.de
http://milianw.de
--nextPart85565125.iVgKRx2EaI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEezawi1aUvUGg3A1+8zYW/HGdOX8FAlvLrrcACgkQ8zYW/HGd
OX/tSxAAy2kLzPQ6wgFMHClTbS9dLGRkcEA6B7++eky6KHrIQ9wxeV1aSJjSWoAN
NBqRPS2lnQt2hzERHhzX8x/mnelo5NBsYGsbsC3S11U4QKMBrAjN6SXfdYTv5gZA
eAZJgpsKF1TKhoVCnrj4vypx+e7PDqM3pjcc9WuD9hcmuK0fvdgCBsecSVmZCC4H
n2aSv8x++1nO5Eht/Jx1sgkAJVRwuFuSNouLiruzjk8QYkkxCA+kOmXhlgsBwuG7
Qi+vj+PB0IMMXMYJFogV6jBJZkCNRF/5/YcfGAFJxlQb7Szg5qvG9nEnKLRMvkBJ
+va2uN0o052EgDbqJxAnnAen21YmNlxdiBcnr/bw8d9MPMmgpwFpte/jAp2T99dI
uD46mgePwMCGiWPY6M2+iyN+thKVPPC9ImTYBEhYrxxZ/wJrehPskeDLxTlolfwn
H5VoAVQVqyXzHRyRD25NP2aOKo4gyxJ87ilybZOteR+pM+VwW1iU1r/MalC60XA+
OooBOF80epiYj9W9vdkslD8mZIUEVzUPtjVcRpcF/LNTzJ15vrjMDElEC4G0P9WU
6kgI4xQAxJYi5l8jbnbF++6xpXAX4EKaPEJ14S/Ri6XUHAA6jz9txKS6wsCf9soO
GDLXVhaoP0Rs1AMrSvJuV+HCue1zmUILj2In4WSLYQ3AxvSKwV4=
=u7DK
-----END PGP SIGNATURE-----

--nextPart85565125.iVgKRx2EaI--



