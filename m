Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE4BECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8238D20779
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1gnktSX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8238D20779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbeGQQUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:20:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:53946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729702AbeGQQT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:19:59 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A90E20657;
        Tue, 17 Jul 2018 15:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531842404;
        bh=YYLR/gXfx28aeRf+O1lNeyi+ody/rq9gSQZu/Wn2pV8=;
        h=From:To:Subject:Date:From;
        b=g1gnktSXqd2OC1XD3QKE1atud9fTJ/vhSfKvTIK9ho05XnjQ5QXjHjGlPRFys3ZkI
         pN+3nk+4ttVb8VNcwA7mnD229M5Mt6CTV5bqiUX4fdI9J4Dn3OnN1iqtWyKETSPyC3
         KSCL76RckoNgLKKTsN7PHNvLZiZp1bwDFBbjEW0Q=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: samsung: Remove Exynos5440 clock handling left-overs
Date:   Tue, 17 Jul 2018 17:46:17 +0200
Message-Id: <20180717154617.29913-1-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8014220d48e7 ("thermal: samsung: Remove support for Exynos5440")
removed the Exynos5440 specific part of code for accessing TMU interrupt
registers but the surrounding clock handling was left.

Clean it up.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/thermal/samsung/exynos_tmu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index a992e51ef065..48eef552cba4 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -789,11 +789,6 @@ static void exynos_tmu_work(struct work_struct *work)
 	struct exynos_tmu_data *data = container_of(work,
 			struct exynos_tmu_data, irq_work);
 
-	if (!IS_ERR(data->clk_sec))
-		clk_enable(data->clk_sec);
-	if (!IS_ERR(data->clk_sec))
-		clk_disable(data->clk_sec);
-
 	thermal_zone_device_update(data->tzd, THERMAL_EVENT_UNSPECIFIED);
 
 	mutex_lock(&data->lock);
-- 
2.14.1

