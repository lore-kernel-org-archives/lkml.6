Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32986C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E133F24B36
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="Y+3eWb87"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E133F24B36
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932155AbeGCLxJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 07:53:09 -0400
Received: from 8bytes.org ([81.169.241.247]:45386 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752491AbeGCLwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 07:52:32 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id DD83E577; Tue,  3 Jul 2018 13:52:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1530618750; bh=ENfulY4LWVUYhmfGGktbr3cigMS5/69AHhXEsTw5eRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y+3eWb875m0VBynwYhHhL2qT99UfGJxDnSm23eWWGenDkHEc8ic1NEbE0jwgDgRDa
         VqdfxpO60OPlWN+wgC+51f3VPFn6fyfAz/zZquPf1RptwJwsm2dRkkJM9zs7p6sTkV
         lr6UySeqZHZqd+QIWzqp/QeuL5pVff6M+fluKUGIws1YBMMMV34jDDsx4b7ZzQAzja
         wvbFYZ0SdJoWu2dCMctIkSGKTH05Enwq7xr182zeooSd2m2/UIXt53WXjpznpNNi8U
         cY3tewFhDmi+mgAn5eu4vIwnqbXCtk1FgWgKQHwqbWBUoxTtauDP9EKQOrdbhII3fN
         bob8Sw8uYr2cQ==
From:   Joerg Roedel <joro@8bytes.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Cc:     hpa@zytor.com, Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 3/3] x86/pti: Call pti_clone_kernel_text() from pti_init()
Date:   Tue,  3 Jul 2018 13:52:26 +0200
Message-Id: <1530618746-23116-4-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530618746-23116-1-git-send-email-joro@8bytes.org>
References: <1530618746-23116-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The pti_init() function is now called late enough for
pti_clone_kernel_text(), so call it directly from there.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/pti.h | 2 --
 arch/x86/mm/init_64.c      | 6 ------
 arch/x86/mm/pti.c          | 3 ++-
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/pti.h b/arch/x86/include/asm/pti.h
index 38a17f1..0b5ef05 100644
--- a/arch/x86/include/asm/pti.h
+++ b/arch/x86/include/asm/pti.h
@@ -6,10 +6,8 @@
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 extern void pti_init(void);
 extern void pti_check_boottime_disable(void);
-extern void pti_clone_kernel_text(void);
 #else
 static inline void pti_check_boottime_disable(void) { }
-static inline void pti_clone_kernel_text(void) { }
 #endif
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index a688617..9b19f9a 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1291,12 +1291,6 @@ void mark_rodata_ro(void)
 			(unsigned long) __va(__pa_symbol(_sdata)));
 
 	debug_checkwx();
-
-	/*
-	 * Do this after all of the manipulation of the
-	 * kernel text page tables are complete.
-	 */
-	pti_clone_kernel_text();
 }
 
 int kern_addr_valid(unsigned long addr)
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 8a80522..dd344f7 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -438,7 +438,7 @@ static inline bool pti_kernel_image_global_ok(void)
  * For some configurations, map all of kernel text into the user page
  * tables.  This reduces TLB misses, especially on non-PCID systems.
  */
-void pti_clone_kernel_text(void)
+static void pti_clone_kernel_text(void)
 {
 	/*
 	 * rodata is part of the kernel image and is normally
@@ -499,6 +499,7 @@ void pti_init(void)
 	pti_set_kernel_image_nonglobal();
 	/* Replace some of the global bits just for shared entry text: */
 	pti_clone_entry_text();
+	pti_clone_kernel_text();
 	pti_setup_espfix64();
 	pti_setup_vsyscall();
 }
-- 
2.7.4

