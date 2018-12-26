Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7F5C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 03:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E2421720
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 03:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbeLZDTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 22:19:13 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:16661 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725957AbeLZDTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 22:19:13 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 214172B66B523;
        Wed, 26 Dec 2018 11:19:08 +0800 (CST)
Received: from dessert.huawei.com (10.69.192.158) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.408.0; Wed, 26 Dec 2018 11:18:59 +0800
From:   Zeng Tao <prime.zeng@hisilicon.com>
To:     <felipe.balbi@linux.intel.com>
CC:     Zeng Tao <prime.zeng@hisilicon.com>,
        Felipe Balbi <balbi@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] usb: dwc3: gadget: Fix the uninitialized link_state when udc starts
Date:   Wed, 26 Dec 2018 19:22:00 +0800
Message-ID: <1545823320-21881-1-git-send-email-prime.zeng@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the link_state is uninitialized and the default value is 0(U0)
before the first time we start the udc, and after we start the udc then
 stop the udc, the link_state will be undefined.
We may have the following warnings if we start the udc again with
an undefined link_state:

WARNING: CPU: 0 PID: 327 at drivers/usb/dwc3/gadget.c:294 dwc3_send_gadget_ep_cmd+0x304/0x308
dwc3 100e0000.hidwc3_0: wakeup failed --> -22
[...]
Call Trace:
[<c010f270>] (unwind_backtrace) from [<c010b3d8>] (show_stack+0x10/0x14)
[<c010b3d8>] (show_stack) from [<c034a4dc>] (dump_stack+0x84/0x98)
[<c034a4dc>] (dump_stack) from [<c0118000>] (__warn+0xe8/0x100)
[<c0118000>] (__warn) from [<c0118050>](warn_slowpath_fmt+0x38/0x48)
[<c0118050>] (warn_slowpath_fmt) from [<c0442ec0>](dwc3_send_gadget_ep_cmd+0x304/0x308)
[<c0442ec0>] (dwc3_send_gadget_ep_cmd) from [<c0445e68>](dwc3_ep0_start_trans+0x48/0xf4)
[<c0445e68>] (dwc3_ep0_start_trans) from [<c0446750>](dwc3_ep0_out_start+0x64/0x80)
[<c0446750>] (dwc3_ep0_out_start) from [<c04451c0>](__dwc3_gadget_start+0x1e0/0x278)
[<c04451c0>] (__dwc3_gadget_start) from [<c04452e0>](dwc3_gadget_start+0x88/0x10c)
[<c04452e0>] (dwc3_gadget_start) from [<c045ee54>](udc_bind_to_driver+0x88/0xbc)
[<c045ee54>] (udc_bind_to_driver) from [<c045f29c>](usb_gadget_probe_driver+0xf8/0x140)
[<c045f29c>] (usb_gadget_probe_driver) from [<bf005424>](gadget_dev_desc_UDC_store+0xac/0xc4 [libcomposite])
[<bf005424>] (gadget_dev_desc_UDC_store [libcomposite]) from[<c023d8e0>] (configfs_write_file+0xd4/0x160)
[<c023d8e0>] (configfs_write_file) from [<c01d51e8>] (__vfs_write+0x1c/0x114)
[<c01d51e8>] (__vfs_write) from [<c01d5ff4>] (vfs_write+0xa4/0x168)
[<c01d5ff4>] (vfs_write) from [<c01d6d40>] (SyS_write+0x3c/0x90)
[<c01d6d40>] (SyS_write) from [<c0107400>] (ret_fast_syscall+0x0/0x3c)

Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
---
 drivers/usb/dwc3/gadget.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 16a6e3c..e18c2a2 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1988,6 +1988,7 @@ static int __dwc3_gadget_start(struct dwc3 *dwc)
 
 	/* begin to receive SETUP packets */
 	dwc->ep0state = EP0_SETUP_PHASE;
+	dwc->link_state = DWC3_LINK_STATE_SS_DIS;
 	dwc3_ep0_out_start(dwc);
 
 	dwc3_gadget_enable_irq(dwc);
-- 
2.7.4

