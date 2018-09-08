Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A212DC4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 14:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 435EB2086B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 14:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnEuKC6I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 435EB2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbeIHTDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 15:03:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726498AbeIHTDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 15:03:53 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36C892075A;
        Sat,  8 Sep 2018 14:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536416275;
        bh=3roJy3z0QfwO7aEy7+p6OrGdKeho++slnZ7cSqge9UI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dnEuKC6II9u/4SvikCxjn2mtZTAkn27pMqqWfqVNAKFTApAZtXigtABms0pNlfBYU
         yDsVRrnIFiasxhFXO2il9SzkGOa2xQBPGkjMpt0bJK5f0iCCGVbUCqto0Sg4fG+i/Q
         WycpLQTk4zgjj9TI+6sz1jmZ+Jl9glHZ+bhsGZB4=
Date:   Sat, 8 Sep 2018 15:17:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Himanshu Jha <himanshujha199640@gmail.com>
Cc:     zhong jiang <zhongjiang@huawei.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: remove unnecessary condition judgment in
 am2315_trigger_handler
Message-ID: <20180908151751.20e7396f@archlinux>
In-Reply-To: <20180908122913.GA4445@himanshu-Vostro-3559>
References: <1536404256-25189-1-git-send-email-zhongjiang@huawei.com>
        <20180908122913.GA4445@himanshu-Vostro-3559>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Sep 2018 17:59:13 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> On Sat, Sep 08, 2018 at 06:57:36PM +0800, zhong jiang wrote:
> > The iterator in for_each_set_bit is never null, therefore, remove
> > the redundant conditional judgment.
> > 
> > Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> > ---
> >  drivers/iio/humidity/am2315.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/humidity/am2315.c b/drivers/iio/humidity/am2315.c
> > index 7d8669d..dc12e37 100644
> > --- a/drivers/iio/humidity/am2315.c
> > +++ b/drivers/iio/humidity/am2315.c
> > @@ -176,8 +176,7 @@ static irqreturn_t am2315_trigger_handler(int irq, void *p)
> >  		i = 0;
> >  		for_each_set_bit(bit, indio_dev->active_scan_mask,
> >  				 indio_dev->masklength) {
> > -			data->buffer[i] = (bit ? sensor_data.temp_data :
> > -						 sensor_data.hum_data);
> > +			data->buffer[i] = sensor_data.temp_data;  
> 
> No, this seems wrong!
> 
> We have buffer support to either take both readings(temp & humid)
> simultaneously, or only single channel using specified scan mask.

Key think is that bit most definitely can be 0 if the 0th bit is set.
This isn't a null check at all.

I'm curious, was this a by inspection case or did some script throw
this one up?

Thanks,

Jonathan

> 
> Patch title should be:
> 
> "iio: humidity: am2315: .... .. "
> 
> 
> Thanks

