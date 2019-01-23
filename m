Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342D2C282C5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0234821855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548263125;
	bh=OmNg+ClXWmRx2IRdzYBMnQ7ZUoaJHZ35h2gI2F41Zzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RQwBEidB2VCFEeTi5eSciEX5MLiAeubpsIZCGxV7orBi+mPDJW0oaMJOd4/wHky42
	 gRRM4YzN4EqIdkw87I/e3+QZCAbAlXWgj81GBB5DK0ZcHOnAk4CJWJUL8u/284/PdS
	 2JR9ltPOpjA13C4uZ4rFRcFtejq72uo3Ji0o5jc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfAWRFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:05:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:60416 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725996AbfAWRFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 12:05:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A9832B06E;
        Wed, 23 Jan 2019 17:05:20 +0000 (UTC)
Date:   Wed, 23 Jan 2019 18:05:18 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     dave@sr71.net, dan.j.williams@intel.com, dave.jiang@intel.com,
        zwisler@kernel.org, vishal.l.verma@intel.com,
        thomas.lendacky@amd.com, akpm@linux-foundation.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ying.huang@intel.com, fengguang.wu@intel.com,
        bp@suse.de, bhelgaas@google.com, baiyaowei@cmss.chinamobile.com,
        tiwai@suse.de
Subject: Re: [PATCH 2/4] mm/memory-hotplug: allow memory resources to be
 children
Message-ID: <20190123170518.GC4087@dhcp22.suse.cz>
References: <20190116181859.D1504459@viggo.jf.intel.com>
 <20190116181902.670EEBC3@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116181902.670EEBC3@viggo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Sorry for a late reply]

On Wed 16-01-19 10:19:02, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> The mm/resource.c code is used to manage the physical address
> space.  We can view the current resource configuration in
> /proc/iomem.  An example of this is at the bottom of this
> description.
> 
> The nvdimm subsystem "owns" the physical address resources which
> map to persistent memory and has resources inserted for them as
> "Persistent Memory".  We want to use this persistent memory, but
> as volatile memory, just like RAM.  The best way to do this is
> to leave the existing resource in place, but add a "System RAM"
> resource underneath it. This clearly communicates the ownership
> relationship of this memory.
> 
> The request_resource_conflict() API only deals with the
> top-level resources.  Replace it with __request_region() which
> will search for !IORESOURCE_BUSY areas lower in the resource
> tree than the top level.
> 
> We also rework the old error message a bit since we do not get
> the conflicting entry back: only an indication that we *had* a
> conflict.
> 
> We *could* also simply truncate the existing top-level
> "Persistent Memory" resource and take over the released address
> space.  But, this means that if we ever decide to hot-unplug the
> "RAM" and give it back, we need to recreate the original setup,
> which may mean going back to the BIOS tables.
> 
> This should have no real effect on the existing collision
> detection because the areas that truly conflict should be marked
> IORESOURCE_BUSY.
> 
> 00000000-00000fff : Reserved
> 00001000-0009fbff : System RAM
> 0009fc00-0009ffff : Reserved
> 000a0000-000bffff : PCI Bus 0000:00
> 000c0000-000c97ff : Video ROM
> 000c9800-000ca5ff : Adapter ROM
> 000f0000-000fffff : Reserved
>   000f0000-000fffff : System ROM
> 00100000-9fffffff : System RAM
>   01000000-01e071d0 : Kernel code
>   01e071d1-027dfdff : Kernel data
>   02dc6000-0305dfff : Kernel bss
> a0000000-afffffff : Persistent Memory (legacy)
>   a0000000-a7ffffff : System RAM
> b0000000-bffdffff : System RAM
> bffe0000-bfffffff : Reserved
> c0000000-febfffff : PCI Bus 0000:00

This is the only memory hotplug related change in this series AFAICS.
Unfortunately I am not really familiar with guts for resources
infrastructure so I cannot judge the correctness. The change looks
sensible to me although I do not feel like acking it.

Overall design of this feature makes a lot of sense to me. It doesn't
really add any weird APIs yet it allows to use nvdimms as a memory
transparently. All future policies are to be defined by the userspace
and I like that. I was especially astonished by the sheer size of the
driver and changes it required to achieve that. Really nice!

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
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> ---
> 
>  b/mm/memory_hotplug.c |   31 ++++++++++++++-----------------
>  1 file changed, 14 insertions(+), 17 deletions(-)
> 
> diff -puN mm/memory_hotplug.c~mm-memory-hotplug-allow-memory-resource-to-be-child mm/memory_hotplug.c
> --- a/mm/memory_hotplug.c~mm-memory-hotplug-allow-memory-resource-to-be-child	2018-12-20 11:48:42.317771933 -0800
> +++ b/mm/memory_hotplug.c	2018-12-20 11:48:42.322771933 -0800
> @@ -98,24 +98,21 @@ void mem_hotplug_done(void)
>  /* add this memory to iomem resource */
>  static struct resource *register_memory_resource(u64 start, u64 size)
>  {
> -	struct resource *res, *conflict;
> -	res = kzalloc(sizeof(struct resource), GFP_KERNEL);
> -	if (!res)
> -		return ERR_PTR(-ENOMEM);
> +	struct resource *res;
> +	unsigned long flags =  IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> +	char *resource_name = "System RAM";
>  
> -	res->name = "System RAM";
> -	res->start = start;
> -	res->end = start + size - 1;
> -	res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> -	conflict =  request_resource_conflict(&iomem_resource, res);
> -	if (conflict) {
> -		if (conflict->desc == IORES_DESC_DEVICE_PRIVATE_MEMORY) {
> -			pr_debug("Device unaddressable memory block "
> -				 "memory hotplug at %#010llx !\n",
> -				 (unsigned long long)start);
> -		}
> -		pr_debug("System RAM resource %pR cannot be added\n", res);
> -		kfree(res);
> +	/*
> +	 * Request ownership of the new memory range.  This might be
> +	 * a child of an existing resource that was present but
> +	 * not marked as busy.
> +	 */
> +	res = __request_region(&iomem_resource, start, size,
> +			       resource_name, flags);
> +
> +	if (!res) {
> +		pr_debug("Unable to reserve System RAM region: %016llx->%016llx\n",
> +				start, start + size);
>  		return ERR_PTR(-EEXIST);
>  	}
>  	return res;
> _

-- 
Michal Hocko
SUSE Labs
