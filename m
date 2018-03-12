Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELvLEoIrYLeQkl9uKsRwe2kGuH4/zkqrxugyhUr300MJgWxVYth91KOhgL710TxK5tUHUJPU
ARC-Seal: i=1; a=rsa-sha256; t=1520824085; cv=none;
        d=google.com; s=arc-20160816;
        b=VN63dGWw3Qh+Ty1nx43jzLiTugMb0kuknO6zEgvWbJ2L6aeDqMZ5WRjfR8ARYZCbYZ
         2SYCbMuwlLUsLp7YB64DLeM7RV4kUNJWvAV96PqGkudzHPKTr8ArH8hRIrFtImPts3uv
         UiS3NiOzUb9B2Co7iE1YSlr3OzmqNw6BD8q9b5hLRTKjAsvPs8EYKGS3O+Iv78Up/PYo
         2GRjz02DdgI0q5gPJKP14BSqQXnTE8bPZWN7Pf/zM3sU1HWcUTnsq2E8kIPqS/bWch1l
         r4SUuO6TZGy8bvKDdb5p+vE1WjbSMgl74tqHVAYtfMtg79vw9mEnDiT7WWPWPO5t+8YA
         mxsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=VWxbIVjHBvwyiyTFNd6DAJSue2Us/F4zZ6OD2+GjjC8=;
        b=jWVt5x2HtsH4zhlC7BTXj8UtgGT5wj4NkTmjVlyVw/QDfJpizOgnkhxQcRqg8KQwF8
         5Zwjxf0jyEm0DjG1xNc9YNkjkHBI1DrYpFuyTRjnEhgmG7fnSF41MEtXXL2/GysopzmM
         rNRC1xIq6jPJIQ9Er5Nb7UNgy8qeXHCXosVnoeYgSNARREBt0wrQNAIZ09QvQSz8/rdv
         WRKzPFqVo/9ZMfH5+5+Rss+efQoDQ/2a6+gIISyBIxRkx/EZnCsAez8WUX41x5p3taPJ
         c221ZufxYqxZocNa0frPgMFkKDS+6bReY0m0Kr3bIbR+ycIVam63vsKH+KShPv/yTJau
         BbZA==
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
CC: akpm@linux-foundation.org, linux-arch@vger.kernel.org,
 "Al Viro" <viro@zeniv.linux.org.uk>,
 "Ingo Molnar" <mingo@redhat.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 gregkh@linuxfoundation.org,
 "Tom Lendacky" <thomas.lendacky@amd.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 kernel-hardening@lists.openwall.com,
 "Andi Kleen" <ak@linux.intel.com>,
 "Dan Williams" <dan.j.williams@intel.com>,
 "Kees Cook" <keescook@chromium.org>,
 alan@linux.intel.com
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.335034940@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 085/104] x86: Introduce barrier_nospec
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699636153002589?=
X-GMAIL-MSGID: =?utf-8?q?1594699636153002589?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.2: update rdtsc_barrier() instead of rdtsc_ordered()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/include/asm/system.h
+++ b/arch/x86/include/asm/system.h
@@ -478,6 +478,10 @@ static inline unsigned long array_index_
 /* Override the default implementation from linux/nospec.h. */
 #define array_index_mask_nospec array_index_mask_nospec
 
+/* Prevent speculative execution past this barrier. */
+#define barrier_nospec() alternative_2("", "mfence", X86_FEATURE_MFENCE_RDTSC, \
+					   "lfence", X86_FEATURE_LFENCE_RDTSC)
+
 /**
  * read_barrier_depends - Flush all pending reads that subsequents reads
  * depend on.
@@ -563,8 +567,7 @@ static inline unsigned long array_index_
  */
 static __always_inline void rdtsc_barrier(void)
 {
-	alternative(ASM_NOP3, "mfence", X86_FEATURE_MFENCE_RDTSC);
-	alternative(ASM_NOP3, "lfence", X86_FEATURE_LFENCE_RDTSC);
+	barrier_nospec();
 }
 
 /*
