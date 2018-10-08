Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90780C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 338032156B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2ufIrmN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 338032156B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbeJHWkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:40:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729122AbeJHWkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:40:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C2B321531;
        Mon,  8 Oct 2018 15:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012464;
        bh=yLWT7jys5R3CdOT/S2wCCnXKQXYGAd/tZnmO6KnnGNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N2ufIrmNjODdOs6gIG7wm95yIcXz13wLosLrcn7jmpqwsveeVgqWf2RLu4IjmCdWZ
         +ZX6F6o6L5XPMjqk+qGytQrdVAhqC34i62EI37jn5hHOQUUHogNHTMEllg1XrCNEyG
         L4WFa5IiLJIQGjzEyK85IPbaFibF1gs+gr5F9oHI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Neuling <mikey@neuling.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 9/9] powerpc/tm: Avoid possible userspace r1 corruption on reclaim
Date:   Mon,  8 Oct 2018 11:27:34 -0400
Message-Id: <20181008152734.70962-9-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152734.70962-1-sashal@kernel.org>
References: <20181008152734.70962-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Neuling <mikey@neuling.org>

[ Upstream commit 96dc89d526ef77604376f06220e3d2931a0bfd58 ]

Current we store the userspace r1 to PACATMSCRATCH before finally
saving it to the thread struct.

In theory an exception could be taken here (like a machine check or
SLB miss) that could write PACATMSCRATCH and hence corrupt the
userspace r1. The SLB fault currently doesn't touch PACATMSCRATCH, but
others do.

We've never actually seen this happen but it's theoretically
possible. Either way, the code is fragile as it is.

This patch saves r1 to the kernel stack (which can't fault) before we
turn MSR[RI] back on. PACATMSCRATCH is still used but only with
MSR[RI] off. We then copy r1 from the kernel stack to the thread
struct once we have MSR[RI] back on.

Suggested-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/kernel/tm.S | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
index cf30c2c36502..2d2860711e07 100644
--- a/arch/powerpc/kernel/tm.S
+++ b/arch/powerpc/kernel/tm.S
@@ -201,6 +201,13 @@ dont_backup_fp:
 
 	std	r11, GPR11(r1)			/* Temporary stash */
 
+	/*
+	 * Move the saved user r1 to the kernel stack in case PACATMSCRATCH is
+	 * clobbered by an exception once we turn on MSR_RI below.
+	 */
+	ld	r11, PACATMSCRATCH(r13)
+	std	r11, GPR1(r1)
+
 	/*
 	 * Store r13 away so we can free up the scratch SPR for the SLB fault
 	 * handler (needed once we start accessing the thread_struct).
@@ -237,7 +244,7 @@ dont_backup_fp:
 	SAVE_GPR(8, r7)				/* user r8 */
 	SAVE_GPR(9, r7)				/* user r9 */
 	SAVE_GPR(10, r7)			/* user r10 */
-	ld	r3, PACATMSCRATCH(r13)		/* user r1 */
+	ld	r3, GPR1(r1)			/* user r1 */
 	ld	r4, GPR7(r1)			/* user r7 */
 	ld	r5, GPR11(r1)			/* user r11 */
 	ld	r6, GPR12(r1)			/* user r12 */
-- 
2.17.1

