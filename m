Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752084AbeDIMlx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 08:41:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:39933 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751676AbeDIMlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 08:41:52 -0400
From: Johannes Thumshirn <jthumshirn@suse.de>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Himanshu Madhani <himanshu.madhani@cavium.com>
Subject: [PATCH] scsi: qla2xxx: Correct setting of SAM_STAT_CHECK_CONDITION
Date: Mon,  9 Apr 2018 14:39:22 +0200
Message-Id: <20180409123922.854-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bart reports that in qla_isr.c's qla2x00_handle_dif_error we're
wrongly shifting the SAM_STAT_CHECK_CONDITION by one instead of
directly ORing it onto the SCSI command's result.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Reported-by: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: Himanshu Madhani <himanshu.madhani@cavium.com>
---
 drivers/scsi/qla2xxx/qla_isr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index 49d67e1d571f..ed6cdfea00b4 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -2195,7 +2195,7 @@ qla2x00_handle_dif_error(srb_t *sp, struct sts_entry_24xx *sts24)
 		    0x10, 0x1);
 		set_driver_byte(cmd, DRIVER_SENSE);
 		set_host_byte(cmd, DID_ABORT);
-		cmd->result |= SAM_STAT_CHECK_CONDITION << 1;
+		cmd->result |= SAM_STAT_CHECK_CONDITION;
 		return 1;
 	}
 
@@ -2205,7 +2205,7 @@ qla2x00_handle_dif_error(srb_t *sp, struct sts_entry_24xx *sts24)
 		    0x10, 0x3);
 		set_driver_byte(cmd, DRIVER_SENSE);
 		set_host_byte(cmd, DID_ABORT);
-		cmd->result |= SAM_STAT_CHECK_CONDITION << 1;
+		cmd->result |= SAM_STAT_CHECK_CONDITION;
 		return 1;
 	}
 
@@ -2215,7 +2215,7 @@ qla2x00_handle_dif_error(srb_t *sp, struct sts_entry_24xx *sts24)
 		    0x10, 0x2);
 		set_driver_byte(cmd, DRIVER_SENSE);
 		set_host_byte(cmd, DID_ABORT);
-		cmd->result |= SAM_STAT_CHECK_CONDITION << 1;
+		cmd->result |= SAM_STAT_CHECK_CONDITION;
 		return 1;
 	}
 
-- 
2.16.2
