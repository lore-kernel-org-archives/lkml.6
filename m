Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AD1C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7602C2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:40:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7602C2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbeIDWG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 18:06:29 -0400
Received: from mga09.intel.com ([134.134.136.24]:1701 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbeIDWG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 18:06:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 10:40:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,329,1531810800"; 
   d="scan'208";a="260644333"
Received: from chenyu-desktop.sh.intel.com ([10.239.160.116])
  by fmsmga006.fm.intel.com with ESMTP; 04 Sep 2018 10:40:20 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH][RFC] x86/intel_rdt: Do not display size for non-CAT resource
Date:   Wed,  5 Sep 2018 01:46:14 +0800
Message-Id: <20180904174614.26682-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a platform with MB resource enabled, a divided-by-zero
exception is triggered when accessing 'size':

[  151.193447] divide error: 0000 [#1] SMP PTI
[  151.197743] CPU: 93 PID: 1929 Comm: cat Not tainted 4.19.0-rc2-debug-rdt+ #25
[  151.205070] Hardware name: Dell Inc. PowerEdge R640/0CRT1G, BIOS 1.3.7 02/08/2018
[  151.212783] RIP: 0010:rdtgroup_cbm_to_size+0x7e/0xa0
[  151.237172] RSP: 0018:ffffb3454f90bd88 EFLAGS: 00010246
[  151.242538] RAX: 00000000023c0000 RBX: 0000000000000000 RCX: 0000000000000003
[  151.249878] RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000003
[  151.257213] RBP: ffff96ff0089e000 R08: 0000000000000000 R09: 0000000000aaaaaa
[  151.264544] R10: ffffb3454f90bd8c R11: 00000000ffffffff R12: ffffffffb5028910
[  151.271887] R13: ffffffffb5028910 R14: 0000000000000064 R15: ffff96ff0089e000
[  151.279217] FS:  00007f95a623a500(0000) GS:ffff97170f9c0000(0000) knlGS:0000000000000000
[  151.287532] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  151.293432] CR2: 00007f95a6217000 CR3: 00000023f696c003 CR4: 00000000007606e0
[  151.300766] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  151.308094] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  151.315426] PKRU: 55555554
[  151.318212] Call Trace:
[  151.320732]  rdtgroup_size_show+0x11a/0x1d0
[  151.325039]  seq_read+0xd8/0x3b0
[  151.328363]  __vfs_read+0x36/0x170
[  151.331857]  vfs_read+0x89/0x130
[  151.335179]  ksys_read+0x52/0xc0
[  151.338500]  do_syscall_64+0x5b/0x180
[  151.342261]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

This is because for MB resource, the r->cache.cbm_len is zero, thus
calculating size in rdtgroup_cbm_to_size() will trigger the exception.

Fix this issue by not exposing 'size' for non-CAT resources.

Fixes: d9b48c86eb38 ("x86/intel_rdt: Display resource groups'
allocations in bytes")
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index b799c00bef09..53fd07b2f61a 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -1329,7 +1329,7 @@ static struct rftype res_common_files[] = {
 		.mode		= 0444,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdtgroup_size_show,
-		.fflags		= RF_CTRL_BASE,
+		.fflags		= RF_CTRL_INFO | RFTYPE_RES_CACHE,
 	},
 
 };
-- 
2.17.1

