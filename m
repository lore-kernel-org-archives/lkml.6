Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA36C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E417206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:16:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E417206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbeILBRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 21:17:41 -0400
Received: from foss.arm.com ([217.140.101.70]:48822 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbeILBRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 21:17:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A7F27A9;
        Tue, 11 Sep 2018 13:16:45 -0700 (PDT)
Received: from [192.168.100.242] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6D213F575;
        Tue, 11 Sep 2018 13:16:44 -0700 (PDT)
Subject: Re: [PATCH] ACPI/PPTT: Handle architecturally unknown cache types
To:     Jeffrey Hugo <jhugo@codeaurora.org>, rjw@rjwysocki.net,
        linux-acpi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vkilari@codeaurora.org,
        Sudeep Holla <sudeep.holla@arm.com>
References: <1536694334-5811-1-git-send-email-jhugo@codeaurora.org>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <f62f22a6-2dd8-f254-dbaf-b9e224099afd@arm.com>
Date:   Tue, 11 Sep 2018 15:16:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1536694334-5811-1-git-send-email-jhugo@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeffrey,

(+Sudeep)

On 09/11/2018 02:32 PM, Jeffrey Hugo wrote:
> The type of a cache might not be specified by architectural mechanisms (ie
> system registers), but its type might be specified in the PPTT.  In this
> case, following the PPTT specification, we should identify the cache as
> the type specified by PPTT.
> 
> This fixes the following lscpu issue where only the cache type sysfs file
> is missing which results in no output providing a poor user experience in
> the above system configuration-
> lscpu: cannot open /sys/devices/system/cpu/cpu0/cache/index3/type: No such
> file or directory
> 
> Fixes: 2bd00bcd73e5 (ACPI/PPTT: Add Processor Properties Topology Table parsing)
> Reported-by: Vijaya Kumar K <vkilari@codeaurora.org>
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---
>   drivers/acpi/pptt.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index d1e26cb..3c6db09 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -401,6 +401,21 @@ static void update_cache_properties(struct cacheinfo *this_leaf,
>   			break;
>   		}
>   	}
> +	if ((this_leaf->type == CACHE_TYPE_NOCACHE) &&
> +	    (found_cache->flags & ACPI_PPTT_CACHE_TYPE_VALID)) {
> +		switch (found_cache->attributes & ACPI_PPTT_MASK_CACHE_TYPE) {
> +		case ACPI_PPTT_CACHE_TYPE_DATA:
> +			this_leaf->type = CACHE_TYPE_DATA;
> +			break;
> +		case ACPI_PPTT_CACHE_TYPE_INSTR:
> +			this_leaf->type = CACHE_TYPE_INST;
> +			break;
> +		case ACPI_PPTT_CACHE_TYPE_UNIFIED:
> +		case ACPI_PPTT_CACHE_TYPE_UNIFIED_ALT:
> +			this_leaf->type = CACHE_TYPE_UNIFIED;
> +			break;
> +		}
> +	}
>   	/*
>   	 * If the above flags are valid, and the cache type is NOCACHE
>   	 * update the cache type as well.
> 

If you look at the next line of code following this comment its going to 
update the cache type for fully populated PPTT nodes. Although with the 
suggested change its only going to activate if someone completely fills 
out the node and fails to set the valid flag on the cache type.

What I suspect is happening in the reported case is that the nodes in 
the PPTT table are missing fields we consider to be important. Since 
that data isn't being filled out anywhere else, so we leave the cache 
type alone too. This has the effect of hiding sysfs nodes with 
incomplete information.

Also, the lack of the DATA/INST fields is based on the assumption that 
the only nodes which need their type field updated are outside of the 
CPU core itself so they are pretty much guaranteed to be UNIFIED. Are 
you hitting this case?


Thanks,
