Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377BBC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED85D20BEC
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED85D20BEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbeGLMSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 08:18:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57906 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726580AbeGLMSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 08:18:14 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 79403DFF0;
        Thu, 12 Jul 2018 12:08:56 +0000 (UTC)
Received: from localhost (ovpn-8-32.pek2.redhat.com [10.72.8.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F35D1C701;
        Thu, 12 Jul 2018 12:08:54 +0000 (UTC)
Date:   Thu, 12 Jul 2018 20:08:50 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        yasu.isimatu@gmail.com, keescook@chromium.org,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com,
        douly.fnst@cn.fujitsu.com, mhocko@suse.com, vbabka@suse.cz,
        mgorman@techsingularity.net
Subject: Re: Bug report about KASLR and ZONE_MOVABLE
Message-ID: <20180712120850.GJ1969@MiWiFi-R3L-srv>
References: <20180711094244.GA2019@localhost.localdomain>
 <20180711104158.GE2070@MiWiFi-R3L-srv>
 <20180711104944.GG1969@MiWiFi-R3L-srv>
 <20180711124008.GF2070@MiWiFi-R3L-srv>
 <20180712011954.GC6742@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712011954.GC6742@localhost.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 12 Jul 2018 12:08:56 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 12 Jul 2018 12:08:56 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/18 at 09:19am, Chao Fan wrote:
> On Wed, Jul 11, 2018 at 08:40:08PM +0800, Baoquan He wrote:
> >Please try this v3 patch:
> >
> >From 9850d3de9c02e570dc7572069a9749a8add4c4c7 Mon Sep 17 00:00:00 2001
> >From: Baoquan He <bhe@redhat.com>
> >Date: Wed, 11 Jul 2018 20:31:51 +0800
> >Subject: [PATCH v3] mm, page_alloc: find movable zone after kernel text
> >
> >In find_zone_movable_pfns_for_nodes(), when try to find the starting
> >PFN movable zone begins in each node, kernel text position is not
> >considered. KASLR may put kernel after which movable zone begins.
> >
> >Fix it by finding movable zone after kernel text on that node.
> >
> >Signed-off-by: Baoquan He <bhe@redhat.com>
> >---
> > mm/page_alloc.c | 20 +++++++++++++++-----
> > 1 file changed, 15 insertions(+), 5 deletions(-)
> >
> >diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >index 1521100..390eb35 100644
> >--- a/mm/page_alloc.c
> >+++ b/mm/page_alloc.c
> >@@ -6547,7 +6547,7 @@ static unsigned long __init early_calculate_totalpages(void)
> > static void __init find_zone_movable_pfns_for_nodes(void)
> > {
> > 	int i, nid;
> >-	unsigned long usable_startpfn;
> >+	unsigned long usable_startpfn, real_startpfn;
> > 	unsigned long kernelcore_node, kernelcore_remaining;
> > 	/* save the state before borrow the nodemask */
> > 	nodemask_t saved_node_state = node_states[N_MEMORY];
> >@@ -6681,10 +6681,20 @@ static void __init find_zone_movable_pfns_for_nodes(void)
> > 			if (start_pfn >= end_pfn)
> > 				continue;
> 
> Hi Baoquan,
> 
> Thanks for your quick reply and PATCH.
> I think it can work well after reviewing the code. But I think the new
> variable 'real_startpfn' is unnecessary. How about this:
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 6d00f746c2fd..0fc9c4283947 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6492,6 +6492,10 @@ static void __init find_zone_movable_pfns_for_nodes(void)
>                         if (start_pfn >= end_pfn)
>                                 continue;
> 
> +                       if (pfn_to_nid(PFN_UP(_etext)) == i)
> +                               usable_startpfn = max(usable_startpfn,
> +                                                 PFN_UP(_etext));
> +
>                         /* Account for what is only usable for kernelcore */
>                         if (start_pfn < usable_startpfn) {
>                                 unsigned long kernel_pages;
> 
> I think the logic of these two method are the same, and this method
> change less code. If I am wrong, please let me know.

Might be not. Need consider usable_startpfn and kernel_pfn are in the
same node, or in different node, two cases.

I will correct code after fix the compiling error.
> 
> 
> > 
> >+			/*
> >+			 * KASLR may put kernel near tail of node memory,
> >+			 * start after kernel on that node to find PFN
> >+			 * which zone begins.
> >+			 */
> >+			if (pfn_to_nid(PFN_UP(_etext)) == i)
> >+				real_startpfn = max(usable_startpfn,
> >+						PFN_UP(_etext))
> >+			else
> >+				real_startpfn = usable_startpfn;
> > 			/* Account for what is only usable for kernelcore */
> >-			if (start_pfn < usable_startpfn) {
> >+			if (start_pfn < real_startpfn) {
> > 				unsigned long kernel_pages;
> >-				kernel_pages = min(end_pfn, usable_startpfn)
> >+				kernel_pages = min(end_pfn, real_startpfn)
> > 								- start_pfn;
> > 
> > 				kernelcore_remaining -= min(kernel_pages,
> >@@ -6693,7 +6703,7 @@ static void __init find_zone_movable_pfns_for_nodes(void)
> > 							required_kernelcore);
> > 
> > 				/* Continue if range is now fully accounted */
> >-				if (end_pfn <= usable_startpfn) {
> >+				if (end_pfn <= real_startpfn) {
> > 
> > 					/*
> > 					 * Push zone_movable_pfn to the end so
> >@@ -6704,7 +6714,7 @@ static void __init find_zone_movable_pfns_for_nodes(void)
> > 					zone_movable_pfn[nid] = end_pfn;
> > 					continue;
> > 				}
> >-				start_pfn = usable_startpfn;
> >+				start_pfn = real_startpfn;
> > 			}
> > 
> > 			/*
> >-- 
> >2.1.0
> >
> >
> >
> 
> 
