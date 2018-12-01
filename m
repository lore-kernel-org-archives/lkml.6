Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913FFC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 08:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A2C320834
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 08:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A2C320834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbeLATnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 14:43:24 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15622 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726124AbeLATnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 14:43:24 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 429468E462846;
        Sat,  1 Dec 2018 16:31:21 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.408.0; Sat, 1 Dec 2018 16:31:14 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] coresight: stm: remove set but not used variable 'res_size'
Date:   Sat, 1 Dec 2018 08:39:45 +0000
Message-ID: <1543653585-108277-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/hwtracing/coresight/coresight-stm.c: In function 'stm_probe':
drivers/hwtracing/coresight/coresight-stm.c:796:9: warning:
 variable 'res_size' set but not used [-Wunused-but-set-variable]

It never used since introduction in commit
237483aa5cf4 ("coresight: stm: adding driver for CoreSight STM component")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/hwtracing/coresight/coresight-stm.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index ef339ff..f07825d 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -793,7 +793,7 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 	struct stm_drvdata *drvdata;
 	struct resource *res = &adev->res;
 	struct resource ch_res;
-	size_t res_size, bitmap_size;
+	size_t bitmap_size;
 	struct coresight_desc desc = { 0 };
 	struct device_node *np = adev->dev.of_node;
 
@@ -833,15 +833,11 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 
 	drvdata->write_bytes = stm_fundamental_data_size(drvdata);
 
-	if (boot_nr_channel) {
+	if (boot_nr_channel)
 		drvdata->numsp = boot_nr_channel;
-		res_size = min((resource_size_t)(boot_nr_channel *
-				  BYTES_PER_CHANNEL), resource_size(res));
-	} else {
+	else
 		drvdata->numsp = stm_num_stimulus_port(drvdata);
-		res_size = min((resource_size_t)(drvdata->numsp *
-				 BYTES_PER_CHANNEL), resource_size(res));
-	}
+
 	bitmap_size = BITS_TO_LONGS(drvdata->numsp) * sizeof(long);
 
 	guaranteed = devm_kzalloc(dev, bitmap_size, GFP_KERNEL);



