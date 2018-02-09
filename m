Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AH8x227aMl9fPP6rJGPy1lUKLIMs65ZNPjXCsHGUZsTpPWYJlShTvo3KJQsMDGc8RFc+hS9fhHpT
ARC-Seal: i=1; a=rsa-sha256; t=1518168359; cv=none;
        d=google.com; s=arc-20160816;
        b=KNlUZj6oLLl8oa4M6QXb4F8sfm/Tpj5BnxTy+pBQfFx+J6pjfosbdKfme5v/XSRqvM
         H8dq9jZk1KgXehMFrGCYRW1Y6bZb9wVOBz/mDTG9vcRe/ibFVZbULErdRewrKQw56uWU
         58YsYvG1k1KHQ7Ku9wTQKZQdYCuIHajq+HTsI083weaaUF1wGrqDoGcu48WoMec1xjXq
         FSq+y7XQaEc5T1YCFHP/Uy6MvyLVOecckeYPkptSIz0ii2fuBpbxh7dNID2eSjcsy2bK
         LmjEGTnyrY89sdZ9idFUTv+4aKJZ0jKpLGzr/0tj4TRLWW0S8zYiCf2JhpjOQiwYRlOj
         Rc9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=59MhfMU72c18caWRDgmz/TzHGVoGLjlnnaF4XkAcR74=;
        b=oJuYjheDwJqdNScjjRtggh4JI6jEsVnV/jGSSYYUcKVZ9iqlu7Sor86mkfbrXkPNCk
         bbuEyvZi4mtpri9GsrME0zWmnLQ89/o2eM0p5N7Qh9a/U1/V2dqqLrEIYqrPT85crUbS
         76taYz+EruD7xSKqZzRTBD07itzHXTdFqMUzUPKkMmC+3nO81qQ5C2jscgKS/uehkVty
         bB2Fb2kB0jz7k4LFEmZuiRwB2nF8hhfL7vSv1z0EaFw9O1U+nvPjNbGDJyGo1lCIJyd0
         BV5viISURQ5lRmD9sRDSTDXYPvTShjbIKc4vghtkRXAbfPwL8BcqqIXX/Q/NSywbB8vj
         YEQA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=JNTvl4l6;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=JNTvl4l6;
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
	jroedel@suse.de,
	joro@8bytes.org
Subject: [PATCH 14/31] x86/pgtable/pae: Unshare kernel PMDs when PTI is enabled
Date: Fri,  9 Feb 2018 10:25:23 +0100
Message-Id: <1518168340-9392-15-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518168340-9392-1-git-send-email-joro@8bytes.org>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914906203794040?=
X-GMAIL-MSGID: =?utf-8?q?1591914906203794040?=
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
