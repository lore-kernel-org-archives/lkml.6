Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C015C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 08:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64E5E20818
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 08:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="YVqYjp/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfBGIvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 03:51:35 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17113 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfBGIvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 03:51:35 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5bf19a0000>; Thu, 07 Feb 2019 00:51:38 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 07 Feb 2019 00:51:34 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 07 Feb 2019 00:51:34 -0800
Received: from localhost (10.124.1.5) by HQMAIL101.nvidia.com (172.20.187.10)
 with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 7 Feb 2019 08:51:33
 +0000
Date:   Thu, 7 Feb 2019 09:51:31 +0100
From:   Thierry Reding <treding@nvidia.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpu: host1x: Use direct DMA with IOMMU API usage
Message-ID: <20190207085129.GB8741@ulmo>
References: <20190206220833.GA20747@roeck-us.net>
MIME-Version: 1.0
In-Reply-To: <20190206220833.GA20747@roeck-us.net>
X-NVConfidentiality: public
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549529498; bh=/1A9iRrnKaJbvAc1fM4IfG7OpJDIk8c3X97/xuJFlp4=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:In-Reply-To:X-NVConfidentiality:User-Agent:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Disposition;
        b=YVqYjp/6yARt7Jz6cV3hA0tBZ5q+AiAgesfUmCQRL4LKI0VtcYMq++XiP5nD+p3pY
         8F1XYDfCp7SZvpx6nV+MQE85ZvAxulSTz5cEjdE6HQSLCafyN9NmO5ve9TeJO7jKo/
         6e8esgt6DlV7U2+dCpv537AtXBdyALVAWW6yM9pmokRE8eQhnbE3sHW2oPCVQevLo7
         vnh2ubNYDa0cN5g/iRzsPcLDZWaX+wiyvuTfg8wg9P5MthfG31PdLHGTkd+tiNEwP1
         S5Yj0/Jl+6jCmr7GuO0p2YqsNnYq2DMRolGkdInKYDMhxngibC6nwG2YZ3wUT2nllr
         CcZwzPTIQhKcg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06, 2019 at 02:08:33PM -0800, Guenter Roeck wrote:
> On Fri, Feb 01, 2019 at 02:28:26PM +0100, Thierry Reding wrote:
> > If we use the IOMMU API directly to map buffers into host1x' IOVA space,
> > we must make sure that the DMA API doesn't already set up a mapping, or
> > else translation will fail.
> >=20
> > The direct DMA API allows us to allocate memory that will not be mapped
> > through an IOMMU automatically.
> >=20
> > Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
>=20
> arm64:defconfig:
>=20
> ERROR: "dma_direct_free" [drivers/gpu/host1x/host1x.ko] undefined!
> ERROR: "dma_direct_alloc" [drivers/gpu/host1x/host1x.ko] undefined!

Hi Guenter,

I sent out a fix to export dma_direct_alloc() and dma_direct_free() but
Christoph preferred not to merge that, so I'm currently working on a
different solution for this. I hope to have a fix for this by the end of
the day, but if not I'll back out the above commit.

Thanks,
Thierry

--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxb8ZEACgkQ3SOs138+
s6FtLg/+LnL4AhHtgPwa5FzeBJm2Muu3XyCNi0E/PFYLtlepTS0uD/YrowxXCNaz
ibhWyh76YdbwyCwuR1OaRvEOwUHinG4FLETYr0TZaM/UMpVV1NqYpOg4+js5a7kR
ymXtE0O3+8Yd1pwUjc63ehcoOQUKPJorwkFTR2K+0h1iJy2uSF+rNNz2pGoHr7zF
ORvkm9k7OQFN02i2syelDAJMdjhYWcV3CCq6bhBt0S2AzBrzhzR8kmCi6NqY9fk2
Tm1E/c+Up3HcgAkyb3qNxhzJqX28aUU/6JYyIIwn5DfXHoGRGLwjHx/36Gv5/fuS
59pUn7sgMwE4KuM6PiE8o8tPGak0+btvZ6X7En4okjRG5Q91vgaV+JRsWntLS3pJ
0uuvOo17QkQuQAlfhMQSXtlKwAp1RQNcljtFAXV7O1RcrZf98zyifHAkukd1HvjT
lB+xrhzaUyKWhL4ByDcs++lUjFvb0Xjr4LUoulh+VjvCPXz2xYpFj+1xLNz4AGGI
hMtZnCx6J7WosUVLuz2Yi2tvqq1wEvBl+8Kd+ZkHTNZvlCamHVSBar7Pfr2kyFVC
o4gJtqpz87dTgKdVJI8dvFWndcDltOQv5De0VOB/u5rL0DRy8a/1vMYpsiwTGfOB
tc56iGzi8XZhzxkVTCYcyROBJWc/PWY9+R+ZNvqlHYg2FAW1d2s=
=hsue
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--
