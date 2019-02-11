Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E716C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64AEA21B18
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900469;
	bh=/1AKaazZBrp7vCjUjcn1mZqGMVItqWxAcv/D3igiKkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m2qAPQmxP79N/hMMlSp4ulrUHKp8W6J5S+aXHuEwxh2/9rWe1GK7bTABHjT0/rK1W
	 PDgDzCIjdBaCbIa7jf53puHQuqilUTwJH7W4y1El5sAOQla3aOAk6osh0/ovgwZ/In
	 jIbs6ohIx1uxR/Rp0Fv7sru5SDCbRZqQugjUmgxE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731668AbfBKPy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:54:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:44494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731097AbfBKOfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:35:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE36E2080F;
        Mon, 11 Feb 2019 14:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895744;
        bh=/1AKaazZBrp7vCjUjcn1mZqGMVItqWxAcv/D3igiKkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ot6wNnzC1A+QRe7JUVwmWlUlLXCmBGSNJgktSHzV2OGRnnSEehBQ62c8VDvUAEMno
         xBei/R5Anpae9VGDpLpQR2rLuba52BzWL26tNqKgCqiLjJWCndmME+acMUjOeR1V9k
         EEf9msnk3CQx2mVa7Ix6BxBYNF8gAHSCLh1XPZ5w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 281/352] arm64/sve: ptrace: Fix SVE_PT_REGS_OFFSET definition
Date:   Mon, 11 Feb 2019 15:18:28 +0100
Message-Id: <20190211141904.817811652@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index a36227fdb084..65ef8b0fdb0e 100644
--- a/arch/arm64/include/uapi/asm/ptrace.h
+++ b/arch/arm64/include/uapi/asm/ptrace.h
@@ -131,7 +131,7 @@ struct user_sve_header {
 
 /* Offset from the start of struct user_sve_header to the register data */
 #define SVE_PT_REGS_OFFSET					\
-	((sizeof(struct sve_context) + (SVE_VQ_BYTES - 1))	\
+	((sizeof(struct user_sve_header) + (SVE_VQ_BYTES - 1))	\
 		/ SVE_VQ_BYTES * SVE_VQ_BYTES)
 
 /*
-- 
2.19.1



