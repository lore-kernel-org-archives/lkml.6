Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAA1C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC2E23D15
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:01:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CC2E23D15
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934194AbeF1LBA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 07:01:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54468 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934000AbeF1LA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 07:00:59 -0400
Received: from localhost (unknown [104.153.224.166])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 01C2686A;
        Thu, 28 Jun 2018 11:00:57 +0000 (UTC)
Date:   Thu, 28 Jun 2018 19:51:55 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>,
        Mats Karrman <mats.dev.list@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] usb: typec: mux: Get the mux identifier from
 function parameter
Message-ID: <20180628105155.GB5191@kroah.com>
References: <20180627151953.30942-1-heikki.krogerus@linux.intel.com>
 <20180627151953.30942-4-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627151953.30942-4-heikki.krogerus@linux.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 06:19:48PM +0300, Heikki Krogerus wrote:
> In order for the muxes to be usable with alternate modes,
> the alternate mode devices will need also to be able to get
> a handle to the muxes on top of the port devices. To make
> that possible, the muxes need to be possible to request with
> an identifier.
> 
> This will change the API so that the mux identifier is given
> as a function parameter to typec_mux_get(), and the hard-coded
> "typec-mux" is replaced with that value.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/usb/typec/class.c     | 2 +-
>  drivers/usb/typec/mux.c       | 6 +++---
>  include/linux/usb/typec_mux.h | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 2b3eaa969f3b..b860bd3a0acb 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -1357,7 +1357,7 @@ struct typec_port *typec_register_port(struct device *parent,
>  		goto err_switch;
>  	}
>  
> -	port->mux = typec_mux_get(cap->fwnode ? &port->dev : parent);
> +	port->mux = typec_mux_get(parent, "typec-mux");

This changes the first parameter for this call, is that ok?  Doesn't
that change the functionality here?

thanks,

greg k-h
