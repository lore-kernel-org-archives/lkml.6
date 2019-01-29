Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E13C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 912482184D
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548785157;
	bh=HYU0VpPkTwAVt0GjuWhhtdSHEStCm7KcfkROMzsXPvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=clS7bKpAPpMkSUWBbecUWylzn4MWQ2zCLGUISL2yabN/L2+NORjf8Y/GYgtpU9Wy7
	 ms6yw+rHG9rM7Pc6fTvA/lp2yLbiPkgI8ug0kdln6nUCbg/0wVXNBaV5Lul+Kc/vE7
	 VntrC1R2zcf6SV7ENmP+KVd+40G2xyzzlHPYshlI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbfA2SF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:05:56 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48938 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfA2SFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:05:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HYU0VpPkTwAVt0GjuWhhtdSHEStCm7KcfkROMzsXPvI=; b=wFy4lPDDkAVtaIMPiO3BIVmCv
        PhtBOslTjdMImWD8yj7dVkceyc7lyGFpVBJyPMuXHaWd8mdyk0mayz/oNEFg9Oqxw8uMq9k/YSCHu
        +JBXRnQb4EVX0gZhRa2JtocxtEV8XesVfojrUY6KVLk0sfaYp24ihnbvwmclZR2C5mves=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1goXlc-0000vy-7T; Tue, 29 Jan 2019 18:05:48 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 949081127D50; Tue, 29 Jan 2019 18:05:47 +0000 (GMT)
Date:   Tue, 29 Jan 2019 18:05:47 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Axel Lin <axel.lin@ingics.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: lochnagar: Fix n_voltages setting for VDDCORE
Message-ID: <20190129180547.GI10524@sirena.org.uk>
References: <20190129030156.2024-1-axel.lin@ingics.com>
 <20190129095438.GJ3837@imbe.wolfsonmicro.main>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="svExV93C05KqedWb"
Content-Disposition: inline
In-Reply-To: <20190129095438.GJ3837@imbe.wolfsonmicro.main>
X-Cookie: What foods these morsels be!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--svExV93C05KqedWb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 29, 2019 at 09:54:38AM +0000, Charles Keepax wrote:

> Hmm... I think this might need a little more investigation, it
> does indeed fail at present (amazing that it works upto exactly 1.2V
> which is common the usecase) but this feels more like a core
> problem. There are indeed only 57 valid voltage settings as the
> range is 0x8 - 0x41, but it seems that presently the core treats
> this less as n_voltages and more like max_selector. Should we
> perhaps be teaching the core to understand the min_selector
> instead?

We've not had a need for this before but that seems like a reasonable
addition.

--svExV93C05KqedWb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxQlfoACgkQJNaLcl1U
h9CWCwf/ZxzfLoEjq12l4scqJJJmpfhVqlHEDdjHea26783vz7S0ktdWmF0FMQ+x
tRo+YaqxCs4jk/lufyvubY3jPaurP7388NSTZg7bpcZGO9MncO9UcGYq2FgjSlkS
VkKSl4qFZ9rtZbSX+Mqav7+QPpTJak+6wLbN3x0MRgMmoemOfJOZl2PjBtmqpXF9
ikRcZaBKu2u+6P2RfTE83VUrNjgLW5BbYhWnzypmu09rNLIfbnwu22mV1jp1n1oW
FfVFyCtp/pJHsOVOvNJymhi7fIbVSk2gxVo76Y8oJO+N8EG26urGLgEpZiHeWJ4Q
LU9tlH8DlbkVpi7Dii7duNa5ocjLbw==
=SbyI
-----END PGP SIGNATURE-----

--svExV93C05KqedWb--
