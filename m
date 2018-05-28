Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S940388AbeE1QlJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 12:41:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:56108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933884AbeE1KIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:08:04 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Manish Rangankar <manish.rangankar@cavium.com>,
        "Ewan D. Milne" <emilne@redhat.com>, Tomas Henzl <thenzl@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 055/185] scsi: qla4xxx: skip error recovery in case of register disconnect.
Date: Mon, 28 May 2018 12:01:36 +0200
Message-Id: <20180528100055.558842835@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100050.700971285@linuxfoundation.org>
References: <20180528100050.700971285@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Manish Rangankar <manish.rangankar@cavium.com>

[ Upstream commit 1bc5ad3a6acdcf56f83272f2de1cd2389ea9e9e2 ]

A system crashes when continuously removing/re-adding the storage
controller.

Signed-off-by: Manish Rangankar <manish.rangankar@cavium.com>
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Reviewed-by: Tomas Henzl <thenzl@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla4xxx/ql4_def.h |    2 +
 drivers/scsi/qla4xxx/ql4_os.c  |   46 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

--- a/drivers/scsi/qla4xxx/ql4_def.h
+++ b/drivers/scsi/qla4xxx/ql4_def.h
@@ -167,6 +167,8 @@
 #define DEV_DB_NON_PERSISTENT	0
 #define DEV_DB_PERSISTENT	1
 
+#define QL4_ISP_REG_DISCONNECT 0xffffffffU
+
 #define COPY_ISID(dst_isid, src_isid) {			\
 	int i, j;					\
 	for (i = 0, j = ISID_SIZE - 1; i < ISID_SIZE;)	\
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -268,6 +268,24 @@ static struct iscsi_transport qla4xxx_is
 
 static struct scsi_transport_template *qla4xxx_scsi_transport;
 
+static int qla4xxx_isp_check_reg(struct scsi_qla_host *ha)
+{
+	u32 reg_val = 0;
+	int rval = QLA_SUCCESS;
+
+	if (is_qla8022(ha))
+		reg_val = readl(&ha->qla4_82xx_reg->host_status);
+	else if (is_qla8032(ha) || is_qla8042(ha))
+		reg_val = qla4_8xxx_rd_direct(ha, QLA8XXX_PEG_ALIVE_COUNTER);
+	else
+		reg_val = readw(&ha->reg->ctrl_status);
+
+	if (reg_val == QL4_ISP_REG_DISCONNECT)
+		rval = QLA_ERROR;
+
+	return rval;
+}
+
 static int qla4xxx_send_ping(struct Scsi_Host *shost, uint32_t iface_num,
 			     uint32_t iface_type, uint32_t payload_size,
 			     uint32_t pid, struct sockaddr *dst_addr)
@@ -9230,10 +9248,17 @@ static int qla4xxx_eh_abort(struct scsi_
 	struct srb *srb = NULL;
 	int ret = SUCCESS;
 	int wait = 0;
+	int rval;
 
 	ql4_printk(KERN_INFO, ha, "scsi%ld:%d:%llu: Abort command issued cmd=%p, cdb=0x%x\n",
 		   ha->host_no, id, lun, cmd, cmd->cmnd[0]);
 
+	rval = qla4xxx_isp_check_reg(ha);
+	if (rval != QLA_SUCCESS) {
+		ql4_printk(KERN_INFO, ha, "PCI/Register disconnect, exiting.\n");
+		return FAILED;
+	}
+
 	spin_lock_irqsave(&ha->hardware_lock, flags);
 	srb = (struct srb *) CMD_SP(cmd);
 	if (!srb) {
@@ -9285,6 +9310,7 @@ static int qla4xxx_eh_device_reset(struc
 	struct scsi_qla_host *ha = to_qla_host(cmd->device->host);
 	struct ddb_entry *ddb_entry = cmd->device->hostdata;
 	int ret = FAILED, stat;
+	int rval;
 
 	if (!ddb_entry)
 		return ret;
@@ -9304,6 +9330,12 @@ static int qla4xxx_eh_device_reset(struc
 		      cmd, jiffies, cmd->request->timeout / HZ,
 		      ha->dpc_flags, cmd->result, cmd->allowed));
 
+	rval = qla4xxx_isp_check_reg(ha);
+	if (rval != QLA_SUCCESS) {
+		ql4_printk(KERN_INFO, ha, "PCI/Register disconnect, exiting.\n");
+		return FAILED;
+	}
+
 	/* FIXME: wait for hba to go online */
 	stat = qla4xxx_reset_lun(ha, ddb_entry, cmd->device->lun);
 	if (stat != QLA_SUCCESS) {
@@ -9347,6 +9379,7 @@ static int qla4xxx_eh_target_reset(struc
 	struct scsi_qla_host *ha = to_qla_host(cmd->device->host);
 	struct ddb_entry *ddb_entry = cmd->device->hostdata;
 	int stat, ret;
+	int rval;
 
 	if (!ddb_entry)
 		return FAILED;
@@ -9364,6 +9397,12 @@ static int qla4xxx_eh_target_reset(struc
 		      ha->host_no, cmd, jiffies, cmd->request->timeout / HZ,
 		      ha->dpc_flags, cmd->result, cmd->allowed));
 
+	rval = qla4xxx_isp_check_reg(ha);
+	if (rval != QLA_SUCCESS) {
+		ql4_printk(KERN_INFO, ha, "PCI/Register disconnect, exiting.\n");
+		return FAILED;
+	}
+
 	stat = qla4xxx_reset_target(ha, ddb_entry);
 	if (stat != QLA_SUCCESS) {
 		starget_printk(KERN_INFO, scsi_target(cmd->device),
@@ -9418,9 +9457,16 @@ static int qla4xxx_eh_host_reset(struct
 {
 	int return_status = FAILED;
 	struct scsi_qla_host *ha;
+	int rval;
 
 	ha = to_qla_host(cmd->device->host);
 
+	rval = qla4xxx_isp_check_reg(ha);
+	if (rval != QLA_SUCCESS) {
+		ql4_printk(KERN_INFO, ha, "PCI/Register disconnect, exiting.\n");
+		return FAILED;
+	}
+
 	if ((is_qla8032(ha) || is_qla8042(ha)) && ql4xdontresethba)
 		qla4_83xx_set_idc_dontreset(ha);
 
