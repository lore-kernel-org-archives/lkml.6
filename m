Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74521ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F3A720854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F3A720854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388265AbeGWN07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:26:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45142 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388151AbeGWN07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:26:59 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9B45FBD4;
        Mon, 23 Jul 2018 12:26:00 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Ewan D. Milne" <emilne@redhat.com>,
        Quinn Tran <quinn.tran@cavium.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        Himanshu Madhani <hmadhani@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.17 02/63] scsi: qla2xxx: Fix inconsistent DMA mem alloc/free
Date:   Mon, 23 Jul 2018 14:24:08 +0200
Message-Id: <20180723122446.456041464@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122446.351334162@linuxfoundation.org>
References: <20180723122446.351334162@linuxfoundation.org>
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

From: Quinn Tran <quin.tran@cavium.com>

commit b5f3bc39a0e815a30005da246dd4ad47fd2f88ff upstream.

GPNFT command allocates 2 buffer for switch query. On completion, the same
buffers were freed using different size, instead of using original size at
the time of allocation.

This patch saves the size of the request and response buffers and uses that
to free them.

Following stack trace can be seen when using debug kernel

dump_stack+0x19/0x1b
__warn+0xd8/0x100
warn_slowpath_fmt+0x5f/0x80
check_unmap+0xfb/0xa20
debug_dma_free_coherent+0x110/0x160
qla24xx_sp_unmap+0x131/0x1e0 [qla2xxx]
qla24xx_async_gnnft_done+0xb6/0x550 [qla2xxx]
qla2x00_do_work+0x1ec/0x9f0 [qla2xxx]

