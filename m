Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CC0ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 14:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E3120869
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 14:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mM8TRUQo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E3120869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbeJUW3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 18:29:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:47770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727266AbeJUW3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 18:29:04 -0400
Received: from archlinux (unknown [176.12.107.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4D9320836;
        Sun, 21 Oct 2018 14:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540131273;
        bh=5ozLdjNbogvagVNSIuHHJY/AXlM+49c9BHGEzLc12IU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mM8TRUQo59UY5Mk1v9Awb5kZHN2oemzRmGx8qmmvzFvVU4SKWox6DuZX+JgnfirJK
         0g6g7t+H2YEOrOZHJeJ78tD/MXPiGLAlCPmqL5d6RX2LOe9W9G3jk76w1HmFr2SBvo
         nMFNe0cDRnVJRfs7lzQa5o5JIyYh0z5pAPPFa3yA=
Date:   Sun, 21 Oct 2018 15:14:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Song Qiang <songqiang1304521@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com, preid@electromag.com.au,
        himanshujha199640@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] iio: magnetometer: Add driver support for PNI
 RM3100
Message-ID: <20181021151427.5b3dbb9b@archlinux>
In-Reply-To: <e1715942-8fd8-152f-49c8-2a9e081d8a2a@gmail.com>
References: <20181002143812.3661-1-songqiang1304521@gmail.com>
        <20181012073536.20339-1-songqiang1304521@gmail.com>
        <20181012073536.20339-4-songqiang1304521@gmail.com>
        <20181013111935.00a2e1af@archlinux>
        <e1715942-8fd8-152f-49c8-2a9e081d8a2a@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2018 16:24:15 +0800
Song Qiang <songqiang1304521@gmail.com> wrote:

> On 2018/10/13 =E4=B8=8B=E5=8D=886:19, Jonathan Cameron wrote:
> > On Fri, 12 Oct 2018 15:35:36 +0800
> > Song Qiang<songqiang1304521@gmail.com>  wrote:
> > =20
> >> PNI RM3100 is a high resolution, large signal immunity magnetometer,
> >> composed of 3 single sensors and a processing chip with a MagI2C
> >> interface.
> >>
> >> Following functions are available:
> >>   - Single-shot measurement from
> >>     /sys/bus/iio/devices/iio:deviceX/in_magn_{axis}_raw
> >>   - Triggerd buffer measurement.
> >>   - DRDY pin for data ready trigger.
> >>   - Both i2c and spi interface are supported.
> >>   - Both interrupt and polling measurement is supported, depends on if
> >>     the 'interrupts' in DT is declared.
> >>
> >> Signed-off-by: Song Qiang<songqiang1304521@gmail.com> =20
> > A few questions for you (getting very close to being good to go btw!)
> >
> > Why do we have the 3second additional wait for conversions?  I know we
> > rarely wait that long, but still seems excessive.
> >
> > Few more comments inline.
> >
> > Thanks,
> >
> > Jonathan =20
>=20
> Hi Jonathan,
>=20
>=20
> The measurement time of this device varies from 1.7ms to 13 seconds, 3 se=
conds=20
> is just a number in the middle between them. This may be worth discussing=
,=20
> hoping to get a better solution from the community.

We should 'know' which of those it will be though as I assume it is depende=
nt
on the device configuration which we control.

So waiting for say, double, the expected time should be sufficient to detect
that things have gone horribly wrong.

>=20
>=20
> >> ---
> >>   MAINTAINERS                            |   7 +
> >>   drivers/iio/magnetometer/Kconfig       |  29 ++
> >>   drivers/iio/magnetometer/Makefile      |   4 +
> >>   drivers/iio/magnetometer/rm3100-core.c | 627 +++++++++++++++++++++++=
++
> >>   drivers/iio/magnetometer/rm3100-i2c.c  |  58 +++
> >>   drivers/iio/magnetometer/rm3100-spi.c  |  64 +++
> >>   drivers/iio/magnetometer/rm3100.h      |  17 +
> >>   7 files changed, 806 insertions(+)
> >>   create mode 100644 drivers/iio/magnetometer/rm3100-core.c
> >>   create mode 100644 drivers/iio/magnetometer/rm3100-i2c.c
> >>   create mode 100644 drivers/iio/magnetometer/rm3100-spi.c
> >>   create mode 100644 drivers/iio/magnetometer/rm3100.h
> >> =20
>=20
> ...
>=20
> > =20
> >> +static irqreturn_t rm3100_trigger_handler(int irq, void *p)
> >> +{
> >> +	struct iio_poll_func *pf =3D p;
> >> +	struct iio_dev *indio_dev =3D pf->indio_dev;
> >> +	unsigned long scan_mask =3D *indio_dev->active_scan_mask;
> >> +	unsigned int mask_len =3D indio_dev->masklength;
> >> +	struct rm3100_data *data =3D iio_priv(indio_dev);
> >> +	struct regmap *regmap =3D data->regmap;
> >> +	int ret, i, bit;
> >> +
> >> +	mutex_lock(&data->lock);
> >> +	switch (scan_mask) {
> >> +	case BIT(0) | BIT(1) | BIT(2):
> >> +		ret =3D regmap_bulk_read(regmap, RM3100_REG_MX2, data->buffer, 9);
> >> +		mutex_unlock(&data->lock);
> >> +		if (ret < 0)
> >> +			goto done;
> >> +	break;
> >> +	case BIT(0) | BIT(1):
> >> +		ret =3D regmap_bulk_read(regmap, RM3100_REG_MX2, data->buffer, 6);
> >> +		mutex_unlock(&data->lock);
> >> +		if (ret < 0)
> >> +			goto done;
> >> +	break;
> >> +	case BIT(1) | BIT(2):
> >> +		ret =3D regmap_bulk_read(regmap, RM3100_REG_MY2, data->buffer, 6);
> >> +		mutex_unlock(&data->lock);
> >> +		if (ret < 0)
> >> +			goto done;
> >> +	break; =20
> > What about BIT(0) | BIT(2)?
> >
> > Now you can do it like you have here and on that one corner case let th=
e iio core
> > demux code take care of it, but then you will need to provide available=
_scan_masks
> > so the core knows it needs to handle this case.
> > =20
>=20
> This confused me a little. The available_scan_masks I was using is {BIT(0=
) |=20
> BIT(1) | BIT(2), 0x0}. Apparently in this version of patch I would like i=
t to=20
> handle every circumstances like BIT(0), BIT(0) | BIT(2), BIT(1) | BIT(2),=
 etc.=20
> Since Phil mentioned he would like this to reduce bus usage as much as we=
 can=20
> and I want it, too, I think these three circumstances can be read consecu=
tively=20
> while others can be read one axis at a time. So I plan to let=C2=A0 BIT(0=
) | BIT(2)=20
> fall into the 'default' section, which reads axis one by one.
>=20
> My question is, since this handles every possible combination, do I still=
 need=20
> to list every available scan masks in available_scan_masks?

Ah. I see, I'd missed that the default was picking up that case as well as =
the
single axes.   It would be interesting to sanity check if it is quicker on
a 'typical' platform to do the all axis read for the BIT(0) | BIT(2) case
and drop the middle value (which would be done using available scan_masks)
or to just do two independent reads.

(I would guess it is worth reading the 'dead' axis).

>=20
>=20
> All other problems will be fixed in the next patch.
>=20
> yours,
>=20
> Song Qiang
>=20
>=20
> ...
Thanks,

Jonathan
