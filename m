Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F512C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5107F20673
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5107F20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbeLAFl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:41:26 -0500
Received: from foss.arm.com ([217.140.101.70]:34504 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbeLAFlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:41:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EA23165C;
        Fri, 30 Nov 2018 10:31:16 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74F533F575;
        Fri, 30 Nov 2018 10:31:15 -0800 (PST)
Subject: Re: [PATCH] firmware: arm_sdei: fix wrong of_node_put() in init
 function
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181126121536.28739-1-nsaenzjulienne@suse.de>
From:   James Morse <james.morse@arm.com>
Message-ID: <08d6b9e6-7aa0-9342-193b-1ce6e0417f77@arm.com>
Date:   Fri, 30 Nov 2018 18:31:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181126121536.28739-1-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On 26/11/2018 12:15, Nicolas Saenz Julienne wrote:
> After finding a "firmware" dt node arm_sdei tries to match it's
> compatible string with it. To do so it's calling of_find_matching_node()
> which already takes care of decreasing the refcount on the "firmware"
> node. We are then incorrectly decreasing the refcount on that node
> again.
> 
> This patch removes the unwarranted call to of_node_put().
> 
> Fixes: ad6eb31ef903 ("firmware: arm_sdei: Add driver for Software Delegated Exceptions")
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>


Thanks!, I agree this is unwarranted.
Is there a tool that picks these up? I remember sparse giving me a headache, but
I don't remember this one... I probably cargo-culted it from somewhere else.

Acked-by: James Morse <james.morse@arm.com>


Thanks,

James


> ---
>  drivers/firmware/arm_sdei.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
> index 1ea71640fdc2..dffb47c6b480 100644
> --- a/drivers/firmware/arm_sdei.c
> +++ b/drivers/firmware/arm_sdei.c
> @@ -1017,7 +1017,6 @@ static bool __init sdei_present_dt(void)
>  		return false;
>  
>  	np = of_find_matching_node(fw_np, sdei_of_match);
> -	of_node_put(fw_np);
>  	if (!np)
>  		return false;
>  
> 

