Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB38C282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 171D1218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfAYTH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 14:07:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57012 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbfAYTHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 14:07:21 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6C8A91B98;
        Fri, 25 Jan 2019 19:07:21 +0000 (UTC)
Received: from redhat.com (ovpn-122-28.rdu2.redhat.com [10.10.122.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6238F17D93;
        Fri, 25 Jan 2019 19:07:19 +0000 (UTC)
Date:   Fri, 25 Jan 2019 14:07:17 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, zwisler@kernel.org, vishal.l.verma@intel.com,
        thomas.lendacky@amd.com, akpm@linux-foundation.org,
        mhocko@suse.com, linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        ying.huang@intel.com, fengguang.wu@intel.com
Subject: Re: [PATCH 2/5] mm/resource: move HMM pr_debug() deeper into
 resource code
Message-ID: <20190125190716.GB3237@redhat.com>
References: <20190124231441.37A4A305@viggo.jf.intel.com>
 <20190124231444.38182DD8@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124231444.38182DD8@viggo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 25 Jan 2019 19:07:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 03:14:44PM -0800, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> HMM consumes physical address space for its own use, even
> though nothing is mapped or accessible there.  It uses a
> special resource description (IORES_DESC_DEVICE_PRIVATE_MEMORY)
> to uniquely identify these areas.
> 
> When HMM consumes address space, it makes a best guess about
> what to consume.  However, it is possible that a future memory
> or device hotplug can collide with the reserved area.  In the
> case of these conflicts, there is an error message in
> register_memory_resource().
> 
> Later patches in this series move register_memory_resource()
> from using request_resource_conflict() to __request_region().
> Unfortunately, __request_region() does not return the conflict
> like the previous function did, which makes it impossible to
> check for IORES_DESC_DEVICE_PRIVATE_MEMORY in a conflicting
> resource.
> 
> Instead of warning in register_memory_resource(), move the
> check into the core resource code itself (__request_region())
> where the conflicting resource _is_ available.  This has the
> added bonus of producing a warning in case of HMM conflicts
> with devices *or* RAM address space, as opposed to the RAM-
> only warnings that were there previously.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ross Zwisler <zwisler@kernel.org>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: linux-nvdimm@lists.01.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Fengguang Wu <fengguang.wu@intel.com>

Reviewed-by: Jerome Glisse <jglisse@redhat.com>

> ---
> 
>  b/kernel/resource.c   |   10 ++++++++++
>  b/mm/memory_hotplug.c |    5 -----
>  2 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff -puN kernel/resource.c~move-request_region-check kernel/resource.c
> --- a/kernel/resource.c~move-request_region-check	2019-01-24 15:13:14.453199539 -0800
> +++ b/kernel/resource.c	2019-01-24 15:13:14.458199539 -0800
> @@ -1123,6 +1123,16 @@ struct resource * __request_region(struc
>  		conflict = __request_resource(parent, res);
>  		if (!conflict)
>  			break;
> +		/*
> +		 * mm/hmm.c reserves physical addresses which then
> +		 * become unavailable to other users.  Conflicts are
> +		 * not expected.  Be verbose if one is encountered.
> +		 */
> +		if (conflict->desc == IORES_DESC_DEVICE_PRIVATE_MEMORY) {
> +			pr_debug("Resource conflict with unaddressable "
> +				 "device memory at %#010llx !\n",
> +				 (unsigned long long)start);
> +		}
>  		if (conflict != parent) {
>  			if (!(conflict->flags & IORESOURCE_BUSY)) {
>  				parent = conflict;
> diff -puN mm/memory_hotplug.c~move-request_region-check mm/memory_hotplug.c
> --- a/mm/memory_hotplug.c~move-request_region-check	2019-01-24 15:13:14.455199539 -0800
> +++ b/mm/memory_hotplug.c	2019-01-24 15:13:14.459199539 -0800
> @@ -109,11 +109,6 @@ static struct resource *register_memory_
>  	res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
>  	conflict =  request_resource_conflict(&iomem_resource, res);
>  	if (conflict) {
> -		if (conflict->desc == IORES_DESC_DEVICE_PRIVATE_MEMORY) {
> -			pr_debug("Device unaddressable memory block "
> -				 "memory hotplug at %#010llx !\n",
> -				 (unsigned long long)start);
> -		}
>  		pr_debug("System RAM resource %pR cannot be added\n", res);
>  		kfree(res);
>  		return ERR_PTR(-EEXIST);
> _
