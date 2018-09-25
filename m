Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A62C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A532082C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1A532082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbeIYUup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 16:50:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54082 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729224AbeIYUup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 16:50:45 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 31F8FE22;
        Tue, 25 Sep 2018 14:42:55 +0000 (UTC)
Date:   Tue, 25 Sep 2018 16:42:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 4.14 156/173] gpiolib: Respect error code of
 ->get_direction()
Message-ID: <20180925144252.GA28362@kroah.com>
References: <20180924113114.334025954@linuxfoundation.org>
 <20180924113126.730832814@linuxfoundation.org>
 <dfdf04ac-2413-ccf3-a8ea-407674cc6b08@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfdf04ac-2413-ccf3-a8ea-407674cc6b08@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 03:12:13PM +0100, Jon Hunter wrote:
> Hi Greg,
> 
> On 24/09/18 12:53, Greg Kroah-Hartman wrote:
> > 4.14-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > [ Upstream commit 36b312792b97933dc07abe074f50941199bd357c ]
> > 
> > In case we try to lock GPIO pin as IRQ when something going wrong
> > we print a misleading message.
> > 
> > Correct this by checking an error code from ->get_direction() in
> > gpiochip_lock_as_irq() and printing a corresponding message.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/gpio/gpiolib.c |    6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > --- a/drivers/gpio/gpiolib.c
> > +++ b/drivers/gpio/gpiolib.c
> > @@ -2811,6 +2811,12 @@ int gpiochip_lock_as_irq(struct gpio_chi
> >  	if (!chip->can_sleep && chip->get_direction) {
> >  		int dir = chip->get_direction(chip, offset);
> >  
> > +		if (dir < 0) {
> > +			chip_err(chip, "%s: cannot get GPIO direction\n",
> > +				 __func__);
> > +			return dir;
> > +		}
> > +
> >  		if (dir)
> >  			clear_bit(FLAG_IS_OUT, &desc->flags);
> >  		else
> 
> This change is causing a boot regression on Tegra20 and Tegra30. After
> this change was merged in mainline there was a fix for Tegra [0] that
> was also needed.
> 
> On Tegra the above change causes the allocation of GPIOs to fail and
> looks like this then exposes another bug somewhere else that finally
> leads to a system crash.
> 
> If this is needed for stable, then we will need the fix for Tegra as well.

Thanks, I've just dropped this from all of the queues, no need to cause
more problems.

greg k-h
