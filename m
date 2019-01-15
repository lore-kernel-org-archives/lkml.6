Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D367CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE8A20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbfAOMK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 07:10:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:56256 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727410AbfAOMK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 07:10:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 41B26ADF0;
        Tue, 15 Jan 2019 12:10:58 +0000 (UTC)
Subject: Re: [PATCH 06/25] mm, compaction: Skip pageblocks with reserved pages
To:     Mel Gorman <mgorman@techsingularity.net>,
        Linux-MM <linux-mm@kvack.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <20190104125011.16071-1-mgorman@techsingularity.net>
 <20190104125011.16071-7-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Message-ID: <657ee6fc-48df-59ab-70b7-6066513e3b22@suse.cz>
Date:   Tue, 15 Jan 2019 13:10:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190104125011.16071-7-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/19 1:49 PM, Mel Gorman wrote:
> Reserved pages are set at boot time, tend to be clustered and almost never
> become unreserved. When isolating pages for either migration sources or
> target, skip the entire pageblock is one PageReserved page is encountered
> on the grounds that it is highly probable the entire pageblock is reserved.
> 
> The performance impact is relative to the number of reserved pages in
> the system and their location so it'll be variable but intuitively it
> should make sense. If the memblock allocator was ever changed to spread
> reserved pages throughout the address space then this patch would be
> impaired but it would also be considered a bug given that such a change
> would ruin fragmentation.
> 
> On both 1-socket and 2-socket machines, scan rates are reduced slightly
> on workloads that intensively allocate THP while the system is fragmented.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  mm/compaction.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 3afa4e9188b6..94d1e5b062ea 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -484,6 +484,15 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
>  			goto isolate_fail;
>  		}
>  
> +		/*
> +		 * A reserved page is never freed and tend to be clustered in
> +		 * the same pageblock. Skip the block.
> +		 */
> +		if (PageReserved(page)) {
> +			blockpfn = end_pfn;
> +			break;
> +		}
> +
>  		if (!PageBuddy(page))
>  			goto isolate_fail;
>  
> @@ -827,6 +836,13 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  					goto isolate_success;
>  			}
>  
> +			/*
> +			 * A reserved page is never freed and tend to be
> +			 * clustered in the same pageblocks. Skip the block.

AFAICS memory allocator is not the only user of PageReserved. There
seems to be some drivers as well, notably the DRM subsystem via
drm_pci_alloc(). There's an effort to clean those up [1] but until then,
there might be some false positives here.

[1] https://marc.info/?l=linux-mm&m=154747078617898&w=2

> +			 */
> +			if (PageReserved(page))
> +				low_pfn = end_pfn;
> +
>  			goto isolate_fail;
>  		}
>  
> 

