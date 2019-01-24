Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C30DC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AF4B218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548355466;
	bh=6QJItVbXWlYTNUkBCqS2Xdyq3evEBPA5lrU5PHsy234=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FBtssCDkkAAYQl7kBpx4R+0UW72thSBH6QEevGyFD2ooFoNEESZ3xJwviIHGL7Czk
	 rQPTRbO/NpuaMVaLa1bXCUZ8dlJQ2aliXAzCHxj0iRMzq+Kt9Fxx5YrKIMXLQCFaVB
	 qmJGhVQekDZf1rudftF/FX5dAbuJfYEbH4IS6DXM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbfAXSoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 13:44:24 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56852 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfAXSoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 13:44:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0+BsLDD8/YOaQq8MqSu0f5Z51J2TJE3PFkt3g7sgQT0=; b=v9fHLfP/rlkaDBq1qWL8npIlx
        +Yo13i3raaOxzFwkx317QpHYTfLzfs3PicYwKmYODoCFueaH/cCUlWIIw31JBEJN13LA6TneNHBOI
        J5za2v/fwjn3X7ghpsHdcNulNFam9xBOgM1U9eNJ7G5sPTxElLCC7t8Qd5a3IWZPZCJ+Q=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gmjz3-0006bM-EY; Thu, 24 Jan 2019 18:44:13 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id E1EBF1121B6F; Thu, 24 Jan 2019 18:44:12 +0000 (GMT)
Date:   Thu, 24 Jan 2019 18:44:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Curtis Malainey <cujomalainey@google.com>,
        rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, vinod.koul@linaro.org,
        linux-kernel@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com,
        lgirdwood@gmail.com,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Matthias Reichl <hias@horus.com>,
        Rohit kumar <rohitkr@codeaurora.org>,
        srinivas.kandagatla@linaro.org, asishb@codeaurora.org,
        Ajit Pandey <ajitp@codeaurora.org>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Dylan Reid <dgreid@google.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: soc-core: Fix null pointer
 dereference in soc_find_component
Message-ID: <20190124184412.GH5641@sirena.org.uk>
References: <20190115000610.GM11073@sirena.org.uk>
 <796a856c-a9a6-022d-da63-947279090198@linux.intel.com>
 <20190115211137.rhdyjadu7fppp3p4@lenny.lan>
 <af2e9555-444f-7c40-865b-347f3db8fa76@linux.intel.com>
 <044d59ba-094e-727d-14a9-6ebfc54cbbf4@linux.intel.com>
 <CAOReqxjhZAzOpr-bGcV6uxPsOEid--Ym2Y0YZMHkybgZSePvtQ@mail.gmail.com>
 <CAOReqxjLcdN6rT9w3_6MJaqE-hpiCsZ+3Luic+e793GwPde+Qg@mail.gmail.com>
 <c6721670-cf89-5d21-953d-c1fa10d87367@linux.intel.com>
 <CAOReqxgG4TJDXKCEVcDVXvpi_mnLUzqLwF7Rp0H5iAPdbMuZ_Q@mail.gmail.com>
 <44029078-2749-5a3b-7b03-f38461bf268f@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Zi0sgQQBxRFxMTsj"
Content-Disposition: inline
In-Reply-To: <44029078-2749-5a3b-7b03-f38461bf268f@linux.intel.com>
X-Cookie: Love America -- or give it back.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Zi0sgQQBxRFxMTsj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 22, 2019 at 08:01:15PM -0600, Pierre-Louis Bossart wrote:

> changes are legitimate. To move forward, maybe it's not worth spending too
> much time on a grand unification of string theory, there are simpler
> solutions: the Intel machine drivers already do get the platform driver name
> as an platform_data argument, so we could modify the dailinks platform names
> before even registering the card. I tested with the attached

Yes, that would be much better - it's vastly more idiomatic.  The
general idea is that a machine driver should know what it's expecting to
find before it starts probing.

--Zi0sgQQBxRFxMTsj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxKB3wACgkQJNaLcl1U
h9DWzAf+NtlimN/EneqIJgAU2m4qsSGsS9Mz520HmFrDdz20VvslFLxGcyQylwnY
dytQj5u6mMW5FjRr1ZtxO/ILOPpuYU23IfhLmNkBdnCcPKNVZwO5YfoBA4tCnLS9
fh4A7gAXXxxPvwv22dQUzoj2O78yRGtNwmPl4r2Fz8cgUqqklLxpG1D/crEg3e0Y
P6ghAMtQh0w72+9Op3rf9Cjhwuj7bXnvS+l4g9B9SkhAvUQX+9KCB3M/+bkSDuf6
m/ke2DVbmvi/w3VB2nscnAYt7XdnlzhG2siJl8Mj1CEIclBUte7s3qneDIPeSHvQ
ojflN99K6KhrRzn6L0mH3ntAPU5h4w==
=MyTR
-----END PGP SIGNATURE-----

--Zi0sgQQBxRFxMTsj--
