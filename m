Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0081DC677E4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B374021570
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wSCjz+CK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B374021570
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbeJHWkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:40:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:59530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728002AbeJHWj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:39:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6608621565;
        Mon,  8 Oct 2018 15:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012464;
        bh=wL5m3dlXd8aOxFok/+DpmwoEtTcq6UWrosLCzUZk5GA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wSCjz+CKdCVyhJPKviE+qH+N/2MPkwTY9r3osWI1yWL0ON2Gvn6pQJIEjfnjip28J
         AN2ZzqrlzcMTRd67PCKCseHrz+PtZ5sr1QDLFqJwwCK4x2JuL1uCqD+CFVxhD6iiWd
         IjKazIA2O/z8zl+qTwe5ftbq5tZmBEHCxxGXbB/0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Neuling <mikey@neuling.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 8/9] powerpc/tm: Fix userspace r13 corruption
Date:   Mon,  8 Oct 2018 11:27:33 -0400
Message-Id: <20181008152734.70962-8-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152734.70962-1-sashal@kernel.org>
References: <20181008152734.70962-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Neuling <mikey@neuling.org>

[ Upstream commit cf13435b730a502e814c63c84d93db131e563f5f ]

When we treclaim we store the userspace checkpointed r13 to a scratch
SPR and then later save the scratch SPR to the user thread struct.

Unfortunately, this doesn't work as accessing the user thread struct
can take an SLB fault and the SLB fault handler will write the same
scratch SPRG that now contains the userspace r13.

To fix this, we store r13 to the kernel stack (which can't fault)
before we access the user thread struct.

Found by running P8 guest + powervm + disable_1tb_segments + TM. Seen
as a random userspace segfault with r13 looking like a kernel address.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/kernel/tm.S | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
index b7019b559ddb..cf30c2c36502 100644
--- a/arch/powerpc/kernel/tm.S
+++ b/arch/powerpc/kernel/tm.S
@@ -199,13 +199,20 @@ dont_backup_fp:
 	std	r1, PACATMSCRATCH(r13)
 	ld	r1, PACAR1(r13)
 
-	/* Store the PPR in r11 and reset to decent value */
 	std	r11, GPR11(r1)			/* Temporary stash */
 
+	/*
+	 * Store r13 away so we can free up the scratch SPR for the SLB fault
+	 * handler (needed once we start accessing the thread_struct).
+	 */
+	GET_SCRATCH0(r11)
+	std	r11, GPR13(r1)
+
 	/* Reset MSR RI so we can take SLB faults again */
 	li	r11, MSR_RI
 	mtmsrd	r11, 1
 
+	/* Store the PPR in r11 and reset to decent value */
 	mfspr	r11, SPRN_PPR
 	HMT_MEDIUM
 
@@ -234,7 +241,7 @@ dont_backup_fp:
 	ld	r4, GPR7(r1)			/* user r7 */
 	ld	r5, GPR11(r1)			/* user r11 */
 	ld	r6, GPR12(r1)			/* user r12 */
-	GET_SCRATCH0(8)				/* user r13 */
+	ld	r8, GPR13(r1)			/* user r13 */
 	std	r3, GPR1(r7)
 	std	r4, GPR7(r7)
 	std	r5, GPR11(r7)
-- 
2.17.1

