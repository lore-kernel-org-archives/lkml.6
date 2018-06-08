Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 1Gi1GwG7GltuWwAAmS7hNA
	; Fri, 08 Jun 2018 17:21:05 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 575F8608B8; Fri,  8 Jun 2018 17:21:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8C877601D2;
	Fri,  8 Jun 2018 17:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8C877601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753189AbeFHRVD (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 13:21:03 -0400
Received: from mga04.intel.com ([192.55.52.120]:49129 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752754AbeFHRVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 13:21:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jun 2018 10:20:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,490,1520924400";
   d="scan'208";a="231035336"
Received: from nzou1-mobl1.ccr.corp.intel.com (HELO localhost) ([10.249.254.60])
  by orsmga005.jf.intel.com with ESMTP; 08 Jun 2018 10:20:54 -0700
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: x86@kernel.org, platform-driver-x86@vger.kernel.org
Cc: dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT)), intel-sgx-kernel-dev@lists.01.org (open list:INTEL SGX)
Subject: [PATCH v11 08/13] x86, sgx: added ENCLS wrappers
Date: Fri,  8 Jun 2018 19:09:43 +0200
Message-Id: <20180608171216.26521-9-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds wrappers for Intel(R) SGX ENCLS opcode functionality.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 arch/x86/include/asm/sgx.h | 198 +++++++++++++++++++++++++++++++++++++
 1 file changed, 198 insertions(+)

diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
index fa3e6e0eb8af..a2f727f85b91 100644
--- a/arch/x86/include/asm/sgx.h
+++ b/arch/x86/include/asm/sgx.h
@@ -10,6 +10,10 @@
 #ifndef _ASM_X86_SGX_H
 #define _ASM_X86_SGX_H
 
+#include <asm/sgx_arch.h>
+#include <asm/asm.h>
+#include <linux/bitops.h>
+#include <linux/err.h>
 #include <linux/types.h>
 
 #define SGX_CPUID 0x12
@@ -20,6 +24,200 @@ enum sgx_cpuid {
 	SGX_CPUID_EPC_BANKS	= 2,
 };
 
