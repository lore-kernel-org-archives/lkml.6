Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFE9C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 19:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C68E20693
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 19:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C68E20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754043AbeGETNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 15:13:34 -0400
Received: from foss.arm.com ([217.140.101.70]:55262 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753466AbeGETNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 15:13:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20DC97A9;
        Thu,  5 Jul 2018 12:13:33 -0700 (PDT)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 013003F5A0;
        Thu,  5 Jul 2018 12:13:31 -0700 (PDT)
Date:   Thu, 5 Jul 2018 20:13:27 +0100
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Bo Yan <byan@nvidia.com>
Cc:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] irqchip/gic: check return value of
 of_address_to_resource
Message-ID: <20180705201327.4a4dc7dd@why.wild-wind.fr.eu.org>
In-Reply-To: <1530814859-11610-1-git-send-email-byan@nvidia.com>
References: <1530814859-11610-1-git-send-email-byan@nvidia.com>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bo,

On Thu, 5 Jul 2018 11:20:59 -0700
Bo Yan <byan@nvidia.com> wrote:

> The of_address_to_resource returns 0 if successful. gic_check_eoimode
> calls it without checking the return value. This induces Coverity
> warning: "Unchecked return value".
> 
> Return false from gic_check_eoimode if of_address_to_resource returns
> non-0 value.
> 
> Signed-off-by: Bo Yan <byan@nvidia.com>
> ---
>  drivers/irqchip/irq-gic.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index ced10c4..0bceb10 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -1284,7 +1284,8 @@ static bool gic_check_eoimode(struct device_node *node, void __iomem **base)
>  {
>  	struct resource cpuif_res;
>  
> -	of_address_to_resource(node, 1, &cpuif_res);
> +	if (of_address_to_resource(node, 1, &cpuif_res))
> +		return false;

We've just done an of_iomap() on this resource, which succeeded. How
can the same thing now fail? It would mean that the device tree has
been pulled from under our feet...

And if it could happen, why is returning false the right thing to do?
Why would we say we want EOImode==0 instead of 1?

>  
>  	if (!is_hyp_mode_available())
>  		return false;

As it stands, I'm not taking such a patch. It either papers over a
bigger problem, or just keeps a warning quiet for the sake of it.

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
