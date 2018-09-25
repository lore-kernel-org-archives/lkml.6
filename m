Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C960ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8361214AB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:12:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8361214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbeIYTUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 15:20:24 -0400
Received: from mga02.intel.com ([134.134.136.20]:39126 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729298AbeIYTUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 15:20:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2018 06:12:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,302,1534834800"; 
   d="scan'208";a="93546827"
Received: from thomasvo-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.53.212])
  by orsmga001.jf.intel.com with ESMTP; 25 Sep 2018 06:11:05 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     x86@kernel.org, platform-driver-x86@vger.kernel.org
Cc:     dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com, serge.ayoun@intel.com,
        shay.katz-zamir@intel.com, linux-sgx@vger.kernel.org,
        andriy.shevchenko@linux.intel.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Suresh Siddha <suresh.b.siddha@intel.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH v14 11/19] x86/sgx: Add wrappers for ENCLS leaf functions
Date:   Tue, 25 Sep 2018 16:06:48 +0300
Message-Id: <20180925130845.9962-12-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180925130845.9962-1-jarkko.sakkinen@linux.intel.com>
References: <20180925130845.9962-1-jarkko.sakkinen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add wrappers for Intel(R) SGX ENCLS opcode leaf functions except
ENCLS(EINIT). ENCLS invokes privileged functions for managing (creation,
initialization and swapping) and debugging enclaves.

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/include/asm/sgx.h | 244 +++++++++++++++++++++++++++++++++++++
 1 file changed, 244 insertions(+)

diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
index f4f82f0453a9..e66e2572011e 100644
--- a/arch/x86/include/asm/sgx.h
+++ b/arch/x86/include/asm/sgx.h
@@ -10,4 +10,248 @@
 extern bool sgx_enabled;
 extern bool sgx_lc_enabled;
 
