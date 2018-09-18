Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADD9ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A355721471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A355721471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730629AbeISDUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 23:20:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56765 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729705AbeISDUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 23:20:51 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8ILkDS7930486
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Sep 2018 14:46:13 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8ILkDBF930483;
        Tue, 18 Sep 2018 14:46:13 -0700
Date:   Tue, 18 Sep 2018 14:46:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-f0df4e1acf3d721958dcafb2c9c0bdf25189068d@git.kernel.org>
Cc:     xiaochen.shen@intel.com, fenghua.yu@intel.com, tony.luck@intel.com,
        mingo@kernel.org, reinette.chatre@intel.com, tglx@linutronix.de,
        hpa@zytor.com, linux-kernel@vger.kernel.org, yu.c.chen@intel.com
Reply-To: tglx@linutronix.de, reinette.chatre@intel.com, mingo@kernel.org,
          tony.luck@intel.com, yu.c.chen@intel.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, xiaochen.shen@intel.com,
          fenghua.yu@intel.com
In-Reply-To: <1537048707-76280-8-git-send-email-fenghua.yu@intel.com>
References: <1537048707-76280-8-git-send-email-fenghua.yu@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/intel_rdt: Fix incorrect loop end condition
Git-Commit-ID: f0df4e1acf3d721958dcafb2c9c0bdf25189068d
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

Commit-ID:  f0df4e1acf3d721958dcafb2c9c0bdf25189068d
Gitweb:     https://git.kernel.org/tip/f0df4e1acf3d721958dcafb2c9c0bdf25189068d
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Sat, 15 Sep 2018 14:58:25 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 18 Sep 2018 23:38:06 +0200

x86/intel_rdt: Fix incorrect loop end condition

A loop is used to check if a CAT resource's CBM of one CLOSID
overlaps with the CBM of another CLOSID of the same resource. The loop
is run over all CLOSIDs supported by the resource.

The problem with running the loop over all CLOSIDs supported by the
resource is that its number of supported CLOSIDs may be more than the
number of supported CLOSIDs on the system, which is the minimum number of
CLOSIDs supported across all resources.

Fix the loop to only consider the number of system supported CLOSIDs,
not all that are supported by the resource.

Fixes: 49f7b4efa ("x86/intel_rdt: Enable setting of exclusive mode")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "H Peter Anvin" <hpa@zytor.com>
Cc: "Tony Luck" <tony.luck@intel.com>
Cc: "Xiaochen Shen" <xiaochen.shen@intel.com>
Cc: "Chen Yu" <yu.c.chen@intel.com>
Link: https://lkml.kernel.org/r/1537048707-76280-8-git-send-email-fenghua.yu@intel.com

---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 74821bc457c0..afd93d45e21b 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -996,7 +996,7 @@ bool rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
 
 	/* Check for overlap with other resource groups */
 	ctrl = d->ctrl_val;
-	for (i = 0; i < r->num_closid; i++, ctrl++) {
+	for (i = 0; i < closids_supported(); i++, ctrl++) {
 		ctrl_b = (unsigned long *)ctrl;
 		mode = rdtgroup_mode_by_closid(i);
 		if (closid_allocated(i) && i != closid &&
