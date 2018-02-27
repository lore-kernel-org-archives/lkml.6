Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751789AbeB0RaH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 12:30:07 -0500
Received: from mga03.intel.com ([134.134.136.65]:38451 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751654AbeB0RaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 12:30:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,401,1515484800";
   d="scan'208";a="23638780"
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: [PATCH 3/3] nfit_test: prevent parsing error of nfit_test.0
Date: Tue, 27 Feb 2018 10:29:52 -0700
Message-Id: <20180227172952.22177-3-ross.zwisler@linux.intel.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180227172952.22177-1-ross.zwisler@linux.intel.com>
References: <20180227172952.22177-1-ross.zwisler@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When you load nfit_test you currently see the following error in dmesg:

 nfit_test nfit_test.0: found a zero length table '0' parsing nfit

This happens because when we parse the nfit_test.0 table via
acpi_nfit_init(), we specify a size of nfit_test->nfit_size.  For the first
pass through nfit_test.0 where (t->setup_hotplug == 0) this is the size of
the entire buffer we allocated, including space for the hot plug
structures, not the size that we've actually filled in.

Fix this by only trying to parse the size of the structures that we've
filled in.

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
---
 tools/testing/nvdimm/test/nfit.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index fcd233342273..d785235ba04e 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -154,6 +154,7 @@ struct nfit_test {
 	void *nfit_buf;
 	dma_addr_t nfit_dma;
 	size_t nfit_size;
+	size_t nfit_filled;
 	int dcr_idx;
 	int num_dcr;
 	int num_pm;
@@ -2053,6 +2054,8 @@ static void nfit_test0_setup(struct nfit_test *t)
 		WARN_ON(offset != t->nfit_size);
 	}
 
+	t->nfit_filled = offset;
+
 	post_ars_status(&t->ars_state, &t->badrange, t->spa_set_dma[0],
 			SPA0_SIZE);
 
@@ -2172,6 +2175,8 @@ static void nfit_test1_setup(struct nfit_test *t)
 	/* sanity check to make sure we've filled the buffer */
 	WARN_ON(offset != t->nfit_size);
 
+	t->nfit_filled = offset;
+
 	post_ars_status(&t->ars_state, &t->badrange, t->spa_set_dma[0],
 			SPA2_SIZE);
 
@@ -2529,7 +2534,7 @@ static int nfit_test_probe(struct platform_device *pdev)
 	nd_desc->ndctl = nfit_test_ctl;
 
 	rc = acpi_nfit_init(acpi_desc, nfit_test->nfit_buf,
-			nfit_test->nfit_size);
+			nfit_test->nfit_filled);
 	if (rc)
 		return rc;
 
-- 
2.14.3
