Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F36C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 03:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77F920811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 03:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B77F920811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbeLMDUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 22:20:05 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:52217 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726470AbeLMDUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 22:20:05 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D61B664683C03;
        Thu, 13 Dec 2018 11:20:00 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Thu, 13 Dec 2018
 11:19:52 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>, <yoshihiro.shimoda.uh@renesas.com>,
        <felipe.balbi@linux.intel.com>, <horms+renesas@verge.net.au>,
        <fengguang.wu@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] usb: renesas_usbhs: Fix unused function warning when CONFIG_PM not set
Date:   Thu, 13 Dec 2018 11:19:24 +0800
Message-ID: <20181213031924.12216-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

with CONFIG_PM not set, gcc warning this:
drivers/usb/renesas_usbhs/common.c:844:12:
 warning: 'usbhsc_suspend' defined but not used [-Wunused-function]
drivers/usb/renesas_usbhs/common.c:860:12:
 warning: 'usbhsc_resume' defined but not used [-Wunused-function]

fix this by adding #ifdef around it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/usb/renesas_usbhs/common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index 02c1d2b..9390c76 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -841,6 +841,7 @@ static int usbhs_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
 static int usbhsc_suspend(struct device *dev)
 {
 	struct usbhs_priv *priv = dev_get_drvdata(dev);
@@ -873,6 +874,7 @@ static int usbhsc_resume(struct device *dev)
 
 	return 0;
 }
+#endif
 
 static SIMPLE_DEV_PM_OPS(usbhsc_pm_ops, usbhsc_suspend, usbhsc_resume);
 
-- 
2.7.4


