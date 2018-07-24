Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DACC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E6AC20875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="MElidWRs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E6AC20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388530AbeGXLQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 07:16:28 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:42396 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388251AbeGXLQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 07:16:27 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 4697724E0749;
        Tue, 24 Jul 2018 03:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1532427044; bh=USTCJUDFbwY5/curXeDwo9o/IGl4dzncWcHCc0L2ltc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MElidWRs1vYMD8fsuffmo+cAMKnQkaojcZCwPHYh0Hofq9P/8eGdM6o2e1809QuoT
         ibLBCI7Kj4DGXKcmAmyIj57jwqCdpwGpCNHDQnXQYIISuAm4cTY4oYQnp6f/7YtzzV
         /tsQPeYvtqeqQgnESuFZe7r2BozSF4nqEqQ0oTX6dryVHq6n2PPxk5FAv/4pv0dQiS
         M9Q//n8TKlsCVxQThGRAlVL/I7gNYtnV+/gbnl97GuMVbz3XegIGa2pnBZpfTVKcF+
         96v9UM4TI83bpDTeT8rlR47+P2nLbs4GRoMjO/tJEDJRVw/OcERbV+W2G+e56GNAT/
         Hwbln7YAZqWxw==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.86])
        by mailhost.synopsys.com (Postfix) with ESMTP id 70D36339F;
        Tue, 24 Jul 2018 03:10:42 -0700 (PDT)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>, hch@lst.de,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 4/4] ARC: IOC: panic if both IOC and ZONE_HIGHMEM enabled
Date:   Tue, 24 Jul 2018 13:10:01 +0300
Message-Id: <20180724101001.31965-5-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180724101001.31965-1-Eugeniy.Paltsev@synopsys.com>
References: <20180724101001.31965-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/mm/cache.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arc/mm/cache.c b/arch/arc/mm/cache.c
index 34935ce38631..e0b3484641c3 100644
--- a/arch/arc/mm/cache.c
+++ b/arch/arc/mm/cache.c
@@ -1143,6 +1143,19 @@ noinline void __init arc_ioc_setup(void)
 {
 	unsigned int ioc_base, mem_sz;
 
+	/*
+	 * As for today we don't support both IOC and ZONE_HIGHMEM enabled
+	 * simultaneously. This happens because as of today IOC aperture covers
+	 * only ZONE_NORMAL (low mem) and any dma transactions outside this
+	 * region won't be HW coherent.
+	 * If we want to use both IOC and ZONE_HIGHMEM we can use
+	 * bounce_buffer to handle dma transactions to HIGHMEM.
+	 * Also it is possible to modify dma_direct cache ops or increase IOC
+	 * aperture size if we are planning to use HIGHMEM without PAE.
+	 */
+	if (IS_ENABLED(CONFIG_HIGHMEM))
+		panic("IOC and HIGHMEM can't be used simultaneously");
+
 	/* Flush + invalidate + disable L1 dcache */
 	__dc_disable();
 
-- 
2.14.4

