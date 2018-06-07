Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id UmrFE3hLGVs9WwAAmS7hNA
	; Thu, 07 Jun 2018 15:13:32 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5CC506089E; Thu,  7 Jun 2018 15:13:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 18381601B4;
	Thu,  7 Jun 2018 15:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 18381601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964891AbeFGPCQ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:02:16 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41431 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935113AbeFGPCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:02:10 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbY-0005hJ-SX; Thu, 07 Jun 2018 15:09:33 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb9-00036a-9j; Thu, 07 Jun 2018 15:09:07 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Andy Lutomirski" <luto@kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Juergen Gross" <jgross@suse.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        "Denys Vlasenko" <dvlasenk@redhat.com>,
        "Jan Beulich" <JBeulich@suse.com>,
        "Ingo Molnar" <mingo@kernel.org>,
        "Brian Gerst" <brgerst@gmail.com>,
        "Jan Beulich" <jbeulich@suse.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Borislav Petkov" <bp@alien8.de>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.494514515@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 273/410] x86/mm: Fix {pmd,pud}_{set,clear}_flags()
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Beulich <JBeulich@suse.com>

commit 842cef9113c2120f74f645111ded1e020193d84c upstream.

Just like pte_{set,clear}_flags() their PMD and PUD counterparts should
not do any address translation. This was outright wrong under Xen
(causing a dead boot with no useful output on "suitable" systems), and
produced needlessly more complicated code (even if just slightly) when
paravirt was enabled.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/5A8AF1BB02000078001A91C3@prv-mh.provo.novell.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
[bwh: Backported to 3.16:
 - There aren't any pud_{set,clear}_flags() functions
 - There's no p4d level]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -263,14 +263,14 @@ static inline pmd_t pmd_set_flags(pmd_t
 {
 	pmdval_t v = native_pmd_val(pmd);
 
-	return __pmd(v | set);
+	return native_make_pmd(v | set);
 }
 
 static inline pmd_t pmd_clear_flags(pmd_t pmd, pmdval_t clear)
 {
 	pmdval_t v = native_pmd_val(pmd);
 
-	return __pmd(v & ~clear);
+	return native_make_pmd(v & ~clear);
 }
 
 static inline pmd_t pmd_mkold(pmd_t pmd)
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -321,6 +321,11 @@ static inline pmdval_t native_pmd_val(pm
 #else
 #include <asm-generic/pgtable-nopmd.h>
 
+static inline pmd_t native_make_pmd(pmdval_t val)
+{
+	return (pmd_t) { .pud.pgd = native_make_pgd(val) };
+}
+
 static inline pmdval_t native_pmd_val(pmd_t pmd)
 {
 	return native_pgd_val(pmd.pud.pgd);
