Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0ECC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F14B0213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F14B0213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbeK2J06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:26:58 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:33066 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbeK2JYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:24:09 -0500
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gS8CW-0001GX-Qb; Wed, 28 Nov 2018 23:20:57 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 06/29] x86/fpu: Update comment for __raw_xsave_addr()
Date:   Wed, 28 Nov 2018 23:20:12 +0100
Message-Id: <20181128222035.2996-7-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181128222035.2996-1-bigeasy@linutronix.de>
References: <20181128222035.2996-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment above __raw_xsave_addr() claims that the function does not
work for compacted buffers and was introduced in commit
  b8b9b6ba9dec3("x86/fpu: Allow setting of XSAVE state")

In this commit, the function was factored out of get_xsave_addr() and
this function claims that it works with "standard format or compacted
format of xsave area". It accesses the "xstate_comp_offsets" variable
for the actual offset and it was introduced in commit
  7496d6458fe32 ("Define kernel API to get address of each state in xsave area")

Based on the code (back then and now):
- xstate_offsets holds the standard offset.
- if compacted mode is not supported then xstate_comp_offsets gets the
  xstate_offsets copied.
- if compacted mode is supported then xstate_comp_offsets will hold the
  offset for the compacted buffer.

Based on that the function works for compacted buffers as long as the
CPU supports it and this what we care about.

Remove the "Note:" which is not accurate.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/kernel/fpu/xstate.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 69d5740ed2546..359564beab5c3 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -808,8 +808,6 @@ void fpu__resume_cpu(void)
  * Given an xstate feature mask, calculate where in the xsave
  * buffer the state is.  Callers should ensure that the buffer
  * is valid.
- *
- * Note: does not work for compacted buffers.
  */
 void *__raw_xsave_addr(struct xregs_state *xsave, int xstate_feature_mask)
 {
-- 
2.20.0.rc1

