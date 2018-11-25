Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE08C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 13:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D0E2086B
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 13:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBG/LZTn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D0E2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbeKZAOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 19:14:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:40778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbeKZAOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 19:14:06 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8C132082E;
        Sun, 25 Nov 2018 13:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543152181;
        bh=/cKKeYl06cI/TnyP2TIask/0nEEx1GiM3Vvx+5DPRY4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oBG/LZTnfCm3l+Cn9GaBD3MONmoEx05Wr5gr/Sj747O2gdWKdEtq1PhDiXuN50kei
         YYdHO+4vB5kzhFIpn9ZbCkZ7Koyyat2LN5CBVwljKzlaKyzlqnpznBaejfpjKo/+el
         VhzfhtiJZCFwb1HDFvevSEyC/AswG0YxH4IHZCrU=
Date:   Sun, 25 Nov 2018 13:22:57 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jian-Hong Pan <jian-hong@endlessm.com>
Cc:     denis.ciocca@st.com, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        linux-iio@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>, linux@endlessm.com
Subject: Re: [PATCH] iio: st_sensors: Fix the sleep time for sampling
Message-ID: <20181125132257.6ae9fe82@archlinux>
In-Reply-To: <CAPpJ_ed-A_mkPJieZA4pHaRbY0SGpOEXP04aY4g1b60PzMGQuA@mail.gmail.com>
References: <20181119061219.14238-1-jian-hong@endlessm.com>
        <04d0345d6c6c4ac0950ab0676ffd7689@SFHDAG2NODE1.st.com>
        <CAPpJ_ed-A_mkPJieZA4pHaRbY0SGpOEXP04aY4g1b60PzMGQuA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018 13:13:40 +0800
Jian-Hong Pan <jian-hong@endlessm.com> wrote:

> Denis CIOCCA <denis.ciocca@st.com> =E6=96=BC 2018=E5=B9=B411=E6=9C=8820=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=883:05=E5=AF=AB=E9=81=93=EF=BC=
=9A
> >
> > Hi Jian,
> >
> > Not clear to me why should be + instead of *.
> >
> > ODR is expressed in Hz, so (1/Hz) =3D period in seconds (1 sample sampl=
ing time) [s]
> > 1000 * (1/Hz) =3D period in milliseconds (1 sample sampling time) [ms]
> > n * 1000 * (1/Hz) =3D n times period in milliseconds (n times sample sa=
mpling time) [ms]
> >
> > In your case you assume bootime is in milliseconds. =20
>=20
> Yes, I assume that according to the original comment.
>=20
> >Maybe we can change the comment and use 'number of samples ...'. =20
>=20
> Making the meaning more clear is better.
>=20
> However, does the bootime of the measurement need as the long time to
> be enabled?
> If the sampling rate is 1Hz and n is 2, then they will do msleep with
> 2000 ms for each st_sensors_read_info_raw.

Superficially that seems correct as we need to be sure that a reading
has occurred.  If you want it to be quicker than the ODR should be set
faster so that the reading shows up reasonably quickly. At 1Hz and
you want to drop 2 samples, it will indeed take 2 seconds.

I'm not understanding why this is unexpected?

Jonathan

>=20
> Regards,
> Jian-Hong Pan
>=20
> >
> >
> > -----Original Message-----
> > From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org>=
 On Behalf Of Jian-Hong Pan
> > Sent: Sunday, November 18, 2018 10:12 PM
> > To: Jonathan Cameron <jic23@kernel.org>; Hartmut Knaack <knaack.h@gmx.d=
e>; Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-Stadler <pmeerw@pm=
eerw.net>; Dominique Martinet <asmadeus@codewreck.org>
> > Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org; linux@endl=
essm.com; Jian-Hong Pan <jian-hong@endlessm.com>
> > Subject: [PATCH] iio: st_sensors: Fix the sleep time for sampling
> >
> > According to the description of st_sensor_settings and st_sensor_data s=
tructures' comments:
> > - bootime: samples to discard when sensor passing from power-down to po=
wer-up.
> > - odr: Output data rate of the sensor [Hz].
> >
> > The sleep time should be
> > sdata->sensor_settings->bootime + 1000 / sdata->odr ms.
> >
> > Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
> > ---
> >  drivers/iio/common/st_sensors/st_sensors_core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/=
iio/common/st_sensors/st_sensors_core.c
> > index 26fbd1bd9413..6b87ea657a92 100644
> > --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> > +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> > @@ -594,7 +594,7 @@ int st_sensors_read_info_raw(struct iio_dev *indio_=
dev,
> >                 if (err < 0)
> >                         goto out;
> >
> > -               msleep((sdata->sensor_settings->bootime * 1000) / sdata=
->odr);
> > +               msleep(sdata->sensor_settings->bootime + 1000 / sdata->=
odr);
> >                 err =3D st_sensors_read_axis_data(indio_dev, ch, val);
> >                 if (err < 0)
> >                         goto out;
> > --
> > 2.11.0
> > =20

