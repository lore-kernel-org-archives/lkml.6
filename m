Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqOpKUUB8/a42ddiy2+tXfSXn2jiDYfU+vStvn6dGZVCYJJlBU/0jSdIuwIkcXDQJkEqrEL
ARC-Seal: i=1; a=rsa-sha256; t=1527155691; cv=none;
        d=google.com; s=arc-20160816;
        b=DaotfP1augClixn74eExw9CWGupzxTUMH+33oYxOEkOeY0uPsHIib+4okFSTq2SA1e
         hBFd3JUZytOOgthT/pWgFgik32ZVuhb+yD+BS9wOdXIdGd2vJMor0BX2ecOkTKdX3uNx
         7dV21V6RTbZBhTi7s1HezbUrjd30t2TSVEqVEtQ2mR5uQDH9FQiYScoirUEC2pD69sVn
         Pimmv6xXjFS5/rQGLxb7gxkbBLN7lBEPPixoo/E0flbkhcCzTIXOb0LsRts1zQFwjD/P
         D+4TthBii6D9++2snPMM4GWMAvO75okc22tDHq2Wybtazz50L3lc9spKqsbNK8sFPyhS
         rrsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=c70Q+rR6C+un2YIxxxHEmQxzFtCabrJ8y+Z3eHjNsCw=;
        b=RgUAM2lNyHntgz4t5msIdAF6YCStoQR8MHauawBpe+VpLUub5kZJcM/90ydbLWMd86
         VhlCNI6Asbh144/uCF2wT3jeQDhDFK6lpJW6Q8CLNZ+STgkBhZOBKrcu1zn5PaMbedUH
         5ZxTZ8lCZbPtwk0fiI+4BwNP3JAGc/HaoQnA+UKjAiOLnHBgej40hNxhEXF4ERy53X0b
         xHLkSYuRX3/wDEL1mz1GQnP2WZrruLqGkHgBA/3L/23lty6mXSyqcLpfMlLFVEkn+vC2
         2Nuj6pZLVYCPdzAikdTditfYbAzrb1mib2LzrMA3E22M1+QYb4sb0llOybghXftWQo2I
         6jrg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=kSjUzeVM;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=kSjUzeVM;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jason Yan <yanaijie@huawei.com>,
	Xiaofei Tan <tanxiaofei@huawei.com>,
	John Garry <john.garry@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.14 046/165] scsi: libsas: defer ata device eh commands to libata
Date: Thu, 24 May 2018 11:37:32 +0200
Message-Id: <20180524093623.892469476@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338016246744962?=
X-GMAIL-MSGID: =?utf-8?q?1601338806172124912?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Yan <yanaijie@huawei.com>

commit 318aaf34f1179b39fa9c30fa0f3288b645beee39 upstream.

When ata device doing EH, some commands still attached with tasks are
not passed to libata when abort failed or recover failed, so libata did
not handle these commands. After these commands done, sas task is freed,
but ata qc is not freed. This will cause ata qc leak and trigger a
warning like below:

WARNING: CPU: 0 PID: 28512 at drivers/ata/libata-eh.c:4037
ata_eh_finish+0xb4/0xcc
CPU: 0 PID: 28512 Comm: kworker/u32:2 Tainted: G     W  OE 4.14.0#1
......
Call trace:
[<ffff0000088b7bd0>] ata_eh_finish+0xb4/0xcc
[<ffff0000088b8420>] ata_do_eh+0xc4/0xd8
[<ffff0000088b8478>] ata_std_error_handler+0x44/0x8c
[<ffff0000088b8068>] ata_scsi_port_error_handler+0x480/0x694
[<ffff000008875fc4>] async_sas_ata_eh+0x4c/0x80
[<ffff0000080f6be8>] async_run_entry_fn+0x4c/0x170
[<ffff0000080ebd70>] process_one_work+0x144/0x390
[<ffff0000080ec100>] worker_thread+0x144/0x418
[<ffff0000080f2c98>] kthread+0x10c/0x138
[<ffff0000080855dc>] ret_from_fork+0x10/0x18

