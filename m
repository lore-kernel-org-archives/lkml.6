Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698C4ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19EF220850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="rNd8Jar5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19EF220850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731748AbeGRKSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:18:40 -0400
Received: from 8bytes.org ([81.169.241.247]:54154 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731731AbeGRKSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:18:39 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 39C201B24; Wed, 18 Jul 2018 11:41:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1531906884; bh=2V0XCeOUnRlODFqALspBJ8CBUOtjUtaImRZ6+JHIei8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rNd8Jar55gKfAMr4Yu8B+/5ju7NlduhGvUHE0RZkD+96CBLyo0mMjWQVxWhW3gcFq
         T30viFXW4VhpDJbQhe8w6xFBtk3wrbaKsonQxILNPUOXruT4F+n92xT31m1ScgOWCI
         qTMKB/908rBm/OB4tj2SqCTJM6rbDnFwKBtDINhHZAgSXhb8ndgFm9aan2q/A2zaHH
         7ia0qpt3SHVdN9voiez6BVhNWeetx5508+/d9nRarYsJ9lzx4ecG8HeL/xknmkz5o0
         jLHdY1UufWuPypa68+3P7Jf73Trr1BJk7BratOTaFXE1UKamRKftMxHIENE8HBOrxk
         IlwU9lOVI7gew==
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
Subject: [PATCH 30/39] x86/mm/pti: Clone entry-text again in pti_finalize()
Date:   Wed, 18 Jul 2018 11:41:07 +0200
Message-Id: <1531906876-13451-31-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531906876-13451-1-git-send-email-joro@8bytes.org>
References: <1531906876-13451-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The mapping for entry-text might have changed in the kernel
after it was cloned to the user page-table. Clone again
to update the user page-table to bring the mapping in sync
with the kernel again.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/mm/pti.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 1825f30..b879ccd 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -404,7 +404,7 @@ static void __init pti_setup_espfix64(void)
 /*
  * Clone the populated PMDs of the entry and irqentry text and force it RO.
  */
-static void __init pti_clone_entry_text(void)
+static void pti_clone_entry_text(void)
 {
 	pti_clone_pmds((unsigned long) __entry_text_start,
 			(unsigned long) __irqentry_text_end,
@@ -528,13 +528,18 @@ void __init pti_init(void)
 }
 
 /*
- * Finalize the kernel mappings in the userspace page-table.
+ * Finalize the kernel mappings in the userspace page-table. Some of the
+ * mappings for the kernel image might have changed since pti_init()
+ * cloned them. This is because parts of the kernel image have been
+ * mapped RO and/or NX.  These changes need to be cloned again to the
+ * userspace page-table.
  */
 void pti_finalize(void)
 {
 	/*
-	 * Do this after all of the manipulation of the
-	 * kernel text page tables are complete.
+	 * We need to clone everything (again) that maps parts of the
+	 * kernel image.
 	 */
+	pti_clone_entry_text();
 	pti_clone_kernel_text();
 }
-- 
2.7.4

