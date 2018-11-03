Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C34C6786F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF7D520847
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ybK8yqLK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF7D520847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbeKDCiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 22:38:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726849AbeKDCiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 22:38:05 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4ED0A204FD;
        Sat,  3 Nov 2018 17:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541265971;
        bh=kuc9C/0qV+PN3bkwh9XQAJgZvMzmN2Dg4arNG8URwL8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ybK8yqLKFMaXhTUqRusLO/LN8Sto4f1IQrWFAGBJEECHxb1fH5XtMQ8xBJ3GlR2dE
         i00YeEMyS1Oows1QPKFP7RJzw0RAn0z9V/iQYXs6Ovh3u/sI9VTAmZAc5eXi37L0zH
         A4wb3Qk9ELDS4jR6D12nquuD2+kWJhDJ2Cqg0iwY=
Date:   Sat, 3 Nov 2018 17:26:06 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        Victor Colombo <victorcolombo@gmail.com>
Subject: Re: [PATCH v2 5/6] staging:iio:ad2s90: Add IIO_CHAN_INFO_SCALE to
 channel spec and read_raw
Message-ID: <20181103172606.364fc1b0@archlinux>
In-Reply-To: <CAHd-oW4wki7am70DHFWb0GjOCtptRYRfAO2BG=32=YBBeAyASg@mail.gmail.com>
References: <20181027020005.3140-1-matheus.bernardino@usp.br>
        <20181027020005.3140-6-matheus.bernardino@usp.br>
        <20181028165040.27c69fc5@archlinux>
        <CAHd-oW4wki7am70DHFWb0GjOCtptRYRfAO2BG=32=YBBeAyASg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Nov 2018 13:04:04 -0300
Matheus Tavares Bernardino <matheus.bernardino@usp.br> wrote:

> On Sun, Oct 28, 2018 at 1:50 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Fri, 26 Oct 2018 23:00:04 -0300
> > Matheus Tavares <matheus.bernardino@usp.br> wrote:
> >  
> > > This patch adds the IIO_CHAN_INFO_SCALE mask to ad2s90_chan and
> > > implements the relative read behavior at ad2s90_read_raw.
> > >
> > > Signed-off-by: Victor Colombo <victorcolombo@gmail.com>
> > > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>  
> >
> > Hi,
> >
> > A suggestion inline.  This is a common case that we have infrastructure
> > to simplify.  + I think your scale factor is very slightly wrong.
> >
> > Jonathan
> >  
> > > ---
> > >  drivers/staging/iio/resolver/ad2s90.c | 32 ++++++++++++++++++---------
> > >  1 file changed, 22 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
> > > index b4a6a89c11b0..52b656875ed1 100644
> > > --- a/drivers/staging/iio/resolver/ad2s90.c
> > > +++ b/drivers/staging/iio/resolver/ad2s90.c
> > > @@ -34,19 +34,31 @@ static int ad2s90_read_raw(struct iio_dev *indio_dev,
> > >       int ret;
> > >       struct ad2s90_state *st = iio_priv(indio_dev);
> > >
> > > -     mutex_lock(&st->lock);
> > > +     switch (m) {
> > > +     case IIO_CHAN_INFO_SCALE:
> > > +             /* 2 * Pi / (2^12 - 1) ~= 0.001534355 */
> > > +             *val = 0;
> > > +             *val2 = 1534355;  
> > Definitely 2^12 - 1?  That's a bit unusual if true as it would imply
> > that 2^12 - 1 and 0 were the same value.
> >
> > Imagine a smaller version with on 2^2 bits so 0, 1, 2, 3
> > Values of each are
> >
> > 0, M_PI/2, M_PI, 3*M_PI/2
> >
> > So the multiplier is 2*M_PI/(2^2) not 2*M_PI/(2^2 - 1)
> > 1/2 vs 2/3 * M_PI  
> 
> Oh, that makes a lot of sense! We used 2^12 - 1 here based on driver
> drivers/iio/resolver/ad2s1200.c, whose resolution is also 12 bits, as
> the ad2s90.c. Do you think this section is, perhaps, wrong on
> ad2s1200.c too, or maybe there is some difference between these two
> drivers that I didn't catch regarding the resolution?
Certainly seems likely to be wrong.  Difference is tiny so no one
probably ever noticed :(

Feel free to post a patch fixing that one as well!

Thanks,

Jonathan

> 
> Matheus.
> 
> > Now this is a very common case so we have the return type
> > IIO_VAL_FRACTIONAL_LOG2 to give a more obvious and potentially
> > more accurate representation.
> >  
> > > +             return IIO_VAL_INT_PLUS_NANO;
> > > +     case IIO_CHAN_INFO_RAW:
> > > +             mutex_lock(&st->lock);
> > > +
> > > +             ret = spi_read(st->sdev, st->rx, 2);
> > > +             if (ret < 0) {
> > > +                     mutex_unlock(&st->lock);
> > > +                     return ret;
> > > +             }
> > > +
> > > +             *val = (((u16)(st->rx[0])) << 4) | ((st->rx[1] & 0xF0) >> 4);
> > >
> > > -     ret = spi_read(st->sdev, st->rx, 2);
> > > -     if (ret < 0) {
> > >               mutex_unlock(&st->lock);
> > > -             return ret;
> > > -     }
> > >
> > > -     *val = (((u16)(st->rx[0])) << 4) | ((st->rx[1] & 0xF0) >> 4);
> > > -
> > > -     mutex_unlock(&st->lock);
> > > +             return IIO_VAL_INT;
> > > +     default:
> > > +             break;
> > > +     }
> > >
> > > -     return IIO_VAL_INT;
> > > +     return -EINVAL;
> > >  }
> > >
> > >  static const struct iio_info ad2s90_info = {
> > > @@ -57,7 +69,7 @@ static const struct iio_chan_spec ad2s90_chan = {
> > >       .type = IIO_ANGL,
> > >       .indexed = 1,
> > >       .channel = 0,
> > > -     .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > > +     .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> > >  };
> > >
> > >  static int ad2s90_probe(struct spi_device *spi)  
> >  

