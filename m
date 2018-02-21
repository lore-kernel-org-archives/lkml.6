Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224UfNuYOP/JdI5UNYIW4ONjyLZrnBZsnukHusVfby1MrTJ9VnDdsQAICMD10hvNzr8Nty6l
ARC-Seal: i=1; a=rsa-sha256; t=1519218209; cv=none;
        d=google.com; s=arc-20160816;
        b=NB/GGYmGKr3YyHmK0x3No2txEu+ESsPijxCAtwLKyXAFzBMzH9h7zN+05N3hD/Ehao
         7G3CGP3Cw0x8Mc3bwF4qVKLS25gEQsc5y9Z1sM9wyMesk9piInUN9JPUZK5GLjwY8SAN
         H3/F873SEaT5Gu2Ub4YwPC7+4yRkJAvvD5C8GrV+bt01ereuLqa1VOr9UCv+plJvWk+j
         Dm5GMKh14MUKqaPHwMZ7rmYECF74IY81C7u99PViPnEMj7T8vUh5t0zyagpLCMsgOyvR
         CoEN43c5ZdBVVsDZWhKqciwMsQezjs6TOIkHg11Z8qm6KmBvIXSQqaZfOUJCo6b1oE4u
         IcYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=BxmgyqjYDzC7bzmBeDjP5gUCOnoBOaNLXbro+95xQBk=;
        b=viYVzcKkkW8zm175BQj3o9hWgXySPvOua+T0PeqJgm3gOnm5fWiE1EouZp7g3HW3Zf
         Idayy8w5D1s09Al5DaEMg/N7BMj4clz7/4DuA+zfIqVrq5essjXkEoBppJdT5kPOi5Lp
         ejAkrE0bFsVfFXc3EYy1owHgJ+z31ZuzJ8i/O8/7PM4Pj6p6fX+NJJsQs0iZ5UH5pVsq
         IDmNe2RaGCvPt81T4oGSJvEVhbUolYHHA9X+FCuPArrrs21nEbFJK8vIcR59fI9Tk1BJ
         S0NwsGfMV8Ote3fUsPyvTP946wnauNi1NI78rM9prxIltuCZmrMVwuo7dObbKuE3/c32
         uw7w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.14 125/167] arm64: proc: Set PTE_NG for table entries to avoid traversing them twice
Date: Wed, 21 Feb 2018 13:48:56 +0100
Message-Id: <20180221124531.396947267@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015752592250801?=
X-GMAIL-MSGID: =?utf-8?q?1593015752592250801?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>

commit 2ce77f6d8a9ae9ce6d80397d88bdceb84a2004cd upstream.

When KASAN is enabled, the swapper page table contains many identical
mappings of the zero page, which can lead to a stall during boot whilst
the G -> nG code continually walks the same page table entries looking
for global mappings.

This patch sets the nG bit (bit 11, which is IGNORED) in table entries
after processing the subtree so we can easily skip them if we see them
a second time.

Tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/mm/proc.S |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -190,7 +190,8 @@ ENDPROC(idmap_cpu_replace_ttbr1)
 	dc	cvac, cur_\()\type\()p		// Ensure any existing dirty
 	dmb	sy				// lines are written back before
 	ldr	\type, [cur_\()\type\()p]	// loading the entry
-	tbz	\type, #0, next_\()\type	// Skip invalid entries
+	tbz	\type, #0, skip_\()\type	// Skip invalid and
+	tbnz	\type, #11, skip_\()\type	// non-global entries
 	.endm
 
 	.macro __idmap_kpti_put_pgtable_ent_ng, type
@@ -249,8 +250,9 @@ ENTRY(idmap_kpti_install_ng_mappings)
 	add	end_pgdp, cur_pgdp, #(PTRS_PER_PGD * 8)
 do_pgd:	__idmap_kpti_get_pgtable_ent	pgd
 	tbnz	pgd, #1, walk_puds
-	__idmap_kpti_put_pgtable_ent_ng	pgd
 next_pgd:
+	__idmap_kpti_put_pgtable_ent_ng	pgd
+skip_pgd:
 	add	cur_pgdp, cur_pgdp, #8
 	cmp	cur_pgdp, end_pgdp
 	b.ne	do_pgd
@@ -278,8 +280,9 @@ walk_puds:
 	add	end_pudp, cur_pudp, #(PTRS_PER_PUD * 8)
 do_pud:	__idmap_kpti_get_pgtable_ent	pud
 	tbnz	pud, #1, walk_pmds
-	__idmap_kpti_put_pgtable_ent_ng	pud
 next_pud:
+	__idmap_kpti_put_pgtable_ent_ng	pud
+skip_pud:
 	add	cur_pudp, cur_pudp, 8
 	cmp	cur_pudp, end_pudp
 	b.ne	do_pud
@@ -298,8 +301,9 @@ walk_pmds:
 	add	end_pmdp, cur_pmdp, #(PTRS_PER_PMD * 8)
 do_pmd:	__idmap_kpti_get_pgtable_ent	pmd
 	tbnz	pmd, #1, walk_ptes
-	__idmap_kpti_put_pgtable_ent_ng	pmd
 next_pmd:
+	__idmap_kpti_put_pgtable_ent_ng	pmd
+skip_pmd:
 	add	cur_pmdp, cur_pmdp, #8
 	cmp	cur_pmdp, end_pmdp
 	b.ne	do_pmd
@@ -317,7 +321,7 @@ walk_ptes:
 	add	end_ptep, cur_ptep, #(PTRS_PER_PTE * 8)
 do_pte:	__idmap_kpti_get_pgtable_ent	pte
 	__idmap_kpti_put_pgtable_ent_ng	pte
-next_pte:
+skip_pte:
 	add	cur_ptep, cur_ptep, #8
 	cmp	cur_ptep, end_ptep
 	b.ne	do_pte
