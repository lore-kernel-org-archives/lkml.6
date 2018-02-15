Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226axw90w/cwK5AUW5dFHoPABPD7KMc0FVVvDdymPoGaIUVjAtjIj/Cvm4IR1eHPa3N3jhhE
ARC-Seal: i=1; a=rsa-sha256; t=1518708655; cv=none;
        d=google.com; s=arc-20160816;
        b=dlWXn5+avrUVj0Q0SeAJ69WX2TAfEfMBZgNu5jZmd8zjImnjWYGNXpnoOPg3Z4ZyNo
         MetT+z9mL6rXpme9pJWPCteJpC+4yK445c2HyhFAT6NrRAqubBLqSnuZLKkoHtA3Dizn
         aPeotEsqVZ7pA8DOD0kavcuAYVjVwc8EDODBNHClEK/llz0rfI6hr0M59ucpQXEoAJFz
         eExyHG0FyCr560gpb6PvFXjSztxlyRe8+ISuhoqfJzWO0Jubx84VWhVsuxmNFzuLPgmM
         EpT1a0ZIQggGi6K6ZYUsbdjMSMPoUFvjm7OPV7zmK2r3Jox85V7v1nZLWMXoGFYK5BoJ
         YcNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LNgAbbbd4rOoAwX2YvwiDaBOCxNvX2h5Ew4qS1461ec=;
        b=dPSWYJ+HVcJu/Qm4vj3t4tp09sXrbr7TQ7u2Z+w5x/Zzwof0gijcwvf1L32AqB/ppv
         hcOAOqsaO9LfgCVyvTOCAUi0bezzrJDuVtnIfDoj+LlrwJQXY+SsZ2cUs9+mSY+LL0Ap
         KAZERsll34ZHd82S22vzszs8YgTG1WfA0v0PKDCRqjMFDl/6uZofne3xvekeh/mmeDx7
         EXcUnKa/AaFNgYduykOuKGh6T8xA4sv7066BeOvOosEfaoJPzyGSiGaAuGkfIgwm/RB9
         wHrBWS3QXrZQ8TdffR6JRhg/lknmz0FYC3enpkDSTEAJSKlGI/bFIau6KxR6pEbFu46q
         6QLQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Laura Abbott <labbott@redhat.com>,
	Shanker Donthineni <shankerd@codeaurora.org>,
	Will Deacon <will.deacon@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 031/195] [Variant 3/Meltdown] arm64: mm: Invalidate both kernel and user ASIDs when performing TLBI
Date: Thu, 15 Feb 2018 16:15:22 +0100
Message-Id: <20180215151707.308102857@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481446371488395?=
X-GMAIL-MSGID: =?utf-8?q?1592481446371488395?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit 9b0de864b5bc upstream.

Since an mm has both a kernel and a user ASID, we need to ensure that
broadcast TLB maintenance targets both address spaces so that things
like CoW continue to work with the uaccess primitives in the kernel.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/tlbflush.h |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -23,6 +23,7 @@
 
 #include <linux/sched.h>
 #include <asm/cputype.h>
+#include <asm/mmu.h>
 
 /*
  * Raw TLBI operations.
@@ -54,6 +55,11 @@
 
 #define __tlbi(op, ...)		__TLBI_N(op, ##__VA_ARGS__, 1, 0)
 
+#define __tlbi_user(op, arg) do {						\
+	if (arm64_kernel_unmapped_at_el0())					\
+		__tlbi(op, (arg) | USER_ASID_FLAG);				\
+} while (0)
+
 /*
  *	TLB Management
  *	==============
@@ -115,6 +121,7 @@ static inline void flush_tlb_mm(struct m
 
 	dsb(ishst);
 	__tlbi(aside1is, asid);
+	__tlbi_user(aside1is, asid);
 	dsb(ish);
 }
 
@@ -125,6 +132,7 @@ static inline void flush_tlb_page(struct
 
 	dsb(ishst);
 	__tlbi(vale1is, addr);
+	__tlbi_user(vale1is, addr);
 	dsb(ish);
 }
 
@@ -151,10 +159,13 @@ static inline void __flush_tlb_range(str
 
 	dsb(ishst);
 	for (addr = start; addr < end; addr += 1 << (PAGE_SHIFT - 12)) {
-		if (last_level)
+		if (last_level) {
 			__tlbi(vale1is, addr);
-		else
+			__tlbi_user(vale1is, addr);
+		} else {
 			__tlbi(vae1is, addr);
+			__tlbi_user(vae1is, addr);
+		}
 	}
 	dsb(ish);
 }
@@ -194,6 +205,7 @@ static inline void __flush_tlb_pgtable(s
 	unsigned long addr = uaddr >> 12 | (ASID(mm) << 48);
 
 	__tlbi(vae1is, addr);
+	__tlbi_user(vae1is, addr);
 	dsb(ish);
 }
 
