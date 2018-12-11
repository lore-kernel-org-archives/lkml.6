Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4BBC67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD2020851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:13:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AD2020851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbeLKVNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 16:13:23 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54491 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbeLKVNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 16:13:22 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBBLD7Df4154210
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Dec 2018 13:13:07 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBBLD5Qh4154207;
        Tue, 11 Dec 2018 13:13:05 -0800
Date:   Tue, 11 Dec 2018 13:13:05 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-80b71c340f17705ec145911b9a193ea781811b16@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        reinette.chatre@intel.com, fenghua.yu@intel.com, mingo@redhat.com,
        hpa@zytor.com, bp@suse.de, tony.luck@intel.com,
        stable@vger.kernel.org, x86@kernel.org
Reply-To: bp@suse.de, tony.luck@intel.com, stable@vger.kernel.org,
          x86@kernel.org, mingo@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, reinette.chatre@intel.com,
          fenghua.yu@intel.com, mingo@redhat.com, hpa@zytor.com
In-Reply-To: <b7b17432a80f95a1fa21a1698ba643014f58ad31.1544476425.git.reinette.chatre@intel.com>
References: <b7b17432a80f95a1fa21a1698ba643014f58ad31.1544476425.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/intel_rdt: Ensure a CPU remains online for the
 region's pseudo-locking sequence
Git-Commit-ID: 80b71c340f17705ec145911b9a193ea781811b16
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

Commit-ID:  80b71c340f17705ec145911b9a193ea781811b16
Gitweb:     https://git.kernel.org/tip/80b71c340f17705ec145911b9a193ea781811b16
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Mon, 10 Dec 2018 13:21:54 -0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Tue, 11 Dec 2018 21:59:01 +0100

x86/intel_rdt: Ensure a CPU remains online for the region's pseudo-locking sequence

The user triggers the creation of a pseudo-locked region when writing
the requested schemata to the schemata resctrl file. The pseudo-locking
of a region is required to be done on a CPU that is associated with the
cache on which the pseudo-locked region will reside. In order to run the
locking code on a specific CPU, the needed CPU has to be selected and
ensured to remain online during the entire locking sequence.

At this time, the cpu_hotplug_lock is not taken during the pseudo-lock
region creation and it is thus possible for a CPU to be selected to run
the pseudo-locking code and then that CPU to go offline before the
thread is able to run on it.

Fix this by ensuring that the cpu_hotplug_lock is taken while the CPU on
which code has to run needs to be controlled. Since the cpu_hotplug_lock
is always taken before rdtgroup_mutex the lock order is maintained.

Fixes: e0bdfe8e36f3 ("x86/intel_rdt: Support creation/removal of pseudo-locked region")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: stable <stable@vger.kernel.org>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/b7b17432a80f95a1fa21a1698ba643014f58ad31.1544476425.git.reinette.chatre@intel.com
---
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
 
