Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+T9ThEBazuFEDoCrt6V04rLcnWiQuAQpc92i0knLaIN1BwF/v+A0EgdbQt6pp3f9eXsdfG
ARC-Seal: i=1; a=rsa-sha256; t=1523399277; cv=none;
        d=google.com; s=arc-20160816;
        b=jzZN/jwdA+NHjp7uhp9Lj4PK6pS3zJ6Uso1IlF5ExLFDMxuu9BXniuXAF2EDjJXwHK
         YJFGig+2w8JbV5Ytq7xOXjjJCLW/7zpZXqjjjMMisk7z57IthT8sRsb0krtQwYQ5avGd
         2rv3oMmmlkyZmnv6euQSX2oxLDl6GAKQSJcYQxuXqhF7uz4YYaLnBa3ggsJd26bbH4lN
         7y9OftU7jX8InoQWsqb08DzO74/k+ATxBFO9mWe0UGPauTrPoaAv3VK9ttEetjD+d677
         IEWKkFBjTqayt8iD3ORC3FutNKO/GqrSk3Ft3cTFZXT02rmwnSMwHX7x4xsy0NtneDem
         l+nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=L5pY2EO8xLfR8JQUfbFPSd2G8DZZ98Ms1oOiWnokmTw=;
        b=IdBE66Pvi5HCnNLN37eQaRaDEjm1wMLFk8PXO8Dc1S7hMh3GlMR7Z8CexKU6wj+MqI
         m8vIghCBKs59tWIvHRbS9RwGvfhtogo1duIGJfuV4oNJG6KE8aXgLrERx/BQFnvUCufv
         BpwPaDG9RNITXYnZJERXbyqoTgXsGsX60KOVdcIlzgQu36kiKd0vcdRbQzvk0/Nh6noT
         FWLeaGO0enDkK4KqsOKVYGxxlrSWrTaWIAeeH3mJ0BBT3AHvAPoVsrDCPgSLOM4XF86m
         Fp0XteWi1fxdlnoyPQ7GK+SC3MlL3kgTaEKiUCp47N0yMTN/fQEbkVOl7KYtgi2sP8l2
         22LQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 049/168] arm64: asid: Do not replace active_asids if already 0
Date: Wed, 11 Apr 2018 00:23:11 +0200
Message-Id: <20180410212802.290901705@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399921030279283?=
X-GMAIL-MSGID: =?utf-8?q?1597399921030279283?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Catalin Marinas <catalin.marinas@arm.com>


[ Upstream commit a8ffaaa060b8d4da6138e0958cb0f45b73e1cb78 ]

Under some uncommon timing conditions, a generation check and
xchg(active_asids, A1) in check_and_switch_context() on P1 can race with
an ASID roll-over on P2. If P2 has not seen the update to
active_asids[P1], it can re-allocate A1 to a new task T2 on P2. P1 ends
up waiting on the spinlock since the xchg() returned 0 while P2 can go
through a second ASID roll-over with (T2,A1,G2) active on P2. This
roll-over copies active_asids[P1] == A1,G1 into reserved_asids[P1] and
active_asids[P2] == A1,G2 into reserved_asids[P2]. A subsequent
scheduling of T1 on P1 and T2 on P2 would match reserved_asids and get
their generation bumped to G3:

P1					P2
--                                      --
TTBR0.BADDR = T0
TTBR0.ASID = A0
asid_generation = G1
check_and_switch_context(T1,A1,G1)
  generation match
					check_and_switch_context(T2,A0,G0)
 				          new_context()
					    ASID roll-over
					    asid_generation = G2
					    flush_context()
					      active_asids[P1] = 0
					      asid_map[A1] = 0
					      reserved_asids[P1] = A0,G0
  xchg(active_asids, A1)
    active_asids[P1] = A1,G1
    xchg returns 0
  spin_lock_irqsave()
					    allocated ASID (T2,A1,G2)
					    asid_map[A1] = 1
					  active_asids[P2] = A1,G2
					...
					check_and_switch_context(T3,A0,G0)
					  new_context()
					    ASID roll-over
					    asid_generation = G3
					    flush_context()
					      active_asids[P1] = 0
					      asid_map[A1] = 1
					      reserved_asids[P1] = A1,G1
					      reserved_asids[P2] = A1,G2
					    allocated ASID (T3,A2,G3)
					    asid_map[A2] = 1
					  active_asids[P2] = A2,G3
  new_context()
    check_update_reserved_asid(A1,G1)
      matches reserved_asid[P1]
      reserved_asid[P1] = A1,G3
  updated T1 ASID to (T1,A1,G3)
					check_and_switch_context(T2,A1,G2)
					  new_context()
					    check_and_switch_context(A1,G2)
					      matches reserved_asids[P2]
					      reserved_asids[P2] = A1,G3
					  updated T2 ASID to (T2,A1,G3)

At this point, we have two tasks, T1 and T2 both using ASID A1 with the
latest generation G3. Any of them is allowed to be scheduled on the
other CPU leading to two different tasks with the same ASID on the same
CPU.

This patch changes the xchg to cmpxchg so that the active_asids is only
updated if non-zero to avoid a race with an ASID roll-over on a
different CPU.

The ASID allocation algorithm has been formally verified using the TLA+
model checker (see
https://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/kernel-tla.git/tree/asidalloc.tla
for the spec).

Reviewed-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/mm/context.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -194,26 +194,29 @@ set_asid:
 void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
 {
 	unsigned long flags;
-	u64 asid;
+	u64 asid, old_active_asid;
 
 	asid = atomic64_read(&mm->context.id);
 
 	/*
 	 * The memory ordering here is subtle.
-	 * If our ASID matches the current generation, then we update
-	 * our active_asids entry with a relaxed xchg. Racing with a
-	 * concurrent rollover means that either:
+	 * If our active_asids is non-zero and the ASID matches the current
+	 * generation, then we update the active_asids entry with a relaxed
+	 * cmpxchg. Racing with a concurrent rollover means that either:
 	 *
-	 * - We get a zero back from the xchg and end up waiting on the
+	 * - We get a zero back from the cmpxchg and end up waiting on the
 	 *   lock. Taking the lock synchronises with the rollover and so
 	 *   we are forced to see the updated generation.
 	 *
-	 * - We get a valid ASID back from the xchg, which means the
+	 * - We get a valid ASID back from the cmpxchg, which means the
 	 *   relaxed xchg in flush_context will treat us as reserved
 	 *   because atomic RmWs are totally ordered for a given location.
 	 */
-	if (!((asid ^ atomic64_read(&asid_generation)) >> asid_bits)
-	    && atomic64_xchg_relaxed(&per_cpu(active_asids, cpu), asid))
+	old_active_asid = atomic64_read(&per_cpu(active_asids, cpu));
+	if (old_active_asid &&
+	    !((asid ^ atomic64_read(&asid_generation)) >> asid_bits) &&
+	    atomic64_cmpxchg_relaxed(&per_cpu(active_asids, cpu),
+				     old_active_asid, asid))
 		goto switch_mm_fastpath;
 
 	raw_spin_lock_irqsave(&cpu_asid_lock, flags);
