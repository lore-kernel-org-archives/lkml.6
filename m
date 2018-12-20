Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC895C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CA6D218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSk0XIYK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388176AbeLTRuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:50:15 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34426 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732259AbeLTRuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:50:14 -0500
Received: by mail-ed1-f67.google.com with SMTP id b3so2494027ede.1;
        Thu, 20 Dec 2018 09:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TUQTlyqc6f9mbz9aRI6ZWP4z0vW0Fjk9deB5vRyDbD8=;
        b=CSk0XIYKOwObwURHvhN60J4CJERe+WZxBVRlYLr/Fh5yltGDHj0RO8Mr33L8WCnN0n
         3MvCJx3xwyqrU2fo2gJVRpwNSCUDWD0ZjPvwiTaCNKhUFnG3Rs+2z13sgygnIT5ADo2s
         dsVWu5InSaFabM11L7LqJxajPh8SPcNL1dVpmm80i7LlzzaWOOM8TWus7eURmAZKJ34W
         MFwfY+ORSzGgPDxZweQfj4WWHl9+X+uXorEZmORfJIK+gM4/ThAxOQwn0RQMkT6ZXe9m
         c7oFSzxNTx3Fd8u/xNXfFhCJ4pugQ06x4C3bXEdgbGKb3QP+lNoYEfDW6hvjVdD8dpSe
         RHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TUQTlyqc6f9mbz9aRI6ZWP4z0vW0Fjk9deB5vRyDbD8=;
        b=ZJEw33bULb9jU5wL5ulTzKtn0R2uzmBzGQ7H0ltFb1tqgXKrXFfRjnBCOPiQwy5Fke
         my5CR+7defCdtoG354pNwQcOftfY/H6qhkQ66J46yehqmQDnNF2lLgY/CiZCCGEr3Z2w
         h4ulJcDSlbjOeeXGf1gDsQLIMWm8xoeqe4rX0PbxoDwG7OqoAcfecTcNLnCfFhMj0zBa
         3/DAkCAS1lG47OwXtdTGzrQu4ADWTeabIbrcCqWe8NaFh1oCJAC63ZdOicFAGNDR6GuC
         Gk8a/frkViCCTpX9bN8WusrecAU7eWfPirNicQOmsgvT6nn/TUClKxL1RBPy5G7XqDvc
         cTgw==
X-Gm-Message-State: AA+aEWZnSYjcxkXKDHVBUVzNTmeyMlvicoMmgjIkEX3CCEyxyeHcU4kt
        /YmONYlfrD6pjMzyTRhBbhg=
X-Google-Smtp-Source: AFSGD/XlvvuHfiZCrBoZtfjTTj+clRp0f7moT4gbfvMhvlglGiu8+vAFto6P8hV1s333lx6h0X6wCg==
X-Received: by 2002:a17:906:515:: with SMTP id j21-v6mr12819054eja.39.1545328211161;
        Thu, 20 Dec 2018 09:50:11 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id b9sm6594602ede.12.2018.12.20.09.50.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 09:50:10 -0800 (PST)
Date:   Thu, 20 Dec 2018 18:50:09 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Hao Zhang <hao5781286@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 1/6] Documentation: ARM: sunxi: pwm: add Allwinner
 sun8i.
Message-ID: <20181220175009.GF9408@ulmo>
References: <20181125161859.GA5277@arx-s1>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IvGM3kKqwtniy32b"
Content-Disposition: inline
In-Reply-To: <20181125161859.GA5277@arx-s1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IvGM3kKqwtniy32b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 26, 2018 at 12:18:59AM +0800, Hao Zhang wrote:
> This patch adds Allwinner sun8i pwm binding document.
>=20
> Signed-off-by: Hao Zhang <hao5781286@gmail.com>
> ---
>  .../devicetree/bindings/pwm/pwm-sun8i.txt          | 24 ++++++++++++++++=
++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt b/Docume=
ntation/devicetree/bindings/pwm/pwm-sun8i.txt
> new file mode 100644
> index 0000000..7531d85
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
> @@ -0,0 +1,24 @@
> +Allwinner sun8i R40/V40/T3 SoC PWM controller
> +
> +Required properties:
> +  - compatible: Should be one of:
> +    - "allwinner,sun8i-r40-pwm"
> +  - reg: Physical base address and length of the controller's registers
> +  - interrupts: Should contain interrupt.
> +  - clocks: From common clock binding, handle to the parent clock.
> +  - clock-names: Must contain the clock names described just above.
> +  - pwm-channels: PWM channels of the controller.

Why do you need this? In the cover letter you say:

	"The sun8i R40/T3/V40 PWM has 8 PWM channals ..."

Why does this need to be specified in the DT?

Thierry

--IvGM3kKqwtniy32b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwb1k4ACgkQ3SOs138+
s6EOyA//auHjqjKwvjCLwWgHXdVr26cFUnFn/Ml6ZHHRe+oLCiYsatv4AZfGFvZ7
CIGWN3zUu9c5YoDOd1isauQYgRtTsShWYC4gPxFFK9hWfb8f3o/wG60whkNDuvLL
1SAQ/KJTC01LQIEXfHlb60EPvKCtt4YUQG4PkTGBGOHSO+MhWQHRLy5aLaq+d3yH
KHaDZ0PuZvYNnFWi7W/ggraiIlRToPH8HanFzGew+gUfPjClrczjrGqgn8u0bAL6
MuKDMHLgjI/D8cs7XIaXc/OCPsp69B4JGrRJsxYh0KGKthaYDeKAUERpvsltDhGT
oTB55mJPZlriaiEOSwPrj+M0JQe9AnUIBVEiSIP2dSn8+rcSlWd10ysEjnCH/Ea7
ARkamiRCk2hgOhZlDZcm+hjh7VxnJinaYahGFXMszpVgCScHT/fjZKexGqX8NJa8
EWRJjeJaS1jLpLb7ZhM0iZrhzSC638G/5z3+1CWmyxwOvICb0FXzQDCTNSm1t8DO
NicV26tAWMIvDEW5PcTqrJaSvQmNrr4MiBiqocKs4N+ZA7Ey8JQW0oUFzwiwD6Ew
HaOuVXDlha1SZNK2tEnTDsTctXefl+eB7xeQ8MOHPp3yeKrpQlj4gHSyNOboEaXR
8el/ZC1gGYHPeFGPSgXTbRNFwNY8/9GKPfP5cUgLc+e1B7oWAHg=
=9v1O
-----END PGP SIGNATURE-----

--IvGM3kKqwtniy32b--
