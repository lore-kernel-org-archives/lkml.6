Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D3BC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A71132064C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547058974;
	bh=OEjnu19knIiWM5eQCnWpE6IClH7Gwn31Wk8WRTfuFmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m58FUoh6wYV8LtdEtSGdWxVsdD1/+M+94PpuFDctX9/Lk2EhlkbWDkHnJNxiqQ0r3
	 7PliHmwHEGZ31r1btL+ihGKCWzAoWcNUIBKmMBKtiMj2KPoBEDcMakIVF/8DU/v26F
	 i/nF/YRfF7X9qWxoYi07/JY1F6ZnC1vRWGC3jDQg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfAISgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:36:13 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39548 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbfAISgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:36:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=swwKGjlxsCKsDjfNvxqulMIv2gw8hesi3Ugj4h66wwY=; b=cutrSAxW4NeRuyLooMiefSOm1
        eMj3m7pNeUv9BRUNshBlG3nfw1lTzULJoASN5NODq4X6ad906D2U4GozLYZw/dwxR+LQSzDPBt41C
        ks8zOrtUhFWv6JCPqIGkgnODs0wF/vuZOCYrRJeqnEtRO1YzVnHNyyjKFth5SNUza/4K0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ghIhy-0000jZ-7N; Wed, 09 Jan 2019 18:36:06 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id A33391127528; Wed,  9 Jan 2019 18:36:05 +0000 (GMT)
Date:   Wed, 9 Jan 2019 18:36:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, Marcel Ziswiler <marcel@ziswiler.com>,
        Matthias Reichl <hias@horus.com>
Subject: Re: [PATCH] ASoC: core: Fix deferral of machine drivers
Message-ID: <20190109183605.GH10405@sirena.org.uk>
References: <1546968494-22993-1-git-send-email-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="svZFHVx8/dhPCe52"
Content-Disposition: inline
In-Reply-To: <1546968494-22993-1-git-send-email-jonathanh@nvidia.com>
X-Cookie: VMS version 2.0 ==>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--svZFHVx8/dhPCe52
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 08, 2019 at 05:28:14PM +0000, Jon Hunter wrote:

> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> @@ -925,7 +925,7 @@ struct snd_soc_dai_link {
>  	 */
>  	const char *platform_name;
>  	struct device_node *platform_of_node;
> -	struct snd_soc_dai_link_component *platform;
> +	struct snd_soc_dai_link_component platform;
> =20
>  	int id;	/* optional ID for machine driver link identification */
> =20

This breaks the build for the SCU cards (and we needs a little rebase
against another fix I just merged, though I did do that when applying).
I do think that this is going to be the safest thing to do for v5.0, it
can always be reverted later on when it's not needed but it seems clear
that a better fix is going to be way too invasive for the -rcs.  Can you
respin and retest please?

--svZFHVx8/dhPCe52
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw2PxQACgkQJNaLcl1U
h9DsVQf7Bl7vEBMABSqiIzvDhDkyN+XK0TSjJ3FL2od/a+726iim+xXCPWWPX3lH
gJpGNqEdpUOoOHmF/vdJG+mXCgDZIWQNcno7WS2NXKxZTuR7nGq7jlEVPhCMB7uz
03p1MsAS9cgejzohTErsCKcgcGpdRvaJe+WyNwu4uQK5vaOFoS8e9VnP+RiLo3gQ
aQR0Gqxw4C3CwZZt7abSfwB/Y20gJ8xFreTAJOqAoqMQV4R4KOU0Wqmou2pYzLGW
D4CRr53m1xD1F4E2v+i/XvpHJ+FGRYkv287tj05kdaCgRQzsCMuYuZUw1wymXq/t
BszRVWAPqyfTHsJk+jTrcHlYroKyJQ==
=oZNb
-----END PGP SIGNATURE-----

--svZFHVx8/dhPCe52--
