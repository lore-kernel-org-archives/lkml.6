Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E61C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 04:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD8352087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 04:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfAHEyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 23:54:25 -0500
Received: from foss.arm.com ([217.140.101.70]:43578 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727433AbfAHEyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 23:54:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61886EBD;
        Mon,  7 Jan 2019 20:54:24 -0800 (PST)
Received: from [10.37.8.27] (unknown [10.37.8.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 87C993F6CF;
        Mon,  7 Jan 2019 20:54:22 -0800 (PST)
Subject: Re: linux-next: build failure after merge of the akpm-current tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190108131141.730e9c4f@canb.auug.org.au>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <78f2ee4a-9851-2b5c-18c6-ba3f3e6bd302@arm.com>
Date:   Tue, 8 Jan 2019 10:24:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190108131141.730e9c4f@canb.auug.org.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/08/2019 07:41 AM, Stephen Rothwell wrote:
> Hi Andrew,
> 
> After merging the akpm-current tree, today's linux-next build (native
> perf) failed like this:
> 
> bench/numa.c: In function 'bind_to_node':
> bench/numa.c:301:21: error: 'NUMA_NO_NODE' undeclared (first use in this function); did you mean 'NUMA_NUM_NODES'?
>   if (target_node == NUMA_NO_NODE) {
>                      ^~~~~~~~~~~~
>                      NUMA_NUM_NODES
> bench/numa.c:301:21: note: each undeclared identifier is reported only once for each function it appears in
> bench/numa.c: In function 'bind_to_memnode':
> bench/numa.c:342:14: error: 'NUMA_NO_NODE' undeclared (first use in this function); did you mean 'NUMA_NUM_NODES'?
>   if (node == NUMA_NO_NODE)
>               ^~~~~~~~~~~~
>               NUMA_NUM_NODES
> bench/numa.c: In function 'init_thread_data':
> bench/numa.c:1366:19: error: 'NUMA_NO_NODE' undeclared (first use in this function); did you mean 'NUMA_NUM_NODES'?
>    td->bind_node = NUMA_NO_NODE;
>                    ^~~~~~~~~~~~
>                    NUMA_NUM_NODES
> 
> Caused by commit
> 
>   3856193d8452 ("tools/: replace open encodings for NUMA_NO_NODE")
> 
> [BTW, I did not write that patch, just added fixes last time]

Yes I had consolidated parts from the original patch into the build failure fix.


> [BTW 2, there are lots of cc's that probably no longer apply since this
> was split form the previous patch]

Hmm. I had sent it as a series. So the second patch just carried over all the CC
for the first one as well.

> 
> I have applied the following fix patch:
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 8 Jan 2019 13:08:32 +1100
> Subject: [PATCH] tools/: fix for replace open encodings for NUMA_NO_NODE
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  tools/perf/bench/numa.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
> index e0ad5f1de226..98ad783efc69 100644
> --- a/tools/perf/bench/numa.c
> +++ b/tools/perf/bench/numa.c
> @@ -34,6 +34,7 @@
>  #include <sys/types.h>
>  #include <linux/kernel.h>
>  #include <linux/time64.h>
> +#include <linux/numa.h>
>  
>  #include <numa.h>

Just curious why the NUMA_NO_NODE definition did not get resolved from the local
numa.h which had the same ones copied over from linux/numa.h but anyways the fix
looks okay.
