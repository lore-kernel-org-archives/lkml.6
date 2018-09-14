Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46554ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C6120861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9C6120861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbeINW3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 18:29:36 -0400
Received: from foss.arm.com ([217.140.101.70]:36922 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbeINW3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 18:29:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B93A80D;
        Fri, 14 Sep 2018 10:14:12 -0700 (PDT)
Received: from [192.168.100.242] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BFE83F575;
        Fri, 14 Sep 2018 10:14:12 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] drivers: base: cacheinfo: Do not populate sysfs
 for unknown cache types
To:     Jeffrey Hugo <jhugo@codeaurora.org>, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        linux-acpi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vkilari@codeaurora.org
References: <1536942489-4018-1-git-send-email-jhugo@codeaurora.org>
 <1536942489-4018-2-git-send-email-jhugo@codeaurora.org>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <3e842dd3-9b92-c56b-c45a-72d99b37f946@arm.com>
Date:   Fri, 14 Sep 2018 12:14:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1536942489-4018-2-git-send-email-jhugo@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09/14/2018 11:28 AM, Jeffrey Hugo wrote:
> If a cache has an unknown type because neither the hardware nor the
> firmware told us, an entry in the sysfs tree will be made, but the type
> file will not be present.  lscpu depends on the type file being present
> for every entry, and will error out without printing system information
> if lscpu cannot open the type file.
> 
> Presenting information about a cache without indicating its type is not
> useful, therefore if we hit a cache with an unknown type, stop populating
> sysfs so that userspace has the maximum amount of useful information.
> 
> This addresses the following lscpu error, which prevents any output.
> lscpu: cannot open /sys/devices/system/cpu/cpu0/cache/index3/type: No such
> file or directory
> 
> Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---
>   drivers/base/cacheinfo.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> index 5d5b598..cf78fa6 100644
> --- a/drivers/base/cacheinfo.c
> +++ b/drivers/base/cacheinfo.c
> @@ -615,6 +615,8 @@ static int cache_add_dev(unsigned int cpu)
>   		this_leaf = this_cpu_ci->info_list + i;
>   		if (this_leaf->disable_sysfs)
>   			continue;
> +		if (this_leaf->type == CACHE_TYPE_NOCACHE)
> +			break;
>   		cache_groups = cache_get_attribute_groups(this_leaf);
>   		ci_dev = cpu_device_create(parent, this_leaf, cache_groups,
>   					   "index%1u", i);
> 

Looks fine to me:

Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>


Thanks,
