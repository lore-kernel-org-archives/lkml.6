Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+XVLx7JV/Jhakq0xSGYQiJyhCcPZaaMGhySPU3mWi/F+S/ABweLoCxX0Feu3RKQnBJ2u75
ARC-Seal: i=1; a=rsa-sha256; t=1523022189; cv=none;
        d=google.com; s=arc-20160816;
        b=tUwyDC1wIt0IU76kO220IpBgGxFGxrhay8y///NHgJW3YPqGszOXWwwobLDbbWu3ra
         hW83QWLQYMxC0e7/ll9lrFTW1/k5nw1/Intdd9Z16xMzwr4WPF+yrFY4Db1vmJnz/vOk
         TIcjOjRCALFeAuSfBxmvpsCYtxLf3/EQc3J7rS1p2RMFajlRLOo8tsWXtaTsT1opPpWI
         IZuJhGkm/Oq9FdXMQZL/pgWqaKkwXM+hpDlwig+Ya1jvF8VvoWSL6NNxz30XgiF21obQ
         De13TW1dkg8dpul66NX5pUBLHE3mCRdNz59ZkKEanA8mV3ea8dztr0mxX9doui+ybgYJ
         phEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jYLBp0sA7Iouy2fFfg312c2YV9KKSSOWAPdKk71iJhY=;
        b=LeTkqJyDryXPtaFj6liTPHeYLixWBN+DmYU2A2GdpMx90yu774uui6EMkOC025nkyE
         VLAn037cZaaNLRa9xHfe0vj6yjDMyzp8Bvlz78qHK/fEFwkz4SZpKoeJbrdTZo0sVXso
         nSj2NUz0QaMWkikyluYcv+RB5jU+rkhlbPePrX4BOCn7M+iIVVfzbGnA5PVOHA0c9PLP
         m/i8JADI4s5RfaRW7RkBiXy41tryJCmNCZb+r+sggL7sw3YgYHiVWvIhFMl4mpPNEnfq
         3DlYyH9dssBKF5dblTHVlTGNOhtIUAqH3ga8cWeZtYnGZOOzWxTxuk1azspyB3heimWB
         dK4g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Balbir Singh <bsingharora@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.15 15/72] powerpc/mm: Add tracking of the number of coprocessors using a context
Date: Fri,  6 Apr 2018 15:23:50 +0200
Message-Id: <20180406084350.742056111@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004515407689367?=
X-GMAIL-MSGID: =?utf-8?q?1597004515407689367?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

commit aff6f8cb3e2170b9e58b0932bce7bfb492775e23 upstream.

Currently, when using coprocessors (which use the Nest MMU), we
simply increment the active_cpu count to force all TLB invalidations
to be come broadcast.

Unfortunately, due to an errata in POWER9, we will need to know
more specifically that coprocessors are in use.

This maintains a separate copros counter in the MMU context for
that purpose.

NB. The commit mentioned in the fixes tag below is not at fault for
the bug we're fixing in this commit and the next, but this fix applies
on top the infrastructure it introduced.

Fixes: 03b8abedf4f4 ("cxl: Enable global TLBIs for cxl contexts")
Cc: stable@vger.kernel.org # v4.15+
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Tested-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/include/asm/book3s/64/mmu.h |    3 +++
 arch/powerpc/include/asm/mmu_context.h   |   18 +++++++++++++-----
 arch/powerpc/mm/mmu_context_book3s64.c   |    1 +
 3 files changed, 17 insertions(+), 5 deletions(-)

--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -87,6 +87,9 @@ typedef struct {
 	/* Number of bits in the mm_cpumask */
 	atomic_t active_cpus;
 
+	/* Number of users of the external (Nest) MMU */
+	atomic_t copros;
+
 	/* NPU NMMU context */
 	struct npu_context *npu_context;
 
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -92,15 +92,23 @@ static inline void dec_mm_active_cpus(st
 static inline void mm_context_add_copro(struct mm_struct *mm)
 {
 	/*
-	 * On hash, should only be called once over the lifetime of
-	 * the context, as we can't decrement the active cpus count
-	 * and flush properly for the time being.
+	 * If any copro is in use, increment the active CPU count
+	 * in order to force TLB invalidations to be global as to
+	 * propagate to the Nest MMU.
 	 */
-	inc_mm_active_cpus(mm);
+	if (atomic_inc_return(&mm->context.copros) == 1)
+		inc_mm_active_cpus(mm);
 }
 
 static inline void mm_context_remove_copro(struct mm_struct *mm)
 {
+	int c;
+
+	c = atomic_dec_if_positive(&mm->context.copros);
+
+	/* Detect imbalance between add and remove */
+	WARN_ON(c < 0);
+
 	/*
 	 * Need to broadcast a global flush of the full mm before
 	 * decrementing active_cpus count, as the next TLBI may be
@@ -111,7 +119,7 @@ static inline void mm_context_remove_cop
 	 * for the time being. Invalidations will remain global if
 	 * used on hash.
 	 */
-	if (radix_enabled()) {
+	if (c == 0 && radix_enabled()) {
 		flush_all_mm(mm);
 		dec_mm_active_cpus(mm);
 	}
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -171,6 +171,7 @@ int init_new_context(struct task_struct
 	mm_iommu_init(mm);
 #endif
 	atomic_set(&mm->context.active_cpus, 0);
+	atomic_set(&mm->context.copros, 0);
 
 	return 0;
 }
