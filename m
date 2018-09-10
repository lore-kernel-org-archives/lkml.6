Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5150CC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB4C62087E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="IfyHnYLL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB4C62087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbeIJQcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 12:32:17 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44652 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbeIJQcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 12:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3i8cqO83hprtHSwfrCBgZDmbQdfk4arbckma1HzOpfw=; b=IfyHnYLLEY2VB9gW8Q/whQIRr
        OSdMIp5GKp6yFS6vGCKm4k3SdBiLk4PA/1BBpWvI798NNuC3ZEHaodMUn6ih8vCuowjCqK4IsHQXo
        Fqmu3rzXwYz56FLeFJuqOttAh/MTH0/GMMMkpy0AHA+tSOe/ixYtuKG3W8yfk96atYc4w=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fzKWL-0001w9-86; Mon, 10 Sep 2018 11:38:21 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id F3BF61122D51; Mon, 10 Sep 2018 12:38:20 +0100 (BST)
Date:   Mon, 10 Sep 2018 12:38:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     djkurtz@chromium.org, Alexander.Deucher@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] ASoC: AMD: Fix simultaneous playback and capture on
 different channel
Message-ID: <20180910113820.GD5856@sirena.org.uk>
References: <1536566815-3271-1-git-send-email-akshu.agrawal@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GpGaEY17fSl8rd50"
Content-Disposition: inline
In-Reply-To: <1536566815-3271-1-git-send-email-akshu.agrawal@amd.com>
X-Cookie: Yow!  We're going to a new disco!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GpGaEY17fSl8rd50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 10, 2018 at 01:36:29PM +0530, Akshu Agrawal wrote:
> If capture and playback are started on different channel (I2S/BT)
> there is a possibilty that channel information passed from machine driver
> is overwritten before the configuration is done in dma driver.
> Example:
> 113.597588: cz_max_startup: ---playback sets BT channel
> 113.597694: cz_dmic1_startup: ---capture sets I2S channel
> 113.597979: acp_dma_hw_params: ---configures capture for I2S channel
> 113.598114: acp_dma_hw_params: ---configures playback for I2S channel
>=20
> This is fixed by having lock between startup and prepare. This ensures
> no other codec startup gets called between a codec's startup(where channel
> info is set) and hw_params(where channel info is read).

This isn't viable - the driver will deadlock if the application hits an
error and never gets to startup, or if the application tries to
simultaneously configure two channels (ie, do all the prepares and then
all the parameter configuration and then startup).  The DMA driver needs
to remember the configurations for the different channels separately.

--GpGaEY17fSl8rd50
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluWV6wACgkQJNaLcl1U
h9CujQf/dW83AWCa4lWvkfHryxAKuYFIxv1USSFz30+0uzXDmLTxOt3ZRu4D8gVW
i1Is4Fk5sY2zj0HXU0DH4PPA+NSnpoUg7IHa3aI8hzmkIiKtKP2ZH3Q6EVjZChgS
bf/isOGQ01RJl/QNFZ2u393l9C4ZX5i7EgYQI2PwCdt9DzgbyFGgvYIcs4Ac2eLF
tgeEHq8N0qvl4W3Q2NT6s+fBaxIYqHzNHZIE/jvMgTccM38J7YhK+OvPdjmsnwtW
ukPoZxjEfMYvhA574ApIpwONMmRwsB9YfmAK7vXE0S3nLSTWZC9ftDXOtRG5HwZC
b96+fJx6o07IHeQ1Mwu4lRv5drDXEA==
=sbh/
-----END PGP SIGNATURE-----

--GpGaEY17fSl8rd50--
