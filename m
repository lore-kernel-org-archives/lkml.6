Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2CEC6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 10:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF8121A08
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 10:01:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF8121A08
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753724AbeGGKBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 06:01:54 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46010 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753567AbeGGKBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 06:01:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6A5680D;
        Sat,  7 Jul 2018 03:01:52 -0700 (PDT)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF5A53F5AD;
        Sat,  7 Jul 2018 03:01:51 -0700 (PDT)
Date:   Sat, 7 Jul 2018 11:01:47 +0100
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Bo Yan <byan@nvidia.com>
Cc:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] irqchip/gic: check return value of
 of_address_to_resource
Message-ID: <20180707110147.64905726@why.wild-wind.fr.eu.org>
In-Reply-To: <c892593d-8824-e6c5-b435-0902fd0e7fde@nvidia.com>
References: <1530814859-11610-1-git-send-email-byan@nvidia.com>
        <20180705201327.4a4dc7dd@why.wild-wind.fr.eu.org>
        <5548bdf4-4e4f-a2e1-b194-da35da87e3d3@nvidia.com>
        <c892593d-8824-e6c5-b435-0902fd0e7fde@nvidia.com>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jul 2018 12:32:22 -0700
Bo Yan <byan@nvidia.com> wrote:

> Marc,
> 
> Sorry for the previous reply. My email settings were not correct, so it inserted those confidentiality text, which was not what I intended.
> 
> This is what I think:
> 
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index ced10c4..0b60bb0 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -1284,7 +1284,7 @@ static bool gic_check_eoimode(struct device_node *node, void __iomem **base)
>   {
>          struct resource cpuif_res;
> 
> -       of_address_to_resource(node, 1, &cpuif_res);
> +       (void)of_address_to_resource(node, 1, &cpuif_res);
> 
>          if (!is_hyp_mode_available())
>                  return false;
> 
> We are 100% sure of_address_to_resource will succeed in this particular case, so "(void)" will help suppress Coverity warning.

In all honesty. I don't see the point of patching the kernel to silence
a warning when we know that this is a false positive. I'm sure you can
flag that one as "false positive" in Coverity.

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
