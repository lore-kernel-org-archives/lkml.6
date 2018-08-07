Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446DFC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 10:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B312170A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 10:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="O36mKEnR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6B312170A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388795AbeHGMiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 08:38:15 -0400
Received: from 8bytes.org ([81.169.241.247]:60890 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726968AbeHGMiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 08:38:14 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 997C32F5; Tue,  7 Aug 2018 12:24:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1533637473; bh=Hj+SU0Qi3gZNMXnmPL7TuoJ+PAqH5xoY7fEQcBwdn6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O36mKEnRWyC79mRhCh+IPXmc77EAS47qmqWnud68YuK+bTATmtwKgih5zHkOixjf4
         e9mVudDghe9YdMTU7R+8G2K+uP/n1rpu46WC2St5KwunHzxWiWDN1tCo8kuRBv4Mnd
         V0ibcAkf2cAjJMlVOSQUaHv/K4VV+UW6NKW4s8xi/BBE2S9cvfLiznD5wHXMw8q0l+
         3DdLOnQranBg0zwlJTGKzwLgZ78AtcLWCFz1OzgAm2CXNzhpmKihlOqLhzUOkNKpuZ
         oQri8X7dZhYpTP+MUQV1UU8vFehR9VsUb5dYI5mw66uWg2ShlJpZcGjBfaVrKgaITH
         blQRNyoL9YtmA==
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
        jroedel@suse.de, joro@8bytes.org
Subject: [PATCH 2/3] x86/mm/pti: Don't clear permissions in pti_clone_pmd()
Date:   Tue,  7 Aug 2018 12:24:30 +0200
Message-Id: <1533637471-30953-3-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533637471-30953-1-git-send-email-joro@8bytes.org>
References: <1533637471-30953-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The function sets the global-bit on cloned PMD entries,
which only makes sense when the permissions are identical
between the user and the kernel page-table.

Further, only write-permissions are cleared for entry-text
and kernel-text sections, which are not writeable anyway.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/mm/pti.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 113ba14..5164c98 100644
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
-- 
2.7.4

