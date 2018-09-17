Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31F2ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651FB2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 651FB2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731792AbeIREiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:38:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49960 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbeIREiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:38:13 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9EC46707;
        Mon, 17 Sep 2018 23:08:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.18 008/158] memory_hotplug: fix kernel_panic on offline page processing
Date:   Tue, 18 Sep 2018 00:40:38 +0200
Message-Id: <20180917211710.987209166@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikhail Zaslonko <zaslonko@linux.ibm.com>

commit 4e8346d0be889c7ab5eb2d3deedc18111d741e99 upstream.

Within show_valid_zones() the function test_pages_in_a_zone() should be
called for online memory blocks only.

Otherwise it might lead to the VM_BUG_ON due to uninitialized struct
pages (when CONFIG_DEBUG_VM_PGFLAGS kernel option is set):

 page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
 ------------[ cut here ]------------
 Call Trace:
 ([<000000000038f91e>] test_pages_in_a_zone+0xe6/0x168)
  [<0000000000923472>] show_valid_zones+0x5a/0x1a8
  [<0000000000900284>] dev_attr_show+0x3c/0x78
  [<000000000046f6f0>] sysfs_kf_seq_show+0xd0/0x150
  [<00000000003ef662>] seq_read+0x212/0x4b8
  [<00000000003bf202>] __vfs_read+0x3a/0x178
  [<00000000003bf3ca>] vfs_read+0x8a/0x148
  [<00000000003bfa3a>] ksys_read+0x62/0xb8
  [<0000000000bc2220>] system_call+0xdc/0x2d8

That VM_BUG_ON was triggered by the page poisoning introduced in
mm/sparse.c with the git commit d0dc12e86b31 ("mm/memory_hotplug:
optimize memory hotplug").

With the same commit the new 'nid' field has been added to the struct
memory_block in order to store and later on derive the node id for
offline pages (instead of accessing struct page which might be
uninitialized).  But one reference to nid in show_valid_zones() function
has been overlooked.  Fixed with current commit.  Also, nr_pages will
not be used any more after test_pages_in_a_zone() call, do not update
it.

Link: http://lkml.kernel.org/r/20180828090539.41491-1-zaslonko@linux.ibm.com
Fixes: d0dc12e86b31 ("mm/memory_hotplug: optimize memory hotplug")
Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
Cc: <stable@vger.kernel.org>	[4.17+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/base/memory.c |   20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -417,25 +417,23 @@ static ssize_t show_valid_zones(struct d
 	int nid;
 
 	/*
-	 * The block contains more than one zone can not be offlined.
-	 * This can happen e.g. for ZONE_DMA and ZONE_DMA32
-	 */
-	if (!test_pages_in_a_zone(start_pfn, start_pfn + nr_pages, &valid_start_pfn, &valid_end_pfn))
-		return sprintf(buf, "none\n");
-
-	start_pfn = valid_start_pfn;
-	nr_pages = valid_end_pfn - start_pfn;
-
-	/*
 	 * Check the existing zone. Make sure that we do that only on the
 	 * online nodes otherwise the page_zone is not reliable
 	 */
 	if (mem->state == MEM_ONLINE) {
+		/*
+		 * The block contains more than one zone can not be offlined.
+		 * This can happen e.g. for ZONE_DMA and ZONE_DMA32
+		 */
+		if (!test_pages_in_a_zone(start_pfn, start_pfn + nr_pages,
+					  &valid_start_pfn, &valid_end_pfn))
+			return sprintf(buf, "none\n");
+		start_pfn = valid_start_pfn;
 		strcat(buf, page_zone(pfn_to_page(start_pfn))->name);
 		goto out;
 	}
 
-	nid = pfn_to_nid(start_pfn);
+	nid = mem->nid;
 	default_zone = zone_for_pfn_range(MMOP_ONLINE_KEEP, nid, start_pfn, nr_pages);
 	strcat(buf, default_zone->name);
 


