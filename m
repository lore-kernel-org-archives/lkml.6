Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCDEC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D40208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3D40208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730002AbeJEXQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:16:13 -0400
Received: from ale.deltatee.com ([207.54.116.67]:32874 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729963AbeJEXQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:16:12 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1g8SmU-0008D2-45; Fri, 05 Oct 2018 10:16:47 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1g8SmR-0000eX-VZ; Fri, 05 Oct 2018 10:16:44 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christoph Hellwig <hch@lst.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Oscar Salvador <osalvador@suse.de>
Date:   Fri,  5 Oct 2018 10:16:38 -0600
Message-Id: <20181005161642.2462-2-logang@deltatee.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181005161642.2462-1-logang@deltatee.com>
References: <20181005161642.2462-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-mm@kvack.org, linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, sbates@raithlin.com, palmer@sifive.com, aou@eecs.berkeley.edu, hch@lst.de, logang@deltatee.com, akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz, pasha.tatashin@oracle.com, osalvador@suse.de
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH 1/5] mm/sparse: add common helper to mark all memblocks present
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Presently the arches arm64, arm, sh have a function which loops through
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
 mm/sparse.c            | 15 +++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 1e22d96734e0..a10fc3c18b07 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -794,6 +794,12 @@ void memory_present(int nid, unsigned long start, unsigned long end);
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
index 10b07eea9a6e..109159574208 100644
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
@@ -238,6 +239,20 @@ void __init memory_present(int nid, unsigned long start, unsigned long end)
 	}
 }
 
+#ifdef CONFIG_HAVE_MEMBLOCK
+void __init memblocks_present(void)
+{
+	struct memblock_region *reg;
+
+	for_each_memblock(memory, reg) {
+		int nid = memblock_get_region_node(reg);
+
+		memory_present(nid, memblock_region_memory_base_pfn(reg),
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

