Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752722AbeB1N1O (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 08:27:14 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:52106 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752619AbeB1N1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 08:27:13 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DB2E9602BA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
Subject: Re: [PATCH v3] of: cache phandle nodes to reduce cost of
 of_find_node_by_phandle()
To: frowand.list@gmail.com, Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1518655979-10910-1-git-send-email-frowand.list@gmail.com>
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <ab87b605-6ec4-0b65-89ff-6232c89cb75f@codeaurora.org>
Date: Wed, 28 Feb 2018 18:57:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518655979-10910-1-git-send-email-frowand.list@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/15/2018 6:22 AM, frowand.list@gmail.com wrote:

> +static void of_populate_phandle_cache(void)
> +{
> +	unsigned long flags;
> +	u32 cache_entries;
> +	struct device_node *np;
> +	u32 phandles = 0;
> +
> +	raw_spin_lock_irqsave(&devtree_lock, flags);
> +
> +	kfree(phandle_cache);
> +	phandle_cache = NULL;
> +
> +	for_each_of_allnodes(np)
> +		if (np->phandle && np->phandle != OF_PHANDLE_ILLEGAL)
> +			phandles++;
> +
> +	cache_entries = roundup_pow_of_two(phandles);
> +	phandle_cache_mask = cache_entries - 1;
> +
> +	phandle_cache = kcalloc(cache_entries, sizeof(*phandle_cache),
> +				GFP_ATOMIC);
> +

NULL check of phandle_cache would be good to have.

> +	for_each_of_allnodes(np)
> +		if (np->phandle && np->phandle != OF_PHANDLE_ILLEGAL)
> +			phandle_cache[np->phandle & phandle_cache_mask] = np;
> +
> +	raw_spin_unlock_irqrestore(&devtree_lock, flags);
> +}


Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
