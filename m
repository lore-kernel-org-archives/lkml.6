Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELv/BAnqzqQrBlu9OsR3WHjhDTCjt5HO7kQErXiJtZU/7avG8+jt3D2vYPv+wmZLzOxTlXuz
ARC-Seal: i=1; a=rsa-sha256; t=1520245575; cv=none;
        d=google.com; s=arc-20160816;
        b=kgH0G01lax1wowbTUr9F9KFWdYcqAq+1etklaZcwxNnXoV58V8ewU5h4612l4Jc7nT
         zXZU477nO1wQD/I3MXRx6cRD9r+3Ql+DaCi2bBAjNx3IYvFcR1wwZ7RdFdxaPtrvZa1a
         Qwbf5dge/rbvUJ/V1ZVfZd5sDF1Od7tUayDUJqa9o/3WjnlLbfGFSRtgIfhJim4LDBgY
         uPIiQrZv03QdIP4mqLazASllInyD808KuwktOFpMvAZE9K9t5HkueUcZnk3P+N4b5BUT
         UGiVTtOb/D7sNDrawR7GwkJO75o5zjnYtETCaDQ54J25eQ6pMPdU9K2aRe3p+JX1L2M3
         vdkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=59MhfMU72c18caWRDgmz/TzHGVoGLjlnnaF4XkAcR74=;
        b=QI+MyY/uA8GFLNQ3tU0J/IrZXK4woO71FL6T+wEYgRUnLpTw0EEJRgYaf23vohQUJ+
         BV+PLoLGVTUI3jkaWS4vmLHJwkvihT73NgR2k7qnn7wM0Ph9SgiM3gcG3T8Mv+hD1yiu
         1dEetaGf6km9Fhnx6UfPkL2NMvbUMio/7Hg8yDS9WQwHyefGN0nwpWzYG5qXDowvKz0f
         FbjkBAcjnUzXuGFKSkZFPBMg3Zyydfju6Tnv+P2YihAfxQdKjWqeS6Y+xuA/HZ43IuHZ
         rzJKm3OPb5YOHnq7yRHV2/nQnV+44+tveehmZhcdAvD368FfRGiw8xxkJf2ntTX+PD7T
         uBtw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=Cx1hIp5A;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=Cx1hIp5A;
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
Subject: [PATCH 16/34] x86/pgtable/pae: Unshare kernel PMDs when PTI is enabled
Date: Mon,  5 Mar 2018 11:25:45 +0100
Message-Id: <1520245563-8444-17-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520245563-8444-1-git-send-email-joro@8bytes.org>
References: <1520245563-8444-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594093023818886947?=
X-GMAIL-MSGID: =?utf-8?q?1594093023818886947?=
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
