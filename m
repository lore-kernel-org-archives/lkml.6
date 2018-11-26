Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7AEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 498A22089F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNNONZQj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 498A22089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbeK0CVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:21:07 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45040 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbeK0CVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 21:21:07 -0500
Received: by mail-ed1-f66.google.com with SMTP id y56so16150542edd.11;
        Mon, 26 Nov 2018 07:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8SqajA9Q/sm+TfBlQZRt/02S6xni7B8LPuFTIzWVMS4=;
        b=lNNONZQjWeif7UVP8xOK1TipAHCqHrtRjhObZJboGc2DtqGjAnObKtUEIfhZAjlDFq
         1b5U9havSgzCnnOiXuBl4IZ3U2nCqlmEThQ3C4jubqF1/+6eP6l17Rpzp04tkR7CtiS4
         tdBoI4smGk8lPsYoUy9sen8O6jeTA8qH5k05uIlEDTSAvE1syNBKL28yuUmzUr+GZmW3
         B9UYNDtS6mmkDoSzjgbybbT/7V75Ux9lsvWwKCziFFMvzM5ZC66tymAKx+hJNVGdA0KN
         Djea+638ivCS6PwNVUpk53cbKOLPX2cB9qL6/e+t+WpbBq93ArmvttLK0Nr5C2OshOCm
         tIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8SqajA9Q/sm+TfBlQZRt/02S6xni7B8LPuFTIzWVMS4=;
        b=ue2fVELA2znI6vzSGGUzuxJxM6AiK/gPB6KDnxXJ6z7d3fCzY32hIS4dBepDsucTDG
         yoX95h20EdsS4dJbDRJDHGVmRn7T7zd8fYl1v5uNU7KQSSCEwfTMnJhaNu7c6+k68nFL
         4SkYZqyQCaPBAFe2P7t1FuFf7BBA5NKD2PBieZ1pd9Gi7ASwXi4jS5qbN6cbzfDTRKLd
         zM95RtEZoz5A2gstC7OTe/DQlygj4YGVeEVueEro6kTLhcU4HlG+5KVcxiqCp68Oag16
         Xd5hLDdVIyKZLIiheYCLNjGIExggATrjuur3AdJohuAVHVAaiofkd49X5JoUazzS3YjF
         Npgg==
X-Gm-Message-State: AA+aEWYtrqpQ5C9Vz/Bmi6OWRA7zGMVSsrWlIcw2chmO+Qes3y+auP2M
        jLxIgW+9K4M8ZWK/oxRP2cE=
X-Google-Smtp-Source: AFSGD/Xg0+9lRQ5Zl3eU0hmRSwGDrOdjMdg6Zgfawb1pVGCbM1y2az1PoyuePH4upZqEkFs1LPtSKA==
X-Received: by 2002:a50:f5af:: with SMTP id u44mr24347965edm.172.1543245999264;
        Mon, 26 Nov 2018 07:26:39 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id x38sm249647edx.24.2018.11.26.07.26.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 07:26:38 -0800 (PST)
Date:   Mon, 26 Nov 2018 16:26:37 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Hao Zhang <hao5781286@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 4/6] DEV: CLK: add function to check the using clock
 name of driver.
Message-ID: <20181126152637.GB19710@ulmo>
References: <20181125162118.GA5358@arx-s1>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Content-Disposition: inline
In-Reply-To: <20181125162118.GA5358@arx-s1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 26, 2018 at 12:21:18AM +0800, Hao Zhang wrote:
> In some situation we want to check clock whether is we want
> and after the driver been probed use to change different clock source.
>=20
> Signed-off-by: Hao Zhang <hao5781286@gmail.com>
> ---
>  drivers/clk/clk.c            | 6 ++++++
>  include/linux/clk-provider.h | 1 +
>  2 files changed, 7 insertions(+)

This doesn't seem right. If you're going to change to to a different
clock source anyway, why would you even want to know what it was set
before that? Isn't that completely irrelevant?

But if you really need this, perhaps a combination of clk_get() and
clk_is_match() would be a better approach? Perhaps best to let Mike
and Stephen share their feelings about this kind of API.

> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index d31055a..3d2c2cd 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -3466,6 +3466,12 @@ static int devm_clk_hw_match(struct device *dev, v=
oid *res, void *data)
>  	return hw =3D=3D data;
>  }
> =20
> +bool devm_clk_name_match(struct clk *clk, const char *string)
> +{
> +	return match_string(&clk->con_id, 1, string) =3D=3D 0;
> +}
> +EXPORT_SYMBOL_GPL(devm_clk_name_match);

Also, there's nothing about this that would be device-managed, so the
devm_ prefix on the function name is misleading.

>  /**
>   * devm_clk_unregister - resource managed clk_unregister()
>   * @clk: clock to unregister
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 08b1aa7..5cd2eed 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -764,6 +764,7 @@ struct clk *devm_clk_register(struct device *dev, str=
uct clk_hw *hw);
>  int __must_check clk_hw_register(struct device *dev, struct clk_hw *hw);
>  int __must_check devm_clk_hw_register(struct device *dev, struct clk_hw =
*hw);
> =20
> +bool devm_clk_name_match(struct clk *clk, const char *string);
>  void clk_unregister(struct clk *clk);
>  void devm_clk_unregister(struct device *dev, struct clk *clk);

You use this from clock consumers, so clk-provider.h is not the right
place for it. Also, you'll want to add a dummy implementation for the
case where CONFIG_COMMON_CLK is not set.

Thierry

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv8EKkACgkQ3SOs138+
s6EqSA/+KecW29TvcRN+tsDP+2qTYxrw9IhCvgGgkvwWizFuMIY1kjajRebUe9j0
3jxWJ6hLrw1E2sL4ZwMOZJnw6GI2ApMg7PXy2R6F/awZ6vMOB2FE1BUTDWLBYP5v
2PHAy+kvDli+Gl74PCZy58BnOSZyncRP9FtoBJDZ4jx/LM8JGcIhqq0ybi0OTQjA
Q8ZEvPTdBZ8kS8PsjT6zSYIaUtYw7ejsemBPORaHFHJlHokUkfA2kMGJVhHsGnZH
eMngTXRf3q4U3Tx1reukBa3EfDuYRGl2OVVGKPGp1l6HuOpoAPjuGCA9ASP5bd3N
72OsNdbzp2kIU+BZIrmgnjQ6DQ0jQKpcHA7iomKYw/Qku8Sntu35Yj11LnF+3bJK
dR0rlTg2XV+GPigvGifh2WhFcXJ8C+CJKHmcaR3gyaigS8bYaymWe16HvKdPklSz
2tKo6pUlMKTHf5oYtTTNtlBNgGRjOuCjt23keuwrse8willdrHxdR9pCE0vUL3iN
StIfJTdq4FSJx+dsZBXKB4MUQ8oNckm9lEwZbI4jHaNi35eoRy3z7NrA07FQ7DLn
x9nGhvayD5xjYfJyzhk/XEC3w1FPxWIVmlP+v5IBNR28ei2EF/UZAEjN8uDy1Vul
UvT6cGuYmdMaw8x+tEXyrLMJI1iwDWDUwk8QV8/lurjsDfsEOxw=
=1aiA
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
