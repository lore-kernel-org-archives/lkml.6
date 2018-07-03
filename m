Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D897C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453D7208B1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 453D7208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934690AbeGCSXc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 14:23:32 -0400
Received: from mga14.intel.com ([192.55.52.115]:20281 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934448AbeGCSXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 14:23:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2018 11:23:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,304,1526367600"; 
   d="scan'208";a="242708205"
Received: from cdikicix-mobl.ger.corp.intel.com (HELO localhost) ([10.249.254.69])
  by fmsmga006.fm.intel.com with ESMTP; 03 Jul 2018 11:23:15 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     x86@kernel.org, platform-driver-x86@vger.kernel.org
Cc:     dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com,
        linux-sgx@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH v12 08/13] x86/sgx: wrappers for ENCLS opcode leaf functions
Date:   Tue,  3 Jul 2018 21:19:53 +0300
Message-Id: <20180703182118.15024-9-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180703182118.15024-1-jarkko.sakkinen@linux.intel.com>
References: <20180703182118.15024-1-jarkko.sakkinen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds wrappers for Intel(R) SGX ENCLS opcode leaf functions
except for ENCLS(EINIT). The ENCLS instruction invokes the privileged
functions for managing (creation, initialization and swapping) and
debugging enclaves.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/include/asm/sgx.h      | 176 ++++++++++++++++++++++++++++++++
 arch/x86/include/asm/sgx_arch.h |  19 ++++
 2 files changed, 195 insertions(+)

diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
index 77b2294fcfb0..a42c8ed10f7d 100644
--- a/arch/x86/include/asm/sgx.h
+++ b/arch/x86/include/asm/sgx.h
@@ -11,6 +11,157 @@
 #include <linux/rwsem.h>
 #include <linux/types.h>
 
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
 #define SGX_MAX_EPC_BANKS 8
 
 #define SGX_EPC_BANK(epc_page) \
@@ -39,4 +190,29 @@ extern bool sgx_lc_enabled;
 void *sgx_get_page(struct sgx_epc_page *ptr);
 void sgx_put_page(void *epc_page_ptr);
 
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
diff --git a/arch/x86/include/asm/sgx_arch.h b/arch/x86/include/asm/sgx_arch.h
index 41a37eaa3f51..85e6eb4c11a5 100644
--- a/arch/x86/include/asm/sgx_arch.h
+++ b/arch/x86/include/asm/sgx_arch.h
@@ -14,6 +14,25 @@ enum sgx_cpuid {
 	SGX_CPUID_EPC_BANKS	= 2,
 };
 
+enum sgx_encls_leafs {
+	ECREATE	= 0x0,
+	EADD	= 0x1,
+	EINIT	= 0x2,
+	EREMOVE	= 0x3,
+	EDGBRD	= 0x4,
+	EDGBWR	= 0x5,
+	EEXTEND	= 0x6,
+	ELDB	= 0x7,
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
 #define SGX_SSA_GPRS_SIZE		182
 #define SGX_SSA_MISC_EXINFO_SIZE	16
 
-- 
2.17.1

