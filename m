Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9A2C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F5A20835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUSopYhv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88F5A20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbeJKQko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 12:40:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45322 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbeJKQko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 12:40:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id q5-v6so8781922wrw.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 02:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=MFPPl+fwIKsr0uLSnUhlbiHIz6S6TEHe8aIJT2FPQSk=;
        b=KUSopYhvUDCqJJ3T48TOyC85YLDExZBwiXq4oDm8ckbQxl3qknGmNFQWvqki/xoQNZ
         IvixmxvYTBJNqAnf7oPM2Ca5/pgan7WL4vPNW5VsjDhh/slo3ozdrjH10kzGkEz5EUd2
         9OjXe+t10YZkIYAMjIWFcKSPFpcX7fFyIra3PecfrTuooP6l5RUrgMmBKYe3FikG3Eol
         8Jwh5tAQ7YlvmJHYg99LVb4AOW441XkmyVWsCBiRjIoQVd9yuNAMwiDq+baSYXj+1F03
         YjhQDmeyX8fmRmbJ/07K07vI0OlkUnIUx0CRxbLxc+rV+SVchcEP0zBFdoqvQ1iCkbnm
         BUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=MFPPl+fwIKsr0uLSnUhlbiHIz6S6TEHe8aIJT2FPQSk=;
        b=SAtt5a7vvU/GSKQXC6nnflR6ZOewVz9+zMcKJ+KlmvjgHhrvLMfhqQtZTMycS5C/GD
         KxxRMtRpdjvo6AOHxP6ZBQZDP9HF+BdpuVG8/QW+qEUZtLuoXeuKdbqZtxA+h5Rz4YMf
         6P+ehH4JB/R0vMFUELrocdkOTS2oiN+RRioDlYYKC4J/wIW8C5lgllhljsn6ZpZ0AgYU
         1FWn7cwpVvzLsiYG9zOPwiJB+906fmJtDEwtctoqBvsdNwvAVHzVEw1QMZa60WMY4m5H
         SNowO/Tw/LZJWpNgmDMANHiAoh62maN4AsE8LTKkWhxbb9T+vhrSEyQtGwyHgHkR0DUf
         1CKg==
X-Gm-Message-State: ABuFfogwh53LUgXk2OhdIy57k8d/P6ZwqjTGhvo1w8pLgKF9fRPixexX
        ReuMGw08c913qibL7dmuk20=
X-Google-Smtp-Source: ACcGV62CjMavAOXHhDT7Q8EyXz/9rnNRPvFFg6zWqeDegV+1QGRQUC15HHd887aoTQ8Cw/7F41VnCg==
X-Received: by 2002:adf:b64e:: with SMTP id i14-v6mr824566wre.14.1539249259221;
        Thu, 11 Oct 2018 02:14:19 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id e6-v6sm23991512wrc.70.2018.10.11.02.14.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 02:14:18 -0700 (PDT)
Date:   Thu, 11 Oct 2018 11:14:16 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86 fixes
Message-ID: <20181011091416.GA79390@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

Please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

   # HEAD: 184d47f0fd365108bd06ab26cdb3450b716269fd x86/mm: Avoid VLA in pgd_alloc()

An intel_rdt memory access fix and a VLA fix in pgd_alloc().

 Thanks,

	Ingo

------------------>
Kees Cook (1):
      x86/mm: Avoid VLA in pgd_alloc()

Reinette Chatre (1):
      x86/intel_rdt: Fix out-of-bounds memory access in CBM tests


 arch/x86/kernel/cpu/intel_rdt.h             |  6 ++---
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 20 ++++++++--------
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c    | 36 ++++++++++++++++++-----------
 arch/x86/mm/pgtable.c                       | 10 ++++++--
 4 files changed, 45 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 285eb3ec4200..3736f6dc9545 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -529,14 +529,14 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 int rdtgroup_schemata_show(struct kernfs_open_file *of,
 			   struct seq_file *s, void *v);
 bool rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
-			   u32 _cbm, int closid, bool exclusive);
+			   unsigned long cbm, int closid, bool exclusive);
 unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r, struct rdt_domain *d,
-				  u32 cbm);
+				  unsigned long cbm);
 enum rdtgrp_mode rdtgroup_mode_by_closid(int closid);
 int rdtgroup_tasks_assigned(struct rdtgroup *r);
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
 int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp);
-bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_domain *d, u32 _cbm);
+bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_domain *d, unsigned long cbm);
 bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d);
 int rdt_pseudo_lock_init(void);
 void rdt_pseudo_lock_release(void);
diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index 40f3903ae5d9..f8c260d522ca 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -797,25 +797,27 @@ int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp)
 /**
  * rdtgroup_cbm_overlaps_pseudo_locked - Test if CBM or portion is pseudo-locked
  * @d: RDT domain
- * @_cbm: CBM to test
+ * @cbm: CBM to test
  *
- * @d represents a cache instance and @_cbm a capacity bitmask that is
- * considered for it. Determine if @_cbm overlaps with any existing
+ * @d represents a cache instance and @cbm a capacity bitmask that is
+ * considered for it. Determine if @cbm overlaps with any existing
  * pseudo-locked region on @d.
  *
- * Return: true if @_cbm overlaps with pseudo-locked region on @d, false
+ * @cbm is unsigned long, even if only 32 bits are used, to make the
+ * bitmap functions work correctly.
+ *
+ * Return: true if @cbm overlaps with pseudo-locked region on @d, false
  * otherwise.
  */
-bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_domain *d, u32 _cbm)
+bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_domain *d, unsigned long cbm)
 {
-	unsigned long *cbm = (unsigned long *)&_cbm;
-	unsigned long *cbm_b;
 	unsigned int cbm_len;
+	unsigned long cbm_b;
 
 	if (d->plr) {
 		cbm_len = d->plr->r->cache.cbm_len;
-		cbm_b = (unsigned long *)&d->plr->cbm;
-		if (bitmap_intersects(cbm, cbm_b, cbm_len))
+		cbm_b = d->plr->cbm;
+		if (bitmap_intersects(&cbm, &cbm_b, cbm_len))
 			return true;
 	}
 	return false;
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 1b8e86a5d5e1..b140c68bc14b 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -975,33 +975,34 @@ static int rdtgroup_mode_show(struct kernfs_open_file *of,
  * is false then overlaps with any resource group or hardware entities
  * will be considered.
  *
+ * @cbm is unsigned long, even if only 32 bits are used, to make the
+ * bitmap functions work correctly.
+ *
  * Return: false if CBM does not overlap, true if it does.
  */
 bool rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
-			   u32 _cbm, int closid, bool exclusive)
+			   unsigned long cbm, int closid, bool exclusive)
 {
-	unsigned long *cbm = (unsigned long *)&_cbm;
-	unsigned long *ctrl_b;
 	enum rdtgrp_mode mode;
+	unsigned long ctrl_b;
 	u32 *ctrl;
 	int i;
 
 	/* Check for any overlap with regions used by hardware directly */
 	if (!exclusive) {
-		if (bitmap_intersects(cbm,
-				      (unsigned long *)&r->cache.shareable_bits,
-				      r->cache.cbm_len))
+		ctrl_b = r->cache.shareable_bits;
+		if (bitmap_intersects(&cbm, &ctrl_b, r->cache.cbm_len))
 			return true;
 	}
 
 	/* Check for overlap with other resource groups */
 	ctrl = d->ctrl_val;
 	for (i = 0; i < closids_supported(); i++, ctrl++) {
-		ctrl_b = (unsigned long *)ctrl;
+		ctrl_b = *ctrl;
 		mode = rdtgroup_mode_by_closid(i);
 		if (closid_allocated(i) && i != closid &&
 		    mode != RDT_MODE_PSEUDO_LOCKSETUP) {
-			if (bitmap_intersects(cbm, ctrl_b, r->cache.cbm_len)) {
+			if (bitmap_intersects(&cbm, &ctrl_b, r->cache.cbm_len)) {
 				if (exclusive) {
 					if (mode == RDT_MODE_EXCLUSIVE)
 						return true;
@@ -1138,15 +1139,18 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
  * computed by first dividing the total cache size by the CBM length to
  * determine how many bytes each bit in the bitmask represents. The result
  * is multiplied with the number of bits set in the bitmask.
+ *
+ * @cbm is unsigned long, even if only 32 bits are used to make the
+ * bitmap functions work correctly.
  */
 unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
-				  struct rdt_domain *d, u32 cbm)
+				  struct rdt_domain *d, unsigned long cbm)
 {
 	struct cpu_cacheinfo *ci;
 	unsigned int size = 0;
 	int num_b, i;
 
-	num_b = bitmap_weight((unsigned long *)&cbm, r->cache.cbm_len);
+	num_b = bitmap_weight(&cbm, r->cache.cbm_len);
 	ci = get_cpu_cacheinfo(cpumask_any(&d->cpu_mask));
 	for (i = 0; i < ci->num_leaves; i++) {
 		if (ci->info_list[i].level == r->cache_level) {
@@ -2353,6 +2357,7 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 	u32 used_b = 0, unused_b = 0;
 	u32 closid = rdtgrp->closid;
 	struct rdt_resource *r;
+	unsigned long tmp_cbm;
 	enum rdtgrp_mode mode;
 	struct rdt_domain *d;
 	int i, ret;
@@ -2390,9 +2395,14 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 			 * modify the CBM based on system availability.
 			 */
 			cbm_ensure_valid(&d->new_ctrl, r);
-			if (bitmap_weight((unsigned long *) &d->new_ctrl,
-					  r->cache.cbm_len) <
-					r->cache.min_cbm_bits) {
+			/*
+			 * Assign the u32 CBM to an unsigned long to ensure
+			 * that bitmap_weight() does not access out-of-bound
+			 * memory.
+			 */
+			tmp_cbm = d->new_ctrl;
+			if (bitmap_weight(&tmp_cbm, r->cache.cbm_len) <
+			    r->cache.min_cbm_bits) {
 				rdt_last_cmd_printf("no space on %s:%d\n",
 						    r->name, d->id);
 				return -ENOSPC;
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 089e78c4effd..59274e2c1ac4 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -115,6 +115,8 @@ static inline void pgd_list_del(pgd_t *pgd)
 
 #define UNSHARED_PTRS_PER_PGD				\
 	(SHARED_KERNEL_PMD ? KERNEL_PGD_BOUNDARY : PTRS_PER_PGD)
+#define MAX_UNSHARED_PTRS_PER_PGD			\
+	max_t(size_t, KERNEL_PGD_BOUNDARY, PTRS_PER_PGD)
 
 
 static void pgd_set_mm(pgd_t *pgd, struct mm_struct *mm)
@@ -181,6 +183,7 @@ static void pgd_dtor(pgd_t *pgd)
  * and initialize the kernel pmds here.
  */
 #define PREALLOCATED_PMDS	UNSHARED_PTRS_PER_PGD
+#define MAX_PREALLOCATED_PMDS	MAX_UNSHARED_PTRS_PER_PGD
 
 /*
  * We allocate separate PMDs for the kernel part of the user page-table
@@ -189,6 +192,7 @@ static void pgd_dtor(pgd_t *pgd)
  */
 #define PREALLOCATED_USER_PMDS	 (static_cpu_has(X86_FEATURE_PTI) ? \
 					KERNEL_PGD_PTRS : 0)
+#define MAX_PREALLOCATED_USER_PMDS KERNEL_PGD_PTRS
 
 void pud_populate(struct mm_struct *mm, pud_t *pudp, pmd_t *pmd)
 {
@@ -210,7 +214,9 @@ void pud_populate(struct mm_struct *mm, pud_t *pudp, pmd_t *pmd)
 
 /* No need to prepopulate any pagetable entries in non-PAE modes. */
 #define PREALLOCATED_PMDS	0
+#define MAX_PREALLOCATED_PMDS	0
 #define PREALLOCATED_USER_PMDS	 0
+#define MAX_PREALLOCATED_USER_PMDS 0
 #endif	/* CONFIG_X86_PAE */
 
 static void free_pmds(struct mm_struct *mm, pmd_t *pmds[], int count)
@@ -428,8 +434,8 @@ static inline void _pgd_free(pgd_t *pgd)
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	pgd_t *pgd;
-	pmd_t *u_pmds[PREALLOCATED_USER_PMDS];
-	pmd_t *pmds[PREALLOCATED_PMDS];
+	pmd_t *u_pmds[MAX_PREALLOCATED_USER_PMDS];
+	pmd_t *pmds[MAX_PREALLOCATED_PMDS];
 
 	pgd = _pgd_alloc();
 
