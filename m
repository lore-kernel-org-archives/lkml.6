Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779B7C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A8ED20C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A8ED20C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730554AbeISDTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 23:19:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33121 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbeISDTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 23:19:45 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8ILj7jq930368
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Sep 2018 14:45:07 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8ILj7pa930365;
        Tue, 18 Sep 2018 14:45:07 -0700
Date:   Tue, 18 Sep 2018 14:45:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-70479c012b67b89e219c40eddc5dc338b7c447a3@git.kernel.org>
Cc:     mingo@kernel.org, fenghua.yu@intel.com, hpa@zytor.com,
        xiaochen.shen@intel.com, yu.c.chen@intel.com,
        linux-kernel@vger.kernel.org, reinette.chatre@intel.com,
        tony.luck@intel.com, tglx@linutronix.de
Reply-To: yu.c.chen@intel.com, xiaochen.shen@intel.com, tglx@linutronix.de,
          reinette.chatre@intel.com, tony.luck@intel.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
          fenghua.yu@intel.com
In-Reply-To: <1537048707-76280-6-git-send-email-fenghua.yu@intel.com>
References: <1537048707-76280-6-git-send-email-fenghua.yu@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/intel_rdt: Fix unchecked MSR access
Git-Commit-ID: 70479c012b67b89e219c40eddc5dc338b7c447a3
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

Commit-ID:  70479c012b67b89e219c40eddc5dc338b7c447a3
Gitweb:     https://git.kernel.org/tip/70479c012b67b89e219c40eddc5dc338b7c447a3
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Sat, 15 Sep 2018 14:58:23 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 18 Sep 2018 23:38:06 +0200

x86/intel_rdt: Fix unchecked MSR access

When a new resource group is created, it is initialized with sane
defaults that currently assume the resource being initialized is a CAT
resource. This code path is also followed by a MBA resource that is not
allocated the same as a CAT resource and as a result we encounter the
following unchecked MSR access error:

unchecked MSR access error: WRMSR to 0xd51 (tried to write 0x0000
000000000064) at rIP: 0xffffffffae059994 (native_write_msr+0x4/0x20)
Call Trace:
mba_wrmsr+0x41/0x80
update_domains+0x125/0x130
rdtgroup_mkdir+0x270/0x500

Fix the above by ensuring the initial allocation is only attempted on a
CAT resource.

Fixes: 95f0b77ef ("x86/intel_rdt: Initialize new resource group with sane defaults")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "H Peter Anvin" <hpa@zytor.com>
Cc: "Tony Luck" <tony.luck@intel.com>
Cc: "Xiaochen Shen" <xiaochen.shen@intel.com>
Cc: "Chen Yu" <yu.c.chen@intel.com>
Link: https://lkml.kernel.org/r/1537048707-76280-6-git-send-email-fenghua.yu@intel.com

---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index ea91750ba27f..74821bc457c0 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -2349,6 +2349,12 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 	u32 *ctrl;
 
 	for_each_alloc_enabled_rdt_resource(r) {
+		/*
+		 * Only initialize default allocations for CBM cache
+		 * resources
+		 */
+		if (r->rid == RDT_RESOURCE_MBA)
+			continue;
 		list_for_each_entry(d, &r->domains, list) {
 			d->have_new_ctrl = false;
 			d->new_ctrl = r->cache.shareable_bits;
@@ -2386,6 +2392,12 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 	}
 
 	for_each_alloc_enabled_rdt_resource(r) {
+		/*
+		 * Only initialize default allocations for CBM cache
+		 * resources
+		 */
+		if (r->rid == RDT_RESOURCE_MBA)
+			continue;
 		ret = update_domains(r, rdtgrp->closid);
 		if (ret < 0) {
 			rdt_last_cmd_puts("failed to initialize allocations\n");
