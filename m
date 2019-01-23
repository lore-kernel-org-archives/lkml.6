Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50655C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1168D217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548228865;
	bh=s186fJC8vvhjr8+Yrm0wEu90lhBrmb5tDdQzIG0ASss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JhZfmTnI9tLMNxuhkKzPHQeeHJ5tgOSWQhXjdYJBlLP28mDW0EbobaVhKGRqxX4rP
	 TZFViweJbZFT3FlUl9YAjdvFEioYvPf3W3pSGPArvHxTWXYMRxjwlXjBGnylPAosTp
	 6hy4ChJK0YUcda0QZBYELnoldhJRsxEAAdZCB7do=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfAWHeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 02:34:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:49648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbfAWHeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 02:34:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6006521726;
        Wed, 23 Jan 2019 07:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548228862;
        bh=s186fJC8vvhjr8+Yrm0wEu90lhBrmb5tDdQzIG0ASss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2lenD8wFWs9J+A4RN+Wb3h9Ar0ap7sbq/T/l/XJ4pOGf0tPh0SIi6noA3MeMDNwZl
         Dj0MN97IQGcZwedOGWAzrEVIbZGr2RhpR714JeeBDfSjTXivhJ+5BgidEU9nfo3gCc
         bHi//VZFdKlxU1LvVYKfoRCtBQuLAOj6lUoO97AA=
Date:   Wed, 23 Jan 2019 08:34:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     arnd@arndb.de, andy.shevchenko@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 4/6]  misc/pvpanic: add pvpanic acpi driver
Message-ID: <20190123073419.GA18917@kroah.com>
References: <1548258448-62013-1-git-send-email-peng.hao2@zte.com.cn>
 <1548258448-62013-5-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548258448-62013-5-git-send-email-peng.hao2@zte.com.cn>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 11:47:26PM +0800, Peng Hao wrote:
> Make pvpanic acpi driver as seperate file and modify code 
> in order to adapt the framework.
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

Any reason you ignored the review comments I made for your v1
submission?

Please address those comments before you resend this again.

greg k-h
