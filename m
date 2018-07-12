Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78031C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D06A20875
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D06A20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732627AbeGLF56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 01:57:58 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:35224 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726588AbeGLF55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:57:57 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="42153219"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 12 Jul 2018 13:49:55 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id AE4454B473E0;
        Thu, 12 Jul 2018 13:49:51 +0800 (CST)
Received: from localhost.localdomain (10.167.226.106) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.399.0; Thu, 12 Jul 2018 13:49:52 +0800
Subject: Re: Bug report about KASLR and ZONE_MOVABLE
To:     Baoquan He <bhe@redhat.com>, Chao Fan <fanc.fnst@cn.fujitsu.com>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <yasu.isimatu@gmail.com>, <keescook@chromium.org>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>,
        <mhocko@suse.com>, <vbabka@suse.cz>, <mgorman@techsingularity.net>
References: <20180711094244.GA2019@localhost.localdomain>
 <20180711104158.GE2070@MiWiFi-R3L-srv> <20180711104944.GG1969@MiWiFi-R3L-srv>
 <20180711124008.GF2070@MiWiFi-R3L-srv>
From:   Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <72721138-ba6a-32c9-3489-f2060f40a4c9@cn.fujitsu.com>
Date:   Thu, 12 Jul 2018 13:49:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180711124008.GF2070@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: AE4454B473E0.AAFF7
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baoquan,

At 07/11/2018 08:40 PM, Baoquan He wrote:
> Please try this v3 patch:
> >>From 9850d3de9c02e570dc7572069a9749a8add4c4c7 Mon Sep 17 00:00:00 2001
> From: Baoquan He <bhe@redhat.com>
> Date: Wed, 11 Jul 2018 20:31:51 +0800
> Subject: [PATCH v3] mm, page_alloc: find movable zone after kernel text
> 
> In find_zone_movable_pfns_for_nodes(), when try to find the starting
> PFN movable zone begins in each node, kernel text position is not
> considered. KASLR may put kernel after which movable zone begins.
> 
> Fix it by finding movable zone after kernel text on that node.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>


You fix this in the _zone_init side_. This may make the 'kernelcore=' or
'movablecore=' failed if the KASLR puts the kernel back the tail of the
last node, or more.

Due to we have fix the mirror memory in KASLR side, and Chao is trying
to fix the 'movable_node' in KASLR side. Have you had a chance to fix
this in the KASLR side.


> ---
>   mm/page_alloc.c | 20 +++++++++++++++-----
>   1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 1521100..390eb35 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6547,7 +6547,7 @@ static unsigned long __init early_calculate_totalpages(void)
>   static void __init find_zone_movable_pfns_for_nodes(void)
>   {
>   	int i, nid;
> -	unsigned long usable_startpfn;
> +	unsigned long usable_startpfn, real_startpfn;
>   	unsigned long kernelcore_node, kernelcore_remaining;
>   	/* save the state before borrow the nodemask */
>   	nodemask_t saved_node_state = node_states[N_MEMORY];
> @@ -6681,10 +6681,20 @@ static void __init find_zone_movable_pfns_for_nodes(void)
>   			if (start_pfn >= end_pfn)
>   				continue;
>   
> +			/*
> +			 * KASLR may put kernel near tail of node memory,
> +			 * start after kernel on that node to find PFN
> +			 * which zone begins.
> +			 */
> +			if (pfn_to_nid(PFN_UP(_etext)) == i)

Here, did you want to check the Node id? seems may be nid.

and

for_each_node_state(nid, N_MEMORY) {

         ... seems check here is more suitable.

	for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {

	}
}

Thanks,
	dou

> +				real_startpfn = max(usable_startpfn,
> +						PFN_UP(_etext))
> +			else
> +				real_startpfn = usable_startpfn;
>   			/* Account for what is only usable for kernelcore */
> -			if (start_pfn < usable_startpfn) {
> +			if (start_pfn < real_startpfn) {
>   				unsigned long kernel_pages;
> -				kernel_pages = min(end_pfn, usable_startpfn)
> +				kernel_pages = min(end_pfn, real_startpfn)
>   								- start_pfn;
>   
>   				kernelcore_remaining -= min(kernel_pages,
> @@ -6693,7 +6703,7 @@ static void __init find_zone_movable_pfns_for_nodes(void)
>   							required_kernelcore);
>   
>   				/* Continue if range is now fully accounted */
> -				if (end_pfn <= usable_startpfn) {
> +				if (end_pfn <= real_startpfn) {
>   
>   					/*
>   					 * Push zone_movable_pfn to the end so
> @@ -6704,7 +6714,7 @@ static void __init find_zone_movable_pfns_for_nodes(void)
>   					zone_movable_pfn[nid] = end_pfn;
>   					continue;
>   				}
> -				start_pfn = usable_startpfn;
> +				start_pfn = real_startpfn;
>   			}
>   
>   			/*
> 


