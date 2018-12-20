Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2539C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC1B217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297728;
	bh=0SzFpg0Czr5ZqcIKaHUhnmdV6p2DVbZpuxjDCPuxrPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SxaxfVbVhxagCsW9BnoVY2CCeWDcnLS7UsiKFTXFGVD0sSK6G2drL7YOWzwv58b7s
	 B/isGKrWreVJAR1Z/adwYATwvBpJKleV5VK9iIlIA8O8I76KfSFsYSv4ZeGwFL41pe
	 z/leyaXZUZRTXiMRvNsQVpq9bemn7eatJzDa5tns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731265AbeLTJWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:22:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:52556 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731250AbeLTJWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:22:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D949AB005;
        Thu, 20 Dec 2018 09:22:02 +0000 (UTC)
Date:   Thu, 20 Dec 2018 10:22:02 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, Pavel.Tatashin@microsoft.com,
        mingo@kernel.org, hpa@zytor.com, mgorman@techsingularity.net,
        tglx@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_owner: fix for deferred struct page init
Message-ID: <20181220092202.GD14234@dhcp22.suse.cz>
References: <cbfacb4b-dbfd-f68f-3d1e-05e137feca18@lca.pw>
 <20181220060303.38686-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220060303.38686-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 20-12-18 01:03:03, Qian Cai wrote:
> When booting a system with "page_owner=on",
> 
> start_kernel
>   page_ext_init
>     invoke_init_callbacks
>       init_section_page_ext
>         init_page_owner
>           init_early_allocated_pages
>             init_zones_in_node
>               init_pages_in_zone
>                 lookup_page_ext
>                   page_to_nid
> 
> The issue here is that page_to_nid() will not work since some page
> flags have no node information until later in page_alloc_init_late() due
> to DEFERRED_STRUCT_PAGE_INIT. Hence, it could trigger an out-of-bounds
> access with an invalid nid.
> 
> [    8.666047] UBSAN: Undefined behaviour in ./include/linux/mm.h:1104:50
> [    8.672603] index 7 is out of range for type 'zone [5]'
> 
> Also, kernel will panic since flags were poisoned earlier with,
> 
> CONFIG_DEBUG_VM_PGFLAGS=y
> CONFIG_NODE_NOT_IN_PAGE_FLAGS=n
> 
> start_kernel
>   setup_arch
>     pagetable_init
>       paging_init
>         sparse_init
>           sparse_init_nid
>             memblock_alloc_try_nid_raw
> 
> Although later it tries to set page flags for pages in reserved bootmem
> regions,
> 
> mm_init
>   mem_init
>     memblock_free_all
>       free_low_memory_core_early
>         reserve_bootmem_region
> 
> there could still have some freed pages from the page allocator but yet
> to be initialized due to DEFERRED_STRUCT_PAGE_INIT. It have already been
> dealt with a bit in page_ext_init().

Is there any reason why we cannot postpone page_ext initialization to
after all the memory is initialized?
-- 
Michal Hocko
SUSE Labs
