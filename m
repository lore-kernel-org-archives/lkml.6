Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864E0C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37AFE21509
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="trQinmp4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37AFE21509
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731682AbeHBMFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 08:05:19 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46540 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbeHBMFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 08:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XCXc/o0DnUitj8iLzZx16kr1uTbxMt/m+cByi9Sfnzo=; b=trQinmp4zYttpTTUiSPB+EHSQ
        N0OphjdaRudThHZ3s4UZFethjJNKhysvrj0wwS1Pf9kDYj5UX52yFOX4kf3gjZ/7gH5H5+E/iqS+h
        a4lgAvbf56RN0DpC+IYHOnzQs3Xig8q/gjeVehJz6fBqxMx1EGaFcvdMsLL9RfzmzEILs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1flAcv-0001sX-RO; Thu, 02 Aug 2018 10:14:37 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 774EB11242E7; Thu,  2 Aug 2018 11:14:37 +0100 (BST)
Date:   Thu, 2 Aug 2018 11:14:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     jic23@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: Re: [PATCH v2 3/6] regmap: Add regmap_pipe_read API
Message-ID: <20180802101437.GE9117@sirena.org.uk>
References: <1533136667-31828-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xJK8B5Wah2CMJs8h"
Content-Disposition: inline
In-Reply-To: <1533136667-31828-1-git-send-email-stefan.popa@analog.com>
X-Cookie: BARBARA STANWYCK makes me nervous!!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xJK8B5Wah2CMJs8h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 01, 2018 at 06:17:47PM +0300, Stefan Popa wrote:
> From: Crestez Dan Leonard <leonard.crestez@intel.com>
>=20
> The regmap API usually assumes that bulk read operations will read a
> range of registers but some I2C/SPI devices have certain registers for
> which a such a read operation will return data from an internal FIFO
> instead. Add an explicit API to support bulk read with pipe rather than
> range semantics.

If we're going to do this it's probably best to explicitly mark the
registers where it will work otherwise we'll end up confusing ourselves
and corrupting data at some point, provide another op like readable and
so on. =20

I'd also suggest calling it something like _noinc (for non-incrementing)
instead of _pipe as I was a bit confused about what a pipe read was.  We
could also have a software implementation for things like ADC outputs
where the register doesn't have the convenient nonincrementing behaviour
but we want to do repeated reads.

--xJK8B5Wah2CMJs8h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlti2YwACgkQJNaLcl1U
h9AviQf/U61lFuMPKacSSxRzqCrcwQ/U8WiIbPEeHuDyeCcg5sG4CH5Srh7ibDNU
o325C83BXWWHmt77KuiDZp+vnooX7SOauLlVjS6YgZ8CoQ/jeeDJuI8a+LGMW8Y2
Hary1PbC4Br4ETuRxBUbVg0ZL4gZ0FYzmephHSdE+KTBYnawl7vexSenN+NPc+iz
Fn3bRc9oMHm6vYTjDiUG0o1z6ymxaaWdAdOOpEuXp6LpBrPtPWPIs3Dijy2yLUDk
/RO/JgrNhcha8pqWhmO1wT50Z67ofhKyNA3cZminOlnEmq8Tpuv2YufB/mI0C6WC
7HuGQebfxWQRxJkjB/5pXRl8WmyuVA==
=mnD0
-----END PGP SIGNATURE-----

--xJK8B5Wah2CMJs8h--
