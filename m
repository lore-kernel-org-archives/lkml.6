Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F40C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4462220880
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4462220880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbeI3ESk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:18:40 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52173 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728951AbeI3ESj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:39 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N6E-0000Gw-Nm; Sat, 29 Sep 2018 22:48:30 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5w-0006sn-Qy; Sat, 29 Sep 2018 22:48:12 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Joerg Roedel" <joro@8bytes.org>,
        "Borislav Petkov" <bp@suse.de>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        "Mikhail Gavrilov" <mikhail.v.gavrilov@gmail.com>,
        kvm@vger.kernel.org, "Paolo Bonzini" <pbonzini@redhat.com>,
        "Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>,
        x86@kernel.org, "Matthew Wilcox" <willy@infradead.org>,
        "Thomas Gleixner" <tglx@xxxxxxxxxxxxx>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.173395561@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 049/131] KVM: x86: SVM: Call x86_spec_ctrl_set_guest/host()
 with interrupts disabled
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.59-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@xxxxxxxxxxxxx>

commit 024d83cadc6b2af027e473720f3c3da97496c318 upstream.

Mikhail reported the following lockdep splat:

WARNING: possible irq lock inversion dependency detected
CPU 0/KVM/10284 just changed the state of lock:
  000000000d538a88 (&st->lock){+...}, at:
  speculative_store_bypass_update+0x10b/0x170

but this lock was taken by another, HARDIRQ-safe lock
in the past:

(&(&sighand->siglock)->rlock){-.-.}

   and interrupts could create inverse lock ordering between them.

Possible interrupt unsafe locking scenario:

    CPU0                    CPU1
    ----                    ----
   lock(&st->lock);
                           local_irq_disable();
                           lock(&(&sighand->siglock)->rlock);
                           lock(&st->lock);
    <Interrupt>
     lock(&(&sighand->siglock)->rlock);
     *** DEADLOCK ***

The code path which connects those locks is:

   speculative_store_bypass_update()
   ssb_prctl_set()
   do_seccomp()
   do_syscall_64()

In svm_vcpu_run() speculative_store_bypass_update() is called with
interupts enabled via x86_virt_spec_ctrl_set_guest/host().

This is actually a false positive, because GIF=0 so interrupts are
disabled even if IF=1; however, we can easily move the invocations of
x86_virt_spec_ctrl_set_guest/host() into the interrupt disabled region to
cure it, and it's a good idea to keep the GIF=0/IF=1 area as small
and self-contained as possible.

Fixes: 1f50ddb4f418 ("x86/speculation: Handle HT correctly on AMD")
Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: kvm@vger.kernel.org
Cc: x86@kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kvm/svm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -3983,8 +3983,6 @@ static void svm_vcpu_run(struct kvm_vcpu
 
 	clgi();
 
-	local_irq_enable();
-
 	/*
 	 * If this vCPU has touched SPEC_CTRL, restore the guest's value if
 	 * it's non-zero. Since vmentry is serialising on affected CPUs, there
@@ -3993,6 +3991,8 @@ static void svm_vcpu_run(struct kvm_vcpu
 	 */
 	x86_spec_ctrl_set_guest(svm->spec_ctrl, svm->virt_spec_ctrl);
 
+	local_irq_enable();
+
 	asm volatile (
 		"push %%" _ASM_BP "; \n\t"
 		"mov %c[rbx](%[svm]), %%" _ASM_BX " \n\t"
@@ -4115,12 +4115,12 @@ static void svm_vcpu_run(struct kvm_vcpu
 	if (unlikely(!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL)))
 		svm->spec_ctrl = native_read_msr(MSR_IA32_SPEC_CTRL);
 
-	x86_spec_ctrl_restore_host(svm->spec_ctrl, svm->virt_spec_ctrl);
-
 	reload_tss(vcpu);
 
 	local_irq_disable();
 
+	x86_spec_ctrl_restore_host(svm->spec_ctrl, svm->virt_spec_ctrl);
+
 	vcpu->arch.cr2 = svm->vmcb->save.cr2;
 	vcpu->arch.regs[VCPU_REGS_RAX] = svm->vmcb->save.rax;
 	vcpu->arch.regs[VCPU_REGS_RSP] = svm->vmcb->save.rsp;

