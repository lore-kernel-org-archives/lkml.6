Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6479C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7405821526
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7405821526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbeHHADv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 20:03:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33891 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbeHHADv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 20:03:51 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w77LjqbQ1401637
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 7 Aug 2018 14:45:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w77LjpB41401633;
        Tue, 7 Aug 2018 14:45:51 -0700
Date:   Tue, 7 Aug 2018 14:45:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-30514effc9206d4e084ec32239ae221db157d43a@git.kernel.org>
Cc:     jroedel@suse.de, luto@kernel.org, jkosina@suse.cz, pavel@ucw.cz,
        peterz@infradead.org, llong@redhat.com, brgerst@gmail.com,
        hpa@zytor.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        boris.ostrovsky@oracle.com, dhgutteridge@sympatico.ca,
        jgross@suse.com, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, aarcange@redhat.com, bp@alien8.de,
        David.Laight@aculab.com, will.deacon@arm.com, tglx@linutronix.de,
        eduval@amazon.com, torvalds@linux-foundation.org,
        dvlasenk@redhat.com, jpoimboe@redhat.com
Reply-To: brgerst@gmail.com, hpa@zytor.com, llong@redhat.com,
          jkosina@suse.cz, jroedel@suse.de, luto@kernel.org,
          peterz@infradead.org, pavel@ucw.cz, dhgutteridge@sympatico.ca,
          jgross@suse.com, boris.ostrovsky@oracle.com,
          gregkh@linuxfoundation.org, mingo@kernel.org, bp@alien8.de,
          aarcange@redhat.com, linux-kernel@vger.kernel.org,
          dave.hansen@intel.com, jpoimboe@redhat.com, dvlasenk@redhat.com,
          torvalds@linux-foundation.org, tglx@linutronix.de,
          David.Laight@aculab.com, will.deacon@arm.com, eduval@amazon.com
In-Reply-To: <1533637471-30953-3-git-send-email-joro@8bytes.org>
References: <1533637471-30953-3-git-send-email-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/mm/pti: Don't clear permissions in
 pti_clone_pmd()
Git-Commit-ID: 30514effc9206d4e084ec32239ae221db157d43a
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

Commit-ID:  30514effc9206d4e084ec32239ae221db157d43a
Gitweb:     https://git.kernel.org/tip/30514effc9206d4e084ec32239ae221db157d43a
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Tue, 7 Aug 2018 12:24:30 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 7 Aug 2018 23:36:02 +0200

x86/mm/pti: Don't clear permissions in pti_clone_pmd()

The function sets the global-bit on cloned PMD entries, which only makes
sense when the permissions are identical between the user and the kernel
page-table. Further, only write-permissions are cleared for entry-text and
kernel-text sections, which are not writeable at the end of the boot
process.

The reason why this RW clearing exists is that in the early PTI
implementations the cloned kernel areas were set up during early boot
before the kernel text is set to read only and not touched afterwards.

This is not longer true. The cloned areas are still set up early to get the
entry code working for interrupts and other things, but after the kernel
text has been set RO the clone is repeated which copies the RO PMD/PTEs
over to the user visible clone. That means the initial clearing of the
writable bit can be avoided.

[ tglx: Amended changelog ]

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: linux-mm@kvack.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
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
Cc: "David H . Gutteridge" <dhgutteridge@sympatico.ca>
Cc: joro@8bytes.org
Link: https://lkml.kernel.org/r/1533637471-30953-3-git-send-email-joro@8bytes.org

---
 arch/x86/mm/pti.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 113ba14a03d8..5164c987b1f1 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -291,7 +291,7 @@ static void __init pti_setup_vsyscall(void) { }
 #endif
 
 static void
-pti_clone_pmds(unsigned long start, unsigned long end, pmdval_t clear)
+pti_clone_pmds(unsigned long start, unsigned long end)
 {
 	unsigned long addr;
 
@@ -352,7 +352,7 @@ pti_clone_pmds(unsigned long start, unsigned long end, pmdval_t clear)
 		 * tables will share the last-level page tables of this
 		 * address range
 		 */
-		*target_pmd = pmd_clear_flags(*pmd, clear);
+		*target_pmd = *pmd;
 	}
 }
 
@@ -398,7 +398,7 @@ static void __init pti_clone_user_shared(void)
 	start = CPU_ENTRY_AREA_BASE;
 	end   = start + (PAGE_SIZE * CPU_ENTRY_AREA_PAGES);
 
-	pti_clone_pmds(start, end, 0);
+	pti_clone_pmds(start, end);
 }
 #endif /* CONFIG_X86_64 */
 
@@ -418,8 +418,7 @@ static void __init pti_setup_espfix64(void)
 static void pti_clone_entry_text(void)
 {
 	pti_clone_pmds((unsigned long) __entry_text_start,
-			(unsigned long) __irqentry_text_end,
-		       _PAGE_RW);
+		       (unsigned long) __irqentry_text_end);
 }
 
 /*
@@ -501,7 +500,7 @@ static void pti_clone_kernel_text(void)
 	 * pti_set_kernel_image_nonglobal() did to clear the
 	 * global bit.
 	 */
-	pti_clone_pmds(start, end_clone, _PAGE_RW);
+	pti_clone_pmds(start, end_clone);
 
 	/*
 	 * pti_clone_pmds() will set the global bit in any PMDs
