Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3ABC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D1E2177B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+QzcOw1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbfAJOs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:48:58 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55679 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728125AbfAJOs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 09:48:58 -0500
Received: by mail-wm1-f66.google.com with SMTP id y139so11432354wmc.5;
        Thu, 10 Jan 2019 06:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uuR/OCNyrQsI1HZ9Kmc55IIg0UxxlGgiJzrRelP5YX8=;
        b=A+QzcOw1Dv60K7T0KL4h2/yqw4PoIudRG+00Fn6vU959IzZJOOoyxs4aNuc4dAtlws
         TKNFb2tpW/7Iey26xJgtWnso0q4YfnfiDq/EfA6D7kZ6BJAVA4lAFbter/NblbQI7RQN
         Emv25a/QGwPRk0j70d1+bwkOqRNh3SjplMfDmvpRVoYCAP418iIBwg8x2fPhNadqxCZI
         CytQ9HRlIzUOahAEAGLcgXwDHsm9eFu1kUFnMqekO/yGShHGSKtJUuBL79iUU6xaqQp2
         aXyMMPqhs87ZVvyyUk0Dn6jOh5KUsJK/aDoCeJD24N7G7dbc4DW6kIw1RO9aISEk1KAy
         pEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uuR/OCNyrQsI1HZ9Kmc55IIg0UxxlGgiJzrRelP5YX8=;
        b=VrJMCwJPkpEmpW3NHh0Blqu1Pm74s1iusn44y+PcMLSDG41n2EaxkorrQpKVEl/u+u
         JonaWsbNbgLKmb56sOroOwg4IS50GdjbxTdKCiUaLH+X5waA55JZb2QG09TipzD1jo7v
         3SoSo03EN32+AqzNQ51OVweDazDLcjZHZDJymwYoGy79RMUAMd5dyUp4FrWPd3e63oR+
         G9YPM6QulIprIE4ABImgtRWlfG1ZxtyN4h9OrB0446eFisdbek12hbi7o1eVHhPzs6Y3
         SVPyqyxdzjbsnLBe5iIaQBEfXl4hBqpfL7JCdKmiAeUH00kE9Qgq34K4PNDs+fTrfjjy
         VBQg==
X-Gm-Message-State: AJcUukfy3bGoBNTWBYnw+hA+m3h3vwl+cOfbFyhCaaj4WXEW46ZMHgfF
        QhObvcJra+CmUQJRCrBv9ns=
X-Google-Smtp-Source: ALg8bN55sCs0TF8B0/4J0GtACn6ZkWyoFfzse+3ajmALnjkOSn/g/Hw7hGcqhlEiFNOrUgm5UeQjrQ==
X-Received: by 2002:a7b:ce8e:: with SMTP id q14mr10754053wmj.10.1547131735525;
        Thu, 10 Jan 2019 06:48:55 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id y1sm15062844wme.1.2019.01.10.06.48.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 06:48:54 -0800 (PST)
Date:   Thu, 10 Jan 2019 15:48:53 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, mperttunen@nvidia.com,
        jonathanh@nvidia.com, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH V3 1/3] dt-bindings: mmc: tegra: Add pinctrl for pad
 drive strength config
Message-ID: <20190110144853.GB25353@ulmo>
References: <1546462674-22856-1-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Content-Disposition: inline
In-Reply-To: <1546462674-22856-1-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 02, 2019 at 12:57:52PM -0800, Sowjanya Komatineni wrote:
> Add pinctrl for 3V3 and 1V8 pad drive strength configuration for
> Tegra210 sdmmc which has pad configuration registers in the pinmux
> reigster domain.
> Pad drive strengths for Tegra186 and Later are
> part of SDMMC device node itself.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Hi Rob,

any chance you could take a look at this?

Thanks,
Thierry

> diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.t=
xt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> index 32b4b4e41923..2cecdc71d94c 100644
> --- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> @@ -39,12 +39,16 @@ sdhci@c8000200 {
>  	bus-width =3D <8>;
>  };
> =20
> -Optional properties for Tegra210 and Tegra186:
> +Optional properties for Tegra210, Tegra186 and Tegra194:
>  - pinctrl-names, pinctrl-0, pinctrl-1 : Specify pad voltage
>    configurations. Valid pinctrl-names are "sdmmc-3v3" and "sdmmc-1v8"
>    for controllers supporting multiple voltage levels. The order of names
>    should correspond to the pin configuration states in pinctrl-0 and
>    pinctrl-1.
> +- pinctrl-names : "sdmmc-3v3-drv" and "sdmmc-1v8-drv" are applicable for
> +  Tegra210 where pad config registers are in the pinmux register domain
> +  for pull-up-strength and pull-down-strength values configuration when
> +  using pads at 3V3 and 1V8 levels.
>  - nvidia,only-1-8-v : The presence of this property indicates that the
>    controller operates at a 1.8 V fixed I/O voltage.
>  - nvidia,pad-autocal-pull-up-offset-3v3,
> --=20
> 2.7.4
>=20

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlw3W1UACgkQ3SOs138+
s6H3axAAozYOuxywpdMdLfOIgXUnfWBigHXMNhK4eINNJyBlqfSnQmHLuNoWoXJ0
6evDzZY6rHZ94K1UlsMIz7cNvZrxdn1Rt0lq1+ye8ohgWdCP5cFZoESZX59xGGLN
E5iyiPEmUN+Ec8PKefOFLUAH2xPE+4syKqDbXQV4Lm9Maj7HzFT9YwK5Pwazv224
AYDC45wZMP5U7QLm07bcaJ4clytxtRaPvDBxT+ugaJy4DrdWNcsbSI6jyEcjaxh2
zzPLbb1ujVXSz+EFpZ/voAuxM85eruFMDmBIaKA640LDMjq1nEknSa0Y8wZYFwG5
F3/59TdkuRFylNVRwCStt0n39tFNxsvxuqzkhM6gWgCMyVD7mBS/kXnp0v0v/DoB
nkKIf+eJljrgTh4w4C4OS+edga9F7HS9DuH1a9iATq8HxSKkJjsLPkCKxwKOZhhk
kDPUc7tFq7hwffkXsSoYNszEVM75kF2ujWUW5dqOPiTy7YxsyvjrJUgmViEBfYZO
S1BM/N3c5QKMO+M2ilArDiIArZwfLaWi9OypGi50NBYskei+50IGMbMWLildV2sv
UjRmWWN1Ms1kQxmHA9TphLUtUdArvWxMZPy+fe0bThMBKPrWtA30v/GkWWjhSI/C
FY0j3+yBOPccAb0XlGDuEYLIHiXYuJtvJstET4Ky1fkpnVXSJBg=
=aOWC
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
