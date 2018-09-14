Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E7CECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 20:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E2320881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 20:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15E2320881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbeIOBvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 21:51:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:60391 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728366AbeIOBvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 21:51:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2018 13:35:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,374,1531810800"; 
   d="scan'208";a="263593822"
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
Subject: [PATCH 9/9] x86/intel_rdt: Fix incorrect loop end condition
Date:   Fri, 14 Sep 2018 13:32:09 -0700
Message-Id: <1536957129-70380-10-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1536957129-70380-1-git-send-email-fenghua.yu@intel.com>
References: <1536957129-70380-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Reinette Chatre <reinette.chatre@intel.com>

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
---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index fac99f81d02f..90b76c1ebd70 100644
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
-- 
2.19.0

