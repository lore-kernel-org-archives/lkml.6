Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95D0C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B1D920880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B1D920880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730971AbeISNMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 09:12:45 -0400
Received: from mga14.intel.com ([192.55.52.115]:55097 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726972AbeISNMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 09:12:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2018 00:36:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,393,1531810800"; 
   d="scan'208";a="91368329"
Received: from chenyu-desktop.sh.intel.com ([10.239.160.116])
  by fmsmga001.fm.intel.com with ESMTP; 19 Sep 2018 00:36:02 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Zhimin Gu <kookoo.gu@intel.com>, Yu Chen <yu.c.chen@intel.com>
Subject: [PATCH 07/12][RFC v3] x86-32, hibernate: Use temp_pgt as the temporary page table
Date:   Wed, 19 Sep 2018 15:42:48 +0800
Message-Id: <22b6bfd23d24405194930baf88f0ec3fe76ba807.1537275915.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1537275915.git.yu.c.chen@intel.com>
References: <cover.1537275915.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhimin Gu <kookoo.gu@intel.com>

This is to reuse the temp_pgt for both 32bit and 64bit
system.

No functional change.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Zhimin Gu <kookoo.gu@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 arch/x86/power/hibernate_32.c     | 2 ++
 arch/x86/power/hibernate_asm_32.S | 3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/power/hibernate_32.c b/arch/x86/power/hibernate_32.c
index f82fbd279d08..a44bdada4e4e 100644
--- a/arch/x86/power/hibernate_32.c
+++ b/arch/x86/power/hibernate_32.c
@@ -156,6 +156,8 @@ asmlinkage int swsusp_arch_resume(void)
 	if (error)
 		return error;
 
+	temp_pgt = __pa(resume_pg_dir);
+
 	/* We have got enough memory and from now on we cannot recover */
 	restore_image();
 	return 0;
diff --git a/arch/x86/power/hibernate_asm_32.S b/arch/x86/power/hibernate_asm_32.S
index 671d38d0d931..f0627cf30a36 100644
--- a/arch/x86/power/hibernate_asm_32.S
+++ b/arch/x86/power/hibernate_asm_32.S
@@ -33,8 +33,7 @@ ENDPROC(swsusp_arch_suspend)
 
 ENTRY(restore_image)
 	movl	mmu_cr4_features, %ecx
-	movl	resume_pg_dir, %eax
-	subl	$__PAGE_OFFSET, %eax
+	movl	temp_pgt, %eax
 	movl	%eax, %cr3
 
 	jecxz	1f	# cr4 Pentium and higher, skip if zero
-- 
2.17.1

