Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F28ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 20:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5137420854
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 20:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="JHcxbUqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5137420854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=runbox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbeGUVfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 17:35:12 -0400
Received: from aibo.runbox.com ([91.220.196.211]:32770 "EHLO aibo.runbox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728110AbeGUVfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 17:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
         s=rbselector1; h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
         bh=+eTJo7qWEBRtXUZwvFl2lEV8dKSwETVAxfYQdSQoYR4=; b=JHcxbUqwODQUws0Xk2atGy4zO
        ZtGdCEpb4/bW1yK5seLEJTHFZzRvKZPlXqMIpMehUQP/+nW8NLwZ7p1ri+GssaxLWe3pkB1aLOJX5
        WftHdn6KV+FK9FSShxMxp1fJb7LQ8fdAE9bAGc+GO4Gju24jfKy4Ir4Mr6DulS6tJWY8VHR5Vy6l2
        QNoGs22SKWtNrcRkMfu/sUGMtCm+3zV5UoDMS/H3ltnIppw0JGdL2+YILZfr3Zf8mUapwfEjOtZDS
        wVwZ9Bwcx3HgeJBoXqUksOzneKWf4JRE0EeTthtLeejWczw4WCXGKZvPC2PG+AxU+fAY+r8A9iYt1
        NpxB+pV5A==;
Received: from [10.9.9.210] (helo=mailfront10.runbox.com)
        by mailtransmit03.runbox with esmtp (Exim 4.86_2)
        (envelope-from <m.v.b@runbox.com>)
        id 1fgxtG-0002Tu-MP; Sat, 21 Jul 2018 21:50:06 +0200
Received: by mailfront10.runbox.com with esmtpsa  (uid:769847 )  (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.82)
        id 1fgxt2-0007pF-RS; Sat, 21 Jul 2018 21:49:53 +0200
From:   "M. Vefa Bicakci" <m.v.b@runbox.com>
To:     linux-kernel@vger.kernel.org
Cc:     "M . Vefa Bicakci" <m.v.b@runbox.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, x86@kernel.org,
        stable@vger.kernel.org
Subject: [PATCH 2/2] xen/pv: Call get_cpu_address_sizes to set x86_virt/phys_bits
Date:   Sat, 21 Jul 2018 15:49:09 -0400
Message-Id: <20180721194909.23903-2-m.v.b@runbox.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180721194909.23903-1-m.v.b@runbox.com>
References: <20180721194909.23903-1-m.v.b@runbox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d94a155c59c9 ("x86/cpu: Prevent cpuinfo_x86::x86_phys_bits
adjustment corruption") has moved the query and calculation of the
"x86_virt_bits" and "x86_phys_bits" fields of the "cpuinfo_x86" struct
from the "get_cpu_cap" function to a new function named
"get_cpu_address_sizes".

One of the call sites related to Xen PV VMs was unfortunately missed
in the aforementioned commit, and this prevents successful boot-up of
kernel versions 4.17 and up in Xen PV VMs.

Signed-off-by: M. Vefa Bicakci <m.v.b@runbox.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: xen-devel@lists.xenproject.org
Cc: x86@kernel.org
Cc: stable@vger.kernel.org # for v4.17 and up
Fixes: d94a155c59c9 ("x86/cpu: Prevent cpuinfo_x86::x86_phys_bits adjustment corruption")
---
 arch/x86/kernel/cpu/common.c | 2 +-
 arch/x86/kernel/cpu/cpu.h    | 1 +
 arch/x86/xen/enlighten_pv.c  | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index eb4cb3efd20e..2322d0c4bfd2 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -911,7 +911,7 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 	apply_forced_caps(c);
 }
 
-static void get_cpu_address_sizes(struct cpuinfo_x86 *c)
+void get_cpu_address_sizes(struct cpuinfo_x86 *c)
 {
 	u32 eax, ebx, ecx, edx;
 
diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
index 38216f678fc3..12a5f0cec0b2 100644
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -46,6 +46,7 @@ extern const struct cpu_dev *const __x86_cpu_dev_start[],
 			    *const __x86_cpu_dev_end[];
 
 extern void get_cpu_cap(struct cpuinfo_x86 *c);
+extern void get_cpu_address_sizes(struct cpuinfo_x86 *c);
 extern void cpu_detect_cache_sizes(struct cpuinfo_x86 *c);
 extern void init_scattered_cpuid_features(struct cpuinfo_x86 *c);
 extern u32 get_scattered_cpuid_leaf(unsigned int level,
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 439a94bf89ad..87afb000142a 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1257,6 +1257,7 @@ asmlinkage __visible void __init xen_start_kernel(void)
 
 	/* Work out if we support NX */
 	get_cpu_cap(&boot_cpu_data);
+	get_cpu_address_sizes(&boot_cpu_data);
 	x86_configure_nx();
 
 	/* Let's presume PV guests always boot on vCPU with id 0. */
-- 
2.17.1

