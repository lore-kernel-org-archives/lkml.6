Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752039AbeENC6D (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 22:58:03 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:43594 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751953AbeENC6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 22:58:02 -0400
X-Google-Smtp-Source: AB8JxZrpEPAOg8ddLnHVf3IZp06VPal2swQYFpQpzz8+FSIPn5iDwdu9P6BjgfyHqCX5HEAUyMP0Kw==
Date: Sun, 13 May 2018 20:00:07 -0700
From: Eric Biggers <ebiggers3@gmail.com>
To: linux-kvm@vger.kernel.org, dvyukov@google.com, karahmed@amazon.de
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
Subject: CONFIG_KCOV causing crash in svm_vcpu_run()
Message-ID: <20180514030007.GH677@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_KCOV=y and an AMD processor, running the following program crashes
the kernel with no output (I'm testing in a VM, so it's using nested
virtualization):

	#include <fcntl.h>
	#include <linux/kvm.h>
	#include <sys/ioctl.h>

	int main()
	{
		int dev, vm, cpu;
		char page[4096] __attribute__((aligned(4096))) = { 0 };
		struct kvm_userspace_memory_region memreg = {
			.memory_size = 4096,
			.userspace_addr = (unsigned long)page,
		};
		dev = open("/dev/kvm", O_RDONLY);
		vm = ioctl(dev, KVM_CREATE_VM, 0);
		cpu = ioctl(vm, KVM_CREATE_VCPU, 0);
		ioctl(vm, KVM_SET_USER_MEMORY_REGION, &memreg);
		ioctl(cpu, KVM_RUN, 0);
	}

It bisects down to commit b2ac58f90540e39 ("KVM/SVM: Allow direct access to
MSR_IA32_SPEC_CTRL").  The bug is apparently that due to the new code for
managing the SPEC_CTRL MSR, __sanitizer_cov_trace_pc() is being called from
svm_vcpu_run() before the host's MSR_GS_BASE has been restored, which causes a
crash somehow.  The following patch fixes it, though I don't know that it's the
right solution; maybe KCOV should be disabled in the function instead, or maybe
there's a more fundamental problem.  What do people think?

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 1fc05e428aba8..d35ef241e66d8 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -5652,6 +5652,15 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
 #endif
 		);
 
+#ifdef CONFIG_X86_64
+	wrmsrl(MSR_GS_BASE, svm->host.gs_base);
+#else
+	loadsegment(fs, svm->host.fs);
+#ifndef CONFIG_X86_32_LAZY_GS
+	loadsegment(gs, svm->host.gs);
+#endif
+#endif
+
 	/*
 	 * We do not use IBRS in the kernel. If this vCPU has used the
 	 * SPEC_CTRL MSR it may have left it on; save the value and
@@ -5676,15 +5685,6 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
 	/* Eliminate branch target predictions from guest mode */
 	vmexit_fill_RSB();
 
-#ifdef CONFIG_X86_64
-	wrmsrl(MSR_GS_BASE, svm->host.gs_base);
-#else
-	loadsegment(fs, svm->host.fs);
-#ifndef CONFIG_X86_32_LAZY_GS
-	loadsegment(gs, svm->host.gs);
-#endif
-#endif
-
 	reload_tss(vcpu);
 
 	local_irq_disable();
