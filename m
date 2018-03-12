Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELs8H7ivrP0edS/tZm6EMJYVYL7jqqrhf3NXQFBXOsNnKESeFaTSt67QBL2dHUfZ+LnvS9uC
ARC-Seal: i=1; a=rsa-sha256; t=1520824064; cv=none;
        d=google.com; s=arc-20160816;
        b=WlWwjJeQv9SNg5oQcNVTVRTuPB8NMFrN1tAHBN/SjqVWEO915aUu2qYtG1NiN10JAb
         2VoMQWlw7qw2Y6s5+BMkNYJ8il1Y54Of8bLE6W8fdcLLy2N1D1ewKK7KOruA5ogvdSPM
         uWIu/HxKwMgxIKjjsGGKiVrucBZsggXaUCTS7enRC+rLkAkOVu4ujpfdXymCibfEk3Jd
         if0E2mMMoBNe0D5QCbcHeEVW+/XazdDh6rABOWuDDXOXtVGTchMC3+zZh/HlBhB4BURI
         QpoXO8qMFNgk7q0CQQ/iRZXboucHGLchMYCF4sNLKopp5rAJvZ/MzcaHN/Rvn1WTTChj
         FNyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=Zgc30eVrUpLl4eczwrLb/bV2478p85+6axYv+kcDIEw=;
        b=q78BKXhbkZdquhQP0RahEIILLvJuie5fZLCjvfJJkkK0bAuyuo35LLzg0Ru6K+Htcw
         ff6q+65YbUJ351qPfp+qq2oBIa9fMrR9UwFRIpD6NsGB4Q4ddbxxQ6JbLuPVFNuLy78k
         JhZVJqMbmAtc974RLG3acrfVREE2S8mAOa4rODMnZFGB+6MAjEvKKWvSoFwAejFgrlRo
         WgZwCfGYEcOkPSu5K+yZNwtOrDlSbjEOb92GQ9cg27GZVmennP1yf0dq/QHxCn+0t4rs
         rB+zdVBFuNy/GlkkvkzOinmuKO37WjPdvGgPzFYCU76+YB99I8Ry4COl04ghCBa+7S3s
         PAeQ==
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
CC: akpm@linux-foundation.org, alan@linux.intel.com,
 kernel-hardening@lists.openwall.com,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Dan Williams" <dan.j.williams@intel.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 gregkh@linuxfoundation.org, linux-arch@vger.kernel.org
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.879983504@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 084/104] x86: Implement array_index_mask_nospec
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699614346273084?=
X-GMAIL-MSGID: =?utf-8?q?1594699614346273084?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.2: adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/system.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

--- a/arch/x86/include/asm/system.h
+++ b/arch/x86/include/asm/system.h
@@ -455,6 +455,30 @@ void stop_this_cpu(void *dummy);
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
