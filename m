Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB7DECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 23:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E6A20BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 23:52:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44E6A20BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387753AbeGMAEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 20:04:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55000 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387723AbeGMAEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 20:04:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 046E12BCB1;
        Thu, 12 Jul 2018 23:52:46 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8DFCB1C665;
        Thu, 12 Jul 2018 23:52:44 +0000 (UTC)
Date:   Fri, 13 Jul 2018 07:52:40 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        yasu.isimatu@gmail.com, keescook@chromium.org,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com,
        vbabka@suse.cz, mgorman@techsingularity.net
Subject: Re: Bug report about KASLR and ZONE_MOVABLE
Message-ID: <20180712235240.GH2070@MiWiFi-R3L-srv>
References: <20180711094244.GA2019@localhost.localdomain>
 <20180711104158.GE2070@MiWiFi-R3L-srv>
 <20180711104944.GG1969@MiWiFi-R3L-srv>
 <20180711124008.GF2070@MiWiFi-R3L-srv>
 <72721138-ba6a-32c9-3489-f2060f40a4c9@cn.fujitsu.com>
 <20180712060115.GD6742@localhost.localdomain>
 <20180712123228.GK32648@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712123228.GK32648@dhcp22.suse.cz>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 12 Jul 2018 23:52:46 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 12 Jul 2018 23:52:46 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On 07/12/18 at 02:32pm, Michal Hocko wrote:
> On Thu 12-07-18 14:01:15, Chao Fan wrote:
> > On Thu, Jul 12, 2018 at 01:49:49PM +0800, Dou Liyang wrote:
> > >Hi Baoquan,
> > >
> > >At 07/11/2018 08:40 PM, Baoquan He wrote:
> > >> Please try this v3 patch:
> > >> >>From 9850d3de9c02e570dc7572069a9749a8add4c4c7 Mon Sep 17 00:00:00 2001
> > >> From: Baoquan He <bhe@redhat.com>
> > >> Date: Wed, 11 Jul 2018 20:31:51 +0800
> > >> Subject: [PATCH v3] mm, page_alloc: find movable zone after kernel text
> > >> 
> > >> In find_zone_movable_pfns_for_nodes(), when try to find the starting
> > >> PFN movable zone begins in each node, kernel text position is not
> > >> considered. KASLR may put kernel after which movable zone begins.
> > >> 
> > >> Fix it by finding movable zone after kernel text on that node.
> > >> 
> > >> Signed-off-by: Baoquan He <bhe@redhat.com>
> > >
> > >
> > >You fix this in the _zone_init side_. This may make the 'kernelcore=' or
> > >'movablecore=' failed if the KASLR puts the kernel back the tail of the
> > >last node, or more.
> > 
> > I think it may not fail.
> > There is a 'restart' to do another pass.
> > 
> > >
> > >Due to we have fix the mirror memory in KASLR side, and Chao is trying
> > >to fix the 'movable_node' in KASLR side. Have you had a chance to fix
> > >this in the KASLR side.
> > >
> > 
> > I think it's better to fix here, but not KASLR side.
> > Cause much more code will be change if doing it in KASLR side.
> > Since we didn't parse 'kernelcore' in compressed code, and you can see
> > the distribution of ZONE_MOVABLE need so much code, so we do not need
> > to do so much job in KASLR side. But here, several lines will be OK.
> 
> I am not able to find the beginning of the email thread right now. Could
> you summarize what is the actual problem please?

The bug is found on x86 now. 

When added "kernelcore=" or "movablecore=" into kernel command line,
kernel memory is spread evenly among nodes. However, this is right when
KASLR is not enabled, then kernel will be at 16M of place in x86 arch.
If KASLR enabled, it could be put any place from 16M to 64T randomly.
 
Consider a scenario, we have 10 nodes, and each node has 20G memory, and
we specify "kernelcore=50%", means each node will take 10G for
kernelcore, 10G for movable area. But this doesn't take kernel position
into consideration. E.g if kernel is put at 15G of 2nd node, namely
node1. Then we think on node1 there's 10G for kernelcore, 10G for
movable, in fact there's only 5G available for movable, just after
kernel.

I made a v4 patch which possibly can fix it.


From dbcac3631863aed556dc2c4ff1839772dfd02d18 Mon Sep 17 00:00:00 2001
From: Baoquan He <bhe@redhat.com>
Date: Fri, 13 Jul 2018 07:49:29 +0800
Subject: [PATCH v4] mm, page_alloc: find movable zone after kernel text

In find_zone_movable_pfns_for_nodes(), when try to find the starting
PFN movable zone begins at in each node, kernel text position is not
considered. KASLR may put kernel after which movable zone begins.

Fix it by finding movable zone after kernel text on that node.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/page_alloc.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1521100f1e63..5bc1a47dafda 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6547,7 +6547,7 @@ static unsigned long __init early_calculate_totalpages(void)
 static void __init find_zone_movable_pfns_for_nodes(void)
 {
 	int i, nid;
-	unsigned long usable_startpfn;
+	unsigned long usable_startpfn, kernel_endpfn, arch_startpfn;
 	unsigned long kernelcore_node, kernelcore_remaining;
 	/* save the state before borrow the nodemask */
 	nodemask_t saved_node_state = node_states[N_MEMORY];
@@ -6649,8 +6649,9 @@ static void __init find_zone_movable_pfns_for_nodes(void)
 	if (!required_kernelcore || required_kernelcore >= totalpages)
 		goto out;
 
+	kernel_endpfn = PFN_UP(__pa_symbol(_end));
 	/* usable_startpfn is the lowest possible pfn ZONE_MOVABLE can be at */
-	usable_startpfn = arch_zone_lowest_possible_pfn[movable_zone];
+	arch_startpfn = arch_zone_lowest_possible_pfn[movable_zone];
 
 restart:
 	/* Spread kernelcore memory as evenly as possible throughout nodes */
@@ -6659,6 +6660,16 @@ static void __init find_zone_movable_pfns_for_nodes(void)
 		unsigned long start_pfn, end_pfn;
 
 		/*
+		 * KASLR may put kernel near tail of node memory,
+		 * start after kernel on that node to find PFN
+		 * at which zone begins.
+		 */
+		if (pfn_to_nid(kernel_endpfn) == nid)
+		        usable_startpfn = max(arch_startpfn, kernel_endpfn);
+		else
+		        usable_startpfn = arch_startpfn;
+
+		/*
 		 * Recalculate kernelcore_node if the division per node
 		 * now exceeds what is necessary to satisfy the requested
 		 * amount of memory for the kernel
-- 
2.13.6

