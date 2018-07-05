Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE87C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D378824018
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D378824018
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753677AbeGEQAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:00:51 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:64826 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753317AbeGEQAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:00:49 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w65Fwjed025668;
        Thu, 5 Jul 2018 18:00:47 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2k0dr4hxkw-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 05 Jul 2018 18:00:47 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D8E9738;
        Thu,  5 Jul 2018 16:00:45 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag7node2.st.com [10.75.127.20])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B8DAA29D9;
        Thu,  5 Jul 2018 16:00:45 +0000 (GMT)
Received: from localhost (10.75.127.50) by SFHDAG7NODE2.st.com (10.75.127.20)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 5 Jul 2018 18:00:45
 +0200
From:   Loic Pallardy <loic.pallardy@st.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH 1/1] remoteproc: correct rproc_free_vring() to avoid invalid kernel paging
Date:   Thu, 5 Jul 2018 17:59:13 +0200
Message-ID: <1530806353-13664-1-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG7NODE2.st.com
 (10.75.127.20)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-05_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If rproc_start() failed, rproc_resource_cleanup() is called to clean
debufs entries, then associated iommu mappings, carveouts and vdev.
Issue occurs when rproc_free_vring() is trying to reset vring resource
table entry.
At this time, table_ptr is pointing on loaded resource table and carveouts
amready released, so access to loaded resource table is generating a kernel
paging error:

[   12.696535] Unable to handle kernel paging request at virtual address f0f357cc
[   12.696540] pgd = (ptrval)
[   12.696542] [f0f357cc] *pgd=6d2d0811, *pte=00000000, *ppte=00000000
[   12.696558] Internal error: Oops: 807 [#1] SMP ARM
[   12.696563] Modules linked in: rpmsg_core v4l2_mem2mem videobuf2_dma_contig sti_drm v4l2_common vida
[   12.696598] CPU: 1 PID: 48 Comm: kworker/1:1 Tainted: G        W         4.18.0-rc2-00018-g3170fdd-8
[   12.696602] Hardware name: STi SoC with Flattened Device Tree
[   12.696625] Workqueue: events request_firmware_work_func
[   12.696659] PC is at rproc_free_vring+0x84/0xbc [remoteproc]
[   12.696667] LR is at rproc_free_vring+0x70/0xbc [remoteproc]

This patch proposes to simply remove reset of resource table vring entries,
as firmware and resource table are reloaded at each rproc boot.
rproc_trigger_recovery() not impacted as resources not touched during recovery
procedure.

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
---
 drivers/remoteproc/remoteproc_core.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index a9609d9..9a8b47c 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -289,16 +289,10 @@ void rproc_free_vring(struct rproc_vring *rvring)
 {
 	int size = PAGE_ALIGN(vring_size(rvring->len, rvring->align));
 	struct rproc *rproc = rvring->rvdev->rproc;
-	int idx = rvring->rvdev->vring - rvring;
-	struct fw_rsc_vdev *rsc;
 
 	dma_free_coherent(rproc->dev.parent, size, rvring->va, rvring->dma);
 	idr_remove(&rproc->notifyids, rvring->notifyid);
 
-	/* reset resource entry info */
-	rsc = (void *)rproc->table_ptr + rvring->rvdev->rsc_offset;
-	rsc->vring[idx].da = 0;
-	rsc->vring[idx].notifyid = -1;
 }
 
 static int rproc_vdev_do_probe(struct rproc_subdev *subdev)
-- 
1.9.1

