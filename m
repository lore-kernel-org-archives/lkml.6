Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224TUJeCWsqI+/YYvgJN/9i4ex68ghsNNvulvr093DOLllFJOUSCNH+4L9j8rzf6OutC4IiE
ARC-Seal: i=1; a=rsa-sha256; t=1518709167; cv=none;
        d=google.com; s=arc-20160816;
        b=iZpZ5h1Kfy3ag5fA7RSMudGupkG/8aO/B2HOJaKqQgoeHkXammhGOH4IwCDtxwr9DU
         YKusy0pT6kYExNmVo8OsAVg7vdmMvAVf7bbNc3XobSzygYTNCtnUDkxO2zFrjEQLGINm
         XI+Awa1hemff/UIMhkRJTPY4dn8mt98BON/ZgXXc0SqUEZh4IXn5KDR3rC02rSrIWYHT
         AS3jDzKb/NkdVl6baygvuY6kKEnkUbCEkIIr+TJeDGwQOoYL1NsYPW43hQxn2DWDf7zf
         J3X7fZifAkoAFqyNO95QIxtTC3ioGLSRWFkXNslwP+xjYF5+KbYVBq4Ej9XCYu0DLkJ3
         phKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=L1/uF7OCkwsNUSmSkVTPjUieZ3VBzdboCYHvkI9r20s=;
        b=ZWPb1woxQ+fEyJOlivB3yPS60ABvIsH9E5nMaWODai9RXvd7lw/5j05NAV+poybxbc
         ZRfGUkpx9YqAf8/zEVnRGOja4kQSKwD573nV5iRVX8wsxFRDpHTpqox29n4L+OCoUH8H
         xd1vwBrf3gWySoa31iYWoVUOVaDfpa56LZSPOdSZT80R2EKdgdSCFnJE8Zgb3+RhO0/4
         dpV7D0f1y90mw65+0XovULLJh4g2mK5pWMeZq0U9XPL3PO3Cskr2EtLRzb2++jLD2JpW
         GbRsrc0SDp2Du3lMf1TS8upx+XeEpdiX+P56Xx+TnhPUrasS0hi4Plh0+LwskqHIochN
         kkcg==
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
Subject: [PATCH 4.15 021/202] [Variant 3/Meltdown] arm64: mm: Allocate ASIDs in pairs
Date: Thu, 15 Feb 2018 16:15:21 +0100
Message-Id: <20180215151713.996965074@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481441200588566?=
X-GMAIL-MSGID: =?utf-8?q?1592481983648806616?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit 0c8ea531b774 upstream.

In preparation for separate kernel/user ASIDs, allocate them in pairs
for each mm_struct. The bottom bit distinguishes the two: if it is set,
then the ASID will map only userspace.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/mmu.h |    1 +
 arch/arm64/mm/context.c      |   25 +++++++++++++++++--------
 2 files changed, 18 insertions(+), 8 deletions(-)

--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -17,6 +17,7 @@
 #define __ASM_MMU_H
 
 #define MMCF_AARCH32	0x1	/* mm context flag for AArch32 executables */
+#define USER_ASID_FLAG	(UL(1) << 48)
 
 typedef struct {
 	atomic64_t	id;
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
@@ -98,7 +107,7 @@ static void flush_context(unsigned int c
 		 */
 		if (asid == 0)
 			asid = per_cpu(reserved_asids, i);
-		__set_bit(asid & ~ASID_MASK, asid_map);
+		__set_bit(asid2idx(asid), asid_map);
 		per_cpu(reserved_asids, i) = asid;
 	}
 
@@ -153,16 +162,16 @@ static u64 new_context(struct mm_struct
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
@@ -179,7 +188,7 @@ static u64 new_context(struct mm_struct
 set_asid:
 	__set_bit(asid, asid_map);
 	cur_idx = asid;
-	return asid | generation;
+	return idx2asid(asid) | generation;
 }
 
 void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
