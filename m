Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD4DC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 383592150B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUyZ/0Or"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 383592150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbeJHWjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:39:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:58236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728627AbeJHWjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:39:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5831121531;
        Mon,  8 Oct 2018 15:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012417;
        bh=0fxxZfuYdHxbi7QhDMC7ITO2eAixZjaxSH4Yt7qsQEc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AUyZ/0OrOb0Kw+7S2ZgBo/p1h9YVOwclX/euuFccS/oo7pGxUqhgscyAbSkOuxYmY
         JiRunaW9tQMW+SADGO/ZnqAPXv4JMNLqMPGCC76UjBqaRXFh/2r/1AKI6Tgwms2cer
         7ciqmMlbHB7AvsOOBSvtd0rS1j0D8EH1M882Xj3E=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Neuling <mikey@neuling.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 30/32] powerpc/tm: Fix userspace r13 corruption
Date:   Mon,  8 Oct 2018 11:26:27 -0400
Message-Id: <20181008152629.70812-30-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152629.70812-1-sashal@kernel.org>
References: <20181008152629.70812-1-sashal@kernel.org>
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
index 1da12f521cb7..69eacb85ebca 100644
--- a/arch/powerpc/kernel/tm.S
+++ b/arch/powerpc/kernel/tm.S
@@ -167,13 +167,20 @@ _GLOBAL(tm_reclaim)
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
 
@@ -202,7 +209,7 @@ _GLOBAL(tm_reclaim)
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

