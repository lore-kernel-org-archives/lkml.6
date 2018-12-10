Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1ADC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B4020821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:22:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54B4020821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbeLJVWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:22:43 -0500
Received: from mga05.intel.com ([192.55.52.43]:40410 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728191AbeLJVWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:22:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2018 13:22:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,339,1539673200"; 
   d="scan'208";a="99626325"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga006.jf.intel.com with ESMTP; 10 Dec 2018 13:22:41 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        stable@vger.kernel.org
Subject: [PATCH V2] x86/intel_rdt: Ensure usage of CPUs are locked while needed
Date:   Mon, 10 Dec 2018 13:21:54 -0800
Message-Id: <b7b17432a80f95a1fa21a1698ba643014f58ad31.1544476425.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The user triggers the creation of a pseudo-locked region when writing
the requested schemata to the schemata resctrl file. The pseudo-locking
of a region is required to be done on a CPU that is associated with the
cache on which the pseudo-locked region will reside. In order to run the
locking code on a specific CPU the needed CPU has to be selected and
ensured to remain online during the entire locking sequence.

At this time the cpu_hotplug_lock is not taken during the pseudo-lock
region creation and it is thus possible for a CPU to be selected to run
the pseudo-locking code and then that CPU to go offline before the
thread is able to run on it.

Fix this by ensuring that the cpu_hotplug_lock is taken while the CPU on
which code has to run needs to be controlled. Since the cpu_hotplug_lock
is always taken before rdtgroup_mutex the lock order is maintained.

Fixes: e0bdfe8e36f3 ("x86/intel_rdt: Support creation/removal of pseudo-locked region")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: stable@vger.kernel.org
---
V2:
- Rebase against tip/x86/urgent
- Modify subject from x86/resctrl to x86/intel_rdt to match subject used
  before the code reorganization.

 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
index 27937458c231..efa4a519f5e5 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
@@ -23,6 +23,7 @@
 
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
+#include <linux/cpu.h>
 #include <linux/kernfs.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
@@ -310,9 +311,11 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 		return -EINVAL;
 	buf[nbytes - 1] = '\0';
 
+	cpus_read_lock();
 	rdtgrp = rdtgroup_kn_lock_live(of->kn);
 	if (!rdtgrp) {
 		rdtgroup_kn_unlock(of->kn);
+		cpus_read_unlock();
 		return -ENOENT;
 	}
 	rdt_last_cmd_clear();
@@ -367,6 +370,7 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 
 out:
 	rdtgroup_kn_unlock(of->kn);
+	cpus_read_unlock();
 	return ret ?: nbytes;
 }
 
-- 
2.17.0

