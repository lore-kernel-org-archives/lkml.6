Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DE6C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D541F21726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548169776;
	bh=xFhKV7tvTbXpfATs/LPmIu606U/90xVAEffgfEz4NE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zvGXv8vISfRRknyq0i/+h/3G76f8WrrcM+U+DzPCz7mUtck7CAorWDZY9rB6gwG/a
	 Z7UkDkjLskNsPmB/88kb/7nrwM+GMyqsZceyM2TFe9KcjDtQzXIjlUMqUnu6dhv6ix
	 wbMg+8udqjC3qiArCrHZ+62A34ipsICqsePlt4RI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbfAVPJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:09:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:48874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729136AbfAVPJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:09:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE67A20879;
        Tue, 22 Jan 2019 15:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548169770;
        bh=xFhKV7tvTbXpfATs/LPmIu606U/90xVAEffgfEz4NE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MCqEJmhoynwvl+L0Byc1dwNfJ0pjKEqM49S/sZ3LCkiujbYn8jBWj3kuDSYl9DhRW
         UNCTdYAcGXgoM39esCPzA7QJLEsimj3CH6QDPYJLiQ5ARRwraDbLP7DDyqgQrp6OB/
         j0r6pMl1gL+OJqv9P9b+Ex7S6AtyUhCiqew54V7E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     James Bottomley <jejb@linux.ibm.com>,
        Martin Petersen <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 5/7] scsi: lpfc: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 16:09:04 +0100
Message-Id: <20190122150906.12470-6-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122150906.12470-1-gregkh@linuxfoundation.org>
References: <20190122150906.12470-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: James Smart <james.smart@broadcom.com>
Cc: Dick Kennedy <dick.kennedy@broadcom.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/lpfc/lpfc_debugfs.c | 170 -------------------------------
 1 file changed, 170 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index a58f0b3f03a9..a851dee09587 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -5280,11 +5280,6 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 	if (!lpfc_debugfs_root) {
 		lpfc_debugfs_root = debugfs_create_dir("lpfc", NULL);
 		atomic_set(&lpfc_debugfs_hba_count, 0);
-		if (!lpfc_debugfs_root) {
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
-					 "0408 Cannot create debugfs root\n");
-			goto debug_failed;
-		}
 	}
 	if (!lpfc_debugfs_start_time)
 		lpfc_debugfs_start_time = jiffies;
@@ -5295,11 +5290,6 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 		pport_setup = true;
 		phba->hba_debugfs_root =
 			debugfs_create_dir(name, lpfc_debugfs_root);
-		if (!phba->hba_debugfs_root) {
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
-					 "0412 Cannot create debugfs hba\n");
-			goto debug_failed;
-		}
 		atomic_inc(&lpfc_debugfs_hba_count);
 		atomic_set(&phba->debugfs_vport_count, 0);
 
@@ -5309,11 +5299,6 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 			debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
 				 phba->hba_debugfs_root,
 				 phba, &lpfc_debugfs_op_hbqinfo);
-		if (!phba->debug_hbqinfo) {
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
-				"0411 Cannot create debugfs hbqinfo\n");
-			goto debug_failed;
-		}
 
 		/* Setup dumpHBASlim */
 		if (phba->sli_rev < LPFC_SLI_REV4) {
@@ -5323,12 +5308,6 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 					S_IFREG|S_IRUGO|S_IWUSR,
 					phba->hba_debugfs_root,
 					phba, &lpfc_debugfs_op_dumpHBASlim);
-			if (!phba->debug_dumpHBASlim) {
-				lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
-						 "0413 Cannot create debugfs "
-						"dumpHBASlim\n");
-				goto debug_failed;
-			}
 		} else
 			phba->debug_dumpHBASlim = NULL;
 
@@ -5340,12 +5319,6 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 					S_IFREG|S_IRUGO|S_IWUSR,
 					phba->hba_debugfs_root,
 					phba, &lpfc_debugfs_op_dumpHostSlim);
