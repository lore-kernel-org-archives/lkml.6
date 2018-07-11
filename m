Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E146C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03AFA208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="KfJeW5hD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03AFA208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732996AbeGKLeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:34:09 -0400
Received: from 8bytes.org ([81.169.241.247]:37802 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732754AbeGKLeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:34:08 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 76D2AA96; Wed, 11 Jul 2018 13:30:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1531308605; bh=48FBcw49wasOWCwH8N3EK5w1EL7mm104AhYjmxHQeP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KfJeW5hDKT7/C0YgavPyjFwVxsz1FtHUIseocuccPONPqhFDNO/07dvP5XgUQJFAF
         XllvsDt4ExWuliArFKKumHJP9OEdFf7G3E80o0RjAFGurKWdsL2zliZY+bUNTChN6M
         MeXaucRwEkKGhY9w0bEtNEVjnC0yrBNImR2xziD+wv4iHggWQLRUgexy2qr7z8qeXS
         XYHoOl33nhFFnLYIsKv70TDv3JfMAEJpfydAGukdI2BiFvxy+Np0Ag4ayQmogsCSyJ
         CZaw2q2AI92Bht304iTWa0YhFKC0yeTxCxVfUPj81lFHElR047Am/tFLYJsU0F9ph4
         CoVZiqIwTCW7A==
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
Subject: [PATCH 26/39] x86/mm/pti: Clone CPU_ENTRY_AREA on PMD level on x86_32
Date:   Wed, 11 Jul 2018 13:29:33 +0200
Message-Id: <1531308586-29340-27-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531308586-29340-1-git-send-email-joro@8bytes.org>
References: <1531308586-29340-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Cloning on the P4D level would clone the complete kernel
address space into the user-space page-tables for PAE
kernels. Cloning on PMD level is fine for PAE and legacy
paging.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/mm/pti.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index dc02fd4..2eadab0 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -348,6 +348,7 @@ pti_clone_pmds(unsigned long start, unsigned long end, pmdval_t clear)
 	}
 }
 
+#ifdef CONFIG_X86_64
 /*
  * Clone a single p4d (i.e. a top-level entry on 4-level systems and a
  * next-level entry on 5-level systems.
@@ -371,6 +372,25 @@ static void __init pti_clone_user_shared(void)
 	pti_clone_p4d(CPU_ENTRY_AREA_BASE);
 }
 
+#else /* CONFIG_X86_64 */
+
+/*
+ * On 32 bit PAE systems with 1GB of Kernel address space there is only
+ * one pgd/p4d for the whole kernel. Cloning that would map the whole
+ * address space into the user page-tables, making PTI useless. So clone
+ * the page-table on the PMD level to prevent that.
+ */
+static void __init pti_clone_user_shared(void)
+{
+	unsigned long start, end;
+
+	start = CPU_ENTRY_AREA_BASE;
+	end   = start + (PAGE_SIZE * CPU_ENTRY_AREA_PAGES);
+
+	pti_clone_pmds(start, end, 0);
+}
+#endif /* CONFIG_X86_64 */
+
 /*
  * Clone the ESPFIX P4D into the user space visible page table
  */
-- 
2.7.4

