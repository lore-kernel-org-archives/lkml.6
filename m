Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AIpwx4/IigrcI6Q8UWtd0F9qmf5kwbZS4Wtm7CeYLPboxMNYYL1JcSj7/JJV0XTG/Y+yiLnO3CXi
ARC-Seal: i=1; a=rsa-sha256; t=1523892346; cv=none;
        d=google.com; s=arc-20160816;
        b=q/T6zhWpZMzgG/1jDBxqB6baGBSw6DmJ4oXsz1JDAW10ylfnCxxsRCKp9U1qZdug60
         p+EEOK/G3oa9waAzwe9Q7AiDhys7uQDIkbJRGGYdv9gHeaakmY1x9lOAKHVVNJKYwPs9
         36jrbRp+OxtZL/j90pLQy2jUaNlqEZJcXs0HTBNEXFX5lf7nBRs2ByHYefXKYKMxNCHk
         4DZ2+NX0f2wpc6mEwqzXRrsu4AjxC1kqw0qEeuRfy0C+jgiRGIBPJk57hfLgkn9lSTNQ
         /LoLzFpHbTG+esg8QR9zHXT5f8cqQFE+0r45WTXTEazMrDzA828SelkIN9bgG5tq4zkN
         YSWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=S4MgOOtbnkkfJuMRU2k7i/vCCmzXOxdDizUjf0gP0lA=;
        b=HiuNEPgGa/8NQ6q3IJldpUOZWc2dxBzxT00mNjp6AeORjre5LuIoshY3/lbg3WCJfV
         qCJj5JJOJJ1ZRzhR0azzTJ2iQjyGC13dVp1PWley/4mCmKNwnAquTgqLpjQb7pgh04dh
         bPFxLaGY90efD+uNVsS91G7n3l+KmWpsp2PRKDdxxwM5CrmseRnIgi4XwAPF0e9o1LcP
         TdYvELNLlk1ByRpfFV7s/PpXvExm9Q09az06UliyAi9j6bvHpRk6kMTu9vQZlvjl1rct
         u8FrXvrkUKrBD5FfAzIPEscTyoB0ZC6Qop4WyojNkVSYxd/b1X6MLCRhwgoK9QPfPtf8
         om7w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=DUYEXDmh;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=DUYEXDmh;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
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
	"David H . Gutteridge" <dhgutteridge@sympatico.ca>,
	jroedel@suse.de,
	joro@8bytes.org
Subject: [PATCH 16/35] x86/pgtable/pae: Unshare kernel PMDs when PTI is enabled
Date: Mon, 16 Apr 2018 17:25:04 +0200
Message-Id: <1523892323-14741-17-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523892323-14741-1-git-send-email-joro@8bytes.org>
References: <1523892323-14741-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597916940910831666?=
X-GMAIL-MSGID: =?utf-8?q?1597916940910831666?=
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
index 6a59a6d..78038e0 100644
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
