Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377EFECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F3120684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3F3120684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731361AbeGTASc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:18:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49277 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727743AbeGTASb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:18:31 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JNWA8K2453904
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 16:32:10 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JNWAMc2453901;
        Thu, 19 Jul 2018 16:32:10 -0700
Date:   Thu, 19 Jul 2018 16:32:10 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-f94560cd6b5117f8913f4c42f4d9a405c26ddc1c@git.kernel.org>
Cc:     aarcange@redhat.com, peterz@infradead.org,
        gregkh@linuxfoundation.org, dvlasenk@redhat.com,
        tglx@linutronix.de, hpa@zytor.com, llong@redhat.com,
        dave.hansen@intel.com, torvalds@linux-foundation.org,
        jpoimboe@redhat.com, eduval@amazon.com, mingo@kernel.org,
        brgerst@gmail.com, luto@kernel.org, jgross@suse.com,
        boris.ostrovsky@oracle.com, bp@alien8.de, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, dhgutteridge@sympatico.ca,
        David.Laight@aculab.com, jroedel@suse.de, jkosina@suse.cz,
        pavel@ucw.cz
Reply-To: brgerst@gmail.com, luto@kernel.org, bp@alien8.de,
          jgross@suse.com, boris.ostrovsky@oracle.com, will.deacon@arm.com,
          linux-kernel@vger.kernel.org, David.Laight@aculab.com,
          dhgutteridge@sympatico.ca, jkosina@suse.cz, jroedel@suse.de,
          pavel@ucw.cz, aarcange@redhat.com, peterz@infradead.org,
          gregkh@linuxfoundation.org, dvlasenk@redhat.com, hpa@zytor.com,
          tglx@linutronix.de, torvalds@linux-foundation.org,
          llong@redhat.com, dave.hansen@intel.com, jpoimboe@redhat.com,
          eduval@amazon.com, mingo@kernel.org
In-Reply-To: <1531906876-13451-27-git-send-email-joro@8bytes.org>
References: <1531906876-13451-27-git-send-email-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/mm/pti: Clone CPU_ENTRY_AREA on PMD level on
 x86_32
Git-Commit-ID: f94560cd6b5117f8913f4c42f4d9a405c26ddc1c
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

Commit-ID:  f94560cd6b5117f8913f4c42f4d9a405c26ddc1c
Gitweb:     https://git.kernel.org/tip/f94560cd6b5117f8913f4c42f4d9a405c26ddc1c
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Wed, 18 Jul 2018 11:41:03 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 01:11:44 +0200

x86/mm/pti: Clone CPU_ENTRY_AREA on PMD level on x86_32

Cloning on the P4D level would clone the complete kernel address space into
the user-space page-tables for PAE kernels. Cloning on PMD level is fine
for PAE and legacy paging.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Pavel Machek <pavel@ucw.cz>
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
Cc: "David H . Gutteridge" <dhgutteridge@sympatico.ca>
Cc: joro@8bytes.org
Link: https://lkml.kernel.org/r/1531906876-13451-27-git-send-email-joro@8bytes.org

---
 arch/x86/mm/pti.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 79217868dd13..a594e3b6401a 100644
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
