Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B939CECE563
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 18:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B7BD2083A
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 18:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B7BD2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbeIPAMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 20:12:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56519 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbeIPAMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 20:12:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8FIqRDc3924537
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 15 Sep 2018 11:52:27 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8FIqQhM3924533;
        Sat, 15 Sep 2018 11:52:26 -0700
Date:   Sat, 15 Sep 2018 11:52:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Brijesh Singh <tipbot@zytor.com>
Message-ID: <tip-6a1cac56f41f9ea94e440dfcc1cac44b41a1b194@git.kernel.org>
Cc:     sean.j.christopherson@intel.com, thomas.lendacky@amd.com,
        rkrcmar@redhat.com, bp@suse.de, brijesh.singh@amd.com,
        mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, pbonzini@redhat.com
Reply-To: hpa@zytor.com, mingo@kernel.org, brijesh.singh@amd.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          pbonzini@redhat.com, sean.j.christopherson@intel.com,
          rkrcmar@redhat.com, thomas.lendacky@amd.com, bp@suse.de
In-Reply-To: <1536932759-12905-3-git-send-email-brijesh.singh@amd.com>
References: <1536932759-12905-3-git-send-email-brijesh.singh@amd.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/kvm: Use __bss_decrypted attribute in shared
 variables
Git-Commit-ID: 6a1cac56f41f9ea94e440dfcc1cac44b41a1b194
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

Commit-ID:  6a1cac56f41f9ea94e440dfcc1cac44b41a1b194
Gitweb:     https://git.kernel.org/tip/6a1cac56f41f9ea94e440dfcc1cac44b41a1b194
Author:     Brijesh Singh <brijesh.singh@amd.com>
AuthorDate: Fri, 14 Sep 2018 08:45:59 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 15 Sep 2018 20:48:46 +0200

x86/kvm: Use __bss_decrypted attribute in shared variables

The recent removal of the memblock dependency from kvmclock caused a SEV
guest regression because the wall_clock and hv_clock_boot variables are
no longer mapped decrypted when SEV is active.

Use the __bss_decrypted attribute to put the static wall_clock and
hv_clock_boot in the .bss..decrypted section so that they are mapped
decrypted during boot.

In the preparatory stage of CPU hotplug, the per-cpu pvclock data pointer
assigns either an element of the static array or dynamically allocated
memory for the pvclock data pointer. The static array are now mapped
decrypted but the dynamically allocated memory is not mapped decrypted.
However, when SEV is active this memory range must be mapped decrypted.

Add a function which is called after the page allocator is up, and
allocate memory for the pvclock data pointers for the all possible cpus.
Map this memory range as decrypted when SEV is active.

Fixes: 368a540e0232 ("x86/kvmclock: Remove memblock dependency")
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: kvm@vger.kernel.org
Link: https://lkml.kernel.org/r/1536932759-12905-3-git-send-email-brijesh.singh@amd.com

---
 arch/x86/kernel/kvmclock.c | 52 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 1e6764648af3..013fe3d21dbb 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -28,6 +28,7 @@
 #include <linux/sched/clock.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/set_memory.h>
 
 #include <asm/hypervisor.h>
 #include <asm/mem_encrypt.h>
@@ -61,9 +62,10 @@ early_param("no-kvmclock-vsyscall", parse_no_kvmclock_vsyscall);
 	(PAGE_SIZE / sizeof(struct pvclock_vsyscall_time_info))
 
 static struct pvclock_vsyscall_time_info
-			hv_clock_boot[HVC_BOOT_ARRAY_SIZE] __aligned(PAGE_SIZE);
-static struct pvclock_wall_clock wall_clock;
+			hv_clock_boot[HVC_BOOT_ARRAY_SIZE] __bss_decrypted __aligned(PAGE_SIZE);
+static struct pvclock_wall_clock wall_clock __bss_decrypted;
 static DEFINE_PER_CPU(struct pvclock_vsyscall_time_info *, hv_clock_per_cpu);
+static struct pvclock_vsyscall_time_info *hvclock_mem;
 
 static inline struct pvclock_vcpu_time_info *this_cpu_pvti(void)
 {
@@ -236,6 +238,45 @@ static void kvm_shutdown(void)
 	native_machine_shutdown();
 }
 
+static void __init kvmclock_init_mem(void)
+{
+	unsigned long ncpus;
+	unsigned int order;
+	struct page *p;
+	int r;
+
+	if (HVC_BOOT_ARRAY_SIZE >= num_possible_cpus())
+		return;
+
+	ncpus = num_possible_cpus() - HVC_BOOT_ARRAY_SIZE;
+	order = get_order(ncpus * sizeof(*hvclock_mem));
+
+	p = alloc_pages(GFP_KERNEL, order);
+	if (!p) {
+		pr_warn("%s: failed to alloc %d pages", __func__, (1U << order));
+		return;
+	}
+
+	hvclock_mem = page_address(p);
+
+	/*
+	 * hvclock is shared between the guest and the hypervisor, must
+	 * be mapped decrypted.
+	 */
+	if (sev_active()) {
+		r = set_memory_decrypted((unsigned long) hvclock_mem,
+					 1UL << order);
+		if (r) {
+			__free_pages(p, order);
+			hvclock_mem = NULL;
+			pr_warn("kvmclock: set_memory_decrypted() failed. Disabling\n");
+			return;
+		}
+	}
+
+	memset(hvclock_mem, 0, PAGE_SIZE << order);
+}
+
 static int __init kvm_setup_vsyscall_timeinfo(void)
 {
 #ifdef CONFIG_X86_64
@@ -250,6 +291,9 @@ static int __init kvm_setup_vsyscall_timeinfo(void)
 
 	kvm_clock.archdata.vclock_mode = VCLOCK_PVCLOCK;
 #endif
+
+	kvmclock_init_mem();
+
 	return 0;
 }
 early_initcall(kvm_setup_vsyscall_timeinfo);
@@ -269,8 +313,10 @@ static int kvmclock_setup_percpu(unsigned int cpu)
 	/* Use the static page for the first CPUs, allocate otherwise */
 	if (cpu < HVC_BOOT_ARRAY_SIZE)
 		p = &hv_clock_boot[cpu];
+	else if (hvclock_mem)
+		p = hvclock_mem + cpu - HVC_BOOT_ARRAY_SIZE;
 	else
-		p = kzalloc(sizeof(*p), GFP_KERNEL);
+		return -ENOMEM;
 
 	per_cpu(hv_clock_per_cpu, cpu) = p;
 	return p ? 0 : -ENOMEM;
