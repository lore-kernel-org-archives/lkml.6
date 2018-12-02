Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536BCC64EB4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22DAD20892
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22DAD20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=m3y3r.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725918AbeLBVPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 16:15:00 -0500
Received: from www17.your-server.de ([213.133.104.17]:57418 "EHLO
        www17.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbeLBVPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 16:15:00 -0500
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www17.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <thomas@m3y3r.de>)
        id 1gTYlv-00017P-Fi; Sun, 02 Dec 2018 21:55:23 +0100
Received: from [2a02:908:4c28:3f60:fff6:43c5:695c:41d6] (helo=localhost.localdomain)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <thomas@m3y3r.de>)
        id 1gTYlv-00034a-AR; Sun, 02 Dec 2018 21:55:23 +0100
Subject: [PATCH] scsi: qla2xxx: NULL check before some freeing functions is
 not needed.
From:   Thomas Meyer <thomas@m3y3r.de>
To:     qla2xxx-upstream@qlogic.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Patch: Cocci
X-Mailer: DiffSplit
Message-ID: <1543760930052-275330559-13-diffsplit-thomas@m3y3r.de>
References: <1543760930050-1499171309-0-diffsplit-thomas@m3y3r.de>
In-Reply-To: <1543760930050-1499171309-0-diffsplit-thomas@m3y3r.de>
X-Serial-No: 13
Date:   Sun, 02 Dec 2018 21:52:11 +0100
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: thomas@m3y3r.de
X-Virus-Scanned: Clear (ClamAV 0.100.2/25173/Sun Dec  2 15:13:44 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NULL check before some freeing functions is not needed.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff -u -p a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -4191,12 +4191,10 @@ fail_free_nvram:
 	kfree(ha->nvram);
 	ha->nvram = NULL;
 fail_free_ctx_mempool:
-	if (ha->ctx_mempool)
-		mempool_destroy(ha->ctx_mempool);
+	mempool_destroy(ha->ctx_mempool);
 	ha->ctx_mempool = NULL;
 fail_free_srb_mempool:
-	if (ha->srb_mempool)
-		mempool_destroy(ha->srb_mempool);
+	mempool_destroy(ha->srb_mempool);
 	ha->srb_mempool = NULL;
 fail_free_gid_list:
 	dma_free_coherent(&ha->pdev->dev, qla2x00_gid_list_size(ha),
@@ -4498,8 +4496,7 @@ qla2x00_mem_free(struct qla_hw_data *ha)
 		dma_free_coherent(&ha->pdev->dev, MCTP_DUMP_SIZE, ha->mctp_dump,
 		    ha->mctp_dump_dma);
 
-	if (ha->srb_mempool)
-		mempool_destroy(ha->srb_mempool);
+	mempool_destroy(ha->srb_mempool);
 
 	if (ha->dcbx_tlv)
 		dma_free_coherent(&ha->pdev->dev, DCBX_TLV_DATA_SIZE,
@@ -4531,8 +4528,7 @@ qla2x00_mem_free(struct qla_hw_data *ha)
 	if (ha->async_pd)
 		dma_pool_free(ha->s_dma_pool, ha->async_pd, ha->async_pd_dma);
 
-	if (ha->s_dma_pool)
-		dma_pool_destroy(ha->s_dma_pool);
+	dma_pool_destroy(ha->s_dma_pool);
 
 	if (ha->gid_list)
 		dma_free_coherent(&ha->pdev->dev, qla2x00_gid_list_size(ha),
@@ -4553,14 +4549,11 @@ qla2x00_mem_free(struct qla_hw_data *ha)
 		}
 	}
 
-	if (ha->dl_dma_pool)
-		dma_pool_destroy(ha->dl_dma_pool);
+	dma_pool_destroy(ha->dl_dma_pool);
 
-	if (ha->fcp_cmnd_dma_pool)
-		dma_pool_destroy(ha->fcp_cmnd_dma_pool);
+	dma_pool_destroy(ha->fcp_cmnd_dma_pool);
 
-	if (ha->ctx_mempool)
-		mempool_destroy(ha->ctx_mempool);
+	mempool_destroy(ha->ctx_mempool);
 
 	qlt_mem_free(ha);
 
@@ -7106,8 +7099,7 @@ qla2x00_module_exit(void)
 	qla2x00_release_firmware();
 	kmem_cache_destroy(srb_cachep);
 	qlt_exit();
-	if (ctx_cachep)
-		kmem_cache_destroy(ctx_cachep);
+	kmem_cache_destroy(ctx_cachep);
 	fc_release_transport(qla2xxx_transport_template);
 	fc_release_transport(qla2xxx_transport_vport_template);
 }
