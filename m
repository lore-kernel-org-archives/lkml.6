Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21184C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE8020657
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE8020657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeHPVtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 17:49:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57766 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbeHPVtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 17:49:01 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B5CF0D58;
        Thu, 16 Aug 2018 18:48:50 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "M. Vefa Bicakci" <m.v.b@runbox.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, x86@kernel.org
Subject: [PATCH 4.18 06/22] xen/pv: Call get_cpu_address_sizes to set x86_virt/phys_bits
Date:   Thu, 16 Aug 2018 20:45:22 +0200
Message-Id: <20180816171556.744027410@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180816171556.502583508@linuxfoundation.org>
References: <20180816171556.502583508@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: M. Vefa Bicakci <m.v.b@runbox.com>

commit 405c018a25fe464dc68057bbc8014a58f2bd4422 upstream.

Commit d94a155c59c9 ("x86/cpu: Prevent cpuinfo_x86::x86_phys_bits
adjustment corruption") has moved the query and calculation of the
x86_virt_bits and x86_phys_bits fields of the cpuinfo_x86 struct
from the get_cpu_cap function to a new function named
get_cpu_address_sizes.

One of the call sites related to Xen PV VMs was unfortunately missed
in the aforementioned commit. This prevents successful boot-up of
kernel versions 4.17 and up in Xen PV VMs if CONFIG_DEBUG_VIRTUAL
is enabled, due to the following code path:

  enlighten_pv.c::xen_start_kernel
    mmu_pv.c::xen_reserve_special_pages
      page.h::__pa
        physaddr.c::__phys_addr
          physaddr.h::phys_addr_valid

phys_addr_valid uses boot_cpu_data.x86_phys_bits to validate physical
addresses. boot_cpu_data.x86_phys_bits is no longer populated before
the call to xen_reserve_special_pages due to the aforementioned commit
though, so the validation performed by phys_addr_valid fails, which
causes __phys_addr to trigger a BUG, preventing boot-up.

Signed-off-by: M. Vefa Bicakci <m.v.b@runbox.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
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
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/common.c |    2 +-
 arch/x86/kernel/cpu/cpu.h    |    1 +
 arch/x86/xen/enlighten_pv.c  |    3 +++
 3 files changed, 5 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -905,7 +905,7 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 	apply_forced_caps(c);
 }
 
-static void get_cpu_address_sizes(struct cpuinfo_x86 *c)
+void get_cpu_address_sizes(struct cpuinfo_x86 *c)
 {
 	u32 eax, ebx, ecx, edx;
 
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -46,6 +46,7 @@ extern const struct cpu_dev *const __x86
 			    *const __x86_cpu_dev_end[];
 
 extern void get_cpu_cap(struct cpuinfo_x86 *c);
+extern void get_cpu_address_sizes(struct cpuinfo_x86 *c);
 extern void cpu_detect_cache_sizes(struct cpuinfo_x86 *c);
 extern void init_scattered_cpuid_features(struct cpuinfo_x86 *c);
 extern u32 get_scattered_cpuid_leaf(unsigned int level,
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1259,6 +1259,9 @@ asmlinkage __visible void __init xen_sta
 	get_cpu_cap(&boot_cpu_data);
 	x86_configure_nx();
 
+	/* Determine virtual and physical address sizes */
+	get_cpu_address_sizes(&boot_cpu_data);
+
 	/* Let's presume PV guests always boot on vCPU with id 0. */
 	per_cpu(xen_vcpu_id, 0) = 0;
 


