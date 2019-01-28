Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D733AC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A673C20879
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548692061;
	bh=TEkgNeXJVm2BYY9sKTJNoUkPb7TZeze7t3q2S7JhTZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Mu09gkH7PdpnJ1vzDV/16/1ie6sivg52YsR0Gc28HvUZ36GqKuiIqaRb4AiJ75fws
	 0RdyLuW5zCDohQHBdlT8KHd2sqwE1gtzt/KVWLW40HDKE/ahW/Cn01vrTiq7YQDQ3U
	 shfx3t05Qd97i3W6TXfkEsJYHfTT9evZr8JDCpAA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387604AbfA1QOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:14:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:43464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732851AbfA1QOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:14:15 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6ACB20879;
        Mon, 28 Jan 2019 16:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692055;
        bh=TEkgNeXJVm2BYY9sKTJNoUkPb7TZeze7t3q2S7JhTZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vNWGUwj1ieFW7yQmQfBs502FnI62Xx6TG6YJjcle0Vf1saYXNUTlne2YLbD4lH5t5
         srBYDvjfpT2Pmm0738QIhBNSkFvt7QMApp1SdN3CPRkf1JirqHl+1zeo7ZgAA8jHpi
         hzw4w9WtWOVXnRZ3vRVWaa7lPu8q4OU1roHn5jI4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Will Deacon <will.deacon@arm.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 055/170] arm64: io: Ensure value passed to __iormb() is held in a 64-bit register
Date:   Mon, 28 Jan 2019 11:10:05 -0500
Message-Id: <20190128161200.55107-55-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will.deacon@arm.com>

[ Upstream commit 1b57ec8c75279b873639eb44a215479236f93481 ]

As of commit 6460d3201471 ("arm64: io: Ensure calls to delay routines
are ordered against prior readX()"), MMIO reads smaller than 64 bits
fail to compile under clang because we end up mixing 32-bit and 64-bit
register operands for the same data processing instruction:

./include/asm-generic/io.h:695:9: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
        return readb(addr);
               ^
./arch/arm64/include/asm/io.h:147:58: note: expanded from macro 'readb'
                                                                       ^
./include/asm-generic/io.h:695:9: note: use constraint modifier "w"
./arch/arm64/include/asm/io.h:147:50: note: expanded from macro 'readb'
                                                               ^
./arch/arm64/include/asm/io.h:118:24: note: expanded from macro '__iormb'
        asm volatile("eor       %0, %1, %1\n"                           \
                                    ^

Fix the build by casting the macro argument to 'unsigned long' when used
as an input to the inline asm.

Reported-by: Nick Desaulniers <nick.desaulniers@gmail.com>
Reported-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/io.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index b2bc7dbc1fa6..49bb9a020a09 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -119,7 +119,8 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
 	 */								\
 	asm volatile("eor	%0, %1, %1\n"				\
 		     "cbnz	%0, ."					\
-		     : "=r" (tmp) : "r" (v) : "memory");		\
+		     : "=r" (tmp) : "r" ((unsigned long)(v))		\
+		     : "memory");					\
 })
 
 #define __iowmb()		wmb()
-- 
2.19.1

