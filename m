Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224FQdsWSJmRlXe8aegQR+VuH8uY3fkdxVL99Gb25unyDWdXdpxfVU1m3MsLIu3HaOC8NnvQ
ARC-Seal: i=1; a=rsa-sha256; t=1518709172; cv=none;
        d=google.com; s=arc-20160816;
        b=oxwXcAjD7nxnn/byKlP+YvvUUQf9dWJgHpHtx7Kz9hHtgs21TWMheMqeQ/5F38FVdK
         XWp0VF8nGZ8Ifj8WJb9dadZJ7laaATPxpgV5LFwwE4RWtSaFUvZzqXpsJAs+mxEhgyMY
         X12bx9qXHoUAsmQW61fZ38StsY92EoZgLcH/0nVou3VM/wSexmmFEgsKuXUWZNjW28ze
         UwLgy0Mq5FdO0nniJ8I58s2bHEGxNN80KruEjDJ53ujQlXpINQ7+cX3rstSmqz8FD1AV
         arHk5m79BfvbwAzmSbK8VIuOKt5X9+E4nrJx+Wfv6feRkiVk+WxBF2/NWGATlqv4VRaD
         w/Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vBdJpuPR/PuBTrPBmCProtQdpKyCxAXO9bfyMp0SMEI=;
        b=RkEQ6LM+qYpE5P6bH2sxkLvu4vlfeYdX0iMjUt31fiiOwTISoH81ZSEFgPDKJQxj36
         5lgo9t4fsXCm/W/IZK1jtffxUIZxRgl/j6sZKADPb9AHACUW2cSW95jUW7j9N+bd3LLR
         3WGjBcnEDpgeeCKfjXUdL+qtOeKcwSixDFLKMcohcCYD/bMM0e4QYJtHJmm1ZOzVHqdd
         Oj6iBaT/SbxhdFB1PuuxPgrYNBs5Huo/neS3YBT27sypkzRwUkXLRljdKCMB1epGzAKQ
         vslRjx2krsRHN0093qaPQCBizXEiY89A33b5PRzsNuXc0bagqR/WSoQD9JTOjx2dbuvf
         x1lA==
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
	Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.15 023/202] [Variant 3/Meltdown] arm64: mm: Invalidate both kernel and user ASIDs when performing TLBI
Date: Thu, 15 Feb 2018 16:15:23 +0100
Message-Id: <20180215151714.135182487@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481446371488395?=
X-GMAIL-MSGID: =?utf-8?q?1592481989332619110?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
 
