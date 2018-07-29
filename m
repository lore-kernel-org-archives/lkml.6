Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD244FF05FE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 12:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96447205F4
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 12:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96447205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbeG2ONp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 10:13:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33700 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbeG2ONp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 10:13:45 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6DB30898;
        Sun, 29 Jul 2018 12:43:23 +0000 (UTC)
Date:   Sun, 29 Jul 2018 14:43:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Georgios Tsotsos <tsotsos@gmail.com>
Cc:     devel@driverdev.osuosl.org, James Hogan <jhogan@kernel.org>,
        linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH v3 1/1] Staging: octeon-usb: Breaks down
 cvmx_usb_poll_channel().
Message-ID: <20180729124320.GA27275@kroah.com>
References: <3b90173dc3a8ce12ef7f4896f05673140ac3b4d7.camel@perches.com>
 <cover.1532864059.git.tsotsos@gmail.com>
 <81f71a7c1997e53ec97f2b90ae562ff361a46f42.1532864059.git.tsotsos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81f71a7c1997e53ec97f2b90ae562ff361a46f42.1532864059.git.tsotsos@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 29, 2018 at 02:41:53PM +0300, Georgios Tsotsos wrote:
> In order to make this function more clear a new function created that controls
> channels halt on no DMA mode.
> 
> Signed-off-by: Georgios Tsotsos <tsotsos@gmail.com>
> ---
>  drivers/staging/octeon-usb/octeon-hcd.c | 81 +++++++++++++++++++++------------
>  1 file changed, 53 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
> index 8a7bdf1a9fe6..3f44ac260eff 100644
> --- a/drivers/staging/octeon-usb/octeon-hcd.c
> +++ b/drivers/staging/octeon-usb/octeon-hcd.c
> @@ -2593,7 +2593,51 @@ static void cvmx_usb_transfer_isoc(struct octeon_hcd *usb,
>  		cvmx_usb_complete(usb, pipe, transaction, CVMX_USB_STATUS_OK);
>  	}
>  }
> +/**

Blank line between functions please.

Also, as this is not a global function, no need for kerneldoc
formatting, but you did it already, so no big deal.

> + * Handles channels halt in non DMA mode
> + * @hcchar_chena:
> + * @hcint_xfercompl:
> + * @usb:             USB device
> + * @channel:         Channel to poll
> + *
> + * In non DMA mode the channels don't halt themselves. We need
> + * to manually disable channels that are left running
> + *
> + * Returns: -1 on halt
> + */
> +static int cvmx_usb_dma_halt(u32 hcchar_chena, u32 hcint_xfercompl,
> +			     struct octeon_hcd *usb, int channel)
> +{
> +	struct usb_hcd *hcd = octeon_to_hcd(usb);
> +	struct device *dev = hcd->self.controller;
>  
> +	if (hcchar_chena) {
> +		union cvmx_usbcx_hcintmskx hcintmsk;
> +		union cvmx_usbcx_hccharx usbc_hcchar;
> +		/* Disable all interrupts except CHHLTD */
> +		hcintmsk.u32 = 0;
> +		hcintmsk.s.chhltdmsk = 1;
> +		cvmx_usb_write_csr32(usb,
> +				     CVMX_USBCX_HCINTMSKX(channel, usb->index),
> +				     hcintmsk.u32);
> +		usbc_hcchar.s.chdis = 1;
> +		cvmx_usb_write_csr32(usb,
> +				     CVMX_USBCX_HCCHARX(channel, usb->index),
> +				     usbc_hcchar.u32);
> +		return -1;

Do not make up error values, return -EINVAL or something like that (what
ever the real error here is.)

> +	} else if (hcint_xfercompl) {
> +		/*
> +		 * Successful IN/OUT with transfer complete.
> +		 * Channel halt isn't needed.
> +		 */
> +	} else {
> +		dev_err(dev, "USB%d: Channel %d interrupt without halt\n",
> +			usb->index, channel);
> +		return -1;

Same here.

thanks,

greg k-h
