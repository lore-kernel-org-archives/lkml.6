Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03419C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95EB720862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:33:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95EB720862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408026AbeHATSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:18:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52944 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436578AbeHATSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:18:39 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0941FEA4;
        Wed,  1 Aug 2018 16:54:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Robert Elliott <elliott@hpe.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.17 005/336] mm: disallow mappings that conflict for devm_memremap_pages()
Date:   Wed,  1 Aug 2018 18:45:40 +0200
Message-Id: <20180801165029.129401653@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Jiang <dave.jiang@intel.com>

commit 15d36fecd0bdc7510b70a0e5ec6671140b3fce0c upstream.

When pmem namespaces created are smaller than section size, this can
cause an issue during removal and gpf was observed:

  general protection fault: 0000 1 SMP PTI
  CPU: 36 PID: 3941 Comm: ndctl Tainted: G W 4.14.28-1.el7uek.x86_64 #2
  task: ffff88acda150000 task.stack: ffffc900233a4000
  RIP: 0010:__put_page+0x56/0x79
  Call Trace:
    devm_memremap_pages_release+0x155/0x23a
    release_nodes+0x21e/0x260
    devres_release_all+0x3c/0x48
    device_release_driver_internal+0x15c/0x207
    device_release_driver+0x12/0x14
    unbind_store+0xba/0xd8
    drv_attr_store+0x27/0x31
    sysfs_kf_write+0x3f/0x46
    kernfs_fop_write+0x10f/0x18b
    __vfs_write+0x3a/0x16d
    vfs_write+0xb2/0x1a1
    SyS_write+0x55/0xb9
    do_syscall_64+0x79/0x1ae
    entry_SYSCALL_64_after_hwframe+0x3d/0x0

Add code to check whether we have a mapping already in the same section
and prevent additional mappings from being created if that is the case.

Link: http://lkml.kernel.org/r/152909478401.50143.312364396244072931.stgit@djiang5-desk3.ch.intel.com
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Robert Elliott <elliott@hpe.com>
Cc: Jeff Moyer <jmoyer@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/memremap.c |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -348,10 +348,27 @@ void *devm_memremap_pages(struct device
 	unsigned long pfn, pgoff, order;
 	pgprot_t pgprot = PAGE_KERNEL;
 	int error, nid, is_ram;
+	struct dev_pagemap *conflict_pgmap;
 
 	align_start = res->start & ~(SECTION_SIZE - 1);
 	align_size = ALIGN(res->start + resource_size(res), SECTION_SIZE)
 		- align_start;
+	align_end = align_start + align_size - 1;
+
+	conflict_pgmap = get_dev_pagemap(PHYS_PFN(align_start), NULL);
+	if (conflict_pgmap) {
+		dev_WARN(dev, "Conflicting mapping in same section\n");
+		put_dev_pagemap(conflict_pgmap);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	conflict_pgmap = get_dev_pagemap(PHYS_PFN(align_end), NULL);
+	if (conflict_pgmap) {
+		dev_WARN(dev, "Conflicting mapping in same section\n");
+		put_dev_pagemap(conflict_pgmap);
+		return ERR_PTR(-ENOMEM);
+	}
+
 	is_ram = region_intersects(align_start, align_size,
 		IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE);
 
@@ -371,7 +388,6 @@ void *devm_memremap_pages(struct device
 
 	mutex_lock(&pgmap_lock);
 	error = 0;
-	align_end = align_start + align_size - 1;
 
 	foreach_order_pgoff(res, order, pgoff) {
 		error = __radix_tree_insert(&pgmap_radix,


