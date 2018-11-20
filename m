Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F00C41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775F321104
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="UHuPsbeG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 775F321104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730208AbeKUCaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:30:03 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40506 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728344AbeKUCaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:30:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JCE0HIN2BE0GZEJgNOy4CSF+2ZQj6Sw5PQn5UDR0ERw=; b=UHuPsbeGErtfju2FVDBJnG2/D
        b6KoaPCJmcaCgmH4edr1uMhQiqzBT+HGp7o0blLGrpgrTuov4kTRCYXK8SEGd6auHaRElG+CPg1Hw
        kRFlzFFMRRVE9NstrRYMZHlBUfEYTRPrrYfwlcoxXKofRFFWv+f6se6Dgaz9RP4WfAK00=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gP8Re-0001kC-Pt; Tue, 20 Nov 2018 16:00:10 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 629FF1124DC2; Tue, 20 Nov 2018 16:00:10 +0000 (GMT)
Date:   Tue, 20 Nov 2018 16:00:10 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, evgreen@chromium.org,
        swboyd@chromium.org, Dmitry Osipenko <digetx@gmail.com>,
        ryandcase@chromium.org, David Collins <collinsd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] regulator: core: Don't assume always_on when
 is_enabled returns err
Message-ID: <20181120160010.GH3894@sirena.org.uk>
References: <20181120002654.1891-1-dianders@chromium.org>
 <20181120002654.1891-2-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VkqCAaSJIySsbD6j"
Content-Disposition: inline
In-Reply-To: <20181120002654.1891-2-dianders@chromium.org>
X-Cookie: fortune: No such file or directory
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VkqCAaSJIySsbD6j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 19, 2018 at 04:26:49PM -0800, Douglas Anderson wrote:

> At boot sometimes regulators (like qcom-rpmh-regulator) will return
> -EINVAL if we don't know the enable state of the regulator.  We
> shouldn't take this to mean that the regulator is an always-on
> regulator, but that was what was happening since "-EINVAL" is non-zero
> and a few places in the code were not properly checking for errors.

This still results in breakage - if the regulator fails to read when
we're initializing then we won't flag the regualtor as always_on, the
regulator would need to tell the framework when it becomes readable.

This hardware really is fragile :(

--VkqCAaSJIySsbD6j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv0L4kACgkQJNaLcl1U
h9DbRgf+L5WDk5UklVGYOblPPgBlRSumLujd5ibYIX1blsVHVHReGbGIlTN8Nde+
48S3/7NA6PH3ARH+OamVq/q98RYfIlF9Jh11qMkd18YT8CmRxD7cws4e2js5R6JT
rnLusouG/mDJZzzDDNnRLcTFId1SzDEU297/ZzGZ6GJnFdi/0nHLvc1JUOijOqmK
fPB7p/UoQvjpF3ms8+9fLiMgf+EYl4cqsFvneUqUKd89YvzWBw9MyH9FDp9MXjH1
+wDkFmfqGTO1Lgjlah9N96cuLqcHZw2A7fOGxhjB45w8+OE/HUmk9qv2IhOpwvcp
EztQjTIn6R+wKJt0baFWj+P2nMLAMA==
=R5N5
-----END PGP SIGNATURE-----

--VkqCAaSJIySsbD6j--
