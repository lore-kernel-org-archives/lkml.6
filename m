Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA2BC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 13:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F08432098B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 13:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="aSUHrORc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F08432098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbeHZRGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 13:06:52 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54178 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbeHZRGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 13:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vGFSkFRn+av84V8N9h8jSax4PobElq1TltmajYo+jSQ=; b=aSUHrORciHeMEVleqZYjQolDz
        Kz74cfQRBYx0PtPiGEJAk/HJnlHHBJXQMnwiJbNFYYLtvOqoeHMRhzOt24+1809sQl7rCKi/0bUBh
        u4/9wiRqBLw0Api7XJWEaeSr3Eb9upZAHqXmeoEXjVxa7zSlUk48CdF1n3qhpb/DII90k=;
Received: from [2001:4d48:ad55:2401:8b41:d939:2045:fb4c] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ftv1c-0003CK-3V; Sun, 26 Aug 2018 13:24:16 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 31D35440078; Sun, 26 Aug 2018 14:24:15 +0100 (BST)
Date:   Sun, 26 Aug 2018 14:24:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kirill Kapranov <kirill.kapranov@compulab.co.il>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] spi: Fix double IDR allocation with DT aliases
Message-ID: <20180826132415.GB2414@sirena.org.uk>
References: <20180821095303.27664-1-geert+renesas@glider.be>
 <35fbd3ae-3ac3-f6ef-874b-3d99c4d4d29a@compulab.co.il>
 <20180823102121.GC5207@sirena.org.uk>
 <a1bba27e-a287-c162-a238-eeae1e84d63c@compulab.co.il>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3MRlEjvj2/M31Nfs"
Content-Disposition: inline
In-Reply-To: <a1bba27e-a287-c162-a238-eeae1e84d63c@compulab.co.il>
X-Cookie: Many are called, few volunteer.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3MRlEjvj2/M31Nfs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 25, 2018 at 08:54:53PM +0300, Kirill Kapranov wrote:
> > For DT systems the dynamically allocated IDs start at the maximum
> > positive ID and work down so in practice it is vanishingly unlikely that
> > there will be a collision as idiomatic static DT IDs would be low
> > integers.
>=20
> Yes, this algorithm seems really bullet-proof. However, it isn't actually
> used now. The ID allocation algorithm using  atomic_dec_return call had b=
een
> introduced 2006-01-08 as [1]. It was being used in the mainline kernel (w=
ith
> some improvements) up to 2017-08-16, when it has been replaced with the
> newer algorithm using Linux idr, accordingly [2].

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

> Since idr_alloc call works incrementally, the situation of a 'fixed' ID
> squatting by a driver with 'dynamic ID' seems more than possible.
> Therefore it would be justified to use a hardcoded constant
> SPI_DYN_FIRST_BUS_NUM (that was introduced in [2] and eliminated in [3]),
> but with a sufficiently greater value of the constant.

Right, that clearly wasn't an intended effect, though - should be using
the max of the big constant and the maximum static ID.

--3MRlEjvj2/M31Nfs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluCqf4ACgkQJNaLcl1U
h9AqlQf/f1Ygj0gQJI4WHKVVOeOAKQ/lCjedt4b1RPCSVEI2bL6xDZe285X3giTA
O7esPQ5FidXofVcJbXVvI5RbkSm4wVYjjcYOuMLU5BruXLZlYXbQztVRSuZhqlXI
YVbERltGQV2TkCgR+y7IPB+BzIfJLz4ZS/kXnHwbRcD7VEAKiEm8CTn5xslXl2ao
BBGtKaTRalGAe7guBHLWvzsFoPI4lEO9y4AIJXksDCj0y7mX6NuAGxUNXl4HJMD+
ztyRWAywmC/zNL6c+z3sXIFyGDI5F6UgiWHb701i8frAVflq2sN/JuJWHid6j34U
JgU4Eotl2oBlxbZpjT5chbCuiHDoNw==
=vrmZ
-----END PGP SIGNATURE-----

--3MRlEjvj2/M31Nfs--
