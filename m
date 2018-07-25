Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DFEECDE5F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D3F204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="jWvJ76oN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91D3F204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbeGYRAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:00:37 -0400
Received: from 8bytes.org ([81.169.241.247]:40220 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728360AbeGYRAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:00:37 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id D9F372DF; Wed, 25 Jul 2018 17:48:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1532533699; bh=7uyJQGX9MH9cxdB/eSz9dqZtNfQZQYIzfaEbxYSk570=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jWvJ76oNSjsoIEonhak0wCu79+mD3+lH8iEegZ2evNmKO+cqf2NAIgHNfcKAMaf/a
         MwEA8Nmk4a36mKs1n/PTDVMNm2lbnbqUzO8yVgmf5QPOFm/saH6ykWhxrPA1/ua4rQ
         jcfBBfX4noPHzUHxiqVdpkXt3zjYVsmYMFnvcPNkVJbkqpPIDyC98hRITyAH2mvxhX
         Dz8rmMkMDrQGy2YlBi05whtLt7MmvrCzvXCkNig/FKr5J0XFZ6B8xWjhcAFraBcj9l
         9QaqO1QXQT/Ghrq9msDwWKdx4gjaCnXVe+LKKXJ3G2xG+JjaZmiVNAdnEC2ReocCF4
         0xZCnx2vRRXpw==
From:   Joerg Roedel <joro@8bytes.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>, aliguori@amazon.com,
        daniel.gruss@iaik.tugraz.at, hughd@google.com, keescook@google.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>,
        jroedel@suse.de, Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, joro@8bytes.org
Subject: [PATCH 3/3] x86/kexec: Allocate 8k PGDs for PTI
Date:   Wed, 25 Jul 2018 17:48:03 +0200
Message-Id: <1532533683-5988-4-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532533683-5988-1-git-send-email-joro@8bytes.org>
References: <1532533683-5988-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Fuzzing the PTI-x86-32 code with trinity showed unhandled
kernel paging request oops-messages that looked a lot like
silent data corruption.

Lot's of debugging and testing lead to the kexec-32bit code,
which is still allocating 4k PGDs when PTI is enabled. But
since it uses native_set_pud() to build the page-table, it
will unevitably call into __pti_set_user_pgtbl(), which
writes beyond the allocated 4k page.

Use PGD_ALLOCATION_ORDER to allocate PGDs in the kexec code
to fix the issue.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/machine_kexec_32.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_kexec_32.c
index d1ab07e..5409c28 100644
--- a/arch/x86/kernel/machine_kexec_32.c
+++ b/arch/x86/kernel/machine_kexec_32.c
@@ -56,7 +56,7 @@ static void load_segments(void)
 
 static void machine_kexec_free_page_tables(struct kimage *image)
 {
-	free_page((unsigned long)image->arch.pgd);
+	free_pages((unsigned long)image->arch.pgd, PGD_ALLOCATION_ORDER);
 	image->arch.pgd = NULL;
 #ifdef CONFIG_X86_PAE
 	free_page((unsigned long)image->arch.pmd0);
@@ -72,7 +72,8 @@ static void machine_kexec_free_page_tables(struct kimage *image)
 
 static int machine_kexec_alloc_page_tables(struct kimage *image)
 {
-	image->arch.pgd = (pgd_t *)get_zeroed_page(GFP_KERNEL);
+	image->arch.pgd = (pgd_t *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
+						    PGD_ALLOCATION_ORDER);
 #ifdef CONFIG_X86_PAE
 	image->arch.pmd0 = (pmd_t *)get_zeroed_page(GFP_KERNEL);
 	image->arch.pmd1 = (pmd_t *)get_zeroed_page(GFP_KERNEL);
-- 
2.7.4

