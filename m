Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F42BC71133
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D79A3214C3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D79A3214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbeJPBp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 21:45:26 -0400
Received: from ale.deltatee.com ([207.54.116.67]:54708 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbeJPBnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 21:43:35 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1gC77D-0002IJ-IV; Mon, 15 Oct 2018 11:57:16 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1gC779-0002Md-7J; Mon, 15 Oct 2018 11:57:11 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Oscar Salvador <osalvador@suse.de>
Date:   Mon, 15 Oct 2018 11:56:58 -0600
Message-Id: <20181015175702.9036-3-logang@deltatee.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181015175702.9036-1-logang@deltatee.com>
References: <20181015175702.9036-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-mm@kvack.org, linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, sbates@raithlin.com, palmer@sifive.com, aou@eecs.berkeley.edu, hch@lst.de, akpm@linux-foundation.org, arnd@arndb.de, logang@deltatee.com, mhocko@suse.com, vbabka@suse.cz, pasha.tatashin@oracle.com, osalvador@suse.de
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v2 2/6] mm/sparse: add common helper to mark all memblocks present
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Presently the arches arm64, arm and sh have a function which loops through
each memblock and calls memory present. riscv will require a similar
function.

Introduce a common memblocks_present() function that can be used by
all the arches. Subsequent patches will cleanup the arches that
make use of this.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Oscar Salvador <osalvador@suse.de>
---
 include/linux/mmzone.h |  6 ++++++
 mm/sparse.c            | 14 ++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index d4b0c79d2924..26a026a45857 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -784,6 +784,12 @@ void memory_present(int nid, unsigned long start, unsigned long end);
 static inline void memory_present(int nid, unsigned long start, unsigned long end) {}
 #endif
 
+#if defined(CONFIG_SPARSEMEM) && defined(CONFIG_HAVE_MEMBLOCK)
+void memblocks_present(void);
+#else
+static inline void memblocks_present(void) {}
+#endif
+
 #ifdef CONFIG_HAVE_MEMORYLESS_NODES
 int local_memory_node(int node_id);
 #else
diff --git a/mm/sparse.c b/mm/sparse.c
index 10b07eea9a6e..90aec8331a03 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -5,6 +5,7 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/mmzone.h>
+#include <linux/memblock.h>
 #include <linux/bootmem.h>
 #include <linux/compiler.h>
 #include <linux/highmem.h>
@@ -238,6 +239,19 @@ void __init memory_present(int nid, unsigned long start, unsigned long end)
 	}
 }
 
+#ifdef CONFIG_HAVE_MEMBLOCK
+void __init memblocks_present(void)
+{
+	struct memblock_region *reg;
+
+	for_each_memblock(memory, reg) {
+		memory_present(memblock_get_region_node(reg),
+			       memblock_region_memory_base_pfn(reg),
+			       memblock_region_memory_end_pfn(reg));
+	}
+}
+#endif
+
 /*
  * Subtle, we encode the real pfn into the mem_map such that
  * the identity pfn - section_mem_map will return the actual
-- 
2.19.0

