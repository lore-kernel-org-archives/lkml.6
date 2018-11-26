Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB92DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 934A620855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="QV8uEY6e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 934A620855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbeK0FPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 00:15:20 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34606 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbeK0FPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 00:15:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Cu/kVXph88pAUUvv9tZqQ9kmLcyMuvcq1dcgd3ChQLI=; b=QV8uEY6e8qVjh4QaKUBrbvKkR
        CKpj5AUhnFXutkS4do65Urg5edhGnyeVEe70u/f4iKwXdorNGrTxlJ3m/HUD1A3MIhuIfz7thv5kJ
        0LRyvTXGFR2h0rq/AlWuPCZ5Sig8sWQeB0bhz4EX3Lpbmi+Az3EAOVPPGvckAFoHUuxjM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gRLAg-0005Z5-9f; Mon, 26 Nov 2018 17:59:46 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id DA202112519F; Mon, 26 Nov 2018 17:59:45 +0000 (GMT)
Date:   Mon, 26 Nov 2018 17:59:45 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     masneyb@onstation.org, Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Question about "regulator: core: Only count load for enabled
 consumers" in -next
Message-ID: <20181126175945.GL9715@sirena.org.uk>
References: <20181125093750.GA28055@basecamp>
 <CAD=FV=VuPerEgPPiUKk7-Ck9aVz=oR1CAAzg+0wag1WTrTGKxg@mail.gmail.com>
 <20181125232450.GA3774@basecamp>
 <CAD=FV=V4WFYoKLQ72pico4HCGgLDTae7xougivv6VWOSoPhLpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oOpJzULQ70+PGW7h"
Content-Disposition: inline
In-Reply-To: <CAD=FV=V4WFYoKLQ72pico4HCGgLDTae7xougivv6VWOSoPhLpg@mail.gmail.com>
X-Cookie: Gloffing is a state of mine.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oOpJzULQ70+PGW7h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 26, 2018 at 09:43:42AM -0800, Doug Anderson wrote:

> NOTE: another option would be to change the regulator driver to just
> force this rail to a high power mode and never let it change.  That's
> what we're doing on a SDM845-based board.  When the regulator is off
> the mode doesn't matter and as per the above argument we always want
> it in high power mode when it's on.

You should never need to modify the driver for this, the regulator
framework will only change things if it's been given permission to do
so - simply don't specify a regulator-allowed-modes property and the
mode will be left alone (we should probably still use -initial-mode if
it's specified but I'd need to check if we actually do).

> > I see that there are 8 users of regulator-system-load but most are all
> > addressing this same issue with the SD card.
> > qcom-msm8974-sony-xperia-castor.dts sets the load to 500 mA but all of
> > the other msm8974-based SOCs use 200 mA. I'm not sure if this is
> > correct.

> Interestingly enough I think the max load here is specified by the SD
> card specification.  My quick reading of the SD spec shows that you
> could do all sorts of complex negotiation with the card about how much
> load it could take up but Linux didn't actually support that.  If I'm
> reading it right the default is 200 mA.

I'd like to see how closely hardware adheres to the spec too...

--oOpJzULQ70+PGW7h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv8NJEACgkQJNaLcl1U
h9C41wf/eYy5LvY8hdnM7HN65nkdHyMIz9bgfxD0G/uiv35k5jQxEomVAURZy2pZ
QXwEsbjW1s9egx4153hwDwn5V4aXiyDdvhvL8kxoozaWjVBYqUHDmQ/+iTmCVcQ1
B9ZCN/OobV/DRuYCbGmy9gMqc0gsUy+U4f2vq12Hq4zKGid2MdUTprpmJVTQLZDh
GcQwD07GS/Ozxoa69g1STTTzzeWN129vdPR355mO5c8mT4hFmgCzK1A0tds4DlQ8
74eOsmSdENTeviBbUTSheJu4HtyzxM1ARhnysRuV3xBbSIp7t5DVIN+ql7g5pEcr
hekFJuDhvc+SEXkxT6vHh37JZIodUw==
=8KyR
-----END PGP SIGNATURE-----

--oOpJzULQ70+PGW7h--
