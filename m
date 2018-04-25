Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbeDYG1M (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 02:27:12 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42999 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbeDYG1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 02:27:01 -0400
X-Google-Smtp-Source: AIpwx48htSByNefkX1ZBqTeevP7DwlOqLB15GAd0SPqw7ru76VE76QAGbcAMKAkPsNkvcXSOtKR1wQ==
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net,
        dyoung@redhat.com, bhe@redhat.com, arnd@arndb.de
Cc: ard.biesheuvel@linaro.org, james.morse@arm.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v9 03/11] arm64: kexec_file: invoke the kernel without purgatory
Date: Wed, 25 Apr 2018 15:26:21 +0900
Message-Id: <20180425062629.29404-4-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425062629.29404-1-takahiro.akashi@linaro.org>
References: <20180425062629.29404-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On arm64, purugatory would do almosty nothing. So just invoke secondary
kernel directy by jumping into its entry code.

While, in this case, cpu_soft_restart() must be called with dtb address
in the fifth argument, the behavior still stays compatible with kexec_load
case as long as the argument is null.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/cpu-reset.S       |  6 +++---
 arch/arm64/kernel/machine_kexec.c   | 11 +++++++++--
 arch/arm64/kernel/relocate_kernel.S |  3 ++-
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/cpu-reset.S b/arch/arm64/kernel/cpu-reset.S
index 8021b46c9743..391df91328ac 100644
--- a/arch/arm64/kernel/cpu-reset.S
+++ b/arch/arm64/kernel/cpu-reset.S
@@ -24,9 +24,9 @@
  *
  * @el2_switch: Flag to indicate a swich to EL2 is needed.
  * @entry: Location to jump to for soft reset.
- * arg0: First argument passed to @entry.
- * arg1: Second argument passed to @entry.
- * arg2: Third argument passed to @entry.
+ * arg0: First argument passed to @entry. (relocation list)
+ * arg1: Second argument passed to @entry.(physcal kernel entry)
+ * arg2: Third argument passed to @entry. (physical dtb address)
  *
  * Put the CPU into the same state as it would be if it had been reset, and
  * branch to what would be the reset vector. It must be executed with the
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index f76ea92dff91..f7dbba00be10 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -205,10 +205,17 @@ void machine_kexec(struct kimage *kimage)
 	 * uses physical addressing to relocate the new image to its final
 	 * position and transfers control to the image entry point when the
 	 * relocation is complete.
+	 * In case of kexec_file_load syscall, we directly start the kernel,
+	 * skipping purgatory.
 	 */
-
 	cpu_soft_restart(kimage != kexec_crash_image,
-		reboot_code_buffer_phys, kimage->head, kimage->start, 0);
+		reboot_code_buffer_phys, kimage->head, kimage->start,
+#ifdef CONFIG_KEXEC_FILE
+				kimage->purgatory_info.purgatory_buf ?
+						0 : kimage->arch.dtb_mem);
+#else
+				0);
+#endif
 
 	BUG(); /* Should never get here. */
 }
diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index f407e422a720..95fd94209aae 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -32,6 +32,7 @@
 ENTRY(arm64_relocate_new_kernel)
 
 	/* Setup the list loop variables. */
+	mov	x18, x2				/* x18 = dtb address */
 	mov	x17, x1				/* x17 = kimage_start */
 	mov	x16, x0				/* x16 = kimage_head */
 	raw_dcache_line_size x15, x0		/* x15 = dcache line size */
@@ -107,7 +108,7 @@ ENTRY(arm64_relocate_new_kernel)
 	isb
 
 	/* Start new image. */
-	mov	x0, xzr
+	mov	x0, x18
 	mov	x1, xzr
 	mov	x2, xzr
 	mov	x3, xzr
-- 
2.17.0
