Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbeEGG53 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 02:57:29 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46350 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750716AbeEGG5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 02:57:25 -0400
X-Google-Smtp-Source: AB8JxZoKW6qh9L+SJV0D8wOuc1FUNIDvFaaukH5wKDuG4eKh6+dP59hstEmPdYwqWqjgC599hmjn6A==
Subject: [PATCH 2/3] scsi: arcmsr: Add slave_configure callback function to
 set device command timeout value
From: Ching Huang <ching2048@areca.com.tw>
To: martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dan.carpenter@oracle.com, hch@infradead.org, colin.king@canonical.com
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 07 May 2018 14:57:16 +0800
Message-ID: <1525676236.8876.18.camel@Centos6.3-64>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.3 (2.32.3-37.el6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From Ching Huang <ching2048@areca.com.tw>

Add slave_configure callback function to set device command timeout value

Signed-off-by: Ching Huang <ching2048@areca.com.tw>
---

diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index f6ddaec..79a4487 100755
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -139,6 +139,7 @@ static irqreturn_t arcmsr_interrupt(struct AdapterControlBlock *acb);
 static void arcmsr_free_irq(struct pci_dev *, struct AdapterControlBlock *);
 static void arcmsr_wait_firmware_ready(struct AdapterControlBlock *acb);
 static void arcmsr_set_iop_datetime(struct timer_list *);
+static int arcmsr_slave_config(struct scsi_device *sdev);
 static int arcmsr_adjust_disk_queue_depth(struct scsi_device *sdev, int queue_depth)
 {
 	if (queue_depth > ARCMSR_MAX_CMD_PERLUN)
@@ -154,6 +155,7 @@ static struct scsi_host_template arcmsr_scsi_host_template = {
 	.eh_abort_handler	= arcmsr_abort,
 	.eh_bus_reset_handler	= arcmsr_bus_reset,
 	.bios_param		= arcmsr_bios_param,
+	.slave_configure	= arcmsr_slave_config,
 	.change_queue_depth	= arcmsr_adjust_disk_queue_depth,
 	.can_queue		= ARCMSR_DEFAULT_OUTSTANDING_CMD,
 	.this_id		= ARCMSR_SCSI_INITIATOR_ID,
@@ -3033,6 +3035,17 @@ static int arcmsr_queue_command_lck(struct scsi_cmnd *cmd,
 
 static DEF_SCSI_QCMD(arcmsr_queue_command)
 
+static int arcmsr_slave_config(struct scsi_device *sdev)
+{
+	unsigned int	dev_timeout;
+
+	dev_timeout = sdev->request_queue->rq_timeout;
+	if ((cmd_timeout > 0) && ((cmd_timeout * HZ) > dev_timeout))
+		blk_queue_rq_timeout(sdev->request_queue, cmd_timeout * HZ);
+	arcmsr_adjust_disk_queue_depth(sdev, cmd_per_lun);
+	return 0;
+}
+
 static void arcmsr_get_adapter_config(struct AdapterControlBlock *pACB, uint32_t *rwbuffer)
 {
 	int count;
