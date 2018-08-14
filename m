Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7F1C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628112172C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="bTLcR9GK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 628112172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732813AbeHNR1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 13:27:40 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38802 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728458AbeHNR1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 13:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=x60Wh2jZgzSxPBxY0QS/GeNVRf/5TWuFNyLZBUU4CSU=; b=bTLcR9GKrenX/0MgVBJQCE4tt
        TnUIwfIG75wRsp6FXXfcnLcGPYjFmSXK1WzkOLQZG/95sRux9iZX3zCFG7akCyLh78M8sxwJ5ljIj
        sDLDuxeiMwvMwjtUEckdHEFRIuEGZn8B9NZlNREuoRTM8SJhiVgpyGLByZRja13OZ9DBE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fpaUP-0000tJ-8c; Tue, 14 Aug 2018 14:40:05 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C75331124449; Tue, 14 Aug 2018 15:40:04 +0100 (BST)
Date:   Tue, 14 Aug 2018 15:40:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [RFC PATCH] ASoC: core: Optimise suspend/resume of DAPM widgets
Message-ID: <20180814144004.GD5810@sirena.org.uk>
References: <1533301025-19980-1-git-send-email-jonathanh@nvidia.com>
 <20180803163605.GD6591@sirena.org.uk>
 <7ba86328-5bb6-5280-df6f-9937173fb2ab@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="osDK9TLjxFScVI/L"
Content-Disposition: inline
In-Reply-To: <7ba86328-5bb6-5280-df6f-9937173fb2ab@nvidia.com>
X-Cookie: All true wisdom is found on T-shirts.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--osDK9TLjxFScVI/L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 13, 2018 at 07:19:16PM +0100, Jon Hunter wrote:
>=20
> I had taken some ftrace graphs but there was not one thing that really
> stood out. Looking again it seems that each call to
> async_schedule_domain() can take tens of uS and so it there are a lot of
> DAPM widgets (100+) this can take some time. I will dig into it a bit
> further.

We don't call that per widget, we call that per context.  We might have
a lot of contexts but it's definitely not number of widgets level.
Perhaps what we need there is something which remembers if we actually
changed anything in each context and/or there's relevant operations and
then doesn't do this if not, we're working on the basis that these
operations are fairly cheap.

> > One thing that it occurs to me might help is to start the suspend
> > process by powering down all the input and output widgets that aren't
> > ignoring suspend in one operation, that should hopefully have the effect
> > of ensuring that most of the system that's going to get powered down
> > does so on the first pass through.

> If the async_schedule_domain() calls are the problem, then it may not
> help as we call that for all dapms apart from the card->dapm.

No, we actually need to run the operations on all contexts - they can
all do things if they want to.  We just want them all to run in parallel
so if we are doing things like waiting for capacitors to charge we don't
do it in series.

--osDK9TLjxFScVI/L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlty6cQACgkQJNaLcl1U
h9Cu4ggAhNYHM3NFIKtqdn0xYhoxvkssFh3GROehNT3p06HwwvCytbNXsyT7VelC
4Tmf1pktMnBs+Lg+jOIFTY/rGqPr/+xk4DYbNwUDd3B3+jSnrTWixh+GTdXmPiuB
SRzgOZznTocV3E6Fmz+DIVJ9QKfaIWZQjZfCS8eqG1Qmru4BPXxjrvRqprXG3SDJ
6NxbQGQCW9Nc3szoVXPuXbUV1FlQPFfApa4cABsl/1qAPFq3NEJLky+GUbM0N6X7
ajW7CmOBAs4MfuDjN7/sB2qmj5blfC/Bp1rEb77CzjaptLNJLzY0XQj1o4+T5O7u
Cnk0bQZUQlukZCuQmrNnVwd1+pT0mA==
=ANgL
-----END PGP SIGNATURE-----

--osDK9TLjxFScVI/L--
