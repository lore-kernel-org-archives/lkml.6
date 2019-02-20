Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6116C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A036E21841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550681787;
	bh=oIS7lSF4HXo//aiugYgaw2YVawOfHPqLXBn4b69cH7k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=jI1JuCfPewuyBIcuJfaEjuOi54nKeulTzrCI2UY1F/zAcaShnBuauUhJKqxED1h9l
	 KeA3m06by5Mwu0sSdkMUSIekbN+l68sUx/SIJ4FaPGxcibwQmCvJ4wqVj/gIDHqGN0
	 zHFi2FBGkxHmc044XLmx191mNVZdglTLNOjmOBZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfBTQ40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:56:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:42646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfBTQ4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 11:56:25 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E9BF2084D;
        Wed, 20 Feb 2019 16:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550681784;
        bh=oIS7lSF4HXo//aiugYgaw2YVawOfHPqLXBn4b69cH7k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OkmbynPDy3YJ/EKR9KV+6+J86ZDBNyUP3mUEBVqI4pZ7OOH/xRVqvvwmCAYGpOSh9
         syWl5sTtM73TPtLFGyWsgzCiD+mSSU/fRvBe2hY/PD/S/KlEHma75z6XYqNfdvA8uI
         wlzeExkIaCzpZMqW1EPGnElFnHYPOsE1Cytqkmwg=
Date:   Wed, 20 Feb 2019 16:56:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mathieu Othacehe <m.othacehe@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: trigger: Print an error if there is no
 available irq
Message-ID: <20190220165619.171da668@archlinux>
In-Reply-To: <20190220164910.18517-1-m.othacehe@gmail.com>
References: <20190220164910.18517-1-m.othacehe@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2019 17:49:10 +0100
Mathieu Othacehe <m.othacehe@gmail.com> wrote:

> If there are more trigger consumers than
> CONFIG_IIO_CONSUMERS_PER_TRIGGER, iio_trigger_attach_poll_func will
> silently fail. Add an error message to inform the user that
> CONFIG_IIO_CONSUMERS_PER_TRIGGER limit might be exceeded.
> 
> Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/industrialio-trigger.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index ce66699c7fcc..e5b538379ed1 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -254,8 +254,11 @@ static int iio_trigger_attach_poll_func(struct iio_trigger *trig,
>  
>  	/* Get irq number */
>  	pf->irq = iio_trigger_get_irq(trig);
> -	if (pf->irq < 0)
> +	if (pf->irq < 0) {
> +		pr_err("Could not find an available irq for trigger %s, CONFIG_IIO_CONSUMERS_PER_TRIGGER=%d limit might be exceeded\n",
> +			trig->name, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
>  		goto out_put_module;
> +	}
>  
>  	/* Request irq */
>  	ret = request_threaded_irq(pf->irq, pf->h, pf->thread,

