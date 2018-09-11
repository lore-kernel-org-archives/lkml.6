Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD44C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E062086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:16:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E062086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbeIKRPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 13:15:02 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12095 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726647AbeIKRPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 13:15:01 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C51A74AE5E6A1;
        Tue, 11 Sep 2018 20:15:54 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.399.0; Tue, 11 Sep 2018 20:15:51 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <kronos.it@gmail.com>, <jdelvare@suse.com>, <linux@roeck-us.net>
CC:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] hwmon: Use PTR_ERR_OR_ZERO instead of reimplementing its function
Date:   Tue, 11 Sep 2018 20:03:37 +0800
Message-ID: <1536667417-11718-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PTR_ERR_OR_ZERO has implemented the same function. We prefer to use
inlined function rather than code-opened implementation.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/hwmon/asus_atk0110.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hwmon/asus_atk0110.c b/drivers/hwmon/asus_atk0110.c
index a6636fe..a7cf008 100644
--- a/drivers/hwmon/asus_atk0110.c
+++ b/drivers/hwmon/asus_atk0110.c
@@ -1210,10 +1210,8 @@ static int atk_register_hwmon(struct atk_data *data)
 	data->hwmon_dev = hwmon_device_register_with_groups(dev, "atk0110",
 							    data,
 							    data->attr_groups);
-	if (IS_ERR(data->hwmon_dev))
-		return PTR_ERR(data->hwmon_dev);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(data->hwmon_dev);
 }
 
 static int atk_probe_if(struct atk_data *data)
-- 
1.7.12.4

