Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7368CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3668A206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:23:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3668A206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbeK2FZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 00:25:32 -0500
Received: from mga18.intel.com ([134.134.136.126]:30896 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725266AbeK2FZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 00:25:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2018 10:22:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,291,1539673200"; 
   d="scan'208";a="278352141"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga005.jf.intel.com with ESMTP; 28 Nov 2018 10:22:59 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     jithu.joseph@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        stable@vger.kernel.org
Subject: [PATCH] x86/resctrl: Ensure usage of CPUs are locked while needed
Date:   Wed, 28 Nov 2018 10:22:07 -0800
Message-Id: <725073a1f4448e3c45ed7102229e6946ca2526d8.1543428144.git.reinette.chatre@intel.com>
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
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 03ee13235a45..6f7adb3be01e 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -23,6 +23,7 @@
 
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
+#include <linux/cpu.h>
 #include <linux/kernfs.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
@@ -381,9 +382,11 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
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
@@ -438,6 +441,7 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 
 out:
 	rdtgroup_kn_unlock(of->kn);
+	cpus_read_unlock();
 	return ret ?: nbytes;
 }
 
-- 
2.17.0

