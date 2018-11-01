Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86919C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40495204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:42:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40495204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbeKAUow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 16:44:52 -0400
Received: from foss.arm.com ([217.140.101.70]:55422 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727507AbeKAUow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 16:44:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB51AA78;
        Thu,  1 Nov 2018 04:42:16 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD2413F71D;
        Thu,  1 Nov 2018 04:42:14 -0700 (PDT)
Date:   Thu, 1 Nov 2018 11:42:12 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     robh+dt@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        andy@infradead.org, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        hutao@cn.fujitsu.com, linux-doc@vger.kernel.org
Subject: Re: [PATCH V5 6/8]  misc/pvpanic: add MMIO support
Message-ID: <20181101114212.k3s5marvi66eg5xn@lakrids.cambridge.arm.com>
References: <1541085002-42993-1-git-send-email-peng.hao2@zte.com.cn>
 <1541085002-42993-6-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541085002-42993-6-git-send-email-peng.hao2@zte.com.cn>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 11:10:00PM +0800, Peng Hao wrote:
> On some architectures (e.g. arm64), it's preferable to use MMIO, since
> this can be used standalone. Add MMIO support to the pvpanic driver.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  drivers/misc/pvpanic.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
> index c20fdff..c0b787e 100644
> --- a/drivers/misc/pvpanic.c
> +++ b/drivers/misc/pvpanic.c
> @@ -28,7 +28,7 @@
>  
>  #define PVPANIC_PANICKED	(1 << 0)
>  
> -static u16 port;
> +static void __iomem *base;
>  
>  static struct acpi_driver pvpanic_driver = {
>  	.name =		"pvpanic",
> @@ -44,7 +44,7 @@
>  static void
>  pvpanic_send_event(unsigned int event)
>  {
> -	outb(event, port);
> +	iowrite8(event, base);
>  }
>  
>  static int
> @@ -66,8 +66,14 @@
>  {
>  	struct resource r;
>  
> -	if (acpi_dev_resource_io(res, &r) {
> -		port = r.start;
> +	if (acpi_dev_resource_io(res, &r) ||
> +	    acpi_dev_resource_memory(res, &r)) {
> +		if (r.flags & IORESOURCE_IO)
> +			base = (void __iomem *) ioport_map(r.start,
> +						r.end - r.start + 1);
> +		else
> +			base = ioremap(r.start, r.end - r.start + 1);
> +
>  		return AE_OK;
>  	}
>  
> @@ -89,7 +95,7 @@ static int pvpanic_add(struct acpi_device *device)
>  	acpi_walk_resources(device->handle, METHOD_NAME__CRS,
>  			    pvpanic_walk_resources, NULL);
>  
> -	if (!port)
> +	if (!base)
>  		return -ENODEV;
>  
>  	atomic_notifier_chain_register(&panic_notifier_list,
> @@ -103,6 +109,8 @@ static int pvpanic_remove(struct acpi_device *device)
>  
>  	atomic_notifier_chain_unregister(&panic_notifier_list,
>  					 &pvpanic_panic_nb);
> +
> +	iounmap(base);
>  	return 0;
>  }
>  
> -- 
> 1.8.3.1
> 
