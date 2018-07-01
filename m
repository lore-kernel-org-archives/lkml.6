Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424C4C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 05:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048012245C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 05:03:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 048012245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752073AbeGAFDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 01:03:30 -0400
Received: from mga03.intel.com ([134.134.136.65]:48739 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751136AbeGAFDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 01:03:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jun 2018 22:03:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,293,1526367600"; 
   d="scan'208";a="241698249"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by fmsmga005.fm.intel.com with ESMTP; 30 Jun 2018 22:03:21 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH 2/2] x86/intel_rdt: Fix cleanup of plr structure on error
Date:   Sat, 30 Jun 2018 22:03:03 -0700
Message-Id: <49b4782f6d204d122cee3499e642b2772a98d2b4.1530421026.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1530421026.git.reinette.chatre@intel.com>
References: <cover.1530421026.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1530421026.git.reinette.chatre@intel.com>
References: <cover.1530421026.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a resource group enters pseudo-locksetup mode a pseudo_lock_region
is associated with it. When the user writes to the resource group's
schemata file the CBM of the requested pseudo-locked region is entered
into the pseudo_lock_region struct. If any part of pseudo-lock region
creation fails the resource group will remain in pseudo-locksetup mode
with the pseudo_lock_region associated with it.

In case of failure during pseudo-lock region creation care needs to be
taken to ensure that the pseudo_lock_region struct associated with the
resource group is cleared from any pseudo-locking data - especially the
CBM. This is because the existence of a pseudo_lock_region struct with a
CBM is significant in other areas of the code, for example, the display
of bit_usage and initialization of a new resource group.

Fix the error path of pseudo-lock region creation to ensure that the
pseudo_lock_region struct is cleared at each error exit.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 22 ++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index 1860ec10302d..8fd79c281ee6 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -290,6 +290,7 @@ static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
 static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
 {
 	struct cpu_cacheinfo *ci;
+	int ret;
 	int i;
 
 	/* Pick the first cpu we find that is associated with the cache. */
@@ -298,7 +299,8 @@ static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
 	if (!cpu_online(plr->cpu)) {
 		rdt_last_cmd_printf("cpu %u associated with cache not online\n",
 				    plr->cpu);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out_region;
 	}
 
 	ci = get_cpu_cacheinfo(plr->cpu);
@@ -312,8 +314,11 @@ static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
 		}
 	}
 
+	ret = -1;
 	rdt_last_cmd_puts("unable to determine cache line size\n");
-	return -1;
+out_region:
+	pseudo_lock_region_clear(plr);
+	return ret;
 }
 
 /**
@@ -365,16 +370,23 @@ static int pseudo_lock_region_alloc(struct pseudo_lock_region *plr)
 	 */
 	if (plr->size > KMALLOC_MAX_SIZE) {
 		rdt_last_cmd_puts("requested region exceeds maximum size\n");
-		return -E2BIG;
+		ret = -E2BIG;
+		goto out_region;
 	}
 
 	plr->kmem = kzalloc(plr->size, GFP_KERNEL);
 	if (!plr->kmem) {
 		rdt_last_cmd_puts("unable to allocate memory\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out_region;
 	}
 
-	return 0;
+	ret = 0;
+	goto out;
+out_region:
+	pseudo_lock_region_clear(plr);
+out:
+	return ret;
 }
 
 /**
-- 
2.17.0

