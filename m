Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6D4C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709A121741
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 709A121741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732556AbeHNPrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 11:47:12 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55784 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729488AbeHNPrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 11:47:12 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 096F220799; Tue, 14 Aug 2018 15:00:05 +0200 (CEST)
Received: from localhost (unknown [37.169.111.59])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9BF0E2072C;
        Tue, 14 Aug 2018 14:59:54 +0200 (CEST)
Date:   Tue, 14 Aug 2018 14:59:54 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     nicolas.ferre@microchip.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm/mach-at91/pm: Do not double put the device node
Message-ID: <20180814125954.GM943@piout.net>
References: <1534211696-4221-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534211696-4221-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/2018 09:54:56+0800, zhong jiang wrote:
> Device node iterators put the previous value of the index variable,
> so an explicit put causes a double put.
> 

While for_each_matching_node_and_match will get and put the node
properly, there is also a call to of_find_device_by_node that will get a
reference to the node.

> I detect the issue with the help of Coccinelle.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  arch/arm/mach-at91/pm.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index 32fae4d..a5ec35f 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -143,15 +143,12 @@ static int at91_pm_config_ws(unsigned int pm_mode, bool set)
>  
>  			/* Check if enabled on SHDWC. */
>  			if (wsi->shdwc_mr_bit && !(val & wsi->shdwc_mr_bit))
> -				goto put_node;
> +				continue;
>  
>  			mode |= wsi->pmc_fsmr_bit;
>  			if (wsi->set_polarity)
>  				polarity |= wsi->pmc_fsmr_bit;
>  		}
> -
> -put_node:
> -		of_node_put(np);
>  	}
>  
>  	if (mode) {
> -- 
> 1.7.12.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
