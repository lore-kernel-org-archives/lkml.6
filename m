Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7A5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B66222CF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405857AbfBNGlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 01:41:04 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:59556 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393070AbfBNGlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 01:41:03 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 90A287E7E3DEB4AD273B;
        Thu, 14 Feb 2019 14:41:01 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x1E6ewDe050826;
        Thu, 14 Feb 2019 14:40:58 +0800 (GMT-8)
        (envelope-from huang.zijiang@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019021414412885-26035930 ;
          Thu, 14 Feb 2019 14:41:28 +0800 
From:   Huang Zijiang <huang.zijiang@zte.com.cn>
To:     yisen.zhuang@huawei.com
Cc:     salil.mehta@huawei.com, davem@davemloft.net, lipeng321@huawei.com,
        liuyonglong@huawei.com, yuehaibing@huawei.com,
        keescook@chromium.org, wangxi11@huawei.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn,
        Huang Zijiang <huang.zijiang@zte.com.cn>
Subject: [PATCH] net: hns: Fix object reference leaks in hns_dsaf_roce_reset()
Date:   Thu, 14 Feb 2019 14:41:45 +0800
Message-Id: <1550126505-28394-1-git-send-email-huang.zijiang@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-02-14 14:41:28,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-02-14 14:40:47,
        Serialize complete at 2019-02-14 14:40:47
X-MAIL: mse01.zte.com.cn x1E6ewDe050826
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_find_device_by_node() takes a reference to the underlying device
structure, we should release that reference.

Signed-off-by: Huang Zijiang <huang.zijiang@zte.com.cn>
---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
index 14d7ec7..697d929 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
@@ -3081,6 +3081,7 @@ int hns_dsaf_roce_reset(struct fwnode_handle *dsaf_fwnode, bool dereset)
 	dsaf_dev = dev_get_drvdata(&pdev->dev);
 	if (!dsaf_dev) {
 		dev_err(&pdev->dev, "dsaf_dev is NULL\n");
+		put_device(&pdev->dev);
 		return -ENODEV;
 	}
 
@@ -3088,6 +3089,7 @@ int hns_dsaf_roce_reset(struct fwnode_handle *dsaf_fwnode, bool dereset)
 	if (AE_IS_VER1(dsaf_dev->dsaf_ver)) {
 		dev_err(dsaf_dev->dev, "%s v1 chip doesn't support RoCE!\n",
 			dsaf_dev->ae_dev.name);
+		put_device(&pdev->dev);
 		return -ENODEV;
 	}
 
-- 
1.8.3.1

