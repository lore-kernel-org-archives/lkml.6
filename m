Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F277FC6787A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 23:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A39B22077B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 23:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XEcshooR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A39B22077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbeJIHIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 03:08:49 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38505 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbeJIHIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 03:08:48 -0400
Received: by mail-pl1-f193.google.com with SMTP id b5-v6so10752196plr.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 16:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=O0ZPb2tlO7Hn1nCJyJMhk4AY3aS4w6sDZ47qGL8y5gw=;
        b=XEcshooRuDE+O1nrmUjD52EWl8dYYMZJZ76p3WQYOV4CXb0TXyIRpUKub4hs95i33Q
         CWx0GJnql9RMLyiUtNgXueBx8/dXIkim55ApN/wbhRyh7kd12dV5IhPz5bJN++cUxIMj
         rPj3ZmQ43SoLPrXdtl9jhmf+q3pqXHE0MXdAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=O0ZPb2tlO7Hn1nCJyJMhk4AY3aS4w6sDZ47qGL8y5gw=;
        b=ES8d/wUVHL58acrf15DVtH0nO8TvBikV6TACZNotDmAK0ohlLktstYKWwQoIKsavKw
         LyOWUAtf/gHdVFanVmmROfTJYhbMe2YX645rZ2LXKMF2VYv6pcVmPxBlC87Y+RKVVzc7
         sFCrFaNJEu0xw5j+mnd+TkupXFEuw9zGhcIGIvaMWMrUJllcN4dZtAsm4yH+0JHxn8Kn
         pm9PemdcuD9JjDDG92c9YMta2l9b4XuarX8l1ziAKyODkom3Pqal+Yx2fLeqR2n7RKPT
         dzWJsedNO3++SGHdvMipWC8ONsT5HT8rASZLbDYX47cTGqimVwuCLT+u2MxaUYReaObo
         k84Q==
X-Gm-Message-State: ABuFfojnQRF1UTTwCVUc2J0a2rp4GZ43Q5/6H+3fxinig4wZz0IZZjtJ
        p4O9dGgfIjubyWy7O/UninGxkQ==
X-Google-Smtp-Source: ACcGV63ek8aCqxPOF+as2QUs/WOszraIzlpal3u/P9LQ6c7sUwCY/jKb2YMP37Mq8rHAfUjoU8OT7A==
X-Received: by 2002:a17:902:9b84:: with SMTP id y4-v6mr26379649plp.332.1539042877024;
        Mon, 08 Oct 2018 16:54:37 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id s2-v6sm18811294pgo.90.2018.10.08.16.54.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 16:54:35 -0700 (PDT)
Date:   Mon, 8 Oct 2018 16:54:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Toshi Kani <toshi.kani@hpe.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/mm: Fix preallocated PMD stack array
Message-ID: <20181008235434.GA35035@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While trying to remove VLAs in pgd_alloc(), a typo was made and a use
of PREALLOCATED_PMDS was replaced with the new MAX_PREALLOCATED_USER_PMDS
(note "...USER..."). Instead, we also need a new MAX_PREALLOCATED_PMDS.
This adds it and fixes the stack array size.

Without this fix, 32-bit kernels would trip the stack protector at boot:

Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: pgd_alloc+0x29e/0x2a0
CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W         4.19.0-rc6+ #5
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.1-1 04/01/2014
Call Trace:
 dump_stack+0x66/0x95
 panic+0x94/0x1dd
 __stack_chk_fail+0x1e/0x20
 ? pgd_alloc+0x29e/0x2a0
 pgd_alloc+0x29e/0x2a0
 mm_init.isra.60+0x1ec/0x210
 mm_alloc+0x30/0x40
 __do_execve_file+0x378/0x930
 ? __do_execve_file+0x108/0x930
 ? kmem_cache_alloc+0x123/0x220
 do_execve+0x2c/0x30
 run_init_process+0x31/0x36
 ? rest_init+0xb0/0xb0
 try_to_run_init_process+0x11/0x33
 ? rest_init+0xb0/0xb0
 kernel_init+0x9e/0xda
 ret_from_fork+0x2e/0x38
Kernel Offset: disabled
---[ end Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: pgd_alloc+0x29e/0x2a0 ]---

Reported-by: Borislav Petkov <bp@alien8.de>
Fixes: 1be3f247c288 ("x86/mm: Avoid VLA in pgd_alloc()")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/mm/pgtable.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 386b43e3e0ac..59274e2c1ac4 100644
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
@@ -211,6 +214,7 @@ void pud_populate(struct mm_struct *mm, pud_t *pudp, pmd_t *pmd)
 
 /* No need to prepopulate any pagetable entries in non-PAE modes. */
 #define PREALLOCATED_PMDS	0
+#define MAX_PREALLOCATED_PMDS	0
 #define PREALLOCATED_USER_PMDS	 0
 #define MAX_PREALLOCATED_USER_PMDS 0
 #endif	/* CONFIG_X86_PAE */
@@ -431,7 +435,7 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	pgd_t *pgd;
 	pmd_t *u_pmds[MAX_PREALLOCATED_USER_PMDS];
-	pmd_t *pmds[MAX_PREALLOCATED_USER_PMDS];
+	pmd_t *pmds[MAX_PREALLOCATED_PMDS];
 
 	pgd = _pgd_alloc();
 
-- 
2.17.1


-- 
Kees Cook
Pixel Security
