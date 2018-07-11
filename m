Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42E8C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A504920C0E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A504920C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388814AbeGKRmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 13:42:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50088 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732492AbeGKRmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 13:42:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 24E097C6CA;
        Wed, 11 Jul 2018 17:37:21 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 82246111AF36;
        Wed, 11 Jul 2018 17:37:19 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Masatake YAMATO <yamato@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/kvm/vmx: don't read current->thread.{fs,gs}base of legacy tasks
Date:   Wed, 11 Jul 2018 19:37:18 +0200
Message-Id: <20180711173718.8850-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 11 Jul 2018 17:37:21 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 11 Jul 2018 17:37:21 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we switched from doing rdmsr() to reading FS/GS base values from
current->thread we completely forgot about legacy 32-bit userspaces which
we still support in KVM (why?). task->thread.{fsbase,gsbase} are only
synced for 64-bit processes, calling save_fsgs_for_kvm() and using
its result from current is illegal for legacy processes.

There's no ARCH_SET_FS/GS prctls for legacy applications. Base MSRs are,
however, not always equal to zero. Intel's manual says (3.4.4 Segment
Loading Instructions in IA-32e Mode):

"In order to set up compatibility mode for an application, segment-load
instructions (MOV to Sreg, POP Sreg) work normally in 64-bit mode. An
entry is read from the system descriptor table (GDT or LDT) and is loaded
in the hidden portion of the segment register.
...
The hidden descriptor register fields for FS.base and GS.base are
physically mapped to MSRs in order to load all address bits supported by
a 64-bit implementation.
"

The issue was found by strace test suite where 32-bit ioctl_kvm_run test
started segfaulting.

Reported-by: Dmitry V. Levin <ldv@altlinux.org>
Bisected-by: Masatake YAMATO <yamato@redhat.com>
Fixes: 42b933b59721 ("x86/kvm/vmx: read MSR_{FS,KERNEL_GS}_BASE from current->thread")
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/vmx.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 559a12b6184d..65968649b365 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -2560,6 +2560,7 @@ static void vmx_save_host_state(struct kvm_vcpu *vcpu)
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 #ifdef CONFIG_X86_64
 	int cpu = raw_smp_processor_id();
+	unsigned long fsbase, kernel_gsbase;
 #endif
 	int i;
 
@@ -2575,12 +2576,20 @@ static void vmx_save_host_state(struct kvm_vcpu *vcpu)
 	vmx->host_state.gs_ldt_reload_needed = vmx->host_state.ldt_sel;
 
 #ifdef CONFIG_X86_64
-	save_fsgs_for_kvm();
-	vmx->host_state.fs_sel = current->thread.fsindex;
-	vmx->host_state.gs_sel = current->thread.gsindex;
-#else
-	savesegment(fs, vmx->host_state.fs_sel);
-	savesegment(gs, vmx->host_state.gs_sel);
+	if (likely(is_64bit_mm(current->mm))) {
+		save_fsgs_for_kvm();
+		vmx->host_state.fs_sel = current->thread.fsindex;
+		vmx->host_state.gs_sel = current->thread.gsindex;
+		fsbase = current->thread.fsbase;
+		kernel_gsbase = current->thread.gsbase;
+	} else {
+#endif
+		savesegment(fs, vmx->host_state.fs_sel);
+		savesegment(gs, vmx->host_state.gs_sel);
+#ifdef CONFIG_X86_64
+		fsbase = read_msr(MSR_FS_BASE);
+		kernel_gsbase = read_msr(MSR_KERNEL_GS_BASE);
+	}
 #endif
 	if (!(vmx->host_state.fs_sel & 7)) {
 		vmcs_write16(HOST_FS_SELECTOR, vmx->host_state.fs_sel);
@@ -2600,10 +2609,10 @@ static void vmx_save_host_state(struct kvm_vcpu *vcpu)
 	savesegment(ds, vmx->host_state.ds_sel);
 	savesegment(es, vmx->host_state.es_sel);
 
-	vmcs_writel(HOST_FS_BASE, current->thread.fsbase);
+	vmcs_writel(HOST_FS_BASE, fsbase);
 	vmcs_writel(HOST_GS_BASE, cpu_kernelmode_gs_base(cpu));
 
-	vmx->msr_host_kernel_gs_base = current->thread.gsbase;
+	vmx->msr_host_kernel_gs_base = kernel_gsbase;
 	if (is_long_mode(&vmx->vcpu))
 		wrmsrl(MSR_KERNEL_GS_BASE, vmx->msr_guest_kernel_gs_base);
 #else
-- 
2.14.4

