Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7676C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A9621730
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A9621730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388536AbeHNUOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:14:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52072 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387824AbeHNUOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:14:50 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 489FAC5C;
        Tue, 14 Aug 2018 17:26:43 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.18 57/79] x86/speculation/l1tf: Unbreak !__HAVE_ARCH_PFN_MODIFY_ALLOWED architectures
Date:   Tue, 14 Aug 2018 19:17:16 +0200
Message-Id: <20180814171340.052011732@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171336.799314117@linuxfoundation.org>
References: <20180814171336.799314117@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Kosina <jkosina@suse.cz>

pfn_modify_allowed() and arch_has_pfn_modify_check() are outside of the
!__ASSEMBLY__ section in include/asm-generic/pgtable.h, which confuses
assembler on archs that don't have __HAVE_ARCH_PFN_MODIFY_ALLOWED (e.g.
ia64) and breaks build:

    include/asm-generic/pgtable.h: Assembler messages:
    include/asm-generic/pgtable.h:538: Error: Unknown opcode `static inline bool pfn_modify_allowed(unsigned long pfn,pgprot_t prot)'
    include/asm-generic/pgtable.h:540: Error: Unknown opcode `return true'
    include/asm-generic/pgtable.h:543: Error: Unknown opcode `static inline bool arch_has_pfn_modify_check(void)'
    include/asm-generic/pgtable.h:545: Error: Unknown opcode `return false'
    arch/ia64/kernel/entry.S:69: Error: `mov' does not fit into bundle

Move those two static inlines into the !__ASSEMBLY__ section so that they
don't confuse the asm build pass.

Fixes: 42e4089c7890 ("x86/speculation/l1tf: Disallow non privileged high MMIO PROT_NONE mappings")
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/asm-generic/pgtable.h |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -1083,6 +1083,18 @@ int phys_mem_access_prot_allowed(struct
 static inline void init_espfix_bsp(void) { }
 #endif
 
+#ifndef __HAVE_ARCH_PFN_MODIFY_ALLOWED
+static inline bool pfn_modify_allowed(unsigned long pfn, pgprot_t prot)
+{
+	return true;
+}
+
+static inline bool arch_has_pfn_modify_check(void)
+{
+	return false;
+}
+#endif /* !_HAVE_ARCH_PFN_MODIFY_ALLOWED */
+
 #endif /* !__ASSEMBLY__ */
 
 #ifndef io_remap_pfn_range
@@ -1097,16 +1109,4 @@ static inline void init_espfix_bsp(void)
 #endif
 #endif
 
-#ifndef __HAVE_ARCH_PFN_MODIFY_ALLOWED
-static inline bool pfn_modify_allowed(unsigned long pfn, pgprot_t prot)
-{
-	return true;
-}
-
-static inline bool arch_has_pfn_modify_check(void)
-{
-	return false;
-}
-#endif
-
 #endif /* _ASM_GENERIC_PGTABLE_H */


