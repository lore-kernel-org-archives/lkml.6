Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490AAECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 14:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7F620869
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 14:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJ8xNIoX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E7F620869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbeJUW7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 18:59:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:55518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727336AbeJUW7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 18:59:41 -0400
Received: from archlinux (unknown [176.12.107.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FC0A20843;
        Sun, 21 Oct 2018 14:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540133107;
        bh=wCPmjW45C40ynB3ElYcJOiEpa2D31RFOS1vTqgMR0Q4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RJ8xNIoXd5xlJS8Z3Y9i7r5+SsmOrJsuPfZIws/hShIdAdt7SlNfvdUN1cg/tecVs
         nL6esfzunUgYbLlDWMrLlan9sNw7jgfTemgYt7seCC415b6pPcwPtLJnV4x1nRwfkt
         Bdrpt2UMQBayDdvIguxZj+YeMUhQ9BSSDliTyK5s=
Date:   Sun, 21 Oct 2018 15:45:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan =?UTF-8?B?QnLDvG5z?= <stefan.bruens@rwth-aachen.de>
Cc:     Colin King <colin.king@canonical.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][V2] iio: adc: ina2xx: add in early -EINVAL returns in
 case statements
Message-ID: <20181021154503.5141163f@archlinux>
In-Reply-To: <3078823.PklSZE2rHu@pebbles>
References: <20181016161418.29213-1-colin.king@canonical.com>
        <3078823.PklSZE2rHu@pebbles>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2018 20:26:57 +0200
Stefan Br=C3=BCns <stefan.bruens@rwth-aachen.de> wrote:

> On Dienstag, 16. Oktober 2018 18:14:18 CEST Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >=20
> > Static analysis with CoverityScan is throwing warnings that specific
> > case statements are missing breaks.  Rather than adding breaks, add
> > return -EINVAL to the specific case statements to clarify the
> > error return paths. Fix also saves 50 bytes.
> >=20
> > Before:
> >    text	   data	    bss	    dec	    hex	filename
> >   21418	   4936	    128	  26482	   6772	drivers/iio/adc/ina2xx-adc.o
> >=20
> > After:
> >   dec	    hex	filename
> >   21370	   4936	    128	  26434	   6742	drivers/iio/adc/ina2xx-adc.o
> >=20
> > (gcc 8.2, x86-64)
> >=20
> > Detected by CoverityScan, CID#1462408 ("Missing break in switch")
> >=20
> > ---
> >=20
> > V2: use returns instead of break statements to keep with the
> > current style used in the switch statement.
> >=20
> > Signed-off-by: Colin Ian King <colin.king@canonical.com> =20
>=20
> Reviewed-by: Stefan Br=C3=BCns <stefan.bruens@rwth-aachen.de>

Thanks, and applied to the togreg branch of iio.git and pushed
out as testing for the autobuilders to play with it.

Note however that I was confused when there appeared to be no sign off
in the patch from Colin after applying.  It ended up below an
additional cut line so git am dropped it.

All fixed up now.

Thanks,

Jonathan

>=20
> > ---
> >  drivers/iio/adc/ina2xx-adc.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> > index d1239624187d..bdd7cba6f6b0 100644
> > --- a/drivers/iio/adc/ina2xx-adc.c
> > +++ b/drivers/iio/adc/ina2xx-adc.c
> > @@ -250,6 +250,7 @@ static int ina2xx_read_raw(struct iio_dev *indio_de=
v,
> >  			*val2 =3D chip->shunt_resistor_uohm;
> >  			return IIO_VAL_FRACTIONAL;
> >  		}
> > +		return -EINVAL;
> >=20
> >  	case IIO_CHAN_INFO_HARDWAREGAIN:
> >  		switch (chan->address) {
> > @@ -262,6 +263,7 @@ static int ina2xx_read_raw(struct iio_dev *indio_de=
v,
> >  			*val =3D chip->range_vbus =3D=3D 32 ? 1 : 2;
> >  			return IIO_VAL_INT;
> >  		}
> > +		return -EINVAL;
> >  	}
> >=20
> >  	return -EINVAL; =20
>=20
>=20

