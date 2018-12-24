Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C095AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 02:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 918D7217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 02:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbeLXCf1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 21:35:27 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:6521 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726361AbeLXCf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 21:35:27 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 7A65CBD9F3973;
        Mon, 24 Dec 2018 10:35:22 +0800 (CST)
Received: from DGGEMM424-HUB.china.huawei.com (10.1.198.41) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 24 Dec 2018 10:35:24 +0800
Received: from DGGEMM510-MBS.china.huawei.com ([169.254.11.150]) by
 dggemm424-hub.china.huawei.com ([10.1.198.41]) with mapi id 14.03.0415.000;
 Mon, 24 Dec 2018 10:35:17 +0800
From:   liangshengjun <liangshengjun@hisilicon.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Elder <paul.elder@ideasonboard.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jiangheng <jiangheng@hisilicon.com>,
        Caizhiyong <caizhiyong@hisilicon.com>
Subject: [PATCH] usb: gadget: function: f_uac1 add interface assoc desc
Thread-Topic: [PATCH] usb: gadget: function: f_uac1 add interface assoc desc
Thread-Index: AdSXihVFnR/WgnXsQhWO9abAmF+4CADpmHag
Date:   Mon, 24 Dec 2018 02:35:16 +0000
Message-ID: <84923CA334DF85428B9ADCEC0F3CE864055B6976@dggemm510-mbs.china.huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.223.71]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add f_uac1 interface association descriptor, make f_uac1 link other function(like f_uvc) is possible.

Signed-off-by: Liang Shengjun <liangshengjun@hisilicon.com>
---
 drivers/usb/gadget/function/f_uac1.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/usb/gadget/function/f_uac1.c b/drivers/usb/gadget/function/f_uac1.c
index 2746a92..28c1a78 100644
--- a/drivers/usb/gadget/function/f_uac1.c
+++ b/drivers/usb/gadget/function/f_uac1.c
@@ -48,6 +48,16 @@ static inline struct f_uac1 *func_to_uac1(struct usb_function *f)
 /* Number of streaming interfaces */
 #define F_AUDIO_NUM_INTERFACES		2
 
+static struct usb_interface_assoc_descriptor uac_iad = {
+	.bLength = sizeof(uac_iad),
+	.bDescriptorType = USB_DT_INTERFACE_ASSOCIATION,
+	.bFirstInterface = 0,
+	.bInterfaceCount = 3,
+	.bFunctionClass = USB_CLASS_AUDIO,
+	.bFunctionSubClass = 0,
+	.bFunctionProtocol = UAC_VERSION_1,
+};
+
 /* B.3.1  Standard AC Interface Descriptor */  static struct usb_interface_descriptor ac_interface_desc = {
 	.bLength =		USB_DT_INTERFACE_SIZE,
@@ -247,6 +257,7 @@ static struct uac_iso_endpoint_descriptor as_iso_in_desc = {  };
 
 static struct usb_descriptor_header *f_audio_desc[] = {
+	(struct usb_descriptor_header *)&uac_iad,
 	(struct usb_descriptor_header *)&ac_interface_desc,
 	(struct usb_descriptor_header *)&ac_header_desc,
 
@@ -523,6 +534,7 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 	us = usb_gstrings_attach(cdev, uac1_strings, ARRAY_SIZE(strings_uac1));
 	if (IS_ERR(us))
 		return PTR_ERR(us);
+	uac_iad.iFunction = us[STR_AC_IF].id;
 	ac_interface_desc.iInterface = us[STR_AC_IF].id;
 	usb_out_it_desc.iTerminal = us[STR_USB_OUT_IT].id;
 	usb_out_it_desc.iChannelNames = us[STR_USB_OUT_IT_CH_NAMES].id; @@ -559,6 +571,7 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 	status = usb_interface_id(c, f);
 	if (status < 0)
 		goto fail;
+	uac_iad.bFirstInterface = status;
 	ac_interface_desc.bInterfaceNumber = status;
 	uac1->ac_intf = status;
 	uac1->ac_alt = 0;
--
2.7.4
