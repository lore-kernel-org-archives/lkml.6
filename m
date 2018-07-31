Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DFAC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABAEB2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABAEB2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732421AbeGaP2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 11:28:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:41920 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732380AbeGaP2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 11:28:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 31D5CAE4D;
        Tue, 31 Jul 2018 13:48:12 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        ard <ard@kwaak.net>, Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 3/3] scsi: fcoe: clear FC_RP_STARTED flags when receiving a LOGO
Date:   Tue, 31 Jul 2018 15:46:03 +0200
Message-Id: <20180731134603.20089-4-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180731134603.20089-1-jthumshirn@suse.de>
References: <20180731134603.20089-1-jthumshirn@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When receiving a LOGO request we forget to clear the FC_RP_STARTED
flag before starting the rport delete routine.

As the started flag was not cleared, we're not deleting the rport but
waiting for a restart and thus are keeping the reference count of the
rdata object at 1.

This leads to the following kmemleak report:
unreferenced object 0xffff88006542aa00 (size 512):
  comm "kworker/0:2", pid 24, jiffies 4294899222 (age 226.880s)
  hex dump (first 32 bytes):
    68 96 fe 65 00 88 ff ff 00 00 00 00 00 00 00 00  h..e............
    01 00 00 00 08 00 00 00 02 c5 45 24 ac b8 00 10  ..........E$....
  backtrace:
    [<(____ptrval____)>] fcoe_ctlr_vn_add.isra.5+0x7f/0x770 [libfcoe]
    [<(____ptrval____)>] fcoe_ctlr_vn_recv+0x12af/0x27f0 [libfcoe]
    [<(____ptrval____)>] fcoe_ctlr_recv_work+0xd01/0x32f0 [libfcoe]
    [<(____ptrval____)>] process_one_work+0x7ff/0x1420
    [<(____ptrval____)>] worker_thread+0x87/0xef0
    [<(____ptrval____)>] kthread+0x2db/0x390
    [<(____ptrval____)>] ret_from_fork+0x35/0x40
    [<(____ptrval____)>] 0xffffffffffffffff

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Reported-by: ard <ard@kwaak.net>
---
 drivers/scsi/libfc/fc_rport.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/libfc/fc_rport.c b/drivers/scsi/libfc/fc_rport.c
index 31d31aad3de1..89b1f1af2fd4 100644
--- a/drivers/scsi/libfc/fc_rport.c
+++ b/drivers/scsi/libfc/fc_rport.c
@@ -2164,6 +2164,7 @@ static void fc_rport_recv_logo_req(struct fc_lport *lport, struct fc_frame *fp)
 		FC_RPORT_DBG(rdata, "Received LOGO request while in state %s\n",
 			     fc_rport_state(rdata));
 
+		rdata->flags &= ~FC_RP_STARTED;
 		fc_rport_enter_delete(rdata, RPORT_EV_STOP);
 		mutex_unlock(&rdata->rp_mutex);
 		kref_put(&rdata->kref, fc_rport_destroy);
-- 
2.16.4

