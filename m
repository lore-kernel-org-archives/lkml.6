Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AB8C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C3A217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548188767;
	bh=i9+uLvcmmvlFNkSQWBQC2VjdMUkoWknsSOqfmhOzrR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tmuQ+5oMEkMulNssGPqaeO4M9nMQM1nbwCapRDcwVxzp7bf3Zm/YVZo3F71RY7vtb
	 IxsPCOGxu6Hy40CTFCut0Fh5C5DIo5ej5t56pRGtKZKaH55OTlSvXtJXaWOw0BLkfy
	 5jt1Oy9qVyl27o3VbyVSyi8NRhh2PWGqBkTrcfI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfAVU0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 15:26:06 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51344 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfAVU0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 15:26:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ELWjOGU/W78hrlVNoDMF8p48A5w4hVSHYCPvuN4v6S0=; b=lgdK+M1Of4Vajtx/jOT8iavYj
        Efz+4BzyDiJ8mJlQheyz9zQ5mMWa60F/9kuOe2U2plpKgeAqbETVx39ishUIkpWDxPLok5LOY5rIc
        TrtkqUHxH4HjJM0cPPlOIMzJCfM8md9fvRZR/hIDKDjfPhWG/xe9FXg1oac6h9V+WLPb0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gm2c3-0007CE-S0; Tue, 22 Jan 2019 20:25:35 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 3E98A1127955; Tue, 22 Jan 2019 20:25:35 +0000 (GMT)
Date:   Tue, 22 Jan 2019 20:25:35 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
        arnd@arndb.de, keescook@chromium.org, bgoswami@codeaurora.org,
        sr@denx.de, gustavo@embeddedor.com, philburk@google.com,
        willy@infradead.org, mchehab+samsung@kernel.org, sboyd@kernel.org,
        vkoul@kernel.org, Baolin Wang <baolin.wang@linaro.org>,
        daniel.thompson@linaro.org, leo.yan@linaro.org,
        mathieu.poirier@linaro.org, srinivas.kandagatla@linaro.org,
        anna-maria@linutronix.de, corbet@lwn.net, jmiller@neverware.com,
        ckeepax@opensource.wolfsonmicro.com, joe@perches.com,
        o-takashi@sakamocchi.jp, colyli@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ALSA: core: Add DMA share buffer support
Message-ID: <20190122202535.GK7579@sirena.org.uk>
References: <290f6d3a5fe288b87480cc5fa12c5139728daeca.1547787189.git.baolin.wang@linaro.org>
 <81e894ba-acad-2fd4-996d-8d35edd8825a@perex.cz>
 <20190118190805.GF6260@sirena.org.uk>
 <s5hzhrxzrez.wl-tiwai@suse.de>
 <20190121124053.GA12679@sirena.org.uk>
 <f278bb69-7df0-4d14-5e4f-9bcb57d7f2b6@perex.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="huG+SbfbdD6eblZQ"
Content-Disposition: inline
In-Reply-To: <f278bb69-7df0-4d14-5e4f-9bcb57d7f2b6@perex.cz>
X-Cookie: Truckers welcome.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--huG+SbfbdD6eblZQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 21, 2019 at 03:15:43PM +0100, Jaroslav Kysela wrote:
> Dne 21.1.2019 v 13:40 Mark Brown napsal(a):

> > It was the bit about adding more extended permission control that I was
> > worried about there, not the initial O_APPEND bit.  Indeed the O_APPEND
> > bit sounds like it might also work from the base buffer sharing point of
> > view, I have to confess I'd not heard of that feature before (it didn't
> > come up in the discussion when Eric raised this in Prague).

> With permissions, I meant to make possible to restrict the file
> descriptor operations (ioctls) for the depending task (like access to
> the DMA buffer, synchronize it for the non-coherent platforms and maybe
> read/write the actual position, delay etc.). It should be relatively
> easy to implement using the snd_pcm_file structure.

Right, that's what I understood you to mean.  If you want to have a
policy saying "it's OK to export a PCM file descriptor if it's only got
permissions X and Y" the security module is going to need to know about
the mechanism for setting those permissions.  With dma_buf that's all a
bit easier as there's less new stuff, though I've no real idea how much
of a big deal that actually is.

> Even with the full operation mode, it's difficult imagine what the
> depending task can break with the sound interface except probably annoy
> users with some cracks for the playback or start/stop the streaming rapidly.

In some embedded systems the ability to play back notifications clearly
can be very important to system functionality.  Obviously at times the
main purpose of the system is to play or record audio.

I don't have a *super* strong opinion here but I'm not really a security
person.

--huG+SbfbdD6eblZQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxHfD4ACgkQJNaLcl1U
h9Bi/gf/RX3fSAWWGh9peNObRd7J19zaw9F/D2+LAK882ygexXi+46clqp5voXp0
9ayUdE4ZGQEkJ7OMO9HFdBZLvWWwVdcovK9EPrWDKhEUzjZbmU71ZSrIqYm4eEyV
NHmJGrsWUMulWJsxsYmtAf+AF9uEke0/nWHSZlu7v26FIlihpZKx99IrBq3D5egh
6934PlTzIc7gzt2HFMRbeX7Wi8dQ+YyffoZ73kxjYENud7WbyC6tqWaWsihlApl7
T3mOL3UQx8DRCDwsR1zGbv2ECnjniTvuBPIFmuNB89jWWivjnQ7qdyasFR5i7Vw7
k7LxSzKlzpjvgPcFZSMwoFnXdPRN5Q==
=D6GE
-----END PGP SIGNATURE-----

--huG+SbfbdD6eblZQ--