-			if (!phba->debug_dumpHostSlim) {
-				lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
-						 "0414 Cannot create debugfs "
-						 "dumpHostSlim\n");
-				goto debug_failed;
-			}
 		} else
 			phba->debug_dumpHostSlim = NULL;
 
@@ -5355,11 +5328,6 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 			debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
 				 phba->hba_debugfs_root,
 				 phba, &lpfc_debugfs_op_dumpData);
-		if (!phba->debug_dumpData) {
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
-				"0800 Cannot create debugfs dumpData\n");
-			goto debug_failed;
-		}
 
 		/* Setup dumpDif */
 		snprintf(name, sizeof(name), "dumpDif");
@@ -5367,11 +5335,6 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 			debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
 				 phba->hba_debugfs_root,
 				 phba, &lpfc_debugfs_op_dumpDif);
-		if (!phba->debug_dumpDif) {
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
-				"0801 Cannot create debugfs dumpDif\n");
-			goto debug_failed;
-		}
 
 		/* Setup DIF Error Injections */
 		snprintf(name, sizeof(name), "InjErrLBA");
@@ -5379,11 +5342,6 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 			debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
 			phba->hba_debugfs_root,
 			phba, &lpfc_debugfs_op_dif_err);
-		if (!phba->debug_InjErrLBA) {
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
-				"0807 Cannot create debugfs InjErrLBA\n");
-			goto debug_failed;
-		}
 		phba->lpfc_injerr_lba = LPFC_INJERR_LBA_OFF;
 
 		snprintf(name, sizeof(name), "InjErrNPortID");
@@ -5391,88 +5349,48 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 			debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
 			phba->hba_debugfs_root,
 			phba, &lpfc_debugfs_op_dif_err);
-		if (!phba->debug_InjErrNPortID) {
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
-				"0809 Cannot create debugfs InjErrNPortID\n");
-			goto debug_failed;
-		}
 
 		snprintf(name, sizeof(name), "InjErrWWPN");
 		phba->debug_InjErrWWPN =
 			debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
 			phba->hba_debugfs_root,
 			phba, &lpfc_debugfs_op_dif_err);
-		if (!phba->debug_InjErrWWPN) {
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
-				"0810 Cannot create debugfs InjErrWWPN\n");
-			goto debug_failed;
-		}
 
 		snprintf(name, sizeof(name), "writeGuardInjErr");
 		phba->debug_writeGuard =
 			debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
 			phba->hba_debugfs_root,
 			phba, &lpfc_debugfs_op_dif_err);
-		if (!phba->debug_writeGuard) {
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
-				"0802 Cannot create debugfs writeGuard\n");
-			goto debug_failed;
-		}
 
 		snprintf(name, sizeof(name), "writeAppInjErr");
 		phba->debug_writeApp =
 			debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
 			phba->hba_debugfs_root,
 			phba, &lpfc_debugfs_op_dif_err);
-		if (!phba->debug_writeApp) {
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
-				"0803 Cannot create debugfs writeApp\n");
-			goto debug_failed;
-		}
 
 		snprintf(name, sizeof(name), "writeRefInjErr");
 		phba->debug_writeRef =
 			debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
 			phba->hba_debugfs_root,
 			phba, &lpfc_debugfs_op_dif_err);
-		if (!phba->debug_writeRef) {
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
-				"0804 Cannot create debugfs writeRef\n");
-			goto debug_failed;
-		}
 
 		snprintf(name, sizeof(name), "readGuardInjErr");
 		phba->debug_readGuard =
 			debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
 			phba->hba_debugfs_root,
 			phba, &lpfc_debugfs_op_dif_err);
-		if (!phba->debug_readGuard) {
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
-				"0808 Cannot create debugfs readGuard\n");
-			goto debug_failed;
-		}
 
 		snprintf(name, sizeof(name), "readAppInjErr");
 		phba->debug_readApp =
 			debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
 			phba->hba_debugfs_root,
 			phba, &lpfc_debugfs_op_dif_err);
