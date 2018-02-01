Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751581AbeBAGpp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 01:45:45 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:39222 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751119AbeBAGpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 01:45:43 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 98C726076A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
Subject: Re: [PATCH] of: cache phandle nodes to decrease cost of
 of_find_node_by_phandle()
To: frowand.list@gmail.com, Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1517429142-25727-1-git-send-email-frowand.list@gmail.com>
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <5b84a166-c71b-3a41-9e7f-a7624a8441f6@codeaurora.org>
Date: Thu, 1 Feb 2018 12:15:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1517429142-25727-1-git-send-email-frowand.list@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/1/2018 1:35 AM, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>

> +
> +static void of_populate_phandle_cache(void)
> +{
> +	unsigned long flags;
> +	phandle max_phandle;
> +	u32 nodes = 0;
> +	struct device_node *np;
> +
> +	if (phandle_cache)
> +		return;
> +
> +	max_phandle = live_tree_max_phandle();
> +
> +	raw_spin_lock_irqsave(&devtree_lock, flags);
> +
> +	for_each_of_allnodes(np)
> +		nodes++;
> +
> +	/* sanity cap for malformed tree */
> +	if (max_phandle > nodes)
> +		max_phandle = nodes;
Shouldn't we speak up about this in kernel log ? May be WARN_ON() ?

> +
> +	phandle_cache = kzalloc((max_phandle + 1) * sizeof(*phandle_cache),
> +				GFP_KERNEL);
kzalloc (might_sleep) in critical context will break.

Anyways, will fix this locally and share test results.

Thanks,
Chintan

-- 
Qualcom India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
