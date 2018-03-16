Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELvsIOPgrJ3SRfBmj19POE0xP1E+6jDm1IfSWNo0InC3AKxODU6wriFw21YvcVjA+WrUq4fF
ARC-Seal: i=1; a=rsa-sha256; t=1521228605; cv=none;
        d=google.com; s=arc-20160816;
        b=nQit5+c6ZHaEcY3fxH7E1HjQb+Mfx/CxoW5kcZRgt5BbRO+pri9s/YcIrCovd9VIBS
         ROKsiGN74MljcQZwAlVCF2oSZxJiODkO4cMPOk+co0kzdKmXTG2rlEjPCoGkMbpw9tCI
         CwqriIEK3uc1V81wvK9bZmZsPVsV9xgSyD6FCZpW9GjzrFxWYMRqAqJK2xRxU7Q4zF8i
         KfL1+xfF8xMX3MVeaedtYYD85xCS98Bvx6efodg/mXu18URvi1xp9/4dJVKmjWFyKd/d
         ksDsTfe4eUjzB90agVw+UTYF7YK+mZOqJLgifVafC+z5cKqzhYOaATp0Z85aD6C7+a9Z
         b5FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=59MhfMU72c18caWRDgmz/TzHGVoGLjlnnaF4XkAcR74=;
        b=ty6r//qm3f8CSJcprqjpfvR+JMcLasXJdBTa+LG/P9dgJ5c3QPk2706kMD5MOEzw8q
         zMzYDQ38/VJAHMYMBaPClVxunh8P51VLNm7s4QLxYKAT++uSCu6Llvc2zsHPuxpEmkGO
         1e5h/stsQ+r6by5d7eGhXE7AlFxgNCqxYFsIIvZRIdu28i0aB6XLb8q+AGoF3iPYivNG
         DlpP79GpWZsL+BwOfqaZ2U4oxbHCKKo6AvgsOSeC7qoQWagslRmxIvZ66dniH+Ovpiw3
         yUtyjlKtt5uX41p9iD003LLDB4kH5qEhfAqRdkklg+Eil5i9Wfsm/whtNF/LgbDVpBD2
         IMlg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=OmD+Qruy;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=OmD+Qruy;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
From: Joerg Roedel <joro@8bytes.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>,
	aliguori@amazon.com,
	daniel.gruss@iaik.tugraz.at,
	hughd@google.com,
	keescook@google.com,
	Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>,
	Pavel Machek <pavel@ucw.cz>,
	jroedel@suse.de,
	joro@8bytes.org
Subject: [PATCH 16/35] x86/pgtable/pae: Unshare kernel PMDs when PTI is enabled
Date: Fri, 16 Mar 2018 20:29:34 +0100
Message-Id: <1521228593-3820-17-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521228593-3820-1-git-send-email-joro@8bytes.org>
References: <1521228593-3820-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595123806464996100?=
X-GMAIL-MSGID: =?utf-8?q?1595123806464996100?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

With PTI we need to map the per-process LDT into the kernel
address-space for each process, so we need separate kernel
PMDs per PGD.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/pgtable-3level_types.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/pgtable-3level_types.h b/arch/x86/include/asm/pgtable-3level_types.h
index 876b4c7..ed8a200 100644
--- a/arch/x86/include/asm/pgtable-3level_types.h
+++ b/arch/x86/include/asm/pgtable-3level_types.h
@@ -21,9 +21,10 @@ typedef union {
 #endif	/* !__ASSEMBLY__ */
 
 #ifdef CONFIG_PARAVIRT
-#define SHARED_KERNEL_PMD	(pv_info.shared_kernel_pmd)
+#define SHARED_KERNEL_PMD	((!static_cpu_has(X86_FEATURE_PTI) &&	\
+				 (pv_info.shared_kernel_pmd)))
 #else
-#define SHARED_KERNEL_PMD	1
+#define SHARED_KERNEL_PMD	(!static_cpu_has(X86_FEATURE_PTI))
 #endif
 
 /*
-- 
2.7.4
