Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46854C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17BEF21479
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17BEF21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbeK2JYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:24:09 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:33058 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbeK2JYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:24:08 -0500
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gS8CW-0001GX-0M; Wed, 28 Nov 2018 23:20:56 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 05/29] x86/fpu: add might_fault() to user_insn()
Date:   Wed, 28 Nov 2018 23:20:11 +0100
Message-Id: <20181128222035.2996-6-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181128222035.2996-1-bigeasy@linutronix.de>
References: <20181128222035.2996-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every user of user_insn() passes an user memory pointer to this macro.

Add might_fault() to user_insn() so we can spot users which are using
this macro in sections where page faulting is not allowed.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/include/asm/fpu/internal.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 69dcdf195b611..978a1633c0698 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -106,6 +106,7 @@ extern void fpstate_sanitize_xstate(struct fpu *fpu);
 #define user_insn(insn, output, input...)				\
 ({									\
 	int err;							\
+	might_fault();							\
 	asm volatile(ASM_STAC "\n"					\
 		     "1:" #insn "\n\t"					\
 		     "2: " ASM_CLAC "\n"				\
-- 
2.20.0.rc1

