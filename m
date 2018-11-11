Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFE7C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9525520872
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWJDDvhs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9525520872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390888AbeKLItN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:49:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:52752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390795AbeKLIWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:38 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89F182243E;
        Sun, 11 Nov 2018 22:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975561;
        bh=4Sm4qGhQ1tep0V6H5pjlcFufoXQbmMfIZh/wwQBzajI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gWJDDvhsCBKZqnQi0xe9Vxu97SpXyuaYz+JoQUZFzGvmzbbjBPRbWeWK6q3qOOUMg
         7Vn7q1R9sZSZlb1xHe8uyswoWLJtbFYwTRF3sh0fo0tnWMaXxqnLf7YpZ5D0R7JofT
         4/tYXzR8TBVP5QVd2exQ3Fpy+4FBEkMq6yaIGMxk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.14 124/222] libertas: dont set URB_ZERO_PACKET on IN USB transfer
Date:   Sun, 11 Nov 2018 14:23:41 -0800
Message-Id: <20181111221658.784346627@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lubomir Rintel <lkundrak@v3.sk>

commit 6528d88047801b80d2a5370ad46fb6eff2f509e0 upstream.

The USB core gets rightfully upset:

  usb 1-1: BOGUS urb flags, 240 --> 200
  WARNING: CPU: 0 PID: 60 at drivers/usb/core/urb.c:503 usb_submit_urb+0x2f8/0x3ed
  Modules linked in:
  CPU: 0 PID: 60 Comm: kworker/0:3 Not tainted 4.19.0-rc6-00319-g5206d00a45c7 #39
  Hardware name: OLPC XO/XO, BIOS OLPC Ver 1.00.01 06/11/2014
  Workqueue: events request_firmware_work_func
  EIP: usb_submit_urb+0x2f8/0x3ed
  Code: 75 06 8b 8f 80 00 00 00 8d 47 78 89 4d e4 89 55 e8 e8 35 1c f6 ff 8b 55 e8 56 52 8b 4d e4 51 50 68 e3 ce c7 c0 e8 ed 18 c6 ff <0f> 0b 83 c4 14 80 7d ef 01 74 0a 80 7d ef 03 0f 85 b8 00 00 00 8b
  EAX: 00000025 EBX: ce7d4980 ECX: 00000000 EDX: 00000001
  ESI: 00000200 EDI: ce7d8800 EBP: ce7f5ea8 ESP: ce7f5e70
  DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068 EFLAGS: 00210292
  CR0: 80050033 CR2: 00000000 CR3: 00e80000 CR4: 00000090
  Call Trace:
   ? if_usb_fw_timeo+0x64/0x64
   __if_usb_submit_rx_urb+0x85/0xe6
   ? if_usb_fw_timeo+0x64/0x64
   if_usb_submit_rx_urb_fwload+0xd/0xf
   if_usb_prog_firmware+0xc0/0x3db
   ? _request_firmware+0x54/0x47b
   ? _request_firmware+0x89/0x47b
   ? if_usb_probe+0x412/0x412
   lbs_fw_loaded+0x55/0xa6
   ? debug_smp_processor_id+0x12/0x14
   helper_firmware_cb+0x3c/0x3f
   request_firmware_work_func+0x37/0x6f
   process_one_work+0x164/0x25a
   worker_thread+0x1c4/0x284
   kthread+0xec/0xf1
   ? cancel_delayed_work_sync+0xf/0xf
   ? kthread_create_on_node+0x1a/0x1a
   ret_from_fork+0x2e/0x38
  ---[ end trace 3ef1e3b2dd53852f ]---

Cc: stable@vger.kernel.org
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/marvell/libertas/if_usb.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/net/wireless/marvell/libertas/if_usb.c
+++ b/drivers/net/wireless/marvell/libertas/if_usb.c
@@ -456,8 +456,6 @@ static int __if_usb_submit_rx_urb(struct
 			  MRVDRV_ETH_RX_PACKET_BUFFER_SIZE, callbackfn,
 			  cardp);
 
-	cardp->rx_urb->transfer_flags |= URB_ZERO_PACKET;
-
 	lbs_deb_usb2(&cardp->udev->dev, "Pointer for rx_urb %p\n", cardp->rx_urb);
 	if ((ret = usb_submit_urb(cardp->rx_urb, GFP_ATOMIC))) {
 		lbs_deb_usbd(&cardp->udev->dev, "Submit Rx URB failed: %d\n", ret);


