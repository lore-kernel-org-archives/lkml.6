Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBE1C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D86B21855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895105;
	bh=Jk8H50YROFZSpleFUTHOxSdIKyuY4+ZZTMNVfSaxIDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pWqSZg+S9mjbuArB+V7IKp8Ck6Nf+sMW2oZhbe6JmZxcAFy8+Xtn4N6XjiLpDV8wp
	 0+wugjTIH7nE39NfVnuok/04me0UnSrUe9at9j4twf/NJLERx+tUKQm+4UQEhe5Pwa
	 oE4LNYEKVQVS8uvo4ikbBoBYWp7pqsd42qWBKG+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbfBKOZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:25:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:58332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729306AbfBKOY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:24:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3F94214DA;
        Mon, 11 Feb 2019 14:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895099;
        bh=Jk8H50YROFZSpleFUTHOxSdIKyuY4+ZZTMNVfSaxIDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nuM39LtTuawoGH25/XO9uFXfh+NhmgWmcrimMqHll/m8+sXix8AhiwafY0ylmM9KQ
         6jqky5dBzaysRAQSlmBKAoqaHxwCCIn5PSDCLN9In/oFi+et+gqBWZY5PBEAN+gXfr
         m/VLtLm3b7bEyw5UEiC4+J66u6r+tsYqNOj3qWrA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 092/352] arm64: io: Ensure value passed to __iormb() is held in a 64-bit register
Date:   Mon, 11 Feb 2019 15:15:19 +0100
Message-Id: <20190211141851.743766379@linuxfoundation.org>
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
index d42d00d8d5b6..ee723835c1f4 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -117,7 +117,8 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
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



