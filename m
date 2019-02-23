Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DB1C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A53242086D
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550956088;
	bh=OeSzBiRxHhl5XBdsNfxxqihSZDqPNSY1//9l1LDPaG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qbMIP8ozRltPnXf7j0tUlhkVyNXmO01UOlDJuno83z7uRQaD4aX9JMOcJ96FprZTR
	 F7nWlcw3Xe+fppR/lSp8iRB43hwwPRBPGlPtpK6EHIgp9MYiGIlPedFplgWRd9036x
	 1c08E/LarCXOUXH6L6M64z5/xCTxUeM+F03x0kWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbfBWVIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:08:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:43324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729189AbfBWVID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:08:03 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B56320861;
        Sat, 23 Feb 2019 21:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956082;
        bh=OeSzBiRxHhl5XBdsNfxxqihSZDqPNSY1//9l1LDPaG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S91Xixujuqo8bJd4oxXerdoSH7eVTspbbco7bqb1NFRi35x/4HNrRKzERDJSoPMo0
         VCdc5w1FYnfPxdOsuqqRKi124xdZ1jhfSYufetbTkIBe5mCUbP9azGEHJxy8hU7EGf
         YuK5nAD5WpJV0/JCrO14pQ3uycjP/MinQHnV1Ixw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wei Huang <wei@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        bp@alien8.de, hpa@zytor.com, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 51/65] x86/boot/compressed/64: Set EFER.LME=1 in 32-bit trampoline before returning to long mode
Date:   Sat, 23 Feb 2019 16:06:26 -0500
Message-Id: <20190223210640.200911-51-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210640.200911-1-sashal@kernel.org>
References: <20190223210640.200911-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Huang <wei@redhat.com>

[ Upstream commit b677dfae5aa197afc5191755a76a8727ffca538a ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/boot/compressed/head_64.S | 8 ++++++++
 arch/x86/boot/compressed/pgtable.h | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 64037895b0859..f105ae8651c94 100644
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
index 91f75638f6e68..6ff7e81b56284 100644
--- a/arch/x86/boot/compressed/pgtable.h
+++ b/arch/x86/boot/compressed/pgtable.h
@@ -6,7 +6,7 @@
 #define TRAMPOLINE_32BIT_PGTABLE_OFFSET	0
 
 #define TRAMPOLINE_32BIT_CODE_OFFSET	PAGE_SIZE
-#define TRAMPOLINE_32BIT_CODE_SIZE	0x60
+#define TRAMPOLINE_32BIT_CODE_SIZE	0x70
 
 #define TRAMPOLINE_32BIT_STACK_END	TRAMPOLINE_32BIT_SIZE
 
-- 
2.19.1

