Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A41FC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82CE208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="eVpR3vJy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E82CE208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbeLEUOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 15:14:55 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:52192 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbeLEUOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 15:14:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lipye6iQUwdemJOdf5NCMMGHiDOl2DVHeX6ghVxvvYU=; b=eVpR3vJyBgHAP7TGz2ueJJN/s
        6ZAArIqtj4oyMk/O6R2+BxH5fAC1IeJrBkWEzNCT5vzOMCAzU2j0uK+PCeRVc/5Kt+viygcQF5nRg
        8MTwoKHSQz5RuYctujxmgiyDggmcCIL7chUCVSsYw53WGzLNxfDD2i9b7nV87dnNxrCqQ=;
Received: from p5dcc3ed6.dip0.t-ipconnect.de ([93.204.62.214] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gUdZM-0004RM-Bu; Wed, 05 Dec 2018 21:14:52 +0100
Date:   Wed, 5 Dec 2018 21:14:42 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Johan Hovold <johan@kernel.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH 1/5] gnss: sirf: write data to gnss only when the gnss
 device is open
Message-ID: <20181205211442.63dc33df@aktux>
In-Reply-To: <20181205144739.GE15689@localhost>
References: <20181118215801.12280-1-andreas@kemnade.info>
        <20181118215801.12280-2-andreas@kemnade.info>
        <20181205144739.GE15689@localhost>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/P0wFCYhvudvg=8epL0WOEBR"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/P0wFCYhvudvg=8epL0WOEBR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 5 Dec 2018 15:47:39 +0100
Johan Hovold <johan@kernel.org> wrote:

> On Sun, Nov 18, 2018 at 10:57:57PM +0100, Andreas Kemnade wrote:
> > The api forbids writing data there otherwise. Prepare for the
> > serdev_open()/close() being a part of runtime pm.
> >=20
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> >  drivers/gnss/sirf.c | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-) =20
> =20
> > @@ -73,6 +76,7 @@ static void sirf_close(struct gnss_device *gdev)
> >  	serdev_device_close(serdev);
> > =20
> >  	pm_runtime_put(&serdev->dev);
> > +	data->opened =3D false;
> >  }
> > =20
> >  static int sirf_write_raw(struct gnss_device *gdev, const unsigned cha=
r *buf,
> > @@ -105,7 +109,17 @@ static int sirf_receive_buf(struct serdev_device *=
serdev,
> >  	struct sirf_data *data =3D serdev_device_get_drvdata(serdev);
> >  	struct gnss_device *gdev =3D data->gdev;
> > =20
> > -	return gnss_insert_raw(gdev, buf, count);
> > +	/*
> > +	 * we might come here everytime when runtime is resumed
> > +	 * and data is received. Two cases are possible
> > +	 * 1. device is opened during initialisation
> > +	 * 2. kernel is compiled without runtime pm
> > +	 *    and device is opened all the time
> > +	 */
> > +	if (data->opened)
> > +		return gnss_insert_raw(gdev, buf, count); =20
>=20
> This can race with sirf_close() when you move serdev handling out of
> sirf_open()/close(). Not sure how best to handle that yet.
>=20
Ok, first lets check whether we have a common idea of the problem before
coming to a solution. So race condition here can happen if the serdev
is still opened after the pm_runtime_put in sirf_close() which might
happen if runtime is not suspended after that. I missed that case.
Then if (data->opened)=20
is checked, data->opened set to false
then gnss_insert_raw() is executed.
There is data inserted into the fifo which will be read by the next one
opening the gnss device. And there might be trouble at deregistering
time.

And now if we simply add locks:
For sirf_receive_buf(), it somehow feels dangerous if we call
gnss_insert_raw() with a lock held but I have not analyzed it
thoroughly. For sirf_close(), we could simply
put a lock around data->opened =3D false;
Am I missing something?

I will check if anything changes when I move the serdev_open()/close()
calls a bit. In the end me end to have the serdev open whenever the
userspace wants data or we want to change the state of the gnss chip
without wakeup.
Maybe add a special driver state for that situation where the power
state of the gps chip is changed without having it opened. If we check
that at the beginning of that action, we might have luck.

Regards,
Andreas

--Sig_/P0wFCYhvudvg=8epL0WOEBR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlwIMbIACgkQfb1qx03i
kyQMjg//eHFBUJmOa5AywirLIgeFGZxiqlSaHGADIrkOmdNADeOGKliiNDyLR4Gu
dAtPSU4rhyNlxTgozPZHFUdQrWFwvB2epOGOU5nX11XPBwYUtKALSU31MsKzEE5z
hVHLnf0uyQ8TD/FYZXdv3d0xCGxOhaNGiEZ4eXFMorDonmcTPIcy4A6ljHHrHWBi
IcjpBea/vztz9bur7RG3KOi3kNAyPIsrKcQpbKgF9H0AHowjkj84CADoEIJh0V6C
Gw6oQVAXtj271x7Aq9V3LXDmJVfZmfWMLnz2WtV6Z66zDQECPBNLhDafhu0t1ZCx
XrtshTd/cq2+Mpt8wDQlmCsBuqf4AuYhaWH3XkUnhesHM0/xrHsz2m1Nd//wKjLV
i6Frqj0+VKaScJXofHA+9+KOaW0iEhzKCrV5hLbj+qHkIspuEBwSDrpUQuec6MgZ
HY6M3CQXVbAabthjgDkrBK5slnrqI8OtRqQyfowF/dXn9qaQ3/PCUjJXGQYj8UD8
Kaq/S8Om7FfnNpngKIH9AsA1IGZ25JaXHNRCKvrrTcK4fso27Lb11zeVI/CqyJdw
UvYjTGvC/6bycexV9fW7gaseonPEBOht3QhzbZ+sp54fAGa6hTGEOT/USYZpVnoO
JkugDGsr9SAZH55T6znKZ7d2qDJ4nQ/dxn07eB6b0MZX51iakRU=
=SNfM
-----END PGP SIGNATURE-----

--Sig_/P0wFCYhvudvg=8epL0WOEBR--
