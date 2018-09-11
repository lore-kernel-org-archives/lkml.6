Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C48C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C57F2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hNEK2DM3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C57F2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbeIKUAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:00:14 -0400
Received: from m12-18.163.com ([220.181.12.18]:41682 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726782AbeIKUAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=koQSiyMj0hIeN4kGUR
        pJB0sAZE4Rshw+VeltyU188Wg=; b=hNEK2DM3AuXGaAnzn1COz3ff0nub9yEKZ/
        2Ky6DgkFjT2hIMDrIx3XRC5wBj8MWvWFo7N8JcPab+sSw1ueeQcIIcb0vemBio7p
        Tg7EV0Tp7GVOyy511kjBdU8MPDYXr6cS2Vzj2BYP/5WGfv9IlcInjD3iJLeHWXUz
        F7MvsKH0A=
Received: from localhost (unknown [183.134.187.192])
        by smtp14 (Coremail) with SMTP id EsCowAAXld2H2Jdbqm3FSw--.23641S5;
        Tue, 11 Sep 2018 23:00:24 +0800 (CST)
From:   jun qian <hangdianqj@163.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        jun qian <hangdianqj@163.com>
Subject: [PATCH] Iommu: ipmmu-vmsa: replace spin_lock_irqsave with spin_lock in ISR
Date:   Tue, 11 Sep 2018 08:00:20 -0700
Message-Id: <20180911150020.53768-1-hangdianqj@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: EsCowAAXld2H2Jdbqm3FSw--.23641S5
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr1rAF4xAFWruFWfWF48Zwb_yoWfCwc_Cr
        WUur97Jr4UCr1Ykr4xKF13uryjkasFvrn7GFy0ga13Z34DX395JrWkX3s5Jry7uF48AasF
        9Fyj9ayxWry2vjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRR66z5UUUUU==
X-Originating-IP: [183.134.187.192]
X-CM-SenderInfo: pkdqwvpldq1yi6rwjhhfrp/1tbiRAm+R1SIX4acCAAAsl
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As you are already in ISR, it is unnecessary to call spin_lock_irqsave.

Signed-off-by: jun qian <hangdianqj@163.com>
---
 drivers/iommu/ipmmu-vmsa.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 22b94f8a9a04..afa23d53502c 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -569,9 +569,8 @@ static irqreturn_t ipmmu_irq(int irq, void *dev)
 	struct ipmmu_vmsa_device *mmu = dev;
 	irqreturn_t status = IRQ_NONE;
 	unsigned int i;
-	unsigned long flags;
 
-	spin_lock_irqsave(&mmu->lock, flags);
+	spin_lock(&mmu->lock);
 
 	/*
 	 * Check interrupts for all active contexts.
@@ -583,7 +582,7 @@ static irqreturn_t ipmmu_irq(int irq, void *dev)
 			status = IRQ_HANDLED;
 	}
 
-	spin_unlock_irqrestore(&mmu->lock, flags);
+	spin_unlock(&mmu->lock);
 
 	return status;
 }
-- 
2.17.1



