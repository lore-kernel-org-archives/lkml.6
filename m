Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934D6ECDE48
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 20:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 450C9205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 20:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KlApc4hN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 450C9205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbeJYFK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 01:10:28 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38743 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbeJYFK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 01:10:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id f8-v6so2883058pgq.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 13:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:in-reply-to:references:cc:from:to;
        bh=haJQGN66g9cqBvgn1IgWSupU39+1LrZjNGcE4HlkRC4=;
        b=KlApc4hNRgCFad3JuNRcITA4keljxUC+I1dkX2zclz7ddrvw1eo7lRYk25wmQvVpFt
         XN6Q2Dt30vdUoCG2SIBX2Wlf+y2EdLcTUVf2jVZaWbP/UIas/CJY8/Rz9ycANwB5y5ug
         1VzgP+9UWBD2EPIIKZcCJhfqaTKm+43qGpwRXO8RHdyoRRanfQb7QpsZA6km8cNGDjNt
         4o36EDa/zXD0XXKdq9hBEy1uPj5+y7QunpLI4fJGnHxlMOEWRL35j0cHmAmkpu9nXMzs
         X/VxuNcFVy1nFhb3HSDn6HLTmg7D1BPQjoWUPshbf4OSdBqg4yc3U1WnWLsfFiLuoT+g
         pBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :cc:from:to;
        bh=haJQGN66g9cqBvgn1IgWSupU39+1LrZjNGcE4HlkRC4=;
        b=K80N5FwGT6hlCYSrWNECavkkIfG41EFoDCHXlYbhAPXd8wqwo6SucVE8N6w8qViG+8
         MzkJFmVtR3d+FM/Cajx2QPFFuYHIhymfQXkFUiYFcqu0cRN57K/xQFjJ5DLtyG80dA12
         twoKVpiPluMrbLg1KeaPRFGYX+kLYpuujs9IVIzlezl/5P8Hqr87rhk1BSDVUYjD2iy/
         qs99JC4FJElbBJOLjzRMY2V7YUH1VAfjAOaNCGctSsBWCTmL9pC0BHRAI4bff8uOwcSz
         NgV1frgNPyvz2o29OVJOQFylDDNS0ggiAyLWHgERBDHPDXuIZZzwWPhgS7VRHtLFCLcU
         9RQQ==
X-Gm-Message-State: AGRZ1gKgDIKgeHY4j9Y6ruv2zhVEdSmn9Y1FX7JsTI0U2pFhYOK26LD1
        Q/MzVpVES6r6kB1CXAtQP0P7XQ==
X-Google-Smtp-Source: AJdET5dUvpN4PWgG/uZ3iVBHn7yFFk9bzgmhhoTVoUh+qxGBybOtxPE62VdC6X+6QIFa8y6nmrfgJQ==
X-Received: by 2002:a63:82c6:: with SMTP id w189mr3955772pgd.344.1540413653552;
        Wed, 24 Oct 2018 13:40:53 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id h5-v6sm6922729pgh.42.2018.10.24.13.40.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 13:40:52 -0700 (PDT)
Subject: [PATCH 2/2] RISC-V: Add support for SECCOMP
Date:   Wed, 24 Oct 2018 13:40:36 -0700
Message-Id: <20181024204036.8799-3-palmer@sifive.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181024204036.8799-1-palmer@sifive.com>
References: <CAEn-LTqbEmWovu4t7Rs4C211+GRRU4V3B=+WmW0SOhX_b8db5Q@mail.gmail.com>
 <20181024204036.8799-1-palmer@sifive.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        paul@paul-moore.com, eparis@redhat.com, keescook@chromium.org,
        luto@amacapital.net, wad@chromium.org,
        Wesley Terpstra <wesley@sifive.com>, dhowells@redhat.com,
        tglx@linutronix.de, pombredanne@nexb.com,
        Greg KH <gregkh@linuxfoundation.org>,
        kstewart@linuxfoundation.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        david.abdurachmanov@gmail.com, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:      linux-riscv@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Wesley W. Terpstra" <wesley@sifive.com>

