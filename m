Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D20FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF3E821902
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999275;
	bh=mzOY71yJtGJ8JGykn0/VUKLVRFxpfOH4Bj0uX6Dmwxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pmVDpAFa7BUpPOsLztQxFYVfafZ64hKZN/iJsiTG8w1CK2BnDAaib0EaSnfw6ILAY
	 fYKIn1Hhd4Q0t4kLVADddA74vGULsTU2uwNhT2UFlGuj8+qd+EtfT47t7KE9Qhtb1s
	 kU+773087yckT7JfpWOwLVe/Zgu/inEigQsmZKRg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731093AbeL1MOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:14:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:33318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731029AbeL1MO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:14:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5D0C218FD;
        Fri, 28 Dec 2018 12:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999266;
        bh=mzOY71yJtGJ8JGykn0/VUKLVRFxpfOH4Bj0uX6Dmwxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=itoZRdF4aXO1pmcYDLK8P6BHcy7iP4SNbsgle+12aO39/v4lVEvaBZv3t3OwuI8SV
         Xsub+AgBX4y/BjSK8vukzbBIK23nUVdDbQQikrmen7yRzzd/HDV3DmtFwOIL2vZ4e4
         RzstPrJJSL6SiayXlau6GfpmI+I5kORfx/gCeHs8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, gavin.hindman@intel.com,
        jithu.joseph@intel.com, x86-ml <x86@kernel.org>
Subject: [PATCH 4.19 29/46] x86/intel_rdt: Ensure a CPU remains online for the regions pseudo-locking sequence
Date:   Fri, 28 Dec 2018 12:52:23 +0100
Message-Id: <20181228113126.499269358@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113124.971620049@linuxfoundation.org>
References: <20181228113124.971620049@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Reinette Chatre <reinette.chatre@intel.com>

commit 80b71c340f17705ec145911b9a193ea781811b16 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
@@ -23,6 +23,7 @@
 
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
+#include <linux/cpu.h>
 #include <linux/kernfs.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
@@ -310,9 +311,11 @@ ssize_t rdtgroup_schemata_write(struct k
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
@@ -367,6 +370,7 @@ ssize_t rdtgroup_schemata_write(struct k
 
 out:
 	rdtgroup_kn_unlock(of->kn);
+	cpus_read_unlock();
 	return ret ?: nbytes;
 }
 


