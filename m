Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BF2C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7AF2063F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546976527;
	bh=UGsAZMkOeiD/tT+lLjJ+E9m2QYDZPRdZ1P3jM8rypUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PUHZQSAT0vz048wGDImodXRGqLT7KTR5iZuzs4Ig+pHOS/g8kx6dPxEShceiDENJC
	 iwl+vVmNt5/IJaD3Pco1Y4UlDfIzoxW7bYVaKcaLs35xATSN1J4osgj4F4vNBUY77+
	 lI+SOpxTqGKsqoEOFPUchf/aXsphS2pR65vwaAfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732642AbfAHTmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:42:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:42908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731865AbfAHTeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:34:12 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C409D205C9;
        Tue,  8 Jan 2019 19:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546976051;
        bh=UGsAZMkOeiD/tT+lLjJ+E9m2QYDZPRdZ1P3jM8rypUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WB5ED/dFNyxhvnX4Uz0WiaXMjlJ6qQGSdN/MQ/IKd2GnxRBgH/+RL4lo8M9Ur+8pJ
         JfASLjr7RiadZhz9kfVcTXgX3JlCA+T4bvPMNLiwLXxFZUv+5O2M0b27+VcPdYNK6x
         t3srdYWcg7Tkzv/rmdtGxb/ED9ccq74RGlyZvShM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Breno Leitao <leitao@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.9 14/36] powerpc/xmon: Fix invocation inside lock region
Date:   Tue,  8 Jan 2019 14:33:26 -0500
Message-Id: <20190108193348.123880-14-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108193348.123880-1-sashal@kernel.org>
References: <20190108193348.123880-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Breno Leitao <leitao@debian.org>

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
index 760545519a0b..687e8b8bf5c6 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -73,6 +73,9 @@ static int xmon_gate;
 #define xmon_owner 0
 #endif /* CONFIG_SMP */
 
+#ifdef CONFIG_PPC_PSERIES
+static int set_indicator_token = RTAS_UNKNOWN_SERVICE;
+#endif
 static unsigned long in_xmon __read_mostly = 0;
 
 static unsigned long adrs;
@@ -340,7 +343,6 @@ static inline void disable_surveillance(void)
 #ifdef CONFIG_PPC_PSERIES
 	/* Since this can't be a module, args should end up below 4GB. */
 	static struct rtas_args args;
-	int token;
 
 	/*
 	 * At this point we have got all the cpus we can into
@@ -349,11 +351,11 @@ static inline void disable_surveillance(void)
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
@@ -3227,6 +3229,14 @@ static void xmon_init(int enable)
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

