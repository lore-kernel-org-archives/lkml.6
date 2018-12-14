Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02119C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7835214DE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789720;
	bh=jo62MDfks2B94aRB28OqCwbDq61puIV40kT4JcOxsJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cc6+krvsZ1K1WY1AVruYqt10TPPz6JDlF+kjYWEs7VLoH7hA0c/4l6/jjBpScXcJy
	 ezy2qcwYlbiSRBwfxn9eifOB9rPLtR2AgwLFLge1VlfLDLvuKV0cOZm6eefhuEFBOE
	 7U1SlbdVjGJo0FDWhPvtLxdbm6FNVLgVxnyizcyA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7835214DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732535AbeLNMPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:15:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:35230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732237AbeLNMPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:15:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 913662133F;
        Fri, 14 Dec 2018 12:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789717;
        bh=jo62MDfks2B94aRB28OqCwbDq61puIV40kT4JcOxsJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fBYFHqQFa+gdBFp+mmy7baA27hA0pdQLt9l7CbzkI1VAf8h2WgfYcUnRFkOyzigS0
         ehUSqT74VB+GtZxbeEjaX/HK2CK8nMttwRgxS4nIUrjg5zz84f25Nco3VZq8pyJlAF
         gbVxc2SO5BRmUQPXPrSLIAx4WcnXb9UH4MA0dKrA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 50/88] KVM/x86: Remove indirect MSR op calls from SPEC_CTRL
Date:   Fri, 14 Dec 2018 13:00:24 +0100
Message-Id: <20181214115706.363927232@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115702.151309521@linuxfoundation.org>
References: <20181214115702.151309521@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Bonzini <pbonzini@redhat.com>

commit ecb586bd29c99fb4de599dec388658e74388daad upstream.

Having a paravirt indirect call in the IBRS restore path is not a
good idea, since we are trying to protect from speculative execution
of bogus indirect branch targets.  It is also slower, so use
native_wrmsrl() on the vmentry path too.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: KarimAllah Ahmed <karahmed@amazon.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kvm@vger.kernel.org
Cc: stable@vger.kernel.org
Fixes: d28b387fb74da95d69d2615732f50cceb38e9a4d
Link: http://lkml.kernel.org/r/20180222154318.20361-2-pbonzini@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 4.4: adjust context]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm.c |    7 ++++---
 arch/x86/kvm/vmx.c |    7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -37,6 +37,7 @@
 #include <asm/desc.h>
 #include <asm/debugreg.h>
 #include <asm/kvm_para.h>
+#include <asm/microcode.h>
 #include <asm/spec-ctrl.h>
 
 #include <asm/virtext.h>
@@ -3904,7 +3905,7 @@ static void svm_vcpu_run(struct kvm_vcpu
 	 * being speculatively taken.
 	 */
 	if (svm->spec_ctrl)
-		wrmsrl(MSR_IA32_SPEC_CTRL, svm->spec_ctrl);
+		native_wrmsrl(MSR_IA32_SPEC_CTRL, svm->spec_ctrl);
 
 	asm volatile (
 		"push %%" _ASM_BP "; \n\t"
@@ -4014,10 +4015,10 @@ static void svm_vcpu_run(struct kvm_vcpu
 	 * save it.
 	 */
 	if (!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL))
-		rdmsrl(MSR_IA32_SPEC_CTRL, svm->spec_ctrl);
+		svm->spec_ctrl = native_read_msr(MSR_IA32_SPEC_CTRL);
 
 	if (svm->spec_ctrl)
-		wrmsrl(MSR_IA32_SPEC_CTRL, 0);
+		native_wrmsrl(MSR_IA32_SPEC_CTRL, 0);
 
 	/* Eliminate branch target predictions from guest mode */
 	vmexit_fill_RSB();
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -48,6 +48,7 @@
 #include <asm/kexec.h>
 #include <asm/apic.h>
 #include <asm/irq_remapping.h>
+#include <asm/microcode.h>
 #include <asm/spec-ctrl.h>
 
 #include "trace.h"
@@ -8658,7 +8659,7 @@ static void __noclone vmx_vcpu_run(struc
 	 * being speculatively taken.
 	 */
 	if (vmx->spec_ctrl)
-		wrmsrl(MSR_IA32_SPEC_CTRL, vmx->spec_ctrl);
+		native_wrmsrl(MSR_IA32_SPEC_CTRL, vmx->spec_ctrl);
 
 	vmx->__launched = vmx->loaded_vmcs->launched;
 	asm(
@@ -8794,10 +8795,10 @@ static void __noclone vmx_vcpu_run(struc
 	 * save it.
 	 */
 	if (!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL))
-		rdmsrl(MSR_IA32_SPEC_CTRL, vmx->spec_ctrl);
+		vmx->spec_ctrl = native_read_msr(MSR_IA32_SPEC_CTRL);
 
 	if (vmx->spec_ctrl)
-		wrmsrl(MSR_IA32_SPEC_CTRL, 0);
+		native_wrmsrl(MSR_IA32_SPEC_CTRL, 0);
 
 	/* Eliminate branch target predictions from guest mode */
 	vmexit_fill_RSB();


