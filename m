Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E52C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC892085A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7cVH6Jj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BC892085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729734AbeJYWui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:50:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:60190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727635AbeJYWui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:50:38 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7890C2085A;
        Thu, 25 Oct 2018 14:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477061;
        bh=SrH6G5Mixryhxa9A4qIaRxzPw1XraFOiBgEqT6Sc7Uk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J7cVH6JjaZEB2Yta5c1RUJ+b/BVT8KEALGCcrkUhfdoOOti9YOOLOFhl0IjKZAR9o
         P56kK4onTCF2g/ZAVyq21GeCJhLs3Ca2rESTZ3dGtgyFXyEe9TVZyAKlJuqFWex7ma
         gXdkZ6m3QIi8biMQz111PuslsK3jsdNjHVdecAOo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Raghava Aditya Renukunta <RaghavaAditya.Renukunta@microsemi.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 20/65] aacraid: Start adapter after updating number of MSIX vectors
Date:   Thu, 25 Oct 2018 10:16:20 -0400
Message-Id: <20181025141705.213937-20-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141705.213937-1-sashal@kernel.org>
References: <20181025141705.213937-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raghava Aditya Renukunta <RaghavaAditya.Renukunta@microsemi.com>

[ Upstream commit 116d77fea02e2a5aded7d29ba4c692774cb339f1 ]

The adapter has to be started after updating the number of MSIX Vectors

Fixes: ecc479e00db8 (aacraid: Set correct MSIX count for EEH recovery)
Cc: stable@vger.kernel.org
Signed-off-by: Raghava Aditya Renukunta <RaghavaAditya.Renukunta@microsemi.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/aacraid/linit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c
index 8da8b46da722..1c447405ebbf 100644
--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -1416,8 +1416,8 @@ static int aac_acquire_resources(struct aac_dev *dev)
 		/* After EEH recovery or suspend resume, max_msix count
 		 * may change, therfore updating in init as well.
 		 */
-		aac_adapter_start(dev);
 		dev->init->Sa_MSIXVectors = cpu_to_le32(dev->max_msix);
+		aac_adapter_start(dev);
 	}
 	return 0;
 
-- 
2.17.1

