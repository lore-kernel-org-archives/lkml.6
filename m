Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096A7C282C3
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 01:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0517218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 01:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbfAYBk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 20:40:26 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2229 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727983AbfAYBkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 20:40:25 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 21509A5A1FB833E93DD5;
        Fri, 25 Jan 2019 09:40:23 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Fri, 25 Jan 2019 09:40:16 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] extcon: ptn5150: Fix return value check in ptn5150_i2c_probe()
Date:   Fri, 25 Jan 2019 01:45:54 +0000
Message-ID: <1548380754-67031-1-git-send-email-weiyongjun1@huawei.com>
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

In case of error, the function devm_gpiod_get() returns ERR_PTR() and
never returns NULL. The NULL test in the return value check should be
replaced with IS_ERR().

Fixes: 58963276749e ("extcon: Add support for ptn5150 extcon driver")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/extcon/extcon-ptn5150.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
index 155620b..8217fdc 100644
--- a/drivers/extcon/extcon-ptn5150.c
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -240,14 +240,14 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c,
 	info->dev = &i2c->dev;
 	info->i2c = i2c;
 	info->int_gpiod = devm_gpiod_get(&i2c->dev, "int", GPIOD_IN);
-	if (!info->int_gpiod) {
+	if (IS_ERR(info->int_gpiod)) {
 		dev_err(dev, "failed to get INT GPIO\n");
-		return -EINVAL;
+		return PTR_ERR(info->int_gpiod);
 	}
 	info->vbus_gpiod = devm_gpiod_get(&i2c->dev, "vbus", GPIOD_IN);
-	if (!info->vbus_gpiod) {
+	if (IS_ERR(info->vbus_gpiod)) {
 		dev_err(dev, "failed to get VBUS GPIO\n");
-		return -EINVAL;
+		return PTR_ERR(info->vbus_gpiod);
 	}
 	ret = gpiod_direction_output(info->vbus_gpiod, 0);
 	if (ret) {



