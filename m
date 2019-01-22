Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FEBC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82CBA218D9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548149943;
	bh=GR/l8uHjvDoU91Hb5DMBeDbk+ls8MSkvIDjL+dnI6as=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H6mC13T6s0b22K353F+o2dPVUIYcKO7X0HpDTz7LRCwEjyKr7vScV9moX8+hejd6e
	 VNbKGMtgNLCFNEVdvrKsfJVaMUCNmybuX6yYvYQq8weUtnSxVJrDOzsflb+T6kJLo/
	 3azkJu5a9QejWpZENWk74OLUB1+iDLmIpVA74Mm0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbfAVJjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:39:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:58534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbfAVJjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:39:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BC73218D0;
        Tue, 22 Jan 2019 09:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548149941;
        bh=GR/l8uHjvDoU91Hb5DMBeDbk+ls8MSkvIDjL+dnI6as=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EkSr+O/5n0zxbwksDBB6V5i9rU7u12f0MmRigYt5DLDHpUmyskd5KElljY65tSHQr
         fAjV9aLJyLSpeWfi5yALzl5h32iE3w1K6RIR/43GqMB3qO50RcVBhFQZ5xEDraiIlb
         fqBUhHpYE4Sdwbi9wsZHO7GUdlzRmzGKuNB9W9+4=
Date:   Tue, 22 Jan 2019 10:38:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     arnd@arndb.de, andy.shevchenko@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6]  misc/pvpanic: add API for pvpanic driver framework
Message-ID: <20190122093858.GB29657@kroah.com>
References: <1548098711-52497-1-git-send-email-peng.hao2@zte.com.cn>
 <1548098711-52497-3-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548098711-52497-3-git-send-email-peng.hao2@zte.com.cn>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 03:25:08AM +0800, Peng Hao wrote:
> Add pvpanic_add/remove_device API.

That says what you are doing, but not _why_ you need to do this.

Why?

> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  drivers/misc/pvpanic/pvpanic.c | 32 ++++++++++++++++++++++++++++++++
>  drivers/misc/pvpanic/pvpanic.h | 14 ++++++++++++++
>  2 files changed, 46 insertions(+)
>  create mode 100644 drivers/misc/pvpanic/pvpanic.h
> 
> diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
> index 227ab4e..f842ee4 100644
> --- a/drivers/misc/pvpanic/pvpanic.c
> +++ b/drivers/misc/pvpanic/pvpanic.c
> @@ -48,6 +48,38 @@
>  	.priority = 1, /* let this called before broken drm_fb_helper */
>  };
>  
> +int pvpanic_add_device(struct device *dev, struct resource *res)
> +{
> +	struct platform_device *pdev;
> +	int ret;
> +
> +	pdev = platform_device_alloc("pvpanic", -1);
> +	if (!pdev)
> +		return -ENOMEM;
> +
> +	pdev->dev.parent = dev;
> +
> +	ret = platform_device_add_resources(pdev, res, 1);
> +	if (ret)
> +		goto err;
> +
> +	ret = platform_device_add(pdev);
> +	if (ret)
> +		goto err;
> +	pvpanic_data.pdev = pdev;
> +
> +	return 0;
> +err:
> +	platform_device_put(pdev);
> +	return -1;
> +}
> +
> +void pvpanic_remove_device(void)
> +{
> +	platform_device_unregister(pvpanic_data.pdev);
> +	pvpanic_data.pdev = NULL;
> +}
> +
>  static int pvpanic_platform_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> diff --git a/drivers/misc/pvpanic/pvpanic.h b/drivers/misc/pvpanic/pvpanic.h
> new file mode 100644
> index 0000000..a72ca59
> --- /dev/null
> +++ b/drivers/misc/pvpanic/pvpanic.h
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later

Do you really mean or later?  I have to ask, sorry.

> +/* pvpanic driver framework header file
> + *
> + * Copyright (C) 2019 ZTE Ltd.
> + * Author: Peng Hao <peng.hao2@zte.com.cn>
> + */
> +
> +#ifndef __DRIVERS_MISC_PVPANIC_H
> +#define __DRIVERS_MISC_PVPANIC_H
> +
> +extern int pvpanic_add_device(struct device *dev, struct resource *res);
> +extern void pvpanic_remove_device(void);


No need for "extern", and why have these functions here if no one is
using them?

thanks,

greg k-h
