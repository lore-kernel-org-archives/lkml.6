Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5552CC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 05:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 095BE214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 05:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qr5A8HkB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 095BE214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752223AbeF0FRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 01:17:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752096AbeF0FRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 01:17:22 -0400
Received: from localhost (c-71-202-137-17.hsd1.ca.comcast.net [71.202.137.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B562F2239D;
        Wed, 27 Jun 2018 05:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530076641;
        bh=TAayc+fKPjgDEen5xVuWWTPLpZ/wF07bFOxGZ0/4Xj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Qr5A8HkBEBIVE1uLcItYGFKSkJDgIqQK5n2dBZLmKUg43/Pc3Gb4OTEhqqWm4ZLmO
         dkhoQuzGYxfKX0hnSyNK0wx3O6BjSjxN4J4fFyav9aiiGAUOof+mO/3Ff4NNdLdv98
         afOONYGUWINuQyVvRETeFEfxoYsAhrobYxvbPwSM=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 2/2] selftests/x86/sigreturn: Minor cleanups
Date:   Tue, 26 Jun 2018 22:17:18 -0700
Message-Id: <bb3bc1f923a2f6fe7912d22a1068fe29d6033d38.1530076529.git.luto@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1530076529.git.luto@kernel.org>
References: <cover.1530076529.git.luto@kernel.org>
In-Reply-To: <cover.1530076529.git.luto@kernel.org>
References: <cover.1530076529.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have short names for the requested and resulting register values.
Use them instead of spelling out the whole register entry for each
case.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 tools/testing/selftests/x86/sigreturn.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/x86/sigreturn.c b/tools/testing/selftests/x86/sigreturn.c
index 2559e2c01793..4d9dc3f2fd70 100644
--- a/tools/testing/selftests/x86/sigreturn.c
+++ b/tools/testing/selftests/x86/sigreturn.c
@@ -610,6 +610,7 @@ static int test_valid_sigreturn(int cs_bits, bool use_16bit_ss, int force_ss)
 	 */
 	for (int i = 0; i < NGREG; i++) {
 		greg_t req = requested_regs[i], res = resulting_regs[i];
+
 		if (i == REG_TRAPNO || i == REG_IP)
 			continue;	/* don't care */
 
@@ -673,18 +674,18 @@ static int test_valid_sigreturn(int cs_bits, bool use_16bit_ss, int force_ss)
 #endif
 
 		/* Sanity check on the kernel */
-		if (i == REG_CX && requested_regs[i] != resulting_regs[i]) {
+		if (i == REG_CX && req != res) {
 			printf("[FAIL]\tCX (saved SP) mismatch: requested 0x%llx; got 0x%llx\n",
-			       (unsigned long long)requested_regs[i],
-			       (unsigned long long)resulting_regs[i]);
+			       (unsigned long long)req,
+			       (unsigned long long)res);
 			nerrs++;
 			continue;
 		}
 
-		if (requested_regs[i] != resulting_regs[i] && !ignore_reg) {
+		if (req != res && !ignore_reg) {
 			printf("[FAIL]\tReg %d mismatch: requested 0x%llx; got 0x%llx\n",
-			       i, (unsigned long long)requested_regs[i],
-			       (unsigned long long)resulting_regs[i]);
+			       i, (unsigned long long)req,
+			       (unsigned long long)res);
 			nerrs++;
 		}
 	}
-- 
2.17.1

