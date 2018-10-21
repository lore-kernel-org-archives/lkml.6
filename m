Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51400ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 11:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B832083E
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 11:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="RFUowC/T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B832083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbeJUThX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 15:37:23 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50340 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbeJUThX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 15:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=n0s4/5nYi1ErNihuL+0YrceJPCOTVqM0hCgk36SP488=; b=RFUowC/TvVbVN/vGGbMpnYBdb
        kLbrQF8GsK6mmalqqNpid6WLG5E17JGHkhp74RI+bIWOec6ksSW+vZEpe7kgGUKOooh0ftqmYWQq9
        iptczHizHK1Md+qK9fPctsPUaIL/o555XqkFHXBmykizKWlaSB/ncOfUJBQml45+2Nzhw=;
Received: from [87.246.76.36] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gEBoz-0003sm-Nv; Sun, 21 Oct 2018 11:23:01 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 4F220440078; Sun, 21 Oct 2018 13:23:01 +0200 (CEST)
Date:   Sun, 21 Oct 2018 12:23:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Marcel Ziswiler <marcel@ziswiler.com>, alsa-devel@alsa-project.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v1 3/3] ASoC: soc-core: fix platform name vs. of_node
 assignement
Message-ID: <20181021112301.GC8554@sirena.org.uk>
References: <20181018111829.27056-1-marcel@ziswiler.com>
 <20181018111829.27056-4-marcel@ziswiler.com>
 <e25a7463-9ce0-d7f9-e77b-2bbaab2e0b25@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CblX+4bnyfN0pR09"
Content-Disposition: inline
In-Reply-To: <e25a7463-9ce0-d7f9-e77b-2bbaab2e0b25@nvidia.com>
X-Cookie: Sanitized for your protection.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CblX+4bnyfN0pR09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 19, 2018 at 11:22:46AM +0100, Jon Hunter wrote:

> Looking at snd_soc_init_platform(), it seems that the platform pointer
> can be allocated by the machine driver and so if it is not allocated by
> the core, then I don't think we should clear it here. Seems we need a
> way to determine if this was allocated by the core.

Indeed, this is a bit of a mess.  We probably shouldn't be modifying the
data that the drivers passed in, otherwise we get into trouble like
this.   That suggests that we should copy the data, probably all of it.
I will try to have a proper look at this next week.

> Furthermore, it seems that it is possible that there is more than one
> link that might be to be cleared.

Yes, that's an issue as well.

--CblX+4bnyfN0pR09
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvMYZQACgkQJNaLcl1U
h9Btfwf/dFxAtQI/Mhc7ISVGXuzVPNSrMX9GIpvPLgmAYOMav0sAv/Hwuc5l8yQn
lezhE0TDqs7mjjnBcjSkNlMX+8DRzlr/ROGKmnew4bQUwww+rEex1damDp6JS3b2
fdYqhq42yAVjh09z3ofdX8oa3Y3glbNAp3zR527TajqzSZHOpUOMAFJBxCByDQGH
+8JNd5A7LsccEA29oKULq6OnlsthVbLNEhirU8SE1qaUSadHAZLB8o5IQRmIGnIH
2SmmerTwmMCQE5AHwo0H5HY5M/h6wGYlDNJK2n2mSKohDvN4hKiFBb8lhFb+K15Y
V1l48FNy1pCQpsD7aeTSHFBmh3XhRg==
=q3BQ
-----END PGP SIGNATURE-----

--CblX+4bnyfN0pR09--
