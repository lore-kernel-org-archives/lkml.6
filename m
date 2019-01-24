Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C1DC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 826E2218FC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358039;
	bh=9VuRLE/rYgyaSZ3x2nYSLr7TYCNRgRyAFuSPu8HOgr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C+Z/g6M8tyDHhXjt2HJnBed/dZIr8iomOQTsVexCEyso4u25OGhkwxO/Ocd7Y3nyC
	 d9U0vNT66mdO/ilCdFl4gecY3vQt2Qss3eJDR2kT679643r1HyoR6zp9a/JD8FxgRW
	 1U9LsxDeQlEbEF5MTN2+oXYTU9CZF5cY1VauH6FQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730743AbfAXT1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:27:18 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44126 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730723AbfAXT1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:27:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9VuRLE/rYgyaSZ3x2nYSLr7TYCNRgRyAFuSPu8HOgr0=; b=GFo3feS/VjuRVCt9AFh8lExI6
        9cTuNQHOJo19Az7GdyMLJMA1RrxvwM8+rG3vYlXu6WLivW79GAvMBAi0nlX4i58ICEwTy4pA+hvfT
        NWSySgPLYp1rAIFzT5Zp5tdslJrHvuKnGziSGo6r2s6RK4Xe+yozPuJ+u+wFPOOiGE1CI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gmkeK-0006l1-PZ; Thu, 24 Jan 2019 19:26:52 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5B5731121B6F; Thu, 24 Jan 2019 19:26:52 +0000 (GMT)
Date:   Thu, 24 Jan 2019 19:26:52 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, vinod.koul@linaro.org,
        lgirdwood@gmail.com, Curtis Malainey <cujomalainey@google.com>,
        plai@codeaurora.org, linux-kernel@vger.kernel.org,
        Ajit Pandey <ajitp@codeaurora.org>, tiwai@suse.com,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Matthias Reichl <hias@horus.com>,
        Rohit kumar <rohitkr@codeaurora.org>, asishb@codeaurora.org,
        srinivas.kandagatla@linaro.org,
        Curtis Malainey <cujomalainey@chromium.org>,
        Dylan Reid <dgreid@google.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: soc-core: Fix null pointer
 dereference in soc_find_component
Message-ID: <20190124192652.GK5641@sirena.org.uk>
References: <20190115211137.rhdyjadu7fppp3p4@lenny.lan>
 <af2e9555-444f-7c40-865b-347f3db8fa76@linux.intel.com>
 <044d59ba-094e-727d-14a9-6ebfc54cbbf4@linux.intel.com>
 <CAOReqxjhZAzOpr-bGcV6uxPsOEid--Ym2Y0YZMHkybgZSePvtQ@mail.gmail.com>
 <CAOReqxjLcdN6rT9w3_6MJaqE-hpiCsZ+3Luic+e793GwPde+Qg@mail.gmail.com>
 <c6721670-cf89-5d21-953d-c1fa10d87367@linux.intel.com>
 <CAOReqxgG4TJDXKCEVcDVXvpi_mnLUzqLwF7Rp0H5iAPdbMuZ_Q@mail.gmail.com>
 <44029078-2749-5a3b-7b03-f38461bf268f@linux.intel.com>
 <20190124184412.GH5641@sirena.org.uk>
 <976ec85a-7b21-6c58-90cc-a3d104f9505a@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GBuTPvBEOL0MYPgd"
Content-Disposition: inline
In-Reply-To: <976ec85a-7b21-6c58-90cc-a3d104f9505a@linux.intel.com>
X-Cookie: Love America -- or give it back.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GBuTPvBEOL0MYPgd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 24, 2019 at 01:07:17PM -0600, Pierre-Louis Bossart wrote:

> Thanks for the feedback, will send a formal patch with the helper and
> machine driver changes after I test more with the legacy drivers. Do you
> have a preference for one patch that deals with multiple machines drivers in
> one shot, or individual patches? The latter are nicer for backports (e.g.
> for Chrome), the former nicer for maintainers...

More patches is good, it doesn't make a huge difference if I get one big
patch or a series of repetitive patches - big serieses are more of an
issue if they're all different patches needing individual review.

--GBuTPvBEOL0MYPgd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxKEXsACgkQJNaLcl1U
h9CrfQf/TSuAQrVpDDveUkj5OeoR6tRyUeCAIhi4RM9+BZ8fprgWPxiunRRqnpAe
vloJEfPPN0XMdFa1j25HnHn90yYETGwdbE/y/iGozfk6XF1g1lMxCaAfR2cVqssV
nx+/im9LCh3w5nvq2GBnjaMLG87aBLv8ODnQGNDD5rGElTXKxkueajgJi4xo2VFf
25JBaw1KU8m/eLJdfDb4WGZ4o0ZEdO7p15AqSQ6Y9kvB3rlo+8UAFjHxqyIfIBMy
J9URK3nojNdRlRY6T1vpqHqzvgl4+H460mCxAOviYDsnLlUSM80mmvHrFfBsXolt
zWVfUkU18RAHavnsxQe1elLZSTjebw==
=C+CS
-----END PGP SIGNATURE-----

--GBuTPvBEOL0MYPgd--
