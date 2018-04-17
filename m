Return-Path: <kernel-hardening-return-13025-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx49yIoE4nbofoGi/N6fjLIx6b049Is1x7EmfpRqPhW0hrY/ALm6HJCQ0Zo63WUh3fZajKoG+
ARC-Seal: i=1; a=rsa-sha256; t=1523990390; cv=none;
        d=google.com; s=arc-20160816;
        b=By9qg2hL1cvI6Xk8fkxI0JwzaYnFpkBdLDgyEeyaUddrYxrcOCcUBM4/fC6GluQxYT
         m/XWHSp2a4K6XVTUPd8OZ06pWfjMkT5bnb661kupBaT7l41dFea7caH2LbE+szgHzoBz
         tNX5gLa9TT+D+i5RnohObw4sCS7R3ji8zBkUTMJDtTKsYF8x2R37ZmlYPL5Zjh+6E5eL
         pz1VVfLsp6Y3Z0ljlI7frxpPAU/HUHEM1rncJZlMYfp2Eswq5Auukm4NjFEmywMBkkB4
         fAqShywLa9cQtxLElgBJBBXDYvsUIsA9UL1WH9FSjvqQaIe2ibNf1mV2mluOGPUNgTLF
         4Dfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=5NyX8p96FaCEcF45M2ds34bhzDARufpfc/JRPjLZ5mU=;
        b=fk+uyhoF5zeWtTfaS/ED4Py+20pffgt+hgm3SxVyr20/IDu7/tmmeA+A2gXuycUw5D
         wwvOeCnvgQVl8nz1THVfnJOwaOqg1+neU5cBIShNHbwXmH6Ad8m06A33VP+n2ma9Cfl9
         55gpzNU3rpr+K7kF8X0mV5TAXF7NEgqzbs223ChcMi6dcwJTQErduv0/Ni4+eYdeWeM9
         LNmaM1CjcGCAA3yQuE56BqwUC5FIZ3EV2u5RYkbUOeFcCT1QytyCScyFyaa18GDOYVWc
         Fl1clFkcPZkIoDxCWoA5DmnGdZImgFNqHqqcqD6IevYF2dRZg44odnVjdoRSIthRd/yi
         0dvw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13025-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13025-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13025-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13025-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: arnd@arndb.de,
	catalin.marinas@arm.com,
	cdall@kernel.org,
	drjones@redhat.com,
	kvmarm@lists.cs.columbia.edu,
	linux-arch@vger.kernel.org,
	marc.zyngier@arm.com,
	mark.rutland@arm.com,
	ramana.radhakrishnan@arm.com,
	suzuki.poulose@arm.com,
	will.deacon@arm.com,
	linux-kernel@vger.kernel.org,
	awallis@codeaurora.org,
	kernel-hardening@lists.openwall.com
Subject: [PATCHv3 06/11] asm-generic: mm_hooks: allow hooks to be overridden individually
Date: Tue, 17 Apr 2018 19:37:30 +0100
Message-Id: <20180417183735.56985-7-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180417183735.56985-1-mark.rutland@arm.com>
References: <20180417183735.56985-1-mark.rutland@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598019747500119044?=
X-GMAIL-MSGID: =?utf-8?q?1598019747500119044?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently, an architecture must either implement all of the mm hooks
itself, or use all of those provided by the asm-generic implementation.
When an architecture only needs to override a single hook, it must copy
the stub implementations from the asm-generic version.

To avoid this repetition, allow each hook to be overridden indiviually,
by placing each under an #ifndef block. As architectures providing their
own hooks can't include this file today, this shouldn't adversely affect
any existing hooks.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
---
 include/asm-generic/mm_hooks.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/asm-generic/mm_hooks.h b/include/asm-generic/mm_hooks.h
index 8ac4e68a12f0..2b3ee15d3702 100644
--- a/include/asm-generic/mm_hooks.h
+++ b/include/asm-generic/mm_hooks.h
@@ -7,31 +7,42 @@
 #ifndef _ASM_GENERIC_MM_HOOKS_H
 #define _ASM_GENERIC_MM_HOOKS_H
 
+#ifndef arch_dup_mmap
 static inline int arch_dup_mmap(struct mm_struct *oldmm,
 				struct mm_struct *mm)
 {
 	return 0;
 }
+#endif
 
+#ifndef arch_exit_mmap
 static inline void arch_exit_mmap(struct mm_struct *mm)
 {
 }
+#endif
 
+#ifndef arch_unmap
 static inline void arch_unmap(struct mm_struct *mm,
 			struct vm_area_struct *vma,
 			unsigned long start, unsigned long end)
 {
 }
+#endif
 
+#ifndef arch_bprm_mm_init
 static inline void arch_bprm_mm_init(struct mm_struct *mm,
 				     struct vm_area_struct *vma)
 {
 }
+#endif
 
+#ifndef arch_vma_access_permitted
 static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
 		bool write, bool execute, bool foreign)
 {
 	/* by default, allow everything */
 	return true;
 }
+#endif
+
 #endif	/* _ASM_GENERIC_MM_HOOKS_H */
-- 
2.11.0
