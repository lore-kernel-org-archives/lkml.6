Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E49CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 02:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3783217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 02:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbeLXCgi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 21:36:38 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:6522 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726361AbeLXCgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 21:36:38 -0500
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 18168DC5299C0;
        Mon, 24 Dec 2018 10:36:35 +0800 (CST)
Received: from DGGEMM510-MBS.china.huawei.com ([169.254.11.150]) by
 DGGEMM405-HUB.china.huawei.com ([10.3.20.213]) with mapi id 14.03.0415.000;
 Mon, 24 Dec 2018 10:36:29 +0800
From:   liangshengjun <liangshengjun@hisilicon.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Elder <paul.elder@ideasonboard.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jiangheng <jiangheng@hisilicon.com>,
        Caizhiyong <caizhiyong@hisilicon.com>
Subject: [PATCH] usb: gadget: function: sync f_uac1 ac header baInterfaceNr
Thread-Topic: [PATCH] usb: gadget: function: sync f_uac1 ac header
 baInterfaceNr
Thread-Index: AdSXkyrMjwpwaOV2RBuDWdJqlVCCfQDnjHGQ
Date:   Mon, 24 Dec 2018 02:36:28 +0000
Message-ID: <84923CA334DF85428B9ADCEC0F3CE864055B6981@dggemm510-mbs.china.huawei.com>
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

f_uac1 audio control header descriptor default set baInterfaceNr[]={1,2}, but usb gadget make a configuration descriptor with more interfaces combination, it can not confirm f_uac1 function linked first. So always keep baInterfaceNr[]={1,2} is correct, and it is necessary to sync baInterfaceNr[] with usb_interface_id() value.

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
