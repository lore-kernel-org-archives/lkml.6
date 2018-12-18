Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D60CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1340F21850
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbeLRIIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:08:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:40618 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726316AbeLRIIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:08:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 49698AF63;
        Tue, 18 Dec 2018 08:08:03 +0000 (UTC)
Subject: Re: [PATCH 05/14] mm, compaction: Skip pageblocks with reserved pages
To:     Mel Gorman <mgorman@techsingularity.net>,
        Linux-MM <linux-mm@kvack.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <20181214230310.572-1-mgorman@techsingularity.net>
 <20181214230310.572-6-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Message-ID: <b1d38179-4ccf-f34a-dffa-26c7957b8aed@suse.cz>
Date:   Tue, 18 Dec 2018 09:08:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181214230310.572-6-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/18 12:03 AM, Mel Gorman wrote:
> Reserved pages are set at boot time, tend to be clustered and almost
> never become unreserved. When isolating pages for migrating, skip
> the entire pageblock is one PageReserved page is encountered on the
> grounds that it is highly probable the entire pageblock is reserved.

Agreed, but maybe since it's highly probable and not certain, this
skipping should not be done on the highest compaction priority?

> The impact depends on the machine and timing but both thpscale and
> thpfioscale when using MADV_HUGEPAGE show a reduction of scanning and
> fault latency on a 1-socket machine. The 2-socket results were too
> noisy to draw any meaningful conclusion but it's safe to assume less
> scanning is useful.
> 
> 1-socket thpfioscale
>                                    4.20.0-rc6             4.20.0-rc6
>                                mmotm-20181210        noreserved-v1r4
> Amean     fault-base-1     1481.32 (   0.00%)     1443.63 (   2.54%)
> Amean     fault-huge-1     1118.17 (   0.00%)      981.30 *  12.24%*
> Amean     fault-both-1     1176.43 (   0.00%)     1052.64 *  10.52%*
> 
> Compaction migrate scanned     3860713     3294284
> Compaction free scanned      613786341   433423502
> Kcompactd migrate scanned       408711      291915
> Kcompactd free scanned       242509759   217164988
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  mm/compaction.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 3afa4e9188b6..8134dba47584 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -827,6 +827,13 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  					goto isolate_success;
>  			}
>  
> +			/*
> +			 * A reserved page is never freed and tend to be
> +			 * clustered in the same pageblocks. Skip the block.
> +			 */
> +			if (PageReserved(page))
> +				low_pfn = end_pfn;
> +
>  			goto isolate_fail;
>  		}
>  
> 

