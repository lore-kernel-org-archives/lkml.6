Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE5EC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C351520874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tj1Kn5X7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C351520874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388564AbeGXIDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 04:03:55 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34050 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388264AbeGXIDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 04:03:55 -0400
Received: by mail-pg1-f196.google.com with SMTP id y5-v6so2199006pgv.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 23:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LYcgh+nDPKM588JQ9ma6JrqSapqsGrXqoeVmNFniv60=;
        b=Tj1Kn5X7glWk0eA5Au7pf8DoGG35+0gnsScbyK63dcH0svlRAOtYPEmMQuiuHFyfvn
         qfhUyZPYaVraqD4EiL/GszUO461fcspkMlOuT125/tkekt551LIlH3/DhV9mJlo+nWtf
         IkBO56LtgEpsDzquzEqZqia1bu3RYc9Ef7Jl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LYcgh+nDPKM588JQ9ma6JrqSapqsGrXqoeVmNFniv60=;
        b=lXe+O0NVaf8G8F0ccxnhI5s/3CVHCM97cE9SjyEUXeYTPQCE7Ys830sPvE2bLlG1Uh
         5UoVSD//ZfqOqre93Bm0b90iLHGG6gMIc5eX9FD/ZSkH5GaQ5XLoBRsq/4h1cAa7KoKV
         lTqB04WXbgKxdn1D+nGQAw6WvASHDhjZkGGpxLdt+ROC4goBdSb3Emh0R79yi3sNP6Nd
         j2841ODMq/0eV+ChrOq9wrGxvkcSrtTHgtDo2AumwLuxadaN8HtzMN0cuXD9iY8u2Ng+
         bw+YYEaim77WLsSOygnALwrXC+4XRaSWIAs2oOH3wWTk4TX7dHbTeZScOI7CSSeb4CoI
         r98A==
X-Gm-Message-State: AOUpUlHIIQ7tSuzCDApht3zfZTmvXB06wOyjNCIIvbcNPLnNuTWJWD0w
        TTgyREUMFXJPw852Y+4rhqO6rA==
X-Google-Smtp-Source: AAOMgpeL+YL92DjiK/BLD5vIT6GASjU4kc2OQmjU+/U49ayZjvZCokZNxmDfJzYiI2pyAcaAWfaJ8Q==
X-Received: by 2002:a65:6143:: with SMTP id o3-v6mr15494531pgv.52.1532415536850;
        Mon, 23 Jul 2018 23:58:56 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id x22-v6sm503821pfh.67.2018.07.23.23.58.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 23:58:56 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc:     ard.biesheuvel@linaro.org, james.morse@arm.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v12 13/16] arm64: kexec_file: invoke the kernel without purgatory
Date:   Tue, 24 Jul 2018 15:57:56 +0900
Message-Id: <20180724065759.19186-14-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724065759.19186-1-takahiro.akashi@linaro.org>
References: <20180724065759.19186-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On arm64, purgatory would do almost nothing. So just invoke secondary
kernel directly by jumping into its entry code.

While, in this case, cpu_soft_restart() must be called with dtb address
in the fifth argument, the behavior still stays compatible with kexec_load
case as long as the argument is null.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Reviewed-by: James Morse <james.morse@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/cpu-reset.S       |  8 ++++----
 arch/arm64/kernel/machine_kexec.c   | 12 ++++++++++--
 arch/arm64/kernel/relocate_kernel.S |  3 ++-
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/cpu-reset.S b/arch/arm64/kernel/cpu-reset.S
index 8021b46c9743..a2be30275a73 100644
--- a/arch/arm64/kernel/cpu-reset.S
+++ b/arch/arm64/kernel/cpu-reset.S
@@ -22,11 +22,11 @@
  * __cpu_soft_restart(el2_switch, entry, arg0, arg1, arg2) - Helper for
  * cpu_soft_restart.
  *
- * @el2_switch: Flag to indicate a swich to EL2 is needed.
+ * @el2_switch: Flag to indicate a switch to EL2 is needed.
  * @entry: Location to jump to for soft reset.
- * arg0: First argument passed to @entry.
- * arg1: Second argument passed to @entry.
- * arg2: Third argument passed to @entry.
+ * arg0: First argument passed to @entry. (relocation list)
+ * arg1: Second argument passed to @entry.(physical kernel entry)
+ * arg2: Third argument passed to @entry. (physical dtb address)
  *
  * Put the CPU into the same state as it would be if it had been reset, and
  * branch to what would be the reset vector. It must be executed with the
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index f76ea92dff91..830a5063e09d 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -205,10 +205,18 @@ void machine_kexec(struct kimage *kimage)
 	 * uses physical addressing to relocate the new image to its final
 	 * position and transfers control to the image entry point when the
 	 * relocation is complete.
+	 * In kexec case, kimage->start points to purgatory assuming that
+	 * kernel entry and dtb address are embedded in purgatory by
+	 * userspace (kexec-tools).
+	 * In kexec_file case, the kernel starts directly without purgatory.
 	 */
-
 	cpu_soft_restart(kimage != kexec_crash_image,
-		reboot_code_buffer_phys, kimage->head, kimage->start, 0);
+		reboot_code_buffer_phys, kimage->head, kimage->start,
+#ifdef CONFIG_KEXEC_FILE
+						kimage->arch.dtb_mem);
+#else
+						0);
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
2.18.0

