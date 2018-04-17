Return-Path: <kernel-hardening-return-13018-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/KUmRLVXTWahryV/ATKzTAr8MJUIZ3fiFide6OExOXCWDx8z/VxogpBnODx7m869H4j+mi
ARC-Seal: i=1; a=rsa-sha256; t=1523990325; cv=none;
        d=google.com; s=arc-20160816;
        b=nLrbrDGHj3K/raAvnkPJ1fIhu/GEXj7XK6s+iKBQaMwR9nZyvUk2HDVcQ6bZs4icG4
         qs8dQvuqA01c34+OKfFOBAqtddVMEBaNFkVh/em0sr9w4X7F7Y9JjyVwn7SGnxvOFgtR
         fFYrm97+Kg99iGdvIDvWfqq5B+G9+t4zAHpbisjPvKPb53L/e4PQIHBbFbVxVr8aZrIH
         iRafszYTvjdD+ByTiwbShgNDNWtnB8yn1xx/94n4+WcZLjq7AR2S96dNuZbxWhQjGtim
         3auMSUYzVyu5dBLG8DDnZ8g9wke1lkR0mL5v64TN5YH/5bpsDy80h9yjJtXxyI/KqumP
         TjoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=LMD5f0EwKBjsG6J9F8f4uIaYPevd2L8RCUaeSal7aGQ=;
        b=JFg3F0hoHJVqVJcS5xN3Kicvb5DH0EnEPFi5BS45iOhMwRvB3vwfqsJ8jYn/yXY1VI
         FMGPmLhDahYp8vNp5A5xV8MbybmfhFYJ0DC1CiIFwkKnPr9eWN2nNRl3FXdmUL3B2ozT
         stEOsfeUX178uNEnYwVjuPm7fNEydaPnAoP3fnaNZLQIvXiei1H5mYcOmJyjk7k+uCUv
         hloamMn9wC8NrW3DHeHPdgms43v3+fQriGp7VG2UEFq5aghqtl1dVaFS6A60DWGq2HF0
         I5sEw9pixd1XwhrRHFV8N9Qd8DI96ePhC2C6c/GdaXs4xKo/SmfH1ZJScbH7N3I3Qhpa
         +uAw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13018-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13018-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13018-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13018-gregkh=linuxfoundation.org@lists.openwall.com
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
Subject: [PATCHv3 01/11] arm64: add pointer authentication register bits
Date: Tue, 17 Apr 2018 19:37:25 +0100
Message-Id: <20180417183735.56985-2-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180417183735.56985-1-mark.rutland@arm.com>
References: <20180417183735.56985-1-mark.rutland@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598019679846665173?=
X-GMAIL-MSGID: =?utf-8?q?1598019679846665173?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The ARMv8.3 pointer authentication extension adds:

* New fields in ID_AA64ISAR1 to report the presence of pointer
  authentication functionality.

* New control bits in SCTLR_ELx to enable this functionality.

* New system registers to hold the keys necessary for this
  functionality.

* A new ESR_ELx.EC code used when the new instructions are affected by
  configurable traps

This patch adds the relevant definitions to <asm/sysreg.h> and
<asm/esr.h> for these, to be used by subsequent patches.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/esr.h    |  3 ++-
 arch/arm64/include/asm/sysreg.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index ce70c3ffb993..022785162281 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -30,7 +30,8 @@
 #define ESR_ELx_EC_CP14_LS	(0x06)
 #define ESR_ELx_EC_FP_ASIMD	(0x07)
 #define ESR_ELx_EC_CP10_ID	(0x08)
-/* Unallocated EC: 0x09 - 0x0B */
+#define ESR_ELx_EC_PAC		(0x09)
+/* Unallocated EC: 0x0A - 0x0B */
 #define ESR_ELx_EC_CP14_64	(0x0C)
 /* Unallocated EC: 0x0d */
 #define ESR_ELx_EC_ILL		(0x0E)
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 6171178075dc..426f0eb90101 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -171,6 +171,19 @@
 #define SYS_TTBR1_EL1			sys_reg(3, 0, 2, 0, 1)
 #define SYS_TCR_EL1			sys_reg(3, 0, 2, 0, 2)
 
+#define SYS_APIAKEYLO_EL1		sys_reg(3, 0, 2, 1, 0)
+#define SYS_APIAKEYHI_EL1		sys_reg(3, 0, 2, 1, 1)
+#define SYS_APIBKEYLO_EL1		sys_reg(3, 0, 2, 1, 2)
+#define SYS_APIBKEYHI_EL1		sys_reg(3, 0, 2, 1, 3)
+
+#define SYS_APDAKEYLO_EL1		sys_reg(3, 0, 2, 2, 0)
+#define SYS_APDAKEYHI_EL1		sys_reg(3, 0, 2, 2, 1)
+#define SYS_APDBKEYLO_EL1		sys_reg(3, 0, 2, 2, 2)
+#define SYS_APDBKEYHI_EL1		sys_reg(3, 0, 2, 2, 3)
+
+#define SYS_APGAKEYLO_EL1		sys_reg(3, 0, 2, 3, 0)
+#define SYS_APGAKEYHI_EL1		sys_reg(3, 0, 2, 3, 1)
+
 #define SYS_ICC_PMR_EL1			sys_reg(3, 0, 4, 6, 0)
 
 #define SYS_AFSR0_EL1			sys_reg(3, 0, 5, 1, 0)
@@ -417,9 +430,13 @@
 #define SYS_ICH_LR15_EL2		__SYS__LR8_EL2(7)
 
 /* Common SCTLR_ELx flags. */
+#define SCTLR_ELx_ENIA	(1 << 31)
+#define SCTLR_ELx_ENIB	(1 << 30)
+#define SCTLR_ELx_ENDA	(1 << 27)
 #define SCTLR_ELx_EE    (1 << 25)
 #define SCTLR_ELx_IESB	(1 << 21)
 #define SCTLR_ELx_WXN	(1 << 19)
+#define SCTLR_ELx_ENDB	(1 << 13)
 #define SCTLR_ELx_I	(1 << 12)
 #define SCTLR_ELx_SA	(1 << 3)
 #define SCTLR_ELx_C	(1 << 2)
@@ -510,11 +527,24 @@
 #define ID_AA64ISAR0_AES_SHIFT		4
 
 /* id_aa64isar1 */
+#define ID_AA64ISAR1_GPI_SHIFT		28
+#define ID_AA64ISAR1_GPA_SHIFT		24
 #define ID_AA64ISAR1_LRCPC_SHIFT	20
 #define ID_AA64ISAR1_FCMA_SHIFT		16
 #define ID_AA64ISAR1_JSCVT_SHIFT	12
+#define ID_AA64ISAR1_API_SHIFT		8
+#define ID_AA64ISAR1_APA_SHIFT		4
 #define ID_AA64ISAR1_DPB_SHIFT		0
 
+#define ID_AA64ISAR1_APA_NI		0x0
+#define ID_AA64ISAR1_APA_ARCHITECTED	0x1
+#define ID_AA64ISAR1_API_NI		0x0
+#define ID_AA64ISAR1_API_IMP_DEF	0x1
+#define ID_AA64ISAR1_GPA_NI		0x0
+#define ID_AA64ISAR1_GPA_ARCHITECTED	0x1
+#define ID_AA64ISAR1_GPI_NI		0x0
+#define ID_AA64ISAR1_GPI_IMP_DEF	0x1
+
 /* id_aa64pfr0 */
 #define ID_AA64PFR0_CSV3_SHIFT		60
 #define ID_AA64PFR0_CSV2_SHIFT		56
-- 
2.11.0
