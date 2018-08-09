Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44031C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E893121D66
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8xAAhjf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E893121D66
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731108AbeHIOAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:00:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35603 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbeHIOAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:00:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id g1-v6so4871865wru.2;
        Thu, 09 Aug 2018 04:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j9bikNOBq54bkXwKYMMXRLaGs1bQhNG+bnxPz7oUDlA=;
        b=f8xAAhjfU44P+e+zo3M27XR/UshJ89qTv8p1j0OqDmoVOF7AysKZhQfOUP/CxS+Cx+
         cucZ1ccXf0wg2EAHjN5UMJf/2dnbvGWmk8BWkRQKdfjdxknfgs9s4/z5cmirGPAy6MLH
         Yfg4fED0i7TOi/ci8G1rb5Y9Mb2pJFoPnZiomJJgU82lUCJnxb5kAvoAbhryyHVGkjwp
         MZOgQ34iLmke4My56U6G8E8HXpWG592Ab8F8QUEilWExe4tiAX4rLjOYXQN1VPuCMAv1
         +zrb9425NA6Xmf9+pveTmxP1xIPWKo1i82QVLj7klLmdRTqjVusHfqg7GZXsrh8Hwdrd
         N0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j9bikNOBq54bkXwKYMMXRLaGs1bQhNG+bnxPz7oUDlA=;
        b=Cko+n57Unikpc0xm/lxT7B15+6p00FamaJjYJpsvly/yoKkJplpWEiRAh8KKzVc82/
         p09NDsAEagkd75Jqb5S8+RNyvUl1D30vfSPFkD14haFztCayCx9RkrcYVXRys9gdbp01
         O8RzwCv+DV4XDper8mXtLVYVGgl4kMmQnKWT4DutkIJrJp4UfT/8G/iTRl7Wnf2ags2b
         gSjBZXs7jer2/NpKxIRizyqyaoMc8eV+cOfnGULdEGdb4MG/QnE+SDEsswgE2PMqp02T
         qNFIXSn06w8gLE9O9wT92qAOduNDtznloECOYMWvqk1ja7LrBMks/s0vUbnr0KCErpdx
         51Lw==
X-Gm-Message-State: AOUpUlGm6YBpwhriB1udR5aKGwAJ7K/KrfK7ndz2CDAPzvNkRbXTlKX+
        57GN+hgmHbVBmd+SoQWhnL75wmCv
X-Google-Smtp-Source: AA+uWPxew1HKngBeeqbTXf3ncR5NkqSZcY20e4KCPxCVWkihzDtc7UuFA/n1IDmfAXnjA7uq2HudbA==
X-Received: by 2002:a5d:5691:: with SMTP id f17-v6mr1229957wrv.58.1533814570956;
        Thu, 09 Aug 2018 04:36:10 -0700 (PDT)
Received: from localhost (pD9E51C80.dip0.t-ipconnect.de. [217.229.28.128])
        by smtp.gmail.com with ESMTPSA id g10-v6sm6999182wrv.90.2018.08.09.04.36.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 04:36:09 -0700 (PDT)
Date:   Thu, 9 Aug 2018 13:36:09 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Aapo Vienamo <avienamo@nvidia.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] dt-bindings: mmc: Add DQS trim value to Tegra SDHCI
Message-ID: <20180809113609.GI21639@ulmo>
References: <1533650404-18125-1-git-send-email-avienamo@nvidia.com>
 <1533650404-18125-2-git-send-email-avienamo@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xQR6quUbZ63TTuTU"
Content-Disposition: inline
In-Reply-To: <1533650404-18125-2-git-send-email-avienamo@nvidia.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xQR6quUbZ63TTuTU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 07, 2018 at 04:59:57PM +0300, Aapo Vienamo wrote:
> Document HS400 DQS trim value device tree property.
>=20
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>  Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.t=
xt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> index 3c7960a..7d294f3 100644
> --- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> @@ -72,6 +72,7 @@ Optional properties for Tegra210 and Tegra186:
>    trimmer value for non-tunable modes.
>  - nvidia,default-trim : Specify the default outbound clock trimmer
>    value.
> +- nvidia,dqs-trim : Specify DQS trim value for HS400 timing
> =20
>    Notes on the pad calibration pull up and pulldown offset values:
>      - The property values are drive codes which are programmed into the
> @@ -88,6 +89,8 @@ Optional properties for Tegra210 and Tegra186:
>      - The values are programmed to the Vendor Clock Control Register.
>        Please refer to the reference manual of the SoC for correct
>        values.
> +    - The DQS trim values are only used on controllers which support
> +      HS400 timing.

One of these additions says "DQS trim values", the other says "DQS trim
value". It is unclear from the above how many values there are. I think
this should be more explicit. Also, I don't see why the note about which
controllers the DQS trim value(s) applies to is in a separate paragraph.
Couldn't it be moved to the property description?

Also, I think the bindings should specify which generations of Tegra do
support HS400. Where else are people supposed to find that information?

Thierry

--xQR6quUbZ63TTuTU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsJygACgkQ3SOs138+
s6F+PQ//Sy+W2dQjwsIevUD60h4o/MYKtvLKHwJAfy7RZJ8Bj9HLJMSE66Sx7+Kn
nZPNrn76YGF6tBXsjgkvMaF2yNOsny9ggCbx8ktdpXyZPAGx7Z5ZNJPai93h1+ea
QXrj7aUxyl1ZgPA7aAA5VbYgwH4xUSD8qhuQBbrZFmlD7KJw0k5+K06S0E3CY8Je
TDEuvIEWMX4WMUOvc/vNK756ieW8r0NrU++iuy6m/11DU+fn29gZ79ThYSFQyNPA
zSCYNf00ec7jN4uCTqVPvUO6/dguNAG80xwJGzkuBiaJXaF1PiWdmXI9iS/JvYgw
4Qs5D1BnM734ysrlwEisju+qgktPNMKl+yrVdkiG6KfWkcOtV4yYzfbnhUoP1UdV
Y8PygMgDQtdfH7aHok4NUoIdetbvYIecdvrvGhqcEIsxWYifUnjbil9lQOzf8PPF
P9Hkp0+MHI86wGJRR5+gIeUKmRN8/LODM6YOGBY0AnVVS3c0gMRGx324MU/gNwkA
qurn0ML81uTrv1U0ANNt6rxRt38hoMHbCThPmvaID580tNgleKbcLRb1t86odlIK
R5McG56coeNySKU6UL5O3nLZsbNeW4nioEYIRgwJ9+un5J+AVd8zpQJRatffgOkl
pFuu4AZuYiHYXsymmBrPK24iqi6MVbYGUpG3AjtnagA3vhyc9KU=
=CKUn
-----END PGP SIGNATURE-----

--xQR6quUbZ63TTuTU--
