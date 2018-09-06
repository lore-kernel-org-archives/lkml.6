Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0DBC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A948F20659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:24:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A948F20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbeIFL6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 07:58:46 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42610 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbeIFL6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 07:58:46 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8DA292072F; Thu,  6 Sep 2018 09:24:41 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-30-219.w90-88.abo.wanadoo.fr [90.88.15.219])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0FD7F206DE;
        Thu,  6 Sep 2018 09:24:31 +0200 (CEST)
Date:   Thu, 6 Sep 2018 09:24:29 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Philipp Rossak <embed3d@gmail.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, linux@armlinux.org.uk,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, eugen.hristev@microchip.com,
        rdunlap@infradead.org, vilhelm.gray@gmail.com,
        clabbe.montjoie@gmail.com, geert+renesas@glider.be,
        lukas@wunner.de, icenowy@aosc.io, arnd@arndb.de,
        broonie@kernel.org, arnaud.pouliquen@st.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 30/30] ARM: sun8i: a83t: full range OPP tables and
 CPUfreq
Message-ID: <20180906072429.7qjwbbqsjlbskk6v@qschulz>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-31-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zzux7waj4fepvbk5"
Content-Disposition: inline
In-Reply-To: <20180830154518.29507-31-embed3d@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zzux7waj4fepvbk5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Philipp,

On Thu, Aug 30, 2018 at 05:45:18PM +0200, Philipp Rossak wrote:
> Since we have now thermal trotteling enabeled we can now add the full
> range of the OPP table.
>=20

That's not the reason why they were not added.

Please see commit 2db639d8c1663d7543c9ab5323383d94c8a76c63[1].

Basically, you only want the OPPs which can work below or at the default
voltage of the CPU supply, because the CPU supply is specific to each
board.

If you set your CPU to work at a given frequency and the voltage isn't
updated (saying opp-microvolt =3D <x>; in DT isn't enough, you need
cpu-supply to be provided and functional), the CPU might just crash.

Without cpu-supply property, underclocking isn't effective in term of
thermal cooling or power saving. Overclocking is very, very, very likely
to make the CPU crash.

It's not a very difficult thing to do to test if a given frequency work
well but it needs a specific test environment and it's a lengthy test,
you can have a look at those tools here[3] if you like. It's not because
it works in a given test case that'll work on the long term under heavy
load and constant frequency changes.

For A83T, I already did it and the outcome is the patch in [1]. Same for
A33.

So, if you want to use these three higher OPPs, you need to define them
in your board DTS and add the cpu-supply property. See what's done for
the A33 and more specifically the Sinlinx SinA33[2] as an example.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D2db639d8c1663d7543c9ab5323383d94c8a76c63
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
[3] http://linux-sunxi.org/Hardware_Reliability_Tests#CPU

Quentin

> The operating points were found in Allwinner BSP and fex files.
>=20
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-a83t.dtsi | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-=
a83t.dtsi
> index 78aa448e869f..ddcf404f9c80 100644
> --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> @@ -250,6 +250,22 @@
>  			opp-microvolt =3D <840000>;
>  			clock-latency-ns =3D <244144>; /* 8 32k periods */
>  		};
> +
> +		opp-1608000000 {
> +			opp-hz =3D /bits/ 64 <1608000000>;
> +			opp-microvolt =3D <920000>;
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +		};
> +		opp-1800000000 { /* BOOT FREQ */
> +			opp-hz =3D /bits/ 64 <1800000000>;
> +			opp-microvolt =3D <1000000>;
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +		};
> +		opp-2016000000 {
> +			opp-hz =3D /bits/ 64 <2016000000>;
> +			opp-microvolt =3D <1080000>;
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +		};
>  	};
> =20
>  	cpu1_opp_table: opp_table1 {
> @@ -303,6 +319,22 @@
>  			opp-microvolt =3D <840000>;
>  			clock-latency-ns =3D <244144>; /* 8 32k periods */
>  		};
> +
> +		opp-1608000000 {
> +			opp-hz =3D /bits/ 64 <1608000000>;
> +			opp-microvolt =3D <920000>;
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +		};
> +		opp-1800000000 { /* BOOT FREQ */
> +			opp-hz =3D /bits/ 64 <1800000000>;
> +			opp-microvolt =3D <1000000>;
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +		};
> +		opp-2016000000 {
> +			opp-hz =3D /bits/ 64 <2016000000>;
> +			opp-microvolt =3D <1080000>;
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +		};
>  	};
> =20
>  	soc {
> --=20
> 2.11.0
>=20

--zzux7waj4fepvbk5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAluQ1i0ACgkQhLiadT7g
8aNqzQ//eENMFfPMOD2u/ba5EcJIjcJsNe3BDIZLLPuDOXTAk3eYsLM4/lmY2ZOH
bCE0criU1qrRSgp9WqKYYNN08o5R5gdxmxcconw1LTDP1oe88L6mQ/dXdOn7Sbys
B3CqPXE4KTB8s8A4lGeuSvbDb/ganS8XM/wlpbANPobPjuP2rq/Jf2EpImv4tAKS
wqdNF9acgps1LLFgDqxkYz3+bn3UJsX5mKWbsHr5PnYk/xxRulN7ex9Fu71DRGPV
XqYi+ZBoxQ+CcVMD6dDWkg3RHJGaizOPN80dWo0Z8t7kwK7WKuXjQkncz084I1Tp
hqz/D55T+p9zh7m09jxWVW1z2R/leFKdBPHD3cl2GjfXZjXqsTgjM9fgWNB4KTJo
d5SEhCNerwDvVbaiQ9SVRkY0VZLjmNBdma+9IdeXPnxNxMzATKMAfEqqcF4I7VXI
T0mUzMd0iWpHXlPu7Na3lDH7BwRjePNwq/mlPcFJoqkLMNn8r6hyra2yf38PHg3K
Hc4zor9f4ZyQOziHectSdwY84+QVkhm2jGytiwfEuwU0xDfa7pL+ILNw4MZIFiTG
gObYRCRzfvQoUzuaQJ90wTJZmtHS99F1TORrEqeC+MRrQBVkdjFc9u3R+d0aLAXT
XkCEHuY0wDn0HK0x5BMUBh3rdr5EHQg4hnpG0tKYJQ/ZRm3oQHI=
=H5A0
-----END PGP SIGNATURE-----

--zzux7waj4fepvbk5--
