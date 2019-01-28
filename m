Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A2AC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456572148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548696639;
	bh=9p0M5hU8TYgTnEXIwZiGW37tGdTfecX6jWJufOe+eec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xuc1tgsraztlF/3KZtr/EZg8JVX8hEtSDqJGmxc1iyZKCmvoEHADORmlcTYKupY+2
	 qlWa7wJ22FdUWF13sPNlrh7K/ZBj645RvC9U2hzNyC5odwEkoYt87fdduaghIWeZ8D
	 p494zQ7b4t5XQMYmwTG8+xiIGQwlCRaLHXKTZ72U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbfA1P6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:58:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:44078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729986AbfA1P6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:58:39 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0280F21848;
        Mon, 28 Jan 2019 15:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691119;
        bh=9p0M5hU8TYgTnEXIwZiGW37tGdTfecX6jWJufOe+eec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fRtvCosIQnNsDPvE+R4LTBwfyhdE+2k2H+qUKRCrITAdvSz2Do1ZBi71wjyA9Smjt
         m75yaljn8L5kp6s/0XcNpENRlNhqxvF73w+4iAlINjSdJvD+rEWE1ltQ7lGlvW8GjC
         LfLrgvrVm+erJO+nB82j62mlKDSDMntrTbtt06rg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 295/304] arm64/sve: ptrace: Fix SVE_PT_REGS_OFFSET definition
Date:   Mon, 28 Jan 2019 10:43:32 -0500
Message-Id: <20190128154341.47195-295-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
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

