Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9B1ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 22:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3651214C2
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 22:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3651214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbeIPDWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 23:22:13 -0400
Received: from mga03.intel.com ([134.134.136.65]:34545 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727798AbeIPDWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 23:22:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Sep 2018 15:01:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,379,1531810800"; 
   d="scan'208";a="70289153"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga007.fm.intel.com with ESMTP; 15 Sep 2018 15:01:28 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "H Peter Anvin" <hpa@zytor.com>,
        "Tony Luck" <tony.luck@intel.com>
Cc:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Xiaochen Shen" <xiaochen.shen@intel.com>,
        "Chen Yu" <yu.c.chen@intel.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, "Fenghua Yu" <fenghua.yu@intel.com>
Subject: [PATCH V2 4/9] x86/intel_rdt: Fix invalid mode warning when multiple resources are managed
Date:   Sat, 15 Sep 2018 14:58:22 -0700
Message-Id: <1537048707-76280-5-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1537048707-76280-1-git-send-email-fenghua.yu@intel.com>
References: <1537048707-76280-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Reinette Chatre <reinette.chatre@intel.com>

When multiple resources are managed by RDT, the number of CLOSIDs used
is the minimum of the CLOSIDs supported by each resource. In the function
rdt_bit_usage_show(), the annotated bitmask is created to depict how the
CAT supporting caches are being used. During this annotated bitmask
creation, each resource group is queried for its mode that is used as a
label in the annotated bitmask.

The maximum number of resource groups is currently assumed to be the
number of CLOSIDs supported by the resource for which the information is
being displayed. This is incorrect since the number of active CLOSIDs is
the minimum across all resources.

If information for a cache instance with more CLOSIDs than another is
being generated we thus encounter a warning like:

invalid mode for closid 8
WARNING: CPU: 88 PID: 1791 at [SNIP]/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
:827 rdt_bit_usage_show+0x221/0x2b0

Fix this by ensuring that only the number of supported CLOSIDs are
considered.

Fixes: e651901187ab8 ("x86/intel_rdt: Introduce "bit_usage" to display cache allocations details")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index b372923eb209..ea91750ba27f 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -809,7 +809,7 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 		sw_shareable = 0;
 		exclusive = 0;
 		seq_printf(seq, "%d=", dom->id);
-		for (i = 0; i < r->num_closid; i++, ctrl++) {
+		for (i = 0; i < closids_supported(); i++, ctrl++) {
 			if (!closid_allocated(i))
 				continue;
 			mode = rdtgroup_mode_by_closid(i);
-- 
2.19.0

