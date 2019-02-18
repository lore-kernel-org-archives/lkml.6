Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF072C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8EBF217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730683AbfBRLXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 06:23:39 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:46886 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730639AbfBRLXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 06:23:36 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0AB6B435B2A7334A550D;
        Mon, 18 Feb 2019 19:23:32 +0800 (CST)
Received: from vm100-107-113-134.huawei.com (100.107.113.134) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.408.0; Mon, 18 Feb 2019 19:23:24 +0800
From:   Yu Chen <chenyu56@huawei.com>
To:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <john.stultz@linaro.org>, <suzhuangluan@hisilicon.com>,
        <kongfei@hisilicon.com>, <liuyu712@hisilicon.com>,
        <wanghu17@hisilicon.com>, <butao@hisilicon.com>,
        <chenyao11@huawei.com>, <fangshengzhou@hisilicon.com>,
        <lipengcheng8@huawei.com>, <songxiaowei@hisilicon.com>,
        <xuyiping@hisilicon.com>, <xuyoujun4@huawei.com>,
        <yudongbin@hisilicon.com>, <zangleigang@hisilicon.com>,
        Yu Chen <chenyu56@huawei.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Binghui Wang <wangbinghui@hisilicon.com>
Subject: [PATCH v2 09/10] usb: gadget: Add configfs attribuite for controling match_existing_only
Date:   Mon, 18 Feb 2019 19:23:09 +0800
Message-ID: <20190218112310.17860-10-chenyu56@huawei.com>
X-Mailer: git-send-email 2.15.0-rc2
In-Reply-To: <20190218112310.17860-1-chenyu56@huawei.com>
References: <20190218112310.17860-1-chenyu56@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.107.113.134]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the "match_existing_only" of usb_gadget_driver in configfs is
set to one which is not flexible.
Dwc3 udc will be removed when usb core switch to host mode. This causes
failure of writing name of dwc3 udc to configfs's UDC attribuite.
To fix this we need to add a way to change the config of
"match_existing_only".
There are systems like Android do not support udev, so adding
"match_existing_only" attribute to allow configuration by user is cost little.
This patch adds a configfs attribuite for controling match_existing_only
which allow user to config "match_existing_only".

Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Binghui Wang <wangbinghui@hisilicon.com>
Signed-off-by: Yu Chen <chenyu56@huawei.com>
---
 drivers/usb/gadget/configfs.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index 025129942894..be85104bfab9 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -291,6 +291,36 @@ static ssize_t gadget_dev_desc_UDC_store(struct config_item *item,
 	return ret;
 }
 
+static ssize_t gadget_driver_match_existing_only_store(struct config_item *item,
+		const char *page, size_t len)
+{
+	struct gadget_info *gi = to_gadget_info(item);
+	struct usb_gadget_driver *gadget_driver = &(gi->composite.gadget_driver);
+	bool match_existing_only;
+	int ret;
+
+	ret = kstrtobool(page, &match_existing_only);
+	if (ret)
+		return ret;
+
+	if (match_existing_only)
+		gadget_driver->match_existing_only = 1;
+	else
+		gadget_driver->match_existing_only = 0;
+
+	return len;
+}
+
+static ssize_t gadget_driver_match_existing_only_show(struct config_item *item,
+		char *page)
+{
+	struct gadget_info *gi = to_gadget_info(item);
+	struct usb_gadget_driver *gadget_driver = &(gi->composite.gadget_driver);
+	bool match_existing_only = !!gadget_driver->match_existing_only;
+
+	return sprintf(page, "%s\n", match_existing_only ? "true" : "false");
+}
+
 CONFIGFS_ATTR(gadget_dev_desc_, bDeviceClass);
 CONFIGFS_ATTR(gadget_dev_desc_, bDeviceSubClass);
 CONFIGFS_ATTR(gadget_dev_desc_, bDeviceProtocol);
@@ -300,6 +330,7 @@ CONFIGFS_ATTR(gadget_dev_desc_, idProduct);
 CONFIGFS_ATTR(gadget_dev_desc_, bcdDevice);
 CONFIGFS_ATTR(gadget_dev_desc_, bcdUSB);
 CONFIGFS_ATTR(gadget_dev_desc_, UDC);
+CONFIGFS_ATTR(gadget_, driver_match_existing_only);
 
 static struct configfs_attribute *gadget_root_attrs[] = {
 	&gadget_dev_desc_attr_bDeviceClass,
@@ -311,6 +342,7 @@ static struct configfs_attribute *gadget_root_attrs[] = {
 	&gadget_dev_desc_attr_bcdDevice,
 	&gadget_dev_desc_attr_bcdUSB,
 	&gadget_dev_desc_attr_UDC,
+	&gadget_attr_driver_match_existing_only,
 	NULL,
 };
 
-- 
2.15.0-rc2

