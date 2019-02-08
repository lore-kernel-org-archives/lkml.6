Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB37C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4492146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="OVNZTPov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbfBHOFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:05:02 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34438 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbfBHOFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 09:05:02 -0500
Received: by mail-ed1-f67.google.com with SMTP id b3so2890772ede.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 06:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tcd-ie.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T4GGmSqFHCEpDKP6XeYz/sLJBNs+ap4xefm+Bcu+1Eg=;
        b=OVNZTPovlxog/XSmPFgB3E3sHY7h73V1i+Fg437840qXm1se9fPGX9BsQnZGU4iyPZ
         IOUc9iPnNEkAaeG6qBEgA5WqlVTCpk1DpFf781itckHBpKR1LCIXfTJT3MbgfgYB0aP4
         bZFCg7XCU/OWcTDeKMCCBT479ukcwK2o9RjywOItH8yE+zyV2bEOHVICsZZQdUf+FrsV
         2QTW2LlRi1SMWqGzeaBL2e1Y53n5XqqMMDeQGWdxXhU75KPBuT6950TgxxcT3vJgUEfX
         /e4+SYvSE/eQXSfC9meIsUcGGzKwdHhh17Vd1iN1nan7aQS/ltvvWCRuiHV15iTrXtlr
         LUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T4GGmSqFHCEpDKP6XeYz/sLJBNs+ap4xefm+Bcu+1Eg=;
        b=IBX13ThhjqQwwFNwcWhDrkRed/WN5gAkAJbs9mggmEeV5HDRJtWZHw08SvNmi4rKWD
         x3CKPtmozRc4ShLaFfOAufjRnxGXE5VqcniZPuaWY151cqx/NqQPBxH7op69OIAh+mIR
         pwaREyAj/ZnH5wsohOK56c9i6s4iLBS3bCBFPasCrq7tkruyFu36KhEIsVC9POZxEDV0
         Evx3Gy/HD0ttipS13HoNcTWX0AU6bQkAVUondCfvCABUhB1K13Aqqbci/MiBsgY/3M0q
         avuIHYMoufHLGh+rMUap13j9lZXtNo+DSQxS94aEmKAdgzkBvRposED+oga0k1fs7Y4Y
         qDyg==
X-Gm-Message-State: AHQUAubk3ZlNVgr3+jma4mMIzmDIp45sezbjjDcDRtUq5ABKSmFPUIZn
        8oOlDa28hUA69mQ2Q5rpoWeSwVDHgb8=
X-Google-Smtp-Source: AHgI3IZ999E+6gL8f0/doKau4oTMlU0sTF0QeGAiDA/QlpmrUo7ySsGOMuOUey/Jn6jPXqLQDclBGg==
X-Received: by 2002:a17:906:4306:: with SMTP id j6mr7390206ejm.174.1549634700214;
        Fri, 08 Feb 2019 06:05:00 -0800 (PST)
Received: from linux-ThinkPad-X1-Carbon-5th.Hitronhub.home ([80.111.101.37])
        by smtp.gmail.com with ESMTPSA id k17sm630337edr.59.2019.02.08.06.04.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 06:04:59 -0800 (PST)
From:   Tom Murphy <murphyt7@tcd.ie>
Cc:     Tom Murphy <murphyt7@tcd.ie>, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] remove unused end_pfn
Date:   Fri,  8 Feb 2019 14:04:38 +0000
Message-Id: <20190208140439.26738-1-murphyt7@tcd.ie>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <2017datesandletters@somehostname>
References: <2017datesandletters@somehostname>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This variable is useless.

---
 drivers/iommu/dma-iommu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 8e04b0603a4a..eff301d5e496 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -291,7 +291,7 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 {
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
-	unsigned long order, base_pfn, end_pfn;
+	unsigned long order, base_pfn;
 	int attr;
 
 	if (!cookie || cookie->type != IOMMU_DMA_IOVA_COOKIE)
@@ -300,7 +300,6 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	/* Use the smallest supported page size for IOVA granularity */
 	order = __ffs(domain->pgsize_bitmap);
 	base_pfn = max_t(unsigned long, 1, base >> order);
-	end_pfn = (base + size - 1) >> order;
 
 	/* Check the domain allows at least some access to the device... */
 	if (domain->geometry.force_aperture) {
-- 
2.17.1

