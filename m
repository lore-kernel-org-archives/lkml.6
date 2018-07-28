Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5C2C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 05:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9638520873
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 05:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="Hkt2u+4k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9638520873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=riseup.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbeG1HQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 03:16:09 -0400
Received: from mx1.riseup.net ([198.252.153.129]:56224 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbeG1HQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 03:16:09 -0400
Received: from piha.riseup.net (piha-pn.riseup.net [10.0.1.163])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id 587A31A0438;
        Fri, 27 Jul 2018 22:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1532757056; bh=32qSixbFA/yUrvDEleNLX9gvWvk3W+6YbUWrGgBRxjo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Hkt2u+4k2kcAJcEGudNyEmVQRXaeVnAxfjY15deLdLVtY3qkWuhs2yRbSt8sevNuv
         Dh1QqW99zcBYUL8Nhbv/fZRcV7ZR9YxfWGPTmo56/JTTK/Ob7w4+M9Z4ZSHe5FFtCA
         rKhbGol/bqIyQrJTkWKYkTPEPPN99f4P0YzUxFjg=
X-Riseup-User-ID: DE642827E29A2DF05444B266BA742CDCE136571F16B63BBF194E95211E984897
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by piha.riseup.net with ESMTPSA id A84F3456A1;
        Fri, 27 Jul 2018 22:50:54 -0700 (PDT)
From:   Francisco Jerez <currojerez@riseup.net>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        lenb@kernel.org, rjw@rjwysocki.net, mgorman@techsingularity.net
Cc:     peterz@infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        viresh.kumar@linaro.org, ggherdovich@suse.cz,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Eero Tamminen <eero.t.tamminen@intel.com>
Subject: Re: [PATCH 4/4] cpufreq: intel_pstate: enable boost for Skylake Xeon
In-Reply-To: <20180605214242.62156-5-srinivas.pandruvada@linux.intel.com>
References: <20180605214242.62156-1-srinivas.pandruvada@linux.intel.com> <20180605214242.62156-5-srinivas.pandruvada@linux.intel.com>
Date:   Fri, 27 Jul 2018 22:34:03 -0700
Message-ID: <87bmarhqk4.fsf@riseup.net>
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

> Enable HWP boost on Skylake server and workstations.
>

Please revert this series, it led to significant energy usage and
graphics performance regressions [1].  The reasons are roughly the ones
we discussed by e-mail off-list last April: This causes the intel_pstate
driver to decrease the EPP to zero when the workload blocks on IO
frequently enough, which for the regressing benchmarks detailed in [1]
is a symptom of the workload being heavily IO-bound, which means they
won't benefit at all from the EPP boost since they aren't significantly
CPU-bound, and they will suffer a decrease in parallelism due to the
active CPU core using a larger fraction of the TDP in order to achieve
the same work, causing the GPU to have a lower power budget available,
leading to a decrease in system performance.

You may want to give a shot to my previous suggestion of using [2] in
order to detect whether the system is IO-bound, which you can use as an
indicator that the optimization implemented in this series cannot
possibly improve performance and can be expected to hurt energy usage.

Thanks.

[1] https://bugs.freedesktop.org/show_bug.cgi?id=3D107410
[2] https://patchwork.kernel.org/patch/10312259/

> Reported-by: Mel Gorman <mgorman@techsingularity.net>
> Tested-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index 70bf63bb4e0e..01c8da1f99db 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1794,6 +1794,12 @@ static const struct x86_cpu_id intel_pstate_cpu_ee=
_disable_ids[] =3D {
>  	{}
>  };
>=20=20
> +static const struct x86_cpu_id intel_pstate_hwp_boost_ids[] __initconst =
=3D {
> +	ICPU(INTEL_FAM6_SKYLAKE_X, core_funcs),
> +	ICPU(INTEL_FAM6_SKYLAKE_DESKTOP, core_funcs),
> +	{}
> +};
> +
>  static int intel_pstate_init_cpu(unsigned int cpunum)
>  {
>  	struct cpudata *cpu;
> @@ -1824,6 +1830,10 @@ static int intel_pstate_init_cpu(unsigned int cpun=
um)
>  			intel_pstate_disable_ee(cpunum);
>=20=20
>  		intel_pstate_hwp_enable(cpu);
> +
> +		id =3D x86_match_cpu(intel_pstate_hwp_boost_ids);
> +		if (id)
> +			hwp_boost =3D true;
>  	}
>=20=20
>  	intel_pstate_get_cpu_pstates(cpu);
> --=20
> 2.13.6

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCW1wASwAKCRCDmTidfVK/
WzinAP9iSIhkNZ+g1+eSnElRAH+Q8VZaIfmYeGtnPPGKS/ab/gD+KOvBXL2PzEQ2
Pt5N+XU+g7bHe0OT8uoxtAR77Xk0YUY=
=7by0
-----END PGP SIGNATURE-----
--==-=-=--
