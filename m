Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E553DC282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D5E2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKbCflZd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfAUJiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:38:07 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35114 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfAUJiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:38:06 -0500
Received: by mail-wm1-f66.google.com with SMTP id t200so10096486wmt.0;
        Mon, 21 Jan 2019 01:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lw7x5YKOga/V1lsAnmenMdjg4qGyaTD3/p2iww0/kkg=;
        b=VKbCflZdWUBh1EiUHtI7pKAAPijYMDPO90bbihAqdHFTNFZtKmznar3QWazV5VdhOj
         lUcs7i/GByUhCF79/WHHMyFXKTCeuF1vm4goUe3n1/U4WjLskINP4yIpItgYsk0telfX
         mM9m2G8/Afu0wSvwQZgW49w3sqZutgjhb5Xrfqbvvs7Dy//S9oJuGNmo1RzLnptJIgxN
         xpzwnvc228aqSKlVczZ486ky0jJ7gjl/J1pXRACzbgOQE4JP6s5Oz3lNV6qydkZQG+4v
         kvhIMz7EscE3JcG1ue9vS3BItRPnLMlnz/ydeT+ePA1bbLho45WOz/nO/6F0UlByafvd
         6nnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lw7x5YKOga/V1lsAnmenMdjg4qGyaTD3/p2iww0/kkg=;
        b=EkL/6ia9A4PWR3UFCNUDSeicMt0h0oxO82MrDH7edeKtIp0qhh1bGJgFVasdx9WzTu
         fv/AM5n0TiOi8KpMdO5HyA2g9eG56j56hNXc34FaoEdE+HqRHU9CazW/gp2EoGVGE3cu
         RwcJZPkkcUw5XwHnIsJ/g90cqcQ6G0ijRF9xkLMDtnzzce6w7FJ4fD5plTH2qEJSVllT
         fV2/XwnxSMHJZQJMtaofEG4DotXdKamFAP2DRgTu27OrkA7OUOR5aRSR7RcIYgWBICAB
         nlOh42vHbri3BW0PwdI76TnAFltKiGPuI5I3Fqa4v+SVwUYFm1uH6fLUcR3BeZaY0R7P
         xihg==
X-Gm-Message-State: AJcUukcgRRp/Pz9lDdjg87eHSDzDbfLv9c8QxA3OQH86G7if72+QjKlb
        fiL8GogOjdCcwi5fN6XTkSI8KUt0zlA=
X-Google-Smtp-Source: ALg8bN5gVCWl1oYRlF2mzfgYMsIifCIvueFGjjI0J3dw/Spw15RVDd5A19IHqWqGxhdjp0zKu9F6OA==
X-Received: by 2002:a1c:ca15:: with SMTP id a21mr22665862wmg.132.1548063482808;
        Mon, 21 Jan 2019 01:38:02 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id h13sm71568350wrp.61.2019.01.21.01.38.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 01:38:02 -0800 (PST)
Date:   Mon, 21 Jan 2019 10:38:00 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH V1] i2c: tegra: increase transfer timeout
Message-ID: <20190121093800.GA16756@ulmo>
References: <1547757572-29075-1-git-send-email-skomatineni@nvidia.com>
 <c6ba237c-d271-c9d7-1c30-9901ba6bb1a0@nvidia.com>
 <BYAPR12MB3398536A1776FE6B3CA1AB34C29C0@BYAPR12MB3398.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <BYAPR12MB3398536A1776FE6B3CA1AB34C29C0@BYAPR12MB3398.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 18, 2019 at 05:21:28PM +0000, Sowjanya Komatineni wrote:
