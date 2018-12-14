Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096B3C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C465B2148E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789920;
	bh=8WAvJQX9jGcjF2U83WaTNd0zgluNShbDeW8S3zBpWXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Cjnnk5qYAVRmlzecR1p4It4fZfXhOAKfUYW0VwVRw+0Zk8FqwX5wfkw/ZioH2T4hZ
	 8H0ltolPvpmYbEfW9KyAzXj+xjZXvC3bfVA5wQ8iyCm0dQvAYRYZLwa0yQSOsXwzgr
	 FFkfIEZ7W2XE7TFiSFiogQXYlzql/t6zxGvQHhOE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C465B2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732767AbeLNMSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:18:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:36494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730605AbeLNMQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:16:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF5272133F;
        Fri, 14 Dec 2018 12:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789778;
        bh=8WAvJQX9jGcjF2U83WaTNd0zgluNShbDeW8S3zBpWXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jlNOcnZLrVJt+iem2sH4xZt7iRZ5ir+s51c5Gl+24/tPVkhnj/73T/XFjHX7DvxuV
         +Yp9F5/h9KJfKpUJdXyHF5F2KYzYgc6xQY9tpRpLq8CaYNM2r42uoa93MhlJqro2fS
         j6pARU7dI+8rSHdCAFC1BFLHUL6IAjl20TR3zfuY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 56/88] x86/bugs, KVM: Support the combination of guest and host IBRS
Date:   Fri, 14 Dec 2018 13:00:30 +0100
Message-Id: <20181214115707.135880362@linuxfoundation.org>
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

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit 5cf687548705412da47c9cec342fd952d71ed3d5 upstream.

A guest may modify the SPEC_CTRL MSR from the value used by the
kernel. Since the kernel doesn't use IBRS, this means a value of zero is
what is needed in the host.

But the 336996-Speculative-Execution-Side-Channel-Mitigations.pdf refers to
the other bits as reserved so the kernel should respect the boot time
SPEC_CTRL value and use that.

This allows to deal with future extensions to the SPEC_CTRL interface if
any at all.

Note: This uses wrmsrl() instead of native_wrmsl(). I does not make any
difference as paravirt will over-write the callq *0xfff.. with the wrmsrl
assembler code.

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
[bwh: Backported to 4.4: This was partly applied before; apply just the
 missing bits]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm.c |    6 ++----
 arch/x86/kvm/vmx.c |    6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -3904,8 +3904,7 @@ static void svm_vcpu_run(struct kvm_vcpu
 	 * is no need to worry about the conditional branch over the wrmsr
 	 * being speculatively taken.
 	 */
-	if (svm->spec_ctrl)
-		native_wrmsrl(MSR_IA32_SPEC_CTRL, svm->spec_ctrl);
+	x86_spec_ctrl_set_guest(svm->spec_ctrl);
 
 	asm volatile (
 		"push %%" _ASM_BP "; \n\t"
@@ -4017,8 +4016,7 @@ static void svm_vcpu_run(struct kvm_vcpu
 	if (!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL))
 		svm->spec_ctrl = native_read_msr(MSR_IA32_SPEC_CTRL);
 
-	if (svm->spec_ctrl)
-		native_wrmsrl(MSR_IA32_SPEC_CTRL, 0);
+	x86_spec_ctrl_restore_host(svm->spec_ctrl);
 
 	/* Eliminate branch target predictions from guest mode */
 	vmexit_fill_RSB();
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -8658,8 +8658,7 @@ static void __noclone vmx_vcpu_run(struc
 	 * is no need to worry about the conditional branch over the wrmsr
 	 * being speculatively taken.
 	 */
-	if (vmx->spec_ctrl)
-		native_wrmsrl(MSR_IA32_SPEC_CTRL, vmx->spec_ctrl);
+	x86_spec_ctrl_set_guest(vmx->spec_ctrl);
 
 	vmx->__launched = vmx->loaded_vmcs->launched;
 	asm(
@@ -8797,8 +8796,7 @@ static void __noclone vmx_vcpu_run(struc
 	if (!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL))
 		vmx->spec_ctrl = native_read_msr(MSR_IA32_SPEC_CTRL);
 
-	if (vmx->spec_ctrl)
-		native_wrmsrl(MSR_IA32_SPEC_CTRL, 0);
+	x86_spec_ctrl_restore_host(vmx->spec_ctrl);
 
 	/* Eliminate branch target predictions from guest mode */
 	vmexit_fill_RSB();


