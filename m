Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A608C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336532173B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbfAILuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 06:50:01 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:56198 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731035AbfAILsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 06:48:41 -0500
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ghCLb-0007Al-F6; Wed, 09 Jan 2019 12:48:35 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 13/22] x86/pkeys: Don't check if PKRU is zero before writting it
Date:   Wed,  9 Jan 2019 12:47:35 +0100
Message-Id: <20190109114744.10936-14-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109114744.10936-1-bigeasy@linutronix.de>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

write_pkru() checks if the current value is the same as the expected
value. So instead just checking if the current and new value is zero
(and skip the write in such a case) we can benefit from that.

Remove the zero check of PKRU, write_pkru() provides a similar check.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/mm/pkeys.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index 05bb9a44eb1c3..50f65fc1b9a3f 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -142,13 +142,6 @@ u32 init_pkru_value = PKRU_AD_KEY( 1) | PKRU_AD_KEY( 2) | PKRU_AD_KEY( 3) |
 void copy_init_pkru_to_fpregs(void)
 {
 	u32 init_pkru_value_snapshot = READ_ONCE(init_pkru_value);
-	/*
-	 * Any write to PKRU takes it out of the XSAVE 'init
-	 * state' which increases context switch cost.  Avoid
-	 * writing 0 when PKRU was already 0.
-	 */
-	if (!init_pkru_value_snapshot && !read_pkru())
-		return;
 	/*
 	 * Override the PKRU state that came from 'init_fpstate'
 	 * with the baseline from the process.
-- 
2.20.1

