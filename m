Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7B4C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7418421905
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732991AbfAaPjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 10:39:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:50270 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726239AbfAaPjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 10:39:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7C4BEAD5D;
        Thu, 31 Jan 2019 15:39:20 +0000 (UTC)
Subject: Re: [PATCH 20/22] mm, compaction: Sample pageblocks for free pages
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20190118175136.31341-1-mgorman@techsingularity.net>
 <20190118175136.31341-21-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Message-ID: <919af440-28d2-465b-3414-bb4719b844ae@suse.cz>
Date:   Thu, 31 Jan 2019 16:39:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190118175136.31341-21-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/19 6:51 PM, Mel Gorman wrote:
> Once fast searching finishes, there is a possibility that the linear
> scanner is scanning full blocks found by the fast scanner earlier. This
> patch uses an adaptive stride to sample pageblocks for free pages. The
> more consecutive full pageblocks encountered, the larger the stride until
> a pageblock with free pages is found. The scanners might meet slightly
> sooner but it is an acceptable risk given that the search of the free
> lists may still encounter the pages and adjust the cached PFN of the free
> scanner accordingly.
> 
>                                      5.0.0-rc1              5.0.0-rc1
>                               roundrobin-v3r17       samplefree-v3r17
> Amean     fault-both-1         0.00 (   0.00%)        0.00 *   0.00%*
> Amean     fault-both-3      2752.37 (   0.00%)     2729.95 (   0.81%)
> Amean     fault-both-5      4341.69 (   0.00%)     4397.80 (  -1.29%)
> Amean     fault-both-7      6308.75 (   0.00%)     6097.61 (   3.35%)
> Amean     fault-both-12    10241.81 (   0.00%)     9407.15 (   8.15%)
> Amean     fault-both-18    13736.09 (   0.00%)    10857.63 *  20.96%*
> Amean     fault-both-24    16853.95 (   0.00%)    13323.24 *  20.95%*
> Amean     fault-both-30    15862.61 (   0.00%)    17345.44 (  -9.35%)
> Amean     fault-both-32    18450.85 (   0.00%)    16892.00 (   8.45%)
> 
> The latency is mildly improved offseting some overhead from earlier
> patches that are prerequisites for the rest of the series.  However,
> a major impact is on the free scan rate with an 82% reduction.
> 
>                                 5.0.0-rc1      5.0.0-rc1
>                          roundrobin-v3r17 samplefree-v3r17
> Compaction migrate scanned    21607271            20116887
> Compaction free scanned       95336406            16668703
> 
> It's also the first time in the series where the number of pages scanned
> by the migration scanner is greater than the free scanner due to the
> increased search efficiency.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
