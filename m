Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A490C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BDE82184B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfADJnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 04:43:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59328 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbfADJnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 04:43:53 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B85757AE9A;
        Fri,  4 Jan 2019 09:43:51 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 62E6060BE8;
        Fri,  4 Jan 2019 09:43:46 +0000 (UTC)
Date:   Fri, 4 Jan 2019 17:43:43 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     kexec@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Daniel Vacek <neelx@redhat.com>,
        Mathieu Malaterre <malat@debian.org>,
        Stefan Agner <stefan@agner.ch>, Dave Young <dyoung@redhat.com>,
        yinghai@kernel.org, vgoyal@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20190104094343.GD30750@MiWiFi-R3L-srv>
References: <1546591195-21853-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546591195-21853-1-git-send-email-kernelfans@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 04 Jan 2019 09:43:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/19 at 04:39pm, Pingfan Liu wrote:
> Customer reported a bug on a high end server with many pcie devices, where
> kernel bootup with crashkernel=384M, and kaslr is enabled. Even
> though we still see much memory under 896 MB, the finding still failed
> intermittently. Because currently we can only find region under 896 MB,
> if w/0 ',high' specified. Then KASLR breaks 896 MB into several parts
> randomly, and crashkernel reservation need be aligned to 128 MB, that's
> why failure is found. It raises confusion to the end user that sometimes
> crashkernel=X works while sometimes fails.
> If want to make it succeed, customer can change kernel option to
> "crashkernel=384M, high". Just this give "crashkernel=xx@yy" a very
> limited space to behave even though its grammer looks more generic.
> And we can't answer questions raised from customer that confidently:
> 1) why it doesn't succeed to reserve 896 MB;
> 2) what's wrong with memory region under 4G;
> 3) why I have to add ',high', I only require 384 MB, not 3840 MB.
> 
> This patch simplifies the method suggested in the mail [1]. It just goes
> bottom-up to find a candidate region for crashkernel. The bottom-up may be
> better compatible with the old reservation style, i.e. still want to get
> memory region from 896 MB firstly, then [896 MB, 4G], finally above 4G.
> 
> There is one trivial thing about the compatibility with old kexec-tools:
> if the reserved region is above 896M, then old tool will fail to load
> bzImage. But without this patch, the old tool also fail since there is no
> memory below 896M can be reserved for crashkernel.
> 
> [1]: http://lists.infradead.org/pipermail/kexec/2017-October/019571.html
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Cc: Daniel Vacek <neelx@redhat.com>
> Cc: Mathieu Malaterre <malat@debian.org>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: yinghai@kernel.org
> Cc: vgoyal@redhat.com
> Cc: linux-kernel@vger.kernel.org
> ---
> v3 -> v4:
>  instead of exporting the stage of parsing mem hotplug info, just using the bottom-up allocation func directly
>  arch/x86/kernel/setup.c  | 8 ++++----
>  include/linux/memblock.h | 4 ++++
>  mm/memblock.c            | 2 +-
>  3 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index d494b9b..082aadd 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -546,10 +546,10 @@ static void __init reserve_crashkernel(void)
>  		 * as old kexec-tools loads bzImage below that, unless
>  		 * "crashkernel=size[KMG],high" is specified.
>  		 */
> -		crash_base = memblock_find_in_range(CRASH_ALIGN,
> -						    high ? CRASH_ADDR_HIGH_MAX
> -							 : CRASH_ADDR_LOW_MAX,
> -						    crash_size, CRASH_ALIGN);
> +		crash_base = __memblock_find_range_bottom_up(CRASH_ALIGN,

Better make a wrapper function for external invocation. E.g we need
allocate kernel data in mirrorred memory region if it's available. This
has been done in memblock_find_in_range(), and the boundary alignment.

> +			(max_pfn * PAGE_SIZE), crash_size, CRASH_ALIGN,
> +			NUMA_NO_NODE, MEMBLOCK_NONE);
> +
>  		if (!crash_base) {
>  			pr_info("crashkernel reservation failed - No suitable area found.\n");
>  			return;
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index aee299a..39720bf 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -116,6 +116,10 @@ phys_addr_t memblock_find_in_range_node(phys_addr_t size, phys_addr_t align,
>  					int nid, enum memblock_flags flags);
>  phys_addr_t memblock_find_in_range(phys_addr_t start, phys_addr_t end,
>  				   phys_addr_t size, phys_addr_t align);
> +phys_addr_t __init_memblock
> +__memblock_find_range_bottom_up(phys_addr_t start, phys_addr_t end,
> +				phys_addr_t size, phys_addr_t align, int nid,
> +				enum memblock_flags flags);
>  void memblock_allow_resize(void);
>  int memblock_add_node(phys_addr_t base, phys_addr_t size, int nid);
>  int memblock_add(phys_addr_t base, phys_addr_t size);
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 81ae63c..53b1707 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -172,7 +172,7 @@ bool __init_memblock memblock_overlaps_region(struct memblock_type *type,
>   * Return:
>   * Found address on success, 0 on failure.
>   */
> -static phys_addr_t __init_memblock
> +phys_addr_t __init_memblock
>  __memblock_find_range_bottom_up(phys_addr_t start, phys_addr_t end,
>  				phys_addr_t size, phys_addr_t align, int nid,
>  				enum memblock_flags flags)
> -- 
> 2.7.4
> 