-		if (!phba->debug_readApp) {
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
-				"0805 Cannot create debugfs readApp\n");
-			goto debug_failed;
-		}
 
 		snprintf(name, sizeof(name), "readRefInjErr");
 		phba->debug_readRef =
 			debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
 			phba->hba_debugfs_root,
 			phba, &lpfc_debugfs_op_dif_err);
-		if (!phba->debug_readRef) {
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
-				"0806 Cannot create debugfs readApp\n");
-			goto debug_failed;
-		}
 
 		/* Setup slow ring trace */
 		if (lpfc_debugfs_max_slow_ring_trc) {
@@ -5496,12 +5414,6 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 			debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
 				 phba->hba_debugfs_root,
 				 phba, &lpfc_debugfs_op_slow_ring_trc);
-		if (!phba->debug_slow_ring_trc) {
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
-					 "0415 Cannot create debugfs "
-					 "slow_ring_trace\n");
-			goto debug_failed;
-		}
 		if (!phba->slow_ring_trc) {
 			phba->slow_ring_trc = kmalloc(
 				(sizeof(struct lpfc_debugfs_trc) *
@@ -5524,11 +5436,6 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 			debugfs_create_file(name, 0644,
 					    phba->hba_debugfs_root,
 					    phba, &lpfc_debugfs_op_nvmeio_trc);
-		if (!phba->debug_nvmeio_trc) {
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
-					 "0574 No create debugfs nvmeio_trc\n");
-			goto debug_failed;
-		}
 
 		atomic_set(&phba->nvmeio_trc_cnt, 0);
 		if (lpfc_debugfs_max_nvmeio_trc) {
@@ -5576,11 +5483,6 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 	if (!vport->vport_debugfs_root) {
 		vport->vport_debugfs_root =
 			debugfs_create_dir(name, phba->hba_debugfs_root);
-		if (!vport->vport_debugfs_root) {
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
-					 "0417 Can't create debugfs\n");
-			goto debug_failed;
-		}
 		atomic_inc(&phba->debugfs_vport_count);
 	}
 
@@ -5617,55 +5519,29 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 		debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
 				 vport->vport_debugfs_root,
 				 vport, &lpfc_debugfs_op_disc_trc);
-	if (!vport->debug_disc_trc) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
-				 "0419 Cannot create debugfs "
-				 "discovery_trace\n");
-		goto debug_failed;
-	}
 	snprintf(name, sizeof(name), "nodelist");
 	vport->debug_nodelist =
 		debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
 				 vport->vport_debugfs_root,
 				 vport, &lpfc_debugfs_op_nodelist);
-	if (!vport->debug_nodelist) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
-				 "2985 Can't create debugfs nodelist\n");
-		goto debug_failed;
-	}
 
 	snprintf(name, sizeof(name), "nvmestat");
 	vport->debug_nvmestat =
 		debugfs_create_file(name, 0644,
 				    vport->vport_debugfs_root,
 				    vport, &lpfc_debugfs_op_nvmestat);
-	if (!vport->debug_nvmestat) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
-				 "0811 Cannot create debugfs nvmestat\n");
-		goto debug_failed;
-	}
 
 	snprintf(name, sizeof(name), "nvmektime");
 	vport->debug_nvmektime =
 		debugfs_create_file(name, 0644,
 				    vport->vport_debugfs_root,
 				    vport, &lpfc_debugfs_op_nvmektime);
-	if (!vport->debug_nvmektime) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
-				 "0815 Cannot create debugfs nvmektime\n");
-		goto debug_failed;
-	}
 
 	snprintf(name, sizeof(name), "cpucheck");
 	vport->debug_cpucheck =
 		debugfs_create_file(name, 0644,
 				    vport->vport_debugfs_root,
 				    vport, &lpfc_debugfs_op_cpucheck);
