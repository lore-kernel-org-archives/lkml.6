Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A320BC433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 08:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F35E20C51
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 08:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F35E20C51
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jic23.retrosnub.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbeHYLzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 07:55:13 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:50312 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbeHYLzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 07:55:13 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 8C3A09E6AB2;
        Sat, 25 Aug 2018 09:17:00 +0100 (BST)
Date:   Sat, 25 Aug 2018 09:16:58 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Stefan Popa <stefan.popa@analog.com>, Michael.Hennerich@analog.com,
        knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: adxl372: Provide validate_trigger and
 validate_device callbacks
Message-ID: <20180825091658.0e4f7cf6@archlinux>
In-Reply-To: <f969da516d7185d84ae3c5abb51ab58b@kernel.org>
References: <1534776823-18703-1-git-send-email-stefan.popa@analog.com>
        <1fc5f7bb-67d1-fa03-2242-b38b94a151ee@metafoo.de>
        <f969da516d7185d84ae3c5abb51ab58b@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Aug 2018 17:37:08 +0100
jic23@kernel.org wrote:

> On 20.08.2018 16:47, Lars-Peter Clausen wrote:
> > On 08/20/2018 04:53 PM, Stefan Popa wrote:  
> >> This patch provides a validate_device callback for the trigger which 
> >> makes
> >> sure that other devices are rejected.
> >> 
> >> Signed-off-by: Stefan Popa <stefan.popa@analog.com
> >> ---
> >>  drivers/iio/accel/adxl372.c | 13 +++++++++++++
> >>  1 file changed, 13 insertions(+)
> >> 
> >> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> >> index d2fdc75..5a039ba 100644
> >> --- a/drivers/iio/accel/adxl372.c
> >> +++ b/drivers/iio/accel/adxl372.c
> >> @@ -762,11 +762,24 @@ static int adxl372_dready_trig_set_state(struct 
> >> iio_trigger *trig,
> >>  	return adxl372_set_interrupts(st, mask, 0);
> >>  }
> >> 
> >> +static int adxl372_validate_trigger(struct iio_dev *indio_dev,
> >> +				    struct iio_trigger *trig)
> >> +{
> >> +	struct adxl372_state *st = iio_priv(indio_dev);
> >> +
> >> +	if (st->dready_trig != trig)
> >> +		return -EINVAL;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >>  static const struct iio_trigger_ops adxl372_trigger_ops = {
> >> +	.validate_device = &iio_trigger_validate_own_device,
> >>  	.set_trigger_state = adxl372_dready_trig_set_state,
> >>  };
> >> 
> >>  static const struct iio_info adxl372_info = {
> >> +	.validate_trigger = &adxl372_validate_trigger,  
> > 
> > I wonder, if the device only works with the trigger and the trigger 
> > only
> > works with the device should we actually register a trigger?
> > 
> > Seems to be just extra hassle when setting up the device without any 
> > extra
> > benefits.  
> 
> I wondered the same, but there is a reason to do this if we think we
> will eventually have support for other triggers (which looks possible 
> for
> this device as we can bypass the fifo).  Then we want to do it in order
> to avoid a breaking ABI change.  There is a way around that by setting
> a default trigger so that it'll still use this one unless it is 
> explicitly
> set but that is rather ugly!
> 
> Jonathan
Hi Lars, Stefan,

I'll apply this as is, but if we continue this debate and reach another
conclusion we can always make a change during this cycle.

Plenty of time left!

Thanks,

Jonathan

