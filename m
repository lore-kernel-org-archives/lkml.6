Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BF2ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE5D2080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zMiSMLKw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAE5D2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730239AbeKAIJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:09:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730224AbeKAIJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:09:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 707D320838;
        Wed, 31 Oct 2018 23:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027335;
        bh=JKFmH31bxgPkkqF/y4/m8+qfsR82WjSwsdh96+RdVzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zMiSMLKwxxZLSq3sVAnBTkdfOtAvXrjwrKuPtcCH6FhQei4s9W4abDM29FMwpryzl
         yiIohn0MH/FOPA6It653r0IYSNhcu+lnllm3g2rKrME9IN9/1GJ6hxFTIkgRCKBT5u
         BXHAcjBlGtEzJAWTj21DBaJGU5BKKxjjPJsBnWd0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Siva Rebbagondla <siva.rebbagondla@redpinesignals.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 065/126] rsi: fix memory alignment issue in ARM32 platforms
Date:   Wed, 31 Oct 2018 19:06:53 -0400
Message-Id: <20181031230754.29029-65-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Siva Rebbagondla <siva.rebbagondla@redpinesignals.com>

[ Upstream commit baa8caf4ab7af2d9e84b566b99fe919a4e9e7562 ]

During testing in ARM32 platforms, observed below kernel panic, as driver
accessing data beyond the allocated memory while submitting URB to USB.

Fix: Resolved this by specifying correct length by considering 64 bit
alignment. so that, USB bus driver will access only allocated memory.

Unit-test: Tested and confirm that driver bring up and scanning,
connection and data transfer works fine with this fix.

...skipping...
[   25.389450] Unable to handle kernel paging request at virtual
	       address 5aa11422
[   25.403078] Internal error: Oops: 5 [#1] SMP ARM
[   25.407703] Modules linked in: rsi_usb
[   25.411473] CPU: 1 PID: 317 Comm: RX-Thread Not tainted 4.18.0-rc7 #1
[   25.419221] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[   25.425764] PC is at skb_release_data+0x90/0x168
[   25.430393] LR is at skb_release_all+0x28/0x2c
[   25.434842] pc : [<807435b0>] lr : [<80742ba0>] psr: 200e0013 5aa1141e
[   25.464633] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32 ISA ARM Segment none
[   25.477524] Process RX-Thread (pid: 317, stack limit = 0x(ptrval))
[   25.483709] Stack: (0xedf69ed8 to 0xedf6a000)
[   25.569907] Backtrace:
[   25.572368] [<80743520>] (skb_release_data) from [<80742ba0>]
	       (skb_release_all+0x28/0x2c)
[   25.580555] r9:7f00258c r8:00000001 r7:ee355000 r6:eddab0d0
	       r5:eddab000 r4:eddbb840
[   25.588308] [<80742b78>] (skb_release_all) from [<807432cc>]
	       (consume_skb+0x30/0x50)
[   25.596055] r5:eddab000 r4:eddbb840
[   25.599648] [<8074329c>] (consume_skb) from [<7f00117c>]
	       (rsi_usb_rx_thread+0x64/0x12c [rsi_usb])
[   25.608524] r5:eddab000 r4:eddbb840
[   25.612116] [<7f001118>] (rsi_usb_rx_thread [rsi_usb]) from
	       [<80142750>] (kthread+0x11c/0x15c)
[   25.620735] r10:ee9ff9e0 r9:edcde3b8 r8:ee355000 r7:edf68000
	       r6:edd3a780 r5:00000000
[   25.628567] r4:edcde380
[   25.631110] [<80142634>] (kthread) from [<801010e8>]
	       (ret_from_fork+0x14/0x2c)
[   25.638336] Exception stack(0xedf69fb0 to 0xedf69ff8)
[   25.682929] ---[ end trace 8236a5496f5b5d3b ]---

Signed-off-by: Siva Rebbagondla <siva.rebbagondla@redpinesignals.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/rsi/rsi_91x_usb.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_usb.c b/drivers/net/wireless/rsi/rsi_91x_usb.c
index 6ce6b754df12..45a1b86491b6 100644
--- a/drivers/net/wireless/rsi/rsi_91x_usb.c
+++ b/drivers/net/wireless/rsi/rsi_91x_usb.c
@@ -266,15 +266,17 @@ static void rsi_rx_done_handler(struct urb *urb)
 	if (urb->status)
 		goto out;
 
-	if (urb->actual_length <= 0) {
-		rsi_dbg(INFO_ZONE, "%s: Zero length packet\n", __func__);
+	if (urb->actual_length <= 0 ||
+	    urb->actual_length > rx_cb->rx_skb->len) {
+		rsi_dbg(INFO_ZONE, "%s: Invalid packet length = %d\n",
+			__func__, urb->actual_length);
 		goto out;
 	}
 	if (skb_queue_len(&dev->rx_q) >= RSI_MAX_RX_PKTS) {
 		rsi_dbg(INFO_ZONE, "Max RX packets reached\n");
 		goto out;
 	}
-	skb_put(rx_cb->rx_skb, urb->actual_length);
+	skb_trim(rx_cb->rx_skb, urb->actual_length);
 	skb_queue_tail(&dev->rx_q, rx_cb->rx_skb);
 
 	rsi_set_event(&dev->rx_thread.event);
@@ -308,6 +310,7 @@ static int rsi_rx_urb_submit(struct rsi_hw *adapter, u8 ep_num)
 	if (!skb)
 		return -ENOMEM;
 	skb_reserve(skb, MAX_DWORD_ALIGN_BYTES);
+	skb_put(skb, RSI_MAX_RX_USB_PKT_SIZE - MAX_DWORD_ALIGN_BYTES);
 	dword_align_bytes = (unsigned long)skb->data & 0x3f;
 	if (dword_align_bytes > 0)
 		skb_push(skb, dword_align_bytes);
@@ -319,7 +322,7 @@ static int rsi_rx_urb_submit(struct rsi_hw *adapter, u8 ep_num)
 			  usb_rcvbulkpipe(dev->usbdev,
 			  dev->bulkin_endpoint_addr[ep_num - 1]),
 			  urb->transfer_buffer,
-			  RSI_MAX_RX_USB_PKT_SIZE,
+			  skb->len,
 			  rsi_rx_done_handler,
 			  rx_cb);
 
-- 
2.17.1

