Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227mkrkQOYFvjsKNYy4eLKTSgwk0tkU+Ef6IoadW+x5hOYDPFceN3N9RdshmX8NehKKo/KkB
ARC-Seal: i=1; a=rsa-sha256; t=1518709230; cv=none;
        d=google.com; s=arc-20160816;
        b=Aa3utHOBqTfYbru9J9rDDqTCyI/pFD88EL3aOY7DjEaosrNFMfaYAWP61UaR5ST+OY
         6TP1fWQss4K+d0n2lzEaIZevJBJiFbjiEsJqAox2l4SGDziqacZlQfUvzze14ylL/lM5
         4tyYt3o0T7s0Ww28xkVNeJeQOtwksSQxDCat4v/9xABy0DvDtA1dIcuX3LAncx+uMRtK
         +WgLxxheIRqbndKTdLzg/w7Io8RCiD3IV9VieMwmDvtJslzQE/IeM+DXct3Kq8dcmFlX
         XK6LByu7lp2Si4XeP1SS3gpnXJDT2WnjaCfWTA2Yze7Ng+nThbC8+VRQ/rlB9Pf/CWQx
         qjNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=aWbzYQ/UV/lP229Fkxaja99rQ9Wec2c4FXfX1xFpaX4=;
        b=XN/KUv6pActO0WiizAAoHYzQrHnvUwdTQj/DZHKFcQQJgXr6Ep2uDlqYdeECM6P+nd
         lDVKTQDys+Hx28WClspWs5TK4F9SPrVA0GZDieQKXsFB/UAgQN6T8YGi4IDRP+M7QgrZ
         +b3ufZH7UyA7Vv1dOZrZRb6Sr3jWK2GbqmXOl1689u03osa5Fyc3G1Eh9kUXc9BZdFi+
         7sR89Kfwn/Vj6l5aifjSD9sy3AgJdwveHNJTSC7M20e2maP3rihOyZq1Bsl/rJDpInTp
         1blvkCp66tM+PZJlLk8HDzMfx7jqi6/7A0d8LAQyClXJnVt086sH2ZF1OXKCCIhNGw7X
         lRKg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.15 042/202] [Variant 3/Meltdown] arm64: kpti: Make use of nG dependent on arm64_kernel_unmapped_at_el0()
Date: Thu, 15 Feb 2018 16:15:42 +0100
Message-Id: <20180215151715.367552742@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481576946472061?=
X-GMAIL-MSGID: =?utf-8?q?1592482050091024838?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit 41acec624087 upstream.

To allow systems which do not require kpti to continue running with
global kernel mappings (which appears to be a requirement for Cavium
ThunderX due to a CPU erratum), make the use of nG in the kernel page
tables dependent on arm64_kernel_unmapped_at_el0(), which is resolved
at runtime.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/kernel-pgtable.h |   12 ++----------
 arch/arm64/include/asm/pgtable-prot.h   |   30 ++++++++++++++----------------
 2 files changed, 16 insertions(+), 26 deletions(-)

--- a/arch/arm64/include/asm/kernel-pgtable.h
+++ b/arch/arm64/include/asm/kernel-pgtable.h
@@ -78,16 +78,8 @@
 /*
  * Initial memory map attributes.
  */
-#define _SWAPPER_PTE_FLAGS	(PTE_TYPE_PAGE | PTE_AF | PTE_SHARED)
-#define _SWAPPER_PMD_FLAGS	(PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S)
-
-#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-#define SWAPPER_PTE_FLAGS	(_SWAPPER_PTE_FLAGS | PTE_NG)
-#define SWAPPER_PMD_FLAGS	(_SWAPPER_PMD_FLAGS | PMD_SECT_NG)
-#else
-#define SWAPPER_PTE_FLAGS	_SWAPPER_PTE_FLAGS
-#define SWAPPER_PMD_FLAGS	_SWAPPER_PMD_FLAGS
-#endif
+#define SWAPPER_PTE_FLAGS	(PTE_TYPE_PAGE | PTE_AF | PTE_SHARED)
+#define SWAPPER_PMD_FLAGS	(PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S)
 
 #if ARM64_SWAPPER_USES_SECTION_MAPS
 #define SWAPPER_MM_MMUFLAGS	(PMD_ATTRINDX(MT_NORMAL) | SWAPPER_PMD_FLAGS)
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -37,13 +37,11 @@
 #define _PROT_DEFAULT		(PTE_TYPE_PAGE | PTE_AF | PTE_SHARED)
 #define _PROT_SECT_DEFAULT	(PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S)
 
