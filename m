Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794E1C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54266218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548918163;
	bh=oOZPwLpazFHRy4sVXAKRn8VXU+7Uo0WOpyJjIZQ57VY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mkx5azzUsyhJ+cFk5gevH9kndj/BO5UdsDMH13k9t5UJymp7nCpXIkwX0keGa65bW
	 OqGYcRXfsgbWJcMkDsWtn4yX26O4a7VAPkDG8OdMyRwlKUvMhKJzvBxcK0wqI9bQBG
	 EHZlCHLRhxQM7z/jqYmCPleEbBrpfh7oE2SIXoxo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730683AbfAaHCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 02:02:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:60074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbfAaHCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 02:02:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30D6720870;
        Thu, 31 Jan 2019 07:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548918160;
        bh=oOZPwLpazFHRy4sVXAKRn8VXU+7Uo0WOpyJjIZQ57VY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sKAzRSL+EthGoxS+wA0bv/Bk60/kOgQbWy/1jzY/+dln73UQNZU7jTmO/i4z4cWYx
         QuSBnqHU+tJRXf7pmMv8V1VqFK+iE+i/V2MPGhEwNJhtoLNGetgEG+YmGBSPbEh63h
         hwvHzsQTnwl/7VQIS9fiJsWEtLrtsQotrrdYbpqY=
Date:   Thu, 31 Jan 2019 08:02:38 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kyle Tso <kyletso@google.com>
Cc:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm: Export partner Source Capabilities
Message-ID: <20190131070238.GA4500@kroah.com>
References: <20190131035411.53576-1-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131035411.53576-1-kyletso@google.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 11:54:11AM +0800, Kyle Tso wrote:
> Provide a function to get the partner Source Capabilities.
> 
> Signed-off-by: Kyle Tso <kyletso@google.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 23 +++++++++++++++++++++++
>  include/linux/usb/tcpm.h      |  1 +
>  2 files changed, 24 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index f1d3e54210df..29cd84ba9960 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4494,6 +4494,29 @@ int tcpm_update_sink_capabilities(struct tcpm_port *port, const u32 *pdo,
>  }
>  EXPORT_SYMBOL_GPL(tcpm_update_sink_capabilities);
>  
> +/*
> + * Don't call this function in interrupt context. Caller needs to free the
> + * memory itself.
> + */
> +int tcpm_get_partner_src_caps(struct tcpm_port *port, u32 **src_pdo)
> +{
> +	unsigned int nr_pdo;
> +
> +	if (port->nr_source_caps == 0)
> +		return -ENODATA;
> +
> +	*src_pdo = kcalloc(port->nr_source_caps, sizeof(u32), GFP_KERNEL);
> +	if (!src_pdo)
> +		return -ENOMEM;
> +
> +	mutex_lock(&port->lock);
> +	nr_pdo = tcpm_copy_pdos(*src_pdo, port->source_caps,
> +				port->nr_source_caps);
> +	mutex_unlock(&port->lock);
> +	return nr_pdo;
> +}
> +EXPORT_SYMBOL_GPL(tcpm_get_partner_src_caps);

We don't add new functions that no one uses :(

