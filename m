Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8496C31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD12B21726
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548095468;
	bh=oc6tFj0cTcSXtpaQF6GJTU6VeqQj6UUGji9ezfTrrN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TWZnTBvWiPwZStGzFBrfV4xIPkdmXZSKVlwcPvMfVX+LQaFZpQ1Gv57KdORcmaK2v
	 L9ZOI0hni9um948sBrAHNRESHhdC3Y/Ly12200tpxEGmVaKZqRhh6va6QCY20MYIfF
	 ASKySrZSp43XmtTQoJBuHIkzW/8cFoi2HrhPV1yg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbfAUSbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 13:31:06 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38838 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfAUSbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 13:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oc6tFj0cTcSXtpaQF6GJTU6VeqQj6UUGji9ezfTrrN4=; b=Hs6Xe2jPANCOyfaatPPEB2nEg
        4EeCrNjq+rbz9YOkWkXR9jtUjutTslayS+8aPNRy53uUaol6mBgyYvHHSbmOgNydosFmDNrXbeDcO
        Rcb3OCmlopLVy44U3joYuZEp1+Zd+NP9q8aR3NDqxGeA+fQLJvQ+x+MK+w7C/sdcb1frI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gleLX-0004wH-4U; Mon, 21 Jan 2019 18:30:55 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 7E8601127D00; Mon, 21 Jan 2019 18:30:54 +0000 (GMT)
Date:   Mon, 21 Jan 2019 18:30:54 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Curtis Malainey <cujomalainey@google.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Matthias Reichl <hias@horus.com>, rohkumar@qti.qualcomm.com,
        alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
        vinod.koul@linaro.org, lgirdwood@gmail.com, plai@codeaurora.org,
        linux-kernel@vger.kernel.org, tiwai@suse.com,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        srinivas.kandagatla@linaro.org,
        Rohit kumar <rohitkr@codeaurora.org>, asishb@codeaurora.org,
        Ajit Pandey <ajitp@codeaurora.org>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Dylan Reid <dgreid@google.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: soc-core: Fix null pointer
 dereference in soc_find_component
Message-ID: <20190121183054.GF12679@sirena.org.uk>
References: <1547194442-1487-1-git-send-email-rohitkr@codeaurora.org>
 <d8726e9a-3477-a573-8c1a-dd8245068802@linux.intel.com>
 <4886ed21-65d2-159d-afcd-bb26dcde636e@linux.intel.com>
 <20190115000610.GM11073@sirena.org.uk>
 <796a856c-a9a6-022d-da63-947279090198@linux.intel.com>
 <20190115211137.rhdyjadu7fppp3p4@lenny.lan>
 <af2e9555-444f-7c40-865b-347f3db8fa76@linux.intel.com>
 <044d59ba-094e-727d-14a9-6ebfc54cbbf4@linux.intel.com>
 <CAOReqxjhZAzOpr-bGcV6uxPsOEid--Ym2Y0YZMHkybgZSePvtQ@mail.gmail.com>
 <CAOReqxjLcdN6rT9w3_6MJaqE-hpiCsZ+3Luic+e793GwPde+Qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2FkSFaIQeDFoAt0B"
Content-Disposition: inline
In-Reply-To: <CAOReqxjLcdN6rT9w3_6MJaqE-hpiCsZ+3Luic+e793GwPde+Qg@mail.gmail.com>
X-Cookie: Body by Nautilus, Brain by Mattel.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2FkSFaIQeDFoAt0B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 18, 2019 at 05:15:32PM -0800, Curtis Malainey wrote:

> of_node was never getting set but the pointer was becoming populated
> (outside of the probe call) which traced to soc_init_platform function
> which was not reallocating memory on a EPROBE_DEFER even though it was
> getting freed by devm. I am not very familiar with devm but my local
> maintainers say that it should be freeing the memory even on a
> PROBE_DEFER.

Probe deferral is just like any other error from probe, any managed
resources will be unwound.

--2FkSFaIQeDFoAt0B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxGD90ACgkQJNaLcl1U
h9CQEQgAgXbxteN3z6JWdvRNOR7LQ1qLbzwzKj6Q5fr9jXKIZaQLPq+1djnb/KFr
v4sITiJopyN0eDbQlmQUis5b0wT1jmOzpNsZfr5te78rYSLZmbd7Icf5/TmIhfMf
6zW4+BLvdFAzTC1ZZoqoX9XvEGfPZVgIS1tJNBQTyx4r4+L76FRis9aWKYnU3FqT
3JvCmZUNg8lhwH5uKN2FOhU1AcTRKFJl5v7YqyzXHOAe6bVRDi/yZYxcETeasUxM
EccYffjtpjxHl3cflJHgT8ZCpYvkNl4Ieg6Gs6In9+quP/FUM9dk4wubsS0gzVeK
yz5IV2nrxgQUkecgJoxR2iESaMBHyw==
=thEi
-----END PGP SIGNATURE-----

--2FkSFaIQeDFoAt0B--
