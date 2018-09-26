Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94E5C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E68620684
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:26:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E68620684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbeIZSi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:38:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45617 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbeIZSi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 14:38:59 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1g58tN-0003mT-6r; Wed, 26 Sep 2018 12:26:09 +0000
From:   Colin King <colin.king@canonical.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] IB/mthca: remove redundant inner check of mdev->mthca_flags
Date:   Wed, 26 Sep 2018 13:26:08 +0100
Message-Id: <20180926122608.29853-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The inner check for mdev->mthca_flags & MTHCA_FLAG_MSI_X is redundant
as this is already true because of the previous identical check in
an outer if statement.  Remove it

Detected by cppcheck:
(warning) Identical inner 'if' condition is always true.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/infiniband/hw/mthca/mthca_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mthca/mthca_main.c b/drivers/infiniband/hw/mthca/mthca_main.c
index f3e80dec1334..f99c7e0b234c 100644
--- a/drivers/infiniband/hw/mthca/mthca_main.c
+++ b/drivers/infiniband/hw/mthca/mthca_main.c
@@ -1014,8 +1014,7 @@ static int __mthca_init_one(struct pci_dev *pdev, int hca_type)
 
 	err = mthca_setup_hca(mdev);
 	if (err == -EBUSY && (mdev->mthca_flags & MTHCA_FLAG_MSI_X)) {
-		if (mdev->mthca_flags & MTHCA_FLAG_MSI_X)
-			pci_free_irq_vectors(pdev);
+		pci_free_irq_vectors(pdev);
 		mdev->mthca_flags &= ~MTHCA_FLAG_MSI_X;
 
 		err = mthca_setup_hca(mdev);
-- 
2.17.1

