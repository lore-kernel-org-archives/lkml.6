Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D74C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 991EC21470
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKip1pCb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 991EC21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730964AbeJKXLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:11:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:42936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbeJKXLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:11:09 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C4B22098A;
        Thu, 11 Oct 2018 15:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272605;
        bh=nh7EdIPAoNbS/wwwubozlXf9MWIGKm1m+5dr27sh8qU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QKip1pCbvnsAD6WuylcBtCqIWbijyucoh09rH0U8BsGICpVKgqkMSKX8FJCxlcsY4
         WWI3qQ0Q8N6kU0/rPXm/ncUXDePoOvWes0rU4tgB3h9+iwcfYaF/BDUBJqLApcFIgT
         vSg7KXqPiVAW+cuzhIrpLqrFajLZ2kpZh4z/jIiY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yu Wang <yyuwang@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.9 20/35] ath10k: fix kernel panic issue during pci probe
Date:   Thu, 11 Oct 2018 17:35:22 +0200
Message-Id: <20181011152520.978201545@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152520.174949126@linuxfoundation.org>
References: <20181011152520.174949126@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yu Wang <yyuwang@codeaurora.org>

commit 50e79e25250bf928369996277e85b00536b380c7 upstream.

If device gone during chip reset, ar->normal_mode_fw.board is not
initialized, but ath10k_debug_print_hwfw_info() will try to access its
member, which will cause 'kernel NULL pointer' issue. This was found
using a faulty device (pci link went down sometimes) in a random
insmod/rmmod/other-op test.
To fix it, check ar->normal_mode_fw.board before accessing the member.

pci 0000:02:00.0: BAR 0: assigned [mem 0xf7400000-0xf75fffff 64bit]
ath10k_pci 0000:02:00.0: enabling device (0000 -> 0002)
ath10k_pci 0000:02:00.0: pci irq msi oper_irq_mode 2 irq_mode 0 reset_mode 0
ath10k_pci 0000:02:00.0: failed to read device register, device is gone
ath10k_pci 0000:02:00.0: failed to wait for target init: -5
ath10k_pci 0000:02:00.0: failed to warm reset: -5
ath10k_pci 0000:02:00.0: firmware crashed during chip reset
ath10k_pci 0000:02:00.0: firmware crashed! (uuid 5d018951-b8e1-404a-8fde-923078b4423a)
ath10k_pci 0000:02:00.0: (null) target 0x00000000 chip_id 0x00340aff sub 0000:0000
ath10k_pci 0000:02:00.0: kconfig debug 1 debugfs 1 tracing 1 dfs 1 testmode 1
ath10k_pci 0000:02:00.0: firmware ver  api 0 features  crc32 00000000
...
BUG: unable to handle kernel NULL pointer dereference at 00000004
...
Call Trace:
 [<fb4e7882>] ath10k_print_driver_info+0x12/0x20 [ath10k_core]
 [<fb62b7dd>] ath10k_pci_fw_crashed_dump+0x6d/0x4d0 [ath10k_pci]
 [<fb629f07>] ? ath10k_pci_sleep.part.19+0x57/0xc0 [ath10k_pci]
 [<fb62c8ee>] ath10k_pci_hif_power_up+0x14e/0x1b0 [ath10k_pci]
 [<c10477fb>] ? do_page_fault+0xb/0x10
 [<fb4eb934>] ath10k_core_register_work+0x24/0x840 [ath10k_core]
 [<c18a00d8>] ? netlbl_unlhsh_remove+0x178/0x410
 [<c10477f0>] ? __do_page_fault+0x480/0x480
 [<c1068e44>] process_one_work+0x114/0x3e0
 [<c1069d07>] worker_thread+0x37/0x4a0
 [<c106e294>] kthread+0xa4/0xc0
 [<c1069cd0>] ? create_worker+0x180/0x180
 [<c106e1f0>] ? kthread_park+0x50/0x50
 [<c18ab4f7>] ret_from_fork+0x1b/0x28
 Code: 78 80 b8 50 09 00 00 00 75 5d 8d 75 94 c7 44 24 08 aa d7 52 fb c7 44 24 04 64 00 00 00
 89 34 24 e8 82 52 e2 c5 8b 83 dc 08 00 00 <8b> 50 04 8b 08 31 c0 e8 20 57 e3 c5 89 44 24 10 8b 83 58 09 00
 EIP: [<fb4e7754>]-
 ath10k_debug_print_board_info+0x34/0xb0 [ath10k_core]
 SS:ESP 0068:f4921d90
 CR2: 0000000000000004

Signed-off-by: Yu Wang <yyuwang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
[AmitP: Minor rebasing for 4.14.y and 4.9.y]
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/ath/ath10k/debug.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/ath/ath10k/debug.c
+++ b/drivers/net/wireless/ath/ath10k/debug.c
@@ -1,6 +1,7 @@
 /*
  * Copyright (c) 2005-2011 Atheros Communications Inc.
  * Copyright (c) 2011-2013 Qualcomm Atheros, Inc.
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
  *
  * Permission to use, copy, modify, and/or distribute this software for any
  * purpose with or without fee is hereby granted, provided that the above
@@ -161,6 +162,8 @@ void ath10k_debug_print_hwfw_info(struct
 void ath10k_debug_print_board_info(struct ath10k *ar)
 {
 	char boardinfo[100];
+	const struct firmware *board;
+	u32 crc;
 
 	if (ar->id.bmi_ids_valid)
 		scnprintf(boardinfo, sizeof(boardinfo), "%d:%d",
@@ -168,11 +171,16 @@ void ath10k_debug_print_board_info(struc
 	else
 		scnprintf(boardinfo, sizeof(boardinfo), "N/A");
 
+	board = ar->normal_mode_fw.board;
+	if (!IS_ERR_OR_NULL(board))
+		crc = crc32_le(0, board->data, board->size);
+	else
+		crc = 0;
+
 	ath10k_info(ar, "board_file api %d bmi_id %s crc32 %08x",
 		    ar->bd_api,
 		    boardinfo,
-		    crc32_le(0, ar->normal_mode_fw.board->data,
-			     ar->normal_mode_fw.board->size));
+		    crc);
 }
 
 void ath10k_debug_print_boot_info(struct ath10k *ar)


