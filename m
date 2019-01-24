Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C629CC282C0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 02:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 960CE2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 02:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfAXCgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 21:36:22 -0500
Received: from mga04.intel.com ([192.55.52.120]:30282 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726517AbfAXCgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 21:36:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jan 2019 18:36:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,514,1539673200"; 
   d="scan'208";a="137255976"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by fmsmga002.fm.intel.com with ESMTP; 23 Jan 2019 18:36:19 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Leave scalable mode default off
Date:   Thu, 24 Jan 2019 10:31:32 +0800
Message-Id: <20190124023132.20410-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 765b6a98c1de3 ("iommu/vt-d: Enumerate the scalable
mode capability") enables VT-d scalable mode if hardware
advertises the capability. As we will bring up different
features and use cases to upstream in different patch
series, it will leave some intermediate kernel versions
which support partial features. Hence, end user might run
into problems when they use such kernels on bare metals
or virtualization environments.

This leaves scalable mode default off and end users could
turn it on with "intel-iommu=sm_on" only when they have
clear ideas about which scalable features are supported
in the kernel.

Cc: Liu Yi L <yi.l.liu@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Suggested-by: Ashok Raj <ashok.raj@intel.com>
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 +++----
 drivers/iommu/intel-iommu.c                     | 8 ++++----
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b799bcf67d7b..858b6c0b9a15 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1696,12 +1696,11 @@
 			By default, super page will be supported if Intel IOMMU
 			has the capability. With this option, super page will
 			not be supported.
-		sm_off [Default Off]
-			By default, scalable mode will be supported if the
+		sm_on [Default Off]
+			By default, scalable mode will be disabled even if the
 			hardware advertises that it has support for the scalable
 			mode translation. With this option set, scalable mode
-			will not be used even on hardware which claims to support
-			it.
+			will be used on hardware which claims to support it.
 		tboot_noforce [Default Off]
 			Do not force the Intel IOMMU enabled under tboot.
 			By default, tboot will force Intel IOMMU on, which
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 2bd9ac285c0d..8d31d3e25e30 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -363,7 +363,7 @@ static int dmar_map_gfx = 1;
 static int dmar_forcedac;
 static int intel_iommu_strict;
 static int intel_iommu_superpage = 1;
-static int intel_iommu_sm = 1;
+static int intel_iommu_sm;
 static int iommu_identity_mapping;
 
 #define IDENTMAP_ALL		1
@@ -456,9 +456,9 @@ static int __init intel_iommu_setup(char *str)
 		} else if (!strncmp(str, "sp_off", 6)) {
 			pr_info("Disable supported super page\n");
 			intel_iommu_superpage = 0;
-		} else if (!strncmp(str, "sm_off", 6)) {
-			pr_info("Intel-IOMMU: disable scalable mode support\n");
-			intel_iommu_sm = 0;
+		} else if (!strncmp(str, "sm_on", 5)) {
+			pr_info("Intel-IOMMU: scalable mode supported\n");
+			intel_iommu_sm = 1;
 		} else if (!strncmp(str, "tboot_noforce", 13)) {
 			printk(KERN_INFO
 				"Intel-IOMMU: not forcing on after tboot. This could expose security risk for tboot\n");
-- 
2.17.1

