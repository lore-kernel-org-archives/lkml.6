Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2E5C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 16:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2721921777
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 16:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="NuJVVopK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2721921777
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbeHCSdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 14:33:19 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53498 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeHCSdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 14:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=o1Jfb5eHXLJ3+uCDpgxnWge0hrNcYJQeXvomouYMFNg=; b=NuJVVopKUuhu+qHsPDNUgvqk/
        P/7/rCpvulkw/JHFkht7vilJgYUc4LgIDUOXHEfv6O5/odxfs+wAq3JLM8sNrW1ILlxR6Xyq/rMdM
        SbYhvFI8Dr3cKGsG70fA8UmOCD0yYk38UzO18o7Za/QMkKX67Q61a8JkHHpnEJiq3XTCc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fld3e-0003kV-7r; Fri, 03 Aug 2018 16:36:06 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 8764D1123AA1; Fri,  3 Aug 2018 17:36:05 +0100 (BST)
Date:   Fri, 3 Aug 2018 17:36:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [RFC PATCH] ASoC: core: Optimise suspend/resume of DAPM widgets
Message-ID: <20180803163605.GD6591@sirena.org.uk>
References: <1533301025-19980-1-git-send-email-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NtwzykIc2mflq5ck"
Content-Disposition: inline
In-Reply-To: <1533301025-19980-1-git-send-email-jonathanh@nvidia.com>
X-Cookie: I invented skydiving in 1989!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NtwzykIc2mflq5ck
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 03, 2018 at 01:57:05PM +0100, Jon Hunter wrote:

> For soundcards that have several DAI links and many DAPM widgets the
> time taken for snd_soc_suspend to execute has been observed to be
> several milliseconds. The time is largely spent executing
> dapm_power_widgets() for each for the DAI links that need to be
> suspended. Given that dapm_power_widgets() is called again after
> suspending/resuming the DAI links, one way to optimise the
> suspend/resume time is to avoid calling dapm_power_widgets() for
> each DAI link and reduces the suspend time significantly.

It's a bit alarming that dapm_power_widgets() is taking substantial
enough time to be worth worring about - it's *supposed* to be relatively
well optimized so it's effectively free.  It'll never be quite free, but
close enough.  The goal is that if nothing changes we end up testing a
few nodes at most before we figure out that nothing changed state and
stop.  Do you have any idea what it's spending its time on, we do call
it a lot so if there's any optimization opportunties there we can
probably get a lot of benefit out of them.

One thing that it occurs to me might help is to start the suspend
process by powering down all the input and output widgets that aren't
ignoring suspend in one operation, that should hopefully have the effect
of ensuring that most of the system that's going to get powered down
does so on the first pass through.

> Please note that this has been observed on the Tegra210 Jetson TX1
> platform which is not currently supported in the mainline for audio
> but has been tested with out-of-tree patches to enable I2S audio.

If someone could get the platform booting reliably in -next that'd be
good but that's a separate issue...

> In the resume path, it is not clear if there could be any issues from
> not sync'ing the DAPM power state until after unmuting and resuming
> the CPU DAI drivers, because this will happen later with this change.

This is a definite problem, we want to have the audio path powered up
before we start playing audio otherwise we loose the start of the audio
which may be important.

--NtwzykIc2mflq5ck
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltkhHQACgkQJNaLcl1U
h9Abfwf9GL/ApQBu4ehC5vT48/dXm5e3eSnbqPF2RPN4ANgZE/sd4zN9ViCH+aZB
a+rO8heoonUwWDAzER847bozpaTlc+FlpozSvHHtGHIKy5IasJaaZGCwcSXchADq
j7dz5WYe6PClb/jRRWIlCYeUXIkVZjq8A/xpZodE8qkCQl2QWYew8Zxy37XVGcZr
kQoiDhdo+lkfWrDjjxq2YAxWESfLzbt0yovMkMhzoEU+gFJM1TwBkF+4pCLUjb6I
SngihcQxjjxfdgsO+5jzt3eHEqHa0j6XNihW7U+h/j9N35rY0SMc99Z+xXL1mbrz
esbscJh0DWpoaCT0MPRo5L1XAO5Jmg==
=0Q2R
-----END PGP SIGNATURE-----

--NtwzykIc2mflq5ck--
