Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF161C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962052403D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:02:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 962052403D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753811AbeGELBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 07:01:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:59886 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753598AbeGELBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 07:01:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 14DD0AFA9;
        Thu,  5 Jul 2018 11:01:43 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 2/4] scsi: bfa: remove ScsiResult macro
Date:   Thu,  5 Jul 2018 13:01:38 +0200
Message-Id: <20180705110140.19545-3-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180705110140.19545-1-jthumshirn@suse.de>
References: <20180705110140.19545-1-jthumshirn@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the ScsiResult macro and open code it on all call sites.

This will make subsequent refactoring in this area easier.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/scsi/bfa/bfad_im.c | 19 ++++++++-----------
 drivers/scsi/bfa/bfad_im.h |  1 -
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/bfa/bfad_im.c b/drivers/scsi/bfa/bfad_im.c
index c05d6e91e4bd..c4a33317d344 100644
--- a/drivers/scsi/bfa/bfad_im.c
+++ b/drivers/scsi/bfa/bfad_im.c
@@ -70,21 +70,18 @@ bfa_cb_ioim_done(void *drv, struct bfad_ioim_s *dio,
 				host_status = DID_ERROR;
 			}
 		}
-		cmnd->result = ScsiResult(host_status, scsi_status);
+		cmnd->result = host_status << 16 | scsi_status;
 
 		break;
 
 	case BFI_IOIM_STS_TIMEDOUT:
-		host_status = DID_TIME_OUT;
-		cmnd->result = ScsiResult(host_status, 0);
+		cmnd->result = DID_TIME_OUT << 16;
 		break;
 	case BFI_IOIM_STS_PATHTOV:
-		host_status = DID_TRANSPORT_DISRUPTED;
-		cmnd->result = ScsiResult(host_status, 0);
+		cmnd->result = DID_TRANSPORT_DISRUPTED << 16;
 		break;
 	default:
-		host_status = DID_ERROR;
-		cmnd->result = ScsiResult(host_status, 0);
+		cmnd->result = DID_ERROR << 16;
 	}
 
 	/* Unmap DMA, if host is NULL, it means a scsi passthru cmd */
@@ -117,7 +114,7 @@ bfa_cb_ioim_good_comp(void *drv, struct bfad_ioim_s *dio)
 	struct bfad_itnim_data_s *itnim_data;
 	struct bfad_itnim_s *itnim;
 
-	cmnd->result = ScsiResult(DID_OK, SCSI_STATUS_GOOD);
+	cmnd->result = DID_OK << 16 | SCSI_STATUS_GOOD;
 
 	/* Unmap DMA, if host is NULL, it means a scsi passthru cmd */
 	if (cmnd->device->host != NULL)
@@ -144,7 +141,7 @@ bfa_cb_ioim_abort(void *drv, struct bfad_ioim_s *dio)
 	struct scsi_cmnd *cmnd = (struct scsi_cmnd *)dio;
 	struct bfad_s         *bfad = drv;
 
-	cmnd->result = ScsiResult(DID_ERROR, 0);
+	cmnd->result = DID_ERROR << 16;
 
 	/* Unmap DMA, if host is NULL, it means a scsi passthru cmd */
 	if (cmnd->device->host != NULL)
@@ -1253,14 +1250,14 @@ bfad_im_queuecommand_lck(struct scsi_cmnd *cmnd, void (*done) (struct scsi_cmnd
 		printk(KERN_WARNING
 			"bfad%d, queuecommand %p %x failed, BFA stopped\n",
 		       bfad->inst_no, cmnd, cmnd->cmnd[0]);
-		cmnd->result = ScsiResult(DID_NO_CONNECT, 0);
+		cmnd->result = DID_NO_CONNECT << 16;
 		goto out_fail_cmd;
 	}
 
 
 	itnim = itnim_data->itnim;
 	if (!itnim) {
-		cmnd->result = ScsiResult(DID_IMM_RETRY, 0);
+		cmnd->result = DID_IMM_RETRY << 16;
 		goto out_fail_cmd;
 	}
 
diff --git a/drivers/scsi/bfa/bfad_im.h b/drivers/scsi/bfa/bfad_im.h
index af66275570c3..e61ed8dad0b4 100644
--- a/drivers/scsi/bfa/bfad_im.h
+++ b/drivers/scsi/bfa/bfad_im.h
@@ -44,7 +44,6 @@ u32 bfad_im_supported_speeds(struct bfa_s *bfa);
 #define MAX_FCP_LUN 16384
 #define BFAD_TARGET_RESET_TMO 60
 #define BFAD_LUN_RESET_TMO 60
-#define ScsiResult(host_code, scsi_code) (((host_code) << 16) | scsi_code)
 #define BFA_QUEUE_FULL_RAMP_UP_TIME 120
 
 /*
-- 
2.16.4