This is a fairly straight-forward implementation of seccomp for RISC-V
systems.

Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 arch/riscv/Kconfig                   | 18 ++++++++++++++++++
 arch/riscv/include/asm/seccomp.h     | 10 ++++++++++
 arch/riscv/include/asm/syscall.h     |  6 ++++++
 arch/riscv/include/asm/thread_info.h |  1 +
 include/uapi/linux/audit.h           |  1 +
 5 files changed, 36 insertions(+)
 create mode 100644 arch/riscv/include/asm/seccomp.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a344980287a5..28abe47602a1 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -28,6 +28,7 @@ config RISCV
 	select GENERIC_STRNLEN_USER
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_ATOMIC64 if !64BIT || !RISCV_ISA_A
+	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_MEMBLOCK
 	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_DMA_CONTIGUOUS
@@ -214,6 +215,22 @@ menu "Kernel type"
 
 source "kernel/Kconfig.hz"
 
+config SECCOMP
+	bool "Enable seccomp to safely compute untrusted bytecode"
+
+	help
+	  This kernel feature is useful for number crunching applications
+	  that may need to compute untrusted bytecode during their
+	  execution. By using pipes or other transports made available to
+	  the process as file descriptors supporting the read/write
+	  syscalls, it's possible to isolate those applications in
+	  their own address space using seccomp. Once seccomp is
+	  enabled via prctl(PR_SET_SECCOMP), it cannot be disabled
+	  and the task is only allowed to execute a few safe syscalls
+	  defined by each seccomp mode.
+
+	  If unsure, say Y. Only embedded should say N here.
+
 endmenu
 
 menu "Bus support"
@@ -243,3 +260,4 @@ menu "Power management options"
 source kernel/power/Kconfig
 
 endmenu
+
diff --git a/arch/riscv/include/asm/seccomp.h b/arch/riscv/include/asm/seccomp.h
new file mode 100644
index 000000000000..c1b4407f1038
--- /dev/null
+++ b/arch/riscv/include/asm/seccomp.h
@@ -0,0 +1,10 @@
+/* Copyright 2018 SiFive, Inc. */
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RISCV_SECCOMP_H
+#define _ASM_RISCV_SECCOMP_H
+
+#include <asm/unistd.h>
+
+#include <asm-generic/seccomp.h>
+
+#endif /* _ASM_RISCV_SECCOMP_H */
diff --git a/arch/riscv/include/asm/syscall.h b/arch/riscv/include/asm/syscall.h
index 8d25f8904c00..d24f774f39df 100644
--- a/arch/riscv/include/asm/syscall.h
+++ b/arch/riscv/include/asm/syscall.h
@@ -19,6 +19,7 @@
 #define _ASM_RISCV_SYSCALL_H
 
 #include <linux/sched.h>
+#include <uapi/linux/audit.h>
 #include <linux/err.h>
 
 /* The array of function pointers for syscalls. */
@@ -99,4 +100,9 @@ static inline void syscall_set_arguments(struct task_struct *task,
 	memcpy(&regs->a1 + i * sizeof(regs->a1), args, n * sizeof(regs->a0));
 }
 
+static inline int syscall_get_arch(void)
+{
+	return AUDIT_ARCH_RISCV;
+}
+
 #endif	/* _ASM_RISCV_SYSCALL_H */
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index f8fa1cd2dad9..374973dc05c6 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -80,6 +80,7 @@ struct thread_info {
 #define TIF_RESTORE_SIGMASK	4	/* restore signal mask in do_signal() */
 #define TIF_MEMDIE		5	/* is terminating due to OOM killer */
 #define TIF_SYSCALL_TRACEPOINT  6       /* syscall tracepoint instrumentation */
+#define TIF_SECCOMP		7	/* seccomp syscall filtering active */
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 818ae690ab79..c16fa1a76659 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -399,6 +399,7 @@ enum {
 /* do not define AUDIT_ARCH_PPCLE since it is not supported by audit */
 #define AUDIT_ARCH_PPC64	(EM_PPC64|__AUDIT_ARCH_64BIT)
 #define AUDIT_ARCH_PPC64LE	(EM_PPC64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
+#define AUDIT_ARCH_RISCV	(EM_RISCV)
 #define AUDIT_ARCH_S390		(EM_S390)
 #define AUDIT_ARCH_S390X	(EM_S390|__AUDIT_ARCH_64BIT)
 #define AUDIT_ARCH_SH		(EM_SH)
-- 
2.18.1

