Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id n2GdEGlEGVspFQAAmS7hNA
	; Thu, 07 Jun 2018 14:42:57 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E86CD608C8; Thu,  7 Jun 2018 14:42:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 26DAD602FC;
	Thu,  7 Jun 2018 14:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 26DAD602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934809AbeFGOmy (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:42:54 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40648 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934319AbeFGOms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:42:48 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbU-0005Zi-B7; Thu, 07 Jun 2018 15:09:28 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbB-0003B3-6W; Thu, 07 Jun 2018 15:09:09 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Tejun Heo" <tj@kernel.org>,
        "Shaohua Li" <shli@fb.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.620274648@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 317/410] ata: Add a new flag to destinguish sas
 controller
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Shaohua Li <shli@fb.com>

commit 5067c0469c643512f24786990e315f9c15cc7d24 upstream.

SAS controller has its own tag allocation, which doesn't directly match to ATA
tag, so SAS and SATA have different code path for ata tags. Originally we use
port->scsi_host (98bd4be1) to destinguish SAS controller, but libsas set
->scsi_host too, so we can't use it for the destinguish, we add a new flag for
this purpose.

Without this patch, the following oops can happen because scsi-mq uses
a host-wide tag map shared among all devices with some integer tag
values >= ATA_MAX_QUEUE.  These unexpectedly high tag values cause
__ata_qc_from_tag() to return NULL, which is then dereferenced in
ata_qc_new_init().

  BUG: unable to handle kernel NULL pointer dereference at 0000000000000058
  IP: [<ffffffff804fd46e>] ata_qc_new_init+0x3e/0x120
  PGD 32adf0067 PUD 32adf1067 PMD 0
  Oops: 0002 [#1] SMP DEBUG_PAGEALLOC
  Modules linked in: iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi igb
  i2c_algo_bit ptp pps_core pm80xx libsas scsi_transport_sas sg coretemp
  eeprom w83795 i2c_i801
  CPU: 4 PID: 1450 Comm: cydiskbench Not tainted 4.0.0-rc3 #1
  Hardware name: Supermicro X8DTH-i/6/iF/6F/X8DTH, BIOS 2.1b       05/04/12
  task: ffff8800ba86d500 ti: ffff88032a064000 task.ti: ffff88032a064000
  RIP: 0010:[<ffffffff804fd46e>]  [<ffffffff804fd46e>] ata_qc_new_init+0x3e/0x120
  RSP: 0018:ffff88032a067858  EFLAGS: 00010046
  RAX: 0000000000000000 RBX: ffff8800ba0d2230 RCX: 000000000000002a
  RDX: ffffffff80505ae0 RSI: 0000000000000020 RDI: ffff8800ba0d2230
  RBP: ffff88032a067868 R08: 0000000000000201 R09: 0000000000000001
  R10: 0000000000000000 R11: 0000000000000000 R12: ffff8800ba0d0000
  R13: ffff8800ba0d2230 R14: ffffffff80505ae0 R15: ffff8800ba0d0000
  FS:  0000000041223950(0063) GS:ffff88033e480000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
  CR2: 0000000000000058 CR3: 000000032a0a3000 CR4: 00000000000006e0
  Stack:
   ffff880329eee758 ffff880329eee758 ffff88032a0678a8 ffffffff80502dad
   ffff8800ba167978 ffff880329eee758 ffff88032bf9c520 ffff8800ba167978
   ffff88032bf9c520 ffff88032bf9a290 ffff88032a0678b8 ffffffff80506909
  Call Trace:
   [<ffffffff80502dad>] ata_scsi_translate+0x3d/0x1b0
   [<ffffffff80506909>] ata_sas_queuecmd+0x149/0x2a0
   [<ffffffffa0046650>] sas_queuecommand+0xa0/0x1f0 [libsas]
   [<ffffffff804ea544>] scsi_dispatch_cmd+0xd4/0x1a0
   [<ffffffff804eb50f>] scsi_queue_rq+0x66f/0x7f0
   [<ffffffff803e5098>] __blk_mq_run_hw_queue+0x208/0x3f0
   [<ffffffff803e54b8>] blk_mq_run_hw_queue+0x88/0xc0
   [<ffffffff803e5c74>] blk_mq_insert_request+0xc4/0x130
   [<ffffffff803e0b63>] blk_execute_rq_nowait+0x73/0x160
   [<ffffffffa0023fca>] sg_common_write+0x3da/0x720 [sg]
   [<ffffffffa0025100>] sg_new_write+0x250/0x360 [sg]
   [<ffffffffa0025feb>] sg_write+0x13b/0x450 [sg]
   [<ffffffff8032ec91>] vfs_write+0xd1/0x1b0
   [<ffffffff8032ee54>] SyS_write+0x54/0xc0
   [<ffffffff80689932>] system_call_fastpath+0x12/0x17

tj: updated description.

Fixes: 12cb5ce101ab ("libata: use blk taging")
Reported-and-tested-by: Tony Battersby <tonyb@cybernetics.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
[bwh: Backported to 3.16: Drop changes to ata_qc_{new_init,free}(); we don't
 actually have the tag allocation bug]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/ata/libata-core.c     | 4 ++--
 drivers/scsi/ipr.c            | 3 ++-
 drivers/scsi/libsas/sas_ata.c | 3 ++-
 include/linux/libata.h        | 1 +
 4 files changed, 7 insertions(+), 4 deletions(-)

--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -6862,7 +6862,8 @@ static struct ata_port_operations ipr_sa
 };
 
 static struct ata_port_info sata_port_info = {
-	.flags		= ATA_FLAG_SATA | ATA_FLAG_PIO_DMA,
+	.flags		= ATA_FLAG_SATA | ATA_FLAG_PIO_DMA |
+			  ATA_FLAG_SAS_HOST,
 	.pio_mask	= ATA_PIO4_ONLY,
 	.mwdma_mask	= ATA_MWDMA2,
 	.udma_mask	= ATA_UDMA6,
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -566,7 +566,8 @@ static struct ata_port_operations sas_sa
 };
 
 static struct ata_port_info sata_port_info = {
-	.flags = ATA_FLAG_SATA | ATA_FLAG_PIO_DMA | ATA_FLAG_NCQ,
+	.flags = ATA_FLAG_SATA | ATA_FLAG_PIO_DMA | ATA_FLAG_NCQ |
+		 ATA_FLAG_SAS_HOST,
 	.pio_mask = ATA_PIO4,
 	.mwdma_mask = ATA_MWDMA2,
 	.udma_mask = ATA_UDMA6,
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -232,6 +232,7 @@ enum {
 					      * led */
 	ATA_FLAG_NO_DIPM	= (1 << 23), /* host not happy with DIPM */
 	ATA_FLAG_LOWTAG		= (1 << 24), /* host wants lowest available tag */
+	ATA_FLAG_SAS_HOST	= (1 << 25), /* SAS host */
 
 	/* bits 24:31 of ap->flags are reserved for LLD specific flags */
 
