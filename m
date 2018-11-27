Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89257C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D96120989
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWWCCoK3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D96120989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbeK1BTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 20:19:10 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38986 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbeK1BTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 20:19:10 -0500
Received: by mail-ed1-f66.google.com with SMTP id b14so19122991edt.6;
        Tue, 27 Nov 2018 06:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+qAvvxAsCOm3AOdYenOjbXrtvKJgFIlzejbUWylNF2Y=;
        b=BWWCCoK36bCkdqOii8kMU8UXLx240pfD9OKFzvN9Q1yrBRTXzMCHQJ+lbO57aWdbs+
         j1adQTE8b8donXWuQ6NbxIfMsrM/E+edn7z/nWkOwm+RpN24RAbzErg2l3HJ5hqZiGg7
         m6iXYL+kCn108WJzokk6bmQJ+34u7WitzC64mp61DoU0f25BF/Wzjc2N4a6PXCUCZTOr
         Nnc9af+tNWW6gRDzRPONkHvDKJy5cpP7VKnKu8SdyIJ1u4lNuzgg0pG1V91jIR8J9Yyy
         8J9p6CuburNgeVM2CHA982JoMl9kjG5qV1fmhgrnjrSF7tOKTcbnpFQyHoZ/0CTlg4hU
         xdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+qAvvxAsCOm3AOdYenOjbXrtvKJgFIlzejbUWylNF2Y=;
        b=PUkRChoOVX3jTErRAvdZq2hYI7yxewEGUZlupbDIJGgeXEC541Ub+Bu8TF8TtUCZuG
         gmTqNluu4nGRyEmdq6u2vdpxQX4WZay0fC4R2AA20pnc0Jmh9N9+idPko0sNucv09UbZ
         LqrHrpDLtUpDbctWyDEtOqXlDKcltNcNSsIHayQO53LC47SqWxoPaSkWrK+vjhL44SF1
         bantrJNSKel2OzlGtpb1XoY1GTAJEElWANxYwNOoW5P+ira8dN5ybW1iFLJ/IyNkmuzO
         AFLSqz13nPPfuqLpAhHMYbovlEpegDpvCj0Immga5g3vCU8QvM4vOe71d91m3FvEfVhe
         DAkA==
X-Gm-Message-State: AA+aEWZikjA8VoJ+S4pWdobUXg8D3Up4mGmFxCLHgu4brNMBAuIAojMB
        v0ZZLu9Dw2YldEbP/t1nYlo=
X-Google-Smtp-Source: AJdET5d8G3RZEDA4HZ/Q7IOYSiD5Ht5pDjskel+XftSHQhOG72xJOaXvcdEFg5Z0FqJ1SckILrXAYw==
X-Received: by 2002:a50:9624:: with SMTP id y33mr26087370eda.206.1543328465076;
        Tue, 27 Nov 2018 06:21:05 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id p20-v6sm587998ejj.54.2018.11.27.06.21.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 06:21:04 -0800 (PST)
Date:   Tue, 27 Nov 2018 15:21:03 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     jic23@kernel.org, marcel.ziswiler@toradex.com, stefan@agner.ch,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        devicetree@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH v3 4/4] ARM: dts: Add stmpe-adc driver to relevant
 devicetrees
Message-ID: <20181127142103.GC10560@ulmo>
References: <20181123142411.8921-1-dev@pschenker.ch>
 <20181123142411.8921-4-dev@pschenker.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w7PDEPdKQumQfZlR"
Content-Disposition: inline
In-Reply-To: <20181123142411.8921-4-dev@pschenker.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w7PDEPdKQumQfZlR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 23, 2018 at 03:24:11PM +0100, Philippe Schenker wrote:
> From: Philippe Schenker <philippe.schenker@toradex.com>
>=20
> Activate the stmpe-adc driver as found on Apalis/Colibri iMX6/T30 modules
>=20
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> ---
>=20
> Changes in v3:
>  - None
>=20
> Changes in v2:
>  - Put common ADC settings in mfd
>=20
>  arch/arm/boot/dts/imx6qdl-apalis.dtsi  | 22 ++++++++++++++--------
>  arch/arm/boot/dts/imx6qdl-colibri.dtsi | 23 +++++++++++++++--------
>  arch/arm/boot/dts/tegra30-apalis.dtsi  | 22 ++++++++++++++--------
>  arch/arm/boot/dts/tegra30-colibri.dtsi | 22 ++++++++++++++--------
>  4 files changed, 57 insertions(+), 32 deletions(-)

You might want to split this up into two patches, one for i.MX and the
other for Tegra so that the respective maintainers can apply them
separately.

Also, where are patches 1-3?

Thierry

--w7PDEPdKQumQfZlR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv9Us8ACgkQ3SOs138+
s6ETBA//Sl4B61jfINf/TIIt678gt5+o7XKrFo7tvvTS9EcK8S8IwwGc7quphlNy
D4abPfA03egiEbiqLIceasyZX+LG6ZgoMpWNvUlJdMQN3DqODplrNxUeqB8NoFP5
TsQ7EToOdvIYRS3fA1j9UlKKU2Q7armFZZ3a23aFaF/p5dNYzsFh/ZQ9QNTh3kdP
dOoonVZcx79Zx67d3M0Po9Xq8cqiUL8wZ60FJODNaqt0D2Gkk3n0sVO8cZiQMMcW
obmf2KmFRWZAVFGd7rcGqRJCjirwHiRRECf+yAMn3JTLfBnf/MG53P9aKMnyJowI
7mPAUvzLatqbcjpJKW1Q/VW7+rB8DAGJ94i0/mdWrg1xhnXmq3eiidjtZrruVS/k
o92dcAw2UsewYerTMbSdSWFFbmp92iJAtXgcKxOlJIncfYbvZJCzm3+uA6IWC2I0
jBiaIxferVHLPfdgGpCebBbor0HHTPq9Yt1RMkUXPkEw32musaw/PjBJEJP36AtE
UH/97cOBZDvBLx+/yX0stCok0hi9rUzm8+/ERyV/kYl3dc4cMtjA3QHtNT4Hw35N
rBnZXruqAngl3PQlRsGykVo2Fve76DWTDxOmkBw4NtDtbVptxWHnVOTE/O1Acn1n
MlQSfriTGswAtcVbjO162MT1jyYNn4jketZncIQJImGivBs99Gc=
=yx3m
-----END PGP SIGNATURE-----

--w7PDEPdKQumQfZlR--
