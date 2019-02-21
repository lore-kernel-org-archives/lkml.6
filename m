Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2725C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D74F2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbfBUJmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:42:36 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:54615 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727812AbfBUJm3 (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Thu, 21 Feb 2019 04:42:29 -0500
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Thu, 21 Feb 2019 10:42:27 +0100
Received: from d104.suse.de (nwb-a10-snat.microfocus.com [10.120.13.202])
        by emea4-mta.ukb.novell.com with ESMTP (NOT encrypted); Thu, 21 Feb 2019 09:42:17 +0000
From:   Oscar Salvador <osalvador@suse.de>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, david@redhat.com,
        mike.kravetz@oracle.com, Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH] mm,memory_hotplug: Unlock 1GB-hugetlb on x86_64
Date:   Thu, 21 Feb 2019 10:42:12 +0100
Message-Id: <20190221094212.16906-1-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On x86_64, 1GB-hugetlb pages could never be offlined due to the fact
that hugepage_migration_supported() returned false for PUD_SHIFT.
So whenever we wanted to offline a memblock containing a gigantic
hugetlb page, we never got beyond has_unmovable_pages() check.
This changed with [1], where now we also return true for PUD_SHIFT.

After that patch, the check in has_unmovable_pages() and scan_movable_pages()
returned true, but we still had a final barrier in do_migrate_range():

if (compound_order(head) > PFN_SECTION_SHIFT) {
	ret = -EBUSY;
	break;
}

This is not really nice, and we do not really need it.
It is perfectly possible to migrate a gigantic page as long as another node has
a spare gigantic page for us.
In alloc_huge_page_nodemask(), we calculate the __real__ number of free pages,
and if any, we try to dequeue one from another node.

This all works fine when we do have another node with a spare gigantic page,
but if that is not the case, alloc_huge_page_nodemask() ends up calling
alloc_migrate_huge_page() which bails out if the wanted page is gigantic.
That is mainly because finding a 1GB (or even 16GB on powerpc) contiguous
memory is quite unlikely when the system has been running for a while.

In that situation, we will keep looping forever because scan_movable_pages()
will give us the same page and we will fail again because there is no node
where we can dequeue a gigantic page from.
This is not nice, and I wish we could differentiate a fatal error from a
transient error in do_migrate_range()->migrate_pages(), but I do not really
see a way now.

Anyway, I would tend say that this is the administrator's job, to make sure
that the system can keep up with the memory to be offlined, so that would mean
that if we want to use gigantic pages, make sure that the other nodes have at
least enough gigantic pages to keep up in case we need to offline memory.

Just for the sake of completeness, this is one of the tests done:

 # echo 1 > /sys/devices/system/node/node1/hugepages/hugepages-1048576kB/nr_hugepages
 # echo 1 > /sys/devices/system/node/node2/hugepages/hugepages-1048576kB/nr_hugepages

 # cat /sys/devices/system/node/node1/hugepages/hugepages-1048576kB/nr_hugepages
   1
 # cat /sys/devices/system/node/node1/hugepages/hugepages-1048576kB/free_hugepages
   1

 # cat /sys/devices/system/node/node2/hugepages/hugepages-1048576kB/nr_hugepages
   1
 # cat /sys/devices/system/node/node2/hugepages/hugepages-1048576kB/free_hugepages
   1

 (hugetlb1gb is a program that maps 1GB region using MAP_HUGE_1GB)

 # numactl -m 1 ./hugetlb1gb
 # cat /sys/devices/system/node/node1/hugepages/hugepages-1048576kB/free_hugepages
   0
 # cat /sys/devices/system/node/node2/hugepages/hugepages-1048576kB/free_hugepages
   1

 # offline node1 memory
 # cat /sys/devices/system/node/node2/hugepages/hugepages-1048576kB/free_hugepages
   0

[1] https://lore.kernel.org/patchwork/patch/998796/

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/memory_hotplug.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index d5f7afda67db..04f6695b648c 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1337,8 +1337,7 @@ static unsigned long scan_movable_pages(unsigned long start, unsigned long end)
 		if (!PageHuge(page))
 			continue;
 		head = compound_head(page);
-		if (hugepage_migration_supported(page_hstate(head)) &&
-		    page_huge_active(head))
+		if (page_huge_active(head))
 			return pfn;
 		skip = (1 << compound_order(head)) - (page - head);
 		pfn += skip - 1;
@@ -1378,10 +1377,6 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 
 		if (PageHuge(page)) {
 			struct page *head = compound_head(page);
-			if (compound_order(head) > PFN_SECTION_SHIFT) {
-				ret = -EBUSY;
-				break;
-			}
 			pfn = page_to_pfn(head) + (1<<compound_order(head)) - 1;
 			isolate_huge_page(head, &source);
 			continue;
-- 
2.13.7

