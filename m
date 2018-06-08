Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id TcNQFau6Glt0WAAAmS7hNA
	; Fri, 08 Jun 2018 17:20:40 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EF42F605A5; Fri,  8 Jun 2018 17:20:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6FDF0605A2;
	Fri,  8 Jun 2018 17:20:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6FDF0605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932163AbeFHRUi (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 13:20:38 -0400
Received: from mga18.intel.com ([134.134.136.126]:17113 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932130AbeFHRUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 13:20:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jun 2018 10:20:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,490,1520924400";
   d="scan'208";a="231035212"
Received: from nzou1-mobl1.ccr.corp.intel.com (HELO localhost) ([10.249.254.60])
  by orsmga005.jf.intel.com with ESMTP; 08 Jun 2018 10:20:27 -0700
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: x86@kernel.org, platform-driver-x86@vger.kernel.org
Cc: dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-crypto@vger.kernel.org (open list:CRYPTO API),
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH v11 06/13] crypto: aesni: add minimal build option for SGX LE
Date: Fri,  8 Jun 2018 19:09:41 +0200
Message-Id: <20180608171216.26521-7-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Allow building a minimal subset of the low-level AESNI functions by
defining AESNI_INTEL_MINIMAL.  The SGX Launch Enclave will utilize
a small number of AESNI functions for creating CMACs when generating
tokens for userspace enclaves.

Reducing the size of the LE is high priority as EPC space is at a
premium and initializing/measuring EPC pages is extremely slow, and
defining only the minimal set of AESNI functions reduces the size of
the in-kernel LE by over 50%.  Because the LE is a (very) non-standard
build environment, using linker tricks e.g. --gc-sections to remove
the unused functions is not an option.

Eliminating the unused AESNI functions also eliminates all usage of
the retpoline macros, e.g. CALL_NOSPEC, which allows the LE linker
script to assert that the alternatives and retpoline sections don't
exist in the final binary.  Because the LE's code cannot be patched,
i.e. retpoline can't be enabled via alternatives, we want to assert
that we're not expecting a security feature that can't be enabled.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/crypto/aesni-intel_asm.S | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index e762ef417562..5a0a487466d5 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -45,6 +45,8 @@
 #define MOVADQ	movaps
 #define MOVUDQ	movups
 
+#ifndef AESNI_INTEL_MINIMAL
+
 #ifdef __x86_64__
 
 # constants in mergeable sections, linker can reorder and merge
@@ -133,6 +135,8 @@ ALL_F:      .octa 0xffffffffffffffffffffffffffffffff
 #define keysize 2*15*16(%arg1)
 #endif
 
+#endif /* AESNI_INTEL_MINIMAL */
+
 
 #define STATE1	%xmm0
 #define STATE2	%xmm4
@@ -506,6 +510,8 @@ _T_16_\@:
 _return_T_done_\@:
 .endm
 
+#ifndef AESNI_INTEL_MINIMAL
+
 #ifdef __x86_64__
 /* GHASH_MUL MACRO to implement: Data*HashKey mod (128,127,126,121,0)
 *
@@ -1760,6 +1766,7 @@ ENDPROC(aesni_gcm_finalize)
 
 #endif
 
+#endif /* AESNI_INTEL_MINIMAL */
 
 .align 4
 _key_expansion_128:
@@ -2031,6 +2038,8 @@ _aesni_enc1:
 	ret
 ENDPROC(_aesni_enc1)
 
+#ifndef AESNI_INTEL_MINIMAL
+
 /*
  * _aesni_enc4:	internal ABI
  * input:
@@ -2840,3 +2849,5 @@ ENTRY(aesni_xts_crypt8)
 ENDPROC(aesni_xts_crypt8)
 
 #endif
+
+#endif /* AESNI_INTEL_MINIMAL */
-- 
2.17.0
