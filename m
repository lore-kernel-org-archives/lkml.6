Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F7EC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9533621B18
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896127;
	bh=YKKH742eFm4iRGf+i9ipmihgqcDANaWr4XXE/BE2hiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FsqQ1SgDrPv5fiAgmC/UnGJ26hpEcF2ZKxOF3ysU3nCfBsn7TgebaVWcJF9Pa9ufk
	 RrecppEEhAM18tFNuxLwkx8o/r+6Gc5lDdziOcwToU5sDE/mAovnEJclxCJ2gP9r9W
	 YQaC0Xe7byf3ed3nQ486yC3HEUQn0JqnAW3r0fIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732356AbfBKOmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:42:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:53682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731937AbfBKOmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:42:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4001E2081B;
        Mon, 11 Feb 2019 14:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896120;
        bh=YKKH742eFm4iRGf+i9ipmihgqcDANaWr4XXE/BE2hiU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=szE4WGh9TEBE4sBfLJ0V+0ZXYbjNxZvhcyXSrHw12tkKAbPWyAkvD4SbAEUJQsnVN
         1ww6/5fnvEK5nqfqTavF9wcsriInVYosqypywzRFYAQrNd2GsRr1upXo18kSdM1QDs
         /9YEfMXWSEXhbGuiNe7tjKWcgb5zLd+Q7zN0Vn+c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 079/313] arm64: io: Ensure value passed to __iormb() is held in a 64-bit register
Date:   Mon, 11 Feb 2019 15:15:59 +0100
Message-Id: <20190211141859.166378526@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



