Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3DBC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5AED20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:49:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5AED20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbeIKMrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 08:47:46 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41068 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbeIKMrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 08:47:45 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fzdQR-0000YZ-2A; Tue, 11 Sep 2018 09:49:31 +0200
Date:   Tue, 11 Sep 2018 09:49:31 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     gregkh@linuxfoundation.org, johan@kernel.org, bjorn@mork.no,
        mingo@kernel.org, oneukum@suse.com, viro@zeniv.linux.org.uk,
        mark.rutland@arm.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: cdc-wdm: Fix a sleep-in-atomic-context bug in
 service_outstanding_interrupt()
Message-ID: <20180911074930.2g6ryk7qe46cijhi@linutronix.de>
References: <20180901081210.16655-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180901081210.16655-1-baijiaju1990@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-01 16:12:10 [+0800], Jia-Ju Bai wrote:
> wdm_in_callback() is a completion handler function for the USB driver.
> So it should not sleep. But it calls service_outstanding_interrupt(), 
> which calls usb_submit_urb() with GFP_KERNEL. 

At which point does wdm_in_callback() invoke
service_outstanding_interrupt()? I don't see it. I see one invocation
from wdm_read() and another from service_interrupt_work().

Also, if that would be the case, then spin_unlock_irq() in an USB
completion handler (which might run in IRQ context with interrupts
disabled) would be wrong.

> To fix this bug, GFP_KERNEL is replaced with GFP_ATOMIC.
> 
> This bug is found by my static analysis tool DSAC.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
> v2:
>  * Add more description.
> ---
>  drivers/usb/class/cdc-wdm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
> index a0d284ef3f40..632a2bfabc08 100644
> --- a/drivers/usb/class/cdc-wdm.c
> +++ b/drivers/usb/class/cdc-wdm.c
> @@ -458,7 +458,7 @@ static int service_outstanding_interrupt(struct wdm_device *desc)
>  
>  	set_bit(WDM_RESPONDING, &desc->flags);
>  	spin_unlock_irq(&desc->iuspin);
> -	rv = usb_submit_urb(desc->response, GFP_KERNEL);
> +	rv = usb_submit_urb(desc->response, GFP_ATOMIC);
>  	spin_lock_irq(&desc->iuspin);
>  	if (rv) {
>  		dev_err(&desc->intf->dev,

Sebastian
