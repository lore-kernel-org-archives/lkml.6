Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A235C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27215208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="K1qaWTCi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27215208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733024AbeGKLeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:34:11 -0400
Received: from 8bytes.org ([81.169.241.247]:37802 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732995AbeGKLeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:34:10 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 62D9C1A02; Wed, 11 Jul 2018 13:30:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1531308606; bh=/Ih1ouATHKIWwXvRWuZbzp4GcZEjnBzBwjH19GfP9H8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K1qaWTCiYEIeGoja1MADwaRUEFV7efFEYqjiiENH/jMjn0ibNSfGtKNg3d5/jQMce
         1/VXi/jiEItdXi/xdKfuuer5EFTgtQe3a3tgqWlvtRr2hWo8GN/9mJOjnHM4FioiB8
         MKW00TIM+CzEoUfBvcHYrrT0TpUPN0cAxrCRbORHO/bJfA2MCsFs8/Xjse6KQhhP8O
         Z9OGQvQntQlAIvCNzzE6O6iOcy/xX/k16U4n2hzx7GfAsOFchRfIYklC5DInePkMbF
         gtK5Ly9vv5q9R0kWUWgeNil1iGFq6MSc8zBlGNz10iLv40K5HZHT8GAnIii+0rjO9H
         JEc44yaHlzGNQ==
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
Subject: [PATCH 25/39] x86/mm/pti: Define X86_CR3_PTI_PCID_USER_BIT on x86_32
Date:   Wed, 11 Jul 2018 13:29:32 +0200
Message-Id: <1531308586-29340-26-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531308586-29340-1-git-send-email-joro@8bytes.org>
References: <1531308586-29340-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Move it out of the X86_64 specific processor defines so
that its visible for 32bit too.

Reviewed-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/processor-flags.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/processor-flags.h b/arch/x86/include/asm/processor-flags.h
index 625a52a..02c2cbd 100644
--- a/arch/x86/include/asm/processor-flags.h
+++ b/arch/x86/include/asm/processor-flags.h
@@ -39,10 +39,6 @@
 #define CR3_PCID_MASK	0xFFFull
 #define CR3_NOFLUSH	BIT_ULL(63)
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
-# define X86_CR3_PTI_PCID_USER_BIT	11
-#endif
-
 #else
 /*
  * CR3_ADDR_MASK needs at least bits 31:5 set on PAE systems, and we save
@@ -53,4 +49,8 @@
 #define CR3_NOFLUSH	0
 #endif
 
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+# define X86_CR3_PTI_PCID_USER_BIT	11
+#endif
+
 #endif /* _ASM_X86_PROCESSOR_FLAGS_H */
-- 
2.7.4

