Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F72C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE6321470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:58:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFE6321470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbeJDCsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 22:48:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56647 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbeJDCsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 22:48:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w93JwMw42469338
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 3 Oct 2018 12:58:22 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w93JwMnJ2469335;
        Wed, 3 Oct 2018 12:58:22 -0700
Date:   Wed, 3 Oct 2018 12:58:22 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Shevchenko <tipbot@zytor.com>
Message-ID: <tip-82159876d32b7959c0b0ea8fe12c428f41502a6f@git.kernel.org>
Cc:     andriy.shevchenko@linux.intel.com, fenghua.yu@intel.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
        tglx@linutronix.de
Reply-To: andriy.shevchenko@linux.intel.com, fenghua.yu@intel.com,
          tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org
In-Reply-To: <20180830115039.63430-1-andriy.shevchenko@linux.intel.com>
References: <20180830115039.63430-1-andriy.shevchenko@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Switch to bitmap_zalloc()
Git-Commit-ID: 82159876d32b7959c0b0ea8fe12c428f41502a6f
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

Commit-ID:  82159876d32b7959c0b0ea8fe12c428f41502a6f
Gitweb:     https://git.kernel.org/tip/82159876d32b7959c0b0ea8fe12c428f41502a6f
Author:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate: Thu, 30 Aug 2018 14:50:39 +0300
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 3 Oct 2018 21:53:49 +0200

x86/intel_rdt: Switch to bitmap_zalloc()

Switch to bitmap_zalloc() to show clearly what is allocated. Besides that
it returns a pointer of bitmap type instead of opaque void *.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Fenghua Yu <fenghua.yu@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lkml.kernel.org/r/20180830115039.63430-1-andriy.shevchenko@linux.intel.com

---
 arch/x86/kernel/cpu/intel_rdt.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.c b/arch/x86/kernel/cpu/intel_rdt.c
index abb71ac70443..1214f3f7ec6d 100644
--- a/arch/x86/kernel/cpu/intel_rdt.c
+++ b/arch/x86/kernel/cpu/intel_rdt.c
@@ -485,9 +485,7 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
 	size_t tsize;
 
 	if (is_llc_occupancy_enabled()) {
-		d->rmid_busy_llc = kcalloc(BITS_TO_LONGS(r->num_rmid),
-					   sizeof(unsigned long),
-					   GFP_KERNEL);
+		d->rmid_busy_llc = bitmap_zalloc(r->num_rmid, GFP_KERNEL);
 		if (!d->rmid_busy_llc)
 			return -ENOMEM;
 		INIT_DELAYED_WORK(&d->cqm_limbo, cqm_handle_limbo);
@@ -496,7 +494,7 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
 		tsize = sizeof(*d->mbm_total);
 		d->mbm_total = kcalloc(r->num_rmid, tsize, GFP_KERNEL);
 		if (!d->mbm_total) {
-			kfree(d->rmid_busy_llc);
+			bitmap_free(d->rmid_busy_llc);
 			return -ENOMEM;
 		}
 	}
@@ -504,7 +502,7 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
 		tsize = sizeof(*d->mbm_local);
 		d->mbm_local = kcalloc(r->num_rmid, tsize, GFP_KERNEL);
 		if (!d->mbm_local) {
-			kfree(d->rmid_busy_llc);
+			bitmap_free(d->rmid_busy_llc);
 			kfree(d->mbm_total);
 			return -ENOMEM;
 		}
@@ -612,7 +610,7 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 
 		kfree(d->ctrl_val);
 		kfree(d->mbps_val);
-		kfree(d->rmid_busy_llc);
+		bitmap_free(d->rmid_busy_llc);
 		kfree(d->mbm_total);
 		kfree(d->mbm_local);
 		kfree(d);
