Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B4AECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C00920652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="jBrZd1xf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C00920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388036AbeGTRLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:11:52 -0400
Received: from 8bytes.org ([81.169.241.247]:35822 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387901AbeGTRLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:11:41 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 5EC2147B; Fri, 20 Jul 2018 18:22:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1532103759; bh=4KTDetwc2za08ZBDrrEdYFeqtUqIJZdCy2mgZWB4/5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jBrZd1xflyjidAw0e7BS6prO+8qCnAtDYqk2xh5lrukP/n5XrVELBoV3MGwc6TKVk
         JDG1nN7MSAsrAN3lX7Zg9tgj8AY9OxBPb5Qc5xpJbDtKaUbc0Gh+WXJCz6UvGQmvu/
         V97lm5OZkmzTLBy5OZvUeDzayAD+LUGIk1YAusZIuurPukGRSPxEL7bDzcgBX5hDnG
         SK3ohiJ322ZzQkm2RA8dwJ8d6jSr/1a8KZfmTChTXa6Bxf94iSWHUPkb3ICsLAWm9Q
         5XLq0dnCv/dHpTKZMWWxO5+ldjsSBOjmAa2jR+/S4IcodVU8Y2gk2gTELjnLumHEH9
         tplzyeIw6H91Q==
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
        jroedel@suse.de, Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, joro@8bytes.org
Subject: [PATCH 2/3] x86/entry/32: Check for VM86 mode in slow-path check
Date:   Fri, 20 Jul 2018 18:22:23 +0200
Message-Id: <1532103744-31902-3-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532103744-31902-1-git-send-email-joro@8bytes.org>
References: <1532103744-31902-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The SWITCH_TO_KERNEL_STACK macro only checks for CPL == 0 to
go down the slow and paranoid entry path. The problem is
that this check also returns true when coming from VM86
mode. This is not a problem by itself, as the paranoid path
handles VM86 stack-frames just fine, but it is not necessary
as the normal code path handles VM86 mode as well (and
faster).

Extend the check to include VM86 mode. This also makes an
optimization of the paranoid path possible.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/entry/entry_32.S | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 010cdb4..2767c62 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -414,8 +414,16 @@
 	andl	$(0x0000ffff), PT_CS(%esp)
 
 	/* Special case - entry from kernel mode via entry stack */
-	testl	$SEGMENT_RPL_MASK, PT_CS(%esp)
-	jz	.Lentry_from_kernel_\@
+#ifdef CONFIG_VM86
+	movl	PT_EFLAGS(%esp), %ecx		# mix EFLAGS and CS
+	movb	PT_CS(%esp), %cl
+	andl	$(X86_EFLAGS_VM | SEGMENT_RPL_MASK), %ecx
+#else
+	movl	PT_CS(%esp), %ecx
+	andl	$SEGMENT_RPL_MASK, %ecx
+#endif
+	cmpl	$USER_RPL, %ecx
+	jb	.Lentry_from_kernel_\@
 
 	/* Bytes to copy */
 	movl	$PTREGS_SIZE, %ecx
-- 
2.7.4

