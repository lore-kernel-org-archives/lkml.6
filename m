Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id PxglDJO7GlvZXgAAmS7hNA
	; Fri, 08 Jun 2018 17:23:45 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5FF2C607DC; Fri,  8 Jun 2018 17:23:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A74AD605A5;
	Fri,  8 Jun 2018 17:23:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A74AD605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752999AbeFHRXh (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 13:23:37 -0400
Received: from mga14.intel.com ([192.55.52.115]:6303 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752609AbeFHRXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 13:23:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jun 2018 10:23:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,490,1520924400";
   d="scan'208";a="231036026"
Received: from nzou1-mobl1.ccr.corp.intel.com (HELO localhost) ([10.249.254.60])
  by orsmga005.jf.intel.com with ESMTP; 08 Jun 2018 10:23:25 -0700
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: x86@kernel.org, platform-driver-x86@vger.kernel.org
Cc: dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT)), intel-sgx-kernel-dev@lists.01.org (open list:INTEL SGX)
Subject: [PATCH v11 13/13] intel_sgx: in-kernel launch enclave
Date: Fri,  8 Jun 2018 19:09:48 +0200
Message-Id: <20180608171216.26521-14-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Launch Enclave (LE) generates cryptographic launch tokens for user
enclaves. A launch token is used by EINIT to check whether the enclave
is authorized to launch or not. By having its own launch enclave, Linux
has full control of the enclave launch process.

LE is wrapped into a user space proxy program that reads enclave
signatures outputs launch tokens. The kernel-side glue code is
implemented by using the user space helper framework.  The IPC between
the LE proxy program and kernel is handled with an anonymous inode.

The commit also adds enclave signing tool that is used by kbuild to
measure and sign the launch enclave. CONFIG_INTEL_SGX_SIGNING_KEY points
to a PEM-file for the 3072-bit RSA key that is used as the LE public key
pair. The default location is:

  drivers/platform/x86/intel_sgx/sgx_signing_key.pem

If the default key does not exist kbuild will generate a random key and
place it to this location. KBUILD_SGX_SIGN_PIN can be used to specify
the passphrase for the LE public key.

The CMAC implementation has been derived from TinyCrypt. The kernel
AES-NI implementation is used for AES.

[1] https://github.com/01org/tinycrypt

Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Serge Ayoun <serge.ayoun@intel.com>
---
 arch/x86/include/asm/sgx.h                    |   1 -
 arch/x86/include/asm/sgx_le.h                 |  17 +
 drivers/platform/x86/intel_sgx/Kconfig        |  14 +
 drivers/platform/x86/intel_sgx/Makefile       |  19 +
 drivers/platform/x86/intel_sgx/le/Makefile    |  34 ++
 .../x86/intel_sgx/le/enclave/Makefile         |  54 ++
 .../intel_sgx/le/enclave/aesni-intel_asm.S    |   1 +
 .../x86/intel_sgx/le/enclave/cmac_mode.c      | 209 +++++++
 .../x86/intel_sgx/le/enclave/cmac_mode.h      |  54 ++
 .../x86/intel_sgx/le/enclave/encl_bootstrap.S | 116 ++++
 .../platform/x86/intel_sgx/le/enclave/main.c  | 146 +++++
 .../platform/x86/intel_sgx/le/enclave/main.h  |  19 +
 .../x86/intel_sgx/le/enclave/sgx_le.lds       |  33 ++
 .../x86/intel_sgx/le/enclave/sgxsign.c        | 551 ++++++++++++++++++
 .../x86/intel_sgx/le/enclave/string.c         |   1 +
 drivers/platform/x86/intel_sgx/le/entry.S     |  70 +++
 .../x86/intel_sgx/le/include/sgx_asm.h        |  15 +
 drivers/platform/x86/intel_sgx/le/main.c      | 140 +++++
 drivers/platform/x86/intel_sgx/le/main.h      |  30 +
 .../platform/x86/intel_sgx/le/sgx_le_piggy.S  |  22 +
 drivers/platform/x86/intel_sgx/le/string.c    |  39 ++
 drivers/platform/x86/intel_sgx/sgx.h          |  17 +
 drivers/platform/x86/intel_sgx/sgx_encl.c     |  18 +-
 drivers/platform/x86/intel_sgx/sgx_ioctl.c    |   4 +-
 drivers/platform/x86/intel_sgx/sgx_le.c       | 303 ++++++++++
 .../x86/intel_sgx/sgx_le_proxy_piggy.S        |  22 +
 drivers/platform/x86/intel_sgx/sgx_main.c     |  71 ++-
 27 files changed, 2000 insertions(+), 20 deletions(-)
 create mode 100644 arch/x86/include/asm/sgx_le.h
 create mode 100644 drivers/platform/x86/intel_sgx/le/Makefile
 create mode 100644 drivers/platform/x86/intel_sgx/le/enclave/Makefile
 create mode 120000 drivers/platform/x86/intel_sgx/le/enclave/aesni-intel_asm.S
 create mode 100644 drivers/platform/x86/intel_sgx/le/enclave/cmac_mode.c
 create mode 100644 drivers/platform/x86/intel_sgx/le/enclave/cmac_mode.h
 create mode 100644 drivers/platform/x86/intel_sgx/le/enclave/encl_bootstrap.S
 create mode 100644 drivers/platform/x86/intel_sgx/le/enclave/main.c
 create mode 100644 drivers/platform/x86/intel_sgx/le/enclave/main.h
 create mode 100644 drivers/platform/x86/intel_sgx/le/enclave/sgx_le.lds
 create mode 100644 drivers/platform/x86/intel_sgx/le/enclave/sgxsign.c
 create mode 120000 drivers/platform/x86/intel_sgx/le/enclave/string.c
 create mode 100644 drivers/platform/x86/intel_sgx/le/entry.S
 create mode 100644 drivers/platform/x86/intel_sgx/le/include/sgx_asm.h
 create mode 100644 drivers/platform/x86/intel_sgx/le/main.c
 create mode 100644 drivers/platform/x86/intel_sgx/le/main.h
 create mode 100644 drivers/platform/x86/intel_sgx/le/sgx_le_piggy.S
 create mode 100644 drivers/platform/x86/intel_sgx/le/string.c
 create mode 100644 drivers/platform/x86/intel_sgx/sgx_le.c
 create mode 100644 drivers/platform/x86/intel_sgx/sgx_le_proxy_piggy.S

diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
index ae738e16ba6c..07c16945076e 100644
--- a/arch/x86/include/asm/sgx.h
+++ b/arch/x86/include/asm/sgx.h
@@ -259,7 +259,6 @@ struct sgx_launch_request {
 	u8 mrsigner[32];
 	uint64_t attributes;
 	uint64_t xfrm;
-	struct sgx_einittoken token;
 };
 
 #define SGX_FN(name, params...)		\
diff --git a/arch/x86/include/asm/sgx_le.h b/arch/x86/include/asm/sgx_le.h
new file mode 100644
index 000000000000..61f73fa71ba2
--- /dev/null
+++ b/arch/x86/include/asm/sgx_le.h
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// Copyright(c) 2016-17 Intel Corporation.
+//
+// Authors:
+//
+// Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
+
+#ifndef _ASM_X86_SGX_LE_H
+#define _ASM_X86_SGX_LE_H
+
+#define SGX_LE_EXE_PATH "/proc/self/fd/3"
+
+#define SGX_LE_EXE_FD 3
+#define SGX_LE_DEV_FD 4
+#define SGX_LE_PIPE_FD 5
+
+#endif /* _ASM_X86_SGX_LE_H */
diff --git a/drivers/platform/x86/intel_sgx/Kconfig b/drivers/platform/x86/intel_sgx/Kconfig
index 4cd88310617e..4db0297b55ab 100644
--- a/drivers/platform/x86/intel_sgx/Kconfig
+++ b/drivers/platform/x86/intel_sgx/Kconfig
@@ -2,12 +2,16 @@
 # Intel SGX
 #
 
+menu "Intel SGX"
+
 config INTEL_SGX
 	tristate "Intel(R) SGX Driver"
 	default n
 	depends on X86_64 && CPU_SUP_INTEL
 	select INTEL_SGX_CORE
 	select MMU_NOTIFIER
+	select CRYPTO
+	select CRYPTO_SHA256
 	help
 	Intel(R) SGX is a set of CPU instructions that can be used by
 	applications to set aside private regions of code and data.  The code
@@ -18,3 +22,13 @@ config INTEL_SGX
 	called Enclave Page Cache (EPC). There is a hardware unit in the
 	processor called Memory Encryption Engine. The MEE encrypts and decrypts
 	the EPC pages as they enter and leave the processor package.
+
+config INTEL_SGX_SIGNING_KEY
+	string "Path to the Intel SGX LE signing key"
+	default "drivers/platform/x86/intel_sgx/signing_key.pem"
+	depends on INTEL_SGX
+	---help---
+	Provide a path to a 3072-bit RSA private key that will be used to
+	sign the launch enclave.
+
+endmenu
diff --git a/drivers/platform/x86/intel_sgx/Makefile b/drivers/platform/x86/intel_sgx/Makefile
index 95f254e30a8b..a5b729310ee2 100644
--- a/drivers/platform/x86/intel_sgx/Makefile
+++ b/drivers/platform/x86/intel_sgx/Makefile
@@ -11,3 +11,22 @@ intel_sgx-$(CONFIG_INTEL_SGX) += \
 	sgx_main.o \
 	sgx_fault.o \
 	sgx_vma.o \
