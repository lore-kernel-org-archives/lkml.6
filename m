Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B904C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08AA120836
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550197683;
	bh=jazbL9HzBQN2ER2NfRImixrA5ZxZexCBSCoqjzPgH/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sptCGuH4vj63Q8o9SZaDbbt/lS3MKavDL/rnYTauZBzrp61ZPA8+xpwqtCYvAzeH4
	 +GaO1krFndFiLFyI2x/EkwoN0AWnu9Hr4pTClwW9eo4UN8kxFCqon+sya82S0opd4P
	 n+XGIcN86cy3lsNWi316cvbyvhooCE8/a4gS9awc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387893AbfBOC2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:28:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:53390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404701AbfBOCN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:13:28 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B52821B1C;
        Fri, 15 Feb 2019 02:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196808;
        bh=jazbL9HzBQN2ER2NfRImixrA5ZxZexCBSCoqjzPgH/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fl4B5QbxvTrapnLmdbUO13q1RfB/JiQ2ttMIms07J1Wm15FGG75kD5eyIL9JaxURQ
         GKag2nxjWC9wHkzXKpvnQKGoxgSC0mRK9jj4KupcGCDpl3fa/tWPm2J0cH2YqOd7Bq
         XAqCzW74OsbCei4DZO9AVni/0cMq7BiMZn0lLVnA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zeng Tao <prime.zeng@hisilicon.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 08/40] usb: dwc3: gadget: Fix the uninitialized link_state when udc starts
Date:   Thu, 14 Feb 2019 21:12:41 -0500
Message-Id: <20190215021313.178476-8-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021313.178476-1-sashal@kernel.org>
References: <20190215021313.178476-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zeng Tao <prime.zeng@hisilicon.com>

[ Upstream commit 88b1bb1f3b88e0bf20b05d543a53a5b99bd7ceb6 ]

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
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/gadget.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index e50f7ca9ca6e..0b378be60a2c 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1906,6 +1906,7 @@ static int __dwc3_gadget_start(struct dwc3 *dwc)
 
 	/* begin to receive SETUP packets */
 	dwc->ep0state = EP0_SETUP_PHASE;
+	dwc->link_state = DWC3_LINK_STATE_SS_DIS;
 	dwc3_ep0_out_start(dwc);
 
 	dwc3_gadget_enable_irq(dwc);
-- 
2.19.1

