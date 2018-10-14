Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65318C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 18:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 110882077C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 18:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RV/rcYO9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 110882077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbeJOBy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 21:54:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53924 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbeJOBy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 21:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1GZ8paWiez3LUjyT/8nFcRlnjJoYXL51jei/BBmqubw=; b=RV/rcYO9sA1ii0G8GO0hIxlJr
        YGfPshxWt/jZB01BX+7zwckuTEYPAZHGFj9q/IBzuiHOZjdhAOZMwdOvCowQC8zUA0ZJIMgzZUMIv
        OdV3aeVmuVc6RAAgpeal6lNstW7PpDYvjPgw8esnF87Pa3644FbW5Adi5NWRpW2DvjQgk0p3UMSFK
        WbVDRjuOJ7CI+C4ZkrqAI72j7IMCRihoyvDOZdwhTOeu+CMVpneIC3iAiOCex4tXaqn6/lQrw+FCC
        nAiKBuMlpf9HXJU1KSJ7eZgG00DeY6XAs03yiqYPRby1Pn3nlVaK5eczy5r9+TpMKT8fV+uS9yZLk
        H+9gJsrzg==;
Received: from 089144199123.atnat0008.highway.a1.net ([89.144.199.123] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gBkt0-0006Sh-IY; Sun, 14 Oct 2018 18:13:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     chris@zankel.net, jcmvbkbc@gmail.com
Cc:     linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xtensa: remove ZONE_DMA
Date:   Sun, 14 Oct 2018 20:13:04 +0200
Message-Id: <20181014181304.22250-1-hch@lst.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ZONE_DMA is intended for magic < 32-bit pools (usually ISA DMA), which
isn't required on xtensa.  Move all the non-highmem memory into
ZONE_NORMAL instead to match other architectures.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/xtensa/Kconfig   | 3 ---
 arch/xtensa/mm/init.c | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 516694937b7a..9a7c654a7654 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -1,7 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-config ZONE_DMA
-	def_bool y
-
 config XTENSA
 	def_bool y
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
diff --git a/arch/xtensa/mm/init.c b/arch/xtensa/mm/init.c
index 34aead7dcb48..b385e6b73065 100644
--- a/arch/xtensa/mm/init.c
+++ b/arch/xtensa/mm/init.c
@@ -71,7 +71,7 @@ void __init zones_init(void)
 {
 	/* All pages are DMA-able, so we put them all in the DMA zone. */
 	unsigned long zones_size[MAX_NR_ZONES] = {
-		[ZONE_DMA] = max_low_pfn - ARCH_PFN_OFFSET,
+		[ZONE_NORMAL] = max_low_pfn - ARCH_PFN_OFFSET,
 #ifdef CONFIG_HIGHMEM
 		[ZONE_HIGHMEM] = max_pfn - max_low_pfn,
 #endif
-- 
2.19.1

