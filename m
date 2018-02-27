Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751706AbeB0RaF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 12:30:05 -0500
Received: from mga03.intel.com ([134.134.136.65]:38451 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751516AbeB0RaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 12:30:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,401,1515484800";
   d="scan'208";a="23638773"
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: [PATCH 2/3] nfit_test: fix buffer overrun, add sanity check
Date: Tue, 27 Feb 2018 10:29:51 -0700
Message-Id: <20180227172952.22177-2-ross.zwisler@linux.intel.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180227172952.22177-1-ross.zwisler@linux.intel.com>
References: <20180227172952.22177-1-ross.zwisler@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that we were overrunning the 'nfit_buf' buffer in
nfit_test0_setup() in the (t->setup_hotplug == 1) case because we failed to
correctly account for all of the acpi_nfit_memory_map structures.

Fix the structure count which will increase the allocation size of
'nfit_buf' in nfit_test0_alloc().  Also add some WARN_ON()s to
nfit_test0_setup() and nfit_test1_setup() to catch future issues where the
size of the buffer doesn't match the amount of data we're writing.

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
---
 tools/testing/nvdimm/test/nfit.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index 1376fc95c33a..fcd233342273 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -104,7 +104,8 @@ enum {
 	NUM_HINTS = 8,
 	NUM_BDW = NUM_DCR,
 	NUM_SPA = NUM_PM + NUM_DCR + NUM_BDW,
-	NUM_MEM = NUM_DCR + NUM_BDW + 2 /* spa0 iset */ + 4 /* spa1 iset */,
+	NUM_MEM = NUM_DCR + NUM_BDW + 2 /* spa0 iset */
+		+ 4 /* spa1 iset */ + 1 /* spa11 iset */,
 	DIMM_SIZE = SZ_32M,
 	LABEL_SIZE = SZ_128K,
 	SPA_VCD_SIZE = SZ_4M,
@@ -2047,6 +2048,9 @@ static void nfit_test0_setup(struct nfit_test *t)
 			flush->hint_address[i] = t->flush_dma[4]
 				+ i * sizeof(u64);
 		offset += flush->header.length;
+
+		/* sanity check to make sure we've filled the buffer */
+		WARN_ON(offset != t->nfit_size);
 	}
 
 	post_ars_status(&t->ars_state, &t->badrange, t->spa_set_dma[0],
@@ -2165,6 +2169,9 @@ static void nfit_test1_setup(struct nfit_test *t)
 	dcr->windows = 0;
 	offset += dcr->header.length;
 
+	/* sanity check to make sure we've filled the buffer */
+	WARN_ON(offset != t->nfit_size);
+
 	post_ars_status(&t->ars_state, &t->badrange, t->spa_set_dma[0],
 			SPA2_SIZE);
 
-- 
2.14.3
