Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1116C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967B42173B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbfAILuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 06:50:12 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:56193 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731028AbfAILsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 06:48:40 -0500
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ghCLZ-0007Al-UX; Wed, 09 Jan 2019 12:48:34 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 12/22] x86/fpu: Only write PKRU if it is different from current
Date:   Wed,  9 Jan 2019 12:47:34 +0100
Message-Id: <20190109114744.10936-13-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109114744.10936-1-bigeasy@linutronix.de>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen says that the `wrpkru' is more expensive than `rdpkru'. It
has a higher cycle cost and it's also practically a (light) speculation
barrier.

As an optimisation read the current PKRU value and only write the new
one if it is different.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/include/asm/special_insns.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 43c029cdc3fe8..c2ccf71b22dd6 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -107,7 +107,7 @@ static inline u32 __read_pkru(void)
 	return pkru;
 }
 
-static inline void __write_pkru(u32 pkru)
+static inline void __write_pkru_insn(u32 pkru)
 {
 	u32 ecx = 0, edx = 0;
 
@@ -118,6 +118,17 @@ static inline void __write_pkru(u32 pkru)
 	asm volatile(".byte 0x0f,0x01,0xef\n\t"
 		     : : "a" (pkru), "c"(ecx), "d"(edx));
 }
+
+static inline void __write_pkru(u32 pkru)
+{
+	/*
+	 * Writting PKRU is expensive. Only write the PKRU value if it is
+	 * different from the current one.
+	 */
+	if (pkru == __read_pkru())
+		return;
+	__write_pkru_insn(pkru);
+}
 #else
 static inline u32 __read_pkru(void)
 {
-- 
2.20.1

