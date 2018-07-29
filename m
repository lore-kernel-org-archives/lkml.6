Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6890DC46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 215DD20857
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:35:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 215DD20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbeG2VHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 17:07:06 -0400
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:47466 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbeG2VHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 17:07:06 -0400
X-Greylist: delayed 510 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 Jul 2018 17:07:04 EDT
Received: from darkstar.musicnaut.iki.fi (85-76-68-182-nat.elisa-mobile.fi [85.76.68.182])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 24121B004B;
        Sun, 29 Jul 2018 22:27:04 +0300 (EEST)
Date:   Sun, 29 Jul 2018 22:27:03 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Georgios Tsotsos <tsotsos@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Hogan <jhogan@kernel.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] Staging: octeon-usb: Changes macro
 CVMX_WAIT_FOR_FIELD32 to function call.
Message-ID: <20180729192703.GA14390@darkstar.musicnaut.iki.fi>
References: <20180727151527.GA2209@kroah.com>
 <cover.1532864087.git.tsotsos@gmail.com>
 <0e52fbfefc34fe064201da9ad93e12e50e1e816c.1532864087.git.tsotsos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e52fbfefc34fe064201da9ad93e12e50e1e816c.1532864087.git.tsotsos@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jul 29, 2018 at 02:40:35PM +0300, Georgios Tsotsos wrote:
> +/**
> + * Loop through register until txfflsh or rxfflsh become zero.
> + *
> + * @usb:           USB block
> + * @address:       64bit address to read
> + * @timeout_usec:  Timeout
> + * @fflsh_type:    Indicates fflsh type, 0 for txfflsh, 1 for rxfflsh
> + *
> + */
> +static int cvmx_wait_for_field32(struct octeon_hcd *usb, u64 address,
> +				 u64 timeout_usec, int fflsh_type)

You should change the name of the function, as it's no longer generic
"wait for any field" to reach specified condition.

The "address" should be calculated from "usb" inside the function.

The timeout is always 100, you could just omit it.

Nobody is ever checking the result, so it's also redundant...

[...]

> +{
> +	int result;
> +	u64 done = cvmx_get_cycle() + timeout_usec *
> +		   (u64)octeon_get_clock_rate / 1000000;
> +
> +	union cvmx_usbcx_grstctl c;
> +
> +	while (1) {
> +		c.u32 = cvmx_usb_read_csr32(usb, address);
> +		if (fflsh_type == 0 && c.s.txfflsh == 0) {
> +			result = 0;
> +			break;
> +		} else if (fflsh_type == 1 && c.s.rxfflsh == 0) {
> +			result = 0;
> +			break;
> +		} else if (cvmx_get_cycle() > done) {
> +			result = -1;
> +			break;
> +		}
> +
> +		__delay(100);
> +	}
> +	return result;
> +}
> +
>  static void cvmx_fifo_setup(struct octeon_hcd *usb)
>  {
>  	union cvmx_usbcx_ghwcfg3 usbcx_ghwcfg3;
> @@ -635,11 +648,9 @@ static void cvmx_fifo_setup(struct octeon_hcd *usb)
>  	/* Flush all FIFOs */
>  	USB_SET_FIELD32(address, cvmx_usbcx_grstctl, txfnum, 0x10);
>  	USB_SET_FIELD32(address, cvmx_usbcx_grstctl, txfflsh, 1);
> -	CVMX_WAIT_FOR_FIELD32(address, cvmx_usbcx_grstctl,
> -			      c.s.txfflsh == 0, 100);
> +	cvmx_wait_for_field32(usb, address, 0, 100);

How did you test this patch? The parameters are in wrong order, you are
specifying 0 timeout.

>  	USB_SET_FIELD32(address, cvmx_usbcx_grstctl, rxfflsh, 1);
> -	CVMX_WAIT_FOR_FIELD32(address, cvmx_usbcx_grstctl,
> -			      c.s.rxfflsh == 0, 100);
> +	cvmx_wait_for_field32(usb, address, 1, 100);

Also wrong order here.

A.