>=20
>=20
> >> increase transfer timeout to 10s to allow enough time during max=20
> >> transfer size.
> >>=20
> >> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> >> ---
> >>  drivers/i2c/busses/i2c-tegra.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>=20
> >> diff --git a/drivers/i2c/busses/i2c-tegra.c=20
> >> b/drivers/i2c/busses/i2c-tegra.c index e417ebf7628c..ca7c581fb4c0=20
> >> 100644
> >> --- a/drivers/i2c/busses/i2c-tegra.c
> >> +++ b/drivers/i2c/busses/i2c-tegra.c
> >> @@ -25,7 +25,7 @@
> >> =20
> >>  #include <asm/unaligned.h>
> >> =20
> >> -#define TEGRA_I2C_TIMEOUT (msecs_to_jiffies(1000))
> >> +#define TEGRA_I2C_TIMEOUT (msecs_to_jiffies(10000))
> >>  #define BYTES_PER_FIFO_WORD 4
> >> =20
> >>  #define I2C_CNFG				0x000
> >
> >Should the timeout be set depending on the max transfer size? 10s seems =
an age if the max transfer size is 4KB. In other words, we should this only=
 be applied for >T194+?
> >
> >Furthermore, in tegra_i2c_xfer_msg() we know the len of the message and =
so maybe it would be better to dynamically set the timeout depending on len=
gth?
> >
> >Cheers
> >Jon
>=20
> Yes, that=E2=80=99s the ideal way to compute timeout based on msg len and=
 bus rate.=20
> To do this I had to update TEGRA_I2C_TIMEOUT macro to take arg and
> there are 3 different patches for tegra i2c under review and all of
> those will effect as the patch changes use TEGRA_I2C_TIMEOUT.=20
>=20
> So, Should I hold on to this change for now till those patches are merged?

If you have a number of patches with interdependencies, it's best to
send them out as a whole series. So you'd typically apply them in order
to a single branch, then use:

	$ git format-patch first^..last

where first is the SHA1 of the first commit you want to send, and last
is the the SHA1 of the last patch. The carret (^) means the parent
commit of the specified one and is needed because git format-patch
doesn't include the start of the sequence.

If the commits are at the top of your branch you can use something like
this:

	$ git format-patch -3

which will generate a series for the last three patches in the branch
(more specifically starting from HEAD).

If you send them as a series, it's immediately obvious in what order
they should be applied and generally makes it easier for people to
review and test.

I think in this case you can probably just have the other two patches
first in the series, then apply the timeout patch on top. That way you
can resolve the conflicts between patches 1 and 2, and patch 3 before
sending out.

Thierry

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxFkvUACgkQ3SOs138+
s6Fw5Q/8DY8UeD7ZJIlP+dx7dlrjYimcows+9YNl/B1Lo0j+R/aCOcil2MKDoh87
2P3yC0Xa3P29kcepD2noRV0T0LHpCmhq0jxhsuY3+Z3K/M4fRw4oKScjikrtfqlN
xnrhNd/FLeBygIPvVgEHJQvnHXjzXEaH6rmZapoHuHJjuDmPXl8ZirLJBHLYXeel
sZFd9aVDtK2PwYm+hKeU2j3Vh18thtKqdtBOcZD4+ioB+mrcwqy7jPPb2OzVWhZw
ozfBnKsPqCgazFK7rZapd/bGlb0FeERtLeeE+ZqFEx475a8HsVpBOqN7ThwgKf7m
TTHEwP9EsJstlK//rPjZdOtwNXe179gbueIaKcwNZjbU/sXqmpM4nfSq1xkvGV7E
yswMwr+4X+nIHjj3Hha5TKdnprBOZTZic2ZZ+k2xQAy5vkgvOLH3BapUoe1lbGV7
9SN9QHLqUKjHukISXbsP4mLnQ2C+5oInhGRYNHRB3pI3dB2D6BvnW/mv8+2/r+uE
3wADIycOKibvWxSH5dDf2OXh5rZbcTUWGv8+jPE2LNgAvMunVICPnzyDksVXBdAq
J0WTMGjHPsr1kwuTtovvl2IHE+e00K3qNx0TJTMCD0ILf6JNjiMazBJz90vRsGyZ
wI9jSAfeYHMZ+/5uoFRev2Uu+W8YjKSvD+oGwGguXe8Xg39pqfM=
=SAKZ
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
