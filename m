Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AIpwx4+dlxD6yXVxFT24FCFIdb/CWtAGIyxZUzowzLSC7j2n3pMEbgH5aSxPzy+4GrLP2nChVgYg
ARC-Seal: i=1; a=rsa-sha256; t=1524498472; cv=none;
        d=google.com; s=arc-20160816;
        b=BrbTS8sCmHXpgFTs1hA9F5xUIcR5lTAyVYb8e5Dmo3XHLgVwvV335jOjvVH+Ro3GMz
         HrHmwuO+0HsYQaokbU1P2JatW8Yf+cj3cBfATBP8jsd8WOzhQKiVlGlYUyFRgGiH/Fa4
         +ZATwVkqbGnplvFGmSlSfQeaXqDwY2hK2AqwEwHuLxjE+IpQgq0lT2zH5vLoiyFBVjs5
         SdplkWwlzAJGl7Bt7LCmStJrnOW/bPI+tvCNXbgWEOxzyFYS+xrBgxWlV3CjAiAt6Fqe
         ZcLWjTy/oIJkAWe2Cd/VPTupEbLs++UmdUNk1Thv2KN4XBPJLsjce7cyxQoSiS5N7ryx
         DsiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=S4MgOOtbnkkfJuMRU2k7i/vCCmzXOxdDizUjf0gP0lA=;
        b=D6bfzXSQQlGkwyQKXEaTJa7boj/hhQSej8rCiOgeTSWjAhA+Fq3lDmkJtswMBUWYC1
         7yUyduHlUikrzLf2K4qFn2FVr36eLtoBoSQQqnZGEfJA9wyTz7DFW3aBOZ0GZ02R2gXu
         22mcm4/8I6k8Vgi5cftbygyUUwYbQ1KgOKaJ2B3dNNKTBVXYd4LQT6iIkrhGPMFTwgqr
         PZD9s3QCrIzGiSHvBVhLZsVNA/07NX2/vjqX9ctXrXWDmSh8RW6raRgvzmPzDezPN1Yl
         QLZo2CUHtmrRuOEKrRs/w24jvG5jA1qa5a7KqJgGqQTKE11K8tecD1/CnnkNnWIqINNH
         b6Xw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=VAuBXDh6;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=VAuBXDh6;
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
Subject: [PATCH 16/37] x86/pgtable/pae: Unshare kernel PMDs when PTI is enabled
Date: Mon, 23 Apr 2018 17:47:19 +0200
Message-Id: <1524498460-25530-17-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524498460-25530-1-git-send-email-joro@8bytes.org>
References: <1524498460-25530-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598552510284017233?=
X-GMAIL-MSGID: =?utf-8?q?1598552510284017233?=
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
