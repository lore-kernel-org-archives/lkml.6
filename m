Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93B4C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 934F9204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:11:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 934F9204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbeKASNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 14:13:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45222 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbeKASNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 14:13:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4112430842A9;
        Thu,  1 Nov 2018 09:10:59 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 68E385C22B;
        Thu,  1 Nov 2018 09:10:58 +0000 (UTC)
Date:   Thu, 1 Nov 2018 17:10:55 +0800
From:   Baoquan He <bhe@redhat.com>
To:     mhocko@suse.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Memory hotplug failed to offline on bare metal system of multiple
 nodes
Message-ID: <20181101091055.GA15166@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 01 Nov 2018 09:10:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A hot removal failure was met on one bare metal system with 8 nodes, and
node1~7 are all hotpluggable and 'movable_node' is set. When try to check
value of  /sys/devices/system/node/node1/memory*/removable, found some of
them are 0, namely un-removable. And a back trace will always be seen. After
bisecting, it points at criminal commit:

  15c30bc09085  ("mm, memory_hotplug: make has_unmovable_pages more robust")

Reverting it fix the failure, and node1~7 can be hot removed and hot
added again. From the log of commit 15c30bc09085, it's to fix a
movable_core setting issue which we allocated node_data firstly in
initmem_init(), then try to mark it as movable in mm_init(). We may need
think about it further to fix it, meanwhile not breaking bare metal
system.

I haven't figured out why the above commit caused those memmory
block in MOVABL zone being not removable. Still checking. Attach the
tested reverting patch in this mail.

Thanks
Baoquan

From 6644aefdf0f2499f7c7c3f30c7c31e791fe3c05a Mon Sep 17 00:00:00 2001
From: Baoquan He <bhe@redhat.com>
Date: Thu, 1 Nov 2018 11:52:41 +0800
Subject: [PATCH] mm, memory_hotplug: memory block failed to offline

On bare metal with multiple nodes, hot removing a memory board will
fail on those hotpluggable node since some memory blocks can't be
offlined. Checking node memory attribute, not all memory blocks are
removable even though they are in MOVABLE zone. And below trace can
always be seen triggered by the checking.

CPU: 60 PID: 4944 Comm: cat Not tainted 4.19.0+ #1
Hardware name:  9008/IT91SMUB, BIOS BLXSV512 03/22/2018
RIP: 0010:has_unmovable_pages+0x154/0x170
Code: 98 49 09 c5 eb c8 8b 43 30 25 80 00 00 f0 3d 00 00 00 f0 75 b9 48 8b 4b 28 b8 01 00 00 00 d3 e0 83 e8 01 48 98 49 01 c5 eb a4 <0f> 0b e9 49 ff ff ff 31 c0 e9 42 ff ff ff 0f 1f 40 00 66 2e 0f 1f
RSP: 0018:ffffc9000e6d3d48 EFLAGS: 00010246
RAX: 0000000000000001 RBX: ffffea043fbda2c0 RCX: 0000000000000000
RDX: dead0000000000ff RSI: 0000000010fef600 RDI: ffffea043fbda2c0
RBP: 0000000010fef600 R08: 0000000000000001 R09: ffff880e4c4918c0
R10: ffff880e5a4a3d40 R11: 0000000000000001 R12: 0000000000001140
R13: 000000000000008b R14: 0000000000000001 R15: 0000000000000001
FS:  00007f97b6805540(0000) GS:ffff880e7d980000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000557f1bf44000 CR3: 0000000e27c06001 CR4: 00000000003606e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 is_mem_section_removable+0x76/0x100
 show_mem_removable+0x6e/0xa0
 dev_attr_show+0x1c/0x40
 sysfs_kf_seq_show+0x9f/0x120
 seq_read+0x153/0x410
 __vfs_read+0x36/0x190
 vfs_read+0x8a/0x140
 ksys_read+0x4f/0xb0
 do_syscall_64+0x55/0x1a0
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f97b630d2a5
Code: fe ff ff 50 48 8d 3d 02 df 09 00 e8 75 11 02 00 0f 1f 44 00 00 f3 0f 1e fa 48 8d 05 75 64 2d 00 8b 00 85 c0 75 0f 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 53 c3 66 90 41 54 49 89 d4 55 48 89 f5 53 89
RSP: 002b:00007ffc8ce8e448 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f97b630d2a5
RDX: 0000000000020000 RSI: 0000557f1bf44000 RDI: 0000000000000003
RBP: 0000557f1bf44000 R08: 0000000000000003 R09: 000000000000007b
R10: 0000557f1bf3e010 R11: 0000000000000246 R12: 0000557f1bf44000
R13: 0000000000000003 R14: 0000000000000fff R15: 0000000000020000
---[ end trace aa042f77d15c548c ]---


Bisecting points to below commit as criminal:

  15c30bc09085 ("mm, memory_hotplug: make has_unmovable_pages more robust")

Reverting fixs the offline failure, and hot removing also succeeds.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/page_alloc.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a919ba5..b48b5eb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7760,12 +7760,11 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
 	unsigned long pfn, iter, found;
 
 	/*
-	 * TODO we could make this much more efficient by not checking every
-	 * page in the range if we know all of them are in MOVABLE_ZONE and
-	 * that the movable zone guarantees that pages are migratable but
-	 * the later is not the case right now unfortunatelly. E.g. movablecore
-	 * can still lead to having bootmem allocations in zone_movable.
+	 * For avoiding noise data, lru_add_drain_all() should be called
+	 * If ZONE_MOVABLE, the zone never contains unmovable pages
 	 */
+	if (zone_idx(zone) == ZONE_MOVABLE)
+		return false;
 
 	/*
 	 * CMA allocations (alloc_contig_range) really need to mark isolate
@@ -7786,7 +7785,7 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
 		page = pfn_to_page(check);
 
 		if (PageReserved(page))
-			goto unmovable;
+			return true;
 
 		/*
 		 * Hugepages are not in LRU lists, but they're movable.
@@ -7796,7 +7795,7 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
 		if (PageHuge(page)) {
 
 			if (!hugepage_migration_supported(page_hstate(page)))
-				goto unmovable;
+				return true;
 
 			iter = round_up(iter + 1, 1<<compound_order(page)) - 1;
 			continue;
@@ -7840,12 +7839,9 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
 		 * page at boot.
 		 */
 		if (found > count)
-			goto unmovable;
+			return true;
 	}
 	return false;
-unmovable:
-	WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE);
-	return true;
 }
 
 #if (defined(CONFIG_MEMORY_ISOLATION) && defined(CONFIG_COMPACTION)) || defined(CONFIG_CMA)
-- 
2.1.0

