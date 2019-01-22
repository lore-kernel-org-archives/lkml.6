Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5FEC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36FE0218DE
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548150018;
	bh=gukq5GUR4mVZu3VBeqO12vnXjjHnhSz4+5pTn/4tcQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=slDdrmiktaiNeWx4ETA23i8amaYfwgE2CXKYtu2GhCnVYC7NokRwz5Au4QOQ3F692
	 uUIDyflmaEZTdofS800DqQd1Bqp7ctvjmvTAWWtCEkcH+FblTgzKe1Qapt5oTEw7So
	 9RoN9XK11ZTClLNx2jtMaWA/cXIkYKJ+sOukT84k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfAVJkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:40:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:59266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727165AbfAVJkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:40:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DA70218D9;
        Tue, 22 Jan 2019 09:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548150015;
        bh=gukq5GUR4mVZu3VBeqO12vnXjjHnhSz4+5pTn/4tcQY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=axx152+LaPCjQP9KNIiql12eF5eHw0/RD5Q77QQlhtRIBPnWkP0+aFpkkdrCkSzLV
         RpfM8O/cp+P8k96aA3AI+JnoU9bGzP8uzv7KtQkibJ3SmCs04+hMBru6t2JBzexNh8
         mWG4vkiGAQcEP1i5vt3JfNIye+gt9COANHOw6UGs=
Date:   Tue, 22 Jan 2019 10:40:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     arnd@arndb.de, andy.shevchenko@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6]  misc/pvpanic : add pvpanic acpi driver
Message-ID: <20190122094013.GC29657@kroah.com>
References: <1548098711-52497-1-git-send-email-peng.hao2@zte.com.cn>
 <1548098711-52497-4-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548098711-52497-4-git-send-email-peng.hao2@zte.com.cn>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 03:25:09AM +0800, Peng Hao wrote:
> Add pvpanic acpi driver in pvpanic driver framework.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  drivers/misc/pvpanic/Kconfig        |  9 +++++
>  drivers/misc/pvpanic/Makefile       |  1 +
>  drivers/misc/pvpanic/pvpanic-acpi.c | 77 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 87 insertions(+)
>  create mode 100644 drivers/misc/pvpanic/pvpanic-acpi.c
> 
> diff --git a/drivers/misc/pvpanic/Kconfig b/drivers/misc/pvpanic/Kconfig
> index 3e612c6..d274130 100644
> --- a/drivers/misc/pvpanic/Kconfig
> +++ b/drivers/misc/pvpanic/Kconfig
> @@ -5,3 +5,12 @@ config PVPANIC
>  	  This driver provides support for the pvpanic device.  pvpanic is
>  	  a paravirtualized device provided by QEMU; it lets a virtual machine
>  	  (guest) communicate panic events to the host.
> +
> +if PVPANIC
> +
> +config PVPANIC_ACPI
> +	tristate "pvpanic acpi driver"
> +	depends on ACPI
> +	default PVPANIC

No help text at all?  Not good.

> +
> +endif
> diff --git a/drivers/misc/pvpanic/Makefile b/drivers/misc/pvpanic/Makefile
> index 6394224..c5b73ca 100644
> --- a/drivers/misc/pvpanic/Makefile
> +++ b/drivers/misc/pvpanic/Makefile
> @@ -3,3 +3,4 @@
>  # Copyright (c) 2018 ZTE Ltd.
>  
>  obj-$(CONFIG_PVPANIC)            += pvpanic.o
> +obj-$(CONFIG_PVPANIC_ACPI)	 += pvpanic-acpi.o

Not aligned?

> diff --git a/drivers/misc/pvpanic/pvpanic-acpi.c b/drivers/misc/pvpanic/pvpanic-acpi.c
> new file mode 100644
> index 0000000..a6153fa
> --- /dev/null
> +++ b/drivers/misc/pvpanic/pvpanic-acpi.c
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later

Are you sure?

And also, shouldn't this be written as:
// SPDX-License-Identifier: GPL-2.0+

thanks,

greg k-h
