Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8866C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A802192B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550198448;
	bh=sHOffNftr5cojCLr4zTtyl8CXbnnKArh2igKxuogNS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QvSqiEfTPXW4xgLxZoGxxlCBYJx+kGAd4P8jiMzSCzU8p1Mzs8/61omoND59h8jYN
	 yIjWixNQVJoUMIv1FF3ye3YgZ643B8FD5xCEW4U2vxQcP5RnzBhXr32bMmJcAmx726
	 dpdYlT2wOG2rWGNMgKgUesfs91DOVnwvbo0hvAIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730835AbfBOCkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:40:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:49984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389306AbfBOCJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:09:50 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51D0A222A1;
        Fri, 15 Feb 2019 02:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196590;
        bh=sHOffNftr5cojCLr4zTtyl8CXbnnKArh2igKxuogNS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TWVc08OfnDuScZCAqdE4TZkRJxJlNazLaFr3VkED658wT0+D0GwuZhfH53HO63bGB
         /FZsPqVW4xG+0QXks9hDY4I5GvCHid7gMBUFT6YS5F/Ig2ylzhB2aHIEPP/m1ewlPu
         +rWvCOggczcXRDCpLF4U439ABZYTQAA3UUOHm+Ok=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH AUTOSEL 4.20 32/77] ARC: fix __ffs return value to avoid build warnings
Date:   Thu, 14 Feb 2019 21:08:10 -0500
Message-Id: <20190215020855.176727-32-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215020855.176727-1-sashal@kernel.org>
References: <20190215020855.176727-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>

[ Upstream commit 4e868f8419cb4cb558c5d428e7ab5629cef864c7 ]

|  CC      mm/nobootmem.o
|In file included from ./include/asm-generic/bug.h:18:0,
|                 from ./arch/arc/include/asm/bug.h:32,
|                 from ./include/linux/bug.h:5,
|                 from ./include/linux/mmdebug.h:5,
|                 from ./include/linux/gfp.h:5,
|                 from ./include/linux/slab.h:15,
|                 from mm/nobootmem.c:14:
|mm/nobootmem.c: In function '__free_pages_memory':
|./include/linux/kernel.h:845:29: warning: comparison of distinct pointer types lacks a cast
|   (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
|                             ^
|./include/linux/kernel.h:859:4: note: in expansion of macro '__typecheck'
|   (__typecheck(x, y) && __no_side_effects(x, y))
|    ^~~~~~~~~~~
|./include/linux/kernel.h:869:24: note: in expansion of macro '__safe_cmp'
|  __builtin_choose_expr(__safe_cmp(x, y), \
|                        ^~~~~~~~~~
|./include/linux/kernel.h:878:19: note: in expansion of macro '__careful_cmp'
| #define min(x, y) __careful_cmp(x, y, <)
|                   ^~~~~~~~~~~~~
|mm/nobootmem.c:104:11: note: in expansion of macro 'min'
|   order = min(MAX_ORDER - 1UL, __ffs(start));

Change __ffs return value from 'int' to 'unsigned long' as it
is done in other implementations (like asm-generic, x86, etc...)
to avoid build-time warnings in places where type is strictly
checked.

As __ffs may return values in [0-31] interval changing return
type to unsigned is valid.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arc/include/asm/bitops.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arc/include/asm/bitops.h b/arch/arc/include/asm/bitops.h
index 8da87feec59a..99e6d8948f4a 100644
--- a/arch/arc/include/asm/bitops.h
+++ b/arch/arc/include/asm/bitops.h
@@ -340,7 +340,7 @@ static inline __attribute__ ((const)) int __fls(unsigned long x)
 /*
  * __ffs: Similar to ffs, but zero based (0-31)
  */
-static inline __attribute__ ((const)) int __ffs(unsigned long word)
+static inline __attribute__ ((const)) unsigned long __ffs(unsigned long word)
 {
 	if (!word)
 		return word;
@@ -400,9 +400,9 @@ static inline __attribute__ ((const)) int ffs(unsigned long x)
 /*
  * __ffs: Similar to ffs, but zero based (0-31)
  */
-static inline __attribute__ ((const)) int __ffs(unsigned long x)
+static inline __attribute__ ((const)) unsigned long __ffs(unsigned long x)
 {
-	int n;
+	unsigned long n;
 
 	asm volatile(
 	"	ffs.f	%0, %1		\n"  /* 0:31; 31(Z) if src 0 */
-- 
2.19.1

