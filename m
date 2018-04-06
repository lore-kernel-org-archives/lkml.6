Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+GalY2HI8hsozXGl9VAMCnw+LSSdl6Bfzh90c3vgUcnp5hWGHTWz6XqzSlDQb1V2od14zq
ARC-Seal: i=1; a=rsa-sha256; t=1523021687; cv=none;
        d=google.com; s=arc-20160816;
        b=TqEZSurNWnU+WAbU/7yTy15ZjSftcaNb39L6qiyEpWur6YoG00I2gN8t+5KJtL/tXB
         1bS5F2QFqc6VotwFAhVjAtPQ+aulnhuT+v0/UZUZ+G/0bL9xREJcgxKalDjJpIFIB8+U
         ngMxjJwNpPAOfAlgR7pFiVSBZM3FxRxzGHccLZ5U1KEkLMILfHHloRUVlFAuPBRtrmlF
         sm3hFHiNOhhA03GLaT3CRsUGPTwMyw5lk2smdehxDDo/1DMlLJgUQcJBeGUPWWAs4nMJ
         ow0zsAzzW73aI3MZgdgxa7MjucXyeBTYsX4OwwAZFiPgGUGfOYz9h08vEKaTmBbM8qIo
         7m5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NVtQTc1d4kyeV81pdC/lhmzrnhJjeVoe8LzNFlwWVUg=;
        b=GO6ZMFafyaaYVb1byfKuvQm7UUjMp/4DYs+gWxpDcMnMiLcRsQlaY8YbEW5m385W10
         8HsQMLSIZ+2XzutTs4fHViyeWK/bix5TFXLXEcWKDxCQDl6OeS6x59uVj3l7X87yuJEO
         7AHqvTOvp8iIr2MUP91HUHfKItNvUow8M7Di9ymdctCE3Lp/ylbMuqkXjh6RuZqLW01/
         tL61SR1GwmToQ7WuDTgZGr49xHlJfW2CvK4pVK3sAOx9xnPcjYLoFFI3TvzLVas6iq1w
         8SeBzISwB91fcg0lWK8xTedN991aos+EZhUDoqba1ACuc8o8kG1DXjee2gOhzkf9kfO0
         CYEw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Laura Abbott <labbott@redhat.com>,
	Shanker Donthineni <shankerd@codeaurora.org>,
	Will Deacon <will.deacon@arm.com>,
	Greg Hackmann <ghackmann@google.com>,
	Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 4.9 054/102] arm64: mm: Invalidate both kernel and user ASIDs when performing TLBI
Date: Fri,  6 Apr 2018 15:23:35 +0200
Message-Id: <20180406084339.231028588@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003989088445405?=
X-GMAIL-MSGID: =?utf-8?q?1597003989088445405?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>

commit 9b0de864b5bc upstream.

Since an mm has both a kernel and a user ASID, we need to ensure that
broadcast TLB maintenance targets both address spaces so that things
like CoW continue to work with the uaccess primitives in the kernel.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org> [v4.9 backport]
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Will Deacon <will.deacon@arm.com>
Tested-by: Greg Hackmann <ghackmann@google.com>
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
@@ -42,6 +43,11 @@
 
 #define __tlbi(op, ...)		__TLBI_N(op, ##__VA_ARGS__, 1, 0)
 
+#define __tlbi_user(op, arg) do {						\
+	if (arm64_kernel_unmapped_at_el0())					\
+		__tlbi(op, (arg) | USER_ASID_FLAG);				\
+} while (0)
+
 /*
  *	TLB Management
  *	==============
@@ -103,6 +109,7 @@ static inline void flush_tlb_mm(struct m
 
 	dsb(ishst);
 	__tlbi(aside1is, asid);
+	__tlbi_user(aside1is, asid);
 	dsb(ish);
 }
 
@@ -113,6 +120,7 @@ static inline void flush_tlb_page(struct
 
 	dsb(ishst);
 	__tlbi(vale1is, addr);
+	__tlbi_user(vale1is, addr);
 	dsb(ish);
 }
 
@@ -139,10 +147,13 @@ static inline void __flush_tlb_range(str
 
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
@@ -182,6 +193,7 @@ static inline void __flush_tlb_pgtable(s
 	unsigned long addr = uaddr >> 12 | (ASID(mm) << 48);
 
 	__tlbi(vae1is, addr);
+	__tlbi_user(vae1is, addr);
 	dsb(ish);
 }
 
