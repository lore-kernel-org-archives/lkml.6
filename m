Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F1DC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618072075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:06:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 618072075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbeIFMkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 08:40:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:34408 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727864AbeIFMk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 08:40:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 22F14ADF4;
        Thu,  6 Sep 2018 08:06:15 +0000 (UTC)
Date:   Thu, 6 Sep 2018 10:06:14 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 14/29] memblock: add align parameter to
 memblock_alloc_node()
Message-ID: <20180906080614.GW14951@dhcp22.suse.cz>
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1536163184-26356-15-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536163184-26356-15-git-send-email-rppt@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 05-09-18 18:59:29, Mike Rapoport wrote:
> With the align parameter memblock_alloc_node() can be used as drop in
> replacement for alloc_bootmem_pages_node().

Why do we need an additional translation later? Sparse code which is the
only one to use it already uses memblock_alloc_try_nid elsewhere
(sparse_mem_map_populate).
 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> ---
>  include/linux/bootmem.h | 4 ++--
>  mm/sparse.c             | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/bootmem.h b/include/linux/bootmem.h
> index 7d91f0f..3896af2 100644
> --- a/include/linux/bootmem.h
> +++ b/include/linux/bootmem.h
> @@ -157,9 +157,9 @@ static inline void * __init memblock_alloc_from_nopanic(
>  }
>  
>  static inline void * __init memblock_alloc_node(
> -						phys_addr_t size, int nid)
> +		phys_addr_t size, phys_addr_t align, int nid)
>  {
> -	return memblock_alloc_try_nid(size, 0, BOOTMEM_LOW_LIMIT,
> +	return memblock_alloc_try_nid(size, align, BOOTMEM_LOW_LIMIT,
>  					    BOOTMEM_ALLOC_ACCESSIBLE, nid);
>  }
>  
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 04e97af..509828f 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -68,7 +68,7 @@ static noinline struct mem_section __ref *sparse_index_alloc(int nid)
>  	if (slab_is_available())
>  		section = kzalloc_node(array_size, GFP_KERNEL, nid);
>  	else
> -		section = memblock_alloc_node(array_size, nid);
> +		section = memblock_alloc_node(array_size, 0, nid);
>  
>  	return section;
>  }
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs
