Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222AEC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B6D21582
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iAMi7lWA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZXrHMDHf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6B6D21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeI0O2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 10:28:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58968 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbeI0O2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 10:28:48 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 353CB60BF5; Thu, 27 Sep 2018 08:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538035907;
        bh=YdKP1LfME2hoioR+eYsigXAyOOK8KuacZFl2Y/0pMAw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iAMi7lWALA7JWRmT1t/rfgzsaElwD4Exds5OgnQNjmgq3GZfpPjqs9riMjZmDLSjZ
         3NBYBEV3i0tQAxgmYUQhE+9gab5Es3Us5QwVG6svWcLl8u/qwhY6lgYtTag159ecVk
         03RSGS4ULsylTRXYnRkldvNAf+V7zigQiiJkAh9w=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 869E0607C6;
        Thu, 27 Sep 2018 08:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538035905;
        bh=YdKP1LfME2hoioR+eYsigXAyOOK8KuacZFl2Y/0pMAw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZXrHMDHffIAuhRYGG5jFbKVPbULWXRTzXQTUmFph+vWIqR4jJfFAsiA2YNVwF2A5U
         9NXaNwodM/MEGsoDOxJJBqg7gS/KvaXN1BzgFjWn3r8ieWts/HcLVxe4q2D7FamuX7
         HuqJvejtA/4ob6c1AU6A8SWui+lDlfIJ90YksAL4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 27 Sep 2018 13:41:45 +0530
From:   Arun KS <arunks@codeaurora.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        boris.ostrovsky@oracle.com, akpm@linux-foundation.org,
        dan.j.williams@intel.com, mhocko@suse.com, vbabka@suse.cz,
        iamjoonsoo.kim@lge.com, gregkh@linuxfoundation.org,
        osalvador@suse.de, malat@debian.org,
        kirill.shutemov@linux.intel.com, jrdr.linux@gmail.com,
        yasu.isimatu@gmail.com, mgorman@techsingularity.net,
        aaron.lu@intel.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, vatsa@codeaurora.org,
        vinmenon@codeaurora.org, getarunks@gmail.com
Subject: Re: [PATCH v3] memory_hotplug: Free pages as higher order
In-Reply-To: <36488c0e-6bae-e277-2cdb-32d0dcc40065@suse.com>
References: <1538031530-25489-1-git-send-email-arunks@codeaurora.org>
 <36488c0e-6bae-e277-2cdb-32d0dcc40065@suse.com>
Message-ID: <21949851c3b2c82853588101f39f1207@codeaurora.org>
X-Sender: arunks@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-27 12:41, Juergen Gross wrote:
> On 27/09/18 08:58, Arun KS wrote:
>> When free pages are done with higher order, time spend on
>> coalescing pages by buddy allocator can be reduced. With
>> section size of 256MB, hot add latency of a single section
>> shows improvement from 50-60 ms to less than 1 ms, hence
>> improving the hot add latency by 60%.
>> 
>> Modify external providers of online callback to align with
>> the change.
>> 
>> Signed-off-by: Arun KS <arunks@codeaurora.org>
>> ---
>> Changes since v2:
>> reuse code from __free_pages_boot_core()
>> 
>> Changes since v1:
>> - Removed prefetch()
>> 
>> Changes since RFC:
>> - Rebase.
>> - As suggested by Michal Hocko remove pages_per_block.
>> - Modifed external providers of online_page_callback.
>> 
>> v2: https://lore.kernel.org/patchwork/patch/991363/
>> v1: https://lore.kernel.org/patchwork/patch/989445/
>> RFC: https://lore.kernel.org/patchwork/patch/984754/
>> 
>> ---
>>  drivers/hv/hv_balloon.c        |  6 ++++--
>>  drivers/xen/balloon.c          | 18 ++++++++++++++---
>>  include/linux/memory_hotplug.h |  2 +-
>>  mm/internal.h                  |  1 +
>>  mm/memory_hotplug.c            | 44 
>> ++++++++++++++++++++++++++++++------------
>>  mm/page_alloc.c                |  2 +-
>>  6 files changed, 54 insertions(+), 19 deletions(-)
>> 
> 
> ...
> 
>> diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
>> index e12bb25..010cf4d 100644
>> --- a/drivers/xen/balloon.c
>> +++ b/drivers/xen/balloon.c
>> @@ -390,8 +390,8 @@ static enum bp_state 
>> reserve_additional_memory(void)
>> 
>>  	/*
>>  	 * add_memory_resource() will call online_pages() which in its turn
>> -	 * will call xen_online_page() callback causing deadlock if we don't
>> -	 * release balloon_mutex here. Unlocking here is safe because the
>> +	 * will call xen_bring_pgs_online() callback causing deadlock if we
>> +	 * don't release balloon_mutex here. Unlocking here is safe because 
>> the
>>  	 * callers drop the mutex before trying again.
>>  	 */
>>  	mutex_unlock(&balloon_mutex);
>> @@ -422,6 +422,18 @@ static void xen_online_page(struct page *page)
>>  	mutex_unlock(&balloon_mutex);
>>  }
>> 
>> +static int xen_bring_pgs_online(struct page *pg, unsigned int order)
>> +{
>> +	unsigned long i, size = (1 << order);
>> +	unsigned long start_pfn = page_to_pfn(pg);
>> +
>> +	pr_debug("Online %lu pages starting at pfn 0x%lx\n", size, 
>> start_pfn);
>> +	for (i = 0; i < size; i++)
>> +		xen_online_page(pfn_to_page(start_pfn + i));
> 

Hi,

> xen_online_page() isn't very complex and this is the only user.
> 
> Why don't you move its body in here and drop the extra function?
> And now you can execute the loop with balloon_mutex held instead of
> taking and releasing it in each iteration of the loop.
Point taken. Will incorporate them.

Regards,
Arun
> 
> 
> Juergen
