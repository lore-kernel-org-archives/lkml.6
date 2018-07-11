Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E7AC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42587208E5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="T1m8QWSK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42587208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732830AbeGKLd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:33:59 -0400
Received: from 8bytes.org ([81.169.241.247]:37318 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727019AbeGKLd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:33:57 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 8E0AF684; Wed, 11 Jul 2018 13:29:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1531308599; bh=pdJphKqrJrdhCHnjF29WnK2jNYpxwmenjYXPOsr8GlQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T1m8QWSKDq6jJObwbmBeOnIrtyJhTyDgdQ51SVJeEq6EBqkS+vAGRG8Rk7jXeYU/N
         2W8TeKUU9IjnyYZ26TVMxa3AiG7SVgovXE2iV9ROqRjpeGZDvc+L3zPTRF1wNBbpml
         oKnqnD1LPsoCGtRlFm6ghpgiAfsMY0tnCeHNuO+0mTJ9R7DTi8xeGX2ifquUGQ3slj
         m6/aoVg6kFwlKaVZZD1G/JfK3ItRqPvQtHgPD+sjvnga9B4d86VBObIBv4RRH8W+qi
         PJlkg7sq0GNsvEzs4jgpEcd+zyHvrGn5ipzJeLzE0Fp1An4ZrKK0CZ7Kmv3gXWRBzw
         NswZ0ZNfLtluw==
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
Subject: [PATCH 01/39] x86/asm-offsets: Move TSS_sp0 and TSS_sp1 to asm-offsets.c
Date:   Wed, 11 Jul 2018 13:29:08 +0200
Message-Id: <1531308586-29340-2-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531308586-29340-1-git-send-email-joro@8bytes.org>
References: <1531308586-29340-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

These offsets will be used in 32 bit assembly code as well,
so make them available for all of x86 code.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/asm-offsets.c    | 4 ++++
 arch/x86/kernel/asm-offsets_64.c | 2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index dcb008c..a1e1628 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -103,4 +103,8 @@ void common(void) {
 	OFFSET(CPU_ENTRY_AREA_entry_trampoline, cpu_entry_area, entry_trampoline);
 	OFFSET(CPU_ENTRY_AREA_entry_stack, cpu_entry_area, entry_stack_page);
 	DEFINE(SIZEOF_entry_stack, sizeof(struct entry_stack));
+
+	/* Offset for sp0 and sp1 into the tss_struct */
+	OFFSET(TSS_sp0, tss_struct, x86_tss.sp0);
+	OFFSET(TSS_sp1, tss_struct, x86_tss.sp1);
 }
diff --git a/arch/x86/kernel/asm-offsets_64.c b/arch/x86/kernel/asm-offsets_64.c
index b2dcd16..3b9405e 100644
--- a/arch/x86/kernel/asm-offsets_64.c
+++ b/arch/x86/kernel/asm-offsets_64.c
@@ -65,8 +65,6 @@ int main(void)
 #undef ENTRY
 
 	OFFSET(TSS_ist, tss_struct, x86_tss.ist);
-	OFFSET(TSS_sp0, tss_struct, x86_tss.sp0);
-	OFFSET(TSS_sp1, tss_struct, x86_tss.sp1);
 	BLANK();
 
 #ifdef CONFIG_STACKPROTECTOR
-- 
2.7.4

