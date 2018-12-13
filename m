Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BD8C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B977B20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544676435;
	bh=zQf/L+b3WFd4rJBEAlVsxd9uIGB8od/4GFq2DZ0bXPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0A3FReHdDAw6KhZWT1sf36cb0eyQif1vQ4cJWc/JifTU0ynTNUY0lTFhohuiTDimY
	 rzL6Su+CfIp3H4MnuM4JlPGIvkBx1D85JzmR2GKyzmMj8rQfFmLxWR06t7MRrHcB8v
	 OQZVuFsbS6W1DkOQexI8965Adwbw1oitlkgh4XsA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B977B20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbeLMErO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:47:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:43198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728159AbeLMEaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:30:16 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4812120879;
        Thu, 13 Dec 2018 04:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675416;
        bh=zQf/L+b3WFd4rJBEAlVsxd9uIGB8od/4GFq2DZ0bXPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VjixBlcLtyTDFSbiao0OqMmPCF1CGwk2BCKtMuhsG6jGPG3d9gUi6p38fwRUAIlrT
         lEwGL8VKlYGFb5c4j2DnR3+H0vnyhyBYYHsdZ7w+Wyevrf8fcDAIdilMmDjuQ2BQYW
         3TtnHW2tKSIDG98rconfmj6MdFcMr0ad5A7Q4ubE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vladimir Murzin <vladimir.murzin@arm.com>,
        Chris Cole <chris@sageembedded.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 52/73] ARM: 8815/1: V7M: align v7m_dma_inv_range() with v7 counterpart
Date:   Wed, 12 Dec 2018 23:28:17 -0500
Message-Id: <20181213042838.75160-52-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213042838.75160-1-sashal@kernel.org>
References: <20181213042838.75160-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Murzin <vladimir.murzin@arm.com>

[ Upstream commit 3d0358d0ba048c5afb1385787aaec8fa5ad78fcc ]

Chris has discovered and reported that v7_dma_inv_range() may corrupt
memory if address range is not aligned to cache line size.

Since the whole cache-v7m.S was lifted form cache-v7.S the same
observation applies to v7m_dma_inv_range(). So the fix just mirrors
what has been done for v7 with a little specific of M-class.

Cc: Chris Cole <chris@sageembedded.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mm/cache-v7m.S | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mm/cache-v7m.S b/arch/arm/mm/cache-v7m.S
index 788486e830d3..32aa2a2aa260 100644
--- a/arch/arm/mm/cache-v7m.S
+++ b/arch/arm/mm/cache-v7m.S
@@ -73,9 +73,11 @@
 /*
  * dcimvac: Invalidate data cache line by MVA to PoC
  */
-.macro dcimvac, rt, tmp
-	v7m_cacheop \rt, \tmp, V7M_SCB_DCIMVAC
+.irp    c,,eq,ne,cs,cc,mi,pl,vs,vc,hi,ls,ge,lt,gt,le,hs,lo
+.macro dcimvac\c, rt, tmp
+	v7m_cacheop \rt, \tmp, V7M_SCB_DCIMVAC, \c
 .endm
+.endr
 
 /*
  * dccmvau: Clean data cache line by MVA to PoU
@@ -369,14 +371,16 @@ v7m_dma_inv_range:
 	tst	r0, r3
 	bic	r0, r0, r3
 	dccimvacne r0, r3
+	addne	r0, r0, r2
 	subne	r3, r2, #1	@ restore r3, corrupted by v7m's dccimvac
 	tst	r1, r3
 	bic	r1, r1, r3
 	dccimvacne r1, r3
-1:
-	dcimvac r0, r3
-	add	r0, r0, r2
 	cmp	r0, r1
+1:
+	dcimvaclo r0, r3
+	addlo	r0, r0, r2
+	cmplo	r0, r1
 	blo	1b
 	dsb	st
 	ret	lr
-- 
2.19.1

