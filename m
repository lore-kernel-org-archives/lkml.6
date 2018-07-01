Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8447AC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 05:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4869C24AF0
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 05:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4869C24AF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752158AbeGAFDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 01:03:48 -0400
Received: from mga03.intel.com ([134.134.136.65]:48739 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751339AbeGAFDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 01:03:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jun 2018 22:03:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,293,1526367600"; 
   d="scan'208";a="241698246"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by fmsmga005.fm.intel.com with ESMTP; 30 Jun 2018 22:03:21 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH 1/2] x86/intel_rdt: Move pseudo_lock_region_clear
Date:   Sat, 30 Jun 2018 22:03:02 -0700
Message-Id: <ef098ec2a45501e23792289bff80ae3152141e2f.1530421026.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1530421026.git.reinette.chatre@intel.com>
References: <cover.1530421026.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1530421026.git.reinette.chatre@intel.com>
References: <cover.1530421026.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pseudo_lock_region_clear() function is moved to earlier in the
file in preparation for its use in functions that currently appear
before it. No functional change.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 46 ++++++++++-----------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index 6e83f61552a5..1860ec10302d 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -246,6 +246,29 @@ static int pseudo_lock_cstates_constrain(struct pseudo_lock_region *plr)
 	return ret;
 }
 
+/**
+ * pseudo_lock_region_clear - Reset pseudo-lock region data
+ * @plr: pseudo-lock region
+ *
+ * All content of the pseudo-locked region is reset - any memory allocated
+ * freed.
+ *
+ * Return: void
+ */
+static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
+{
+	plr->size = 0;
+	plr->line_size = 0;
+	kfree(plr->kmem);
+	plr->kmem = NULL;
+	plr->r = NULL;
+	if (plr->d)
+		plr->d->plr = NULL;
+	plr->d = NULL;
+	plr->cbm = 0;
+	plr->debugfs_dir = NULL;
+}
+
 /**
  * pseudo_lock_region_init - Initialize pseudo-lock region information
  * @plr: pseudo-lock region
@@ -318,29 +341,6 @@ static int pseudo_lock_init(struct rdtgroup *rdtgrp)
 	return 0;
 }
 
-/**
- * pseudo_lock_region_clear - Reset pseudo-lock region data
- * @plr: pseudo-lock region
- *
- * All content of the pseudo-locked region is reset - any memory allocated
- * freed.
- *
- * Return: void
- */
-static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
-{
-	plr->size = 0;
-	plr->line_size = 0;
-	kfree(plr->kmem);
-	plr->kmem = NULL;
-	plr->r = NULL;
-	if (plr->d)
-		plr->d->plr = NULL;
-	plr->d = NULL;
-	plr->cbm = 0;
-	plr->debugfs_dir = NULL;
-}
-
 /**
  * pseudo_lock_region_alloc - Allocate kernel memory that will be pseudo-locked
  * @plr: pseudo-lock region
-- 
2.17.0