+	sgx_le.o \
+	sgx_le_proxy_piggy.o
+
+$(eval $(call config_filename,INTEL_SGX_SIGNING_KEY))
+
+INTEL_SGX_SIGNING_KEY_PATH := \
+	$(INTEL_SGX_SIGNING_KEY_SRCPREFIX)$(INTEL_SGX_SIGNING_KEY_FILENAME)
+
+ifeq ($(CONFIG_INTEL_SGX_SIGNING_KEY),"drivers/platform/x86/intel_sgx/signing_key.pem")
+$(INTEL_SGX_SIGNING_KEY_PATH):
+	$(Q)openssl genrsa -3 -out $(INTEL_SGX_SIGNING_KEY_PATH) 3072
+endif
+
+$(obj)/sgx_le_proxy_piggy.o: $(INTEL_SGX_SIGNING_KEY_PATH) \
+			     $(obj)/le/sgx_le_proxy
+$(obj)/le/sgx_le_proxy: FORCE
+	$(Q)$(MAKE) -j1 $(build)=$(obj)/le $@
+
+export INTEL_SGX_SIGNING_KEY_PATH
diff --git a/drivers/platform/x86/intel_sgx/le/Makefile b/drivers/platform/x86/intel_sgx/le/Makefile
new file mode 100644
index 000000000000..5adaddc71bd6
--- /dev/null
+++ b/drivers/platform/x86/intel_sgx/le/Makefile
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+# Copyright(c) 2016-17 Intel Corporation.
+#
+# Authors:
+#
+# Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
+
+KASAN_SANITIZE := n
+OBJECT_FILES_NON_STANDARD := y
+KCOV_INSTRUMENT := n
+KBUILD_CFLAGS := -Wall -Werror -static -nostdlib -nostartfiles -fno-builtin \
+		 -I$(obj)/include
+KBUILD_AFLAGS += -I$(obj)/include
+
+subdir- := enclave
+
+always := sgx_le_proxy
+clean-files := sgx_le_proxy
+
+#
+# sgx_le_proxy
+#
+
+sgx_le_proxy-y += main.o entry.o sgx_le_piggy.o string.o
+targets += $(sgx_le_proxy-y)
+SGX_LE_PROXY_OBJS = $(addprefix $(obj)/,$(sgx_le_proxy-y))
+
+$(obj)/sgx_le_piggy.o: $(obj)/enclave/sgx_le.bin $(obj)/enclave/sgx_le.ss
+$(obj)/enclave/sgx_le.bin $(obj)/enclave/sgx_le.ss: FORCE
+	$(Q)$(MAKE) -j1 $(build)=$(obj)/enclave $@
+
+targets += sgx_le_proxy
+$(obj)/sgx_le_proxy: $(SGX_LE_PROXY_OBJS)
+	$(call if_changed,ld)
diff --git a/drivers/platform/x86/intel_sgx/le/enclave/Makefile b/drivers/platform/x86/intel_sgx/le/enclave/Makefile
new file mode 100644
index 000000000000..aef95d00223c
--- /dev/null
+++ b/drivers/platform/x86/intel_sgx/le/enclave/Makefile
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+# Copyright(c) 2016-17 Intel Corporation.
+#
+# Authors:
+#
+# Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
+
+KASAN_SANITIZE := n
+OBJECT_FILES_NON_STANDARD := y
+KCOV_INSTRUMENT := n
+KBUILD_CFLAGS := -Wall -Werror -static -nostdlib -nostartfiles -fPIC \
+		 -fno-stack-protector -mrdrnd  -I$(obj)/../include \
+		 -I$(srctree)/arch/x86/include
+KBUILD_AFLAGS := $(KBUILD_CFLAGS) -D__ASSEMBLY__ -DAESNI_INTEL_MINIMAL
+
+always := sgx_le.elf sgx_le.bin sgx_le.ss
+clean-files := sgx_le.elf sgx_le.bin sgx_le.ss
+
+#
+# sgx_le.ss
+#
+
+HOST_EXTRACFLAGS += -I$(srctree)/arch/x86/include
+HOSTLOADLIBES_sgxsign = -lcrypto
+hostprogs-y += sgxsign
+quiet_cmd_sgxsign = SGXSIGN $@
+      cmd_sgxsign = drivers/platform/x86/intel_sgx/le/enclave/sgxsign \
+		    $(INTEL_SGX_SIGNING_KEY_PATH) $< $@
+
+targets += sgx_le.ss
+$(obj)/sgx_le.ss: $(obj)/sgx_le.bin $(obj)/sgxsign FORCE
+	$(call if_changed,sgxsign)
+
+#
+# sgx_le.bin
+#
+
+targets += sgx_le.bin
+OBJCOPYFLAGS_sgx_le.bin := --remove-section=.got.plt -O binary
+$(obj)/sgx_le.bin: $(obj)/sgx_le.elf FORCE
+	$(call if_changed,objcopy)
+
+#
+# sgx_le.elf
+#
+
+sgx_le-y +=  main.o encl_bootstrap.o cmac_mode.o aesni-intel_asm.o string.o
+targets += $(sgx_le-y)
+SGX_LE_OBJS = $(addprefix $(obj)/,$(sgx_le-y))
+
+targets += sgx_le.elf
+LDFLAGS_sgx_le.elf := -T
+$(obj)/sgx_le.elf: $(obj)/sgx_le.lds $(SGX_LE_OBJS)
+	$(call if_changed,ld)
diff --git a/drivers/platform/x86/intel_sgx/le/enclave/aesni-intel_asm.S b/drivers/platform/x86/intel_sgx/le/enclave/aesni-intel_asm.S
new file mode 120000
index 000000000000..61971c8f7b3f
--- /dev/null
+++ b/drivers/platform/x86/intel_sgx/le/enclave/aesni-intel_asm.S
@@ -0,0 +1 @@
+../../../../../../arch/x86/crypto/aesni-intel_asm.S
\ No newline at end of file
diff --git a/drivers/platform/x86/intel_sgx/le/enclave/cmac_mode.c b/drivers/platform/x86/intel_sgx/le/enclave/cmac_mode.c
new file mode 100644
index 000000000000..f1f72b1679ee
--- /dev/null
+++ b/drivers/platform/x86/intel_sgx/le/enclave/cmac_mode.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// Copyright(c) 2016-17 Intel Corporation.
+//
+// Derived from TinyCrypt CMAC implementation.
+//
+// Authors:
+//
+// Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
+
+#include <asm/sgx.h>
+#include "cmac_mode.h"
+
+/* max number of calls until change the key (2^48).*/
+const static uint64_t MAX_CALLS = ((uint64_t)1 << 48);
+
+/*
+ *  gf_wrap -- In our implementation, GF(2^128) is represented as a 16 byte
+ *  array with byte 0 the most significant and byte 15 the least significant.
+ *  High bit carry reduction is based on the primitive polynomial
+ *
+ *                     X^128 + X^7 + X^2 + X + 1,
+ *
+ *  which leads to the reduction formula X^128 = X^7 + X^2 + X + 1. Indeed,
+ *  since 0 = (X^128 + X^7 + X^2 + 1) mod (X^128 + X^7 + X^2 + X + 1) and since
+ *  addition of polynomials with coefficients in Z/Z(2) is just XOR, we can
+ *  add X^128 to both sides to get
+ *
+ *       X^128 = (X^7 + X^2 + X + 1) mod (X^128 + X^7 + X^2 + X + 1)
+ *
+ *  and the coefficients of the polynomial on the right hand side form the
+ *  string 1000 0111 = 0x87, which is the value of gf_wrap.
+ *
+ *  This gets used in the following way. Doubling in GF(2^128) is just a left
+ *  shift by 1 bit, except when the most significant bit is 1. In the latter
+ *  case, the relation X^128 = X^7 + X^2 + X + 1 says that the high order bit
+ *  that overflows beyond 128 bits can be replaced by addition of
+ *  X^7 + X^2 + X + 1 <--> 0x87 to the low order 128 bits. Since addition
+ *  in GF(2^128) is represented by XOR, we therefore only have to XOR 0x87
+ *  into the low order byte after a left shift when the starting high order
+ *  bit is 1.
+ */
+const unsigned char gf_wrap = 0x87;
+
+/*
+ *  assumes: out != NULL and points to a GF(2^n) value to receive the
+ *            doubled value;
+ *           in != NULL and points to a 16 byte GF(2^n) value
+ *            to double;
+ *           the in and out buffers do not overlap.
+ *  effects: doubles the GF(2^n) value pointed to by "in" and places
+ *           the result in the GF(2^n) value pointed to by "out."
+ */
+void gf_double(uint8_t *out, uint8_t *in)
+{
+	/* start with low order byte */
+	uint8_t *x = in + (AES_BLOCK_SIZE - 1);
+
+	/* if msb == 1, we need to add the gf_wrap value, otherwise add 0 */
+	uint8_t carry = (in[0] >> 7) ? gf_wrap : 0;
+
+	out += (AES_BLOCK_SIZE - 1);
+	for (;;) {
+		*out-- = (*x << 1) ^ carry;
+		if (x == in)
+			break;
+		carry = *x-- >> 7;
+	}
+}
+
+/**
+ * tc_cmac_setup - configures the CMAC state to use the given AES key
+ *
+ * @s: the state to set up
+ * @key: the key to use:w
+ * @ctx: AES context
+ */
+void tc_cmac_setup(struct tc_cmac_struct *s, const uint8_t *key,
+		   struct crypto_aes_ctx *ctx)
+{
+	/* put s into a known state */
+	tc_cmac_erase(s);
+	s->ctx = ctx;
+
+	/* configure the encryption key used by the underlying block cipher */
+	aesni_set_key(ctx, key, AES_KEYSIZE_128);
+
+	/* compute s->K1 and s->K2 from s->iv using s->keyid */
+	memset(s->iv, 0, AES_BLOCK_SIZE);
+	aesni_enc(ctx, s->iv, s->iv);
+
+	gf_double (s->K1, s->iv);
+	gf_double (s->K2, s->K1);
+
+	/* reset s->iv to 0 in case someone wants to compute now */
+	tc_cmac_init(s);
+}
+
+/**
+ * tc_cmac_erase - erases the CMAC state
+ *
+ * @s:	the state to erase
+ */
+void tc_cmac_erase(struct tc_cmac_struct *s)
+{
+	memset(s, 0, sizeof(*s));
+}
+
+/**
+ * tc_cmac_init - initializes a new CMAC computation
+ *
+ * @s:	the state to initialize
+ */
+void tc_cmac_init(struct tc_cmac_struct *s)
+{
+	/* CMAC starts with an all zero initialization vector */
+	memset(s->iv, 0, AES_BLOCK_SIZE);
+
+	/* and the leftover buffer is empty */
+	memset(s->leftover, 0, AES_BLOCK_SIZE);
+	s->leftover_offset = 0;
+
+	/* Set countdown to max number of calls allowed before re-keying: */
+	s->countdown = MAX_CALLS;
+}
+
+/**
+ * tc_cmac_update - incrementally computes CMAC over the next data segment
+ *
+ * s:		the CMAC state
+ * data:	the next data segment to MAC
+ * dlen:	the length of data in bytes
+ */
+void tc_cmac_update(struct tc_cmac_struct *s, const uint8_t *data, size_t dlen)
+{
+	uint32_t i;
+
+	s->countdown--;
+
+	if (s->leftover_offset > 0) {
+		/* last data added to s didn't end on a AES_BLOCK_SIZE byte
+		 * boundary
+		 */
+		size_t remaining_space = AES_BLOCK_SIZE - s->leftover_offset;
+
+		if (dlen < remaining_space) {
+			/* still not enough data to encrypt this time either */
+			memcpy(&s->leftover[s->leftover_offset], data,
+			       dlen);
+			s->leftover_offset += dlen;
+			return;
+		}
+		/* leftover block is now full; encrypt it first */
+		memcpy(&s->leftover[s->leftover_offset], data, remaining_space);
+		dlen -= remaining_space;
+		data += remaining_space;
+		s->leftover_offset = 0;
+
+		for (i = 0; i < AES_BLOCK_SIZE; ++i)
+			s->iv[i] ^= s->leftover[i];
+
+		aesni_enc(s->ctx, s->iv, s->iv);
+	}
+
+	/* CBC encrypt each (except the last) of the data blocks */
+	while (dlen > AES_BLOCK_SIZE) {
+		for (i = 0; i < AES_BLOCK_SIZE; ++i)
+			s->iv[i] ^= data[i];
+		aesni_enc(s->ctx, s->iv, s->iv);
+		data += AES_BLOCK_SIZE;
+		dlen  -= AES_BLOCK_SIZE;
+	}
+
+	if (dlen > 0) {
+		/* save leftover data for next time */
+		memcpy(s->leftover, data, dlen);
+		s->leftover_offset = dlen;
+	}
+}
+
+/**
+ * tc_cmac_final - generates the tag from the CMAC state
+ *
+ * @tag:	the CMAC tag
+ * @s:		CMAC state
+ */
+void tc_cmac_final(uint8_t *tag, struct tc_cmac_struct *s)
+{
+	uint8_t *k;
+	uint32_t i;
+
+	if (s->leftover_offset == AES_BLOCK_SIZE) {
+		/* the last message block is a full-sized block */
+		k = (uint8_t *) s->K1;
+	} else {
+		/* the final message block is not a full-sized  block */
+		size_t remaining = AES_BLOCK_SIZE - s->leftover_offset;
+
+		memset(&s->leftover[s->leftover_offset], 0, remaining);
+		s->leftover[s->leftover_offset] = TC_CMAC_PADDING;
+		k = (uint8_t *) s->K2;
+	}
+	for (i = 0; i < AES_BLOCK_SIZE; ++i)
+		s->iv[i] ^= s->leftover[i] ^ k[i];
+
+	aesni_enc(s->ctx, tag, s->iv);
+
+	/* erasing state: */
+	tc_cmac_erase(s);
+}
diff --git a/drivers/platform/x86/intel_sgx/le/enclave/cmac_mode.h b/drivers/platform/x86/intel_sgx/le/enclave/cmac_mode.h
new file mode 100644
index 000000000000..18c9223bbd4f
--- /dev/null
+++ b/drivers/platform/x86/intel_sgx/le/enclave/cmac_mode.h
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// Copyright(c) 2016-17 Intel Corporation.
+//
+// Derived from TinyCrypt CMAC implementation.
+//
+// Authors:
+//
+// Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
+
+#ifndef CMAC_MODE_H
+#define CMAC_MODE_H
+
+#include <stddef.h>
+#include <crypto/aes.h>
+
+/* padding for last message block */
+#define TC_CMAC_PADDING 0x80
+
+/* struct tc_cmac_struct represents the state of a CMAC computation */
+struct tc_cmac_struct {
+	/* initialization vector */
+	uint8_t iv[AES_BLOCK_SIZE];
+	/* used if message length is a multiple of block_size bytes */
+	uint8_t K1[AES_BLOCK_SIZE];
+	/* used if message length isn't a multiple block_size bytes */
+	uint8_t K2[AES_BLOCK_SIZE];
+	/* where to put bytes that didn't fill a block */
+	uint8_t leftover[AES_BLOCK_SIZE];
+	/* identifies the encryption key */
+	uint32_t keyid;
+	/* next available leftover location */
+	uint32_t leftover_offset;
+	/* AES key schedule */
+	struct crypto_aes_ctx *ctx;
+	/* calls to tc_cmac_update left before re-key */
+	uint64_t countdown;
+};
+
+void tc_cmac_setup(struct tc_cmac_struct *s, const uint8_t *key,
+		   struct crypto_aes_ctx *ctx);
+
+void tc_cmac_erase(struct tc_cmac_struct *s);
+
+void tc_cmac_init(struct tc_cmac_struct *s);
+
+void tc_cmac_update(struct tc_cmac_struct *s, const uint8_t *data, size_t dlen);
+
+void tc_cmac_final(uint8_t *tag, struct tc_cmac_struct *s);
+
+asmlinkage int aesni_set_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
+			     unsigned int key_len);
+asmlinkage void aesni_enc(struct crypto_aes_ctx *ctx, u8 *out, const u8 *in);
+
+#endif /* CMAC_MODE_H */
diff --git a/drivers/platform/x86/intel_sgx/le/enclave/encl_bootstrap.S b/drivers/platform/x86/intel_sgx/le/enclave/encl_bootstrap.S
new file mode 100644
index 000000000000..603c4e167761
--- /dev/null
+++ b/drivers/platform/x86/intel_sgx/le/enclave/encl_bootstrap.S
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// Copyright(c) 2016-17 Intel Corporation.
+//
+// Authors:
+//
+// Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
+// Haim Cohen <haim.cohen@intel.com>
+// Sean Christopherson <sean.j.christopherson@intel.com>
+
+#include <sgx_asm.h>
+
+	.section ".tcs", "a"
+	.balign	4096
+
+	.fill	1, 8, 0			# STATE (set by CPU)
+	.fill	1, 8, 0			# FLAGS
+	.long	encl_ssa		# OSSA
+	.fill	1, 4, 0
+	.fill	1, 4, 0			# CSSA (set by CPU)
+	.fill	1, 4, 1			# NSSA
+	.long	encl_entry		# OENTRY
+	.fill	1, 4, 0
+	.fill	1, 8, 0			# AEP (set by EENTER and ERESUME)
+	.fill	1, 8, 0			# OFSBASE
+	.fill	1, 8, 0			# OGSBASE
+	.fill	1, 4, 0xFFFFFFFF 	# FSLIMIT
+	.fill	1, 4, 0xFFFFFFFF	# GSLIMIT
+	.fill	503, 8, 0		# Reserved
+
+	.text
+
+encl_entry:
+	# %rbx contains the base address for TCS, which is also the first
+	# address inside the enclave. By adding $le_stack_end to it, we get the
+	# absolute address for the stack.
+	lea	(encl_stack)(%rbx), %rax
+	xchg	%rsp, %rax
+	push	%rax
+
+	push	%rcx # push the address after EENTER
+	push	%rbx # push the enclave base address
+
+	call	encl_body
+
+	pop	%rbx # pop the enclave base address
+
+	# Restore XSAVE registers to a synthetic state.
+	mov     $0xFFFFFFFF, %rax
+	mov     $0xFFFFFFFF, %rdx
+	lea	(xsave_area)(%rbx), %rdi
+	fxrstor	(%rdi)
+
+	# Clear GPRs
+	xor     %rcx, %rcx
+	xor     %rdx, %rdx
+	xor     %rdi, %rdi
+	xor     %rsi, %rsi
+	xor     %r8, %r8
+	xor     %r9, %r9
+	xor     %r10, %r10
+	xor     %r11, %r11
+	xor     %r12, %r12
+	xor     %r13, %r13
+	xor     %r14, %r14
+	xor     %r15, %r15
+
+	# Reset status flags
+	add     %rdx, %rdx # OF = SF = AF = CF = 0; ZF = PF = 1
+
+	pop	%rbx # pop the address after EENTER
+
+	# Restore the caller stack.
+	pop	%rax
+	mov	%rax, %rsp
+
+	# EEXIT
+	mov	$4, %rax
+	enclu
+
+	.global sgx_ereport
+sgx_ereport:
+	push	%rbx
+	xor	%rax, %rax /* EREPORT */
+	mov	%rdi, %rbx  /* TARGETINFO */
+	mov	%rsi, %rcx /* REPORTDATA */
+	ENCLU
+	pop	%rbx
+	ret
+
+	.global sgx_egetkey
+sgx_egetkey:
+	push	%rbx
+	mov	$0x01, %rax /* EGETKEY */
+	mov	%rdi, %rbx /* KEYREQUEST */
+	mov	%rsi, %rcx  /* KEY */
+	ENCLU
+	pop	%rbx
+	ret
+
+	.section ".data", "aw"
+
+encl_ssa:
+	.space 4096
+
+xsave_area:
+	.fill	1, 4, 0x037F		# FCW
+	.fill	5, 4, 0
+	.fill	1, 4, 0x1F80		# MXCSR
+	.fill	1, 4, 0xFFFF		# MXCSR_MASK
+	.fill	123, 4, 0
+	.fill	1, 4, 0x80000000	# XCOMP_BV[63] = 1, compaction mode
+	.fill	12, 4, 0
+
+	.balign 4096
+	.space 8192
+encl_stack:
diff --git a/drivers/platform/x86/intel_sgx/le/enclave/main.c b/drivers/platform/x86/intel_sgx/le/enclave/main.c
new file mode 100644
index 000000000000..f03bdad4d3b6
--- /dev/null
+++ b/drivers/platform/x86/intel_sgx/le/enclave/main.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// Copyright(c) 2016-17 Intel Corporation.
+//
+// Derived from TinyCrypt CMAC implementation.
+//
+// Authors:
+//
+// Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
+
+#include <asm/sgx.h>
+#include <asm/sgx_arch.h>
+#include <linux/types.h>
+#include <uapi/asm/sgx.h>
+#include "cmac_mode.h"
+#include "main.h"
+
+static bool rdrand_uint32(uint32_t *value)
+{
+	int i;
+
+	for (i = 0; i < RAND_NR_TRIES; i++) {
+		if (__builtin_ia32_rdrand32_step((unsigned int *)value))
+			return true;
+	}
+
+	return false;
+}
+
+static bool sign_einittoken(struct sgx_einittoken *einittoken)
+{
+	struct sgx_keyrequest keyrequest __aligned(512);
+	uint8_t launch_key[16] __aligned(16);
+	struct tc_cmac_struct cmac_state;
+	struct crypto_aes_ctx ctx;
+	uint32_t *keyid_ptr;
+	int i;
+
+	memset(&ctx, 0, sizeof(ctx));
+
+	/* Despite its misleading name, the only purpose of the keyid field is
+	 * to add entropy to the token so that every token will have an unique
+	 * CMAC.
+	 */
+	keyid_ptr = (uint32_t *)einittoken->keyid;
+
+	for (i = 0; i < sizeof(einittoken->keyid) / 4; i++)
+		if (!rdrand_uint32(&keyid_ptr[i]))
+			return false;
+
+	memset(&keyrequest, 0, sizeof(keyrequest));
+	keyrequest.keyname = 0; /* LICENSE_KEY */
+	memcpy(&keyrequest.keyid, &einittoken->keyid, sizeof(keyrequest.keyid));
+	memcpy(&keyrequest.cpusvn, &(einittoken->cpusvnle),
+	       sizeof(keyrequest.cpusvn));
+	memcpy(&keyrequest.isvsvn, &(einittoken->isvsvnle),
+	       sizeof(keyrequest.isvsvn));
+
+	keyrequest.attributemask = ~SGX_ATTR_MODE64BIT;
+	keyrequest.xfrmmask = 0;
+	keyrequest.miscmask = 0xFFFFFFFF;
+
+	einittoken->maskedmiscselectle &= keyrequest.miscmask;
+	einittoken->maskedattributesle &= keyrequest.attributemask;
+	einittoken->maskedxfrmle &= keyrequest.xfrmmask;
+
+	if (sgx_egetkey(&keyrequest, launch_key))
+		return false;
+
+	tc_cmac_setup(&cmac_state, launch_key, &ctx);
+	tc_cmac_init(&cmac_state);
+	tc_cmac_update(&cmac_state, (const uint8_t *)&einittoken->payload,
+		       sizeof(einittoken->payload));
+	tc_cmac_final(einittoken->mac, &cmac_state);
+
+	memset(launch_key, 0, sizeof(launch_key));
+
+	return true;
+}
+
+static bool create_einittoken(uint8_t *mrenclave,
+			      uint8_t *mrsigner,
+			      uint64_t attributes,
+			      uint64_t xfrm,
+			      struct sgx_einittoken *einittoken)
+{
+
+	struct sgx_targetinfo tginfo __aligned(512);
+	struct sgx_report report __aligned(512);
+	uint8_t reportdata[64] __aligned(128);
+
+	if (attributes & SGX_ATTR_RESERVED_MASK)
+		return false;
+
+	memset(&tginfo, 0, sizeof(tginfo));
+	memset(reportdata, 0, sizeof(reportdata));
+	memset(&report, 0, sizeof(report));
+
+	if (sgx_ereport(&tginfo, reportdata, &report))
+		return false;
+
+	memset(einittoken, 0, sizeof(*einittoken));
+
+	einittoken->payload.valid = 1;
+
+	memcpy(einittoken->payload.mrenclave, mrenclave, 32);
+	memcpy(einittoken->payload.mrsigner, mrsigner, 32);
+	einittoken->payload.attributes = attributes;
+	einittoken->payload.xfrm = xfrm;
+
+	memcpy(&einittoken->cpusvnle, &report.cpusvn,
+		   sizeof(report.cpusvn));
+	einittoken->isvsvnle = report.isvsvn;
+	einittoken->isvprodidle = report.isvprodid;
+
+	einittoken->maskedattributesle = report.attributes;
+	einittoken->maskedxfrmle = report.xfrm;
+	einittoken->maskedmiscselectle = report.miscselect;
+
+	if (!sign_einittoken(einittoken))
+		return false;
+
+	return true;
+}
+
+void encl_body(struct sgx_launch_request *req, struct sgx_einittoken *token)
+{
+	struct sgx_einittoken tmp;
+	uint8_t mrenclave[32];
+	uint8_t mrsigner[32];
+	uint64_t attributes;
+	uint64_t xfrm;
+
+	if (!req)
+		return;
+
+	memcpy(mrenclave, req->mrenclave, sizeof(mrenclave));
+	memcpy(mrsigner, req->mrsigner, sizeof(mrsigner));
+	memcpy(&attributes, &req->attributes, sizeof(uint64_t));
+	memcpy(&xfrm, &req->xfrm, sizeof(uint64_t));
+	memset(&tmp, 0, sizeof(tmp));
+
+	if (!create_einittoken(mrenclave, mrsigner, attributes, xfrm, &tmp))
+		return;
+
+	memcpy(token, &tmp, sizeof(*token));
+}
diff --git a/drivers/platform/x86/intel_sgx/le/enclave/main.h b/drivers/platform/x86/intel_sgx/le/enclave/main.h
new file mode 100644
index 000000000000..2cec72242d0e
--- /dev/null
+++ b/drivers/platform/x86/intel_sgx/le/enclave/main.h
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// Copyright(c) 2016-17 Intel Corporation.
+//
+// Derived from TinyCrypt CMAC implementation.
+//
+// Authors:
+//
+// Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
+
+#ifndef MAIN_H
+#define MAIN_H
+
+#define RAND_NR_TRIES 10
+
+int sgx_ereport(const void *target_info, const void *report_data,
+		void *report);
+int sgx_egetkey(void *key_request, void *key);
+
+#endif /* MAIN_H */
diff --git a/drivers/platform/x86/intel_sgx/le/enclave/sgx_le.lds b/drivers/platform/x86/intel_sgx/le/enclave/sgx_le.lds
new file mode 100644
index 000000000000..4997628813b8
--- /dev/null
+++ b/drivers/platform/x86/intel_sgx/le/enclave/sgx_le.lds
@@ -0,0 +1,33 @@
+OUTPUT_FORMAT(elf64-x86-64)
+
+SECTIONS
+{
+	. = 0;
+	.tcs : {
+		*(.tcs*)
+	}
+
+	. = ALIGN(4096);
+	.text : {
+		*(.text*)
+		*(.rodata*)
+	}
+
+	. = ALIGN(4096);
+	.data : {
+		*(.data*)
+	}
+
+	/DISCARD/ : {
+		*(.data*)
+		*(.comment*)
+		*(.note*)
+		*(.debug*)
+		*(.eh_frame*)
+	}
+}
+
+ASSERT(!DEFINED(.altinstructions), "ALTERNATIVES are not supported in the SGX LE")
+ASSERT(!DEFINED(.altinstr_replacement), "ALTERNATIVES are not supported in the SGX LE")
+ASSERT(!DEFINED(.discard.retpoline_safe), "RETPOLINE ALTERNATIVES are not supported in the SGX LE")
+ASSERT(!DEFINED(.discard.nospec), "RETPOLINE ALTERNATIVES are not supported in the SGX LE")
diff --git a/drivers/platform/x86/intel_sgx/le/enclave/sgxsign.c b/drivers/platform/x86/intel_sgx/le/enclave/sgxsign.c
new file mode 100644
index 000000000000..abbb59195fd3
--- /dev/null
+++ b/drivers/platform/x86/intel_sgx/le/enclave/sgxsign.c
@@ -0,0 +1,551 @@
+/*
+ * This file is provided under a dual BSD/GPLv2 license.  When using or
+ * redistributing this file, you may do so under either license.
+ *
+ * GPL LICENSE SUMMARY
+ *
+ * Copyright(c) 2017 Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * Contact Information:
+ * Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
+ * Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
+ *
+ * BSD LICENSE
+ *
+ * Copyright(c) 2017 Intel Corporation.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ *
+ *   * Redistributions of source code must retain the above copyright
+ *     notice, this list of conditions and the following disclaimer.
+ *   * Redistributions in binary form must reproduce the above copyright
+ *     notice, this list of conditions and the following disclaimer in
+ *     the documentation and/or other materials provided with the
+ *     distribution.
+ *   * Neither the name of Intel Corporation nor the names of its
+ *     contributors may be used to endorse or promote products derived
+ *     from this software without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * Authors:
+ *
+ * Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
+ */
+
+#define _GNU_SOURCE
+#include <getopt.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <asm/sgx_arch.h>
+#include <openssl/err.h>
+#include <openssl/pem.h>
+
+static const char *sign_key_pass;
+
+static bool check_crypto_errors(void)
+{
+	int err;
+	bool had_errors = false;
+	const char *filename;
+	int line;
+	char str[256];
+
+	for ( ; ; ) {
+		if (ERR_peek_error() == 0)
+			break;
+
+		had_errors = true;
+		err = ERR_get_error_line(&filename, &line);
+		ERR_error_string_n(err, str, sizeof(str));
+		fprintf(stderr, "crypto: %s: %s:%d\n", str, filename, line);
+	}
+
+	return had_errors;
+}
+
+static void exit_usage(const char *program)
+{
+	fprintf(stderr,
+		"Usage: %s/sign-le <key> <enclave> <sigstruct>\n", program);
+	exit(1);
+}
+
+static int pem_passwd_cb(char *buf, int size, int rwflag, void *u)
+{
+	if (!sign_key_pass)
+		return -1;
+
+	strncpy(buf, sign_key_pass, size);
+	/* no retry */
+	sign_key_pass = NULL;
+
+	return strlen(buf) >= size ? size - 1 : strlen(buf);
+}
+
+static inline const BIGNUM *get_modulus(RSA *key)
+{
+#if OPENSSL_VERSION_NUMBER < 0x10100000L
+	return key->n;
+#else
+	const BIGNUM *n;
+
+	RSA_get0_key(key, &n, NULL, NULL);
+	return n;
+#endif
+}
+
+static RSA *load_sign_key(const char *path)
+{
+	FILE *f;
+	RSA *key;
+
+	f = fopen(path, "rb");
+	if (!f) {
+		fprintf(stderr, "Unable to open %s\n", path);
+		return NULL;
+	}
+	key = RSA_new();
+	if (!PEM_read_RSAPrivateKey(f, &key, pem_passwd_cb, NULL))
+		return NULL;
+	fclose(f);
+
+	if (BN_num_bytes(get_modulus(key)) != SGX_MODULUS_SIZE) {
+		fprintf(stderr, "Invalid key size %d\n",
+			BN_num_bytes(get_modulus(key)));
+		RSA_free(key);
+		return NULL;
+	}
+
+	return key;
+}
+
+static void reverse_bytes(void *data, int length)
+{
+	int i = 0;
+	int j = length - 1;
+	uint8_t temp;
+	uint8_t *ptr = data;
+
+	while (i < j) {
+		temp = ptr[i];
+		ptr[i] = ptr[j];
+		ptr[j] = temp;
+		i++;
+		j--;
+	}
+}
+
+enum mrtags {
+	MRECREATE = 0x0045544145524345,
+	MREADD = 0x0000000044444145,
+	MREEXTEND = 0x00444E4554584545,
+};
+
+static bool mrenclave_update(EVP_MD_CTX *ctx, const void *data)
+{
+	if (!EVP_DigestUpdate(ctx, data, 64)) {
+		fprintf(stderr, "digest update failed\n");
+		return false;
+	}
+
+	return true;
+}
+
+static bool mrenclave_commit(EVP_MD_CTX *ctx, uint8_t *mrenclave)
+{
+	unsigned int size;
+
+	if (!EVP_DigestFinal_ex(ctx, (unsigned char *)mrenclave, &size)) {
+		fprintf(stderr, "digest commit failed\n");
+		return false;
+	}
+
+	if (size != 32) {
+		fprintf(stderr, "invalid digest size = %u\n", size);
+		return false;
+	}
+
+	return true;
+}
+
+struct mrecreate {
+	uint64_t tag;
+	uint32_t ssaframesize;
+	uint64_t size;
+	uint8_t reserved[44];
+} __attribute__((__packed__));
+
+
+static bool mrenclave_ecreate(EVP_MD_CTX *ctx, uint64_t blob_size)
+{
+	struct mrecreate mrecreate;
+	uint64_t encl_size;
+
+	for (encl_size = 0x1000; encl_size < blob_size; )
+		encl_size <<= 1;
+
+	memset(&mrecreate, 0, sizeof(mrecreate));
+	mrecreate.tag = MRECREATE;
+	mrecreate.ssaframesize = 1;
+	mrecreate.size = encl_size;
+
+	if (!EVP_DigestInit_ex(ctx, EVP_sha256(), NULL))
+		return false;
+
+	return mrenclave_update(ctx, &mrecreate);
+}
+
+struct mreadd {
+	uint64_t tag;
+	uint64_t offset;
+	uint64_t flags; /* SECINFO flags */
+	uint8_t reserved[40];
+} __attribute__((__packed__));
+
+static bool mrenclave_eadd(EVP_MD_CTX *ctx, uint64_t offset, uint64_t flags)
+{
+	struct mreadd mreadd;
+
+	memset(&mreadd, 0, sizeof(mreadd));
+	mreadd.tag = MREADD;
+	mreadd.offset = offset;
+	mreadd.flags = flags;
+
+	return mrenclave_update(ctx, &mreadd);
+}
+
+struct mreextend {
+	uint64_t tag;
+	uint64_t offset;
+	uint8_t reserved[48];
+} __attribute__((__packed__));
+
+static bool mrenclave_eextend(EVP_MD_CTX *ctx, uint64_t offset, uint8_t *data)
+{
+	struct mreextend mreextend;
+	int i;
+
+	for (i = 0; i < 0x1000; i += 0x100) {
+		memset(&mreextend, 0, sizeof(mreextend));
+		mreextend.tag = MREEXTEND;
+		mreextend.offset = offset + i;
+
+		if (!mrenclave_update(ctx, &mreextend))
+			return false;
+
+		if (!mrenclave_update(ctx, &data[i + 0x00]))
+			return false;
+
+		if (!mrenclave_update(ctx, &data[i + 0x40]))
+			return false;
+
+		if (!mrenclave_update(ctx, &data[i + 0x80]))
+			return false;
+
+		if (!mrenclave_update(ctx, &data[i + 0xC0]))
+			return false;
+	}
+
+	return true;
+}
+
+/**
+ * measure_encl - measure enclave
+ * @path: path to the enclave
+ * @mrenclave: measurement
+ *
+ * Calculates MRENCLAVE. Assumes that the very first page is a TCS page and
+ * following pages are regular pages. Does not measure the contents of the
+ * enclave as the signing tool is used at the moment only for the launch
+ * enclave, which is pass-through (everything gets a token).
+ */
+static bool measure_encl(const char *path, uint8_t *mrenclave)
+{
+	FILE *file;
+	struct stat sb;
+	EVP_MD_CTX *ctx;
+	uint64_t flags;
+	uint64_t offset;
+	uint8_t data[0x1000];
+	int rc;
+
+	ctx = EVP_MD_CTX_create();
+	if (!ctx)
+		return false;
+
+	file = fopen(path, "rb");
+	if (!file) {
+		perror("fopen");
+		EVP_MD_CTX_destroy(ctx);
+		return false;
+	}
+
+	rc = stat(path, &sb);
+	if (rc) {
+		perror("stat");
+		goto out;
+	}
+
+	if (!sb.st_size || sb.st_size & 0xfff) {
+		fprintf(stderr, "Invalid blob size %lu\n", sb.st_size);
+		goto out;
+	}
+
+	if (!mrenclave_ecreate(ctx, sb.st_size))
+		goto out;
+
+	for (offset = 0; offset < sb.st_size; offset += 0x1000) {
+		if (!offset)
+			flags = SGX_SECINFO_TCS;
+		else
+			flags = SGX_SECINFO_REG | SGX_SECINFO_R |
+				SGX_SECINFO_W | SGX_SECINFO_X;
+
+		if (!mrenclave_eadd(ctx, offset, flags))
+			goto out;
+
+		rc = fread(data, 1, 0x1000, file);
+		if (!rc)
+			break;
+		if (rc < 0x1000)
+			goto out;
+
+		if (!mrenclave_eextend(ctx, offset, data))
+			goto out;
+	}
+
+	if (!mrenclave_commit(ctx, mrenclave))
+		goto out;
+
+	fclose(file);
+	EVP_MD_CTX_destroy(ctx);
+	return true;
+out:
+	fclose(file);
+	EVP_MD_CTX_destroy(ctx);
+	return false;
+}
+
+/**
+ * sign_encl - sign enclave
+ * @sigstruct: pointer to SIGSTRUCT
+ * @key: 3072-bit RSA key
+ * @signature: byte array for the signature
+ *
+ * Calculates EMSA-PKCSv1.5 signature for the given SIGSTRUCT. The result is
+ * stored in big-endian format so that it can be further passed to OpenSSL
+ * libcrypto functions.
+ */
+static bool sign_encl(const struct sgx_sigstruct *sigstruct, RSA *key,
+		      uint8_t *signature)
+{
+	struct sgx_sigstruct_payload payload;
+	unsigned int siglen;
+	uint8_t digest[SHA256_DIGEST_LENGTH];
+	bool ret;
+
+	memcpy(&payload.header, &sigstruct->header, sizeof(sigstruct->header));
+	memcpy(&payload.body, &sigstruct->body, sizeof(sigstruct->body));
+
+	SHA256((unsigned char *)&payload, sizeof(payload), digest);
+
+	ret = RSA_sign(NID_sha256, digest, SHA256_DIGEST_LENGTH, signature,
+		       &siglen, key);
+
+	return ret;
+}
+
+struct q1q2_ctx {
+	BN_CTX *bn_ctx;
+	BIGNUM *m;
+	BIGNUM *s;
+	BIGNUM *q1;
+	BIGNUM *qr;
+	BIGNUM *q2;
+};
+
+static void free_q1q2_ctx(struct q1q2_ctx *ctx)
+{
+	BN_CTX_free(ctx->bn_ctx);
+	BN_free(ctx->m);
+	BN_free(ctx->s);
+	BN_free(ctx->q1);
+	BN_free(ctx->qr);
+	BN_free(ctx->q2);
+}
+
+static bool alloc_q1q2_ctx(const uint8_t *s, const uint8_t *m,
+			   struct q1q2_ctx *ctx)
+{
+	ctx->bn_ctx = BN_CTX_new();
+	ctx->s = BN_bin2bn(s, SGX_MODULUS_SIZE, NULL);
+	ctx->m = BN_bin2bn(m, SGX_MODULUS_SIZE, NULL);
+	ctx->q1 = BN_new();
+	ctx->qr = BN_new();
+	ctx->q2 = BN_new();
+
+	if (!ctx->bn_ctx || !ctx->s || !ctx->m || !ctx->q1 || !ctx->qr ||
+	    !ctx->q2) {
+		free_q1q2_ctx(ctx);
+		return false;
+	}
+
+	return true;
+}
+
+static bool calc_q1q2(const uint8_t *s, const uint8_t *m, uint8_t *q1,
+		      uint8_t *q2)
+{
+	struct q1q2_ctx ctx;
+
+	if (!alloc_q1q2_ctx(s, m, &ctx)) {
+		fprintf(stderr, "Not enough memory for Q1Q2 calculation\n");
+		return false;
+	}
+
+	if (!BN_mul(ctx.q1, ctx.s, ctx.s, ctx.bn_ctx))
+		goto out;
+
+	if (!BN_div(ctx.q1, ctx.qr, ctx.q1, ctx.m, ctx.bn_ctx))
+		goto out;
+
+	if (BN_num_bytes(ctx.q1) > SGX_MODULUS_SIZE) {
+		fprintf(stderr, "Too large Q1 %d bytes\n",
+			BN_num_bytes(ctx.q1));
+		goto out;
+	}
+
+	if (!BN_mul(ctx.q2, ctx.s, ctx.qr, ctx.bn_ctx))
+		goto out;
+
+	if (!BN_div(ctx.q2, NULL, ctx.q2, ctx.m, ctx.bn_ctx))
+		goto out;
+
+	if (BN_num_bytes(ctx.q2) > SGX_MODULUS_SIZE) {
+		fprintf(stderr, "Too large Q2 %d bytes\n",
+			BN_num_bytes(ctx.q2));
+		goto out;
+	}
+
+	BN_bn2bin(ctx.q1, q1);
+	BN_bn2bin(ctx.q2, q2);
+
+	free_q1q2_ctx(&ctx);
+	return true;
+out:
+	free_q1q2_ctx(&ctx);
+	return false;
+}
+
+static bool save_sigstruct(const struct sgx_sigstruct *sigstruct,
+			   const char *path)
+{
+	FILE *f = fopen(path, "wb");
+
+	if (!f) {
+		fprintf(stderr, "Unable to open %s\n", path);
+		return false;
+	}
+
+	fwrite(sigstruct, sizeof(*sigstruct), 1, f);
+	fclose(f);
+	return true;
+}
+
+int main(int argc, char **argv)
+{
+	uint64_t header1[2] = {0x000000E100000006, 0x0000000000010000};
+	uint64_t header2[2] = {0x0000006000000101, 0x0000000100000060};
+	struct sgx_sigstruct ss;
+	const char *program;
+	int opt;
+	RSA *sign_key;
+
+	memset(&ss, 0, sizeof(ss));
+	ss.header.header1[0] = header1[0];
+	ss.header.header1[1] = header1[1];
+	ss.header.header2[0] = header2[0];
+	ss.header.header2[1] = header2[1];
+	ss.exponent = 3;
+	ss.body.attributes = SGX_ATTR_MODE64BIT | SGX_ATTR_EINITTOKENKEY;
+	ss.body.xfrm = 3,
+
+	sign_key_pass = getenv("KBUILD_SGX_SIGN_PIN");
+	program = argv[0];
+
+	do {
+		opt = getopt(argc, argv, "");
+		switch (opt) {
+		case -1:
+			break;
+		default:
+			exit_usage(program);
+		}
+	} while (opt != -1);
+
+	argc -= optind;
+	argv += optind;
+
+	if (argc < 3)
+		exit_usage(program);
+
+	/* sanity check only */
+	if (check_crypto_errors())
+		exit(1);
+
+	sign_key = load_sign_key(argv[0]);
+	if (!sign_key)
+		goto out;
+
+	BN_bn2bin(get_modulus(sign_key), ss.modulus);
+
+	if (!measure_encl(argv[1], ss.body.mrenclave))
+		goto out;
+
+	if (!sign_encl(&ss, sign_key, ss.signature))
+		goto out;
+
+	if (!calc_q1q2(ss.signature, ss.modulus, ss.q1, ss.q2))
+		goto out;
+
+	/* convert to little endian */
+	reverse_bytes(ss.signature, SGX_MODULUS_SIZE);
+	reverse_bytes(ss.modulus, SGX_MODULUS_SIZE);
+	reverse_bytes(ss.q1, SGX_MODULUS_SIZE);
+	reverse_bytes(ss.q2, SGX_MODULUS_SIZE);
+
+	if (!save_sigstruct(&ss, argv[2]))
+		goto out;
+	exit(0);
+out:
+	check_crypto_errors();
+	exit(1);
+}
diff --git a/drivers/platform/x86/intel_sgx/le/enclave/string.c b/drivers/platform/x86/intel_sgx/le/enclave/string.c
new file mode 120000
index 000000000000..5ea3579f0ec6
--- /dev/null
+++ b/drivers/platform/x86/intel_sgx/le/enclave/string.c
@@ -0,0 +1 @@
+../string.c
\ No newline at end of file
diff --git a/drivers/platform/x86/intel_sgx/le/entry.S b/drivers/platform/x86/intel_sgx/le/entry.S
new file mode 100644
index 000000000000..5edab50815a2
--- /dev/null
+++ b/drivers/platform/x86/intel_sgx/le/entry.S
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// Copyright(c) 2016-17 Intel Corporation.
+//
+// Authors:
+//
+// Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
+
+#include <asm/sgx_le.h>
+#include <sgx_asm.h>
+
+	.text
+
+	.global sgx_get_token
+sgx_get_token:
+	push	%rbx
+	mov	$0x02, %rax
+	mov	%rsi, %rbx
+	mov	%rdx, %rsi
+	mov	$sgx_async_exit, %rcx
+sgx_async_exit:
+	ENCLU
+	pop	%rbx
+	ret
+
+	.global sgx_sys_read
+sgx_sys_read:
+	mov	$0, %rax
+	mov	%rsi, %rdx /* buf */
+	mov	%rdi, %rsi /* count */
+	mov	$SGX_LE_PIPE_FD, %rdi
+	syscall
+	ret
+
+	.global sgx_sys_write
+sgx_sys_write:
+	mov	$1, %rax
+	mov	%rsi, %rdx /* buf */
+	mov	%rdi, %rsi /* count */
+	mov	$SGX_LE_PIPE_FD, %rdi
+	syscall
+	ret
+
+	.global sgx_sys_close
+sgx_sys_close:
+	mov	$3, %rax
+	syscall
+	ret
+
+	.global sgx_sys_mmap
+sgx_sys_mmap:
+	mov	$9, %rax
+	mov	%rdi, %r8 /* fd */
+	xor	%rdi, %rdi /* any address */
+
+	mov	$0x07, %rdx /* rwx */
+	mov	$0x01, %r10 /* shared */
+	mov	$0x00, %r9 /* offset */
+	syscall
+	ret
+
+	.global sgx_sys_ioctl
+sgx_sys_ioctl:
+	mov	$16, %rax
+	syscall
+	ret
+
+	.global sgx_sys_exit
+sgx_sys_exit:
+	mov	$60, %rax
+	syscall
diff --git a/drivers/platform/x86/intel_sgx/le/include/sgx_asm.h b/drivers/platform/x86/intel_sgx/le/include/sgx_asm.h
new file mode 100644
index 000000000000..9d32884846fd
--- /dev/null
+++ b/drivers/platform/x86/intel_sgx/le/include/sgx_asm.h
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// Copyright(c) 2016-17 Intel Corporation.
+//
+// Authors:
+//
+// Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
+
+#ifndef SGX_ASM_H
+#define SGX_ASM_H
+
+.macro ENCLU
+.byte 0x0f, 0x01, 0xd7
+.endm
+
+#endif /* SGX_ASM_H */
diff --git a/drivers/platform/x86/intel_sgx/le/main.c b/drivers/platform/x86/intel_sgx/le/main.c
new file mode 100644
index 000000000000..2e2b544b5305
--- /dev/null
+++ b/drivers/platform/x86/intel_sgx/le/main.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// Copyright(c) 2016-17 Intel Corporation.
+//
+// Authors:
+//
+// Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
+
+#include <asm/sgx.h>
+#include <asm/sgx_arch.h>
+#include <asm/sgx_le.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <uapi/asm/sgx.h>
+#include "main.h"
+
+static void *start_launch_enclave(void)
+{
+	struct sgx_enclave_create create_ioc;
+	struct sgx_enclave_add_page add_ioc;
+	struct sgx_enclave_init init_ioc;
+	struct sgx_secs secs;
+	struct sgx_secinfo secinfo;
+	unsigned long blob_base;
+	unsigned long blob_size;
+	unsigned long offset;
+	int rc;
+
+	memset(&secs, 0, sizeof(secs));
+	memset(&secinfo, 0, sizeof(secinfo));
+
+	secs.ssaframesize = 1;
+	secs.attributes = SGX_ATTR_MODE64BIT | SGX_ATTR_EINITTOKENKEY;
+	secs.xfrm = 3;
+
+	blob_base = (unsigned long)&sgx_le_blob;
+	blob_size = (unsigned long)&sgx_le_blob_end - blob_base;
+
+	for (secs.size = 4096; secs.size < blob_size; )
+		secs.size <<= 1;
+
+	secs.base = (unsigned long)sgx_sys_mmap(SGX_LE_DEV_FD, secs.size);
+	if (secs.base == (unsigned long)MAP_FAILED)
+		goto out;
+
+	create_ioc.src = (unsigned long)&secs;
+	rc = sgx_sys_ioctl(SGX_LE_DEV_FD, SGX_IOC_ENCLAVE_CREATE, &create_ioc);
+	if (rc)
+		goto out;
+
+	add_ioc.secinfo = (unsigned long)&secinfo;
+	add_ioc.mrmask = 0xFFFF;
+
+	for (offset = 0; offset < blob_size; offset += 0x1000) {
+		if (!offset)
+			secinfo.flags = SGX_SECINFO_TCS;
+		else
+			secinfo.flags = SGX_SECINFO_REG | SGX_SECINFO_R |
+					SGX_SECINFO_W | SGX_SECINFO_X;
+
+		add_ioc.addr = secs.base + offset;
+		add_ioc.src = blob_base + offset;
+
+		rc = sgx_sys_ioctl(SGX_LE_DEV_FD, SGX_IOC_ENCLAVE_ADD_PAGE,
+				   &add_ioc);
+		if (rc)
+			goto out;
+	}
+
+	init_ioc.addr = secs.base;
+	init_ioc.sigstruct = (uint64_t)&sgx_le_ss;
+	rc = sgx_sys_ioctl(SGX_LE_DEV_FD, SGX_IOC_ENCLAVE_INIT, &init_ioc);
+	if (rc)
+		goto out;
+
+	return (void *)secs.base;
+out:
+	return NULL;
+}
+
+static int read_input(void *data, unsigned int len)
+{
+	uint8_t *ptr = (uint8_t *)data;
+	long i;
+	long ret;
+
+	for (i = 0; i < len; ) {
+		ret = sgx_sys_read(&ptr[i], len - i);
+		if (ret < 0)
+			return ret;
+
+		i += ret;
+	}
+
+	return 0;
+}
+
+static int write_token(const struct sgx_einittoken *token)
+{
+	const uint8_t *ptr = (const uint8_t *)token;
+	long i;
+	long ret;
+
+	for (i = 0; i < sizeof(*token); ) {
+		ret = sgx_sys_write(&ptr[i], sizeof(*token) - i);
+		if (ret < 0)
+			return ret;
+
+		i += ret;
+	}
+
+	return 0;
+}
+
+void _start(void)
+{
+	struct sgx_launch_request req;
+	struct sgx_einittoken token;
+	void *entry;
+
+	sgx_sys_close(SGX_LE_EXE_FD);
+	entry = start_launch_enclave();
+	sgx_sys_close(SGX_LE_DEV_FD);
+	if (!entry)
+		sgx_sys_exit(1);
+
+	for ( ; ; ) {
+		memset(&req, 0, sizeof(req));
+		memset(&token, 0, sizeof(token));
+
+		if (read_input(&req, sizeof(req)))
+			sgx_sys_exit(1);
+
+		sgx_get_token(&req, entry, &token);
+
+		if (write_token(&token))
+			sgx_sys_exit(1);
+	}
+
+	__builtin_unreachable();
+}
diff --git a/drivers/platform/x86/intel_sgx/le/main.h b/drivers/platform/x86/intel_sgx/le/main.h
new file mode 100644
index 000000000000..7069d416d773
--- /dev/null
+++ b/drivers/platform/x86/intel_sgx/le/main.h
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// Copyright(c) 2016-17 Intel Corporation.
+//
+// Authors:
+//
+// Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
+
+#ifndef MAIN_H
+#define MAIN_H
+
+#ifndef NULL
+#define NULL ((void *)0)
+#endif
+
+#define MAP_FAILED ((void *)-1)
+
+extern unsigned char sgx_le_blob[];
+extern unsigned char sgx_le_blob_end[];
+extern unsigned char sgx_le_ss[];
+
+void sgx_get_token(struct sgx_launch_request *req, void *entry,
+		   struct sgx_einittoken *token);
+long sgx_sys_read(void *buf, unsigned long count);
+long sgx_sys_write(const void *buf, unsigned long count);
+long sgx_sys_close(long fd);
+long sgx_sys_mmap(long fd, unsigned long size);
+long sgx_sys_ioctl(long fd, unsigned long cmd, void *arg);
+long sgx_sys_exit(long status);
+
+#endif /* MAIN_H */
diff --git a/drivers/platform/x86/intel_sgx/le/sgx_le_piggy.S b/drivers/platform/x86/intel_sgx/le/sgx_le_piggy.S
new file mode 100644
index 000000000000..e1881066f089
--- /dev/null
+++ b/drivers/platform/x86/intel_sgx/le/sgx_le_piggy.S
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// Copyright(c) 2016-17 Intel Corporation.
+//
+// Authors:
+//
+// Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
+
+#include <linux/linkage.h>
+#include <asm/page_types.h>
+
+	.section ".rodata","a"
+	.balign PAGE_SIZE
+
+GLOBAL(sgx_le_blob)
+	.incbin	"drivers/platform/x86/intel_sgx/le/enclave/sgx_le.bin"
+END(sgx_le_blob)
+
+GLOBAL(sgx_le_blob_end);
+
+GLOBAL(sgx_le_ss)
+	.incbin	"drivers/platform/x86/intel_sgx/le/enclave/sgx_le.ss"
+END(sgx_le_ss)
diff --git a/drivers/platform/x86/intel_sgx/le/string.c b/drivers/platform/x86/intel_sgx/le/string.c
new file mode 100644
index 000000000000..0a61977f8628
--- /dev/null
+++ b/drivers/platform/x86/intel_sgx/le/string.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// Copyright(c) 2016-17 Intel Corporation.
+//
+// Authors:
+//
+// Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
+
+#include <linux/types.h>
+
+/* This might look a bit ugly but is needed because of the way asm/string_64.h
+ * redefines the symbols depending on the CONFIG_KASAN flag.
+ */
+#ifdef CONFIG_KASAN
+void *__memset(void *s, int c, size_t n)
+#else
+void *memset(void *s, int c, size_t n)
+#endif
+{
+	unsigned long i;
+
+	for (i = 0; i < n; i++)
+		((unsigned char *)s)[i] = c;
+
+	return s;
+}
+
+#ifdef CONFIG_KASAN
+void *__memcpy(void *dest, const void *src, size_t n)
+#else
+void *memcpy(void *dest, const void *src, size_t n)
+#endif
+{
+	size_t i;
+
+	for (i = 0; i < n; i++)
+		((char *)dest)[i] = ((char *)src)[i];
+
+	return dest;
+}
diff --git a/drivers/platform/x86/intel_sgx/sgx.h b/drivers/platform/x86/intel_sgx/sgx.h
index 193f5e5b2338..9b9e9d7d09dd 100644
--- a/drivers/platform/x86/intel_sgx/sgx.h
+++ b/drivers/platform/x86/intel_sgx/sgx.h
@@ -103,13 +103,18 @@ struct sgx_encl {
 	struct mmu_notifier mmu_notifier;
 };
 
