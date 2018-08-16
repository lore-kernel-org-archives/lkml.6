Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7617CC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 10:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FED021470
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 10:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="ogXoMJxR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FED021470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388231AbeHPNta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 09:49:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56106 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387896AbeHPNta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 09:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Pr6KVZSCbL7Du4YeoGE2b6PCMpl6DCqiDOKt3gzpIPA=; b=ogXoMJxROwk0Ev1p18MbFjmdm
        iinjgHAjQhOuP0dvBTcYXwC/7Ck7ppeNOnu2dzanwsqRdz3+fAYKbVdWM0AZ6wGLGV62n+UQpVQRK
        QqolSwoowp384FmzEfc9iY09m/eValIVkt0oqjWkjHIJeOHJsDwqKKy6Dw2o9CZRYCdSE=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fqFsP-0002gY-24; Thu, 16 Aug 2018 10:51:37 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id E84D6440078; Thu, 16 Aug 2018 11:51:35 +0100 (BST)
Date:   Thu, 16 Aug 2018 11:51:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [RFC PATCH] ASoC: core: Optimise suspend/resume of DAPM widgets
Message-ID: <20180816105135.GZ2414@sirena.org.uk>
References: <1533301025-19980-1-git-send-email-jonathanh@nvidia.com>
 <20180803163605.GD6591@sirena.org.uk>
 <7ba86328-5bb6-5280-df6f-9937173fb2ab@nvidia.com>
 <20180814144004.GD5810@sirena.org.uk>
 <e1bc40ec-de7e-2b77-d7f6-ec6b3066aeec@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0786ZyFfTSxuegBe"
Content-Disposition: inline
In-Reply-To: <e1bc40ec-de7e-2b77-d7f6-ec6b3066aeec@nvidia.com>
X-Cookie: Many are called, few volunteer.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0786ZyFfTSxuegBe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 15, 2018 at 07:48:47PM +0100, Jon Hunter wrote:

> So then I made the following change to avoid scheduling the function
> calls unnecessarily (which I think should be fine) ...

> Please note that I am just using ktime_get() to log the time on entry
> and exit from dapm_power_widgets() and so yes the time may not be
> purely the time take to execute this function if we are preempted,
> but I am measuring in the same way in both cases and so it does seem
> to show some improvement.

That seems like a simple and useful optimization, will you send a patch?

--0786ZyFfTSxuegBe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlt1VzQACgkQJNaLcl1U
h9C++wf/QB19v9pWanJUtK3uJI3vVk9Y6HQxYhrr0b9X6aZ9IPlhxWlBssaSEY0O
1zygbrumfW9K8OLLANmo8Xb0oMb8YcXwG5UO2aIieuIwxvQo+hwUUI9QwH020JB7
+3bRvRumioLOfR+NeZTg7M5oGuuGK34o0j/pyCT0Ej3v2YKZUlai0ynwxGkfbuav
RiPia8eACF76DkDRBcWMQYy45+kZIXdkBOJvZcnzWGUfhlNEugWo92oYQxSshySV
TsUG1H3HGN1/JvAogds/wVAOXSA8dt8fc1KddCdPEtaCPAoGa8NooKZDlrJFHn1L
FQhmW9eQB1nzC8venmJohqs7SiPvNA==
=OMjY
-----END PGP SIGNATURE-----

--0786ZyFfTSxuegBe--