-	if (!vport->debug_cpucheck) {
-		lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
-				 "0819 Cannot create debugfs cpucheck\n");
-		goto debug_failed;
-	}
 
 	/*
 	 * The following section is for additional directories/files for the
@@ -5685,11 +5561,6 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 	if (!phba->idiag_root) {
 		phba->idiag_root =
 			debugfs_create_dir(name, phba->hba_debugfs_root);
-		if (!phba->idiag_root) {
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
-					 "2922 Can't create idiag debugfs\n");
-			goto debug_failed;
-		}
 		/* Initialize iDiag data structure */
 		memset(&idiag, 0, sizeof(idiag));
 	}
@@ -5700,11 +5571,6 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 		phba->idiag_pci_cfg =
 			debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
 				phba->idiag_root, phba, &lpfc_idiag_op_pciCfg);
-		if (!phba->idiag_pci_cfg) {
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
-					 "2923 Can't create idiag debugfs\n");
-			goto debug_failed;
-		}
 		idiag.offset.last_rd = 0;
 	}
 
@@ -5714,11 +5580,6 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 		phba->idiag_bar_acc =
 			debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
 				phba->idiag_root, phba, &lpfc_idiag_op_barAcc);
-		if (!phba->idiag_bar_acc) {
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
-					"3056 Can't create idiag debugfs\n");
-			goto debug_failed;
-		}
 		idiag.offset.last_rd = 0;
 	}
 
@@ -5728,11 +5589,6 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 		phba->idiag_que_info =
 			debugfs_create_file(name, S_IFREG|S_IRUGO,
 			phba->idiag_root, phba, &lpfc_idiag_op_queInfo);
-		if (!phba->idiag_que_info) {
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
-					 "2924 Can't create idiag debugfs\n");
-			goto debug_failed;
-		}
 	}
 
 	/* iDiag access PCI function queue */
@@ -5741,11 +5597,6 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 		phba->idiag_que_acc =
 			debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
 				phba->idiag_root, phba, &lpfc_idiag_op_queAcc);
-		if (!phba->idiag_que_acc) {
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
-					 "2926 Can't create idiag debugfs\n");
-			goto debug_failed;
-		}
 	}
 
 	/* iDiag access PCI function doorbell registers */
@@ -5754,11 +5605,6 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 		phba->idiag_drb_acc =
 			debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
 				phba->idiag_root, phba, &lpfc_idiag_op_drbAcc);
-		if (!phba->idiag_drb_acc) {
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
-					 "2927 Can't create idiag debugfs\n");
-			goto debug_failed;
-		}
 	}
 
 	/* iDiag access PCI function control registers */
@@ -5767,11 +5613,6 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 		phba->idiag_ctl_acc =
 			debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
 				phba->idiag_root, phba, &lpfc_idiag_op_ctlAcc);
-		if (!phba->idiag_ctl_acc) {
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
-					 "2981 Can't create idiag debugfs\n");
-			goto debug_failed;
-		}
 	}
 
 	/* iDiag access mbox commands */
@@ -5780,11 +5621,6 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 		phba->idiag_mbx_acc =
 			debugfs_create_file(name, S_IFREG|S_IRUGO|S_IWUSR,
 				phba->idiag_root, phba, &lpfc_idiag_op_mbxAcc);
-		if (!phba->idiag_mbx_acc) {
-			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
-					"2980 Can't create idiag debugfs\n");
-			goto debug_failed;
-		}
 	}
 
 	/* iDiag extents access commands */
@@ -5796,12 +5632,6 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 						    S_IFREG|S_IRUGO|S_IWUSR,
 						    phba->idiag_root, phba,
 						    &lpfc_idiag_op_extAcc);
-			if (!phba->idiag_ext_acc) {
-				lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
-						"2986 Cant create "
-						"idiag debugfs\n");
-				goto debug_failed;
-			}
 		}
 	}
 
-- 
2.20.1

