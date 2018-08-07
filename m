Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926E2C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 10:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 432512170A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 10:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="VHlI/Dgv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432512170A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388825AbeHGMiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 08:38:15 -0400
Received: from 8bytes.org ([81.169.241.247]:60838 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388718AbeHGMiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 08:38:13 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 3DE37104; Tue,  7 Aug 2018 12:24:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1533637473; bh=pP6jz/NH1jJ0hu79SobCkHNyMx40HjebERdE/5PdW6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VHlI/DgvOQCLTd7lAb7YKFYn32xIdw+7LS20gUYhndOCcDGH6D5uFn/MIEloLZMYu
         Ebh1dAF2UkjGRBIvefLD+7+Ewie09E4anS30Vcvrtgj6t+SZ/4AmghbSVPPOFYcBsi
         xXK8iq6Qi/V30ICrkxlxHk327LF6UagNIwyAHogS0Qsb9Fp0/ub1zp9I0fLErUVo3W
         GMXDzgxM79cj3j8MIHM8beOVlBBxMpYJA4kGNl6uR1hliGGff5i9UaYwTabdbQq4um
         t6kgF8AIvQ1Us58vligIqp1nn0EBaFLlfSkQ8l7vQSplhnLZ63FYuMpb5mk9qraL0L
         Lz4s1gOqISh/A==
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
Subject: [PATCH 1/3] x86/mm/pti: Fix 32 bit PCID check
Date:   Tue,  7 Aug 2018 12:24:29 +0200
Message-Id: <1533637471-30953-2-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533637471-30953-1-git-send-email-joro@8bytes.org>
References: <1533637471-30953-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The check uses the wrong operator and causes false positive
warnings in the kernel log on some systems.

Fixes: 5e8105950a8b3 ('x86/mm/pti: Add Warning when booting on a PCID capable CPU')
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/mm/pti.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index ef8db6f..113ba14 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -549,7 +549,7 @@ void __init pti_init(void)
 	 * supported on 32 bit anyway. To print the warning we need to
 	 * check with cpuid directly again.
 	 */
-	if (cpuid_ecx(0x1) && BIT(17)) {
+	if (cpuid_ecx(0x1) & BIT(17)) {
 		/* Use printk to work around pr_fmt() */
 		printk(KERN_WARNING "\n");
 		printk(KERN_WARNING "************************************************************\n");
-- 
2.7.4

