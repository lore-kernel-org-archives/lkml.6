Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E23713F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C378620870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:00:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C378620870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbeG3Nej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 09:34:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43897 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbeG3Nej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 09:34:39 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6UBwwSt2294557
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 30 Jul 2018 04:58:58 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6UBwvDS2294554;
        Mon, 30 Jul 2018 04:58:57 -0700
Date:   Mon, 30 Jul 2018 04:58:57 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-ca38dc8f2724d101038b1205122c93a1c7f38f11@git.kernel.org>
Cc:     aarcange@redhat.com, boris.ostrovsky@oracle.com, llong@redhat.com,
        dave.hansen@intel.com, namhyung@kernel.org,
        torvalds@linux-foundation.org, eduval@amazon.com, bp@alien8.de,
        dhgutteridge@sympatico.ca, gregkh@linuxfoundation.org,
        acme@kernel.org, jolsa@redhat.com, jgross@suse.com,
        tglx@linutronix.de, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, dvlasenk@redhat.com,
        jroedel@suse.de, David.Laight@aculab.com, hpa@zytor.com,
        will.deacon@arm.com, jpoimboe@redhat.com, luto@kernel.org,
        brgerst@gmail.com, linux-kernel@vger.kernel.org, jkosina@suse.cz,
        pavel@ucw.cz, peterz@infradead.org
Reply-To: dave.hansen@intel.com, llong@redhat.com,
          boris.ostrovsky@oracle.com, aarcange@redhat.com,
          torvalds@linux-foundation.org, namhyung@kernel.org,
          eduval@amazon.com, gregkh@linuxfoundation.org,
          dhgutteridge@sympatico.ca, bp@alien8.de, acme@kernel.org,
          jgross@suse.com, jolsa@redhat.com, tglx@linutronix.de,
          dvlasenk@redhat.com, alexander.shishkin@linux.intel.com,
          mingo@kernel.org, David.Laight@aculab.com, jroedel@suse.de,
          jpoimboe@redhat.com, will.deacon@arm.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, luto@kernel.org, brgerst@gmail.com,
          peterz@infradead.org, pavel@ucw.cz, jkosina@suse.cz
In-Reply-To: <1532533683-5988-4-git-send-email-joro@8bytes.org>
References: <1532533683-5988-4-git-send-email-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/kexec: Allocate 8k PGDs for PTI
Git-Commit-ID: ca38dc8f2724d101038b1205122c93a1c7f38f11
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  ca38dc8f2724d101038b1205122c93a1c7f38f11
Gitweb:     https://git.kernel.org/tip/ca38dc8f2724d101038b1205122c93a1c7f38f11
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Wed, 25 Jul 2018 17:48:03 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 30 Jul 2018 13:53:48 +0200

x86/kexec: Allocate 8k PGDs for PTI

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
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: David H. Gutteridge <dhgutteridge@sympatico.ca>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: linux-mm@kvack.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: David Laight <David.Laight@aculab.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Eduardo Valentin <eduval@amazon.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: aliguori@amazon.com
Cc: daniel.gruss@iaik.tugraz.at
Cc: hughd@google.com
Cc: keescook@google.com
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Waiman Long <llong@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: joro@8bytes.org
Link: https://lkml.kernel.org/r/1532533683-5988-4-git-send-email-joro@8bytes.org

---
 arch/x86/kernel/machine_kexec_32.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_kexec_32.c
index d1ab07ec8c9a..5409c2800ab5 100644
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
