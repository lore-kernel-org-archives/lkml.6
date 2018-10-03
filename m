Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED08C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45DEE2089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45DEE2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbeJCQ0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 12:26:18 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41446 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbeJCQ0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 12:26:18 -0400
Received: from 79.184.253.194.ipv4.supernova.orange.pl (79.184.253.194) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id 5dd665ea93433a55; Wed, 3 Oct 2018 11:38:39 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     sudeep.holla@arm.com, gregkh@linuxfoundation.org,
        linux-acpi@vger.kernel.org, jeremy.linton@arm.com,
        linux-kernel@vger.kernel.org, vkilari@codeaurora.org
Subject: Re: [PATCH v3 1/2] drivers: base: cacheinfo: Do not populate sysfs for unknown cache types
Date:   Wed, 03 Oct 2018 11:35:39 +0200
Message-ID: <256435083.TFCBfdESsY@aspire.rjw.lan>
In-Reply-To: <1538103477-15513-2-git-send-email-jhugo@codeaurora.org>
References: <1538103477-15513-1-git-send-email-jhugo@codeaurora.org> <1538103477-15513-2-git-send-email-jhugo@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, September 28, 2018 4:57:56 AM CEST Jeffrey Hugo wrote:
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
> Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  drivers/base/cacheinfo.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> index 5d5b598..cf78fa6 100644
> --- a/drivers/base/cacheinfo.c
> +++ b/drivers/base/cacheinfo.c
> @@ -615,6 +615,8 @@ static int cache_add_dev(unsigned int cpu)
>  		this_leaf = this_cpu_ci->info_list + i;
>  		if (this_leaf->disable_sysfs)
>  			continue;
> +		if (this_leaf->type == CACHE_TYPE_NOCACHE)
> +			break;
>  		cache_groups = cache_get_attribute_groups(this_leaf);
>  		ci_dev = cpu_device_create(parent, this_leaf, cache_groups,
>  					   "index%1u", i);
> 

Can you please resend this patch with all tags collected so far?

Patchwork doesn't seem to have picked it up.

Thanks,
Rafael


