Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C6BECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF0E22075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="BnprfT3p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF0E22075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731825AbeGRKSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:18:43 -0400
Received: from 8bytes.org ([81.169.241.247]:54462 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731770AbeGRKSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:18:41 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id AFFC7C98; Wed, 18 Jul 2018 11:41:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1531906885; bh=48FBcw49wasOWCwH8N3EK5w1EL7mm104AhYjmxHQeP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BnprfT3po/XG5LQkuR6EeRLOLHrWtwuxvsbtkdWqOj4VJuc/I7dnjGn6cPNpDS9In
         guejVb/XWr3HGHUsrkLwPa4jBvWOloV1B2TdfIlx+3Y9dCGFtkVYZWegk+3r2Xe0ZJ
         NBZH8VamnQGJuzZGSB7rua+pqbE+dVBz5g5Qz6tKYgstEI5eRaq8x4U8oTXwOpAwHW
         /OIbCQBsDMC9dUdNRClrynvxmTNe+ubtruTDAZp9CcjPyGgt/C5PTpcEg4IvdSsjFc
         uuXcFzEoirJEFLYhxw/NKJJ0382aQvglHyv0oHpvNs/cd1nEBJGpEsk3MN7NDS4zJY
         TddYHr8JjVKSg==
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
Date:   Wed, 18 Jul 2018 11:41:03 +0200
Message-Id: <1531906876-13451-27-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531906876-13451-1-git-send-email-joro@8bytes.org>
References: <1531906876-13451-1-git-send-email-joro@8bytes.org>
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

