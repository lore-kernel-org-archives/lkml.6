Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C3FC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70C821746
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Akut7E51"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A70C821746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbeI1NLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:11:38 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34998 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeI1NLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:11:37 -0400
Received: by mail-pf1-f194.google.com with SMTP id p12-v6so3647632pfh.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 23:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZdHE4nfr8T5Hxvr10M0CzI0OedYEfMU03IOSvEtlq5c=;
        b=Akut7E51HyMcmoDJ8yq2dxz/1WR22lD8Tli0lJqraJGLfSUeCA7RHO949kC/rxf83y
         z5MqpcFwckf7HsZYfQldR7Dv1ZCJD6N3/miuWvGM3bGuOiGBs6//wrEYJ4V0HeODh+qP
         0F93GU41LJIxZ3fOmJqvU3fiHH1f4dfNr7dkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZdHE4nfr8T5Hxvr10M0CzI0OedYEfMU03IOSvEtlq5c=;
        b=s03PgL0jBCBAywYMMiMfigkCohzqP5nvwNOYYM4dVXw/EURZMZNQoMrvB7JA4ymtif
         k/lWioULCamDRh7ZrsmAyXvGxQ0NoUOmuk410tF6+OnpJ9ObNcKWrpU+jfhCAhIdjSN2
         p1LokM+Wq3u6FWJmqgNzAySwGHwwjYpxO1fk+oGo/2Gj0WQgME41f5iioPG9zy4dSi9t
         OJQf+KZFeARbP7d3RWp4KNkzbbDv5wuT7kihaes8v8WhUN/sfNXFP5OrergrukFeTSKa
         s4jt/bpWGFcLo+qfFsZPzO+5A/DpbNqVW6Cv8p3VjBEqxWDffyY/ohBNlT2fzL6XMdEy
         xpBw==
X-Gm-Message-State: ABuFfoiHFXJHYgZfb6Tv/EBtEOuj81ElcnTydQiii/I+XNT5ES4140B/
        kONCTZ8QWCMgNHD4lvjtyA2Dxw==
X-Google-Smtp-Source: ACcGV61Cf7qGrnDdyVYFZ3yzbC5W9PbJu++kfm2zHsjntKkWshWhhZWlD/xgUvrGl+JbjEwrYihUaA==
X-Received: by 2002:a17:902:e088:: with SMTP id cb8-v6mr14600861plb.189.1538117362702;
        Thu, 27 Sep 2018 23:49:22 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id m27-v6sm6990442pff.187.2018.09.27.23.49.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 23:49:21 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc:     prudo@linux.ibm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v15 13/16] arm64: kexec_file: invoke the kernel without purgatory
Date:   Fri, 28 Sep 2018 15:48:38 +0900
Message-Id: <20180928064841.14117-14-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180928064841.14117-1-takahiro.akashi@linaro.org>
References: <20180928064841.14117-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 922add8adb74..aa9c94113700 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -212,9 +212,17 @@ void machine_kexec(struct kimage *kimage)
 	 * uses physical addressing to relocate the new image to its final
 	 * position and transfers control to the image entry point when the
 	 * relocation is complete.
+	 * In kexec case, kimage->start points to purgatory assuming that
+	 * kernel entry and dtb address are embedded in purgatory by
+	 * userspace (kexec-tools).
+	 * In kexec_file case, the kernel starts directly without purgatory.
 	 */
-
-	cpu_soft_restart(reboot_code_buffer_phys, kimage->head, kimage->start, 0);
+	cpu_soft_restart(reboot_code_buffer_phys, kimage->head, kimage->start,
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
2.19.0