If ata qc leaked too many, ata tag allocation will fail and io blocked
for ever.

As suggested by Dan Williams, defer ata device commands to libata and
merge sas_eh_finish_cmd() with sas_eh_defer_cmd(). libata will handle
ata qcs correctly after this.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
CC: Xiaofei Tan <tanxiaofei@huawei.com>
CC: John Garry <john.garry@huawei.com>
CC: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/libsas/sas_scsi_host.c |   33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -222,6 +222,7 @@ out_done:
 static void sas_eh_finish_cmd(struct scsi_cmnd *cmd)
 {
 	struct sas_ha_struct *sas_ha = SHOST_TO_SAS_HA(cmd->device->host);
+	struct domain_device *dev = cmd_to_domain_dev(cmd);
 	struct sas_task *task = TO_SAS_TASK(cmd);
 
 	/* At this point, we only get called following an actual abort
@@ -230,6 +231,14 @@ static void sas_eh_finish_cmd(struct scs
 	 */
 	sas_end_task(cmd, task);
 
+	if (dev_is_sata(dev)) {
+		/* defer commands to libata so that libata EH can
+		 * handle ata qcs correctly
+		 */
+		list_move_tail(&cmd->eh_entry, &sas_ha->eh_ata_q);
+		return;
+	}
+
 	/* now finish the command and move it on to the error
 	 * handler done list, this also takes it off the
 	 * error handler pending list.
@@ -237,22 +246,6 @@ static void sas_eh_finish_cmd(struct scs
 	scsi_eh_finish_cmd(cmd, &sas_ha->eh_done_q);
 }
 
-static void sas_eh_defer_cmd(struct scsi_cmnd *cmd)
-{
-	struct domain_device *dev = cmd_to_domain_dev(cmd);
-	struct sas_ha_struct *ha = dev->port->ha;
-	struct sas_task *task = TO_SAS_TASK(cmd);
-
-	if (!dev_is_sata(dev)) {
-		sas_eh_finish_cmd(cmd);
-		return;
-	}
-
-	/* report the timeout to libata */
-	sas_end_task(cmd, task);
-	list_move_tail(&cmd->eh_entry, &ha->eh_ata_q);
-}
-
 static void sas_scsi_clear_queue_lu(struct list_head *error_q, struct scsi_cmnd *my_cmd)
 {
 	struct scsi_cmnd *cmd, *n;
@@ -260,7 +253,7 @@ static void sas_scsi_clear_queue_lu(stru
 	list_for_each_entry_safe(cmd, n, error_q, eh_entry) {
 		if (cmd->device->sdev_target == my_cmd->device->sdev_target &&
 		    cmd->device->lun == my_cmd->device->lun)
-			sas_eh_defer_cmd(cmd);
+			sas_eh_finish_cmd(cmd);
 	}
 }
 
@@ -630,12 +623,12 @@ static void sas_eh_handle_sas_errors(str
 		case TASK_IS_DONE:
 			SAS_DPRINTK("%s: task 0x%p is done\n", __func__,
 				    task);
-			sas_eh_defer_cmd(cmd);
+			sas_eh_finish_cmd(cmd);
 			continue;
 		case TASK_IS_ABORTED:
 			SAS_DPRINTK("%s: task 0x%p is aborted\n",
 				    __func__, task);
-			sas_eh_defer_cmd(cmd);
+			sas_eh_finish_cmd(cmd);
 			continue;
 		case TASK_IS_AT_LU:
 			SAS_DPRINTK("task 0x%p is at LU: lu recover\n", task);
@@ -646,7 +639,7 @@ static void sas_eh_handle_sas_errors(str
 					    "recovered\n",
 					    SAS_ADDR(task->dev),
 					    cmd->device->lun);
-				sas_eh_defer_cmd(cmd);
+				sas_eh_finish_cmd(cmd);
 				sas_scsi_clear_queue_lu(work_q, cmd);
 				goto Again;
 			}
