Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6FFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 163EF2147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="fLemlMFm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfBTQOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:14:48 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.165]:13741 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfBTQOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 11:14:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1550679285;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=F/wzYkPYsYZi3yFrsilA8JH+MmJdEnu6Ii3U/TtiSEI=;
        b=fLemlMFm86AY8Hd9CandDvX9GLFNgiF+3pxmQbQJPFLsh8PTolcl8zf62jTVg9R12G
        Eb/pvh+DatzGpEbr+t/JKaY9cFZXbFbka6SkRmLi8C8+IQ1DjjxYTgqCJBsCLvl/B9JK
        xR2Io//+gR/p/nDfYExjpNMZozcWgT+xYeIYDUpv2pfRwpf+57w3MMy0ILtEswT4W9JW
        zgoHZmzpxlf74YgGc85+n1wXomp9FLep866sK3IIHudz+ZAPWDkNvEOsNY/gKLvx1Z/j
        xijMq90Dku2ioOB37aTGWlM+MUKP7bwvJU8fyJAL8LlVG3SaIJmQvAZBA1qjg5HOId5r
        SH8A==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NMGH/ztwDXG"
X-RZG-CLASS-ID: mo00
Received: from mbp-13-nikolaus.fritz.box
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id 608499v1KGEhFai
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 20 Feb 2019 17:14:43 +0100 (CET)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 3/9] iio: accel: bmc150: add mount matrix support
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20190220160754.GW9224@smile.fi.intel.com>
Date:   Wed, 20 Feb 2019 17:14:43 +0100
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Song Qiang <songqiang1304521@gmail.com>,
        letux-kernel@openphoenux.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C7E571DD-DEC0-43DE-A11C-988C808BF089@goldelico.com>
References: <cover.1550671256.git.hns@goldelico.com> <71ef51037525ae6324bc22e933c00a514d518b31.1550671256.git.hns@goldelico.com> <20190220160754.GW9224@smile.fi.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 20.02.2019 um 17:07 schrieb Andy Shevchenko =
<andriy.shevchenko@linux.intel.com>:
>=20
> On Wed, Feb 20, 2019 at 03:00:50PM +0100, H. Nikolaus Schaller wrote:
>> This patch allows to read a mount-matrix device tree
>> property and report to user-space or in-kernel iio
>> clients.
>=20
>> +static const struct iio_mount_matrix *
>> +bmc150_accel_get_mount_matrix(const struct iio_dev *indio_dev,
>> +				const struct iio_chan_spec *chan)
>> +{
>> +	return &((struct bmc150_accel_data =
*)iio_priv(indio_dev))->orientation;
>=20
> It's hard to read.
>=20
> Can you split such lines in your series to something like
>=20
> struct bmc150_accel_data *data =3D iio_priv(indio_dev);
>=20
> return &data->orientation;
>=20
> ?

I think I did copy it verbatim from some other iio driver:

=
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/d=
rivers/iio/magnetometer/ak8975.c?h=3Dnext-20190220#n745

and checkpatch did not complain.

But yes, it can and should be improved since it seems that
I picked the only bad example as template...

>=20
>> +}
>> +
>> +static const struct iio_chan_spec_ext_info bmc150_accel_ext_info[] =3D=
 {
>> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, =
bmc150_accel_get_mount_matrix),
>> +	{ },
>=20
> Terminator lines better without comma.

Ok.

>=20
>> +};
>=20
> --=20
> With Best Regards,
> Andy Shevchenko
>=20
>=20

