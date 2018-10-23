Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4F1C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2BB620652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:39:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2BB620652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbeJWTBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 15:01:54 -0400
Received: from foss.arm.com ([217.140.101.70]:56718 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727678AbeJWTBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 15:01:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A23D5341;
        Tue, 23 Oct 2018 03:39:02 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0565F3F6A8;
        Tue, 23 Oct 2018 03:39:00 -0700 (PDT)
Date:   Tue, 23 Oct 2018 11:38:58 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     robh+dt@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        andy@infradead.org, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        hutao@cn.fujitsu.com
Subject: Re: [PATCH 2/4]  pvpanic: add pvpanic support for arm64
Message-ID: <20181023103858.v4rqg646u7roszla@lakrids.cambridge.arm.com>
References: <1540315537-70007-1-git-send-email-peng.hao2@zte.com.cn>
 <1540315537-70007-2-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540315537-70007-2-git-send-email-peng.hao2@zte.com.cn>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 01:25:35AM +0800, Peng Hao wrote:
> pvpanic device is a qemu-specific emulation device. Pvpanic
> devices are now available for ARM64. This patch supports the APCI
> way to get device information.


This woule be better described as:

pvpanic: add MMIO support

On some architectures (e.g. arm64), it's preferable to use MMIO, since
this can be used standalone. Add MMIO support to the pvpanic driver.

> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  drivers/misc/pvpanic.c | 22 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
> index fd86dab..bdcff8b 100644
> --- a/drivers/misc/pvpanic.c
> +++ b/drivers/misc/pvpanic.c
> @@ -35,13 +35,16 @@
>  
>  static const struct acpi_device_id pvpanic_device_ids[] = {
>  	{ "QEMU0001", 0 },
> +	{ "PVPANIC01", 0 },
>  	{ "", 0 },

Why do we need the new ACPI ID?

Can't QEMU0001 cover both the ioport and MMIO versions, given they can
be distinguished based on the associated resources?

Otherwise, this looks sane to me.

Thanks,
Mark.

>  };
>  MODULE_DEVICE_TABLE(acpi, pvpanic_device_ids);
>  
>  #define PVPANIC_PANICKED	(1 << 0)
>  
> +
> +static void __iomem *base;
>  
>  static struct acpi_driver pvpanic_driver = {
>  	.name =		"pvpanic",
> @@ -57,7 +60,10 @@
>  static void
>  pvpanic_send_event(unsigned int event)
>  {
> -	outb(event, port);
> +	if (port)
> +		outb(event, port);
> +	else if (base)
> +		writeb(event, base);
>  }
>  
>  static int
> @@ -77,6 +83,8 @@
>  static acpi_status
>  pvpanic_walk_resources(struct acpi_resource *res, void *context)
>  {
> +	struct acpi_resource_fixed_memory32 *fixmem32;
> +
>  	switch (res->type) {
>  	case ACPI_RESOURCE_TYPE_END_TAG:
>  		return AE_OK;
> @@ -84,7 +92,11 @@
>  	case ACPI_RESOURCE_TYPE_IO:
>  		port = res->data.io.minimum;
>  		return AE_OK;
> -
> +
> +	case ACPI_RESOURCE_TYPE_FIXED_MEMORY32:
> +		fixmem32 = &res->data.fixed_memory32;
> +		base = ioremap(fixmem32->address, fixmem32->address_length);
> +		return AE_OK;
>  	default:
>  		return AE_ERROR;
>  	}
> @@ -104,7 +116,7 @@ static int pvpanic_add(struct acpi_device *device)
>  	acpi_walk_resources(device->handle, METHOD_NAME__CRS,
>  			    pvpanic_walk_resources, NULL);
>  
> -	if (!port)
> +	if (!port && !base)
>  		return -ENODEV;
>  
>  	atomic_notifier_chain_register(&panic_notifier_list,
> @@ -118,6 +130,8 @@ static int pvpanic_remove(struct acpi_device *device)
>  
>  	atomic_notifier_chain_unregister(&panic_notifier_list,
>  					 &pvpanic_panic_nb);
> +	if (base)
> +		iounmap(base);
>  	return 0;
>  }
>  
> -- 
> 1.8.3.1
> 
