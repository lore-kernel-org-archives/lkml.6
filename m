Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6B3C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1CF20827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977234;
	bh=KB46h2aTYnehXf5nRJXlRgXw8M6hO7Y2Oh0GENXFiUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Py3d0wMURXz5IIgmsFyTEq01BpeUm0cSQZN2IJ0ca013xzvx5Di8z5FiToMwiYUmu
	 hGGPXxgQRH/XTA9ytyDRET26Vbwkb1HDY9d9lvho0+TAKRlgLgxS8UhHJCGqtRvOPw
	 LEu2Gq4OzIdQF0d3CDX+3YgCLZorizUNqZP7fvEY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbfAHTxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:53:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:38768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729922AbfAHTax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:30:53 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D96A820827;
        Tue,  8 Jan 2019 19:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975852;
        bh=KB46h2aTYnehXf5nRJXlRgXw8M6hO7Y2Oh0GENXFiUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zOR6pdBn7mLqjWe+UKdUNkgD7wPzhfqOwkqzDSlkTlxBAVrr2V+Gd+i9dSFzpcD4b
         f/A7lB+diDzkVLGBnuHXizNt3AQOMVcaLNZORMW/mpmzc+Bpnh9nnmkWh9J4PZrbZT
         wGKNwauB2j0G5ulUvFGSKDNu60O/Yp0Cj0KeddUQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Breno Leitao <leitao@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.19 37/97] powerpc/xmon: Fix invocation inside lock region
Date:   Tue,  8 Jan 2019 14:28:46 -0500
Message-Id: <20190108192949.122407-37-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192949.122407-1-sashal@kernel.org>
References: <20190108192949.122407-1-sashal@kernel.org>
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

