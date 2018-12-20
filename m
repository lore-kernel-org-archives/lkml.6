Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C957C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BDE42177E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297613;
	bh=dgZP//dKhWWQis8jfr9wJyae5Os8odn/OcIposc5MVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MsTRDQSR9fXZdv+1JDwWoKfd2zn5Y2vono1btvya4plklsIkMMX3tDLWEM3Kgt+1B
	 I/OZxKHeEV1+3APUU/SUlUkbORXxqZ5n443BPNzwYOMWffWjtVOmUOaEYdWWq1ssff
	 Phgiw2gpTuqEAnUj8EBPvHjKjQz+QsDjGo98wXMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbeLTJUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:20:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:49664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730589AbeLTJUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:20:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE96D21720;
        Thu, 20 Dec 2018 09:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297609;
        bh=dgZP//dKhWWQis8jfr9wJyae5Os8odn/OcIposc5MVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W0k1QbTYkj/j3yhm81/kdnBQQS1apJAmNDlcFjQblNjghNsn5Xh8Gu0M59qDf4l+5
         p/b/lflCtu82EKwLuaR8JCn9kD/jVDepNRefpWy10ImEdIfkr7MUwYTFF8a9dE9FCR
         Q8ItT6RmDxuRp6vS5y+exJHy7WOVQSY3jW3b4MU0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Cole <chris@sageembedded.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 23/31] ARM: 8814/1: mm: improve/fix ARM v7_dma_inv_range() unaligned address handling
Date:   Thu, 20 Dec 2018 10:18:35 +0100
Message-Id: <20181220085743.528836665@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085742.601260254@linuxfoundation.org>
References: <20181220085742.601260254@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit a1208f6a822ac29933e772ef1f637c5d67838da9 ]

This patch addresses possible memory corruption when
v7_dma_inv_range(start_address, end_address) address parameters are not
aligned to whole cache lines. This function issues "invalidate" cache
management operations to all cache lines from start_address (inclusive)
to end_address (exclusive). When start_address and/or end_address are
not aligned, the start and/or end cache lines are first issued "clean &
invalidate" operation. The assumption is this is done to ensure that any
dirty data addresses outside the address range (but part of the first or
last cache lines) are cleaned/flushed so that data is not lost, which
could happen if just an invalidate is issued.

The problem is that these first/last partial cache lines are issued
"clean & invalidate" and then "invalidate". This second "invalidate" is
not required and worse can cause "lost" writes to addresses outside the
address range but part of the cache line. If another component writes to
its part of the cache line between the "clean & invalidate" and
"invalidate" operations, the write can get lost. This fix is to remove
the extra "invalidate" operation when unaligned addressed are used.

A kernel module is available that has a stress test to reproduce the
issue and a unit test of the updated v7_dma_inv_range(). It can be
downloaded from
http://ftp.sageembedded.com/outgoing/linux/cache-test-20181107.tgz.

v7_dma_inv_range() is call by dmac_[un]map_area(addr, len, direction)
when the direction is DMA_FROM_DEVICE. One can (I believe) successfully
argue that DMA from a device to main memory should use buffers aligned
to cache line size, because the "clean & invalidate" might overwrite
data that the device just wrote using DMA. But if a driver does use
unaligned buffers, at least this fix will prevent memory corruption
outside the buffer.

Signed-off-by: Chris Cole <chris@sageembedded.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mm/cache-v7.S | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index b966656d2c2d..7e98fecff55a 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -359,14 +359,16 @@ v7_dma_inv_range:
 	ALT_UP(W(nop))
 #endif
 	mcrne	p15, 0, r0, c7, c14, 1		@ clean & invalidate D / U line
+	addne	r0, r0, r2
 
 	tst	r1, r3
 	bic	r1, r1, r3
 	mcrne	p15, 0, r1, c7, c14, 1		@ clean & invalidate D / U line
-1:
-	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D / U line
-	add	r0, r0, r2
 	cmp	r0, r1
+1:
+	mcrlo	p15, 0, r0, c7, c6, 1		@ invalidate D / U line
+	addlo	r0, r0, r2
+	cmplo	r0, r1
 	blo	1b
 	dsb	st
 	ret	lr
-- 
2.19.1



