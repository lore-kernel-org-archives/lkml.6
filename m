Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF47ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 22:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071C82147E
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 22:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 071C82147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbeIPDWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 23:22:00 -0400
Received: from mga17.intel.com ([192.55.52.151]:35528 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727798AbeIPDV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 23:21:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Sep 2018 15:01:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,379,1531810800"; 
   d="scan'208";a="70289156"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga007.fm.intel.com with ESMTP; 15 Sep 2018 15:01:29 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "H Peter Anvin" <hpa@zytor.com>,
        "Tony Luck" <tony.luck@intel.com>
Cc:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Xiaochen Shen" <xiaochen.shen@intel.com>,
        "Chen Yu" <yu.c.chen@intel.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, "Fenghua Yu" <fenghua.yu@intel.com>
Subject: [PATCH V2 5/9] x86/intel_rdt: Fix unchecked MSR access
Date:   Sat, 15 Sep 2018 14:58:23 -0700
Message-Id: <1537048707-76280-6-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1537048707-76280-1-git-send-email-fenghua.yu@intel.com>
References: <1537048707-76280-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Reinette Chatre <reinette.chatre@intel.com>

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
-- 
2.19.0

