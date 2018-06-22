Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27E7C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 23:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6EF249B2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 23:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yPUg4qeQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6EF249B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754761AbeFVXTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 19:19:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754563AbeFVXTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 19:19:36 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49BBB249AE;
        Fri, 22 Jun 2018 23:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529709575;
        bh=Ova4rQDNMKjSWjGNKkeP4gM0LgGRSVzMnBgRBGuoFm4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yPUg4qeQt6t1bE4KyO1irTu9IXYnHu4njCZSlgshQYmLJD6aOiQuE9+5ynD+5PKl3
         OegjOUCVaxbvCwM6jrRB8mPJ9KRf95e59LWVJLTKehGIEhZHtpl5F29S2tmFP2h5fS
         YtmJ8dMDp1+SD+n/MmEQaUkIG75t9ZbqXIcRas3w=
Date:   Fri, 22 Jun 2018 18:19:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     guomin chen <guomin.chen@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Takashi Iwai <tiwai@suse.de>, Lee Chun-Yi <JLee@suse.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Toshi Kani <toshi.kani@hpe.com>
Subject: Re: [PATCH 1/1] resource: Fixed iomem resource release failed on
 release_mem_region_adjustable() when memory node or cpu node hot-remove.
Message-ID: <20180622231930.GA2834@bhelgaas-glaptop.roam.corp.google.com>
References: <20180622120138.5411-1-guomin.chen@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622120138.5411-1-guomin.chen@suse.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+cc Toshi]

On Fri, Jun 22, 2018 at 08:01:38PM +0800, guomin chen wrote:
> We've got a bug report indicating the hot-remove node resource
> release failed,when the memory on this node is divided into
> several sections.because the release_mem_region_adjustable()
> can only release one resource that must be [start,end].

Can you please include a URL for the bug report?  That's useful for
additional details and gives hints about how future changes in this
area might be tested.

release_mem_region_adjustable() and the only call to it were added
by Toshi (cc'd):

  825f787bb496 ("resource: add release_mem_region_adjustable()")
  fe74ebb106a5 ("mm: change __remove_pages() to call release_mem_region_adjustable()")

> In my case, the BIOS supports faulty memory isolation. if BIOS
> detected bad memory block, the BIOS will isolates this badblock.
> And set this badblock memory to EfiUnusableMemory in EFI memory map
> base on UEFI 2.7 spec.For example in my system, the memory range on
> node2 is [mem 0x0000080000000000-0x00000807ffffffff].but the BIOS
> detected the [8004e000000-8004e0fffff] is a badblock memory.
> So the memory on node2 seem like this:
>    		80000000000-8004dffffff : System RAM
> 		8004e000000-8004e0fffff : Unusable memory
> 		8004e100000-807ffffffff : System RAM
> 
> Now, when offline the cpu node2,the kernel will try to release
> ioresource [mem 0x0000080000000000-0x00000807ffffffff]. at this
> time, the kernel will release failed,and output error message:
> "Unable to release resource <0x0000080000000000-0x00000807ffffffff>
> (-22)".
> Because the release_mem_region_adjustable() can only release one
> resource that must be [0x0000080000000000 , 0x00000807ffffffff].
> but now,the iomem resource on node2 [0x0000080000000000,
> 0x00000807ffffffff] are divided into three resources [80000000000-
> 8004dffffff],[8004e000000-8004e0fffff]and[8004e100000-807ffffffff].
> 
> This patch help to Release multiple iomem resources at once when
> node hot-remove. Such as in above case, when hot-remove the cpu
> node2,the kernel will try to release resource [0x0000080000000000-
> 0x00000807ffffffff].And this patch will release three resources
> [80000000000-8004dffffff],[8004e000000-8004e0fffff] and
> [8004e100000-807ffffffff].
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Brijesh Singh <brijesh.singh@amd.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
> Cc: Takashi Iwai <tiwai@suse.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: linux-efi@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Lee Chun-Yi <JLee@suse.com>
> Signed-off-by: guomin chen <guomin.chen@suse.com>
> ---
>  kernel/resource.c | 73 ++++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 43 insertions(+), 30 deletions(-)
> 
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 30e1bc68503b..959bcce4c405 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -1240,6 +1240,7 @@ int release_mem_region_adjustable(struct resource *parent,
>  	struct resource *res;
>  	struct resource *new_res;
>  	resource_size_t end;
> +	resource_size_t new_start = start;
>  	int ret = -EINVAL;
>  
>  	end = start + size - 1;
> @@ -1257,7 +1258,7 @@ int release_mem_region_adjustable(struct resource *parent,
>  			break;
>  
>  		/* look for the next resource if it does not fit into */
> -		if (res->start > start || res->end < end) {
> +		if (res->end < new_start) {
>  			p = &res->sibling;
>  			continue;
>  		}
> @@ -1271,42 +1272,54 @@ int release_mem_region_adjustable(struct resource *parent,
>  		}
>  
>  		/* found the target resource; let's adjust accordingly */
> -		if (res->start == start && res->end == end) {
> +		if (res->start == new_start && res->end == end) {
>  			/* free the whole entry */
>  			*p = res->sibling;
>  			free_resource(res);
>  			ret = 0;
> -		} else if (res->start == start && res->end != end) {
> -			/* adjust the start */
> -			ret = __adjust_resource(res, end + 1,
> -						res->end - end);
> -		} else if (res->start != start && res->end == end) {
> -			/* adjust the end */
> -			ret = __adjust_resource(res, res->start,
> -						start - res->start);
> +		} else if (res->end > end) {
> +			if (res->start >= new_start) {
> +				/* adjust the start */
> +				ret = __adjust_resource(res, end + 1,
> +							res->end - end);
> +			} else {
> +				/* split into two entries */
> +				if (!new_res) {
> +					ret = -ENOMEM;
> +					break;
> +				}
> +				new_res->name = res->name;
> +				new_res->start = end + 1;
> +				new_res->end = res->end;
> +				new_res->flags = res->flags;
> +				new_res->desc = res->desc;
> +				new_res->parent = res->parent;
> +				new_res->sibling = res->sibling;
> +				new_res->child = NULL;
> +
> +				ret = __adjust_resource(res, res->start,
> +							new_start - res->start);
> +				if (ret)
> +					break;
> +				res->sibling = new_res;
> +				new_res = NULL;
> +			}
>  		} else {
> -			/* split into two entries */
> -			if (!new_res) {
> -				ret = -ENOMEM;
> -				break;
> +			if (res->start < new_start) {
> +				/* adjust the end */
> +				ret = __adjust_resource(res, res->start,
> +							new_start - res->start);
> +				new_start = res->end+1;
> +				p = &res->sibling;
> +			} else {
> +				new_start = res->end+1;
> +				*p = res->sibling;
> +				free_resource(res);
> +				ret = 0;
>  			}
> -			new_res->name = res->name;
> -			new_res->start = end + 1;
> -			new_res->end = res->end;
> -			new_res->flags = res->flags;
> -			new_res->desc = res->desc;
> -			new_res->parent = res->parent;
> -			new_res->sibling = res->sibling;
> -			new_res->child = NULL;
> -
> -			ret = __adjust_resource(res, res->start,
> -						start - res->start);
> -			if (ret)
> -				break;
> -			res->sibling = new_res;
> -			new_res = NULL;
> +			if (res->end < end)
> +				continue;
>  		}
> -
>  		break;
>  	}
>  
> -- 
> 2.12.3
> 
