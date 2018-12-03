Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17ADAC65BB0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 03:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED0120848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 03:46:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DED0120848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbeLCDps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 22:45:48 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:15626 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725968AbeLCDps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 22:45:48 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 564264DF14715;
        Mon,  3 Dec 2018 11:45:42 +0800 (CST)
Received: from vm100-107-113-134.huawei.com (100.107.113.134) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.408.0; Mon, 3 Dec 2018 11:45:35 +0800
From:   Yu Chen <chenyu56@huawei.com>
To:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <suzhuangluan@hisilicon.com>, <kongfei@hisilicon.com>,
        Yu Chen <chenyu56@huawei.com>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        "Binghui Wang" <wangbinghui@hisilicon.com>
Subject: [PATCH v1 11/12] usb: gadget: Add configfs attribuite for controling match_existing_only
Date:   Mon, 3 Dec 2018 11:45:14 +0800
Message-ID: <20181203034515.91412-12-chenyu56@huawei.com>
X-Mailer: git-send-email 2.15.0-rc2
In-Reply-To: <20181203034515.91412-1-chenyu56@huawei.com>
References: <20181203034515.91412-1-chenyu56@huawei.com>
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
This patch adds a configfs attribuite for controling match_existing_only
which allow user to config "match_existing_only".

Cc: Felipe Balbi <balbi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Binghui Wang <wangbinghui@hisilicon.com>
Signed-off-by: Yu Chen <chenyu56@huawei.com>
---
 drivers/usb/gadget/configfs.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index 025129942894..c82b7bc98dea 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -291,6 +291,36 @@ static ssize_t gadget_dev_desc_UDC_store(struct config_item *item,
 	return ret;
 }
 
+static ssize_t gadget_driver_match_existing_only_store(struct config_item *item,
+		const char *page, size_t len)
+{
+	struct usb_gadget_driver *gadget_driver =
+		&(to_gadget_info(item)->composite.gadget_driver);
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
+	struct usb_gadget_driver *gadget_driver =
+		&(to_gadget_info(item)->composite.gadget_driver);
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

