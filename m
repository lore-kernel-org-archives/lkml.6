Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D684ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C75A020854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:26:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C75A020854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388335AbeGWN1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:27:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45204 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387882AbeGWN1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:27:15 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 56C09BD4;
        Mon, 23 Jul 2018 12:26:17 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Dmitry V. Levin" <ldv@altlinux.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.17 08/63] x86/kvm/vmx: dont read current->thread.{fs,gs}base of legacy tasks
Date:   Mon, 23 Jul 2018 14:24:14 +0200
Message-Id: <20180723122446.692821560@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122446.351334162@linuxfoundation.org>
References: <20180723122446.351334162@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vitaly Kuznetsov <vkuznets@redhat.com>

commit b062b794c7831a70bda4dfac202c1a9418e06ac0 upstream.

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
Cc: stable@vger.kernel.org
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx.c |   25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -2376,6 +2376,7 @@ static void vmx_save_host_state(struct k
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 #ifdef CONFIG_X86_64
 	int cpu = raw_smp_processor_id();
+	unsigned long fs_base, kernel_gs_base;
 #endif
 	int i;
 
@@ -2391,12 +2392,20 @@ static void vmx_save_host_state(struct k
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
+		fs_base = current->thread.fsbase;
+		kernel_gs_base = current->thread.gsbase;
+	} else {
+#endif
+		savesegment(fs, vmx->host_state.fs_sel);
+		savesegment(gs, vmx->host_state.gs_sel);
+#ifdef CONFIG_X86_64
+		fs_base = read_msr(MSR_FS_BASE);
+		kernel_gs_base = read_msr(MSR_KERNEL_GS_BASE);
+	}
 #endif
 	if (!(vmx->host_state.fs_sel & 7)) {
 		vmcs_write16(HOST_FS_SELECTOR, vmx->host_state.fs_sel);
@@ -2416,10 +2425,10 @@ static void vmx_save_host_state(struct k
 	savesegment(ds, vmx->host_state.ds_sel);
 	savesegment(es, vmx->host_state.es_sel);
 
-	vmcs_writel(HOST_FS_BASE, current->thread.fsbase);
+	vmcs_writel(HOST_FS_BASE, fs_base);
 	vmcs_writel(HOST_GS_BASE, cpu_kernelmode_gs_base(cpu));
 
-	vmx->msr_host_kernel_gs_base = current->thread.gsbase;
+	vmx->msr_host_kernel_gs_base = kernel_gs_base;
 	if (is_long_mode(&vmx->vcpu))
 		wrmsrl(MSR_KERNEL_GS_BASE, vmx->msr_guest_kernel_gs_base);
 #else


