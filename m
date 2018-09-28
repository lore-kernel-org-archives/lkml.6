Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8F8C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A2F2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40A2F2168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbeI1UMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:12:12 -0400
Received: from foss.arm.com ([217.140.101.70]:50528 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbeI1UMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:12:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89389ED1;
        Fri, 28 Sep 2018 06:48:19 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACF363F5B7;
        Fri, 28 Sep 2018 06:48:17 -0700 (PDT)
Date:   Fri, 28 Sep 2018 14:48:15 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh@kernel.org>, Doug Berger <opendmb@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] ARM: psci: Fix secondary core boot with THUMB2_KERNEL
Message-ID: <20180928134814.dlk3xu2plzw4tyu7@lakrids.cambridge.arm.com>
References: <20180927192711.26455-1-f.fainelli@gmail.com>
 <20180927192711.26455-3-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927192711.26455-3-f.fainelli@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 12:27:10PM -0700, Florian Fainelli wrote:
> When THUMB2_KERNEL is enabled, we would be setting the secondary core's
> entry point to secondary_startup() which is already Thumb2 code, utilize
> secondary_startup_arm() which takes care of doing the mode switching for
> us.

As with the first patch, a call to CPU_ON with bit[0] set in the entry
point *should* place the CPU into thumb state, so I'd like to know which
FW you've seen this bug with.

Thanks,
Mark.

> 
> Fixes: 05774088391c ("arm: introduce psci_smp_ops")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/arm/kernel/psci_smp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/kernel/psci_smp.c b/arch/arm/kernel/psci_smp.c
> index cb3fcaeb2233..547a11b065d2 100644
> --- a/arch/arm/kernel/psci_smp.c
> +++ b/arch/arm/kernel/psci_smp.c
> @@ -47,13 +47,13 @@
>   *
>   */
>  
> -extern void secondary_startup(void);
> +extern void secondary_startup_arm(void);
>  
>  static int psci_boot_secondary(unsigned int cpu, struct task_struct *idle)
>  {
>  	if (psci_ops.cpu_on)
>  		return psci_ops.cpu_on(cpu_logical_map(cpu),
> -					virt_to_idmap(&secondary_startup));
> +					virt_to_idmap(&secondary_startup_arm));
>  	return -ENODEV;
>  }
>  
> -- 
> 2.17.1
> 
