Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7BEC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 06:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D98C32083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 06:18:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D98C32083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbeJYOth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 10:49:37 -0400
Received: from smtprelay0074.hostedemail.com ([216.40.44.74]:57930 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726867AbeJYOth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 10:49:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 3AF08180A8CA8;
        Thu, 25 Oct 2018 06:18:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: note94_2b7e760f00625
X-Filterd-Recvd-Size: 2538
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Thu, 25 Oct 2018 06:18:18 +0000 (UTC)
Message-ID: <cc426006c1d69f9fd464afe96a62e9e745b2078b.camel@perches.com>
Subject: Re: [PATCH] staging: axis-fifo: Fix line over 80 characters error
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Aleksa Zdravkovic <alex.zdravkovic98@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 24 Oct 2018 23:18:17 -0700
In-Reply-To: <20181025060533.mfmdozimla7wq2sg@mwanda>
References: <20181024150550.GA5150@zdravcePC>
         <20181025060533.mfmdozimla7wq2sg@mwanda>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-25 at 09:05 +0300, Dan Carpenter wrote:
> On Wed, Oct 24, 2018 at 05:05:53PM +0200, Aleksa Zdravkovic wrote:
> > This patch fixes the checkpatch.pl warning:
[]
> > diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
[]
> > @@ -482,10 +482,10 @@ static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
> >  		spin_lock_irq(&fifo->write_queue_lock);
> >  		ret = wait_event_interruptible_lock_irq_timeout
> >  			(fifo->write_queue,
> > -			 ioread32(fifo->base_addr + XLLF_TDFV_OFFSET)
> > +			ioread32(fifo->base_addr + XLLF_TDFV_OFFSET)
> >  				>= words_to_write,
> > -			 fifo->write_queue_lock,
> > -			 (write_timeout >= 0) ? msecs_to_jiffies(write_timeout) :
> > +			fifo->write_queue_lock,
> > +			(write_timeout >= 0) ? msecs_to_jiffies(write_timeout) :
> >  				MAX_SCHEDULE_TIMEOUT);
> 
> The original was fine.  Just leave it.
> 
> Checkpatch.pl is only useful if it improves the readability for humans.

True, but I think the original is just OK.

Any suggestion on how to make the thing better?

wait_event_interruptible_lock_irq_timeout is a fairly long
identifier with multiple long arguments.

It's as if it should be written here as

 		ret = wait_event_interruptible_lock_irq_timeout(fifo->write_queue,
								ioread32(fifo->base_addr + XLLF_TDFV_OFFSET) >= words_to_write,
								fifo->write_queue_lock,
								write_timeout >= 0 ? msecs_to_jiffies(write_timeout) : MAX_SCHEDULE_TIMEOUT);

where the longest is way over 80 chars, (140?) but I simply don't care
because it's just that much more readable for me.


