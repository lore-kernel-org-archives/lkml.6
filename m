Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B31C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 07:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92E0218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 07:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbfBFHYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 02:24:55 -0500
Received: from mga02.intel.com ([134.134.136.20]:22884 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbfBFHYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 02:24:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 23:24:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,339,1544515200"; 
   d="scan'208";a="144567009"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga001.fm.intel.com with ESMTP; 05 Feb 2019 23:24:53 -0800
Subject: [PATCH 2/2] [-mm only] mm/shuffle: Default enable all shuffling
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 05 Feb 2019 23:12:15 -0800
Message-ID: <154943713572.3858443.11206307988382889377.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <154943712485.3858443.4491117952728936852.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <154943712485.3858443.4491117952728936852.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per Andrew's request arrange for all memory allocation shuffling code to
be enabled by default.

The page_alloc.shuffle command line parameter can still be used to
disable shuffling at boot, but the kernel will default enable the
shuffling if the command line option is not specified.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 init/Kconfig |    4 ++--
 mm/shuffle.c |    4 ++--
 mm/shuffle.h |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index cfa199f3e9be..12557e12be4c 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1697,7 +1697,7 @@ config SLAB_MERGE_DEFAULT
 	  command line.
 
 config SLAB_FREELIST_RANDOM
-	default n
+	default y
 	depends on SLAB || SLUB
 	bool "SLAB freelist randomization"
 	help
@@ -1716,7 +1716,7 @@ config SLAB_FREELIST_HARDENED
 
 config SHUFFLE_PAGE_ALLOCATOR
 	bool "Page allocator randomization"
-	default SLAB_FREELIST_RANDOM && ACPI_NUMA
+	default y
 	help
 	  Randomization of the page allocator improves the average
 	  utilization of a direct-mapped memory-side-cache. See section
diff --git a/mm/shuffle.c b/mm/shuffle.c
index 3ce12481b1dc..a979b48be469 100644
--- a/mm/shuffle.c
+++ b/mm/shuffle.c
@@ -9,8 +9,8 @@
 #include "internal.h"
 #include "shuffle.h"
 
-DEFINE_STATIC_KEY_FALSE(page_alloc_shuffle_key);
-static unsigned long shuffle_state __ro_after_init;
+DEFINE_STATIC_KEY_TRUE(page_alloc_shuffle_key);
+static unsigned long shuffle_state __ro_after_init = 1 << SHUFFLE_ENABLE;
 
 /*
  * Depending on the architecture, module parameter parsing may run
diff --git a/mm/shuffle.h b/mm/shuffle.h
index fc1e327ae22d..466a5620e0aa 100644
--- a/mm/shuffle.h
+++ b/mm/shuffle.h
@@ -19,7 +19,7 @@ enum mm_shuffle_ctl {
 #define SHUFFLE_ORDER (MAX_ORDER-1)
 
 #ifdef CONFIG_SHUFFLE_PAGE_ALLOCATOR
-DECLARE_STATIC_KEY_FALSE(page_alloc_shuffle_key);
+DECLARE_STATIC_KEY_TRUE(page_alloc_shuffle_key);
 extern void page_alloc_shuffle(enum mm_shuffle_ctl ctl);
 extern void __shuffle_free_memory(pg_data_t *pgdat);
 static inline void shuffle_free_memory(pg_data_t *pgdat)

