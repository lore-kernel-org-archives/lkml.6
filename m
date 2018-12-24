Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFBBC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C98D21721
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbeLXIyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 03:54:51 -0500
Received: from mail.bootlin.com ([62.4.15.54]:58428 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbeLXIyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 03:54:51 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id AE2D520A46; Mon, 24 Dec 2018 09:54:48 +0100 (CET)
Received: from aptenodytes (aaubervilliers-681-1-38-38.w90-88.abo.wanadoo.fr [90.88.157.38])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6CC1F20A2E;
        Mon, 24 Dec 2018 09:54:48 +0100 (CET)
Message-ID: <eaad72f27b69259c9d460f031a2c7c392f19a969.camel@bootlin.com>
Subject: Re: [PATCH] i2c: bcm2835: Clear current message and count after a
 transaction
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-i2c@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>
Date:   Mon, 24 Dec 2018 09:54:48 +0100
In-Reply-To: <4892f080-dff5-8d08-c78f-3c8b85f5a454@gmail.com>
References: <20181221121135.4847-1-paul.kocialkowski@bootlin.com>
         <4892f080-dff5-8d08-c78f-3c8b85f5a454@gmail.com>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2018-12-21 at 09:52 -0800, Florian Fainelli wrote:
> On 12/21/18 4:11 AM, Paul Kocialkowski wrote:
> > The driver's interrupt handler checks whether a message is currently
> > being handled with the curr_msg pointer. When it is NULL, the interrupt
> > is considered to be unexpected. Similarly, the i2c_start_transfer
> > routine checks for the remaining number of messages to handle in
> > num_msgs.
> > 
> > However, these values are never cleared and always keep the message and
> > number relevant to the latest transfer (which might be done already and
> > the underlying message memory might have been freed).
> > 
> > When an unexpected interrupt hits with the DONE bit set, the isr will
> > then try to access the flags field of the curr_msg structure, leading
> > to a fatal page fault.
> > 
> > Fix the issue by systematically clearing curr_msg and num_msgs in the
> > driver-wide device structure when a transfer is considered complete.
> 
> Should not this get a Fixes tag?

Yes it totally should! Thanks for the suggestion.

Cheers,

Paul

> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  drivers/i2c/busses/i2c-bcm2835.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
> > index 44deae78913e..5486252f5f2f 100644
> > --- a/drivers/i2c/busses/i2c-bcm2835.c
> > +++ b/drivers/i2c/busses/i2c-bcm2835.c
> > @@ -298,6 +298,9 @@ static int bcm2835_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
> >  		return -ETIMEDOUT;
> >  	}
> >  
> > +	i2c_dev->curr_msg = NULL;
> > +	i2c_dev->num_msgs = 0;
> > +
> >  	if (!i2c_dev->msg_err)
> >  		return num;
> >  
> > 
> 
> 
-- 
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com

