Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2253Vy2aroUiFdWSxAx0pEpl74TWiTbmgNAGzND7gjKmg5Q+2LylO2SjEsev3nTDjmXdPQhI
ARC-Seal: i=1; a=rsa-sha256; t=1518709151; cv=none;
        d=google.com; s=arc-20160816;
        b=uKPDqJ+3bgJ0V3EFzfx8SSr6GOXro+PA3iIUnWU7Hekc9zzSnFWfJ6fbp0eHXbT6ck
         vVxHNb4TPnLa9jZwy7bkI+X1iNd9Q5xIzD0poxSqumG2RZAFF/P6f+CRx8oC82tzqjbH
         0RJ7imy1+eO/BYR2qLI82Uumh2dXbaqB1NDY6BJBUkwjTdeY3dMA/Nfxx7gxnMfY4by+
         nsQJluv20rHFIvf/qgpMs/fuy67r0i7XiP4vi+j+K7NBYecTQACUff0yyOoCSPfrktUN
         vYt28K5OzDpXKXbJlBSMTuq4QfccWiU0auX8s9MBoG2ajuoKuFtlxiIh3+EEUqgEg+wA
         HIGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rd1YWQjC/dAiU8PCMnHOVlbOhhBFb3Mb2hXawy3+tmA=;
        b=pRHdImIZnqUFRrVQ276lB8XjNa9CVYTEq7RwX1pqgalXE+3mRccfLudGhRcMKVatG0
         qRPHc9SebH+m48xyq1pHNXkUMf/q2lMLj4UXeR8Pzv9y32OPeykA93hyaKb6c+tWRX6A
         0c9ng1nDFIBk5AIXBJTSCv+CJ5hCzKS2OAPm0uJJTsxf9a+PScPKOM9yZnpGURBPe5wg
         OF5CpP3GnkhSC6D6+fg4AWbgJlUAjc9zear/eYLaYqrhUyUI6sm/RZXvH70Blhzc9ROG
         6GZtxoYpWcirIwK+Nn/pgccPdknVOIJHzKkvnad88v+37Ukc/X/dtT2xQLG5MYtpNQ7R
         IV4A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Laura Abbott <labbott@redhat.com>,
	Shanker Donthineni <shankerd@codeaurora.org>,
	Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.15 015/202] [Variant 3/Meltdown] arm64: mm: Use non-global mappings for kernel space
Date: Thu, 15 Feb 2018 16:15:15 +0100
Message-Id: <20180215151713.645081624@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481420976317233?=
X-GMAIL-MSGID: =?utf-8?q?1592481966769908461?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit e046eb0c9bf2 upstream.

In preparation for unmapping the kernel whilst running in userspace,
make the kernel mappings non-global so we can avoid expensive TLB
invalidation on kernel exit to userspace.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/kernel-pgtable.h | 12 ++++++++++--
 arch/arm64/include/asm/pgtable-prot.h   | 21 +++++++++++++++------
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
index 7803343e5881..77a27af01371 100644
--- a/arch/arm64/include/asm/kernel-pgtable.h
+++ b/arch/arm64/include/asm/kernel-pgtable.h
@@ -78,8 +78,16 @@
 /*
  * Initial memory map attributes.
  */
-#define SWAPPER_PTE_FLAGS	(PTE_TYPE_PAGE | PTE_AF | PTE_SHARED)
-#define SWAPPER_PMD_FLAGS	(PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S)
+#define _SWAPPER_PTE_FLAGS	(PTE_TYPE_PAGE | PTE_AF | PTE_SHARED)
+#define _SWAPPER_PMD_FLAGS	(PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S)
+
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+#define SWAPPER_PTE_FLAGS	(_SWAPPER_PTE_FLAGS | PTE_NG)
+#define SWAPPER_PMD_FLAGS	(_SWAPPER_PMD_FLAGS | PMD_SECT_NG)
+#else
+#define SWAPPER_PTE_FLAGS	_SWAPPER_PTE_FLAGS
+#define SWAPPER_PMD_FLAGS	_SWAPPER_PMD_FLAGS
+#endif
 
 #if ARM64_SWAPPER_USES_SECTION_MAPS
 #define SWAPPER_MM_MMUFLAGS	(PMD_ATTRINDX(MT_NORMAL) | SWAPPER_PMD_FLAGS)
diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 0a5635fb0ef9..22a926825e3f 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -34,8 +34,16 @@
 
 #include <asm/pgtable-types.h>
 
-#define PROT_DEFAULT		(PTE_TYPE_PAGE | PTE_AF | PTE_SHARED)
-#define PROT_SECT_DEFAULT	(PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S)
+#define _PROT_DEFAULT		(PTE_TYPE_PAGE | PTE_AF | PTE_SHARED)
+#define _PROT_SECT_DEFAULT	(PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S)
+
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+#define PROT_DEFAULT		(_PROT_DEFAULT | PTE_NG)
+#define PROT_SECT_DEFAULT	(_PROT_SECT_DEFAULT | PMD_SECT_NG)
+#else
+#define PROT_DEFAULT		_PROT_DEFAULT
+#define PROT_SECT_DEFAULT	_PROT_SECT_DEFAULT
+#endif /* CONFIG_UNMAP_KERNEL_AT_EL0 */
 
 #define PROT_DEVICE_nGnRnE	(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_WRITE | PTE_ATTRINDX(MT_DEVICE_nGnRnE))
 #define PROT_DEVICE_nGnRE	(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_WRITE | PTE_ATTRINDX(MT_DEVICE_nGnRE))
@@ -48,6 +56,7 @@
 #define PROT_SECT_NORMAL_EXEC	(PROT_SECT_DEFAULT | PMD_SECT_UXN | PMD_ATTRINDX(MT_NORMAL))
 
 #define _PAGE_DEFAULT		(PROT_DEFAULT | PTE_ATTRINDX(MT_NORMAL))
+#define _HYP_PAGE_DEFAULT	(_PAGE_DEFAULT & ~PTE_NG)
 
 #define PAGE_KERNEL		__pgprot(_PAGE_DEFAULT | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_WRITE)
 #define PAGE_KERNEL_RO		__pgprot(_PAGE_DEFAULT | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_RDONLY)
@@ -55,15 +64,15 @@
 #define PAGE_KERNEL_EXEC	__pgprot(_PAGE_DEFAULT | PTE_UXN | PTE_DIRTY | PTE_WRITE)
 #define PAGE_KERNEL_EXEC_CONT	__pgprot(_PAGE_DEFAULT | PTE_UXN | PTE_DIRTY | PTE_WRITE | PTE_CONT)
 
-#define PAGE_HYP		__pgprot(_PAGE_DEFAULT | PTE_HYP | PTE_HYP_XN)
-#define PAGE_HYP_EXEC		__pgprot(_PAGE_DEFAULT | PTE_HYP | PTE_RDONLY)
-#define PAGE_HYP_RO		__pgprot(_PAGE_DEFAULT | PTE_HYP | PTE_RDONLY | PTE_HYP_XN)
+#define PAGE_HYP		__pgprot(_HYP_PAGE_DEFAULT | PTE_HYP | PTE_HYP_XN)
+#define PAGE_HYP_EXEC		__pgprot(_HYP_PAGE_DEFAULT | PTE_HYP | PTE_RDONLY)
+#define PAGE_HYP_RO		__pgprot(_HYP_PAGE_DEFAULT | PTE_HYP | PTE_RDONLY | PTE_HYP_XN)
 #define PAGE_HYP_DEVICE		__pgprot(PROT_DEVICE_nGnRE | PTE_HYP)
 
 #define PAGE_S2			__pgprot(PROT_DEFAULT | PTE_S2_MEMATTR(MT_S2_NORMAL) | PTE_S2_RDONLY)
 #define PAGE_S2_DEVICE		__pgprot(PROT_DEFAULT | PTE_S2_MEMATTR(MT_S2_DEVICE_nGnRE) | PTE_S2_RDONLY | PTE_UXN)
 
-#define PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_VALID) | PTE_PROT_NONE | PTE_RDONLY | PTE_PXN | PTE_UXN)
+#define PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_VALID) | PTE_PROT_NONE | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_UXN)
 #define PAGE_SHARED		__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN | PTE_UXN | PTE_WRITE)
 #define PAGE_SHARED_EXEC	__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_NG | PTE_PXN | PTE_WRITE)
 #define PAGE_READONLY		__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_UXN)
-- 
2.16.1
