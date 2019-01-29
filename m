Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46288C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1102147A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbfA2VEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 16:04:12 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42713 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfA2VEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 16:04:12 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0TL3uBA2095489
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 29 Jan 2019 13:03:56 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0TL3u7g2095486;
        Tue, 29 Jan 2019 13:03:56 -0800
Date:   Tue, 29 Jan 2019 13:03:56 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Wei Huang <tipbot@zytor.com>
Message-ID: <tip-b677dfae5aa197afc5191755a76a8727ffca538a@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, wei@redhat.com, hpa@zytor.com
Reply-To: hpa@zytor.com, kirill.shutemov@linux.intel.com,
          tglx@linutronix.de, mingo@kernel.org, wei@redhat.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190104054411.12489-1-wei@redhat.com>
References: <20190104054411.12489-1-wei@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/boot/compressed/64: Set EFER.LME=1 in 32-bit
 trampoline before returning to long mode
Git-Commit-ID: b677dfae5aa197afc5191755a76a8727ffca538a
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

Commit-ID:  b677dfae5aa197afc5191755a76a8727ffca538a
Gitweb:     https://git.kernel.org/tip/b677dfae5aa197afc5191755a76a8727ffca538a
Author:     Wei Huang <wei@redhat.com>
AuthorDate: Thu, 3 Jan 2019 23:44:11 -0600
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 29 Jan 2019 21:58:59 +0100

x86/boot/compressed/64: Set EFER.LME=1 in 32-bit trampoline before returning to long mode

In some old AMD KVM implementation, guest's EFER.LME bit is cleared by KVM
when the hypervsior detects that the guest sets CR0.PG to 0. This causes
the guest OS to reboot when it tries to return from 32-bit trampoline code
because the CPU is in incorrect state: CR4.PAE=1, CR0.PG=1, CS.L=1, but
EFER.LME=0.  As a precaution, set EFER.LME=1 as part of long mode
activation procedure. This extra step won't cause any harm when Linux is
booted on a bare-metal machine.

Signed-off-by: Wei Huang <wei@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: bp@alien8.de
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/20190104054411.12489-1-wei@redhat.com

---
 arch/x86/boot/compressed/head_64.S | 8 ++++++++
 arch/x86/boot/compressed/pgtable.h | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 64037895b085..f105ae8651c9 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -600,6 +600,14 @@ ENTRY(trampoline_32bit_src)
 	leal	TRAMPOLINE_32BIT_PGTABLE_OFFSET(%ecx), %eax
 	movl	%eax, %cr3
 3:
+	/* Set EFER.LME=1 as a precaution in case hypervsior pulls the rug */
+	pushl	%ecx
+	movl	$MSR_EFER, %ecx
+	rdmsr
+	btsl	$_EFER_LME, %eax
+	wrmsr
+	popl	%ecx
+
 	/* Enable PAE and LA57 (if required) paging modes */
 	movl	$X86_CR4_PAE, %eax
 	cmpl	$0, %edx
diff --git a/arch/x86/boot/compressed/pgtable.h b/arch/x86/boot/compressed/pgtable.h
index 91f75638f6e6..6ff7e81b5628 100644
--- a/arch/x86/boot/compressed/pgtable.h
+++ b/arch/x86/boot/compressed/pgtable.h
@@ -6,7 +6,7 @@
 #define TRAMPOLINE_32BIT_PGTABLE_OFFSET	0
 
 #define TRAMPOLINE_32BIT_CODE_OFFSET	PAGE_SIZE
-#define TRAMPOLINE_32BIT_CODE_SIZE	0x60
+#define TRAMPOLINE_32BIT_CODE_SIZE	0x70
 
 #define TRAMPOLINE_32BIT_STACK_END	TRAMPOLINE_32BIT_SIZE
 
