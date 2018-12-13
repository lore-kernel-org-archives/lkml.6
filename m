Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DD7C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7AE20849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675950;
	bh=0JQlf9lnpUVeeXwAygIuD/6K6JoE6jf2iX7HY821o7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sik3EqApvuX3YJbdwrdhlL+Stcmmechz6eiAOUcNTuNI05B5uhF0dkh22vPMlt9OA
	 T5QXPpIX/1ws/DfBlau4Z35FAVxO0iW2xIXowbSsM35ovMkTrp7tr5hlnxZKVgcFU2
	 lsYljEi9ANY7HcBfivMuAJ5U72TAMwPn62ezpkiM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC7AE20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbeLMEjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:39:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:45590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727758AbeLMEco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:32:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3D3F20880;
        Thu, 13 Dec 2018 04:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675563;
        bh=0JQlf9lnpUVeeXwAygIuD/6K6JoE6jf2iX7HY821o7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dKHP0cvafZhLMy+dObsNRrwiqby8qL155p/CTbZkdn13hV4IpAqNqnRqPSUSckh4p
         l0RPWtT/v4xsLDHVjhPgvMAelDDKRE1AasRALboBfUgx/W+LW533HxL9Ucwpm0KugX
         7KgwCIqDb0B2qcg8w7sJOO1PRQ/Ya+t9+dJCBktQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chris Cole <chris@sageembedded.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 25/34] ARM: 8814/1: mm: improve/fix ARM v7_dma_inv_range() unaligned address handling
Date:   Wed, 12 Dec 2018 23:31:51 -0500
Message-Id: <20181213043200.76295-25-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213043200.76295-1-sashal@kernel.org>
References: <20181213043200.76295-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Cole <chris@sageembedded.com>

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
index a134d8a13d00..11d699af30ed 100644
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

