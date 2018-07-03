Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAB1C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E0A6204EC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E0A6204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753823AbeGCGnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:43:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33249 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753557AbeGCGnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:43:32 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w636hQc8182654
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 2 Jul 2018 23:43:27 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w636hQF6182651;
        Mon, 2 Jul 2018 23:43:26 -0700
Date:   Mon, 2 Jul 2018 23:43:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-546d3c74277398a3d76d059bd2db47186bb47fc8@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, reinette.chatre@intel.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: mingo@kernel.org, tglx@linutronix.de, reinette.chatre@intel.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <49b4782f6d204d122cee3499e642b2772a98d2b4.1530421026.git.reinette.chatre@intel.com>
References: <49b4782f6d204d122cee3499e642b2772a98d2b4.1530421026.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Fix cleanup of plr structure on
 error
Git-Commit-ID: 546d3c74277398a3d76d059bd2db47186bb47fc8
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  546d3c74277398a3d76d059bd2db47186bb47fc8
Gitweb:     https://git.kernel.org/tip/546d3c74277398a3d76d059bd2db47186bb47fc8
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Sat, 30 Jun 2018 22:03:03 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 3 Jul 2018 08:38:39 +0200

x86/intel_rdt: Fix cleanup of plr structure on error

When a resource group enters pseudo-locksetup mode a pseudo_lock_region is
associated with it. When the user writes to the resource group's schemata
file the CBM of the requested pseudo-locked region is entered into the
pseudo_lock_region struct. If any part of pseudo-lock region creation fails
the resource group will remain in pseudo-locksetup mode with the
pseudo_lock_region associated with it.

In case of failure during pseudo-lock region creation care needs to be
taken to ensure that the pseudo_lock_region struct associated with the
resource group is cleared from any pseudo-locking data - especially the
CBM. This is because the existence of a pseudo_lock_region struct with a
CBM is significant in other areas of the code, for example, the display of
bit_usage and initialization of a new resource group.

Fix the error path of pseudo-lock region creation to ensure that the
pseudo_lock_region struct is cleared at each error exit.

Fixes: 018961ae5579 ("x86/intel_rdt: Pseudo-lock region creation/removal core")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/49b4782f6d204d122cee3499e642b2772a98d2b4.1530421026.git.reinette.chatre@intel.com

---
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 22 +++++++++++++++++-----
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
