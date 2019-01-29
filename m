Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81C3C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21732177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbfA2JJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:09:10 -0500
Received: from charybdis-ext.suse.de ([195.135.221.2]:28560 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725355AbfA2JJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:09:10 -0500
Received: by suse.de (Postfix, from userid 1000)
        id 559E540B3; Tue, 29 Jan 2019 10:09:09 +0100 (CET)
Date:   Tue, 29 Jan 2019 10:09:08 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        gerald.schaefer@de.ibm.com, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 2/2] mm, memory_hotplug: test_pages_in_a_zone do not pass
 the end of zone
Message-ID: <20190129090908.oms43oyjicozkvzu@d104.suse.de>
References: <20190128144506.15603-1-mhocko@kernel.org>
 <20190128144506.15603-3-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128144506.15603-3-mhocko@kernel.org>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 03:45:06PM +0100, Michal Hocko wrote:
> From: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> 
> If memory end is not aligned with the sparse memory section boundary, the
> mapping of such a section is only partly initialized. This may lead to
> VM_BUG_ON due to uninitialized struct pages access from test_pages_in_a_zone()
> function triggered by memory_hotplug sysfs handlers.
> 
> Here are the the panic examples:
>  CONFIG_DEBUG_VM_PGFLAGS=y
>  kernel parameter mem=2050M
>  --------------------------
>  page:000003d082008000 is uninitialized and poisoned
>  page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
>  Call Trace:
>  ([<0000000000385b26>] test_pages_in_a_zone+0xde/0x160)
>   [<00000000008f15c4>] show_valid_zones+0x5c/0x190
>   [<00000000008cf9c4>] dev_attr_show+0x34/0x70
>   [<0000000000463ad0>] sysfs_kf_seq_show+0xc8/0x148
>   [<00000000003e4194>] seq_read+0x204/0x480
>   [<00000000003b53ea>] __vfs_read+0x32/0x178
>   [<00000000003b55b2>] vfs_read+0x82/0x138
>   [<00000000003b5be2>] ksys_read+0x5a/0xb0
>   [<0000000000b86ba0>] system_call+0xdc/0x2d8
>  Last Breaking-Event-Address:
>   [<0000000000385b26>] test_pages_in_a_zone+0xde/0x160
>  Kernel panic - not syncing: Fatal exception: panic_on_oops
> 
> Fix this by checking whether the pfn to check is within the zone.
> 
> [mhocko@suse.com: separated this change from
> http://lkml.kernel.org/r/20181105150401.97287-2-zaslonko@linux.ibm.com]
> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Looks good to me:

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/memory_hotplug.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 07872789d778..7711d0e327b6 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1274,6 +1274,9 @@ int test_pages_in_a_zone(unsigned long start_pfn, unsigned long end_pfn,
>  				i++;
>  			if (i == MAX_ORDER_NR_PAGES || pfn + i >= end_pfn)
>  				continue;
> +			/* Check if we got outside of the zone */
> +			if (zone && !zone_spans_pfn(zone, pfn + i))
> +				return 0;
>  			page = pfn_to_page(pfn + i);

Since we are already checking if the zone spans that pfn, is it safe to get
rid of the below check? Or maybe not because we might have intersected zones?

>  			if (zone && page_zone(page) != zone)
>  				return 0;

-- 
Oscar Salvador
SUSE L3
