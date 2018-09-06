Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C19C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F09672083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:55:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F09672083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbeIFM37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 08:29:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:33004 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725819AbeIFM37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 08:29:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 55AB0AC1F;
        Thu,  6 Sep 2018 07:55:47 +0000 (UTC)
Date:   Thu, 6 Sep 2018 09:55:46 +0200
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
Subject: Re: [RFC PATCH 12/29] memblock: replace alloc_bootmem_low with
 memblock_alloc_low
Message-ID: <20180906075546.GU14951@dhcp22.suse.cz>
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1536163184-26356-13-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536163184-26356-13-git-send-email-rppt@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 05-09-18 18:59:27, Mike Rapoport wrote:
> The alloc_bootmem_low(size) allocates low memory with default alignement
> and can be replcaed by memblock_alloc_low(size, 0)
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

Again _virt renaming thing...
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  arch/arm64/kernel/setup.c     | 2 +-
>  arch/unicore32/kernel/setup.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 5b4fac4..cf7a7b7 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -213,7 +213,7 @@ static void __init request_standard_resources(void)
>  	kernel_data.end     = __pa_symbol(_end - 1);
>  
>  	for_each_memblock(memory, region) {
> -		res = alloc_bootmem_low(sizeof(*res));
> +		res = memblock_alloc_low(sizeof(*res), 0);
>  		if (memblock_is_nomap(region)) {
>  			res->name  = "reserved";
>  			res->flags = IORESOURCE_MEM;
> diff --git a/arch/unicore32/kernel/setup.c b/arch/unicore32/kernel/setup.c
> index c2bffa5..9f163f9 100644
> --- a/arch/unicore32/kernel/setup.c
> +++ b/arch/unicore32/kernel/setup.c
> @@ -207,7 +207,7 @@ request_standard_resources(struct meminfo *mi)
>  		if (mi->bank[i].size == 0)
>  			continue;
>  
> -		res = alloc_bootmem_low(sizeof(*res));
> +		res = memblock_alloc_low(sizeof(*res), 0);
>  		res->name  = "System RAM";
>  		res->start = mi->bank[i].start;
>  		res->end   = mi->bank[i].start + mi->bank[i].size - 1;
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs
