Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BF3ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A74E82083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A74E82083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbeJYXEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:04:38 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39062 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbeJYXEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:04:37 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gFgfb-0006Op-Ft; Thu, 25 Oct 2018 14:31:31 +0000
From:   Colin King <colin.king@canonical.com>
To:     Steve Wise <swise@chelsio.com>, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/cxgb3: Fix unintended sign extension
Date:   Thu, 25 Oct 2018 15:31:31 +0100
Message-Id: <20181025143131.4048-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

In the expression "utx_len << 28", utx_len starts as u8, but is promoted
to a signed int, then sign-extended to u64.  If utx_len is 0xf8 or greater
then the sign extension will set all the upper bits of utx_cmd which is
probably not what was intended.  Cast to utx_len to u64  to avoid the sign
extension.

Detected by CoverityScan, CID#138764 ("Unintended sign extension")

Fixes: b038ced7b370 ("RDMA/cxgb3: Add driver for Chelsio T3 RNIC")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/infiniband/hw/cxgb3/cxio_hal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/cxgb3/cxio_hal.c b/drivers/infiniband/hw/cxgb3/cxio_hal.c
index dcb4bba522ba..c5cb80ccc6d6 100644
--- a/drivers/infiniband/hw/cxgb3/cxio_hal.c
+++ b/drivers/infiniband/hw/cxgb3/cxio_hal.c
@@ -647,7 +647,7 @@ static int cxio_hal_ctrl_qp_write_mem(struct cxio_rdev *rdev_p, u32 addr,
 		wqe += (sizeof(struct t3_bypass_wr) >> 3);
 		utx_cmd = (T3_UTX_MEM_WRITE << 28) | (addr + i * 3);
 		utx_cmd <<= 32;
-		utx_cmd |= (utx_len << 28) | ((utx_len << 2) + 1);
+		utx_cmd |= ((u64)utx_len << 28) | ((utx_len << 2) + 1);
 		*wqe = cpu_to_be64(utx_cmd);
 		wqe++;
 		copy_data = (u8 *) data + i * 96;
-- 
2.19.1

