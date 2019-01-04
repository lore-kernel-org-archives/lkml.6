Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81989C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A21C2070C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbfADNKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 08:10:39 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42078 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbfADNKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 08:10:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76562EBD;
        Fri,  4 Jan 2019 05:10:38 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6439F3F575;
        Fri,  4 Jan 2019 05:10:37 -0800 (PST)
From:   Dave Martin <Dave.Martin@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Alan Hayward <alan.hayward@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>
Subject: [PATCH v2 1/2] arm64/sve: ptrace: Fix SVE_PT_REGS_OFFSET definition
Date:   Fri,  4 Jan 2019 13:09:50 +0000
Message-Id: <1546607391-3850-2-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1546607391-3850-1-git-send-email-Dave.Martin@arm.com>
References: <1546607391-3850-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 arch/arm64/include/uapi/asm/ptrace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
index a36227f..65ef8b0 100644
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
2.1.4

