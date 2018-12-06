Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98FAC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B77E208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B77E208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbeLFNTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 08:19:36 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:52218 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbeLFNTf (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Thu, 6 Dec 2018 08:19:35 -0500
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Thu, 06 Dec 2018 14:19:33 +0100
Received: from d104.suse.de (nwb-a10-snat.microfocus.com [10.120.13.202])
        by emea4-mta.ukb.novell.com with ESMTP (NOT encrypted); Thu, 06 Dec 2018 13:19:23 +0000
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH] mm, kmemleak: Little optimization while scanning
Date:   Thu,  6 Dec 2018 14:19:18 +0100
Message-Id: <20181206131918.25099-1-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemleak_scan() goes through all online nodes and tries
to scan all used pages.
We can do better and use pfn_to_online_page(), so in case we have
CONFIG_MEMORY_HOTPLUG, offlined pages will be skiped automatically.
For boxes where CONFIG_MEMORY_HOTPLUG is not present, pfn_to_online_page()
will fallback to pfn_valid().

Another little optimization is to check if the page belongs to the node
we are currently checking, so in case we have nodes interleaved we will
not check the same pfn multiple times.

I ran some tests:

Add some memory to node1 and node2 making it interleaved:

(qemu) object_add memory-backend-ram,id=ram0,size=1G
(qemu) device_add pc-dimm,id=dimm0,memdev=ram0,node=1
(qemu) object_add memory-backend-ram,id=ram1,size=1G
(qemu) device_add pc-dimm,id=dimm1,memdev=ram1,node=2
(qemu) object_add memory-backend-ram,id=ram2,size=1G
(qemu) device_add pc-dimm,id=dimm2,memdev=ram2,node=1

Then, we offline that memory:
 # for i in {32..39} ; do echo "offline" > /sys/devices/system/node/node1/memory$i/state;done
 # for i in {48..55} ; do echo "offline" > /sys/devices/system/node/node1/memory$i/state;don
 # for i in {40..47} ; do echo "offline" > /sys/devices/system/node/node2/memory$i/state;done

And we run kmemleak_scan:

 # echo "scan" > /sys/kernel/debug/kmemleak

before the patch:

kmemleak: time spend: 41596 us

after the patch:

kmemleak: time spend: 34899 us

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/kmemleak.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 877de4fa0720..5ce1e6a46d77 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -113,6 +113,7 @@
 #include <linux/kmemleak.h>
 #include <linux/memory_hotplug.h>
 
+
 /*
  * Kmemleak configuration and common defines.
  */
@@ -1547,11 +1548,14 @@ static void kmemleak_scan(void)
 		unsigned long pfn;
 
 		for (pfn = start_pfn; pfn < end_pfn; pfn++) {
-			struct page *page;
+			struct page *page = pfn_to_online_page(pfn);
+
+			if (!page)
+				continue;
 
-			if (!pfn_valid(pfn))
+			/* only scan pages belonging to this node */
+			if (page_to_nid(page) != i)
 				continue;
-			page = pfn_to_page(pfn);
 			/* only scan if page is in use */
 			if (page_count(page) == 0)
 				continue;
-- 
2.13.7

