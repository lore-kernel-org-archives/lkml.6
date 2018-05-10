Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbeEJW14 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 18:27:56 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36765 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751164AbeEJW1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 18:27:55 -0400
X-Google-Smtp-Source: AB8JxZqM/wZv3b2XeVM8Tew1f2SWutjLQ/zLPoM+yYQu/3ZNMfiGDFQ/9MQEQFxqvPPptrSZgUAy2A==
Date: Thu, 10 May 2018 15:29:21 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will.deacon@arm.com, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        steve.capper@arm.com, kristina.martsenko@arm.com, labbott@redhat.com,
        stefan@agner.ch, akpm@linux-foundation.org, jglisse@redhat.com
Subject: Re: [RFC][PATCH] arm64: update iomem_resource.end
Message-ID: <20180510222920.GA20553@Asurada-Nvidia>
References: <1525906703-28481-1-git-send-email-nicoleotsuka@gmail.com>
 <cfb81f55-f917-431f-0afd-c97e7641a2f8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfb81f55-f917-431f-0afd-c97e7641a2f8@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the comments, Robin.

On Thu, May 10, 2018 at 06:45:59PM +0100, Robin Murphy wrote:
> On 09/05/18 23:58, Nicolin Chen wrote:
> >The iomem_resource.end is -1 by default and should be updated in
> >arch-level code.
> >
> >ARM64 so far hasn't updated it while core kernel code (mm/hmm.c)
> >started to use iomem_resource.end for boundary check. So it'd be
> >better to assign iomem_resource.end using a valid value, the end
> >of physical address space for example because iomem_resource.end
> >in theory should reflect that.
> >
> >However, VA_BITS might be smaller than PA_BITS in ARM64. So using
> >the end of physical address space doesn't make a lot of sense in
> >this case, or could be even harmful since virtual address cannot
> >reach that memory region.
> 
> Why? There's plenty of stuff in the physical address space that will
> only ever be accessed via ioremap/memremap. There's no reason you
> shouldn't be able to run a VA_BITS < 48 kernel on a Cavium ThunderX

I'm running VA_BITS_39 and PA_BITS_48 on Tegra 210. There had
not been any problem of it, however with hmm.....

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/mm/hmm.c#n1144

This hmm_devmem_add() requests a region with PFNs being outside
of the linear region in ARM64 case which takes MAX_PHYSMEM_BITS
(48 bits) over iomem_resource.end without this patch. Then when
dealing with page structures in vmemmap region from a given PFN
directly (CONFIG_SPARSEMEM_VMEMMAP=y), and the given PFN is the
last one based on physical region (48 bits), the address of its
page structure will go beyond vmemmap region. Does this sound a
problem?

> where *all* the I/O is in the top half of the PA space. We already
> constrain RAM in this very function to those regions which fit into
> the linear map, and if you're accessing anything other than RAM
> through the linear map you're probably doing something wrong.

If I understand this part correctly, since ARM64 has applied the
memory limit already, does it mean that probably we should fix
something in the region_intersects() or add an extra check in the
hmm_devmem_add(), instead of limiting the iomem_resource? 
 
> Furthermore, the physical region covered by the linear map doesn't
> necessarily start at physical address 0 anyway - see PHYS_OFFSET.

Hmm...okay...but there still should be a protection somewhere if
it happens to access a page structure via pfn_to_page() while the
PFN is not covered by the vmemmap linear mapping, right?

Thanks!
