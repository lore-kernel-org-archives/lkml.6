Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6ADC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA50E20821
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbfBCOB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:01:58 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53236 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728111AbfBCNtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:49 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9b-0003ts-6m; Sun, 03 Feb 2019 13:49:47 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9W-0006uk-RD; Sun, 03 Feb 2019 14:49:42 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Lubomir Rintel" <lkundrak@v3.sk>,
        "Kalle Valo" <kvalo@codeaurora.org>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.330096539@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 080/305] libertas: don't set URB_ZERO_PACKET on IN
 USB transfer
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

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

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
[bwh: Backported to 3.16: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/wireless/libertas/if_usb.c | 2 --
 1 file changed, 2 deletions(-)

--- a/drivers/net/wireless/libertas/if_usb.c
+++ b/drivers/net/wireless/libertas/if_usb.c
@@ -467,8 +467,6 @@ static int __if_usb_submit_rx_urb(struct
 			  MRVDRV_ETH_RX_PACKET_BUFFER_SIZE, callbackfn,
 			  cardp);
 
-	cardp->rx_urb->transfer_flags |= URB_ZERO_PACKET;
-
 	lbs_deb_usb2(&cardp->udev->dev, "Pointer for rx_urb %p\n", cardp->rx_urb);
 	if ((ret = usb_submit_urb(cardp->rx_urb, GFP_ATOMIC))) {
 		lbs_deb_usbd(&cardp->udev->dev, "Submit Rx URB failed: %d\n", ret);

