Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03760C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F8C20836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6F8C20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754126AbeFSWv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 18:51:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37468 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752895AbeFSWvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 18:51:49 -0400
Received: from localhost (s169.156.222.122.fls.vectant.ne.jp [122.222.156.169])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6D4D3FC3;
        Tue, 19 Jun 2018 22:51:48 +0000 (UTC)
Date:   Wed, 20 Jun 2018 07:51:45 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] driver core: add a debugfs entry to show deferred devices
Message-ID: <20180619225145.GA23389@kroah.com>
References: <20180619205914.21375-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619205914.21375-1-javierm@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 10:59:14PM +0200, Javier Martinez Canillas wrote:
> For debugging purposes it may be useful to know what are the devices whose
> probe function was deferred. Add a debugfs entry showing that information.
> 
>   $ cat /sys/kernel/debug/deferred_devices
>   48070000.i2c:twl@48:bci
>   musb-hdrc.0.auto
>   omapdrm.0
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> ---
> 
> Changes since RFC v1:
> - Remove unneeded ret variable from deferred_devs_show()
> 
> Changes since RFC v2:
> - Use DEFINE_SHOW_ATTRIBUTE() macro.
> - Don't propagate debugfs_create_file() error.
> - Remove IS_ENABLED(CONFIG_DEBUG_FS) guards.
> - Drop RFC prefix.
> 
>  drivers/base/dd.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 1435d7281c6..8ec9e3cfbe4 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -16,6 +16,7 @@
>   * Copyright (c) 2007-2009 Novell Inc.
>   */
>  
> +#include <linux/debugfs.h>
>  #include <linux/device.h>
>  #include <linux/delay.h>
>  #include <linux/dma-mapping.h>
> @@ -224,6 +225,24 @@ void device_unblock_probing(void)
>  	driver_deferred_probe_trigger();
>  }
>  
> +/*
> + * deferred_devs_show() - Show the devices in the deferred probe pending list.
> + */
> +static int deferred_devs_show(struct seq_file *s, void *data)
> +{
> +	struct device_private *curr;
> +
> +	mutex_lock(&deferred_probe_mutex);
> +
> +	list_for_each_entry(curr, &deferred_probe_pending_list, deferred_probe)
> +		seq_printf(s, "%s\n", dev_name(curr->device));
> +
> +	mutex_unlock(&deferred_probe_mutex);
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(deferred_devs);
> +
>  /**
>   * deferred_probe_initcall() - Enable probing of deferred devices
>   *
> @@ -233,6 +252,9 @@ void device_unblock_probing(void)
>   */
>  static int deferred_probe_initcall(void)
>  {
> +	debugfs_create_file("deferred_devices", 0444, NULL, NULL,
> +			    &deferred_devs_fops);

In the root of debugfs?

Anyway, what about "devices_deferred", to help keep things semi-sane if
we have other driver core debugfs entries?

And you don't remove the file ever?

And what is the use of this file?  What can you do with this
information?  Who is going to use it?  Don't we have other deferred
probe debugging somewhere else?

thanks,

greg k-h
