Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54D7C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48EFD22C9B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48EFD22C9B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owl.eu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934285AbeFVCDz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 22:03:55 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:43795 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934184AbeFVCDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 22:03:54 -0400
X-Originating-IP: 70.80.172.8
Received: from localhost (modemcable008.172-80-70.mc.videotron.ca [70.80.172.8])
        (Authenticated sender: hle@owl.eu.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 82BFAC0002;
        Fri, 22 Jun 2018 02:03:53 +0000 (UTC)
Date:   Thu, 21 Jun 2018 22:03:45 -0400
From:   Hugo Lefeuvre <hle@owl.eu.com>
To:     Marcus Wolf <marcus.wolf@smarthome-wolf.de>
Cc:     Valentin Vidic <Valentin.Vidic@CARNet.hr>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: rf69_set_deviation in rf69.c (pi433 driver)
Message-ID: <20180622020345.GA1914@hle-laptop.local>
References: <20180605031120.GB1981@hle-laptop.local>
 <50c4e6ee-e5fb-1d27-4e73-1e82080036b3@smarthome-wolf.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <50c4e6ee-e5fb-1d27-4e73-1e82080036b3@smarthome-wolf.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marcus,

> > According to the datasheet[0], the deviation should always be smaller
> > than 300kHz, and the following equation should be respected:
> >=20
> >   (1) FDA + BRF/2 =3D< 500 kHz
> >=20
> > Why did you choose 500kHz as max for FDA, instead of 300kHz ? It looks =
like
> > a bug to me.
>=20
> My focus was always on OOK and ASK. PSK was only used for a few
> measurements in the laboratory, I engaged to check CE compliance.
> Most probably 500kHz was a value, that's common for PSK and I didn't pay
> any attention to the datasheet. So I think, you are right: This is a bug
> and could be revised.
> Never the less: While using it in the lab, the transmission was fine and
> the signals over air have been clean and fitted to the recommondations
> of the CE.
> >=20
> > Concerning the TODO, I can see two solutions currently:
> >=20
> > 1. Introduce a new rf69_get_bit_rate function which reads REG_BITRATE_M=
SB
> >    and REG_BITRATE_LSB and returns reconstructed BRF.
> >    We could use this function in rf69_set_deviation to retrieve the BRF.
> >=20
> > + clean
> > + intuitive
> > - heavy / slow
>=20
> Why not: I like clean and intuitive implementations. Since it's used
> during configuration, we shouldn't be that squeezed in time, that we
> need to hurry.
> >=20
> > 2. Store BRF somewhere in rf69.c, initialize it with the default value
> >    (4.8 kb/s) and update it when rf69_set_bit_rate is called.
> >=20
> > + easy
> > - dirty, doesn't fit well with the design of rf69.c (do not store
> >   anything, simply expose API)
>=20
> Up to my experience, storing reg values is always a bit problematic,
> since the value may be outdated. And if you update the value every time
> you want to use it to be sure, it's correct, there is no win in having
> the copy of the reg value.
> So this wouldn't be my favourite.
> >=20
> > I'd really prefer going for the first one, but I wanted to have your op=
inion
> > on this.
>=20
> Agree.

I'll prepare a patch addressing both issues. However I don't own test devic=
es
so it would be really great if you could test it !

I'm currently thinking of adapting this driver for other HopeRf modules like
RFM69HCW or RFM12 so I will probably try to find some test equipement in the
future.

Thanks for your answer !

Regards,
 Hugo

--=20
             Hugo Lefeuvre (hle)    |    www.owl.eu.com
4096/ 9C4F C8BF A4B0 8FC5 48EB 56B8 1962 765B B9A8 BACA

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEE5LpPtQuYJzvmooL3LVy48vb3khkFAlssWN8ACgkQLVy48vb3
khk+4wf/dxQ7iek1tuNRV9EgLvngsFySzxiqc7jDgyID2B0eNKMS/63B9U2RJHPY
hDNT3CCK6m28luL9nyPTT9gLvGYJ+9c2pOINaEq5VfmVn1EzaWut0uqaVO+UySdK
jubtPgflwyjT48n16T8hQrzdmDkj4xsIPEF5Wjh6CdYB44he4y1JOIg4UOjkhjtD
/DPC4YUJfxkwYaVJQoXMbgH9+DBw7z5W4svGESukB70PAA/9YGCfBgeTx1OV9O3e
YeqdmWWbntqfSTZnP12C8VtbPbq1O65TvNvz7UKCU6AubIvipwIdA9Foqgh/59ow
OR+xXxpOJpHzQueEX5zptm2mtcaXnA==
=9VOC
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
