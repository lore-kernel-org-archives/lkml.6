Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962F3C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C8CE206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="VmH43G5T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C8CE206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeIDTXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:23:10 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51628 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbeIDTXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yA4G1Me3dvheH5NVlris+pTKd//C3q///b5JpjXKFNg=; b=VmH43G5TmUu+tq7iOLxKFZUhJ
        ICx1VQ5K8Qj1rLSXyoriOwvpCGfEnubVNO6zPh+x5M+4kX9k8N1KygwKd+uWe+2FTt6eSWge4s/UY
        1Pw8gxg4EueVvSxXB0G9LPx3U7VV/ebpbcZRrwvg+r/NznTKRYjUtyvgTqjwDnE2zVIgY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fxClw-0001RM-Nh; Tue, 04 Sep 2018 14:57:40 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 6CD7911227D8; Tue,  4 Sep 2018 15:57:40 +0100 (BST)
Date:   Tue, 4 Sep 2018 15:57:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: tlv320aic31xx: Remove regulator notification
 handling
Message-ID: <20180904145740.GE12993@sirena.org.uk>
References: <20180831181737.29516-1-afd@ti.com>
 <20180903113038.GG10302@sirena.org.uk>
 <b35860d4-70ec-a23f-41d4-7edc87869ccb@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0H629O+sVkh21xTi"
Content-Disposition: inline
In-Reply-To: <b35860d4-70ec-a23f-41d4-7edc87869ccb@ti.com>
X-Cookie: Times approximate.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0H629O+sVkh21xTi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 04, 2018 at 09:50:50AM -0500, Andrew F. Davis wrote:
> On 09/03/2018 06:30 AM, Mark Brown wrote:
> > On Fri, Aug 31, 2018 at 01:17:37PM -0500, Andrew F. Davis wrote:
> >> The notification handler sets the reset line but never re-enables it
> >> as no one is listening for an enable event, this is certainly broken
> >> and was most likely just copied from other CODECs, remove this code.

> > Why not fix it?  The usual pattern would be to take the CODEC out of
> > reset when bringing the bias back to standby.

> The only time this code gets called outside of the normal power on/off
> path is regulator_force_disable(). And the enable event is only called
> inside regulator_enable() which would already be part of the normal
> power up path.

It's there to save us having to rewrite the register cache if we asked
for the device to be powered down but that didn't actually happen due to
other constraints, we know all the registers are still as we left them.

--0H629O+sVkh21xTi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluOnWMACgkQJNaLcl1U
h9CJvAf/bjkIWA0GP2khzx/2gN/0oXMbKFzuMWCbIC8CtijpKjUAROWtKKFYYsGb
5b12ecQ2UNcViwxYImfHsZYsV2yewBPOHZoysbSCBv1KytI4BqJwz4+dBNiuKQuu
znw1/8n5bu9PP2oa2xx7BCjKpIJs9LFkQUBlnLDf8IkKMhAJvvIOUUemtXz1TeyL
EP3F1vSCw3gqNxiDJx9ZuZyeYHcToFTm49VBCaiei3W6DZrWbLH53yVHJQv8Jd7G
/PU0jubJ6/1+gnzJzhfrRQN0GMaV6K7iPuYu/iSctvgpGb/BK79uUiy/DdkZnTot
iKQstDW6IVcD6J1PwycZwn4QE55Jnw==
=Cu00
-----END PGP SIGNATURE-----

--0H629O+sVkh21xTi--
