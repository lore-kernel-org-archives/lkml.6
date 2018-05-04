Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751484AbeEDAQ0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 20:16:26 -0400
Received: from mga04.intel.com ([192.55.52.120]:25618 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751445AbeEDAQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 20:16:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,360,1520924400";
   d="scan'208";a="38537640"
Subject: [PATCH v3 4/9] x86,
 memcpy_mcsafe: add write-protection-fault handling
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
        Mika =?utf-8?b?UGVudHRpbMOk?= <mika.penttila@nextfour.com>, hch@lst.de,
        linux-kernel@vger.kernel.org, tony.luck@intel.com,
        linux-fsdevel@vger.kernel.org
Date: Thu, 03 May 2018 17:06:26 -0700
Message-ID: <152539238635.31796.14056325365122961778.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <152539236455.31796.7516599166555186700.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <152539236455.31796.7516599166555186700.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Reported-by: Mika Penttilä <mika.penttila@nextfour.com>
Co-developed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/include/asm/uaccess_64.h |    3 +++
 arch/x86/lib/memcpy_64.S          |   14 ++++++++++++++
 arch/x86/lib/usercopy_64.c        |   21 +++++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index 62546b3a398e..c63efc07891f 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -194,4 +194,7 @@ __copy_from_user_flushcache(void *dst, const void __user *src, unsigned size)
 unsigned long
 copy_user_handle_tail(char *to, char *from, unsigned len);
 
+unsigned long
+mcsafe_handle_tail(char *to, char *from, unsigned len);
+
 #endif /* _ASM_X86_UACCESS_64_H */
diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
index f01a88391c98..c3b527a9f95d 100644
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -265,9 +265,23 @@ EXPORT_SYMBOL_GPL(__memcpy_mcsafe)
 	mov	%ecx, %eax
 	ret
 
+	/*
+	 * For write fault handling, given the destination is unaligned,
+	 * we handle faults on multi-byte writes with a byte-by-byte
+	 * copy up to the write-protected page.
+	 */
+.E_write_words:
+	shll	$3, %ecx
+	addl	%edx, %ecx
+	movl	%ecx, %edx
+	jmp mcsafe_handle_tail
+
 	.previous
 
 	_ASM_EXTABLE_FAULT(.L_read_leading_bytes, .E_leading_bytes)
 	_ASM_EXTABLE_FAULT(.L_read_words, .E_read_words)
 	_ASM_EXTABLE_FAULT(.L_read_trailing_bytes, .E_trailing_bytes)
+	_ASM_EXTABLE(.L_write_leading_bytes, .E_leading_bytes)
+	_ASM_EXTABLE(.L_write_words, .E_write_words)
+	_ASM_EXTABLE(.L_write_trailing_bytes, .E_trailing_bytes)
 #endif
diff --git a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
index 75d3776123cc..7ebc9901dd05 100644
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -75,6 +75,27 @@ copy_user_handle_tail(char *to, char *from, unsigned len)
 	return len;
 }
 
+/*
+ * Similar to copy_user_handle_tail, probe for the write fault point,
+ * but reuse __memcpy_mcsafe in case a new read error is encountered.
+ * clac() is handled in _copy_to_iter_mcsafe().
+ */
+__visible unsigned long
+mcsafe_handle_tail(char *to, char *from, unsigned len)
+{
+	for (; len; --len, to++, from++) {
+		/*
+		 * Call the assembly routine back directly since
+		 * memcpy_mcsafe() may silently fallback to memcpy.
+		 */
+		unsigned long rem = __memcpy_mcsafe(to, from, 1);
+
+		if (rem)
+			break;
+	}
+	return len;
+}
+
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
 /**
  * clean_cache_range - write back a cache range with CLWB
