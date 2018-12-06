Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF0EC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9D120892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544126193;
	bh=mcvyoth+pT5ZtMtloHOGI12SE+L78Rp4o5EVE0dfgd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A5yOW2pacHCtX5vr4/xTaOKcxYfdbmN7clF6SAb+tFDE/sLNULdibynAAkA5qtE6C
	 o6EOIcKFiZ4+Ib1Fur2Jj9c3yMHgWiODTyJyAq2D9Tr1nJkPq9LAH8E9n9FWyshvUD
	 LSeqfWsi2f6deMBq+/5Q505zhGMaYTIomUqMEvDw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF9D120892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbeLFT4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:56:32 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43394 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbeLFT4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 14:56:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fRNdLXsZ8ImvjXxjKSq7ZQGm2Ix2MfpDK3d0ZBRFAC8=; b=vUyKWCFIkE8ngQryXB3bAyLtj
        0+bYW9ZzfBuuavvQRYgNJ/l6HR6fABtNuYU95485SvhUDBPSze5N0gi4tv3nfd9OTXpI9gZBXGmyq
        O8bsC7WU8R1eTIzj8plMu3DG12XgHEtKMQPY+CVs2zSYuU2pTNJEHPjQifZnW50hq8OrU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gUzky-0001bP-3J; Thu, 06 Dec 2018 19:56:20 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 73B6D11252F7; Thu,  6 Dec 2018 19:56:19 +0000 (GMT)
Date:   Thu, 6 Dec 2018 19:56:19 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Kurtz <djkurtz@chromium.org>
Cc:     Adam.Thomson.Opensource@diasemi.com,
        Akshu Agrawal <Akshu.Agrawal@amd.com>,
        Alexander.Deucher@amd.com, Support.Opensource@diasemi.com,
        Liam Girdwood <lgirdwood@gmail.com>, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: DA7219: Implement error check on reg read and
 write
Message-ID: <20181206195619.GA3084@sirena.org.uk>
References: <1543948103-20752-1-git-send-email-akshu.agrawal@amd.com>
 <1543948103-20752-2-git-send-email-akshu.agrawal@amd.com>
 <AM5PR1001MB099412DDC3B33069BCFDC38B80AF0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <50cffd9e-74f4-b0af-5eed-3dad5f32d8f9@amd.com>
 <AM5PR1001MB0994CDEC9FB92DBCEB83892280A80@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20181205112832.GA6205@sirena.org.uk>
 <CAGS+omCSrt_Fe5=qQc28Dc4GZB-jUH-7kVQ3-Cq6E15tTarxZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <CAGS+omCSrt_Fe5=qQc28Dc4GZB-jUH-7kVQ3-Cq6E15tTarxZQ@mail.gmail.com>
X-Cookie: You will be successful in love.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 05, 2018 at 10:50:29AM -0700, Daniel Kurtz wrote:

> I agree, there is no guarantee here once things have gone wrong, and
> the concerns above are reasonable.  However, in the real world, I2C
> transactions do sometimes fail for various reasons.  The I2C (and

It's *vanishingly* rare and like I say we don't have any constructive
recovery plans - I've never seen a practical system that had any better
idea than hoping the user noticed a problem and reboots.  Probably the
best we can really do is try to reset the device, or at least resync the
register map.  That would probably do something useful in the
vanishingly rare case where it were a singular glitch, at the cost of
obvious and painful user visible issues (which would probably be
happening anyway).  The nearest I've seen to that is one of the CODEC
drivers which has watchdog code to monitor the device in case it
spontaneously reboots and will resync the register cache if that happened.

I'm gathering that there are Chromebooks that do have I/O problems here?

> other bus) APIs have ways of reporting up their errors so callers can
> take appropriate action.  This codec driver can run on all kinds of
> hardware that can experience transient I2C errors, thus it sounds like
> a reasonable idea to have the driver do some error checking on the
> APIs it calls and take whatever action it can.  Just ignoring the
> errors and proceeding like nothing is wrong is one option, but we can
> probably do a little better by at least checking for errors, abort the
> current operation, and pass up errors to higher layers when an i2c
> transaction failure is detected.  If nothing else, this would enable
> higher policy layers to take appropriate corrective action - for
> example, if there is an i2c error when configuring a codec, it seems
> advisable to report this up so that a machine driver would know to
> abort and not turn on downstream amplifiers [I am assuming here that
> something like this would happen, I don't know if the sound stack
> really works this way].

Yeah, so this is partly why I'm not super thrilled here - none of the
layers currently have any especially bright ideas about how to handle
things and giving up part way through an operation and returning an
error without any attempt to unwind or recover feels like it's just
trying to give a false sense of security. =20

> Once the default "check, abort and report" error checking is in place,
> we could perhaps think about actions that the driver could take to
> recover from various failures, such as resetting the device or
> unwinding previous transactions before aborting, or retrying....  but
> those are all policy, and this patch is more mechanism that enables
> policy.

But is this going to be a useful way of handling such policy and is any
work on that from whoever has these unreliable systems likely to be
forthcoming?  We're going to end up with partially done reconfigurations
in the register cache which is a potential issue for recovery strategies
based around resyncing that, it's not so bad on things like starting a
stream but bias level reconfigurations could be fun.

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwJfuIACgkQJNaLcl1U
h9ByIAf9Fs4MIvnokH1GaamyWnCsns/7ZZsboXYWmErv7jwTVyMkFazNGGj5WvHo
PIfTXXHAXmnRgSwrr0NG/fZmSuT5ipEyuVvK5a/6jQChCfa1eqctnzy0ufWyvprh
t/IxAsfywfJvLXEH789+khJkA6OMz2A9F6bhEQPW5bNEgQJxTN3RX6h069dHtbRt
tbKhTEzQfe/LSmD6oyP70yJvunrguFNDOMQ/RjOR2h0oo0YatvvwUY4dNcCPAixd
JqxFlMnC9mYk8J1lR4JWIKsMcQ/R+Q2ecdMNqZfLvtjSVFq23lzCtchI+okeNVOI
QoNmX7cXNuqY5PgijXoh0XO16wuiqQ==
=oW7T
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
