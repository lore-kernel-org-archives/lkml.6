Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751501AbeEAUzX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 16:55:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:58112 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751050AbeEAUzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 16:55:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,352,1520924400";
   d="scan'208";a="37644285"
Subject: [PATCH 3/6] x86, memcpy_mcsafe: add write-protection-fault handling
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com
Date: Tue, 01 May 2018 13:45:24 -0700
Message-ID: <152520752472.36522.6229986239583637697.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <152520750404.36522.15462513519590065300.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <152520750404.36522.15462513519590065300.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for using memcpy_mcsafe() to handle user copies it needs
to be to handle write-protection faults while writing user pages. Add
MMU-fault handlers alongside the machine-check exception handlers.

Note that the machine check fault exception handling makes assumptions
about source buffer alignment and poison alignment. In the write fault
case, given the destination buffer is arbitrarily aligned, it needs a
separate / additional fault handling approach. The mcsafe_handle_tail()
helper is reused. The @limit argument is set to @len since there is no
safety concern about retriggering an MMU fault, and this simplifies the
assembly.

Cc: <x86@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Co-developed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/lib/memcpy_64.S |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
index 97b772fcf62f..fc9c1f594c71 100644
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -345,6 +345,16 @@ EXPORT_SYMBOL_GPL(memcpy_mcsafe_unrolled)
 	mov	%ecx, %eax
 	ret
 
+.E_write_cache_X:
+	shll	$6, %ecx
+	jmp	.E_handle_tail
+.E_write_trailing_words:
+	shll	$3, %ecx
+.E_handle_tail:
+	addl	%edx, %ecx
+	movl	%ecx, %edx
+	jmp mcsafe_handle_tail
+
 	.previous
 
 	_ASM_EXTABLE_FAULT(.L_read_leading_bytes, .E_leading_bytes)
@@ -358,4 +368,15 @@ EXPORT_SYMBOL_GPL(memcpy_mcsafe_unrolled)
 	_ASM_EXTABLE_FAULT(.L_cache_r7, .E_cache_7)
 	_ASM_EXTABLE_FAULT(.L_read_trailing_words, .E_trailing_words)
 	_ASM_EXTABLE_FAULT(.L_read_trailing_bytes, .E_trailing_bytes)
+	_ASM_EXTABLE(.L_write_leading_bytes, .E_leading_bytes)
+	_ASM_EXTABLE(.L_cache_w0, .E_write_cache_X)
+	_ASM_EXTABLE(.L_cache_w1, .E_write_cache_X)
+	_ASM_EXTABLE(.L_cache_w2, .E_write_cache_X)
+	_ASM_EXTABLE(.L_cache_w3, .E_write_cache_X)
+	_ASM_EXTABLE(.L_cache_w4, .E_write_cache_X)
+	_ASM_EXTABLE(.L_cache_w5, .E_write_cache_X)
+	_ASM_EXTABLE(.L_cache_w6, .E_write_cache_X)
+	_ASM_EXTABLE(.L_cache_w7, .E_write_cache_X)
+	_ASM_EXTABLE(.L_write_trailing_words, .E_write_trailing_words)
+	_ASM_EXTABLE(.L_write_trailing_bytes, .E_trailing_bytes)
 #endif
