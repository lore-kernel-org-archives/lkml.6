Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D58C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8840D206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730560AbeLNSbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 13:31:35 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39368 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730307AbeLNSbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 13:31:35 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gXsF8-0000G2-Qv; Fri, 14 Dec 2018 18:31:22 +0000
From:   Colin King <colin.king@canonical.com>
To:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] nvmet: fix comparison of a u16 with -1
Date:   Fri, 14 Dec 2018 18:31:21 +0000
Message-Id: <20181214183121.17445-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the u16 req->error_loc is being compared to -1 which
will always be false.  Fix this by casting -1 to u16 to fix this.

Detected by clang:
  warning: result of comparison of constant -1 with expression of
  type 'u16' (aka 'unsigned short') is always false
  [-Wtautological-constant-out-of-range-compare]

Fixes: 76574f37bf4c ("nvmet: add interface to update error-log page")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/nvme/target/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index cc81d0231587..b9c219c931eb 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -663,7 +663,7 @@ static void nvmet_set_error(struct nvmet_req *req, u16 status)
 
 	req->rsp->status = cpu_to_le16(status << 1);
 
-	if (!ctrl || req->error_loc == -1)
+	if (!ctrl || req->error_loc == (u16)-1)
 		return;
 
 	spin_lock_irqsave(&ctrl->error_lock, flags);
-- 
2.19.1

