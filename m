Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBB1C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 01:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798F620867
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 01:32:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 798F620867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbeIEGAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 02:00:08 -0400
Received: from mga18.intel.com ([134.134.136.126]:25167 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbeIEGAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 02:00:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 18:32:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,331,1531810800"; 
   d="scan'208";a="89019771"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga002.jf.intel.com with ESMTP; 04 Sep 2018 18:32:24 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "H Peter Anvin" <hpa@zytor.com>,
        "Tony Luck" <tony.luck@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>,
        Xiaochen Shen <xiaochen.shen@intel.com>
Subject: [PATCH] x86/intel_rdt: Show missing resctrl mount options
Date:   Tue,  4 Sep 2018 18:29:44 -0700
Message-Id: <1536110984-154868-1-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In resctrl filesystem, we have some mount options to enable
L3/L2 CDP and MBA Software Controller features if platform supports them:
     mount -t resctrl resctrl [-o cdp[,cdpl2][,mba_MBps]] /sys/fs/resctrl

But currently only "cdp" option can be displayed. "cdpl2" and "mba_MBps"
options are not showed even when they are active mount options.

Before this patch:
     #mount -t resctrl resctrl -o cdp,mba_MBps /sys/fs/resctrl
     #grep resctrl /proc/mounts
     /sys/fs/resctrl /sys/fs/resctrl resctrl rw,relatime,cdp 0 0
After this patch:
     #mount -t resctrl resctrl -o cdp,mba_MBps /sys/fs/resctrl
     #grep resctrl /proc/mountts
     /sys/fs/resctrl /sys/fs/resctrl resctrl rw,relatime,cdp,mba_MBps 0 0

Signed-off-by: Xiaochen Shen <xiaochen.shen@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index b799c00bef09..82459a41fa84 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -2760,6 +2760,13 @@ static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *kf)
 {
 	if (rdt_resources_all[RDT_RESOURCE_L3DATA].alloc_enabled)
 		seq_puts(seq, ",cdp");
+
+	if (rdt_resources_all[RDT_RESOURCE_L2DATA].alloc_enabled)
+		seq_puts(seq, ",cdpl2");
+
+	if (is_mba_sc(&rdt_resources_all[RDT_RESOURCE_MBA]))
+		seq_puts(seq, ",mba_MBps");
+
 	return 0;
 }
 
-- 
2.18.0

