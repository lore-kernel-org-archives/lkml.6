Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED38ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EB81206B5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EB81206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbeIQVpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 17:45:13 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33472 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726795AbeIQVpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 17:45:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D76DCED1;
        Mon, 17 Sep 2018 09:17:10 -0700 (PDT)
Received: from [10.4.12.116] (e107155-lin.emea.arm.com [10.4.12.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71AA63F557;
        Mon, 17 Sep 2018 09:17:09 -0700 (PDT)
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        vkilari@codeaurora.org
Subject: Re: [PATCH v2 2/2] ACPI/PPTT: Handle architecturally unknown cache
 types
To:     Jeffrey Hugo <jhugo@codeaurora.org>, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, linux-acpi@vger.kernel.org,
        jeremy.linton@arm.com
References: <1536942489-4018-1-git-send-email-jhugo@codeaurora.org>
 <1536942489-4018-3-git-send-email-jhugo@codeaurora.org>
From:   Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <71208e0e-fba9-ad6c-7578-a53fd1aa3f40@arm.com>
Date:   Mon, 17 Sep 2018 17:17:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536942489-4018-3-git-send-email-jhugo@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/09/18 17:28, Jeffrey Hugo wrote:
> The type of a cache might not be specified by architectural mechanisms (ie
> system registers), but its type might be specified in the PPTT.  In this
> case, we should populate the type of the cache, rather than leave it
> undefined.
> 
> This fixes the issue where the cacheinfo driver will not populate sysfs
> for such caches, resulting in the information missing from utilities like
> lstopo and lscpu, thus degrading the user experience.
> 
> Fixes: 2bd00bcd73e5 (ACPI/PPTT: Add Processor Properties Topology Table parsing)
> Reported-by: Vijaya Kumar K <vkilari@codeaurora.org>
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---
>  drivers/acpi/pptt.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index d1e26cb..bb00ed9 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -402,11 +402,18 @@ static void update_cache_properties(struct cacheinfo *this_leaf,
>  		}
>  	}
>  	/*
> -	 * If the above flags are valid, and the cache type is NOCACHE
> -	 * update the cache type as well.
> +	 * If cache type is NOCACHE, then the cache hasn't been specified
> +	 * via other mechanisms.  Update the type if either the cache has
> +	 * been fully specified in PPTT, or a cache type has been provided.
> +	 *
> +	 * Note, we assume such caches are unified based on conventional system
> +	 * design and known examples.  Significant work is required elsewhere to
> +	 * fully support data/instruction only type caches which are only
> +	 * specified in PPTT.
>  	 */
> -	if (this_leaf->type == CACHE_TYPE_NOCACHE &&
> -	    valid_flags == PPTT_CHECKED_ATTRIBUTES)
> +	if ((this_leaf->type == CACHE_TYPE_NOCACHE) &&
> +	    (valid_flags == PPTT_CHECKED_ATTRIBUTES ||
> +	     found_cache->flags & ACPI_PPTT_CACHE_TYPE_VALID))
>  		this_leaf->type = CACHE_TYPE_UNIFIED;

I thought I did mention that we can drop the valid_flags altogether
unless Jeremy has reasons not to.

-- 
Regards,
Sudeep
