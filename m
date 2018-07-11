Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F23FC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55FED208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="kODeHpl7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55FED208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733182AbeGKLeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:34:50 -0400
Received: from 8bytes.org ([81.169.241.247]:37770 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733050AbeGKLeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:34:13 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id CC92B399F; Wed, 11 Jul 2018 13:30:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1531308607; bh=2V0XCeOUnRlODFqALspBJ8CBUOtjUtaImRZ6+JHIei8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kODeHpl7UsQbPsWyx6FcWfUrNwf2paoUi3eCZ4Ds3yPqUqC9EUpHB8sTofIoQhHfl
         BolLeB2kYCiq9ko+PWYQIR0J7/vKbmk/yRXNAEJim1yY1Jn+09XQXu338yXpFabV29
         p/zdSvYZqlrat96Zl1lxiRVO9hqSC9Be+jldy45UbM2CarCJIjjr5WlnUBhTtZmz3P
         iRxv5FMNsGHX0qGad90XridEHHbvIOu3F0U9GQhrI7qIXueE/VaIIz9BhTYHY6WZPD
         DXUJ5rztB2FSOv/7r7Cky3li9uhmUuVZtBLqo9Zo5MWAeOwZgFKfbJm05BeiDUjARn
         YKnv4mhU+Pasw==
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
Date:   Wed, 11 Jul 2018 13:29:37 +0200
Message-Id: <1531308586-29340-31-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531308586-29340-1-git-send-email-joro@8bytes.org>
References: <1531308586-29340-1-git-send-email-joro@8bytes.org>
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

