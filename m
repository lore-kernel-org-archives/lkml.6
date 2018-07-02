Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6257BC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E7F25C51
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:05:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E7F25C51
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030395AbeGBLE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:04:59 -0400
Received: from foss.arm.com ([217.140.101.70]:57556 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030288AbeGBLEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:04:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE9D215AD;
        Mon,  2 Jul 2018 04:04:49 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B4BDD3F5BA;
        Mon,  2 Jul 2018 04:04:47 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org, will.deacon@arm.com
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        dave.martin@arm.com, hch@infradead.org, james.morse@arm.com,
        linux@dominikbrodowski.net, linux-fsdevel@vger.kernel.org,
        marc.zyngier@arm.com, mark.rutland@arm.com, viro@zeniv.linux.org.uk
Subject: [PATCHv4 10/19] arm64: don't restore GPRs when context tracking
Date:   Mon,  2 Jul 2018 12:04:06 +0100
Message-Id: <20180702110415.10465-11-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180702110415.10465-1-mark.rutland@arm.com>
References: <20180702110415.10465-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that syscalls are invoked with pt_regs, we no longer need to ensure
that the argument regsiters are live in the entry assembly, and it's
fine to not restore them after context_tracking_user_exit() has
corrupted them.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/entry.S | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 156c4e3fd1a4..c41b84d06644 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -41,19 +41,9 @@
  * Context tracking subsystem.  Used to instrument transitions
  * between user and kernel mode.
  */
-	.macro ct_user_exit, syscall = 0
+	.macro ct_user_exit
 #ifdef CONFIG_CONTEXT_TRACKING
 	bl	context_tracking_user_exit
-	.if \syscall == 1
-	/*
-	 * Save/restore needed during syscalls.  Restore syscall arguments from
-	 * the values already saved on stack during kernel_entry.
-	 */
-	ldp	x0, x1, [sp]
-	ldp	x2, x3, [sp, #S_X2]
-	ldp	x4, x5, [sp, #S_X4]
-	ldp	x6, x7, [sp, #S_X6]
-	.endif
 #endif
 	.endm
 
-- 
2.11.0

