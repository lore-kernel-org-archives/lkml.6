Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FB9C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B5F62172F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B5F62172F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389949AbeHGVIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:08:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33050 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388481AbeHGVIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:08:20 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 336DD3EE;
        Tue,  7 Aug 2018 18:52:37 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Quinn Tran <quinn.tran@cavium.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.17 01/18] scsi: qla2xxx: Fix unintialized List head crash
Date:   Tue,  7 Aug 2018 20:51:04 +0200
Message-Id: <20180807172313.016441284@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807172312.964272530@linuxfoundation.org>
References: <20180807172312.964272530@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <quinn.tran@cavium.com>

commit e3dde080ebbdbb4bda8eee35d770714fee8c59ac upstream.

In case of IOCB Queue full or system where memory is low and driver
receives large number of RSCN storm, the stale sp pointer can stay on
gpnid_list resulting in page_fault.

This patch fixes this issue by initializing the sp->elem list head and
removing sp->elem before memory is freed.

Following stack trace is seen

 9 [ffff987b37d1bc60] page_fault at ffffffffad516768 [exception RIP: qla24xx_async_gpnid+496]
10 [ffff987b37d1bd10] qla24xx_async_gpnid at ffffffffc039866d [qla2xxx]
11 [ffff987b37d1bd80] qla2x00_do_work at ffffffffc036169c [qla2xxx]
12 [ffff987b37d1be38] qla2x00_do_dpc_all_vps at ffffffffc03adfed [qla2xxx]
13 [ffff987b37d1be78] qla2x00_do_dpc at ffffffffc036458a [qla2xxx]
14 [ffff987b37d1bec8] kthread at ffffffffacebae31

Fixes: 2d73ac6102d9 ("scsi: qla2xxx: Serialize GPNID for multiple RSCN")
Cc: <stable@vger.kernel.org> # v4.17+
Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_gs.c     |    4 ++++
 drivers/scsi/qla2xxx/qla_inline.h |    2 ++
 2 files changed, 6 insertions(+)

--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -3712,6 +3712,10 @@ int qla24xx_async_gpnid(scsi_qla_host_t
 	return rval;
 
 done_free_sp:
+	spin_lock_irqsave(&vha->hw->vport_slock, flags);
+	list_del(&sp->elem);
+	spin_unlock_irqrestore(&vha->hw->vport_slock, flags);
+
 	if (sp->u.iocb_cmd.u.ctarg.req) {
 		dma_free_coherent(&vha->hw->pdev->dev,
 			sizeof(struct ct_sns_pkt),
--- a/drivers/scsi/qla2xxx/qla_inline.h
+++ b/drivers/scsi/qla2xxx/qla_inline.h
@@ -222,6 +222,8 @@ qla2xxx_get_qpair_sp(struct qla_qpair *q
 	sp->fcport = fcport;
 	sp->iocbs = 1;
 	sp->vha = qpair->vha;
+	INIT_LIST_HEAD(&sp->elem);
+
 done:
 	if (!sp)
 		QLA_QPAIR_MARK_NOT_BUSY(qpair);


