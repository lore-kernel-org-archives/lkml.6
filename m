Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BE3C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A08D2184A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbeLSMIg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 07:08:36 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:6919 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728559AbeLSMIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 07:08:35 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 5A8909C4F5CA4;
        Wed, 19 Dec 2018 20:08:32 +0800 (CST)
Received: from DGGEMM422-HUB.china.huawei.com (10.1.198.39) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 19 Dec 2018 20:08:33 +0800
Received: from DGGEMM510-MBS.china.huawei.com ([169.254.11.150]) by
 dggemm422-hub.china.huawei.com ([10.1.198.39]) with mapi id 14.03.0415.000;
 Wed, 19 Dec 2018 20:08:32 +0800
From:   liangshengjun <liangshengjun@hisilicon.com>
To:     "balbi@kernel.org" <balbi@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] usb: gadget: function: sync f_uac1 ac header baInterfaceNr
Thread-Topic: [PATCH] usb: gadget: function: sync f_uac1 ac header
 baInterfaceNr
Thread-Index: AdSXkyrMjwpwaOV2RBuDWdJqlVCCfQ==
Date:   Wed, 19 Dec 2018 12:08:32 +0000
Message-ID: <84923CA334DF85428B9ADCEC0F3CE864055B49CC@dggemm510-mbs.china.huawei.com>
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

f_uac1 audio control header descriptor default set baInterfaceNr[]={1,2},
but usb gadget make a configuration descriptor with more interfaces combination,
it can not confirm f_uac1 function linked first. So always keep baInterfaceNr[]={1,2}
is correct, and it is necessary to sync baInterfaceNr[] with usb_interface_id() value.

Signed-off-by: Liang Shengjun <liangshengjun@hisilicon.com>
---
 drivers/usb/gadget/function/f_uac1.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/function/f_uac1.c b/drivers/usb/gadget/function/f_uac1.c
index 28c1a78..d9aeb5c 100644
--- a/drivers/usb/gadget/function/f_uac1.c
+++ b/drivers/usb/gadget/function/f_uac1.c
@@ -581,6 +581,7 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 		goto fail;
 	as_out_interface_alt_0_desc.bInterfaceNumber = status;
 	as_out_interface_alt_1_desc.bInterfaceNumber = status;
+	ac_header_desc.baInterfaceNr[0] = status;
 	uac1->as_out_intf = status;
 	uac1->as_out_alt = 0;
 
@@ -589,6 +590,7 @@ static int f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 		goto fail;
 	as_in_interface_alt_0_desc.bInterfaceNumber = status;
 	as_in_interface_alt_1_desc.bInterfaceNumber = status;
+	ac_header_desc.baInterfaceNr[1] = status;
 	uac1->as_in_intf = status;
 	uac1->as_in_alt = 0;
 
-- 
2.7.4
