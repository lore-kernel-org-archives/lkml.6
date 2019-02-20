Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC55C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D5E20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550662501;
	bh=G36ZHd7D9eHLnW6qGl3mA5qqZ+q+yuZZlm92mdHzJSs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=unXZ+926heX+ktvQO5ShyWzv1M3siTRe0NJyZ15K6OhMUHFqxXdilB9LZ56yOIopR
	 bKg10e/kEBGiGEYCyPVwZFM+UMLOeDv+3ZdOrEkD0nJdMlxR/OKS8W8PFdBDS9+gnW
	 fETjumlp1qHUFZ/q8MEY+kvSN6fmfcbOIL6fvHp8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfBTLfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:35:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:37112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbfBTLe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:34:59 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0149020851;
        Wed, 20 Feb 2019 11:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550662498;
        bh=G36ZHd7D9eHLnW6qGl3mA5qqZ+q+yuZZlm92mdHzJSs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a4+rH3AX4vVLSlvYOc4HwGEF12N0bxhim4Auu7a07x45oRiNkPtbQj6hlYgUi9DV4
         Fawd2q/6RZvzxn7usVE9362UIO5wmJyr9OCR3c8zavAwuiftY06Xn+w3A9yQt5fnia
         86bVbz2I23vZWnGak7lRkurd+K998832Y0J7fmow=
Date:   Wed, 20 Feb 2019 11:34:53 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Martin Kelly <mkelly@xevo.com>
Cc:     Mathieu Othacehe <m.othacehe@gmail.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: trigger: Print an error if there is no available
 irq
Message-ID: <20190220113453.22d8fcd2@archlinux>
In-Reply-To: <cd3cf791-e035-d06c-ea1b-4415a93ea7a2@xevo.com>
References: <20190213131752.646-1-m.othacehe@gmail.com>
        <cd3cf791-e035-d06c-ea1b-4415a93ea7a2@xevo.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019 22:19:16 +0000
Martin Kelly <mkelly@xevo.com> wrote:

> On 2/13/19 5:17 AM, Mathieu Othacehe wrote:
> > If there are more trigger consumers than
> > CONFIG_IIO_CONSUMERS_PER_TRIGGER, iio_trigger_attach_poll_func will
> > silently fail. Add an error message to inform the user that
> > CONFIG_IIO_CONSUMERS_PER_TRIGGER limit might be exceeded.
> > 
> > Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
> > ---
> >   drivers/iio/industrialio-trigger.c | 6 +++++-
> >   1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> > index ce66699c7fcc..801986c21467 100644
> > --- a/drivers/iio/industrialio-trigger.c
> > +++ b/drivers/iio/industrialio-trigger.c
> > @@ -254,8 +254,12 @@ static int iio_trigger_attach_poll_func(struct iio_trigger *trig,
> >   
> >   	/* Get irq number */
> >   	pf->irq = iio_trigger_get_irq(trig);
> > -	if (pf->irq < 0)
> > +	if (pf->irq < 0) {
> > +		pr_err("Could not find an available irq for trigger %s, "
> > +			"CONFIG_IIO_CONSUMERS_PER_TRIGGER limit "
> > +			"might be exceeded\n", trig->name);
> >   		goto out_put_module;
> > +	}
> >   
> >   	/* Request irq */
> >   	ret = request_threaded_irq(pf->irq, pf->h, pf->thread,
> >   
> 
> This seems useful! I think it would be good to print the value of 
> CONFIG_IIO_CONSUMERS_PER_TRIGGER too. Also, it appears this is 
> triggering a checkpatch warning:
> 
> WARNING: quoted string split across lines
Agreed, with both comments.  Sensible change though. I'll admit
I'm a bit embarrassed that I wrote it without that warning in the
first place :(

Thanks,

Jonathan

