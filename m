Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6687C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 575AF20673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="maIpLXHl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 575AF20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730989AbeGZOcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:32:41 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:58490 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730095AbeGZOcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:32:41 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 7C7A824E05D9;
        Thu, 26 Jul 2018 06:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1532610951; bh=3a4DuIBG6xuBqte1FHM/tPTXJpH9Tsyejy/XTbQ4I2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=maIpLXHlIr/Rum28DLzeZ8aIJfxxwQ40Mt0uP73zRJnFK01Ltilc+q71zrPI3PrXn
         N89dNowqhkA3EI83uqYFpxfWgpizSbz6FAzuxTe0qZCTReqFukm2GrVgYEg3klKNR9
         DgOGmf4BAE8400IC+eyPTYKpAlR6LL9jHFaZ8i8Qy84susi8gz02ik/qLa6H1zaGPJ
         BRw5SnkUaLFpyTIZ38LrR9dfqVI/MGA923jUn0/pXMS49739MVboilVQOU0x3+0bJc
         ns4rJmXOkKtg9BuD3HI7EvjcWl38dz8LzKPSIBGzDW+Jq5w3e+Js4vvSNY2WjWmmaZ
         PkZHhccGlCvLw==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.8.86])
        by mailhost.synopsys.com (Postfix) with ESMTP id CC090594C;
        Thu, 26 Jul 2018 06:15:49 -0700 (PDT)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH v2 2/2] ARC: add SMP_CACHE_BYTES value validate
Date:   Thu, 26 Jul 2018 16:15:44 +0300
Message-Id: <20180726131544.3780-2-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180726131544.3780-1-Eugeniy.Paltsev@synopsys.com>
References: <20180726131544.3780-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check that SMP_CACHE_BYTES (and hence ARCH_DMA_MINALIGN) is larger
or equal to any cache line length by comparing it with values
previously read from ARC cache BCR registers.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
Changes v1->v2:
 * None.

 arch/arc/mm/cache.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arc/mm/cache.c b/arch/arc/mm/cache.c
index 9dbe645ee127..b95365e1253a 100644
--- a/arch/arc/mm/cache.c
+++ b/arch/arc/mm/cache.c
@@ -1246,6 +1246,16 @@ void __init arc_cache_init_master(void)
 		}
 	}
 
+	/*
+	 * Check that SMP_CACHE_BYTES (and hence ARCH_DMA_MINALIGN) is larger
+	 * or equal to any cache line length.
+	 */
+	BUILD_BUG_ON_MSG(L1_CACHE_BYTES > SMP_CACHE_BYTES,
+			 "SMP_CACHE_BYTES must be >= any cache line length");
+	if (is_isa_arcv2() && (l2_line_sz > SMP_CACHE_BYTES))
+		panic("L2 Cache line [%d] > kernel Config [%d]\n",
+		      l2_line_sz, SMP_CACHE_BYTES);
+
 	/* Note that SLC disable not formally supported till HS 3.0 */
 	if (is_isa_arcv2() && l2_line_sz && !slc_enable)
 		arc_slc_disable();
-- 
2.14.4

