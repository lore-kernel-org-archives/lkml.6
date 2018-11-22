Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78E7C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F4020685
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="prmmzlWJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F4020685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405786AbeKWBzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 20:55:12 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41894 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbeKWBzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 20:55:12 -0500
Received: by mail-ed1-f65.google.com with SMTP id z28so7977600edi.8;
        Thu, 22 Nov 2018 07:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6a9LzmKS56YzOVqaRM59XVIPSRliqPOajs4PrcNz8aU=;
        b=prmmzlWJEsNv9JRu16pkUvs6NyRJ3Ugd7ubk0BRwwM3LZtsn+WRH9zqg9nr8Y8+WZ+
         0rWOMyxEJMXOGzGkHuBoSkBO8YJ6K8NWEOXZbOAy7MqvIrgfOn2KcZq7ZMZPnhf4gKny
         gQKNlwlKeTeigboYF5Wi/+NxhDpr0x5hRmrXg1XduhIhbgw3ub5n3XXjkG1VVxtUfk0A
         ieMmNrqvmauPCS614rIlVhwbJns02QRwyhpzWBUedltH8E+lYdDKR46Q41IWjPMBWCI9
         xA8Pbfsn19JSbqeQMsgqsEn23ijrlbpHRS1ym8RU1QBb34vev/CzvVv67fl06IjFlico
         peLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6a9LzmKS56YzOVqaRM59XVIPSRliqPOajs4PrcNz8aU=;
        b=k/E3a4MKe03mlKmW52aTvzysYu5iIQ7dqaBOMs2qZJs8jptqlbt3Eqwno/XR2Y8tYZ
         XG/4ILZuxu/o46rxTznqN6PiNNir/TWceNCA5tdjiXbfDAa2deYw87MQYPUuux9UgbcD
         lEXw1/xUm8Ec8jlbKESCKLp9Bw/039Otq2DIJWU5/JHI6PNVHEC1UObzXPhmSJxRirQa
         +FrimCsBtVnCcnznAv1s+JJPLdCSzz+kgv6Mq+CWAP8QFcC/3l3/Pkq+KyGPmrgPzN5I
         /kqu9OGc7XPr0+D1W7U/etMub9z2sY4qSC75nmDYgKJQRaevZ0DGy4z54TWwYFODhPAy
         BQmA==
X-Gm-Message-State: AA+aEWbe2VGr0MH1Xobmk9QVr4FX6ev+vVrvdb5w7ya/XD24c/Krt2k8
        QjA1b+2H2h65XrKE+AOVWE8=
X-Google-Smtp-Source: AFSGD/X+wdCV4+GxbVEuHufx1qyoJtFe2mN+Nxl5S8AolVwYf2LkT32TzaGzGKEsC6A5HrMpEWGjbg==
X-Received: by 2002:a50:ac81:: with SMTP id x1mr4899746edc.71.1542899723758;
        Thu, 22 Nov 2018 07:15:23 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id s6-v6sm14298248edh.89.2018.11.22.07.15.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 07:15:23 -0800 (PST)
Date:   Thu, 22 Nov 2018 16:15:22 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     joro@8bytes.org, jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/tegra: Change to use DEFINE_SHOW_ATTRIBUTE macro
Message-ID: <20181122151522.GC24661@ulmo>
References: <20181122133047.24902-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DSayHWYpDlRfCAAQ"
Content-Disposition: inline
In-Reply-To: <20181122133047.24902-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DSayHWYpDlRfCAAQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 22, 2018 at 08:30:47AM -0500, Yangtao Li wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>=20
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/iommu/tegra-smmu.c | 24 ++----------------------
>  1 file changed, 2 insertions(+), 22 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--DSayHWYpDlRfCAAQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv2yAkACgkQ3SOs138+
s6GsyhAAwjLJp+PspBwW5BEnIVlJulbmkaefJnCMpAhYnBKkjTjL3CYzBJt//yT5
tNXqCIwuRpbV6O8e+jig3aWZQRsIY3Md0iSk2OGXf0iF7h03l91rUyKjUDEeNi0G
+MOQk3LyULOZeBb/nL/bJppQyQKPbG7ejC3k/RUmGuF5yt9O+qsythYFLQgYtrON
tRuy2ff6r6gdLa2LWzfkEdHri2Meu3SrTRDeYHf6XblUsN9nRhitm2Em+dlftLYM
WUGOUUsC9qigG+9lZ2Fqwqwac1t52cV5QggTkmR/fnZ0vWNiRDQQctKZZ8gOWQeo
zAaHMa9IJ7s0QBhyHi+DHH1U+8Fn3IuEJRw8ukBRiLjOsJluWljWOgbv9yBZ8xzE
vXYnvRvMBp1vfAwMHUpKj0N/XBJJUpJ9EZipebHcu1nuI9gDpvk2iuTiY/qXOa+U
MiMPwDwa7Su0D+VgrIrTdusVwsK4bJOkgSWSX6pwdFAiyhFA7FXemOcaY4GOSej5
RH7VqfbF60+IjVVvevJaVinGiRiiI4kPMu/HJjwMfYpnk9MF3tdvkQ01Avg7AHpY
Kxs+tVaaCXxszssvv7Xz+Mj6D/TN1qlyxCi6p1ikBFqlJpsPCVWke5xACq0zBZ0V
oT9HE9XBno51EMWo5MxVbsx+Yqmu2qd4v8x3LAdUlZ98PtnHuJU=
=QVqj
-----END PGP SIGNATURE-----

--DSayHWYpDlRfCAAQ--
