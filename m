Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+0UqZ4iY0SCzy8rBrUexHEfrbxGkheqKeLdoOCBKvsRnL01amA2+DgrAKz3FfeS4UHJfUs
ARC-Seal: i=1; a=rsa-sha256; t=1523021681; cv=none;
        d=google.com; s=arc-20160816;
        b=UGmZPd8RBM0LCH9180AZQT9Y7BW4VYiW4yGuDAaF0xfXFj0e1qmEgMQ2KFXe3KfWyK
         ZS74tTwDIgStgOBpeABov4MOOXckPSTijvL+SjqqRGiml3VStsAvVCbQWGuhmns0lPBC
         tozNke2lfojTEuA7yiHJ+7GY3rhBJ/Bmdk7clwiyNRMnqdY6KzKOqSi3WrzRNbTxuHNv
         uehmL6rqw7dw25uL1Mm4jGYrqSilOnEbJMkPY4vNrmNVCs7+TO5k6+ZBN6v/RG9PVvZ9
         zaIM9UCRWZNGu8pLfeTxFTChwi59yE/FlXoQ3Dy99kRue1ehbqaMX6j2w8FFYb0JZKab
         ICvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=PHbixr3Xji6AB2niWjfdHbA4AMOik78uQGVjDBZxeI0=;
        b=aygBZ84AwrUx9K80iGY0ixSTDRmc1aHs9BuztuIUg/wH1Rv3LZUQtm3nkDtZcC9pu7
         d1CqF23uX3ANv7h4iW7atGKAa7QOVqp2v19USIc8Bxvu67tDVADTMx3M2cc2+On0dMrh
         OGxDTTBsNZonGawp/JYfbGqfrkYN/edWY43yHZxkJcsdCqrk+Ff2JloszDr2/8MfyQl5
         z3ufrhe/9JV6z89DEqYBFPnso+LevATcon2jqmkyq1YFwab/gpQkjOciAPNPPN1bBr/c
         yjmf5AYDEpiVlrYOi6Ts6Wc7zSGG55YYVwqxUSOc3vZazFLAR9TfDytokPlyFEfMC6CQ
         W78g==
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
Subject: [PATCH 4.9 052/102] arm64: mm: Allocate ASIDs in pairs
Date: Fri,  6 Apr 2018 15:23:33 +0200
Message-Id: <20180406084338.948783994@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003982919308633?=
X-GMAIL-MSGID: =?utf-8?q?1597003982919308633?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>

commit 0c8ea531b774 upstream.

In preparation for separate kernel/user ASIDs, allocate them in pairs
for each mm_struct. The bottom bit distinguishes the two: if it is set,
then the ASID will map only userspace.

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
 arch/arm64/include/asm/mmu.h |    2 ++
 arch/arm64/mm/context.c      |   25 +++++++++++++++++--------
 2 files changed, 19 insertions(+), 8 deletions(-)

--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -16,6 +16,8 @@
 #ifndef __ASM_MMU_H
 #define __ASM_MMU_H
 
+#define USER_ASID_FLAG	(UL(1) << 48)
+
 typedef struct {
 	atomic64_t	id;
 	void		*vdso;
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -39,7 +39,16 @@ static cpumask_t tlb_flush_pending;
 
 #define ASID_MASK		(~GENMASK(asid_bits - 1, 0))
 #define ASID_FIRST_VERSION	(1UL << asid_bits)
-#define NUM_USER_ASIDS		ASID_FIRST_VERSION
+
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+#define NUM_USER_ASIDS		(ASID_FIRST_VERSION >> 1)
+#define asid2idx(asid)		(((asid) & ~ASID_MASK) >> 1)
+#define idx2asid(idx)		(((idx) << 1) & ~ASID_MASK)
+#else
+#define NUM_USER_ASIDS		(ASID_FIRST_VERSION)
+#define asid2idx(asid)		((asid) & ~ASID_MASK)
+#define idx2asid(idx)		asid2idx(idx)
+#endif
 
 /* Get the ASIDBits supported by the current CPU */
 static u32 get_cpu_asid_bits(void)
@@ -104,7 +113,7 @@ static void flush_context(unsigned int c
 		 */
 		if (asid == 0)
 			asid = per_cpu(reserved_asids, i);
-		__set_bit(asid & ~ASID_MASK, asid_map);
+		__set_bit(asid2idx(asid), asid_map);
 		per_cpu(reserved_asids, i) = asid;
 	}
 
@@ -159,16 +168,16 @@ static u64 new_context(struct mm_struct
 		 * We had a valid ASID in a previous life, so try to re-use
 		 * it if possible.
 		 */
-		asid &= ~ASID_MASK;
-		if (!__test_and_set_bit(asid, asid_map))
+		if (!__test_and_set_bit(asid2idx(asid), asid_map))
 			return newasid;
 	}
 
 	/*
 	 * Allocate a free ASID. If we can't find one, take a note of the
-	 * currently active ASIDs and mark the TLBs as requiring flushes.
-	 * We always count from ASID #1, as we use ASID #0 when setting a
-	 * reserved TTBR0 for the init_mm.
+	 * currently active ASIDs and mark the TLBs as requiring flushes.  We
+	 * always count from ASID #2 (index 1), as we use ASID #0 when setting
+	 * a reserved TTBR0 for the init_mm and we allocate ASIDs in even/odd
+	 * pairs.
 	 */
 	asid = find_next_zero_bit(asid_map, NUM_USER_ASIDS, cur_idx);
 	if (asid != NUM_USER_ASIDS)
@@ -185,7 +194,7 @@ static u64 new_context(struct mm_struct
 set_asid:
 	__set_bit(asid, asid_map);
 	cur_idx = asid;
-	return asid | generation;
+	return idx2asid(asid) | generation;
 }
 
 void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
