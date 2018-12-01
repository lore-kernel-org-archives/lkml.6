Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76289C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 16:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47BA520834
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 16:02:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47BA520834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jic23.retrosnub.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeLBDO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 22:14:56 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:47362 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbeLBDO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 22:14:56 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 076119E749D;
        Sat,  1 Dec 2018 16:02:04 +0000 (GMT)
Date:   Sat, 1 Dec 2018 16:02:03 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     Himanshu Jha <himanshujha199640@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: chemical: add support for Sensirion SPS30
 sensor
Message-ID: <20181201160203.0b26e393@archlinux>
In-Reply-To: <20181126204803.GA19277@arch>
References: <20181124221415.10081-1-tduszyns@gmail.com>
        <20181124221415.10081-3-tduszyns@gmail.com>
        <20181125104434.GA19309@himanshu-Vostro-3559>
        <20181126204803.GA19277@arch>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2018 21:48:07 +0100
Tomasz Duszynski <tduszyns@gmail.com> wrote:

> On Sun, Nov 25, 2018 at 04:14:34PM +0530, Himanshu Jha wrote:
> > On Sat, Nov 24, 2018 at 11:14:14PM +0100, Tomasz Duszynski wrote:  
> > > Add support for Sensirion SPS30 particulate matter sensor.
> > >
> > > Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
> > > ---
> > >  drivers/iio/chemical/Kconfig  |  11 ++
> > >  drivers/iio/chemical/Makefile |   1 +
> > >  drivers/iio/chemical/sps30.c  | 359 ++++++++++++++++++++++++++++++++++
> > >  3 files changed, 371 insertions(+)
> > >  create mode 100644 drivers/iio/chemical/sps30.c  
> >
> > []
> >  
> > > +#define pr_fmt(fmt) "sps30: " fmt  
> >
> > I don't see its usage ?
> >  
> 
> Hint: checkout how dev_err() is defined.
> 
> > > +#include <linux/crc8.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/i2c.h>
> > > +#include <linux/iio/buffer.h>
> > > +#include <linux/iio/iio.h>
> > > +#include <linux/iio/sysfs.h>
> > > +#include <linux/iio/trigger_consumer.h>
> > > +#include <linux/iio/triggered_buffer.h>
> > > +#include <linux/module.h>
> > > +
> > > +#define SPS30_CRC8_POLYNOMIAL 0x31
> > > +
> > > +/* SPS30 commands */
> > > +#define SPS30_START_MEAS 0x0010
> > > +#define SPS30_STOP_MEAS 0x0104
> > > +#define SPS30_RESET 0xd304
> > > +#define SPS30_READ_DATA_READY_FLAG 0x0202
> > > +#define SPS30_READ_DATA 0x0300
> > > +#define SPS30_READ_SERIAL 0xD033  
> >
> > Could you please put a tab and align these macros.
> >
> >   #define SPS30_START_MEAS		0x0010
> >   #define SPS30_STOP_MEAS		0x0104
> >  
> 
> In my opinion this sort of alignment does not pay off in the long run.
> Adding a new definition, a slightly longer one perhaps, can easily break
> formatting.
> 
> So I would stay with current one.

Personally I agree with you on this one.  I don't care enough to
say either way though normally!

> 
> >  
> > > +static int sps30_write_then_read(struct sps30_state *state, u8 *buf,
> > > +				 int buf_size, u8 *data, int data_size)
> > > +{
> > > +	/* every two received data bytes are checksummed */
> > > +	u8 tmp[data_size + data_size / 2];  
> >
> > No VLAs!
> >
> > https://lore.kernel.org/lkml/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com/
> >  
> 
> Looks like -Wvla is some fairly recent addition to KBUILD_CFLAGS.

Yeah, that was only after a 'lot' of effort over years to get the number
present down to a small number.
 
I wrote plenty of them in the early days of IIO so got a lot of
those patches as part of the move to introducing the warning :)

Jonathan

...
