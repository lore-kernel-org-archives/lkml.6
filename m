Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FFFECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 06:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D0220864
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 06:45:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41D0220864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbeGNHCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 03:02:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54960 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbeGNHCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 03:02:47 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 91CC58A5;
        Sat, 14 Jul 2018 06:44:49 +0000 (UTC)
Date:   Sat, 14 Jul 2018 08:39:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Todd Poynor <toddpoynor@gmail.com>
Cc:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>, devel@driverdev.osuosl.org,
        Zhongze Hu <frankhu@chromium.org>,
        linux-kernel@vger.kernel.org, Simon Que <sque@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Todd Poynor <toddpoynor@google.com>,
        Dmitry Torokhov <dtor@chromium.org>
Subject: Re: [PATCH 13/18] staging: gasket: gasket_enable_dev fixups
Message-ID: <20180714063904.GH20451@kroah.com>
References: <20180714055816.223754-1-toddpoynor@gmail.com>
 <20180714055816.223754-14-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180714055816.223754-14-toddpoynor@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 10:58:11PM -0700, Todd Poynor wrote:
> From: Todd Poynor <toddpoynor@google.com>
> 
> Remove unnecessary variable.
> 
> Bail out if no physical device.
> 
> Signed-off-by: Todd Poynor <toddpoynor@google.com>
> ---
>  drivers/staging/gasket/gasket_core.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
> index 65aa7cf454fb..f7d8f66e8746 100644
> --- a/drivers/staging/gasket/gasket_core.c
> +++ b/drivers/staging/gasket/gasket_core.c
> @@ -915,8 +915,6 @@ static int gasket_enable_dev(
>  {
>  	int tbl_idx;
>  	int ret;
> -	bool has_dma_ops;
> -	struct device *ddev;
>  	const struct gasket_driver_desc *driver_desc =
>  		internal_desc->driver_desc;
>  
> @@ -934,26 +932,21 @@ static int gasket_enable_dev(
>  		return ret;
>  	}
>  
> -	has_dma_ops = true;
> +	if (!gasket_dev->pci_dev) {
> +		gasket_log_error(gasket_dev,
> +				 "%s: no physical device", __func__);
> +		return -ENODEV;
> +	}

How can this ever be true?  I don't see where this can be removed to
enable this error check to be hit.  What am I missing?

thanks,

greg k-h
