Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB034C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B45F20449
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298399;
	bh=C6OVpOzz4MKM26/FjmUvne7G+6Yqh98GjhmHUnf5miU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MmNlOoo+WNbIx+2STMhlS3NV2NT647F/stNjw+67UfvIh3h5Re4syhlMLk2blLTgb
	 FvGoGh5FQILq7mRbJ55Bshphey/dY6VbDBl8HKffIIQLR5PTdWYhD/2N1qO6Rx+ulK
	 k97rI1BMHeVI2dpfmEgj3X3gFlI6kZFJ7MIkGupE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733096AbeLTJdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:33:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:38742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732941AbeLTJac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:30:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A41B21741;
        Thu, 20 Dec 2018 09:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298231;
        bh=C6OVpOzz4MKM26/FjmUvne7G+6Yqh98GjhmHUnf5miU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RNiPw/rRo2xf2B/z7UTdv21M7GpaVCWvqv9UN7NlOZP86D2I8o6a1bI3b7Kr50tHq
         mFDkfKFtCTAQY2rYJ8GnzH4FvJPkGLP0givItwahTq1vL0nhZ8EI52GwsBVkR4omyt
         H89yYiuBLOroG2mAZsOgqB+QA3u6Mvdu44bQshLI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Cole <chris@sageembedded.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 48/67] ARM: 8815/1: V7M: align v7m_dma_inv_range() with v7 counterpart
Date:   Thu, 20 Dec 2018 10:19:00 +0100
Message-Id: <20181220085905.447022350@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085903.562090333@linuxfoundation.org>
References: <20181220085903.562090333@linuxfoundation.org>
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



