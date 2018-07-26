Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC644C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C75E2083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C75E2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732077AbeGZRtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 13:49:14 -0400
Received: from smtprelay0236.hostedemail.com ([216.40.44.236]:58331 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731370AbeGZRtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 13:49:14 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 784181B40E;
        Thu, 26 Jul 2018 16:31:38 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: foot21_657922b68f861
X-Filterd-Recvd-Size: 2105
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Thu, 26 Jul 2018 16:31:37 +0000 (UTC)
Message-ID: <3b90173dc3a8ce12ef7f4896f05673140ac3b4d7.camel@perches.com>
Subject: Re: [PATCH v2 3/3] Staging: octeon-usb: Breaks down
 cvmx_usb_poll_channel().
From:   Joe Perches <joe@perches.com>
To:     Georgios Tsotsos <tsotsos@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     James Hogan <jhogan@kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Thu, 26 Jul 2018 09:31:35 -0700
In-Reply-To: <4465097e58f6dbc0e19b9e945ac0b8eee5d98726.1532610629.git.tsotsos@gmail.com>
References: <cover.1532610629.git.tsotsos@gmail.com>
         <4465097e58f6dbc0e19b9e945ac0b8eee5d98726.1532610629.git.tsotsos@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-07-26 at 18:41 +0300, Georgios Tsotsos wrote:
> In order to make this function more clear a new function created that controls
> channels halt on no DMA mode.
[]
> diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
[]
> @@ -2585,6 +2585,52 @@ static void cvmx_usb_transfer_isoc(struct octeon_hcd *usb,
>  	}
>  }
>  
> +/**
> + * Handles channels halt in non DMA mode
> + * @usbc_hcchar: Host Channel-n Characteristics Register (HCCHAR)
> + * @usbc_hcint:  Host Channel-n Interrupt Register
> + * @usb:         USB device
> + * @channel:     Channel to poll
> + *
> + * In non DMA mode the channels don't halt themselves. We need
> + * to manually disable channels that are left running
> + *
> + * Returns: -1 on halt
> + */
> +static int cvmx_usb_dma_halt(union cvmx_usbcx_hccharx usbc_hcchar,
> +			     union cvmx_usbcx_hcintx usbc_hcint,

It looks very suspect to pass unions on the stack.

Are you sure these aren't used after this function
is called?

Likely these should be pointers to unions.

