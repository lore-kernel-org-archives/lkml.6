Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5DDC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB1520878
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:40:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB1520878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbeGKMoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:44:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38468 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726269AbeGKMoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:44:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A96747A7F0;
        Wed, 11 Jul 2018 12:40:13 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F1322026D6B;
        Wed, 11 Jul 2018 12:40:12 +0000 (UTC)
Date:   Wed, 11 Jul 2018 20:40:08 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        yasu.isimatu@gmail.com, keescook@chromium.org,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com,
        douly.fnst@cn.fujitsu.com, mhocko@suse.com, vbabka@suse.cz,
        mgorman@techsingularity.net
Subject: Re: Bug report about KASLR and ZONE_MOVABLE
Message-ID: <20180711124008.GF2070@MiWiFi-R3L-srv>
References: <20180711094244.GA2019@localhost.localdomain>
 <20180711104158.GE2070@MiWiFi-R3L-srv>
 <20180711104944.GG1969@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711104944.GG1969@MiWiFi-R3L-srv>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 11 Jul 2018 12:40:13 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 11 Jul 2018 12:40:13 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please try this v3 patch:

From 9850d3de9c02e570dc7572069a9749a8add4c4c7 Mon Sep 17 00:00:00 2001
From: Baoquan He <bhe@redhat.com>
Date: Wed, 11 Jul 2018 20:31:51 +0800
Subject: [PATCH v3] mm, page_alloc: find movable zone after kernel text

In find_zone_movable_pfns_for_nodes(), when try to find the starting
PFN movable zone begins in each node, kernel text position is not
considered. KASLR may put kernel after which movable zone begins.

Fix it by finding movable zone after kernel text on that node.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/page_alloc.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1521100..390eb35 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6547,7 +6547,7 @@ static unsigned long __init early_calculate_totalpages(void)
 static void __init find_zone_movable_pfns_for_nodes(void)
 {
 	int i, nid;
-	unsigned long usable_startpfn;
+	unsigned long usable_startpfn, real_startpfn;
 	unsigned long kernelcore_node, kernelcore_remaining;
 	/* save the state before borrow the nodemask */
 	nodemask_t saved_node_state = node_states[N_MEMORY];
@@ -6681,10 +6681,20 @@ static void __init find_zone_movable_pfns_for_nodes(void)
 			if (start_pfn >= end_pfn)
 				continue;
 
+			/*
+			 * KASLR may put kernel near tail of node memory,
+			 * start after kernel on that node to find PFN
+			 * which zone begins.
+			 */
+			if (pfn_to_nid(PFN_UP(_etext)) == i)
+				real_startpfn = max(usable_startpfn,
+						PFN_UP(_etext))
+			else
+				real_startpfn = usable_startpfn;
 			/* Account for what is only usable for kernelcore */
-			if (start_pfn < usable_startpfn) {
+			if (start_pfn < real_startpfn) {
 				unsigned long kernel_pages;
-				kernel_pages = min(end_pfn, usable_startpfn)
+				kernel_pages = min(end_pfn, real_startpfn)
 								- start_pfn;
 
 				kernelcore_remaining -= min(kernel_pages,
@@ -6693,7 +6703,7 @@ static void __init find_zone_movable_pfns_for_nodes(void)
 							required_kernelcore);
 
 				/* Continue if range is now fully accounted */
-				if (end_pfn <= usable_startpfn) {
+				if (end_pfn <= real_startpfn) {
 
 					/*
 					 * Push zone_movable_pfn to the end so
@@ -6704,7 +6714,7 @@ static void __init find_zone_movable_pfns_for_nodes(void)
 					zone_movable_pfn[nid] = end_pfn;
 					continue;
 				}
-				start_pfn = usable_startpfn;
+				start_pfn = real_startpfn;
 			}
 
 			/*
-- 
2.1.0

