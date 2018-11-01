Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C8DC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF86C2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF86C2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbeKAULS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 16:11:18 -0400
Received: from ozlabs.org ([203.11.71.1]:58931 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbeKAULS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 16:11:18 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42m2Wg2yDmzB4N0;
        Thu,  1 Nov 2018 22:08:47 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH] of: Fix cpu node iterator to not ignore disabled cpu nodes
In-Reply-To: <20181031144226.26747-1-robh@kernel.org>
References: <20181031144226.26747-1-robh@kernel.org>
Date:   Thu, 01 Nov 2018 22:08:46 +1100
Message-ID: <87o9b9dphd.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> writes:

> In most cases, nodes with 'status = "disabled";' are treated as if the
> node is not present though it is a common bug to forget to check that.
> However, cpu nodes are different in that "disabled" simply means offline
> and the OS can bring the CPU core online. Commit f1f207e43b8a ("of: Add
> cpu node iterator for_each_of_cpu_node()") followed the common behavior
> of ignoring disabled cpu nodes. This breaks some powerpc systems (at
> least NXP P50XX/e5500). Fix this by dropping the status check.
>
> Fixes: 651d44f9679c ("of: use for_each_of_cpu_node iterator")
> Fixes: f1f207e43b8a ("of: Add cpu node iterator for_each_of_cpu_node()")
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Christian Zigotzky <chzigotzky@xenosoft.de>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/of/base.c | 2 --
>  1 file changed, 2 deletions(-)

This fixes my machine, thanks.

Tested-by: Michael Ellerman <mpe@ellerman.id.au>

It was actually originally reported to me by Christian, so also:

Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>


cheers

> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index cc62da278663..e47c5ce6cd58 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -776,8 +776,6 @@ struct device_node *of_get_next_cpu_node(struct device_node *prev)
>  		if (!(of_node_name_eq(next, "cpu") ||
>  		      (next->type && !of_node_cmp(next->type, "cpu"))))
>  			continue;
> -		if (!__of_device_is_available(next))
> -			continue;
>  		if (of_node_get(next))
>  			break;
>  	}
> -- 
> 2.19.1
