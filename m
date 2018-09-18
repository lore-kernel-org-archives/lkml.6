Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA1CECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A23221471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A23221471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730644AbeISDWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 23:22:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38607 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbeISDWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 23:22:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8ILlMf7930573
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Sep 2018 14:47:22 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8ILlLOm930570;
        Tue, 18 Sep 2018 14:47:21 -0700
Date:   Tue, 18 Sep 2018 14:47:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-ffb2315fd22c2568747402eecdc581a245a2f5ba@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, xiaochen.shen@intel.com,
        tglx@linutronix.de, reinette.chatre@intel.com,
        fenghua.yu@intel.com, hpa@zytor.com, mingo@kernel.org,
        tony.luck@intel.com, yu.c.chen@intel.com
Reply-To: yu.c.chen@intel.com, tony.luck@intel.com, mingo@kernel.org,
          reinette.chatre@intel.com, hpa@zytor.com, fenghua.yu@intel.com,
          xiaochen.shen@intel.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de
In-Reply-To: <1537048707-76280-10-git-send-email-fenghua.yu@intel.com>
References: <1537048707-76280-10-git-send-email-fenghua.yu@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/intel_rdt: Fix incorrect loop end condition
Git-Commit-ID: ffb2315fd22c2568747402eecdc581a245a2f5ba
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

Commit-ID:  ffb2315fd22c2568747402eecdc581a245a2f5ba
Gitweb:     https://git.kernel.org/tip/ffb2315fd22c2568747402eecdc581a245a2f5ba
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Sat, 15 Sep 2018 14:58:27 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 18 Sep 2018 23:38:07 +0200

x86/intel_rdt: Fix incorrect loop end condition

In order to determine a sane default cache allocation for a new CAT/CDP
resource group, all resource groups are checked to determine which cache
portions are available to share. At this time all possible CLOSIDs
that can be supported by the resource is checked. This is problematic
if the resource supports more CLOSIDs than another CAT/CDP resource. In
this case, the number of CLOSIDs that could be allocated are fewer than
the number of CLOSIDs that can be supported by the resource.

Limit the check of closids to that what is supported by the system based
on the minimum across all resources.

Fixes: 95f0b77ef ("x86/intel_rdt: Initialize new resource group with sane defaults")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "H Peter Anvin" <hpa@zytor.com>
Cc: "Tony Luck" <tony.luck@intel.com>
Cc: "Xiaochen Shen" <xiaochen.shen@intel.com>
Cc: "Chen Yu" <yu.c.chen@intel.com>
Link: https://lkml.kernel.org/r/1537048707-76280-10-git-send-email-fenghua.yu@intel.com

---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index f3231f78d69b..1b8e86a5d5e1 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -2370,7 +2370,7 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 			d->new_ctrl = r->cache.shareable_bits;
 			used_b = r->cache.shareable_bits;
 			ctrl = d->ctrl_val;
-			for (i = 0; i < r->num_closid; i++, ctrl++) {
+			for (i = 0; i < closids_supported(); i++, ctrl++) {
 				if (closid_allocated(i) && i != closid) {
 					mode = rdtgroup_mode_by_closid(i);
 					if (mode == RDT_MODE_PSEUDO_LOCKSETUP)
