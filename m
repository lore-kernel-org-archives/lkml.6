Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB24C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C4B20894
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62C4B20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbeH1UzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 16:55:21 -0400
Received: from foss.arm.com ([217.140.101.70]:42606 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbeH1UzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 16:55:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 902FD80D;
        Tue, 28 Aug 2018 10:02:47 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 61D253F5BD;
        Tue, 28 Aug 2018 10:02:47 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id EC0161AE311D; Tue, 28 Aug 2018 18:02:58 +0100 (BST)
Date:   Tue, 28 Aug 2018 18:02:58 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] perf: Convert to using %pOFn instead of device_node.name
Message-ID: <20180828170258.GD19825@arm.com>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-38-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828015252.28511-38-robh@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 08:52:39PM -0500, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/perf/arm_pmu_platform.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Cheers, I can queue this up for 4.20. Let me know if you'd rather take it
along with the name pointer removal instead.

Will

> diff --git a/drivers/perf/arm_pmu_platform.c b/drivers/perf/arm_pmu_platform.c
> index 96075cecb0ae..933bd8410fc2 100644
> --- a/drivers/perf/arm_pmu_platform.c
> +++ b/drivers/perf/arm_pmu_platform.c
> @@ -77,14 +77,14 @@ static int pmu_parse_irq_affinity(struct device_node *node, int i)
>  
>  	dn = of_parse_phandle(node, "interrupt-affinity", i);
>  	if (!dn) {
> -		pr_warn("failed to parse interrupt-affinity[%d] for %s\n",
> -			i, node->name);
> +		pr_warn("failed to parse interrupt-affinity[%d] for %pOFn\n",
> +			i, node);
>  		return -EINVAL;
>  	}
>  
>  	cpu = of_cpu_node_to_id(dn);
>  	if (cpu < 0) {
> -		pr_warn("failed to find logical CPU for %s\n", dn->name);
> +		pr_warn("failed to find logical CPU for %pOFn\n", dn);
>  		cpu = nr_cpu_ids;
>  	}
>  
> -- 
> 2.17.1
> 
