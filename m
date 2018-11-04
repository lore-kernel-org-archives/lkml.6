Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA47ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 14:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C3B204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 14:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUFksidy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C3B204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731443AbeKDXRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:17:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:47052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731011AbeKDXIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:08:23 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2C852087A;
        Sun,  4 Nov 2018 13:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339599;
        bh=SHl783TBq4tAYy5T+nh1+3DQfbKJ4E2UVL2LGQdwyiM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SUFksidydT2PxH32xzL4uLJYVGbA+PKGt9vHCJIeDqXTph+ojMujlNukRzkwqp10V
         2sPp50wVy+4umxDUYiQ3nh05yuOzPYOcdJl+UvBz6VTRBDGpNSUGmIc0YZbEtsIOQI
         ESP2VUtvu7cPaVLG6/SwNy5kIJ/FOfvv+zxoqiLI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 38/45] staging:iio:ad7606: fix voltage scales
Date:   Sun,  4 Nov 2018 08:52:33 -0500
Message-Id: <20181104135240.88431-38-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135240.88431-1-sashal@kernel.org>
References: <20181104135240.88431-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Ardelean <alexandru.ardelean@analog.com>

[ Upstream commit 4ee033301c898dd0835d035d0e0eb768a3d35da1 ]

Fixes commit 17be2a2905a6ec9aa27cd59521495e2f490d2af0 ("staging: iio:
ad7606: replace range/range_available with corresponding scale").

The AD7606 devices don't have a 2.5V voltage range, they have 5V & 10V
voltage range, which is selectable via the `gpio_range` descriptor.

The scales also seem to have been miscomputed, because when they were
applied to the raw values, the results differ from the expected values.
After checking the ADC transfer function in the datasheet, these were
re-computed.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/iio/adc/ad7606.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
index 25b9fcd5e3a4..ce3351832fb1 100644
--- a/drivers/staging/iio/adc/ad7606.c
+++ b/drivers/staging/iio/adc/ad7606.c
@@ -26,9 +26,12 @@
 
 #include "ad7606.h"
 
-/* Scales are computed as 2.5/2**16 and 5/2**16 respectively */
+/*
+ * Scales are computed as 5000/32768 and 10000/32768 respectively,
+ * so that when applied to the raw values they provide mV values
+ */
 static const unsigned int scale_avail[2][2] = {
-	{0, 38147}, {0, 76294}
+	{0, 152588}, {0, 305176}
 };
 
 static int ad7606_reset(struct ad7606_state *st)
-- 
2.17.1

