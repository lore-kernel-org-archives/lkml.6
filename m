Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C00C7112C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCDEB20674
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCDEB20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbeJWEik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 00:38:40 -0400
Received: from mga12.intel.com ([192.55.52.136]:22201 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbeJWEij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 00:38:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2018 13:18:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,413,1534834800"; 
   d="scan'208";a="80062767"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga007.fm.intel.com with ESMTP; 22 Oct 2018 13:18:40 -0700
Subject: [PATCH 3/9] dax: add more kmem device infrastructure
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        dan.j.williams@intel.com, dave.jiang@intel.com, zwisler@kernel.org,
        vishal.l.verma@intel.com, thomas.lendacky@amd.com,
        akpm@linux-foundation.org, mhocko@suse.com,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        ying.huang@intel.com, fengguang.wu@intel.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Mon, 22 Oct 2018 13:13:22 -0700
References: <20181022201317.8558C1D8@viggo.jf.intel.com>
In-Reply-To: <20181022201317.8558C1D8@viggo.jf.intel.com>
Message-Id: <20181022201322.6C8A7B2A@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The previous patch is a simple copy of the pmem driver.  This
makes it easy while this is in development to keep the pmem
and kmem code in sync.

This actually adds some necessary infrastructure for the new
driver to compile.

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ross Zwisler <zwisler@kernel.org>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: linux-nvdimm@lists.01.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: Huang Ying <ying.huang@intel.com>
Cc: Fengguang Wu <fengguang.wu@intel.com>

---

 b/drivers/dax/kmem.c         |   10 +++++-----
 b/include/uapi/linux/ndctl.h |    2 ++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff -puN drivers/dax/kmem.c~dax-kmem-try-again-2018-2-header drivers/dax/kmem.c
--- a/drivers/dax/kmem.c~dax-kmem-try-again-2018-2-header	2018-10-22 13:12:22.000930392 -0700
+++ b/drivers/dax/kmem.c	2018-10-22 13:12:22.005930392 -0700
@@ -27,7 +27,7 @@ static struct dax_kmem *to_dax_kmem(stru
 
 static void dax_kmem_percpu_release(struct percpu_ref *ref)
 {
-	struct dax_kmem *dax_kmem = to_dax_pmem(ref);
+	struct dax_kmem *dax_kmem = to_dax_kmem(ref);
 
 	dev_dbg(dax_kmem->dev, "trace\n");
 	complete(&dax_kmem->cmp);
@@ -36,7 +36,7 @@ static void dax_kmem_percpu_release(stru
 static void dax_kmem_percpu_exit(void *data)
 {
 	struct percpu_ref *ref = data;
-	struct dax_kmem *dax_kmem = to_dax_pmem(ref);
+	struct dax_kmem *dax_kmem = to_dax_kmem(ref);
 
 	dev_dbg(dax_kmem->dev, "trace\n");
 	wait_for_completion(&dax_kmem->cmp);
@@ -46,7 +46,7 @@ static void dax_kmem_percpu_exit(void *d
 static void dax_kmem_percpu_kill(void *data)
 {
 	struct percpu_ref *ref = data;
-	struct dax_kmem *dax_kmem = to_dax_pmem(ref);
+	struct dax_kmem *dax_kmem = to_dax_kmem(ref);
 
 	dev_dbg(dax_kmem->dev, "trace\n");
 	percpu_ref_kill(ref);
@@ -142,11 +142,11 @@ static struct nd_device_driver dax_kmem_
 	.drv = {
 		.name = "dax_kmem",
 	},
-	.type = ND_DRIVER_DAX_PMEM,
+	.type = ND_DRIVER_DAX_KMEM,
 };
 
 module_nd_driver(dax_kmem_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Intel Corporation");
-MODULE_ALIAS_ND_DEVICE(ND_DEVICE_DAX_PMEM);
+MODULE_ALIAS_ND_DEVICE(ND_DEVICE_DAX_KMEM);
diff -puN include/uapi/linux/ndctl.h~dax-kmem-try-again-2018-2-header include/uapi/linux/ndctl.h
--- a/include/uapi/linux/ndctl.h~dax-kmem-try-again-2018-2-header	2018-10-22 13:12:22.002930392 -0700
+++ b/include/uapi/linux/ndctl.h	2018-10-22 13:12:22.005930392 -0700
@@ -197,6 +197,7 @@ static inline const char *nvdimm_cmd_nam
 #define ND_DEVICE_NAMESPACE_PMEM 5  /* PMEM namespace (may alias with BLK) */
 #define ND_DEVICE_NAMESPACE_BLK 6   /* BLK namespace (may alias with PMEM) */
 #define ND_DEVICE_DAX_PMEM 7        /* Device DAX interface to pmem */
+#define ND_DEVICE_DAX_KMEM 8        /* Normal kernel-managed system memory */
 
 enum nd_driver_flags {
 	ND_DRIVER_DIMM            = 1 << ND_DEVICE_DIMM,
@@ -206,6 +207,7 @@ enum nd_driver_flags {
 	ND_DRIVER_NAMESPACE_PMEM  = 1 << ND_DEVICE_NAMESPACE_PMEM,
 	ND_DRIVER_NAMESPACE_BLK   = 1 << ND_DEVICE_NAMESPACE_BLK,
 	ND_DRIVER_DAX_PMEM	  = 1 << ND_DEVICE_DAX_PMEM,
+	ND_DRIVER_DAX_KMEM	  = 1 << ND_DEVICE_DAX_KMEM,
 };
 
 enum {
_
