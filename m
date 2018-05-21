Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrPCJxhEqFFdBD5VQC9wQ+9nlejc8BGfA0ldaknb2p22LXWDvvkvjqnRdcFutkhkRfMiH4Q
ARC-Seal: i=1; a=rsa-sha256; t=1526937373; cv=none;
        d=google.com; s=arc-20160816;
        b=Hi61HgoOlmxJ9F+R0x9E5nfWhVlYOl17DjkbjnaDmLm0x/MkuL4Qo4WeRlgBJ8Y7i/
         3c3CHMmeeUFSoKao8dfR+34fXOHLhPhXq54CGnVW/eNKIsCbbRY8eHrzSrPb66k9l9+d
         1acyI/eVet8f1ftEx7U6S4WccXKL4bRQXTo0VTuRlTqfeDIQQPh1xY4pvht7Myx+3n8S
         n8Tz0D0Vy38GQM9egYVoWpY9qfBo1StqWodjjdYdHt4vxTLYuZXVcKMUZI63iVJaA4Be
         duLjZbFN/UUzi74nGSMVL3Uz2WcCerZiRBkgzBvBrn34f0qloqcszGCICjk2n0zzMHX4
         7+Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=HmVeNk31dl2qgj0EV22QjYssl5Bu2iaFTSs1SfRBf6Y=;
        b=olgJLgCJSZc4qWKrDfgZ3Y7d99JTdVpaulfIe68wt7jdsSZ+JlansDJ7/Ox0D6GNKd
         aDWN5I5lcrGA0r/9+qT0WuYHdXjOQDtUPqwhZXuKoVdOB5hNeL4f14YrunTSek9QD8Sv
         HPNhobz5rHzxybKlloE14EeMrNlkbT9jC4VQv6HTHBZz6n/rCsauCry14OSiGa95jGBQ
         UAd7GXwZxkl4U25XNDTNOB6T5IZgG7lmnWtb6JTc0ExTKhAbGg1noaa19PR++C7Ov/qk
         xYdQYIe/ubYrbZg+rXgKTdR2/NncmzsRRbAa0XT4dGzCVvb0KKjRRNz0Y91Z95DrLisA
         ivHg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=0zo/rFM5;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=0zo/rFM5;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shakeel Butt <shakeelb@google.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Michael Ellermen <mpe@ellerman.id.au>,
	Peter Zijlstra <peterz@infradead.org>,
	Ram Pai <linuxram@us.ibm.com>,
	Shuah Khan <shuah@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-mm@kvack.org,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 24/87] x86/pkeys: Override pkey when moving away from PROT_EXEC
Date: Mon, 21 May 2018 23:11:00 +0200
Message-Id: <20180521210422.554987897@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109883753600221?=
X-GMAIL-MSGID: =?utf-8?q?1601109883753600221?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Hansen <dave.hansen@linux.intel.com>

commit 0a0b152083cfc44ec1bb599b57b7aab41327f998 upstream.

I got a bug report that the following code (roughly) was
causing a SIGSEGV:

	mprotect(ptr, size, PROT_EXEC);
	mprotect(ptr, size, PROT_NONE);
	mprotect(ptr, size, PROT_READ);
	*ptr = 100;

The problem is hit when the mprotect(PROT_EXEC)
is implicitly assigned a protection key to the VMA, and made
that key ACCESS_DENY|WRITE_DENY.  The PROT_NONE mprotect()
failed to remove the protection key, and the PROT_NONE->
PROT_READ left the PTE usable, but the pkey still in place
and left the memory inaccessible.

To fix this, we ensure that we always "override" the pkee
at mprotect() if the VMA does not have execute-only
permissions, but the VMA has the execute-only pkey.

We had a check for PROT_READ/WRITE, but it did not work
for PROT_NONE.  This entirely removes the PROT_* checks,
which ensures that PROT_NONE now works.

Reported-by: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Ellermen <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ram Pai <linuxram@us.ibm.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Cc: stable@vger.kernel.org
Fixes: 62b5f7d013f ("mm/core, x86/mm/pkeys: Add execute-only protection keys support")
Link: http://lkml.kernel.org/r/20180509171351.084C5A71@viggo.jf.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/pkeys.h |   12 +++++++++++-
 arch/x86/mm/pkeys.c          |   21 +++++++++++----------
 2 files changed, 22 insertions(+), 11 deletions(-)

--- a/arch/x86/include/asm/pkeys.h
+++ b/arch/x86/include/asm/pkeys.h
@@ -1,6 +1,8 @@
 #ifndef _ASM_X86_PKEYS_H
 #define _ASM_X86_PKEYS_H
 
+#define ARCH_DEFAULT_PKEY	0
+
 #define arch_max_pkey() (boot_cpu_has(X86_FEATURE_OSPKE) ? 16 : 1)
 
 extern int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
@@ -14,7 +16,7 @@ extern int __execute_only_pkey(struct mm
 static inline int execute_only_pkey(struct mm_struct *mm)
 {
 	if (!boot_cpu_has(X86_FEATURE_OSPKE))
-		return 0;
+		return ARCH_DEFAULT_PKEY;
 
 	return __execute_only_pkey(mm);
 }
@@ -55,6 +57,14 @@ bool mm_pkey_is_allocated(struct mm_stru
 		return false;
 	if (pkey >= arch_max_pkey())
 		return false;
+	/*
+	 * The exec-only pkey is set in the allocation map, but
+	 * is not available to any of the user interfaces like
+	 * mprotect_pkey().
+	 */
+	if (pkey == mm->context.execute_only_pkey)
+		return false;
+
 	return mm_pkey_allocation_map(mm) & (1U << pkey);
 }
 
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -95,26 +95,27 @@ int __arch_override_mprotect_pkey(struct
 	 */
 	if (pkey != -1)
 		return pkey;
-	/*
-	 * Look for a protection-key-drive execute-only mapping
-	 * which is now being given permissions that are not
-	 * execute-only.  Move it back to the default pkey.
-	 */
-	if (vma_is_pkey_exec_only(vma) &&
-	    (prot & (PROT_READ|PROT_WRITE))) {
-		return 0;
-	}
+
 	/*
 	 * The mapping is execute-only.  Go try to get the
 	 * execute-only protection key.  If we fail to do that,
 	 * fall through as if we do not have execute-only
-	 * support.
+	 * support in this mm.
 	 */
 	if (prot == PROT_EXEC) {
 		pkey = execute_only_pkey(vma->vm_mm);
 		if (pkey > 0)
 			return pkey;
+	} else if (vma_is_pkey_exec_only(vma)) {
+		/*
+		 * Protections are *not* PROT_EXEC, but the mapping
+		 * is using the exec-only pkey.  This mapping was
+		 * PROT_EXEC and will no longer be.  Move back to
+		 * the default pkey.
+		 */
+		return ARCH_DEFAULT_PKEY;
 	}
+
 	/*
 	 * This is a vanilla, non-pkey mprotect (or we failed to
 	 * setup execute-only), inherit the pkey from the VMA we
