Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC563C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DB452083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DB452083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733141AbeHAUOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:14:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46142 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404246AbeHATDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:37 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A3F0D11EB;
        Wed,  1 Aug 2018 17:08:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Uma Krishnan <ukrishn@linux.vnet.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 282/336] scsi: cxlflash: Synchronize reset and remove ops
Date:   Wed,  1 Aug 2018 18:50:17 +0200
Message-Id: <20180801165039.815203766@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>

[ Upstream commit a3feb6ef50def7c91244d7bd15a3625b7b49b81f ]

The following Oops can be encountered if a device removal or system shutdown
is initiated while an EEH recovery is in process:

[c000000ff2f479c0] c008000015256f18 cxlflash_pci_slot_reset+0xa0/0x100
                                      [cxlflash]
[c000000ff2f47a30] c00800000dae22e0 cxl_pci_slot_reset+0x168/0x290 [cxl]
[c000000ff2f47ae0] c00000000003ef1c eeh_report_reset+0xec/0x170
[c000000ff2f47b20] c00000000003d0b8 eeh_pe_dev_traverse+0x98/0x170
[c000000ff2f47bb0] c00000000003f80c eeh_handle_normal_event+0x56c/0x580
[c000000ff2f47c60] c00000000003fba4 eeh_handle_event+0x2a4/0x338
[c000000ff2f47d10] c0000000000400b8 eeh_event_handler+0x1f8/0x200
[c000000ff2f47dc0] c00000000013da48 kthread+0x1a8/0x1b0
[c000000ff2f47e30] c00000000000b528 ret_from_kernel_thread+0x5c/0xb4

The remove handler frees AFU memory while the EEH recovery is in progress,
leading to a race condition. This can result in a crash if the recovery thread
tries to access this memory.

To resolve this issue, the cxlflash remove handler will evaluate the device
state and yield to any active reset or probing threads.

Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/cxlflash/main.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -946,9 +946,9 @@ static void cxlflash_remove(struct pci_d
 		return;
 	}
 
-	/* If a Task Management Function is active, wait for it to complete
-	 * before continuing with remove.
-	 */
+	/* Yield to running recovery threads before continuing with remove */
+	wait_event(cfg->reset_waitq, cfg->state != STATE_RESET &&
+				     cfg->state != STATE_PROBING);
 	spin_lock_irqsave(&cfg->tmf_slock, lock_flags);
 	if (cfg->tmf_active)
 		wait_event_interruptible_lock_irq(cfg->tmf_waitq,


