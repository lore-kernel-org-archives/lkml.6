Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059B3C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C143420827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKZ8VQfu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C143420827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbeJ3WZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:25:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727765AbeJ3WZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:25:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6811220838;
        Tue, 30 Oct 2018 13:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540906346;
        bh=F5PeondhkZR2BKnjLZ2wBeeBiGH+Yd8Ej5Eu2pxqKFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tKZ8VQfuFVZbskNlIraAmXtWAusmw0LKVi8y7p9yXSEtiYDOdmk8MhAg8dWWV9bMq
         okZk+7vjtyLxS/xRug2rJoINMx8ijUiIZyymf1bIgK+tcr3oKPvmKG+803v9GfgcoY
         QFZoOy7OGm91sIgEsjkU86dnDGVho204FLSj2jAg=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 3/6] x86/fpu: Remove second definition of fpu in __fpu__restore_sig()
Date:   Tue, 30 Oct 2018 09:30:54 -0400
Message-Id: <20181030133057.218186-3-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030133057.218186-1-sashal@kernel.org>
References: <20181030133057.218186-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 6aa676761d4c1acfa31320e55fa1f83f3fcbbc7a ]

Commit:

  c5bedc6847c3b ("x86/fpu: Get rid of PF_USED_MATH usage, convert it to fpu->fpstate_active")

introduced the 'fpu' variable at top of __restore_xstate_sig(),
which now shadows the other definition:

  arch/x86/kernel/fpu/signal.c:318:28: warning: symbol 'fpu' shadows an earlier one
  arch/x86/kernel/fpu/signal.c:271:20: originally declared here

Remove the shadowed definition of 'fpu', as the two definitions are the same.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: c5bedc6847c3b ("x86/fpu: Get rid of PF_USED_MATH usage, convert it to fpu->fpstate_active")
Link: http://lkml.kernel.org/r/20181016202525.29437-3-bigeasy@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/fpu/signal.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 9be3e79eb629..31fad2cbd734 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -294,7 +294,6 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 		 * thread's fpu state, reconstruct fxstate from the fsave
 		 * header. Sanitize the copied state etc.
 		 */
-		struct fpu *fpu = &tsk->thread.fpu;
 		struct user_i387_ia32_struct env;
 		int err = 0;
 
-- 
2.17.1

