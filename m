Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELtAVAVDLluI9+mmGq7JxEGesCJVVE3cyii1cVTmCq4NtF27uf7341eLPxrWMKL33/v/Ia+t
ARC-Seal: i=1; a=rsa-sha256; t=1520824074; cv=none;
        d=google.com; s=arc-20160816;
        b=uZ20iV9C5N10cNY/LO0ckZYPxh6Fg1E+Bxfe4K3voK0QdFsGK7n+WT8hVFCSkxCFJr
         huthUz7fxJ9wqwXU5bbq3bZfFmGQVBxT1i7eGmau3eZ93ZjaPROV9G+baliOs9qtFSLJ
         Xd4c6hwTpAPIhSCBZHkCVD43w10hODtknWSTx1fWk08Wrg1/YVwAxe60U6QgLR5tK+dU
         HYpMBHoIKhPZ8hCFrP36DAY2Asc4s6ENaGTVtLQthq68Tq+/h9PNYXR7DNo0ehhRVP5E
         LCh4Ii/7A8s3fD5ImpZZhhVG+iBbCDJhNceIDaZeEpoUGl3BAgkrtXg5J0SDkmAliFX+
         O+oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=tVgQ/aRYpWm/wf6UMP8RaKMLVEQGoNY5wMNwi909sCc=;
        b=jBVnRSvk9TArR7uuiR+2L5Osb9DmD1ouFgroo8xqAPZHrOggEiBfM7pNvVG5nStoO+
         a4ash73V4qAnbGnjcSA0Y2BBO6bJQ7ImU1ep+iVJWykTgV3tSsQyJZ3VeQkSQRsF6iz4
         YuqgfxpXO7+NTktQSvABH7jlL6B8WlqqXpCV+k3XikzpDeexlkSOUSDoHtIWCSgL4HJu
         trKFT1l/MCN6GHXalfvQOhf9tHl6SX463Q453R/HGdtB2XTlnxwEvyBNicr1COaPDvUz
         RxMIFVF6XPjOxXkjN78TV4rw1HDmIOLbCnnYZ9StQcdhPJukqBIuiaeKeBt0UY4fjYD1
         ZLlw==
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
 "Peter Zijlstra" <peterz@infradead.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Greg Kroah-Hartman" <gregkh@linux-foundation.org>,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Arjan van de Ven" <arjan@linux.intel.com>,
 "Ananth N Mavinakayanahalli" <ananth@linux.vnet.ibm.com>,
 "Andi Kleen" <ak@linux.intel.com>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.226649533@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 36/76] kprobes/x86: Blacklist indirect thunk
 functions for kprobes
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699620789335702?=
X-GMAIL-MSGID: =?utf-8?q?1594699624985405271?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu <mhiramat@kernel.org>

commit c1804a236894ecc942da7dc6c5abe209e56cba93 upstream.

Mark __x86_indirect_thunk_* functions as blacklist for kprobes
because those functions can be called from anywhere in the kernel
including blacklist functions of kprobes.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: David Woodhouse <dwmw@amazon.co.uk>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linux-foundation.org>
Link: https://lkml.kernel.org/r/151629209111.10241.5444852823378068683.stgit@devbox
[bwh: Backported to 3.16: exports are still done from C]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -24,7 +24,9 @@ ENDPROC(__x86_indirect_thunk_\reg)
  * than one per register with the correct names. So we do it
  * the simple and nasty way...
  */
-#define GENERATE_THUNK(reg) THUNK reg
+#define __EXPORT_THUNK(sym) _ASM_NOKPROBE(sym)
+#define EXPORT_THUNK(reg) __EXPORT_THUNK(__x86_indirect_thunk_ ## reg)
+#define GENERATE_THUNK(reg) THUNK reg ; EXPORT_THUNK(reg)
 
 GENERATE_THUNK(_ASM_AX)
 GENERATE_THUNK(_ASM_BX)
