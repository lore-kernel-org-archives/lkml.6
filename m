Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB6BC004D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE474206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE474206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbeI2ER4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:17:56 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56244 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727234AbeI2ERz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:17:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34B9D18A;
        Fri, 28 Sep 2018 14:52:14 -0700 (PDT)
Received: from [192.168.100.242] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B625B3F5B3;
        Fri, 28 Sep 2018 14:52:13 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] ACPI/PPTT: Handle architecturally unknown cache
 types
To:     Jeffrey Hugo <jhugo@codeaurora.org>, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        linux-acpi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vkilari@codeaurora.org
References: <1538103477-15513-1-git-send-email-jhugo@codeaurora.org>
 <1538103477-15513-3-git-send-email-jhugo@codeaurora.org>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <377f840c-6c4f-9a17-7aa5-cc2fa4f7b244@arm.com>
Date:   Fri, 28 Sep 2018 16:52:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1538103477-15513-3-git-send-email-jhugo@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09/27/2018 09:57 PM, Jeffrey Hugo wrote:
> The type of a cache might not be specified by architectural mechanisms (ie
> system registers), but its type might be specified in the PPTT.  In this
> case, we should populate the type of the cache, rather than leave it
> undefined. 
> 
> This fixes the issue where the cacheinfo driver will not populate sysfs
> for such caches, resulting in the information missing from utilities like
> lstopo and lscpu, thus degrading the user experience.

The code looks fine to me.

Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>

Thanks!

> 
> Fixes: 2bd00bcd73e5 (ACPI/PPTT: Add Processor Properties Topology Table parsing)
> Reported-by: Vijaya Kumar K <vkilari@codeaurora.org>

PS:

Although, if you end up re-spinning this, I think its appropriate to add 
in the commit message that what this is really working around is 
firmware that has declined to fill out all the fields in the cache 
description.


> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---
>   drivers/acpi/pptt.c | 30 +++++++++++++-----------------
>   1 file changed, 13 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index d1e26cb..38ac30e 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -357,25 +357,15 @@ static void update_cache_properties(struct cacheinfo *this_leaf,
>   				    struct acpi_pptt_cache *found_cache,
>   				    struct acpi_pptt_processor *cpu_node)
>   {
> -	int valid_flags = 0;
> -
>   	this_leaf->fw_token = cpu_node;
> -	if (found_cache->flags & ACPI_PPTT_SIZE_PROPERTY_VALID) {
> +	if (found_cache->flags & ACPI_PPTT_SIZE_PROPERTY_VALID)
>   		this_leaf->size = found_cache->size;
> -		valid_flags++;
> -	}
> -	if (found_cache->flags & ACPI_PPTT_LINE_SIZE_VALID) {
> +	if (found_cache->flags & ACPI_PPTT_LINE_SIZE_VALID)
>   		this_leaf->coherency_line_size = found_cache->line_size;
> -		valid_flags++;
> -	}
> -	if (found_cache->flags & ACPI_PPTT_NUMBER_OF_SETS_VALID) {
> +	if (found_cache->flags & ACPI_PPTT_NUMBER_OF_SETS_VALID)
>   		this_leaf->number_of_sets = found_cache->number_of_sets;
> -		valid_flags++;
> -	}
> -	if (found_cache->flags & ACPI_PPTT_ASSOCIATIVITY_VALID) {
> +	if (found_cache->flags & ACPI_PPTT_ASSOCIATIVITY_VALID)
>   		this_leaf->ways_of_associativity = found_cache->associativity;
> -		valid_flags++;
> -	}
>   	if (found_cache->flags & ACPI_PPTT_WRITE_POLICY_VALID) {
>   		switch (found_cache->attributes & ACPI_PPTT_MASK_WRITE_POLICY) {
>   		case ACPI_PPTT_CACHE_POLICY_WT:
> @@ -402,11 +392,17 @@ static void update_cache_properties(struct cacheinfo *this_leaf,
>   		}
>   	}
>   	/*
> -	 * If the above flags are valid, and the cache type is NOCACHE
> -	 * update the cache type as well.
> +	 * If cache type is NOCACHE, then the cache hasn't been specified
> +	 * via other mechanisms.  Update the type if a cache type has been
> +	 * provided.
> +	 *
> +	 * Note, we assume such caches are unified based on conventional system
> +	 * design and known examples.  Significant work is required elsewhere to
> +	 * fully support data/instruction only type caches which are only
> +	 * specified in PPTT.
>   	 */
>   	if (this_leaf->type == CACHE_TYPE_NOCACHE &&
> -	    valid_flags == PPTT_CHECKED_ATTRIBUTES)
> +	    found_cache->flags & ACPI_PPTT_CACHE_TYPE_VALID)
>   		this_leaf->type = CACHE_TYPE_UNIFIED;
>   }
>   
> 