+enum sgx_commands {
+	ECREATE	= 0x0,
+	EADD	= 0x1,
+	EINIT	= 0x2,
+	EREMOVE	= 0x3,
+	EDGBRD	= 0x4,
+	EDGBWR	= 0x5,
+	EEXTEND	= 0x6,
+	ELDU	= 0x8,
+	EBLOCK	= 0x9,
+	EPA	= 0xA,
+	EWB	= 0xB,
+	ETRACK	= 0xC,
+	EAUG	= 0xD,
+	EMODPR	= 0xE,
+	EMODT	= 0xF,
+};
+
+#define IS_ENCLS_FAULT(r) ((r) & 0xffff0000)
+#define ENCLS_FAULT_VECTOR(r) ((r) >> 16)
+
+#define ENCLS_TO_ERR(r) (IS_ENCLS_FAULT(r) ? -EFAULT :		\
+			(r) == SGX_UNMASKED_EVENT ? -EINTR :	\
+			(r) == SGX_MAC_COMPARE_FAIL ? -EIO :	\
+			(r) == SGX_ENTRYEPOCH_LOCKED ? -EBUSY : -EPERM)
+
+#define __encls_ret_N(rax, inputs...)			\
+	({						\
+	int ret;					\
+	asm volatile(					\
+	"1: .byte 0x0f, 0x01, 0xcf;\n\t"		\
+	"2:\n"						\
+	".section .fixup,\"ax\"\n"			\
+	"3: shll $16,%%eax\n"				\
+	"   jmp 2b\n"					\
+	".previous\n"					\
+	_ASM_EXTABLE_FAULT(1b, 3b)			\
+	: "=a"(ret)					\
+	: "a"(rax), inputs				\
+	: "memory");					\
+	ret;						\
+	})
+
+#define __encls_ret_1(rax, rcx)				\
+	({						\
+	__encls_ret_N(rax, "c"(rcx));			\
+	})
+
+#define __encls_ret_2(rax, rbx, rcx)			\
+	({						\
+	__encls_ret_N(rax, "b"(rbx), "c"(rcx));		\
+	})
+
+#define __encls_ret_3(rax, rbx, rcx, rdx)			\
+	({							\
+	__encls_ret_N(rax, "b"(rbx), "c"(rcx), "d"(rdx));	\
+	})
+
+#define __encls_N(rax, rbx_out, inputs...)		\
+	({						\
+	int ret;					\
+	asm volatile(					\
+	"1: .byte 0x0f, 0x01, 0xcf;\n\t"		\
+	"   xor %%eax,%%eax;\n"				\
+	"2:\n"						\
+	".section .fixup,\"ax\"\n"			\
+	"3: shll $16,%%eax\n"				\
+	"   jmp 2b\n"					\
+	".previous\n"					\
+	_ASM_EXTABLE_FAULT(1b, 3b)				\
+	: "=a"(ret), "=b"(rbx_out)			\
+	: "a"(rax), inputs				\
+	: "memory");					\
+	ret;						\
+	})
+
+#define __encls_2(rax, rbx, rcx)				\
+	({							\
+	unsigned long ign_rbx_out;				\
+	__encls_N(rax, ign_rbx_out, "b"(rbx), "c"(rcx));	\
+	})
+
+#define __encls_1_1(rax, data, rcx)			\
+	({						\
+	unsigned long rbx_out;				\
+	int ret = __encls_N(rax, rbx_out, "c"(rcx));	\
+	if (!ret)					\
+		data = rbx_out;				\
+	ret;						\
+	})
+
+static inline int __ecreate(struct sgx_pageinfo *pginfo, void *secs)
+{
+	return __encls_2(ECREATE, pginfo, secs);
+}
+
+static inline int __eextend(void *secs, void *epc)
+{
+	return __encls_2(EEXTEND, secs, epc);
+}
+
+static inline int __eadd(struct sgx_pageinfo *pginfo, void *epc)
+{
+	return __encls_2(EADD, pginfo, epc);
+}
+
+static inline int __einit(void *sigstruct, struct sgx_einittoken *einittoken,
+			  void *secs)
+{
+	return __encls_ret_3(EINIT, sigstruct, secs, einittoken);
+}
+
+static inline int __eremove(void *epc)
+{
+	return __encls_ret_1(EREMOVE, epc);
+}
+
+static inline int __edbgwr(unsigned long addr, unsigned long *data)
+{
+	return __encls_2(EDGBWR, *data, addr);
+}
+
+static inline int __edbgrd(unsigned long addr, unsigned long *data)
+{
+	return __encls_1_1(EDGBRD, *data, addr);
+}
+
+static inline int __etrack(void *epc)
+{
+	return __encls_ret_1(ETRACK, epc);
+}
+
+static inline int __eldu(struct sgx_pageinfo *pginfo, void *epc, void *va)
+{
+	return __encls_ret_3(ELDU, pginfo, epc, va);
+}
+
+static inline int __eblock(void *epc)
+{
+	return __encls_ret_1(EBLOCK, epc);
+}
+
+static inline int __epa(void *epc)
+{
+	unsigned long rbx = SGX_PAGE_TYPE_VA;
+
+	return __encls_2(EPA, rbx, epc);
+}
+
+static inline int __ewb(struct sgx_pageinfo *pginfo, void *epc, void *va)
+{
+	return __encls_ret_3(EWB, pginfo, epc, va);
+}
+
+static inline int __eaug(struct sgx_pageinfo *pginfo, void *epc)
+{
+	return __encls_2(EAUG, pginfo, epc);
+}
+
+static inline int __emodpr(struct sgx_secinfo *secinfo, void *epc)
+{
+	return __encls_ret_2(EMODPR, secinfo, epc);
+}
+
+static inline int __emodt(struct sgx_secinfo *secinfo, void *epc)
+{
+	return __encls_ret_2(EMODT, secinfo, epc);
+}
+
 extern bool sgx_enabled;
 
+#define SGX_FN(name, params...)		\
+{					\
+	void *epc;			\
+	int ret;			\
+	epc = sgx_get_page(epc_page);	\
+	ret = __##name(params);		\
+	sgx_put_page(epc);		\
+	return ret;			\
+}
+
+#define BUILD_SGX_FN(fn, name)				\
+static inline int fn(struct sgx_epc_page *epc_page)	\
+	SGX_FN(name, epc)
+BUILD_SGX_FN(sgx_eremove, eremove)
+BUILD_SGX_FN(sgx_eblock, eblock)
+BUILD_SGX_FN(sgx_etrack, etrack)
+BUILD_SGX_FN(sgx_epa, epa)
+
+static inline int sgx_emodpr(struct sgx_secinfo *secinfo,
+			     struct sgx_epc_page *epc_page)
+	SGX_FN(emodpr, secinfo, epc)
+static inline int sgx_emodt(struct sgx_secinfo *secinfo,
+			    struct sgx_epc_page *epc_page)
+	SGX_FN(emodt, secinfo, epc)
+
 #endif /* _ASM_X86_SGX_H */
-- 
2.17.0
