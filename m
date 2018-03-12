Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELudckR8rmboEUKemM8CcDxPHSc9K+Ef4jYfNWieeESjIarEbahbeXeIMeeeW+RmHUJY8uCT
ARC-Seal: i=1; a=rsa-sha256; t=1520824073; cv=none;
        d=google.com; s=arc-20160816;
        b=EcnCd1bVfM9ixUcve9voACH/NsIk0HTJiFH2lexZFK+7rrWCr2lgisaVmKo9ioQVUs
         5dKQug0nPqiW1yYXvBg8mdIMlJlxl0f/qF9VULlGD6Ig37JzLNLslbcOb5E+BvEq+V5Z
         vr9ebCfL4lghF0PTow4FofUPsbnrrZOMayhKYWRcLegi9htSddXGqI44mzFp3tpODmzd
         i6m+fiV8s5j4QppSZTTaR74Lmw40ShsQwPZa5RXKciK/Vt6wZ+X3ZtTh/ptD/GDRXeJn
         tWEB4qfU/wAD1MKQ4JyVh9jvAgr8w0LAo+bwh9k0OHo3yaZp7FOAKGRvCLt92lU4il2B
         jVeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=AUdqFBlNfKuoXqckWWGRXcnyzu0IxCT901Oxz6/wHpk=;
        b=eStgWsyRu/3BydvL8808nMGU+6zCycWH+y7XQPRQJFzIHSYmVWvSH0DGLVIVjodfTV
         ysM4NYo1vk1obGrRs345IFZySVADZfA/YD+A4zA15sl9qKKxCngbT2HripcgoUWu9Agg
         NdNyy21sERn/pBbT9LosVjRpZY+xkwsANtiddRn9ddcmP9uQn4bIg2WqfwPv7+nUseIR
         E/p+Qu2io9AD9JrFFQUwrsTkryIEAqQelCrZHbHAQuW7Ym51geeP3i+ZzrLSZ5xH75fh
         CoRX0lH9vYr4FW0zPgg3roAhS/luIaOSvxSD3Y9qn8MQ3Rj566QwtO2PSdzuDZ1nFerw
         gQxA==
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
CC: akpm@linux-foundation.org, kernel-hardening@lists.openwall.com,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Dan Williams" <dan.j.williams@intel.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 alan@linux.intel.com, gregkh@linuxfoundation.org,
 linux-arch@vger.kernel.org
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.992404138@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 53/76] x86: Implement array_index_mask_nospec
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699614346273084?=
X-GMAIL-MSGID: =?utf-8?q?1594699623638399511?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit babdde2698d482b6c0de1eab4f697cf5856c5859 upstream.

array_index_nospec() uses a mask to sanitize user controllable array
indexes, i.e. generate a 0 mask if 'index' >= 'size', and a ~0 mask
otherwise. While the default array_index_mask_nospec() handles the
carry-bit from the (index - size) result in software.

The x86 array_index_mask_nospec() does the same, but the carry-bit is
handled in the processor CF flag without conditional instructions in the
control flow.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com
Cc: gregkh@linuxfoundation.org
Cc: alan@linux.intel.com
Link: https://lkml.kernel.org/r/151727414808.33451.1873237130672785331.stgit@dwillia2-desk3.amr.corp.intel.com
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/barrier.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -25,6 +25,30 @@
 #endif
 
 /**
+ * array_index_mask_nospec() - generate a mask that is ~0UL when the
+ * 	bounds check succeeds and 0 otherwise
+ * @index: array element index
+ * @size: number of elements in array
+ *
+ * Returns:
+ *     0 - (index < size)
+ */
+static inline unsigned long array_index_mask_nospec(unsigned long index,
+		unsigned long size)
+{
+	unsigned long mask;
+
+	asm ("cmp %1,%2; sbb %0,%0;"
+			:"=r" (mask)
+			:"r"(size),"r" (index)
+			:"cc");
+	return mask;
+}
+
+/* Override the default implementation from linux/nospec.h. */
+#define array_index_mask_nospec array_index_mask_nospec
+
+/**
  * read_barrier_depends - Flush all pending reads that subsequents reads
  * depend on.
  *
