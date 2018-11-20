Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4233C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 07:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75E12075B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 07:27:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E75E12075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732507AbeKTRza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 12:55:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:44524 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726840AbeKTRza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 12:55:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 44A5CAF3A;
        Tue, 20 Nov 2018 07:27:49 +0000 (UTC)
Message-ID: <1542698298.28362.4.camel@suse.com>
Subject: Re: [PATCH v2] usb: hub: add retry routine after intr URB sumbit
 error
From:   Oliver Neukum <oneukum@suse.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        stern@rowland.harvard.edu
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Date:   Tue, 20 Nov 2018 08:18:18 +0100
In-Reply-To: <e4e9c9ec8eee3978f2c88aef22b3d042d5695f75.camel@suse.de>
References: <20181119140208.11590-1-nsaenzjulienne@suse.de>
         <1542636268.945.4.camel@suse.com>
         <e4e9c9ec8eee3978f2c88aef22b3d042d5695f75.camel@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mo, 2018-11-19 at 16:52 +0100, Nicolas Saenz Julienne wrote:
>  
> > >  /* USB 2.0 spec Section 11.24.2.3 */
> > > @@ -1268,6 +1288,7 @@ static void hub_quiesce(struct usb_hub *hub,
> > > enum hub_quiescing_type type)
> > >  	}
> > >  
> > >  	/* Stop hub_wq and related activity */
> > > +	del_timer_sync(&hub->irq_urb_retry);
> > 
> > That is a race condition. You kill the timer here, but the URB may
> > still be in flight. And if it fails, it will restart the error
> > handler. You have to introduce a flag or poison the URB.
> 
> I see, wouldn't checking "hub->quiescing" in hub_irq()'s submit error
> path do the work? Something the likes of this:
> 
> @@ -713,8 +729,12 @@ static void hub_irq(struct urb *urb)
>   		return;
> 
>  	status = usb_submit_urb(hub->urb, GFP_ATOMIC);
> -	if (status != 0 && status != -ENODEV && status != -EPERM)
> +	if (status != 0 && status != -ENODEV && status != -EPERM &&
> +	    status != -ESHUTDOWN && !hub->quiescing) {

The problem with doing such things is that the interrupt and the
disconnect can run on two different CPUs. Thus if you use a flag
you need to make sure they don't race and you need to get
memory ordering right.

Doable, but not easy.
There is a reason URBs can be poisoned.

	Regards
		Oliver

