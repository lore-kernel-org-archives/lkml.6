Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB3BC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE76208E5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE76208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732499AbeGKKxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 06:53:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41038 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726487AbeGKKxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 06:53:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9C91A401CDA7;
        Wed, 11 Jul 2018 10:49:47 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D90C3213ED6A;
        Wed, 11 Jul 2018 10:49:46 +0000 (UTC)
Date:   Wed, 11 Jul 2018 18:49:44 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        yasu.isimatu@gmail.com, keescook@chromium.org,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com,
        douly.fnst@cn.fujitsu.com, mhocko@suse.com, vbabka@suse.cz,
        mgorman@techsingularity.net
Subject: Re: Bug report about KASLR and ZONE_MOVABLE
Message-ID: <20180711104944.GG1969@MiWiFi-R3L-srv>
References: <20180711094244.GA2019@localhost.localdomain>
 <20180711104158.GE2070@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711104158.GE2070@MiWiFi-R3L-srv>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 11 Jul 2018 10:49:47 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 11 Jul 2018 10:49:47 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/18 at 06:41pm, Baoquan He wrote:
 
> Hmm, it's an issue, worth fixing it. Otherwise the size of
> movable area will be smaller than we expect when add "kernel_core="
> or "movable_core=".
> 
> Add a check in find_zone_movable_pfns_for_nodes(), and use min() to get
> the starting address of movable area between aligned '_etext'
> and start_pfn. It will go to label 'restart' to calculate the 2nd round
> if not satisfiled. 
> 
> Hi Chao,
> 
> Could you check if below patch works for you?
> 
> 
> From ab6e47c6a78d1a4ccb577b995b7b386f3149732f Mon Sep 17 00:00:00 2001
> From: Baoquan He <bhe@redhat.com>
> Date: Wed, 11 Jul 2018 18:30:04 +0800
> Subject: [PATCH] mm, page_alloc: find movable zone after kernel text
> 
> In find_zone_movable_pfns_for_nodes(), when try to find the starting
> PFN movable zone begins in each node, kernel text position is not
> considered. KASLR may put kernel after which movable zone begins.
> 
> Fix it by finding movable zone after kernel text.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  mm/page_alloc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 1521100..fe346b4 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6678,6 +6678,8 @@ static void __init find_zone_movable_pfns_for_nodes(void)
>  			unsigned long size_pages;
>  
>  			start_pfn = max(start_pfn, zone_movable_pfn[nid]);
> +			/* KASLR may put kernel after 'start_pfn', start after kernel */
> +			start_pfn = max(start_pfn, PAGE_ALIGN(_etext));

Sorry, I used wrong function.

Please try this one:

From 005435407a331ecf2803e5ebfdc44b8f5f8f9748 Mon Sep 17 00:00:00 2001
From: Baoquan He <bhe@redhat.com>
Date: Wed, 11 Jul 2018 18:30:04 +0800
Subject: [PATCH v2] mm, page_alloc: find movable zone after kernel text

In find_zone_movable_pfns_for_nodes(), when try to find the starting
PFN movable zone begins in each node, kernel text position is not
considered. KASLR may put kernel after which movable zone begins.

Fix it by finding movable zone after kernel text.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/page_alloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1521100..17584cc 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6678,6 +6678,8 @@ static void __init find_zone_movable_pfns_for_nodes(void)
 			unsigned long size_pages;
 
 			start_pfn = max(start_pfn, zone_movable_pfn[nid]);
+			/* KASLR may put kernel after 'start_pfn', start after kernel */
+			start_pfn = max(start_pfn, PFN_UP(_etext));
 			if (start_pfn >= end_pfn)
 				continue;
 
-- 
2.1.0

