Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755905AbeDXERh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 00:17:37 -0400
Received: from ozlabs.org ([203.11.71.1]:39643 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751432AbeDXEQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 00:16:09 -0400
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com, msuchanek@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] powerpc/64s: Patch barrier_nospec in modules
Date: Tue, 24 Apr 2018 14:15:56 +1000
Message-Id: <20180424041559.32410-3-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180424041559.32410-1-mpe@ellerman.id.au>
References: <20180424041559.32410-1-mpe@ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Suchanek <msuchanek@suse.de>

Note that unlike RFI which is patched only in kernel the nospec state
reflects settings at the time the module was loaded.

Iterating all modules and re-patching every time the settings change
is not implemented.

Based on lwsync patching.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/setup.h  |  6 ++++++
 arch/powerpc/kernel/module.c      |  6 ++++++
 arch/powerpc/lib/feature-fixups.c | 16 +++++++++++++---
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index afc7280cce3b..4335cddc1cf2 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -54,6 +54,12 @@ void setup_rfi_flush(enum l1d_flush_type, bool enable);
 void do_rfi_flush_fixups(enum l1d_flush_type types);
 void do_barrier_nospec_fixups(bool enable);
 
+#ifdef CONFIG_PPC_BOOK3S_64
+void do_barrier_nospec_fixups_range(bool enable, void *start, void *end);
+#else
+static inline void do_barrier_nospec_fixups_range(bool enable, void *start, void *end) { };
+#endif
+
 #endif /* !__ASSEMBLY__ */
 
 #endif	/* _ASM_POWERPC_SETUP_H */
diff --git a/arch/powerpc/kernel/module.c b/arch/powerpc/kernel/module.c
index 3f7ba0f5bf29..a72698cd3dd0 100644
--- a/arch/powerpc/kernel/module.c
+++ b/arch/powerpc/kernel/module.c
@@ -72,6 +72,12 @@ int module_finalize(const Elf_Ehdr *hdr,
 		do_feature_fixups(powerpc_firmware_features,
 				  (void *)sect->sh_addr,
 				  (void *)sect->sh_addr + sect->sh_size);
+
+	sect = find_section(hdr, sechdrs, "__spec_barrier_fixup");
+	if (sect != NULL)
+		do_barrier_nospec_fixups_range(true,
+				  (void *)sect->sh_addr,
+				  (void *)sect->sh_addr + sect->sh_size);
 #endif
 
 	sect = find_section(hdr, sechdrs, "__lwsync_fixup");
diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index 093c1d2ea5fd..3b37529f82f8 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -163,14 +163,14 @@ void do_rfi_flush_fixups(enum l1d_flush_type types)
 						: "unknown");
 }
 
-void do_barrier_nospec_fixups(bool enable)
+void do_barrier_nospec_fixups_range(bool enable, void *fixup_start, void *fixup_end)
 {
 	unsigned int instr, *dest;
 	long *start, *end;
 	int i;
 
-	start = PTRRELOC(&__start___barrier_nospec_fixup),
-	end = PTRRELOC(&__stop___barrier_nospec_fixup);
+	start = fixup_start;
+	end = fixup_end;
 
 	instr = 0x60000000; /* nop */
 
@@ -189,6 +189,16 @@ void do_barrier_nospec_fixups(bool enable)
 	printk(KERN_DEBUG "barrier-nospec: patched %d locations\n", i);
 }
 
+void do_barrier_nospec_fixups(bool enable)
+{
+	void *start, *end;
+
+	start = PTRRELOC(&__start___barrier_nospec_fixup),
+	end = PTRRELOC(&__stop___barrier_nospec_fixup);
+
+	do_barrier_nospec_fixups_range(enable, start, end);
+}
+
 #endif /* CONFIG_PPC_BOOK3S_64 */
 
 void do_lwsync_fixups(unsigned long value, void *fixup_start, void *fixup_end)
-- 
2.14.1
