Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91618C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B722147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691896;
	bh=oXvu1Y3xSPb1qaS7ygk3qh2N0TdlzvTvNxK+3Zqpbp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BhkSe9QzT9utBlup5C2uj25EyWO62LnznHDr2HCLxrCPe4NQTFGJntSavFN+kb6oo
	 3HCSeCbhCmAgHKYttd5d2mKgNaDUsxwDFYAavtrn0OHzecAoubRBhIKPGaJkyJFdvu
	 3mSeIMjOmfO2JzUWgH4SjkK7hyJaIObuxJMskLok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731493AbfA1QLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:11:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:38544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732971AbfA1QL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:11:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66F8C2147A;
        Mon, 28 Jan 2019 16:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691888;
        bh=oXvu1Y3xSPb1qaS7ygk3qh2N0TdlzvTvNxK+3Zqpbp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TePvf149GHoi2mOnBCCEEA7jkGLKhI2m0wzfDpw1LRxZncnSXtUKOTloKCNqsIXfB
         1EfegB96jjQZrgzrBlHCwoeTal/BJRtMTm52sWRLj3yxH3N3uO/t0HGdYoXaZCmPoO
         nky3iHST1vP5gjNcOjlk7pGNBX/gCB/mQGeMvsO8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 250/258] arm64/sve: ptrace: Fix SVE_PT_REGS_OFFSET definition
Date:   Mon, 28 Jan 2019 10:59:16 -0500
Message-Id: <20190128155924.51521-250-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Martin <Dave.Martin@arm.com>

[ Upstream commit ee1b465b303591d3a04d403122bbc0d7026520fb ]

SVE_PT_REGS_OFFSET is supposed to indicate the offset for skipping
over the ptrace NT_ARM_SVE header (struct user_sve_header) to the
start of the SVE register data proper.

However, currently SVE_PT_REGS_OFFSET is defined in terms of struct
sve_context, which is wrong: that structure describes the SVE
header in the signal frame, not in the ptrace regset.

This patch fixes the definition to use the ptrace header structure
struct user_sve_header instead.

By good fortune, the two structures are the same size anyway, so
there is no functional or ABI change.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/uapi/asm/ptrace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
index 98c4ce55d9c3..ad64d2c92ef5 100644
--- a/arch/arm64/include/uapi/asm/ptrace.h
+++ b/arch/arm64/include/uapi/asm/ptrace.h
@@ -130,7 +130,7 @@ struct user_sve_header {
 
 /* Offset from the start of struct user_sve_header to the register data */
 #define SVE_PT_REGS_OFFSET					\
-	((sizeof(struct sve_context) + (SVE_VQ_BYTES - 1))	\
+	((sizeof(struct user_sve_header) + (SVE_VQ_BYTES - 1))	\
 		/ SVE_VQ_BYTES * SVE_VQ_BYTES)
 
 /*
-- 
2.19.1

