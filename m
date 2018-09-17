Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A49BECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7283214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="cv1vZ5OI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7283214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbeIQVzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 17:55:45 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54906 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbeIQVzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 17:55:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=scWtCDAXzJvpxbskgmCctuutUf4cNvk5i+BZCJcBqBg=; b=cv1vZ5OI5zzzu1Ycr82GNu5vn
        KbRI8Xkbl2yAlNsiyfDNgmS2RYyFgykYWyqRvjdE0Rl6PTztTnuwnLqtSC+3ls5sN8crFUc6X+aS2
        Y030553f34oxvaNd+apIWjC/AnwMuDqGjYM2GSW6TMUXo/a1Yx0G0BKdQFEOCEDkZbTpY=;
Received: from [209.121.128.187] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g1wN8-0008IN-Ax; Mon, 17 Sep 2018 16:27:39 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 54AB7440078; Mon, 17 Sep 2018 17:27:32 +0100 (BST)
Date:   Mon, 17 Sep 2018 17:27:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: Gracefully handle power supplies with disabled PM
Message-ID: <20180917162732.GA2471@sirena.org.uk>
References: <20180917121041.21084-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <20180917121041.21084-1-lkundrak@v3.sk>
X-Cookie: Universe, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 17, 2018 at 02:10:41PM +0200, Lubomir Rintel wrote:
> This allows use of SPI when power management is disables, such as on
> early boot;
>=20
> See also: commit 31eb74318054 ("PM / runtime: Fix handling of suppliers
> with disabled runtime PM")

>  	if (!was_busy && ctlr->auto_runtime_pm) {
>  		ret =3D pm_runtime_get_sync(ctlr->dev.parent);
> -		if (ret < 0) {
> +		if (ret < 0 && ret !=3D -EACCES) {

No, this is not at all clever.  If the device uses runtime PM and
doesn't get resumed then there is every likelyhood that the device won't
even be clocked.  If users want to disable power management it's going
to need rather more work than just setting a flag.

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluf1fEACgkQJNaLcl1U
h9BnAggAhCJvRzvP5akGwvZ8hcI7I9qnNqdd91sGNeEAKNCjDvOwu6Ctzdf2ijIN
uAYTMmflw9KO9sJm+4rVdDvrlYCKXZtriVrNiRFOEy4O2t2v1SAWTwXhVcqMM0Bc
Th5FLvjJjHZ+nKqbjx/WtNa2sQKBIqxbz143Ze4fZCa1eRlt4zR3IieeImGPiw4l
MUOE7gaNTsIxEeyYeipe/tVWElh8sqK4TrVcwdVaScl5IQAMtUWv6q8x+80jPv4i
o1IzggtxS+eyS1K6/Kf9iksxe34sbfVMGAY9tQsF7IOkJl0CAa53djV90LrTS/YY
/8zdIQBgvKjXYSvl/c8OCuNT/+vHSg==
=zyyw
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
