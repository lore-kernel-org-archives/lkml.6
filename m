Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8BFC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A3AD21B18
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549905839;
	bh=39jttpbGpX55E2F7AHZhg+5THDFbiNREVysQAZd+ftE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FdTJrlGmB/dt66gPTXEJTLQQnzWIytGYnj0tuJBKM9WfE+fq3/ALWwcHGqo15KiVk
	 SuXK2bvzdkzgIf81AWVXSm5Ox0HBYOXi82WM3+JAde3RZq2LS9Np2TGPzD/5Gxm1cL
	 jx8sxGkQymjDrVvhSVTAY3Pu5+EbGDB+tmXoNSbI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbfBKRX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:23:57 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33278 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfBKRX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:23:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=39jttpbGpX55E2F7AHZhg+5THDFbiNREVysQAZd+ftE=; b=R0b4TValXqp7595lEgrt09l6u
        g6zSUoRLNkGp4olk4XvejNLdsy3/c4EE41/iqOjz44VE4m2uTMuJTxLBB5s3UMQpgaooiV0vOOUst
        jlx1sxhrkctS4ptpOQX7uivHlkdMXgk4rLprvfq5lvnZFP9QT7RqQnC0zCCsgubGortpM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gtFIy-0005ML-Us; Mon, 11 Feb 2019 17:23:40 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5D74D11280BD; Mon, 11 Feb 2019 17:23:40 +0000 (GMT)
Date:   Mon, 11 Feb 2019 17:23:40 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     SCSI <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Joao Pinto <jpinto@synopsys.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Stanislav Nijnikov <stanislav.nijnikov@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>,
        Ohad Sharabi <ohad.sharabi@wdc.com>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Yaniv Gardi <ygardi@codeaurora.org>,
        Gilad Broner <gbroner@codeaurora.org>,
        Raviv Shvili <rshvili@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>, Kyuho Choi <kyuho.choi@sk.com>,
        Martin Petersen <martin.petersen@oracle.com>
Subject: Re: [PATCH v5 1/2] scsi: ufs: Do not disable vccq in UFSHC driver
Message-ID: <20190211172340.GG22391@sirena.org.uk>
References: <494cd639-89a7-8868-b63a-ea7cdcba9777@free.fr>
 <be3ef9bf-438b-4e8a-62c4-f75458e8ecc0@free.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Cp3Cp8fzgozWLBWL"
Content-Disposition: inline
In-Reply-To: <be3ef9bf-438b-4e8a-62c4-f75458e8ecc0@free.fr>
X-Cookie: Tell me what to think!!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Cp3Cp8fzgozWLBWL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 11, 2019 at 02:32:15PM +0100, Marc Gonzalez wrote:

> Unfortunately, this optimization breaks UFS on systems where vccq
> powers not only the Flash chip, but the host controller as well,
> such as APQ8098 MEDIABOX or MTP8998:

...

> In my opinion, the rationale for the original patch is questionable.
> If neither the UFSHC, nor the Flash chip, require any load from vccq,
> then that power rail should simply not be specified at all in the DT.

If the supply is physically connected it should be valid to represent
this in DT regardless of how or if the supply gets used at runtime.
However it does sound like this support needs to be better thought
through to make sure we have represented the supplies to the flash chip
and the controller separately - it seems like right now there's no
tracking of the supplies needed for the controller and the assumption is
that only the flash chip needs managing which is breaking things.

--Cp3Cp8fzgozWLBWL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxhr5sACgkQJNaLcl1U
h9DznAf+PetfOWZBsXUecbqnEpq3HNh++HyGkM2V6YeTI2IexM+xHc7igRo1ouCC
fuKl0fPPAY8LEN0UPRMKNN/BDasMYDIq5N5LbMLC/an/eVXql6PKz9zLYNyf823p
UwY6H779Ah947Qb2BZNKLNmO5wbp9gvq1DyRFvSAz62mMe7aWAx+B9xLyULe23MV
6+iR9ud/p5qIrHRat/4ey0S2z6ENntgOtGMvSE7t4Ks/nrgpmsl/Tj+V+rXBf9eX
W5DXlbC7OqFbynBEx+Zco/9S2VpNyIrpA6JLcRX/d/kk5owY36MIArTaKCf//Fjz
mzG6c4B1j3+gWSPmwgj9F0Nqj1Q2Lw==
=Eslj
-----END PGP SIGNATURE-----

--Cp3Cp8fzgozWLBWL--
