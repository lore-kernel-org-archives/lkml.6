Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02908C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 21:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93952086B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 21:36:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B93952086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbeHXBHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 21:07:47 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50817 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728108AbeHXBHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 21:07:45 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9B267207B3; Thu, 23 Aug 2018 23:36:07 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 77BE6204AE;
        Thu, 23 Aug 2018 23:36:07 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Roy Pledge <roy.pledge@nxp.com>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/2] soc: fsl: qbman: qman: avoid allocating from non existing gen_pool
Date:   Thu, 23 Aug 2018 23:36:00 +0200
Message-Id: <20180823213600.23426-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823213600.23426-1-alexandre.belloni@bootlin.com>
References: <20180823213600.23426-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the qman driver didn't probe, calling qman_alloc_fqid_range,
qman_alloc_pool_range or qman_alloc_cgrid_range (as done in dpaa_eth) will
pass a NULL pointer to gen_pool_alloc, leading to a NULL pointer
dereference.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/soc/fsl/qbman/qman.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index ecb22749df0b..8cc015183043 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -2729,6 +2729,9 @@ static int qman_alloc_range(struct gen_pool *p, u32 *result, u32 cnt)
 {
 	unsigned long addr;
 
+	if (!p)
+		return -ENODEV;
+
 	addr = gen_pool_alloc(p, cnt);
 	if (!addr)
 		return -ENOMEM;
-- 
2.18.0

