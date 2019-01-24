Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62FAC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70CD21726
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548359811;
	bh=0whkOm+oWVmrS8vOxYoOAnTzAlV3TMFQ9kkwHNm1gpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FF4cuu/fBtEx4OMtZDuS+hGeohkP42LxGvmuf/tdXuqCKaakFJeZiR3o2J4q1c6GI
	 ysedpuqcOecVdcJEQaMK8nXCLxcucooIDXIF0bI/Fu8AwaZohfQA+L5oHTNT0kioJo
	 3yJMlWfR68fDUroncn/Oh/0fn7cNC/SqrJrO+/nE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732430AbfAXTfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:35:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:35630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731400AbfAXTfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:35:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B23F321908;
        Thu, 24 Jan 2019 19:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358537;
        bh=0whkOm+oWVmrS8vOxYoOAnTzAlV3TMFQ9kkwHNm1gpY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0doRFy6XRsroloz3cdiwO6G6YdcQ35SDkJ5F1vbn7ZKfgVxze0qob4LDcgSbYQNx4
         sxRnjVmh2dOGoNKuAfL7IbRluh5lyy53P13UcD4/hkw2NQTMcr/pdXuL3II45lLznI
         oy4RbBzmwjzA0Gs6tYWSD3qRKmWEEAuUXM3ktjGw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Breno Leitao <leitao@debian.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 043/106] powerpc/xmon: Fix invocation inside lock region
Date:   Thu, 24 Jan 2019 20:20:00 +0100
Message-Id: <20190124190209.176402716@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190206.342411005@linuxfoundation.org>
References: <20190124190206.342411005@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 8d4a862276a9c30a269d368d324fb56529e6d5fd ]

Currently xmon needs to get devtree_lock (through rtas_token()) during its
invocation (at crash time). If there is a crash while devtree_lock is being
held, then xmon tries to get the lock but spins forever and never get into
the interactive debugger, as in the following case:

	int *ptr = NULL;
	raw_spin_lock_irqsave(&devtree_lock, flags);
	*ptr = 0xdeadbeef;

This patch avoids calling rtas_token(), thus trying to get the same lock,
at crash time. This new mechanism proposes getting the token at
initialization time (xmon_init()) and just consuming it at crash time.

This would allow xmon to be possible invoked independent of devtree_lock
being held or not.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/xmon/xmon.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 4264aedc7775..dd6badc31f45 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -75,6 +75,9 @@ static int xmon_gate;
 #define xmon_owner 0
 #endif /* CONFIG_SMP */
 
+#ifdef CONFIG_PPC_PSERIES
+static int set_indicator_token = RTAS_UNKNOWN_SERVICE;
+#endif
 static unsigned long in_xmon __read_mostly = 0;
 static int xmon_on = IS_ENABLED(CONFIG_XMON_DEFAULT);
 
@@ -358,7 +361,6 @@ static inline void disable_surveillance(void)
 #ifdef CONFIG_PPC_PSERIES
 	/* Since this can't be a module, args should end up below 4GB. */
 	static struct rtas_args args;
-	int token;
 
 	/*
 	 * At this point we have got all the cpus we can into
@@ -367,11 +369,11 @@ static inline void disable_surveillance(void)
 	 * If we did try to take rtas.lock there would be a
 	 * real possibility of deadlock.
 	 */
-	token = rtas_token("set-indicator");
-	if (token == RTAS_UNKNOWN_SERVICE)
+	if (set_indicator_token == RTAS_UNKNOWN_SERVICE)
 		return;
 
-	rtas_call_unlocked(&args, token, 3, 1, NULL, SURVEILLANCE_TOKEN, 0, 0);
+	rtas_call_unlocked(&args, set_indicator_token, 3, 1, NULL,
+			   SURVEILLANCE_TOKEN, 0, 0);
 
 #endif /* CONFIG_PPC_PSERIES */
 }
@@ -3672,6 +3674,14 @@ static void xmon_init(int enable)
 		__debugger_iabr_match = xmon_iabr_match;
 		__debugger_break_match = xmon_break_match;
 		__debugger_fault_handler = xmon_fault_handler;
+
+#ifdef CONFIG_PPC_PSERIES
+		/*
+		 * Get the token here to avoid trying to get a lock
+		 * during the crash, causing a deadlock.
+		 */
+		set_indicator_token = rtas_token("set-indicator");
+#endif
 	} else {
 		__debugger = NULL;
 		__debugger_ipi = NULL;
-- 
2.19.1



