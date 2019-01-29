Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AE7C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D397121871
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548782330;
	bh=aHcUSrfNQOiE45arHspE14mKaGaiYpAOhDSpRRREifg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mAMjgprOoPDc+Yl6uCL8/Ig2pHdxkWIDK22vOvGuZjCe9+bErFQZ/ZLnGvuBPFZnU
	 nwgrOB7QfSmkKTDZ9usS5fT/q5urXXRi0QTwmyeRPf5RTdWDNVwSbuAWFJaxzqC+UC
	 AfF4XJc9gRBfRO/hfnuhYt90QcpaFg/RDecPpdTA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbfA2RSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:18:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:35242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbfA2RSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:18:48 -0500
Received: from earth.universe (dyndsl-091-248-209-252.ewe-ip-backbone.de [91.248.209.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AACE72087E;
        Tue, 29 Jan 2019 17:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548782327;
        bh=aHcUSrfNQOiE45arHspE14mKaGaiYpAOhDSpRRREifg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zl49vcoq27xt712Ww+Il5anGsgEtFqy1+6hvWMACwlCuAaijh/sLElIY4Et5riSGR
         e4NqfZ8L1UYhUcI9mD5Vs6UGE9caKqQn0mxoCAOoFolrafZhBoj52wUizqPjtuHKLO
         mWMmyBo3XC4oan9+mVILGeNys2mZ93sxPgFfJPuA=
Received: by earth.universe (Postfix, from userid 1000)
        id ECCEA3C08DE; Tue, 29 Jan 2019 18:18:44 +0100 (CET)
Date:   Tue, 29 Jan 2019 18:18:44 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: New underflow of regulator enable count warnings in v5.0-rc1
Message-ID: <20190129171844.n6wflw4ehfdy3izs@earth.universe>
References: <20190129164813.GA5720@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nxdsms3oudxktwtr"
Content-Disposition: inline
In-Reply-To: <20190129164813.GA5720@atomide.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nxdsms3oudxktwtr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 29, 2019 at 08:48:13AM -0800, Tony Lindgren wrote:
> Looks like commit 5451781dadf8 ("regulator: core: Only count load for
> enabled consumers") started showing new warnings with v5.0-rc cycle:
>=20
> regulator-dummy: Underflow of regulator enable count
>=20
> I'm seeing this at least with my pwm-vibra test case:
>=20
> # rumble-test /dev/input/by-path/platform-vibrator-event 0xffff
> pwm-vibrator vibrator: vibrator supply vcc not found, using dummy regulat=
or
> input: pwm-vibrator as /devices/platform/vibrator/input/input4
> regulator-dummy: Underflow of regulator enable count
> Upload rumble effect... id=3D0
> regulator-dummy: Underflow of regulator enable count
>=20
> Are these bogus warnings for dummy regulator or do we have
> real unpaired regulator calls or somewhere?

There are real unpaired regulator calls in the pwm-vibrator driver,
that I did not notice when I wrote the driver :(. Good news is, that
Pawe=C5=82 Chmiel and Jonathan Bakker are already working on fixing my mess:

https://lore.kernel.org/patchwork/patch/1032759/

On Droid 4 it's a dummy regulator, since I did not know what
regulator is being used to supply the vibrator. Probably directly
=66rom the battery.

-- Sebastian

--nxdsms3oudxktwtr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlxQivIACgkQ2O7X88g7
+prOCw/+OTUVuiiDL1E9MnpFholjz2hyATTT2hLR5GIbulVgaypDSmK9lj/D+3Lh
m6XSToHBxskFyx4ZEbxmijxtF15l7wIzBzhDUzoFjzkAiAiSFoRVzfxG638lGULs
2X+ZOVpKv2fURtknjO2OUA7XavVl/XQLY5Ry3gCHYQm3W0V8gC/6fEtNBOvE4/nw
SJ3Y3cIzZ7OktP5sVp7bfXuPuHmc5XqnBR4GUMtjkds4fdRonyPW8rEPQkMxkIT6
kAGxT2v8bElbCb4DWz4CD+eYbX286ino5gjcOIOeJd0lVjaDZzT3vKy+Q9oTyhhr
OY2KRiuYxTJbz8qCAgK+DCnAIy/ev1t6wJRdH5SGfqHk6/Sp5WWi7fOLkzCclolp
qWOD0fG7fKVD5/PCwi7HjHuCa5A6QSJkB3eBu4YIayQF2x5miBDlIpmu3pISWaxc
3LX5pUDxrUW3qbM33uVTMPO++tm3ZxauYTkJSZTMnogYOeNtthh/9AkuTkJpPBhn
Rnve1dkHLNZrKA/3JtJWj6JVVP6Sy3j/2NXkeX2xnreYYYqcN19OQMchD19ogPVn
3rdvfuoOMDpB4RjoN87D7bIgbsBVWJJIvLtvtvdy09u0qn6ztgpq0SX7f4Z01tg2
rEjKoeBi54HCEr38Ti6uxAPh3rl83BmgWJ4qDVnd0tMhBUOCNiQ=
=l1E0
-----END PGP SIGNATURE-----

--nxdsms3oudxktwtr--
