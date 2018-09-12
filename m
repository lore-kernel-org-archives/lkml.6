Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B01C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 23:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E96206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 23:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53E96206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbeIME6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 00:58:51 -0400
Received: from mga07.intel.com ([134.134.136.100]:39638 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbeIME6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 00:58:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2018 16:52:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,366,1531810800"; 
   d="scan'208";a="91226310"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga002.jf.intel.com with ESMTP; 12 Sep 2018 16:51:48 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "H Peter Anvin" <hpa@zytor.com>,
        "Tony Luck" <tony.luck@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Xiaochen Shen <xiaochen.shen@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2] x86/intel_rdt: Show missing resctrl mount options
Date:   Wed, 12 Sep 2018 16:48:38 -0700
Message-Id: <1536796118-60135-1-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaochen Shen <xiaochen.shen@intel.com>

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
2.19.0

