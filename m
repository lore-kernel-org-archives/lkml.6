Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37941C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 12:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4B52098A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 12:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESD2DSa6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE4B52098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbeJMUVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 16:21:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:57578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbeJMUVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 16:21:34 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 723702087D;
        Sat, 13 Oct 2018 12:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539434673;
        bh=lXYRQgD8ZjR7fH9HqZwEt8Uws+QRb/vDnxbfn+n0C4s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ESD2DSa6X9rvSW3rIsrD+RO9ahnmQVP8/3L/PMs8X906ncjC5BmCOGDe6OyPRGhTH
         41AdwdRXjvNZOnf0xZMuqpySp+6vxT9ffjUhs98GNW59pAeXEx5h7nCkGM8goiL8tW
         utbyLR+lX7aHqBHkYauxN2VII/gFQz6BwhZ1SkgQ=
Date:   Sat, 13 Oct 2018 13:44:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan =?UTF-8?B?QnLDvG5z?= <stefan.bruens@rwth-aachen.de>
Cc:     Colin King <colin.king@canonical.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: ina2xx: fix missing break statement
Message-ID: <20181013134429.1f450ba7@archlinux>
In-Reply-To: <1884341.stJYpOWv9L@pebbles>
References: <20181008210904.9362-1-colin.king@canonical.com>
        <1884341.stJYpOWv9L@pebbles>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2018 12:42:39 +0200
Stefan Br=C3=BCns <stefan.bruens@rwth-aachen.de> wrote:

> On Montag, 8. Oktober 2018 23:09:04 CEST Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >=20
> > The IIO_CHAN_INFO_SCALE case is missing a break statement and in
> > the unlikely event that chan->address is not matched in the nested
> > switch statement then the code falls through to the following
> > IIO_CHAN_INFO_HARDWAREGAIN case.  Fix this by adding the missing
> > break.   While we are fixing this, it's probably a good idea to
> > add in a break statement to the IIO_CHAN_INFO_HARDWAREGAIN case
> > too (this is a moot point).
> >=20
> > Detected by CoverityScan, CID#1462408 ("Missing break in switch") =20
>=20
> Although it is good for code clarity to add a break statement, the code c=
an=20
> never return anything but -EINVAL in case chan->address is not handled in=
=20
> IIO_CHAN_INFO_SCALE:
>=20
> -----
> switch (mask) {
> case IIO_CHAN_INFO_SCALE:
>    switch (chan->address) {
>        case INA2XX_SHUNT_VOLTAGE:
>        ... return IIO_VAL_FRACTIONAL;
>       =20
>        case INA2XX_BUS_VOLTAGE:
>        ... return IIO_VAL_FRACTIONAL;
>=20
>        case INA2XX_CURRENT:
>        ... return IIO_VAL_FRACTIONAL;
>=20
>        case INA2XX_POWER:
>        ... return IIO_VAL_FRACTIONAL;
>    }
>=20
> case IIO_CHAN_INFO_HARDWAREGAIN:
>    switch (chan->address) {
>        case INA2XX_SHUNT_VOLTAGE:
>        ... return IIO_VAL_FRACTIONAL;
>       =20
>        case INA2XX_BUS_VOLTAGE:
>        ... return IIO_VAL_INT;
>    }
> }
> return -EINVAL;
> -----
>=20
> The addresses handled in INFO_HARDWAREGAIN is a subset of the ones in=20
> INFO_SCALE.
>=20
> I would prefer an early "return -EINVAL" here, as it matches better with =
the=20
> other "switch (mask)" cases above.
>=20
> Kind regards,
>=20
> Stefan

I agree with Stefan on this.  It is more in keeping with the local
style to use a direct return.

Colin, would you mind doing a v2 with that approach?

If not I'll get to it at somepoint if no one else does, but it may
take some time!

Please also change the title to make it clear that this is beyond unlikely
as I think it is impossible (without a gross bug somewhere else).
This is worthwhile as an improvement to code clarity and false warning
suppression, but it's not a fix I want to be pushed back to ancient kernels
as in that circumstance it's really just noise.

Jonathan

>=20

