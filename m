Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5334C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 10:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED6420833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 10:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkAnZeUJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED6420833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbeKCTwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 15:52:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:54072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbeKCTwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 15:52:31 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AC3D2081D;
        Sat,  3 Nov 2018 10:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541241697;
        bh=P7E6Dc/eePIyvlG4HxDXhx6nn+Hj8NDVR/IzlrWoxD8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nkAnZeUJrC+53pTsmWrYauvEfpYaDH1OWznJmK0bWmMPVdNHdBoWGyWBY4fny5CV3
         xdBt+qr6I4732EaGXwlimtJhqB6vlOWBVv1cCfZvwS05YOP/oBUmjbi9nJGMZVGR2L
         Ouz/7enYTnDnQwDCiIAJHgNyrNUMSiE1R2HJbAPc=
Date:   Sat, 3 Nov 2018 10:41:32 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v2 1/6] staging:iio:ad2s90: Make read_raw return
 spi_read's error code
Message-ID: <20181103104132.7140c9ed@archlinux>
In-Reply-To: <707d385e-7c08-91a3-2925-0cadf5bc2ac4@usp.br>
References: <20181027020005.3140-1-matheus.bernardino@usp.br>
        <20181027020005.3140-2-matheus.bernardino@usp.br>
        <20181028164038.0c920358@archlinux>
        <707d385e-7c08-91a3-2925-0cadf5bc2ac4@usp.br>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Nov 2018 10:49:59 -0300
Matheus Tavares <matheus.bernardino@usp.br> wrote:

> On 10/28/18 1:40 PM, Jonathan Cameron wrote:
> > On Fri, 26 Oct 2018 23:00:00 -0300
> > Matheus Tavares <matheus.bernardino@usp.br> wrote:
> > =20
> >> Previously, when spi_read returned an error code inside ad2s90_read_ra=
w,
> >> the code was ignored and IIO_VAL_INT was returned. This patch makes the
> >> function return the error code returned by spi_read when it fails.
> >>
> >> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br> =20
> > Hi Matheus,
> >
> > One quick process note is that it takes people a while to get around to=
 reviewing
> > a series, so whilst it's tempting to very quickly send out a fix the mo=
ment
> > someone points out something that needs fixing, it is perhaps better to=
 wait
> > at least a few days to see if you can pick up a few more reviews before=
 you
> > do a V2.
> >
> > A few comments on this one inline.  I think it can be done 'slightly'
> > (and I mean only slightly) nicer than the version you have.  Result is =
the
> > same though.
> >
> > Thanks,
> >
> > Jonathan
> > =20
> >> ---
> >>   drivers/staging/iio/resolver/ad2s90.c | 9 ++++++---
> >>   1 file changed, 6 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/i=
io/resolver/ad2s90.c
> >> index 59586947a936..11fac9f90148 100644
> >> --- a/drivers/staging/iio/resolver/ad2s90.c
> >> +++ b/drivers/staging/iio/resolver/ad2s90.c
> >> @@ -35,12 +35,15 @@ static int ad2s90_read_raw(struct iio_dev *indio_d=
ev,
> >>   	struct ad2s90_state *st =3D iio_priv(indio_dev);
> >>  =20
> >>   	mutex_lock(&st->lock);
> >> + =20
> > Unconnected change.  I'm not against the change in principle but please
> > group white space tidying up in it's own patch.
> > =20
> >>   	ret =3D spi_read(st->sdev, st->rx, 2);
> >> -	if (ret)
> >> -		goto error_ret;
> >> +	if (ret < 0) {
> >> +		mutex_unlock(&st->lock);
> >> +		return ret; =20
> > I'd actually prefer to keep the return path the same as before as then
> > it is easy (if the function gets more complex in future) to be sure
> > that all paths unlock the mutex. =20
>=20
>=20
> Ok, got it! But then, in patch 5, when we add the switch for=20
> IIO_CHAN_INFO_SCALE and IIO_CHAN_INFO_RAW, should I keep the goto and=20
> label inside the switch case? I mean, should it be something like this:
>=20
>=20
>  =C2=A0=C2=A0=C2=A0 switch (m) {
>  =C2=A0=C2=A0=C2=A0 case IIO_CHAN_INFO_SCALE:
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ... // Does not use mutex
>  =C2=A0=C2=A0=C2=A0 case IIO_CHAN_INFO_RAW:
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 mutex_lock(&st->lock);
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ret =3D spi_read(st->sdev, st->rx,=
 2);
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (ret)
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 goto error_ret;
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 *val =3D (((u16)(st->rx[0])) << 4)=
 | ((st->rx[1] & 0xF0) >> 4);
>=20
> error_ret:
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 mutex_unlock(&st->lock);
>=20
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return ret ? ret : IIO_VAL_INT;
>  =C2=A0=C2=A0=C2=A0 default:
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 break;
>  =C2=A0=C2=A0=C2=A0 }
This is was of those ugly signs that perhaps a given block of code
should be factored out as a separate function.  It does feel like
overkill here though given how short the ugly bit will be ;)

So now I get why you did the refactor in the first place (I
hadn't made the connection).

I think on balance your first answer was the best one given
this is going to be deeper nested.  If the function gets
more complex then this block should factored out anyway once the switch
statement is there then we go back to the simple exit path.

Thanks,

Jonathan
>=20
>=20
> Matheus
>=20
>=20
> >> +	}
> >> +
> >>   	*val =3D (((u16)(st->rx[0])) << 4) | ((st->rx[1] & 0xF0) >> 4);
> >>  =20
> >> -error_ret:
> >>   	mutex_unlock(&st->lock);
> >>  =20
> >>   	return IIO_VAL_INT; =20
> > The 'standard' if slightly nasty way of doing this is:
> >
> > 	return ret ? ret : IIO_VAL_INT;
> > =20

