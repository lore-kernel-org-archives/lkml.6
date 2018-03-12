Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELvQCqnIde4NgIbbMoe3q+gUradC0uaUcNt5uLuzkF1mlLoin0pjyAjp7QnnhDLqKptujEdP
ARC-Seal: i=1; a=rsa-sha256; t=1520824090; cv=none;
        d=google.com; s=arc-20160816;
        b=y0DDkKu2u90aRUgOtfOqpesRsS7JhtTXunsYlAX0GFQWKA0Xd8dVenb5A5q34AJMxU
         eMJ97UAO5xr+nojmomQ3xymaEnlw/vS31fbkY23XLVBqChPNiADresVjHuwdKTpERvt5
         Q1urqMSZUmzr61CL+IjxWLPQjghzwgGe2g7VY/OaIFfqOVBCTy13DmHlFRTmuuLwH8yD
         nFEaIiclu/8u7/JDriDI2jle8EWiWhBQPY1ykH41sVRvztZ4NWh5qJFIDlts9GAxY8Io
         trBRYcrWT+3qLV3jgLuJVq5edI0tdHsLMU2w2sGWWZMCU4ezifPWuLgIpPMOJWfy773O
         g1fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=Ey1MrKOnGALd/avmFSTzfAHlufwxJKkveIINhH84b0k=;
        b=hkZSmij2th/YQSpUb3XY8R+Ut+LRdvMVEhH+h/ROQS0sNg8NeFt3hebNdNFnL8UGSL
         eIxJNOCApxejRmTGJwEtGLgNNGiCo0ww/BUk9VwEwwEr6q/TzeahL04FQbZzZGI6YmtE
         PxYGO8z30blAbSLOVjUmDLuJIzXF48I18BJcTZ4tt/U2vjg+8J+KjBa0hZ4W1OEXb2m2
         CJCM4+A3wXLkG1CfYr88Tn+HHiEFGCs/EjmxOn7CJfL28Tabo6IaGaDta/anrnIXKx3w
         BtZ8Sr3E9QQM5RueLvPCSkStUrwFN/gD/9iX3EiJRIXVlicXsEnI3ULz9762Ftp+sNzW
         MKDw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Kees Cook" <keescook@chromium.org>,
 kernel-hardening@lists.openwall.com,
 "Al Viro" <viro@zeniv.linux.org.uk>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Andi Kleen" <ak@linux.intel.com>,
 "Ingo Molnar" <mingo@redhat.com>,
 "Dan Williams" <dan.j.williams@intel.com>,
 alan@linux.intel.com,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Tom Lendacky" <thomas.lendacky@amd.com>,
 linux-arch@vger.kernel.org, gregkh@linuxfoundation.org
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.926146860@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 54/76] x86: Introduce barrier_nospec
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699636153002589?=
X-GMAIL-MSGID: =?utf-8?q?1594699640884555617?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit b3d7ad85b80bbc404635dca80f5b129f6242bc7a upstream.

Rename the open coded form of this instruction sequence from
rdtsc_ordered() into a generic barrier primitive, barrier_nospec().

One of the mitigations for Spectre variant1 vulnerabilities is to fence
speculative execution after successfully validating a bounds check. I.e.
force the result of a bounds check to resolve in the instruction pipeline
to ensure speculative execution honors that result before potentially
operating on out-of-bounds data.

No functional changes.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Suggested-by: Andi Kleen <ak@linux.intel.com>
Suggested-by: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: kernel-hardening@lists.openwall.com
Cc: gregkh@linuxfoundation.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: alan@linux.intel.com
Link: https://lkml.kernel.org/r/151727415361.33451.9049453007262764675.stgit@dwillia2-desk3.amr.corp.intel.com
[bwh: Backported to 3.16: update rdtsc_barrier() instead of rdtsc_ordered()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -48,6 +48,10 @@ static inline unsigned long array_index_
 /* Override the default implementation from linux/nospec.h. */
 #define array_index_mask_nospec array_index_mask_nospec
 
+/* Prevent speculative execution past this barrier. */
+#define barrier_nospec() alternative_2("", "mfence", X86_FEATURE_MFENCE_RDTSC, \
+					   "lfence", X86_FEATURE_LFENCE_RDTSC)
+
 /**
  * read_barrier_depends - Flush all pending reads that subsequents reads
  * depend on.
@@ -174,8 +178,7 @@ do {									\
  */
 static __always_inline void rdtsc_barrier(void)
 {
-	alternative(ASM_NOP3, "mfence", X86_FEATURE_MFENCE_RDTSC);
-	alternative(ASM_NOP3, "lfence", X86_FEATURE_LFENCE_RDTSC);
+	barrier_nospec();
 }
 
 #endif /* _ASM_X86_BARRIER_H */
