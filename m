Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0FFC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 14:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724DA2064C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 14:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 724DA2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbeJVWdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 18:33:47 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39179 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728375AbeJVWdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 18:33:47 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 766A98078E; Mon, 22 Oct 2018 16:14:58 +0200 (CEST)
Date:   Mon, 22 Oct 2018 16:14:59 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: uinput - fix Spectre v1 vulnerability
Message-ID: <20181022141458.GA29727@amd>
References: <20181016111313.GA28307@embeddedor.com>
 <20181016172107.GA230131@dtor-ws>
 <ead3e95a-1acb-362a-0ee2-d02dbc4f378c@embeddedor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <ead3e95a-1acb-362a-0ee2-d02dbc4f378c@embeddedor.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-10-16 19:52:58, Gustavo A. R. Silva wrote:
> Hi Dmitry,
>=20
> On 10/16/18 7:21 PM, Dmitry Torokhov wrote:
> > Hi Gustavo,
> >=20
> > On Tue, Oct 16, 2018 at 01:13:13PM +0200, Gustavo A. R. Silva wrote:
> >> setup.code can be indirectly controlled by user-space, hence leading to
> >> a potential exploitation of the Spectre variant 1 vulnerability.
> >>
> >> This issue was detected with the help of Smatch:
> >>
> >> drivers/input/misc/uinput.c:512 uinput_abs_setup() warn: potential
> >> spectre issue 'dev->absinfo' [w] (local cap)
> >>
> >> Fix this by sanitizing setup.code before using it to index dev->absinf=
o.
> >=20
> > So we are saying that attacker, by repeatedly calling ioctl(...,
> > UI_ABS_SETUP, ...) will be able to poison branch predictor and discover
> > another program or kernel secrets? But uinput is a privileged interface
> > open to root only, as it allows injecting arbitrary keystrokes into the
> > kernel. And since only root can use uinput, meh?
> >=20
>=20
> Oh I see... in that case this is a false positive.

No, please lets fix it.

Some people are trying to make sure kernel is "more priviledged" than
root -- its called secure boot etc.

And "if you givean attacker possibility to generate keystrokes, he can
read kernel memory as well"... is very unexpected.

Unexpected is bad when talking about security.
								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvN22IACgkQMOfwapXb+vJ1xACgkmaCK/eqBI2FyKOW4ixQxGGK
9sYAoJcEKV2/6EU79TFPSfLv9m06gnaV
=lcj5
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
