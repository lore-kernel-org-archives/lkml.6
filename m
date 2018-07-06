Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FBCC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3681E23E0B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3681E23E0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753976AbeGFKnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 06:43:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53503 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753522AbeGFKnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 06:43:05 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w66Agufh1435305
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 6 Jul 2018 03:42:56 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w66Aguo21435302;
        Fri, 6 Jul 2018 03:42:56 -0700
Date:   Fri, 6 Jul 2018 03:42:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for K. Y. Srinivasan" <tipbot@zytor.com>
Message-ID: <tip-1268ed0c474a5c8f165ef386f3310521b5e00e27@git.kernel.org>
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        mingo@kernel.org, kys@microsoft.com, mikelley@microsoft.com
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
          kys@microsoft.com, mikelley@microsoft.com, mingo@kernel.org
In-Reply-To: <20180703230155.15160-1-kys@linuxonhyperv.com>
References: <20180703230155.15160-1-kys@linuxonhyperv.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/hyperv] x86/hyper-v: Fix the circular dependency in IPI
 enlightenment
Git-Commit-ID: 1268ed0c474a5c8f165ef386f3310521b5e00e27
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

Commit-ID:  1268ed0c474a5c8f165ef386f3310521b5e00e27
Gitweb:     https://git.kernel.org/tip/1268ed0c474a5c8f165ef386f3310521b5e00e27
Author:     K. Y. Srinivasan <kys@microsoft.com>
AuthorDate: Tue, 3 Jul 2018 16:01:55 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 6 Jul 2018 12:32:59 +0200

x86/hyper-v: Fix the circular dependency in IPI enlightenment

The IPI hypercalls depend on being able to map the Linux notion of CPU ID
to the hypervisor's notion of the CPU ID. The array hv_vp_index[] provides
this mapping. Code for populating this array depends on the IPI functionality.
Break this circular dependency.

[ tglx: Use a proper define instead of '-1' with a u32 variable as pointed
  	out by Vitaly ]

Fixes: 68bb7bfb7985 ("X86/Hyper-V: Enable IPI enlightenments")
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Cc: gregkh@linuxfoundation.org
Cc: devel@linuxdriverproject.org
Cc: olaf@aepfle.de
Cc: apw@canonical.com
Cc: jasowang@redhat.com
Cc: hpa@zytor.com
Cc: sthemmin@microsoft.com
Cc: Michael.H.Kelley@microsoft.com
Cc: vkuznets@redhat.com
Link: https://lkml.kernel.org/r/20180703230155.15160-1-kys@linuxonhyperv.com


---
 arch/x86/hyperv/hv_apic.c       | 5 +++++
 arch/x86/hyperv/hv_init.c       | 5 ++++-
 arch/x86/include/asm/mshyperv.h | 5 ++++-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index f68855499391..402338365651 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -114,6 +114,8 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector)
 		ipi_arg->vp_set.format = HV_GENERIC_SET_SPARSE_4K;
 		nr_bank = cpumask_to_vpset(&(ipi_arg->vp_set), mask);
 	}
+	if (nr_bank < 0)
+		goto ipi_mask_ex_done;
 	if (!nr_bank)
 		ipi_arg->vp_set.format = HV_GENERIC_SET_ALL;
 
@@ -158,6 +160,9 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector)
 
 	for_each_cpu(cur_cpu, mask) {
 		vcpu = hv_cpu_number_to_vp_number(cur_cpu);
+		if (vcpu == VP_INVAL)
+			goto ipi_mask_done;
+
 		/*
 		 * This particular version of the IPI hypercall can
 		 * only target upto 64 CPUs.
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 4c431e1c1eff..1ff420217298 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -265,7 +265,7 @@ void __init hyperv_init(void)
 {
 	u64 guest_id, required_msrs;
 	union hv_x64_msr_hypercall_contents hypercall_msr;
-	int cpuhp;
+	int cpuhp, i;
 
 	if (x86_hyper_type != X86_HYPER_MS_HYPERV)
 		return;
@@ -293,6 +293,9 @@ void __init hyperv_init(void)
 	if (!hv_vp_index)
 		return;
 
+	for (i = 0; i < num_possible_cpus(); i++)
+		hv_vp_index[i] = VP_INVAL;
+
 	hv_vp_assist_page = kcalloc(num_possible_cpus(),
 				    sizeof(*hv_vp_assist_page), GFP_KERNEL);
 	if (!hv_vp_assist_page) {
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 3cd14311edfa..5a7375ed5f7c 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -9,6 +9,8 @@
 #include <asm/hyperv-tlfs.h>
 #include <asm/nospec-branch.h>
 
+#define VP_INVAL	U32_MAX
+
 struct ms_hyperv_info {
 	u32 features;
 	u32 misc_features;
@@ -20,7 +22,6 @@ struct ms_hyperv_info {
 
 extern struct ms_hyperv_info ms_hyperv;
 
-
 /*
  * Generate the guest ID.
  */
@@ -281,6 +282,8 @@ static inline int cpumask_to_vpset(struct hv_vpset *vpset,
 	 */
 	for_each_cpu(cpu, cpus) {
 		vcpu = hv_cpu_number_to_vp_number(cpu);
+		if (vcpu == VP_INVAL)
+			return -1;
 		vcpu_bank = vcpu / 64;
 		vcpu_offset = vcpu % 64;
 		__set_bit(vcpu_offset, (unsigned long *)
