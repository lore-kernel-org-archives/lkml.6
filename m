Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60618C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 01:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC47A2086C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 01:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="EQzlmHl+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC47A2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=riseup.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbeIEGYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 02:24:06 -0400
Received: from mx1.riseup.net ([198.252.153.129]:48577 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbeIEGYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 02:24:05 -0400
Received: from cotinga.riseup.net (cotinga-pn.riseup.net [10.0.1.164])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id 4227B1A0574;
        Tue,  4 Sep 2018 18:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1536112578; bh=Uv5EIuahHYKRmQCxKrCe3QU3fFPN1BIQFd/LCuIETis=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=EQzlmHl+2a9q4qxgSAZ67wPkMt5jaUMnoIt9fqDyEoTQ4L9gSsxUEVLjDAHrx4Vhv
         GnZVEPj4bOog6+l8QqhvTAilR4ODz/SpYL5ES9rXpASLOqBMWsRFb4B/UcxHT2OncY
         Bm+Hj8ii8hOZoTekv/YjLD6OwVVsleoW8AOrsT1k=
X-Riseup-User-ID: F2ECE41CB1198610A7600BAFD8BA3EE7A3B1ACB80A40E2C8DB8B3FAB614A2CBB
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by cotinga.riseup.net with ESMTPSA id 1F5D36817F;
        Tue,  4 Sep 2018 18:56:16 -0700 (PDT)
From:   Francisco Jerez <currojerez@riseup.net>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Eero Tamminen <eero.t.tamminen@intel.com>, lenb@kernel.org,
        rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     mgorman@techsingularity.net, ggherdovich@suse.cz,
        peterz@infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: intel_pstate: Optimize IO boost in non HWP mode
In-Reply-To: <b48340f59011bc3d7402b6a811bce4fa861fab7b.camel@linux.intel.com>
References: <20180831172851.79812-1-srinivas.pandruvada@linux.intel.com> <1244c5d6-460e-0e0b-b7bf-a46e73327383@intel.com> <8736upda8s.fsf@riseup.net> <b48340f59011bc3d7402b6a811bce4fa861fab7b.camel@linux.intel.com>
Date:   Tue, 04 Sep 2018 18:37:07 -0700
Message-ID: <8736uobu7w.fsf@riseup.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="==-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> writes:

> On Mon, 2018-09-03 at 23:53 -0700, Francisco Jerez wrote:
>> Eero Tamminen <eero.t.tamminen@intel.com> writes:
>>=20
>> > Hi,
>> >=20
>> > On 31.08.2018 20:28, Srinivas Pandruvada wrote:
>> > ...
>> > > As per testing Eero Tamminen, the results are comparable to the
>> > > patchset
>> > > https://patchwork.kernel.org/patch/10312259/
>> > > But he has to watch results for several days to check trend.
>> >=20
>> > It's close, but there is some gap compared to Francisco's version.
>> >=20
>> > (Because of the large variance on TDP limited devices, and factors=20
>> > causing extra perf differences e.g. between boots, it's hard to
>> > give=20
>> > exact number without having trends from several days / weeks.  I
>> > would=20
>> > also need new version of Fransisco's patch set that applies to
>> > latest=20
>> > kernel like yours does.)
>> >=20
>> >=20
>> > > Since here boost is getting limited to turbo and non turbo, we
>> > > need some
>> > > ways to adjust the fractions corresponding to max non turbo as
>> > > well. It
>> > > is much easier to use the actual P-state limits for boost instead
>> > > of
>> > > fractions. So here P-state io boost limit is applied on top of
>> > > the
>> > > P-state limit calculated via current algorithm by removing
>> > > current
>> > > io_wait boost calculation using fractions.
>> > >=20
>> > > Since we prefer to use common algorithm for all processor
>> > > platforms, this
>> > > change was tested on other client and sever platforms as well.
>> > > All results
>> > > were within the margin of errors. Results:
>> > > https://bugzilla.kernel.org/attachment.cgi?id=3D278149
>> >=20
>> > Good.
>> >=20
>> > Francisco, how well the listed PTS tests cover latency bound cases
>> > you=20
>> > were concerned about?  [1]
>> >=20
>> >=20
>> > 	- Eero
>> >=20
>> > [1] Fransisco was concerned that the patch:
>> > * trade-off might regress latency bound cases (which I haven't
>> > tested, I=20
>> > tested only 3D throughput), and
>> > * that it addressed only other of the sources of energy
>> > inefficiencies=20
>> > he had identified (which could explain slightly better 3D results
>> > from=20
>> > his more complex patch set).
>>=20
>> This patch causes a number of statistically significant regressions
>> (with significance of 1%) on the two systems I've tested it on.  On
>> my
> Sure. These patches are targeted to Atom clients where some of these
> server like workload may have some minor regression on few watts TDP
> parts.

Neither the 36% regression of fs-mark, the 21% regression of sqlite, nor
the 10% regression of warsaw qualify as small.  And most of the test
cases on the list of regressions aren't exclusively server-like, if at
all.  Warsaw, gtkperf, jxrendermark and lightsmark are all graphics
benchmarks -- Latency is as important if not more for interactive
workloads than it is for server workloads.  In the case of a conflict
like the one we're dealing with right now between optimizing for
throughput (e.g. for the maximum number of requests per second) and
optimizing for latency (e.g. for the minimum request duration), you are
more likely to be concerned about the former than about the latter in a
server setup.

> But weighing against reduced TURBO usage (which is enough trigger) and
> improvement in tests done by Eero (which was primary complaint to us).
>
> It is trivial patch. Yes, the patch is not perfect and doesn't close
> doors for any improvements.
>

It's sort of self-contained because it's awfully incomplete.

> I see your idea, but how to implement in acceptable way is a challenge.

Main challenge was getting the code to work without regressions in
latency-sensitive workloads, which I did, because you told me that it
wasn't acceptable for it to cause any regressions on the Phoronix
daily-system-tracker, whether latency-bound or not.  What is left in
order to address Peter's concerns is for the most part plumbing, that's
guaranteed not to have any functional impact on the heuristic.  The fact
that we don't expect it to change the performance of the system makes it
substantially less time-consuming to validate than altering the
performance trade-offs of the heuristic dynamically in order to avoid
regressions (which is what has kept my systems busy most of the time
lately).  Seems like my series, even in its current state without the
changes requested by Peter is closer to being ready for production than
this patch is.

> So ultimately we will get there, but will require some time compared
> with other high priority items.
>
>
> Thanks
> Srinivas
>
>> CHV N3050:
>>=20
>> > phoronix/fs-
>> > mark/test=3D0:=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20
>> > XXX =C2=B17.25% x34 -> XXX =C2=B17.00% x39  d=3D-36.85% =C2=B15.91%  p=
=3D0.00%
>> > phoronix/sqlite:=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20
>> >             XXX =C2=B11.86% x34 -> XXX =C2=B11.88% x39  d=3D-21.73%
>> > =C2=B11.66%  p=3D0.00%
>> > warsow/benchsow:=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20
>> >             XXX =C2=B11.25% x34 -> XXX =C2=B11.95% x39  d=3D-10.83%
>> > =C2=B11.53%  p=3D0.00%
>> > phoronix/iozone/record-size=3D4Kb/file-size=3D2GB/test=3DRead
>> > Performance:           XXX =C2=B11.70% x31 -> XXX =C2=B11.02% x34  d=
=3D-7.39%
>> > =C2=B11.36%   p=3D0.00%
>> > phoronix/gtkperf/gtk-
>> > test=3DGtkComboBox:                                         XXX
>> > =C2=B11.15% x13 -> XXX =C2=B11.59% x14   d=3D-5.37% =C2=B11.35%  p=3D0=
.00%
>> > lightsmark:=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20
>> >             XXX =C2=B11.45% x34 -> XXX =C2=B10.97% x41   d=3D-4.66%
>> > =C2=B11.19%  p=3D0.00%
>> > jxrendermark/rendering-test=3DTransformed Blit Bilinear/rendering-
>> > size=3D128x128:  XXX =C2=B11.04% x31 -> XXX =C2=B11.04% x39   d=3D-4.5=
8%
>> > =C2=B11.01%  p=3D0.00%
>> > jxrendermark/rendering-test=3DLinear Gradient Blend/rendering-
>> > size=3D128x128:      XXX =C2=B10.12% x31 -> XXX =C2=B10.19% x39   d=3D=
-3.60%
>> > =C2=B10.16%  p=3D0.00%
>> > dbench/client-
>> > count=3D1:                                                         XX
>> > X =C2=B10.50% x34 -> XXX =C2=B10.50% x39   d=3D-2.51% =C2=B10.49%  p=
=3D0.00%
>>=20
>> On my BXT J3455:
>>=20
>> > fs-
>> > mark/test=3D0:=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20
>> >          XXX =C2=B13.04% x6 ->   XXX =C2=B13.05% x9  d=3D-15.96%
>> > =C2=B12.76%  p=3D0.00%
>> > sqlite:=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>> >             XXX =C2=B12.54% x6 ->   XXX =C2=B12.72% x9  d=3D-12.42%
>> > =C2=B12.44%  p=3D0.00%
>> > dbench/client-
>> > count=3D1:                                                         XX
>> > X =C2=B10.42% x6 ->   XXX =C2=B10.36% x9   d=3D-6.52% =C2=B10.37%  p=
=3D0.00%
>> > dbench/client-
>> > count=3D2:                                                         XX
>> > X =C2=B10.26% x6 ->   XXX =C2=B10.33% x9   d=3D-5.22% =C2=B10.29%  p=
=3D0.00%
>> > dbench/client-
>> > count=3D3:                                                         XX
>> > X =C2=B10.34% x6 ->   XXX =C2=B10.53% x9   d=3D-2.92% =C2=B10.45%  p=
=3D0.00%
>> > x11perf/test=3D500px Compositing From Pixmap To
>> > Window:                          XXX =C2=B12.29% x16 ->  XXX =C2=B12.1=
1%
>> > x19  d=3D-2.69% =C2=B12.16%  p=3D0.09%
>> > lightsmark:=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20
>> >             XXX =C2=B10.44% x6 ->   XXX =C2=B10.33% x9   d=3D-1.76%
>> > =C2=B10.37%  p=3D0.00%
>> > j2dbench/rendering-test=3DVector Graphics
>> > Rendering:                             XXX =C2=B11.18% x16 ->  XXX
>> > =C2=B11.82% x19  d=3D-1.71% =C2=B11.54%  p=3D0.26%
>> > gtkperf/gtk-
>> > test=3DGtkComboBox:=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20
>> > XXX =C2=B10.37% x6 ->   XXX =C2=B10.45% x9   d=3D-0.95% =C2=B10.42%  p=
=3D0.08%
>> > jxrendermark/rendering-test=3DTransformed Blit Bilinear/rendering-
>> > size=3D128x128:  XXX =C2=B10.21% x3 ->   XXX =C2=B10.23% x6   d=3D-0.8=
7%
>> > =C2=B10.22%  p=3D0.08%
>>=20
>> This is not surprising given that the patch is making a hard trade-
>> off
>> between latency and energy efficiency without considering whether the
>> workload is IO- or latency-bound, which is the reason why the series
>> I
>> submitted earlier [1] to address this problem implemented an IO
>> utilization statistic in order to determine whether the workload is
>> IO-bound, in which case the latency trade-off wouldn't impact
>> performance negatively.
>>=20
>> Aside from that the improvement in graphics throughput seems like a
>> small fraction of the series [1] while TDP-bound.  E.g. with this
>> patch
>> on my BXT J3455:
>>=20
>> > unigine/heaven:           XXX =C2=B10.21% x3 -> XXX =C2=B10.19% x6  d=
=3D1.18%
>> > =C2=B10.19%  p=3D0.01%
>> > unigine/valley:           XXX =C2=B10.52% x3 -> XXX =C2=B10.28% x6  d=
=3D1.56%
>> > =C2=B10.37%  p=3D0.06%
>> > gfxbench/gl_manhattan31:  XXX =C2=B10.12% x3 -> XXX =C2=B10.21% x6  d=
=3D1.64%
>> > =C2=B10.19%  p=3D0.00%
>> > gfxbench/gl_trex:         XXX =C2=B10.56% x3 -> XXX =C2=B10.36% x6  d=
=3D7.07%
>> > =C2=B10.44%  p=3D0.00%
>>=20
>> vs. my series on the same system:
>>=20
>> > gfxbench/gl_manhattan31:  XXX =C2=B10.37% x3 -> XXX =C2=B10.08% x3  d=
=3D7.30%
>> > =C2=B10.27%  p=3D0.00%
>> > unigine/heaven:           XXX =C2=B10.47% x3 -> XXX =C2=B10.40% x3  d=
=3D7.99%
>> > =C2=B10.45%  p=3D0.00%
>> > unigine/valley:           XXX =C2=B10.35% x3 -> XXX =C2=B10.50% x3  d=
=3D8.24%
>> > =C2=B10.45%  p=3D0.00%
>> > gfxbench/gl_trex:         XXX =C2=B10.15% x3 -> XXX =C2=B10.26% x3  d=
=3D9.12%
>> > =C2=B10.23%  p=3D0.00%
>>=20
>> That's not surprising either considering that this patch is only
>> addressing one of the two reasons the current non-HWP intel_pstate
>> governor behaves inefficiently (see [1] for more details on the other
>> reason).  And even that is only partially addressed since the
>> heuristic
>> implemented in this patch in order to decide the degree of IOWAIT
>> boosting to apply can and will frequently trigger in heavily GPU-
>> bound
>> cases, which will cause the task to IOWAIT on the GPU frequently,
>> causing the P-state controller to waste shared TDP for no benefit.
>>=20
>> [1] https://lists.freedesktop.org/archives/intel-gfx/2018-March/16053
>> 2.html

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCW48zQwAKCRCDmTidfVK/
W0oHAP9eNzNpGJHK5D9xdz9vSFPcj52orCKOXMBD/PzvuM2VpwEAnlTUPcDkYXoE
nY+BgMHFDxhKetN3XGpchTvPdQALBU4=
=4L/u
-----END PGP SIGNATURE-----
--==-=-=--
