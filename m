Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B852BECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6EF20C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D6EF20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731125AbeGQLFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 07:05:47 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:53768 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729717AbeGQLFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 07:05:46 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6HATwSP021744;
        Tue, 17 Jul 2018 03:33:45 -0700
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2k7gpg8rta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 17 Jul 2018 03:33:45 -0700
Received: from IL-EXCH03.marvell.com (10.5.102.220) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Tue, 17 Jul
 2018 03:33:42 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by IL-EXCH03.marvell.com
 (10.5.102.220) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Tue, 17 Jul
 2018 13:33:40 +0300
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Tue, 17 Jul 2018 03:33:40 -0700
Received: from hannah.il.marvell.com (unknown [10.4.50.2])
        by maili.marvell.com (Postfix) with ESMTP id A8ECE3F703F;
        Tue, 17 Jul 2018 02:58:20 -0700 (PDT)
From:   <hannah@marvell.com>
To:     <dan.j.williams@intel.com>, <vkoul@kernel.org>,
        <dmaengine@vger.kernel.org>
CC:     <thomas.petazzoni@bootlin.com>, <linux-kernel@vger.kernel.org>,
        <nadavh@marvell.com>, <omrii@marvell.com>, <oferh@marvell.com>,
        <gregory.clement@bootlin.com>, Hanna Hawa <hannah@marvell.com>
Subject: [PATCH 4/5] dmaengine: mv_xor_v2: move unmap to before callback
Date:   Tue, 17 Jul 2018 13:30:02 +0300
Message-ID: <1531823403-3683-5-git-send-email-hannah@marvell.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1531823403-3683-1-git-send-email-hannah@marvell.com>
References: <1531823403-3683-1-git-send-email-hannah@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-17_03:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=866 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807170109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hanna Hawa <hannah@marvell.com>

Completion callback should happen after dma_descriptor_unmap() has
happened. This allow the cache invalidate to happen and ensure that
the data accessed by the upper layer is in memory that was from DMA
rather than stale data. On some architecture this is done by the
hardware, however we should make the code consistent to not cause
confusion.

Signed-off-by: Hanna Hawa <hannah@marvell.com>
Reviewed-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 drivers/dma/mv_xor_v2.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
index 14e2a7a..d41d916 100644
--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -589,10 +589,9 @@ static void mv_xor_v2_tasklet(unsigned long data)
 			 */
 			dma_cookie_complete(&next_pending_sw_desc->async_tx);
 
+			dma_descriptor_unmap(&next_pending_sw_desc->async_tx);
 			dmaengine_desc_get_callback_invoke(
 					&next_pending_sw_desc->async_tx, NULL);
-
-			dma_descriptor_unmap(&next_pending_sw_desc->async_tx);
 		}
 
 		dma_run_dependencies(&next_pending_sw_desc->async_tx);
-- 
1.9.1

