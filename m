Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E44DECE567
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D57BC20870
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:24:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D57BC20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392436AbeIVGQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:16:09 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44127 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391923AbeIVGKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:44 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdv-0008BM-0Q; Sat, 22 Sep 2018 01:19:27 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdp-0000ug-AS; Sat, 22 Sep 2018 01:19:21 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Paolo Bonzini" <pbonzini@redhat.com>,
        "Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>
Date:   Sat, 22 Sep 2018 01:15:42 +0100
Message-ID: <lsq.1537575342.424605783@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 62/63] KVM: x86: introduce num_emulated_msrs
In-Reply-To: <lsq.1537575341.194909669@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.58-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Bonzini <pbonzini@redhat.com>

commit 62ef68bb4d00f1a662e487f3fc44ce8521c416aa upstream.

We will want to filter away MSR_IA32_SMBASE from the emulated_msrs if
the host CPU does not support SMM virtualization.  Introduce the
logic to do that, and also move paravirt MSRs to emulated_msrs for
simplicity and to get rid of KVM_SAVE_MSRS_BEGIN.

Reviewed-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kvm/x86.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -876,17 +876,11 @@ EXPORT_SYMBOL_GPL(kvm_rdpmc);
  *
  * This list is modified at module load time to reflect the
  * capabilities of the host cpu. This capabilities test skips MSRs that are
- * kvm-specific. Those are put in the beginning of the list.
+ * kvm-specific. Those are put in emulated_msrs; filtering of emulated_msrs
+ * may depend on host virtualization features rather than host cpu features.
  */
 
-#define KVM_SAVE_MSRS_BEGIN	12
 static u32 msrs_to_save[] = {
-	MSR_KVM_SYSTEM_TIME, MSR_KVM_WALL_CLOCK,
-	MSR_KVM_SYSTEM_TIME_NEW, MSR_KVM_WALL_CLOCK_NEW,
-	HV_X64_MSR_GUEST_OS_ID, HV_X64_MSR_HYPERCALL,
-	HV_X64_MSR_TIME_REF_COUNT, HV_X64_MSR_REFERENCE_TSC,
-	HV_X64_MSR_APIC_ASSIST_PAGE, MSR_KVM_ASYNC_PF_EN, MSR_KVM_STEAL_TIME,
-	MSR_KVM_PV_EOI_EN,
 	MSR_IA32_SYSENTER_CS, MSR_IA32_SYSENTER_ESP, MSR_IA32_SYSENTER_EIP,
 	MSR_STAR,
 #ifdef CONFIG_X86_64
@@ -899,7 +893,14 @@ static u32 msrs_to_save[] = {
 
 static unsigned num_msrs_to_save;
 
-static const u32 emulated_msrs[] = {
+static u32 emulated_msrs[] = {
+	MSR_KVM_SYSTEM_TIME, MSR_KVM_WALL_CLOCK,
+	MSR_KVM_SYSTEM_TIME_NEW, MSR_KVM_WALL_CLOCK_NEW,
+	HV_X64_MSR_GUEST_OS_ID, HV_X64_MSR_HYPERCALL,
+	HV_X64_MSR_TIME_REF_COUNT, HV_X64_MSR_REFERENCE_TSC,
+	HV_X64_MSR_APIC_ASSIST_PAGE, MSR_KVM_ASYNC_PF_EN, MSR_KVM_STEAL_TIME,
+	MSR_KVM_PV_EOI_EN,
+
 	MSR_IA32_TSC_ADJUST,
 	MSR_IA32_TSCDEADLINE,
 	MSR_IA32_MISC_ENABLE,
@@ -907,6 +908,8 @@ static const u32 emulated_msrs[] = {
 	MSR_IA32_MCG_CTL,
 };
 
+static unsigned num_emulated_msrs;
+
 bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
 {
 	if (efer & efer_reserved_bits)
@@ -2774,7 +2777,7 @@ long kvm_arch_dev_ioctl(struct file *fil
 		if (copy_from_user(&msr_list, user_msr_list, sizeof msr_list))
 			goto out;
 		n = msr_list.nmsrs;
-		msr_list.nmsrs = num_msrs_to_save + ARRAY_SIZE(emulated_msrs);
+		msr_list.nmsrs = num_msrs_to_save + num_emulated_msrs;
 		if (copy_to_user(user_msr_list, &msr_list, sizeof msr_list))
 			goto out;
 		r = -E2BIG;
@@ -2786,7 +2789,7 @@ long kvm_arch_dev_ioctl(struct file *fil
 			goto out;
 		if (copy_to_user(user_msr_list->indices + num_msrs_to_save,
 				 &emulated_msrs,
-				 ARRAY_SIZE(emulated_msrs) * sizeof(u32)))
+				 num_emulated_msrs * sizeof(u32)))
 			goto out;
 		r = 0;
 		break;
@@ -4009,8 +4012,7 @@ static void kvm_init_msr_list(void)
 	u32 dummy[2];
 	unsigned i, j;
 
-	/* skip the first msrs in the list. KVM-specific */
-	for (i = j = KVM_SAVE_MSRS_BEGIN; i < ARRAY_SIZE(msrs_to_save); i++) {
+	for (i = j = 0; i < ARRAY_SIZE(msrs_to_save); i++) {
 		if (rdmsr_safe(msrs_to_save[i], &dummy[0], &dummy[1]) < 0)
 			continue;
 
@@ -4035,6 +4037,18 @@ static void kvm_init_msr_list(void)
 		j++;
 	}
 	num_msrs_to_save = j;
+
+	for (i = j = 0; i < ARRAY_SIZE(emulated_msrs); i++) {
+		switch (emulated_msrs[i]) {
+		default:
+			break;
+		}
+
+		if (j < i)
+			emulated_msrs[j] = emulated_msrs[i];
+		j++;
+	}
+	num_emulated_msrs = j;
 }
 
 static int vcpu_mmio_write(struct kvm_vcpu *vcpu, gpa_t addr, int len,

