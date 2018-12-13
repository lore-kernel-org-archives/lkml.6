Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FE3C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 496622086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ktAY/uMD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496622086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbeLMQ4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 11:56:50 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:39874 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbeLMQ4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 11:56:49 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 58FB524E2434;
        Thu, 13 Dec 2018 08:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544720209; bh=J8GQPU5nXQ0BMDJt7JPPSLsm7zQ7XUo/eyaDmHXUdnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ktAY/uMDaeO/RG/vpcFs3LZJk2RPagGIr5plHp4+Qaa2p6oZvXSUB/YVbF9jNiVRB
         bXsJ/VlggjJr/wgAvLGSZxIqRpoXR03wpLUgWFuSaAl7qVS6QwCAu5r1KYseak0Hah
         TvEKZSJi5nmogq2t6ITlyvHOXsFSxHSRhM7qR+I4Lda6jKJ38hW7BizpzaZpE+dhMk
         wTqiiGET54h+yVdpHwC9BFI8dsfeLUYupFD5SKCU9Q5xgZl7u9QXWVfrPzB6hrb/ZG
         4gQqfkqGY8T6VQ6tCoyp0DC2unooG2A7oEw5n6s+h9iexY1U2QEzVpKqanKJlbnDl2
         GFMLcf0qfAUCw==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.66])
        by mailhost.synopsys.com (Postfix) with ESMTP id 7EC8730CF;
        Thu, 13 Dec 2018 08:56:45 -0800 (PST)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH v2 4/4] ARC: perf: avoid kernel killing where it is possible
Date:   Thu, 13 Dec 2018 19:56:21 +0300
Message-Id: <20181213165621.20817-5-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181213165621.20817-1-Eugeniy.Paltsev@synopsys.com>
References: <20181213165621.20817-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No, not gonna die tonight.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/kernel/perf_event.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arc/kernel/perf_event.c b/arch/arc/kernel/perf_event.c
index 0c4714906a06..b0f7eeffde9f 100644
--- a/arch/arc/kernel/perf_event.c
+++ b/arch/arc/kernel/perf_event.c
@@ -567,10 +567,12 @@ static int arc_pmu_device_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 	BUILD_BUG_ON(ARC_PERF_MAX_COUNTERS > 32);
-	BUG_ON(pct_bcr.c > ARC_PERF_MAX_COUNTERS);
+	if (WARN_ON(pct_bcr.c > ARC_PERF_MAX_COUNTERS))
+		return -EINVAL;
 
 	READ_BCR(ARC_REG_CC_BUILD, cc_bcr);
-	BUG_ON(!cc_bcr.v); /* Counters exist but No countable conditions ? */
+	if (WARN(!cc_bcr.v, "Counters exist but No countable conditions?"))
+		return -EINVAL;
 
 	arc_pmu = devm_kzalloc(&pdev->dev, sizeof(struct arc_pmu), GFP_KERNEL);
 	if (!arc_pmu)
-- 
2.14.5