+extern unsigned char sgx_le_proxy[];
+extern unsigned char sgx_le_proxy_end[];
+extern struct sgx_sigstruct sgx_le_ss;
 extern struct workqueue_struct *sgx_add_page_wq;
 extern u64 sgx_encl_size_max_32;
 extern u64 sgx_encl_size_max_64;
 extern u64 sgx_xfrm_mask;
 extern u32 sgx_misc_reserved;
 extern u32 sgx_xsave_size_tbl[64];
+extern u64 sgx_le_pubkeyhash[4];
 
+extern const struct file_operations sgx_fops;
 extern const struct vm_operations_struct sgx_vm_ops;
 
 int sgx_encl_find(struct mm_struct *mm, unsigned long addr,
@@ -161,4 +166,16 @@ unsigned int sgx_alloc_va_slot(struct sgx_va_page *va_page);
 void sgx_free_va_slot(struct sgx_va_page *va_page, unsigned int offset);
 bool sgx_va_page_full(struct sgx_va_page *va_page);
 
+extern struct sgx_le_ctx sgx_le_ctx;
+
+int sgx_get_key_hash(const void *modulus, void *hash);
+int sgx_le_init(struct sgx_le_ctx *ctx);
+void sgx_le_exit(struct sgx_le_ctx *ctx);
+void sgx_le_stop(struct sgx_le_ctx *ctx, bool update_users);
+int sgx_le_start(struct sgx_le_ctx *ctx);
+int sgx_le_get_token(struct sgx_le_ctx *ctx,
+		     const struct sgx_encl *encl,
+		     const struct sgx_sigstruct *sigstruct,
+		     struct sgx_einittoken *token);
+
 #endif /* __ARCH_X86_INTEL_SGX_H__ */
diff --git a/drivers/platform/x86/intel_sgx/sgx_encl.c b/drivers/platform/x86/intel_sgx/sgx_encl.c
index 35436497530b..043be4bb4829 100644
--- a/drivers/platform/x86/intel_sgx/sgx_encl.c
+++ b/drivers/platform/x86/intel_sgx/sgx_encl.c
@@ -774,20 +774,6 @@ int sgx_encl_add_page(struct sgx_encl *encl, unsigned long addr, void *data,
 	return ret;
 }
 
-static int sgx_einit(struct sgx_encl *encl, struct sgx_sigstruct *sigstruct,
-		     struct sgx_einittoken *token)
-{
-	struct sgx_epc_page *secs_epc = encl->secs.epc_page;
-	void *secs_va;
-	int ret;
-
-	secs_va = sgx_get_page(secs_epc);
-	ret = __einit(sigstruct, token, secs_va);
-	sgx_put_page(secs_va);
-
-	return ret;
-}
-
 /**
  * sgx_encl_init - perform EINIT for the given enclave
  *
@@ -821,8 +807,8 @@ int sgx_encl_init(struct sgx_encl *encl, struct sgx_sigstruct *sigstruct,
 
 	for (i = 0; i < SGX_EINIT_SLEEP_COUNT; i++) {
 		for (j = 0; j < SGX_EINIT_SPIN_COUNT; j++) {
-			ret = sgx_einit(encl, sigstruct, token);
-
+			ret = sgx_einit(sigstruct, token, encl->secs.epc_page,
+					sgx_le_pubkeyhash);
 			if (ret == SGX_UNMASKED_EVENT)
 				continue;
 			else
diff --git a/drivers/platform/x86/intel_sgx/sgx_ioctl.c b/drivers/platform/x86/intel_sgx/sgx_ioctl.c
index 68b04893d66a..44b7bc03c2e7 100644
--- a/drivers/platform/x86/intel_sgx/sgx_ioctl.c
+++ b/drivers/platform/x86/intel_sgx/sgx_ioctl.c
@@ -186,7 +186,9 @@ static long sgx_ioc_enclave_init(struct file *filep, unsigned int cmd,
 	if (ret)
 		goto out;
 
-	ret = sgx_encl_init(encl, sigstruct, einittoken);
+	ret = sgx_le_get_token(&sgx_le_ctx, encl, sigstruct, einittoken);
+	if (!ret)
+		ret = sgx_encl_init(encl, sigstruct, einittoken);
 
 	kref_put(&encl->refcount, sgx_encl_release);
 
diff --git a/drivers/platform/x86/intel_sgx/sgx_le.c b/drivers/platform/x86/intel_sgx/sgx_le.c
new file mode 100644
index 000000000000..ffd0fce07614
--- /dev/null
+++ b/drivers/platform/x86/intel_sgx/sgx_le.c
@@ -0,0 +1,303 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// Copyright(c) 2016-17 Intel Corporation.
+//
+// Authors:
+//
+// Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
+
+#include <asm/sgx_le.h>
+#include <linux/anon_inodes.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/kmod.h>
+#include <linux/mutex.h>
+#include <linux/sched/signal.h>
+#include <linux/shmem_fs.h>
+#include <linux/wait.h>
+#include "sgx.h"
+
+struct sgx_le_ctx {
+	struct pid *tgid;
+	char *argv[2];
+	struct crypto_shash *tfm;
+	struct mutex hash_lock;
+	struct mutex launch_lock;
+	struct rw_semaphore users;
+	wait_queue_head_t wq;
+	bool kernel_read;
+	bool user_read;
+	struct file *pipe;
+	struct sgx_launch_request req;
+	struct sgx_einittoken token;
+};
+
+struct sgx_le_ctx sgx_le_ctx;
+
+static int __sgx_get_key_hash(struct crypto_shash *tfm, const void *modulus,
+			      void *hash)
+{
+	SHASH_DESC_ON_STACK(shash, tfm);
+
+	shash->tfm = tfm;
+	shash->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
+
+	return crypto_shash_digest(shash, modulus, SGX_MODULUS_SIZE, hash);
+}
+
+/**
+ * sgx_get_key_hash - calculate SHA256 for a given RSA key
+ * @modulus:	modulus of the key
+ * @hash:	the resulting hash
+ */
+int sgx_get_key_hash(const void *modulus, void *hash)
+{
+	struct crypto_shash *tfm;
+	int ret;
+
+	tfm = crypto_alloc_shash("sha256", 0, CRYPTO_ALG_ASYNC);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+
+	ret = __sgx_get_key_hash(tfm, modulus, hash);
+
+	crypto_free_shash(tfm);
+	return ret;
+}
+
+static ssize_t sgx_le_ctx_fops_read(struct file *filp, char __user *buf,
+				    size_t count, loff_t *off)
+{
+	struct sgx_le_ctx *ctx = filp->private_data;
+	int ret;
+
+	if (count != sizeof(ctx->req)) {
+		pr_crit("%s: invalid count %lu\n", __func__, count);
+		return -EIO;
+	}
+
+	ret = wait_event_interruptible(ctx->wq, ctx->user_read);
+	if (ret)
+		return -EINTR;
+
+	ret = copy_to_user(buf, &ctx->req, count);
+	ctx->user_read = false;
+
+	return ret ? ret : count;
+}
+
+static ssize_t sgx_le_ctx_fops_write(struct file *filp, const char __user *buf,
+				     size_t count, loff_t *off)
+{
+	struct sgx_le_ctx *ctx = filp->private_data;
+	int ret;
+
+	if (count != sizeof(ctx->token)) {
+		pr_crit("%s: invalid count %lu\n", __func__, count);
+		return -EIO;
+	}
+
+	ret = copy_from_user(&ctx->token, buf, count);
+	if (!ret)
+		ctx->kernel_read = true;
+	wake_up_interruptible(&ctx->wq);
+
+	return ret ? ret : count;
+}
+
+static const struct file_operations sgx_le_ctx_fops = {
+	.owner = THIS_MODULE,
+	.llseek = no_llseek,
+	.read = sgx_le_ctx_fops_read,
+	.write = sgx_le_ctx_fops_write,
+};
+
+static int sgx_le_task_init(struct subprocess_info *subinfo, struct cred *new)
+{
+	struct sgx_le_ctx *ctx = (struct sgx_le_ctx *)subinfo->data;
+	struct file *tmp_filp;
+	unsigned long len;
+	loff_t pos = 0;
+	int ret;
+
+	len = (unsigned long)&sgx_le_proxy_end - (unsigned long)&sgx_le_proxy;
+
+	tmp_filp = shmem_file_setup("[sgx_le_proxy]", len, 0);
+	if (IS_ERR(tmp_filp)) {
+		ret = PTR_ERR(tmp_filp);
+		return ret;
+	}
+	fd_install(SGX_LE_EXE_FD, tmp_filp);
+
+	ret = kernel_write(tmp_filp, &sgx_le_proxy, len, &pos);
+	if (ret != len && ret >= 0)
+		return -ENOMEM;
+	if (ret < 0)
+		return ret;
+
+	tmp_filp = anon_inode_getfile("[/dev/sgx]", &sgx_fops, NULL, O_RDWR);
+	if (IS_ERR(tmp_filp))
+		return PTR_ERR(tmp_filp);
+	fd_install(SGX_LE_DEV_FD, tmp_filp);
+
+	tmp_filp = anon_inode_getfile("[sgx_le]", &sgx_le_ctx_fops, ctx,
+				      O_RDWR);
+	if (IS_ERR(tmp_filp))
+		return PTR_ERR(tmp_filp);
+	fd_install(SGX_LE_PIPE_FD, tmp_filp);
+
+	ctx->tgid = get_pid(task_tgid(current));
+	ctx->pipe = tmp_filp;
+
+	return 0;
+}
+
+static void __sgx_le_stop(struct sgx_le_ctx *ctx)
+{
+	if (ctx->tgid) {
+		fput(ctx->pipe);
+		kill_pid(ctx->tgid, SIGKILL, 1);
+		put_pid(ctx->tgid);
+		ctx->tgid = NULL;
+	}
+}
+
+void sgx_le_stop(struct sgx_le_ctx *ctx, bool update_users)
+{
+	if (update_users) {
+		up_read(&ctx->users);
+		if (!down_write_trylock(&ctx->users))
+			return;
+	}
+
+	mutex_lock(&ctx->launch_lock);
+	__sgx_le_stop(ctx);
+	mutex_unlock(&ctx->launch_lock);
+
+	if (update_users)
+		up_write(&ctx->users);
+}
+
+static int __sgx_le_start(struct sgx_le_ctx *ctx)
+{
+	struct subprocess_info *subinfo;
+	int ret;
+
+	if (ctx->tgid)
+		return 0;
+
+	ctx->argv[0] = SGX_LE_EXE_PATH;
+	ctx->argv[1] = NULL;
+
+	subinfo = call_usermodehelper_setup(ctx->argv[0], ctx->argv,
+					    NULL, GFP_KERNEL, sgx_le_task_init,
+					    NULL, &sgx_le_ctx);
+	if (!subinfo)
+		return -ENOMEM;
+
+	ret = call_usermodehelper_exec(subinfo, UMH_WAIT_EXEC);
+	if (ret) {
+		__sgx_le_stop(ctx);
+		return ret;
+	}
+
+	return 0;
+}
+
+int sgx_le_start(struct sgx_le_ctx *ctx)
+{
+	int ret;
+
+	down_read(&ctx->users);
+
+	mutex_lock(&ctx->launch_lock);
+	ret = __sgx_le_start(ctx);
+	mutex_unlock(&ctx->launch_lock);
+
+	if (ret)
+		up_read(&ctx->users);
+
+	return ret;
+}
+
+int sgx_le_init(struct sgx_le_ctx *ctx)
+{
+	struct crypto_shash *tfm;
+
+	tfm = crypto_alloc_shash("sha256", 0, CRYPTO_ALG_ASYNC);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+
+	ctx->tfm = tfm;
+	mutex_init(&ctx->hash_lock);
+	mutex_init(&ctx->launch_lock);
+	init_rwsem(&ctx->users);
+	init_waitqueue_head(&ctx->wq);
+
+	return 0;
+}
+
+void sgx_le_exit(struct sgx_le_ctx *ctx)
+{
+	mutex_lock(&ctx->launch_lock);
+	crypto_free_shash(ctx->tfm);
+	mutex_unlock(&ctx->launch_lock);
+}
+
+static int __sgx_le_get_token(struct sgx_le_ctx *ctx,
+			      const struct sgx_encl *encl,
+			      struct sgx_einittoken *token)
+{
+	ssize_t ret;
+
+	if (!ctx->tgid)
+		return -EIO;
+
+	ctx->user_read = true;
+	wake_up_interruptible(&ctx->wq);
+
+	ret = wait_event_interruptible(ctx->wq, ctx->kernel_read);
+	if (ret)
+		return -EINTR;
+
+	memcpy(token, &ctx->token, sizeof(*token));
+	ctx->kernel_read = false;
+
+	return 0;
+}
+
+int sgx_le_get_token(struct sgx_le_ctx *ctx,
+		     const struct sgx_encl *encl,
+		     const struct sgx_sigstruct *sigstruct,
+		     struct sgx_einittoken *token)
+{
+	u8 mrsigner[32];
+	int ret;
+
+	mutex_lock(&ctx->hash_lock);
+	ret = __sgx_get_key_hash(ctx->tfm, sigstruct->modulus, mrsigner);
+	if (ret) {
+		mutex_unlock(&ctx->hash_lock);
+		return ret;
+	}
+	if (!memcmp(mrsigner, sgx_le_pubkeyhash, 32)) {
+		token->payload.valid = false;
+		mutex_unlock(&ctx->hash_lock);
+		return 0;
+	}
+	mutex_unlock(&ctx->hash_lock);
+
+	mutex_lock(&ctx->launch_lock);
+	ret = __sgx_le_start(ctx);
+	if (ret) {
+		mutex_unlock(&ctx->launch_lock);
+		return ret;
+	}
+	memcpy(&ctx->req.mrenclave, sigstruct->body.mrenclave, 32);
+	memcpy(&ctx->req.mrsigner, mrsigner, 32);
+	ctx->req.attributes = encl->attributes;
+	ctx->req.xfrm = encl->xfrm;
+	memset(&ctx->token, 0, sizeof(ctx->token));
+	ret = __sgx_le_get_token(ctx, encl, token);
+	mutex_unlock(&ctx->launch_lock);
+	return ret;
+}
diff --git a/drivers/platform/x86/intel_sgx/sgx_le_proxy_piggy.S b/drivers/platform/x86/intel_sgx/sgx_le_proxy_piggy.S
new file mode 100644
index 000000000000..9d2057615d04
--- /dev/null
+++ b/drivers/platform/x86/intel_sgx/sgx_le_proxy_piggy.S
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// Copyright(c) 2016-17 Intel Corporation.
+//
+// Authors:
+//
+// Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
+
+#include <linux/linkage.h>
+#include <asm/export.h>
+#include <asm/page_types.h>
+
+	.section ".rodata","a"
+
+GLOBAL(sgx_le_proxy)
+	.incbin	"drivers/platform/x86/intel_sgx/le/sgx_le_proxy"
+END(sgx_le_proxy)
+
+GLOBAL(sgx_le_proxy_end)
+
+GLOBAL(sgx_le_ss)
+	.incbin	"drivers/platform/x86/intel_sgx/le/enclave/sgx_le.ss"
+END(sgx_le_ss)
diff --git a/drivers/platform/x86/intel_sgx/sgx_main.c b/drivers/platform/x86/intel_sgx/sgx_main.c
index 79d772847026..39560ee94b43 100644
--- a/drivers/platform/x86/intel_sgx/sgx_main.c
+++ b/drivers/platform/x86/intel_sgx/sgx_main.c
@@ -31,6 +31,31 @@ u64 sgx_encl_size_max_64;
 u64 sgx_xfrm_mask = 0x3;
 u32 sgx_misc_reserved;
 u32 sgx_xsave_size_tbl[64];
+u64 sgx_le_pubkeyhash[4];
+
+static DECLARE_RWSEM(sgx_file_sem);
+
+static int sgx_open(struct inode *inode, struct file *file)
+{
+	int ret;
+
+	ret = sgx_le_start(&sgx_le_ctx);
+
+	if (!ret)
+		file->private_data = &sgx_le_ctx;
+
+	return ret;
+}
+
+static int sgx_release(struct inode *inode, struct file *file)
+{
+	if (!file->private_data)
+		return 0;
+
+	sgx_le_stop(file->private_data, true);
+
+	return 0;
+}
 
 #ifdef CONFIG_COMPAT
 long sgx_compat_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
@@ -84,8 +109,10 @@ static unsigned long sgx_get_unmapped_area(struct file *file,
 	return addr;
 }
 
-static const struct file_operations sgx_fops = {
+const struct file_operations sgx_fops = {
 	.owner			= THIS_MODULE,
+	.open			= sgx_open,
+	.release		= sgx_release,
 	.unlocked_ioctl		= sgx_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl		= sgx_compat_ioctl,
@@ -100,6 +127,7 @@ static int sgx_pm_suspend(struct device *dev)
 	struct sgx_epc_page *epc_page;
 	struct sgx_encl *encl;
 
+	sgx_le_stop(&sgx_le_ctx, false);
 	list_for_each_entry(epc_page, &sgx_active_page_list, list) {
 		encl_page = container_of(epc_page->impl, struct sgx_encl_page,
 					 impl);
@@ -176,6 +204,34 @@ static struct sgx_context *sgxm_ctx_alloc(struct device *parent)
 	return ctx;
 }
 
+static int sgx_init_msrs(void)
+{
+	u64 msrs[4];
+	int ret;
+
+	ret = sgx_get_key_hash(sgx_le_ss.modulus, sgx_le_pubkeyhash);
+	if (ret)
+		return ret;
+
+	if (sgx_lc_enabled)
+		return 0;
+
+	rdmsrl(MSR_IA32_SGXLEPUBKEYHASH0, msrs[0]);
+	rdmsrl(MSR_IA32_SGXLEPUBKEYHASH1, msrs[1]);
+	rdmsrl(MSR_IA32_SGXLEPUBKEYHASH2, msrs[2]);
+	rdmsrl(MSR_IA32_SGXLEPUBKEYHASH3, msrs[3]);
+
+	if ((sgx_le_pubkeyhash[0] != msrs[0]) ||
+	    (sgx_le_pubkeyhash[1] != msrs[1]) ||
+	    (sgx_le_pubkeyhash[2] != msrs[2]) ||
+	    (sgx_le_pubkeyhash[3] != msrs[3])) {
+		pr_err("IA32_SGXLEPUBKEYHASHn MSRs do not match to the launch enclave signing key\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
 static int sgx_dev_init(struct device *parent)
 {
 	struct sgx_context *sgx_dev;
@@ -186,6 +242,10 @@ static int sgx_dev_init(struct device *parent)
 	int ret;
 	int i;
 
+	ret = sgx_init_msrs();
+	if (ret)
+		return ret;
+
 	sgx_dev = sgxm_ctx_alloc(parent);
 
 	cpuid_count(SGX_CPUID, SGX_CPUID_CAPABILITIES, &eax, &ebx, &ecx, &edx);
@@ -213,11 +273,17 @@ static int sgx_dev_init(struct device *parent)
 	if (!sgx_add_page_wq)
 		return -ENOMEM;
 
-	ret = cdev_device_add(&sgx_dev->cdev, &sgx_dev->dev);
+	ret = sgx_le_init(&sgx_le_ctx);
 	if (ret)
 		goto out_workqueue;
 
+	ret = cdev_device_add(&sgx_dev->cdev, &sgx_dev->dev);
+	if (ret)
+		goto out_le;
+
 	return 0;
+out_le:
+	sgx_le_exit(&sgx_le_ctx);
 out_workqueue:
 	destroy_workqueue(sgx_add_page_wq);
 	return ret;
@@ -236,6 +302,7 @@ static int sgx_drv_remove(struct platform_device *pdev)
 	struct sgx_context *ctx = dev_get_drvdata(&pdev->dev);
 
 	cdev_device_del(&ctx->cdev, &ctx->dev);
+	sgx_le_exit(&sgx_le_ctx);
 	destroy_workqueue(sgx_add_page_wq);
 
 	return 0;
-- 
2.17.0
