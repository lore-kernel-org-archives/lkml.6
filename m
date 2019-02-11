Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7948AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E38222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897489;
	bh=edelpF7QkheoWOzCJRCMFj9K9/UAIRAS4f0PVlisMG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VFV4yX5ciELLPknvZav9sZLOirlwxv1ygkQV/YLBffJHcsB42o4XnrdeCV0vPig2K
	 g9w4UlxA2gJBr73iSgwK3dxvApQnigpBXvh/8CzvgwyWkPnVEV8zfZHgwc4MpuCxUx
	 Dar0Nau4N8y5vsuleN0v7trbU9ASa/XljUCVQxbY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390868AbfBKPEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:04:48 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53470 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390835AbfBKPEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:04:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hJnXkk1dyaeerODSzrQpR2HhMUEBUJ1FrYn4kp9Gg88=; b=iv1Gy5EDG+JUTMA9YUg56thEm
        S8DS0+YFL4KR36iUnSJiJkgsy8Q4rE09d0ebFaLGcAfDE4qgxp2YZ4CRbTROFUMghRaOth6P0cNHB
        VlLR5AmIA7BoXrLZfeXm+ZlfEiNczvZ6VzSsHdCO9K9wGgxpecH/bgdFs2iBdHa6tx4sk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gtD8E-0003oY-BH; Mon, 11 Feb 2019 15:04:26 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B82CF11280BD; Mon, 11 Feb 2019 15:04:25 +0000 (GMT)
Date:   Mon, 11 Feb 2019 15:04:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Peter Seiderer <ps.report@gmx.net>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, b-ak <anur.bhargav@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org
Subject: Re: [RFC v1] tlv320aic32x4: delay i2c access by 1 ms after hardware
 reset
Message-ID: <20190211150425.GE22391@sirena.org.uk>
References: <20190210154519.2506-1-ps.report@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+JUInw4efm7IfTNU"
Content-Disposition: inline
In-Reply-To: <20190210154519.2506-1-ps.report@gmx.net>
X-Cookie: Tell me what to think!!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+JUInw4efm7IfTNU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 10, 2019 at 04:45:19PM +0100, Peter Seiderer wrote:

> @@ -972,6 +972,8 @@ static int aic32x4_component_probe(struct snd_soc_com=
ponent *component)
>  		gpio_set_value(aic32x4->rstn_gpio, 1);
>  	}
> =20
> +	mdelay(1);
> +

Perhaps only do this if we toggled the GPIO?  If the device wasn't in
reset then there's no need to wait.

--+JUInw4efm7IfTNU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxhjvgACgkQJNaLcl1U
h9BpKAf9G+y8nQsDTzqkvK6vjYpwPnr3Staxy0uTlswZLshRAlNWzqorA+k9ySK0
9rnjMVjD0bG+qQcUUWXKIciQVdx2yaqHYCNROB+EloqA/8ADyivO3DuaTh3OPI8S
95q5gnMJyKnWiJq9kxSqhAtfbDt6/F3ITZYy2XD7N4IXKktVbrPtKU3NZhentogy
w2NS5PwuVERZ2NvvmVZY5gZNShpvfFmX/U1BY8/RCGxscmsK6jYRzlKnkQBUymQr
vbs+MuYM0xnu++cz1mEqXhLLbW4wdTujq93BhQm6/zSgndiJySIyKaWBw1KmF1U0
ICvazgSYUkopGbQVe9Dbwkp9j+g/Zw==
=fgqh
-----END PGP SIGNATURE-----

--+JUInw4efm7IfTNU--
