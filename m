Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1B9C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E30020652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E30020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbeIFMbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 08:31:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:33266 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725819AbeIFMbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 08:31:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ADE25AC1F;
        Thu,  6 Sep 2018 07:57:21 +0000 (UTC)
Date:   Thu, 6 Sep 2018 09:57:21 +0200
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
Subject: Re: [RFC PATCH 13/29] memblock: replace __alloc_bootmem_nopanic with
 memblock_alloc_from_nopanic
Message-ID: <20180906075721.GV14951@dhcp22.suse.cz>
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1536163184-26356-14-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536163184-26356-14-git-send-email-rppt@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 05-09-18 18:59:28, Mike Rapoport wrote:
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

The translation is simpler here but still a word or two would be nice.
Empty changelogs suck.

To the change
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  arch/arc/kernel/unwind.c       | 4 ++--
>  arch/x86/kernel/setup_percpu.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arc/kernel/unwind.c b/arch/arc/kernel/unwind.c
> index 183391d..2a01dd1 100644
> --- a/arch/arc/kernel/unwind.c
> +++ b/arch/arc/kernel/unwind.c
> @@ -181,8 +181,8 @@ static void init_unwind_hdr(struct unwind_table *table,
>   */
>  static void *__init unw_hdr_alloc_early(unsigned long sz)
>  {
> -	return __alloc_bootmem_nopanic(sz, sizeof(unsigned int),
> -				       MAX_DMA_ADDRESS);
> +	return memblock_alloc_from_nopanic(sz, sizeof(unsigned int),
> +					   MAX_DMA_ADDRESS);
>  }
>  
>  static void *unw_hdr_alloc(unsigned long sz)
> diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
> index 67d48e26..041663a 100644
> --- a/arch/x86/kernel/setup_percpu.c
> +++ b/arch/x86/kernel/setup_percpu.c
> @@ -106,7 +106,7 @@ static void * __init pcpu_alloc_bootmem(unsigned int cpu, unsigned long size,
>  	void *ptr;
>  
>  	if (!node_online(node) || !NODE_DATA(node)) {
> -		ptr = __alloc_bootmem_nopanic(size, align, goal);
> +		ptr = memblock_alloc_from_nopanic(size, align, goal);
>  		pr_info("cpu %d has no node %d or node-local memory\n",
>  			cpu, node);
>  		pr_debug("per cpu data for cpu%d %lu bytes at %016lx\n",
> @@ -121,7 +121,7 @@ static void * __init pcpu_alloc_bootmem(unsigned int cpu, unsigned long size,
>  	}
>  	return ptr;
>  #else
> -	return __alloc_bootmem_nopanic(size, align, goal);
> +	return memblock_alloc_from_nopanic(size, align, goal);
>  #endif
>  }
>  
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs
