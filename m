Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B57C28CF8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 03:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7689E2098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 03:15:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7689E2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbeJLKp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 06:45:27 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36459 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726034AbeJLKp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 06:45:27 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9F51D38FA8176;
        Fri, 12 Oct 2018 11:15:09 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.399.0; Fri, 12 Oct 2018 11:14:54 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <sudeep.dutt@intel.com>, <ashutosh.dixit@intel.com>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>, <mhocko@suse.com>,
        <akpm@linux-foundation.org>, <leon@kernel.org>,
        <natechancellor@gmail.com>, <christian.koenig@amd.com>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] misc: mic: scif: remove set but not used variables 'src_dma_addr, dst_dma_addr'
Date:   Fri, 12 Oct 2018 03:25:56 +0000
Message-ID: <1539314756-154517-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/misc/mic/scif/scif_dma.c: In function 'scif_rma_list_dma_copy_wrapper':
drivers/misc/mic/scif/scif_dma.c:1558:27: warning:
 variable 'dst_dma_addr' set but not used [-Wunused-but-set-variable]

drivers/misc/mic/scif/scif_dma.c:1558:13: warning:
 variable 'src_dma_addr' set but not used [-Wunused-but-set-variable]

They never used since introduction in
commit 7cc31cd27752 ("misc: mic: SCIF DMA and CPU copy interface")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/misc/mic/scif/scif_dma.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/misc/mic/scif/scif_dma.c b/drivers/misc/mic/scif/scif_dma.c
index 03af8b5..2babbac 100644
--- a/drivers/misc/mic/scif/scif_dma.c
+++ b/drivers/misc/mic/scif/scif_dma.c
@@ -1555,7 +1555,6 @@ static int scif_rma_list_dma_copy_wrapper(struct scif_endpt *epd,
 	u8 *temp = NULL;
 	bool src_local = true;
 	struct scif_dma_comp_cb *comp_cb;
-	dma_addr_t src_dma_addr, dst_dma_addr;
 	int err;
 
 	if (is_dma_copy_aligned(chan->device, 1, 1, 1))
@@ -1569,8 +1568,6 @@ static int scif_rma_list_dma_copy_wrapper(struct scif_endpt *epd,
 
 	if (work->loopback)
 		return scif_rma_list_cpu_copy(work);
-	src_dma_addr = __scif_off_to_dma_addr(work->src_window, src_offset);
-	dst_dma_addr = __scif_off_to_dma_addr(work->dst_window, dst_offset);
 	src_local = work->src_window->type == SCIF_WINDOW_SELF;
 
 	/* Allocate dma_completion cb */

