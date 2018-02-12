Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932753AbeBLWeN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:34:13 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36563 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932628AbeBLWeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:34:11 -0500
X-Google-Smtp-Source: AH8x225QrJSrpaK9x+2G6BDqCZTFj/neYdCmV7/CMJWbzXTIK3DLhjrepLicr9RMWAhK//NvivyleQ==
From: Guenter Roeck <linux@roeck-us.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 1/2] powerpc/kdump: Add missing optional dummy functions
Date: Mon, 12 Feb 2018 14:34:07 -0800
Message-Id: <1518474848-3158-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If KEXEC_CORE is not enabled, PowerNV builds fail as follows.

arch/powerpc/platforms/powernv/smp.c: In function 'pnv_smp_cpu_kill_self':
arch/powerpc/platforms/powernv/smp.c:236:4: error:
	implicit declaration of function 'crash_ipi_callback'

Add dummy function calls, similar to kdump_in_progress(), to solve the
problem.

Fixes: 4145f358644b ("powernv/kdump: Fix cases where the kdump kernel ...")
Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/powerpc/include/asm/kexec.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index 9dcbfa6bbb91..d8b1e8e7e035 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -140,6 +140,12 @@ static inline bool kdump_in_progress(void)
 	return false;
 }
 
+static inline void crash_ipi_callback(struct pt_regs *regs) { }
+
+static inline void crash_send_ipi(void (*crash_ipi_callback)(struct pt_regs *))
+{
+}
+
 #endif /* CONFIG_KEXEC_CORE */
 #endif /* ! __ASSEMBLY__ */
 #endif /* __KERNEL__ */
-- 
2.7.4
