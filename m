Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtGLEAqeglY1WHsQi4GSaP8yNJaC+u152Z5qx8QVx+CailGgl73THX8eA/sl9cC8Gd149q4
ARC-Seal: i=1; a=rsa-sha256; t=1520451847; cv=none;
        d=google.com; s=arc-20160816;
        b=t2ItUHYSHbrIZUIV7vVPWzZfd1RAfHp0to/g6tqNLwg52URhCHJQZQeHrP9MkP6+m+
         s7A7l41nCKUHls24ZdLNn+RRaH+Iv/J3DmbzZxqCr3UGDbEEiFEkSbwdg5r0ikD2XiWx
         MkDfHDX51czW+FA01ZQu5fYHaPimgr1MBykEA1REPYqFBFt932Q37Y+TWiTapQrlFqlt
         pC8lxPNjG1k4f5jR0OOO73HotXNqRWtmwH2CRR9DHVdje2rJ30JDKXHgX+bxXp2e/Apj
         TkZfAe1FpR1bvULJYLoNYWCohS+1e+9h67lu9vXY+PASS3pbX4lCb5SnqeJFiJzjRDSD
         cJfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=EOVdTL7SU08iNqUUXllH8YH8rtPxa9pJ2saSl2iQHQI=;
        b=dm8RxP8YeL6G7IVVLeJ+csaiQ0CoyAJ+iF7YEEiLJ02jrCO0lDeOJKxcM0/Mmf4nBb
         NEvhIbVo4PW0cqjWbi0eNnGIkbdZQwpouRUqSuxU3oLI6XfQSCWYU0XN69CfSjt1iGMm
         UYFPOT3TXdVdnONoom9MOqUhrnpJfAgYnG6mfM9xyalrFE/Mz7xSUt3kJgzaVn0amcMw
         +qtoQDgpoTaWvYMHrxs4x/vzkRx0wCdSW0E3XpOaXCLQsQorIxaZcdXT4xrduSWjwpKM
         /i+zegfpHULkiVr+aPKlXpv5YkLkRN6P2uoS+dWiAychpNoS2tVpdSTBsM/pbL/LVn0d
         mr2Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Florian Weimer <fweimer@redhat.com>,
	Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.15 121/122] powerpc/64s/radix: Boot-time NULL pointer protection using a guard-PID
Date: Wed,  7 Mar 2018 11:38:53 -0800
Message-Id: <20180307191747.151605487@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309316320608447?=
X-GMAIL-MSGID: =?utf-8?q?1594309316320608447?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Piggin <npiggin@gmail.com>

commit eeb715c3e995fbdda0cc05e61216c6c5609bce66 upstream.

This change restores and formalises the behaviour that access to NULL
or other user addresses by the kernel during boot should fault rather
than succeed and modify memory. This was inadvertently broken when
fixing another bug, because it was previously not well defined and
only worked by chance.

powerpc/64s/radix uses high address bits to select an address space
"quadrant", which determines which PID and LPID are used to translate
the rest of the address (effective PID, effective LPID). The kernel
mapping at 0xC... selects quadrant 3, which uses PID=0 and LPID=0. So
the kernel page tables are installed in the PID 0 process table entry.

An address at 0x0... selects quadrant 0, which uses PID=PIDR for
translating the rest of the address (that is, it uses the value of the
PIDR register as the effective PID). If PIDR=0, then the translation
is performed with the PID 0 process table entry page tables. This is
the kernel mapping, so we effectively get another copy of the kernel
address space at 0. A NULL pointer access will access physical memory
address 0.

To prevent duplicating the kernel address space in quadrant 0, this
patch allocates a guard PID containing no translations, and
initializes PIDR with this during boot, before the MMU is switched on.
Any kernel access to quadrant 0 will use this guard PID for
translation and find no valid mappings, and therefore fault.

After boot, this PID will be switchd away to user context PIDs, but
those contain user mappings (and usually NULL pointer protection)
rather than kernel mapping, which is much safer (and by design). It
may be in future this is tightened further, which the guard PID could
be used for.

Commit 371b8044 ("powerpc/64s: Initialize ISAv3 MMU registers before
setting partition table"), introduced this problem because it zeroes
PIDR at boot. However previously the value was inherited from firmware
or kexec, which is not robust and can be zero (e.g., mambo).

Fixes: 371b80447ff3 ("powerpc/64s: Initialize ISAv3 MMU registers before setting partition table")
Cc: stable@vger.kernel.org # v4.15+
Reported-by: Florian Weimer <fweimer@redhat.com>
Tested-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
[mauricfo: backport to v4.15.7 (context line updates only) and re-test]
Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/mm/pgtable-radix.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -21,6 +21,7 @@
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
+#include <asm/mmu_context.h>
 #include <asm/dma.h>
 #include <asm/machdep.h>
 #include <asm/mmu.h>
@@ -334,6 +335,22 @@ static void __init radix_init_pgtable(vo
 		     "r" (TLBIEL_INVAL_SET_LPID), "r" (0));
 	asm volatile("eieio; tlbsync; ptesync" : : : "memory");
 	trace_tlbie(0, 0, TLBIEL_INVAL_SET_LPID, 0, 2, 1, 1);
+
+	/*
+	 * The init_mm context is given the first available (non-zero) PID,
+	 * which is the "guard PID" and contains no page table. PIDR should
+	 * never be set to zero because that duplicates the kernel address
+	 * space at the 0x0... offset (quadrant 0)!
+	 *
+	 * An arbitrary PID that may later be allocated by the PID allocator
+	 * for userspace processes must not be used either, because that
+	 * would cause stale user mappings for that PID on CPUs outside of
+	 * the TLB invalidation scheme (because it won't be in mm_cpumask).
+	 *
+	 * So permanently carve out one PID for the purpose of a guard PID.
+	 */
+	init_mm.context.id = mmu_base_pid;
+	mmu_base_pid++;
 }
 
 static void __init radix_init_partition_table(void)
@@ -580,6 +597,8 @@ void __init radix__early_init_mmu(void)
 
 	radix_init_iamr();
 	radix_init_pgtable();
+	/* Switch to the guard PID before turning on MMU */
+	radix__switch_mmu_context(NULL, &init_mm);
 }
 
 void radix__early_init_mmu_secondary(void)
@@ -601,6 +620,7 @@ void radix__early_init_mmu_secondary(voi
 		radix_init_amor();
 	}
 	radix_init_iamr();
+	radix__switch_mmu_context(NULL, &init_mm);
 }
 
 void radix__mmu_cleanup_all(void)