+/**
+ * ENCLS_FAULT_FLAG - flag signifying an ENCLS return code is a trapnr
+ *
+ * ENCLS has its own (positive value) error codes and also generates
+ * ENCLS specific #GP and #PF faults.  And the ENCLS values get munged
+ * with system error codes as everything percolates back up the stack.
+ * Unfortunately (for us), we need to precisely identify each unique
+ * error code, e.g. the action taken if EWB fails varies based on the
+ * type of fault and on the exact SGX error code, i.e. we can't simply
+ * convert all faults to -EFAULT.
+ *
+ * To make all three error types coexist, we set bit 30 to identify an
+ * ENCLS fault.  Bit 31 (technically bits N:31) is used to differentiate
+ * between positive (faults and SGX error codes) and negative (system
+ * error codes) values.
+ */
+#define ENCLS_FAULT_FLAG 0x40000000
+
+/**
+ * Check for a fault by looking for a postive value with the fault
+ * flag set.  The postive value check is needed to filter out system
+ * error codes since negative values will have all higher order bits
+ * set, including ENCLS_FAULT_FLAG.
+ */
+#define IS_ENCLS_FAULT(r) ((int)(r) > 0 && ((r) & ENCLS_FAULT_FLAG))
+
+/**
+ * Retrieve the encoded trapnr from the specified return code.
+ */
+#define ENCLS_TRAPNR(r) ((r) & ~ENCLS_FAULT_FLAG)
+
+/**
+ * encls_to_err - translate an ENCLS fault or SGX code into a system error code
+ * @ret:	positive value return code
+ *
+ * Translate a postive return code, e.g. from ENCLS, into a system error
+ * code.  Primarily used by functions that cannot return a non-negative
+ * error code, e.g. kernel callbacks.
+ *
+ * Return:
+ *	0 on success,
+ *	-errno on failure
+ */
+static inline int encls_to_err(int ret)
+{
+	if (IS_ENCLS_FAULT(ret))
+		return -EFAULT;
+
+	switch (ret) {
+	case SGX_UNMASKED_EVENT:
+		return -EINTR;
+	case SGX_INVALID_SIG_STRUCT:
+	case SGX_INVALID_ATTRIBUTE:
+	case SGX_INVALID_MEASUREMENT:
+	case SGX_INVALID_EINITTOKEN:
+	case SGX_INVALID_CPUSVN:
+	case SGX_INVALID_ISVSVN:
+	case SGX_INVALID_KEYNAME:
+		return -EINVAL;
+	case SGX_ENCLAVE_ACT:
+	case SGX_CHILD_PRESENT:
+	case SGX_ENTRYEPOCH_LOCKED:
+	case SGX_PREV_TRK_INCMPL:
+	case SGX_PAGE_NOT_MODIFIABLE:
+	case SGX_PAGE_NOT_DEBUGGABLE:
+		return -EBUSY;
+	default:
+		return -EIO;
+	};
+}
+
+/**
+ * __encls_ret_N - encode an ENCLS leaf that returns an error code in EAX
+ * @rax:	leaf number
+ * @inputs:	asm inputs for the leaf
+ *
+ * Emit assembly for an ENCLS leaf that returns an error code, e.g. EREMOVE.
+ * And because SGX isn't complex enough as it is, leafs that return an error
+ * code also modify flags.
+ *
+ * Return:
+ *	0 on success,
+ *	SGX error code on failure
+ */
+#define __encls_ret_N(rax, inputs...)				\
+	({							\
+	int ret;						\
+	asm volatile(						\
+	"1: .byte 0x0f, 0x01, 0xcf;\n\t"			\
+	"2:\n"							\
+	".section .fixup,\"ax\"\n"				\
+	"3: orl $"__stringify(ENCLS_FAULT_FLAG)",%%eax\n"	\
+	"   jmp 2b\n"						\
+	".previous\n"						\
+	_ASM_EXTABLE_FAULT(1b, 3b)				\
+	: "=a"(ret)						\
+	: "a"(rax), inputs					\
+	: "memory", "cc");					\
+	ret;							\
+	})
+
+#define __encls_ret_1(rax, rcx)		\
+	({				\
+	__encls_ret_N(rax, "c"(rcx));	\
+	})
+
+#define __encls_ret_2(rax, rbx, rcx)		\
+	({					\
+	__encls_ret_N(rax, "b"(rbx), "c"(rcx));	\
+	})
+
+#define __encls_ret_3(rax, rbx, rcx, rdx)			\
+	({							\
+	__encls_ret_N(rax, "b"(rbx), "c"(rcx), "d"(rdx));	\
+	})
+
+/**
+ * __encls_N - encode an ENCLS leaf that doesn't return an error code
+ * @rax:	leaf number
+ * @rbx_out:	optional output variable
+ * @inputs:	asm inputs for the leaf
+ *
+ * Emit assembly for an ENCLS leaf that does not return an error code,
+ * e.g. ECREATE.  Leaves without error codes either succeed or fault.
+ * @rbx_out is an optional parameter for use by EDGBRD, which returns
+ * the the requested value in RBX.
+ *
+ * Return:
+ *   0 on success,
+ *   trapnr with ENCLS_FAULT_FLAG set on fault
+ */
+#define __encls_N(rax, rbx_out, inputs...)			\
+	({							\
+	int ret;						\
+	asm volatile(						\
+	"1: .byte 0x0f, 0x01, 0xcf;\n\t"			\
+	"   xor %%eax,%%eax;\n"					\
+	"2:\n"							\
+	".section .fixup,\"ax\"\n"				\
+	"3: orl $"__stringify(ENCLS_FAULT_FLAG)",%%eax\n"	\
+	"   jmp 2b\n"						\
+	".previous\n"						\
+	_ASM_EXTABLE_FAULT(1b, 3b)				\
+	: "=a"(ret), "=b"(rbx_out)				\
+	: "a"(rax), inputs					\
+	: "memory");						\
+	ret;							\
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
+static inline int __ecreate(struct sgx_pageinfo *pginfo, void __iomem *secs)
+{
+	return __encls_2(SGX_ECREATE, pginfo, secs);
+}
+
+static inline int __eextend(void __iomem *secs, void __iomem *addr)
+{
+	return __encls_2(SGX_EEXTEND, secs, addr);
+}
+
+static inline int __eadd(struct sgx_pageinfo *pginfo, void __iomem *addr)
+{
+	return __encls_2(SGX_EADD, pginfo, addr);
+}
+
+static inline int __einit(void *sigstruct, struct sgx_einittoken *einittoken,
+			  void __iomem *secs)
+{
+	return __encls_ret_3(SGX_EINIT, sigstruct, secs, einittoken);
+}
+
+static inline int __eremove(void __iomem *addr)
+{
+	return __encls_ret_1(SGX_EREMOVE, addr);
+}
+
+static inline int __edbgwr(void __iomem *addr, unsigned long *data)
+{
+	return __encls_2(SGX_EDGBWR, *data, addr);
+}
+
+static inline int __edbgrd(void __iomem *addr, unsigned long *data)
+{
+	return __encls_1_1(SGX_EDGBRD, *data, addr);
+}
+
+static inline int __etrack(void __iomem *addr)
+{
+	return __encls_ret_1(SGX_ETRACK, addr);
+}
+
+static inline int __eldu(struct sgx_pageinfo *pginfo, void __iomem *addr,
+			 void *va)
+{
+	return __encls_ret_3(SGX_ELDU, pginfo, addr, va);
+}
+
+static inline int __eblock(void __iomem *addr)
+{
+	return __encls_ret_1(SGX_EBLOCK, addr);
+}
+
+static inline int __epa(void __iomem *addr)
+{
+	unsigned long rbx = SGX_PAGE_TYPE_VA;
+
+	return __encls_2(SGX_EPA, rbx, addr);
+}
+
+static inline int __ewb(struct sgx_pageinfo *pginfo, void __iomem *addr,
+			void __iomem *va)
+{
+	return __encls_ret_3(SGX_EWB, pginfo, addr, va);
+}
+
+static inline int __eaug(struct sgx_pageinfo *pginfo, void __iomem *addr)
+{
+	return __encls_2(SGX_EAUG, pginfo, addr);
+}
+
+static inline int __emodpr(struct sgx_secinfo *secinfo, void __iomem *addr)
+{
+	return __encls_ret_2(SGX_EMODPR, secinfo, addr);
+}
+
+static inline int __emodt(struct sgx_secinfo *secinfo, void __iomem *addr)
+{
+	return __encls_ret_2(SGX_EMODT, secinfo, addr);
+}
+
 #endif /* _ASM_X86_SGX_H */
-- 
2.17.1

