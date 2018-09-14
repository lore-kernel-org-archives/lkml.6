Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441BFECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 20:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A59220881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 20:35:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A59220881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbeIOBvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 21:51:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:60388 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728362AbeIOBvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 21:51:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2018 13:35:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,374,1531810800"; 
   d="scan'208";a="263593815"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga006.fm.intel.com with ESMTP; 14 Sep 2018 13:35:44 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "H Peter Anvin" <hpa@zytor.com>,
        "Tony Luck" <tony.luck@intel.com>
Cc:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Xiaochen Shen" <xiaochen.shen@intel.com>,
        "Chen Yu" <yu.c.chen@intel.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, "Fenghua Yu" <fenghua.yu@intel.com>
Subject: [PATCH 5/9] x86/intel_rdt: Fix unchecked MSR access
Date:   Fri, 14 Sep 2018 13:32:05 -0700
Message-Id: <1536957129-70380-6-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1536957129-70380-1-git-send-email-fenghua.yu@intel.com>
References: <1536957129-70380-1-git-send-email-fenghua.yu@intel.com>
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

[ 6944.864724] unchecked MSR access error: WRMSR to 0xd51 (tried to write 0x0000
000000000064) at rIP: 0xffffffffae059994 (native_write_msr+0x4/0x20)
[ 6944.877967] Call Trace:
[ 6944.880472]  mba_wrmsr+0x41/0x80
[ 6944.883762]  update_domains+0x125/0x130
[ 6944.887667]  rdtgroup_mkdir+0x270/0x500
[ 6944.891572]  kernfs_iop_mkdir+0x5d/0x80
[ 6944.895475]  vfs_mkdir+0x101/0x1b0
[ 6944.898934]  do_mkdirat+0x7b/0xf0
[ 6944.902308]  do_syscall_64+0x5b/0x180
[ 6944.906036]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 6944.911171] RIP: 0033:0x7f5a452b5377
[ 6944.914803] Code: 00 b8 ff ff ff ff c3 0f 1f 40 00 48 8b 05 21 9b 2c 00 64 c7
 00 5f 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 b8 53 00 00 00 0f 05 <48> 3d 01 f0
 ff ff 73 01 c3 48 8b 0d f9 9a 2c 00 f7 d8 64 89 01 48
[ 6944.933942] RSP: 002b:00007ffe18172f78 EFLAGS: 00000246 ORIG_RAX: 00000000000
00053
[ 6944.941628] RAX: ffffffffffffffda RBX: 00007ffe18174cff RCX: 00007f5a452b5377
[ 6944.948929] RDX: 0000000000000001 RSI: 00000000000001ff RDI: 00007ffe18174cff
[ 6944.956168] RBP: 00007ffe18174cff R08: 00000000000001ff R09: 000056126dad8d30
[ 6944.963407] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000001ff
[ 6944.970651] R13: 00007ffe181730f0 R14: 0000000000000000 R15: 00007ffe18173140

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

