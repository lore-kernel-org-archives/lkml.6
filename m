Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96DEC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A4A21480
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DewpreW3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A4A21480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbeJSCEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:04:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729070AbeJSCEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:04:23 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A35421476;
        Thu, 18 Oct 2018 18:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885737;
        bh=rBVOJlv3wSGRLlQK9rVSv2XUWl1FpwMRgMbadrUp0lY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DewpreW3BX7AvVU6t3SLCieDQWjA784IIR6yXNwRBFHX1rQ0tnWE4kt8wtVpsum43
         30T/kJ4u3qR1PBe4euGBlXrY6UEokCV4k/7WlodvqhyfaGfCabJBefWOri1pDlpRCU
         4b8k/Q1APzuhaxlqVBbN1fsSUras3akKvXGmgEWQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Robert Elliott <elliott@hpe.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 38/41] mm: disallow mappings that conflict for devm_memremap_pages()
Date:   Thu, 18 Oct 2018 19:54:53 +0200
Message-Id: <20181018175423.284909039@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175416.718399607@linuxfoundation.org>
References: <20181018175416.718399607@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/memremap.c |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -355,10 +355,27 @@ void *devm_memremap_pages(struct device
 	struct dev_pagemap *pgmap;
 	struct page_map *page_map;
 	int error, nid, is_ram, i = 0;
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
 
@@ -396,7 +413,6 @@ void *devm_memremap_pages(struct device
 
 	mutex_lock(&pgmap_lock);
 	error = 0;
-	align_end = align_start + align_size - 1;
 
 	foreach_order_pgoff(res, order, pgoff) {
 		struct dev_pagemap *dup;