Cc: <stable@vger.kernel.org> # v4.17+
Fixes: 33b28357dd00 ("scsi: qla2xxx: Fix Async GPN_FT for FCP and FC-NVMe scan")
Reported-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Signed-off-by: Himanshu Madhani <hmadhani@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_def.h |    2 ++
 drivers/scsi/qla2xxx/qla_gs.c  |   40 ++++++++++++++++++++++++++--------------
 2 files changed, 28 insertions(+), 14 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -361,6 +361,8 @@ struct ct_arg {
 	dma_addr_t	rsp_dma;
 	u32		req_size;
 	u32		rsp_size;
+	u32		req_allocated_size;
+	u32		rsp_allocated_size;
 	void		*req;
 	void		*rsp;
 	port_id_t	id;
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -556,7 +556,7 @@ err2:
 		/* please ignore kernel warning. otherwise, we have mem leak. */
 		if (sp->u.iocb_cmd.u.ctarg.req) {
 			dma_free_coherent(&vha->hw->pdev->dev,
-			    sizeof(struct ct_sns_pkt),
+			    sp->u.iocb_cmd.u.ctarg.req_allocated_size,
 			    sp->u.iocb_cmd.u.ctarg.req,
 			    sp->u.iocb_cmd.u.ctarg.req_dma);
 			sp->u.iocb_cmd.u.ctarg.req = NULL;
@@ -564,7 +564,7 @@ err2:
 
 		if (sp->u.iocb_cmd.u.ctarg.rsp) {
 			dma_free_coherent(&vha->hw->pdev->dev,
-			    sizeof(struct ct_sns_pkt),
+			    sp->u.iocb_cmd.u.ctarg.rsp_allocated_size,
 			    sp->u.iocb_cmd.u.ctarg.rsp,
 			    sp->u.iocb_cmd.u.ctarg.rsp_dma);
 			sp->u.iocb_cmd.u.ctarg.rsp = NULL;
@@ -617,6 +617,7 @@ static int qla_async_rftid(scsi_qla_host
 	sp->u.iocb_cmd.u.ctarg.req = dma_alloc_coherent(&vha->hw->pdev->dev,
 	    sizeof(struct ct_sns_pkt), &sp->u.iocb_cmd.u.ctarg.req_dma,
 	    GFP_KERNEL);
+	sp->u.iocb_cmd.u.ctarg.req_allocated_size = sizeof(struct ct_sns_pkt);
 	if (!sp->u.iocb_cmd.u.ctarg.req) {
 		ql_log(ql_log_warn, vha, 0xd041,
 		    "%s: Failed to allocate ct_sns request.\n",
@@ -627,6 +628,7 @@ static int qla_async_rftid(scsi_qla_host
 	sp->u.iocb_cmd.u.ctarg.rsp = dma_alloc_coherent(&vha->hw->pdev->dev,
 	    sizeof(struct ct_sns_pkt), &sp->u.iocb_cmd.u.ctarg.rsp_dma,
 	    GFP_KERNEL);
+	sp->u.iocb_cmd.u.ctarg.rsp_allocated_size = sizeof(struct ct_sns_pkt);
 	if (!sp->u.iocb_cmd.u.ctarg.rsp) {
 		ql_log(ql_log_warn, vha, 0xd042,
 		    "%s: Failed to allocate ct_sns request.\n",
@@ -712,6 +714,7 @@ static int qla_async_rffid(scsi_qla_host
 	sp->u.iocb_cmd.u.ctarg.req = dma_alloc_coherent(&vha->hw->pdev->dev,
 	    sizeof(struct ct_sns_pkt), &sp->u.iocb_cmd.u.ctarg.req_dma,
 	    GFP_KERNEL);
+	sp->u.iocb_cmd.u.ctarg.req_allocated_size = sizeof(struct ct_sns_pkt);
 	if (!sp->u.iocb_cmd.u.ctarg.req) {
 		ql_log(ql_log_warn, vha, 0xd041,
 		    "%s: Failed to allocate ct_sns request.\n",
@@ -722,6 +725,7 @@ static int qla_async_rffid(scsi_qla_host
 	sp->u.iocb_cmd.u.ctarg.rsp = dma_alloc_coherent(&vha->hw->pdev->dev,
 	    sizeof(struct ct_sns_pkt), &sp->u.iocb_cmd.u.ctarg.rsp_dma,
 	    GFP_KERNEL);
+	sp->u.iocb_cmd.u.ctarg.rsp_allocated_size = sizeof(struct ct_sns_pkt);
 	if (!sp->u.iocb_cmd.u.ctarg.rsp) {
 		ql_log(ql_log_warn, vha, 0xd042,
 		    "%s: Failed to allocate ct_sns request.\n",
@@ -802,6 +806,7 @@ static int qla_async_rnnid(scsi_qla_host
 	sp->u.iocb_cmd.u.ctarg.req = dma_alloc_coherent(&vha->hw->pdev->dev,
 	    sizeof(struct ct_sns_pkt), &sp->u.iocb_cmd.u.ctarg.req_dma,
 	    GFP_KERNEL);
+	sp->u.iocb_cmd.u.ctarg.req_allocated_size = sizeof(struct ct_sns_pkt);
 	if (!sp->u.iocb_cmd.u.ctarg.req) {
 		ql_log(ql_log_warn, vha, 0xd041,
 		    "%s: Failed to allocate ct_sns request.\n",
@@ -812,6 +817,7 @@ static int qla_async_rnnid(scsi_qla_host
 	sp->u.iocb_cmd.u.ctarg.rsp = dma_alloc_coherent(&vha->hw->pdev->dev,
 	    sizeof(struct ct_sns_pkt), &sp->u.iocb_cmd.u.ctarg.rsp_dma,
 	    GFP_KERNEL);
+	sp->u.iocb_cmd.u.ctarg.rsp_allocated_size = sizeof(struct ct_sns_pkt);
 	if (!sp->u.iocb_cmd.u.ctarg.rsp) {
 		ql_log(ql_log_warn, vha, 0xd042,
 		    "%s: Failed to allocate ct_sns request.\n",
@@ -909,6 +915,7 @@ static int qla_async_rsnn_nn(scsi_qla_ho
 	sp->u.iocb_cmd.u.ctarg.req = dma_alloc_coherent(&vha->hw->pdev->dev,
 	    sizeof(struct ct_sns_pkt), &sp->u.iocb_cmd.u.ctarg.req_dma,
 	    GFP_KERNEL);
+	sp->u.iocb_cmd.u.ctarg.req_allocated_size = sizeof(struct ct_sns_pkt);
 	if (!sp->u.iocb_cmd.u.ctarg.req) {
 		ql_log(ql_log_warn, vha, 0xd041,
 		    "%s: Failed to allocate ct_sns request.\n",
@@ -919,6 +926,7 @@ static int qla_async_rsnn_nn(scsi_qla_ho
 	sp->u.iocb_cmd.u.ctarg.rsp = dma_alloc_coherent(&vha->hw->pdev->dev,
 	    sizeof(struct ct_sns_pkt), &sp->u.iocb_cmd.u.ctarg.rsp_dma,
 	    GFP_KERNEL);
+	sp->u.iocb_cmd.u.ctarg.rsp_allocated_size = sizeof(struct ct_sns_pkt);
 	if (!sp->u.iocb_cmd.u.ctarg.rsp) {
 		ql_log(ql_log_warn, vha, 0xd042,
 		    "%s: Failed to allocate ct_sns request.\n",
@@ -3392,14 +3400,14 @@ void qla24xx_sp_unmap(scsi_qla_host_t *v
 {
 	if (sp->u.iocb_cmd.u.ctarg.req) {
 		dma_free_coherent(&vha->hw->pdev->dev,
-			sizeof(struct ct_sns_pkt),
+			sp->u.iocb_cmd.u.ctarg.req_allocated_size,
 			sp->u.iocb_cmd.u.ctarg.req,
 			sp->u.iocb_cmd.u.ctarg.req_dma);
 		sp->u.iocb_cmd.u.ctarg.req = NULL;
 	}
 	if (sp->u.iocb_cmd.u.ctarg.rsp) {
 		dma_free_coherent(&vha->hw->pdev->dev,
-			sizeof(struct ct_sns_pkt),
+			sp->u.iocb_cmd.u.ctarg.rsp_allocated_size,
 			sp->u.iocb_cmd.u.ctarg.rsp,
 			sp->u.iocb_cmd.u.ctarg.rsp_dma);
 		sp->u.iocb_cmd.u.ctarg.rsp = NULL;
@@ -3600,14 +3608,14 @@ static void qla2x00_async_gpnid_sp_done(
 		/* please ignore kernel warning. otherwise, we have mem leak. */
 		if (sp->u.iocb_cmd.u.ctarg.req) {
 			dma_free_coherent(&vha->hw->pdev->dev,
-				sizeof(struct ct_sns_pkt),
+				sp->u.iocb_cmd.u.ctarg.req_allocated_size,
 				sp->u.iocb_cmd.u.ctarg.req,
 				sp->u.iocb_cmd.u.ctarg.req_dma);
 			sp->u.iocb_cmd.u.ctarg.req = NULL;
 		}
 		if (sp->u.iocb_cmd.u.ctarg.rsp) {
 			dma_free_coherent(&vha->hw->pdev->dev,
-				sizeof(struct ct_sns_pkt),
+				sp->u.iocb_cmd.u.ctarg.rsp_allocated_size,
 				sp->u.iocb_cmd.u.ctarg.rsp,
 				sp->u.iocb_cmd.u.ctarg.rsp_dma);
 			sp->u.iocb_cmd.u.ctarg.rsp = NULL;
@@ -3658,6 +3666,7 @@ int qla24xx_async_gpnid(scsi_qla_host_t
 	sp->u.iocb_cmd.u.ctarg.req = dma_alloc_coherent(&vha->hw->pdev->dev,
 		sizeof(struct ct_sns_pkt), &sp->u.iocb_cmd.u.ctarg.req_dma,
 		GFP_KERNEL);
+	sp->u.iocb_cmd.u.ctarg.req_allocated_size = sizeof(struct ct_sns_pkt);
 	if (!sp->u.iocb_cmd.u.ctarg.req) {
 		ql_log(ql_log_warn, vha, 0xd041,
 		    "Failed to allocate ct_sns request.\n");
@@ -3667,6 +3676,7 @@ int qla24xx_async_gpnid(scsi_qla_host_t
 	sp->u.iocb_cmd.u.ctarg.rsp = dma_alloc_coherent(&vha->hw->pdev->dev,
 		sizeof(struct ct_sns_pkt), &sp->u.iocb_cmd.u.ctarg.rsp_dma,
 		GFP_KERNEL);
+	sp->u.iocb_cmd.u.ctarg.rsp_allocated_size = sizeof(struct ct_sns_pkt);
 	if (!sp->u.iocb_cmd.u.ctarg.rsp) {
 		ql_log(ql_log_warn, vha, 0xd042,
 		    "Failed to allocate ct_sns request.\n");
@@ -4125,14 +4135,14 @@ static void qla2x00_async_gpnft_gnnft_sp
 			 */
 			if (sp->u.iocb_cmd.u.ctarg.req) {
 				dma_free_coherent(&vha->hw->pdev->dev,
-				    sizeof(struct ct_sns_pkt),
+				    sp->u.iocb_cmd.u.ctarg.req_allocated_size,
 				    sp->u.iocb_cmd.u.ctarg.req,
 				    sp->u.iocb_cmd.u.ctarg.req_dma);
 				sp->u.iocb_cmd.u.ctarg.req = NULL;
 			}
 			if (sp->u.iocb_cmd.u.ctarg.rsp) {
 				dma_free_coherent(&vha->hw->pdev->dev,
-				    sizeof(struct ct_sns_pkt),
+				    sp->u.iocb_cmd.u.ctarg.rsp_allocated_size,
 				    sp->u.iocb_cmd.u.ctarg.rsp,
 				    sp->u.iocb_cmd.u.ctarg.rsp_dma);
 				sp->u.iocb_cmd.u.ctarg.rsp = NULL;
@@ -4162,14 +4172,14 @@ static void qla2x00_async_gpnft_gnnft_sp
 		/* please ignore kernel warning. Otherwise, we have mem leak. */
 		if (sp->u.iocb_cmd.u.ctarg.req) {
 			dma_free_coherent(&vha->hw->pdev->dev,
-			    sizeof(struct ct_sns_pkt),
+			    sp->u.iocb_cmd.u.ctarg.req_allocated_size,
 			    sp->u.iocb_cmd.u.ctarg.req,
 			    sp->u.iocb_cmd.u.ctarg.req_dma);
 			sp->u.iocb_cmd.u.ctarg.req = NULL;
 		}
 		if (sp->u.iocb_cmd.u.ctarg.rsp) {
 			dma_free_coherent(&vha->hw->pdev->dev,
-			    sizeof(struct ct_sns_pkt),
+			    sp->u.iocb_cmd.u.ctarg.rsp_allocated_size,
 			    sp->u.iocb_cmd.u.ctarg.rsp,
 			    sp->u.iocb_cmd.u.ctarg.rsp_dma);
 			sp->u.iocb_cmd.u.ctarg.rsp = NULL;
@@ -4264,14 +4274,14 @@ static int qla24xx_async_gnnft(scsi_qla_
 done_free_sp:
 	if (sp->u.iocb_cmd.u.ctarg.req) {
 		dma_free_coherent(&vha->hw->pdev->dev,
-		    sizeof(struct ct_sns_pkt),
+		    sp->u.iocb_cmd.u.ctarg.req_allocated_size,
 		    sp->u.iocb_cmd.u.ctarg.req,
 		    sp->u.iocb_cmd.u.ctarg.req_dma);
 		sp->u.iocb_cmd.u.ctarg.req = NULL;
 	}
 	if (sp->u.iocb_cmd.u.ctarg.rsp) {
 		dma_free_coherent(&vha->hw->pdev->dev,
-		    sizeof(struct ct_sns_pkt),
+		    sp->u.iocb_cmd.u.ctarg.rsp_allocated_size,
 		    sp->u.iocb_cmd.u.ctarg.rsp,
 		    sp->u.iocb_cmd.u.ctarg.rsp_dma);
 		sp->u.iocb_cmd.u.ctarg.rsp = NULL;
@@ -4332,6 +4342,7 @@ int qla24xx_async_gpnft(scsi_qla_host_t
 		sp->u.iocb_cmd.u.ctarg.req = dma_zalloc_coherent(
 			&vha->hw->pdev->dev, sizeof(struct ct_sns_pkt),
 			&sp->u.iocb_cmd.u.ctarg.req_dma, GFP_KERNEL);
+		sp->u.iocb_cmd.u.ctarg.req_allocated_size = sizeof(struct ct_sns_pkt);
 		if (!sp->u.iocb_cmd.u.ctarg.req) {
 			ql_log(ql_log_warn, vha, 0xffff,
 			    "Failed to allocate ct_sns request.\n");
@@ -4349,6 +4360,7 @@ int qla24xx_async_gpnft(scsi_qla_host_t
 		sp->u.iocb_cmd.u.ctarg.rsp = dma_zalloc_coherent(
 			&vha->hw->pdev->dev, rspsz,
 			&sp->u.iocb_cmd.u.ctarg.rsp_dma, GFP_KERNEL);
+		sp->u.iocb_cmd.u.ctarg.rsp_allocated_size = sizeof(struct ct_sns_pkt);
 		if (!sp->u.iocb_cmd.u.ctarg.rsp) {
 			ql_log(ql_log_warn, vha, 0xffff,
 			    "Failed to allocate ct_sns request.\n");
@@ -4408,14 +4420,14 @@ int qla24xx_async_gpnft(scsi_qla_host_t
 done_free_sp:
 	if (sp->u.iocb_cmd.u.ctarg.req) {
 		dma_free_coherent(&vha->hw->pdev->dev,
-		    sizeof(struct ct_sns_pkt),
+		    sp->u.iocb_cmd.u.ctarg.req_allocated_size,
 		    sp->u.iocb_cmd.u.ctarg.req,
 		    sp->u.iocb_cmd.u.ctarg.req_dma);
 		sp->u.iocb_cmd.u.ctarg.req = NULL;
 	}
 	if (sp->u.iocb_cmd.u.ctarg.rsp) {
 		dma_free_coherent(&vha->hw->pdev->dev,
-		    sizeof(struct ct_sns_pkt),
+		    sp->u.iocb_cmd.u.ctarg.rsp_allocated_size,
 		    sp->u.iocb_cmd.u.ctarg.rsp,
 		    sp->u.iocb_cmd.u.ctarg.rsp_dma);
 		sp->u.iocb_cmd.u.ctarg.rsp = NULL;