-#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-#define PROT_DEFAULT		(_PROT_DEFAULT | PTE_NG)
-#define PROT_SECT_DEFAULT	(_PROT_SECT_DEFAULT | PMD_SECT_NG)
-#else
-#define PROT_DEFAULT		_PROT_DEFAULT
-#define PROT_SECT_DEFAULT	_PROT_SECT_DEFAULT
-#endif /* CONFIG_UNMAP_KERNEL_AT_EL0 */
+#define PTE_MAYBE_NG		(arm64_kernel_unmapped_at_el0() ? PTE_NG : 0)
+#define PMD_MAYBE_NG		(arm64_kernel_unmapped_at_el0() ? PMD_SECT_NG : 0)
+
+#define PROT_DEFAULT		(_PROT_DEFAULT | PTE_MAYBE_NG)
+#define PROT_SECT_DEFAULT	(_PROT_SECT_DEFAULT | PMD_MAYBE_NG)
 
 #define PROT_DEVICE_nGnRnE	(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_WRITE | PTE_ATTRINDX(MT_DEVICE_nGnRnE))
 #define PROT_DEVICE_nGnRE	(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_WRITE | PTE_ATTRINDX(MT_DEVICE_nGnRE))
@@ -55,22 +53,22 @@
 #define PROT_SECT_NORMAL	(PROT_SECT_DEFAULT | PMD_SECT_PXN | PMD_SECT_UXN | PMD_ATTRINDX(MT_NORMAL))
 #define PROT_SECT_NORMAL_EXEC	(PROT_SECT_DEFAULT | PMD_SECT_UXN | PMD_ATTRINDX(MT_NORMAL))
 
-#define _PAGE_DEFAULT		(PROT_DEFAULT | PTE_ATTRINDX(MT_NORMAL))
-#define _HYP_PAGE_DEFAULT	(_PAGE_DEFAULT & ~PTE_NG)
+#define _PAGE_DEFAULT		(_PROT_DEFAULT | PTE_ATTRINDX(MT_NORMAL))
+#define _HYP_PAGE_DEFAULT	_PAGE_DEFAULT
 
-#define PAGE_KERNEL		__pgprot(_PAGE_DEFAULT | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_WRITE)
-#define PAGE_KERNEL_RO		__pgprot(_PAGE_DEFAULT | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_RDONLY)
-#define PAGE_KERNEL_ROX		__pgprot(_PAGE_DEFAULT | PTE_UXN | PTE_DIRTY | PTE_RDONLY)
-#define PAGE_KERNEL_EXEC	__pgprot(_PAGE_DEFAULT | PTE_UXN | PTE_DIRTY | PTE_WRITE)
-#define PAGE_KERNEL_EXEC_CONT	__pgprot(_PAGE_DEFAULT | PTE_UXN | PTE_DIRTY | PTE_WRITE | PTE_CONT)
+#define PAGE_KERNEL		__pgprot(PROT_NORMAL)
+#define PAGE_KERNEL_RO		__pgprot((PROT_NORMAL & ~PTE_WRITE) | PTE_RDONLY)
+#define PAGE_KERNEL_ROX		__pgprot((PROT_NORMAL & ~(PTE_WRITE | PTE_PXN)) | PTE_RDONLY)
+#define PAGE_KERNEL_EXEC	__pgprot(PROT_NORMAL & ~PTE_PXN)
+#define PAGE_KERNEL_EXEC_CONT	__pgprot((PROT_NORMAL & ~PTE_PXN) | PTE_CONT)
 
 #define PAGE_HYP		__pgprot(_HYP_PAGE_DEFAULT | PTE_HYP | PTE_HYP_XN)
 #define PAGE_HYP_EXEC		__pgprot(_HYP_PAGE_DEFAULT | PTE_HYP | PTE_RDONLY)
 #define PAGE_HYP_RO		__pgprot(_HYP_PAGE_DEFAULT | PTE_HYP | PTE_RDONLY | PTE_HYP_XN)
 #define PAGE_HYP_DEVICE		__pgprot(PROT_DEVICE_nGnRE | PTE_HYP)
 
-#define PAGE_S2			__pgprot(PROT_DEFAULT | PTE_S2_MEMATTR(MT_S2_NORMAL) | PTE_S2_RDONLY)
-#define PAGE_S2_DEVICE		__pgprot(PROT_DEFAULT | PTE_S2_MEMATTR(MT_S2_DEVICE_nGnRE) | PTE_S2_RDONLY | PTE_UXN)
+#define PAGE_S2			__pgprot(_PROT_DEFAULT | PTE_S2_MEMATTR(MT_S2_NORMAL) | PTE_S2_RDONLY)
+#define PAGE_S2_DEVICE		__pgprot(_PROT_DEFAULT | PTE_S2_MEMATTR(MT_S2_DEVICE_nGnRE) | PTE_S2_RDONLY | PTE_UXN)
 
 #define PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_VALID) | PTE_PROT_NONE | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_UXN)
 #define PAGE_SHARED		__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN | PTE_UXN | PTE_WRITE)
