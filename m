Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CC5C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CBDB2146D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543380;
	bh=wOd/Ml20No4T5bFzaBjvSB/dhXDhBhLauyZ2NmJ/W2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oX4HnADJ3kSPrns7DmZglgiLl52M1JIrfh3a6ZYbWvAcgKH/jVZfRhT8sgYRoGdzM
	 4I8gwK5r10QwsmRNIJ1sYZExkr4o9BCJl3U9A0ED02gAfciEQGrfKHCLD70+BbeU9G
	 LzYpd31HbHL+QI2mXZSIbN8rpLBjIWHwwjJy9pOs=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CBDB2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbeLKPtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:49:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:37888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729064AbeLKPtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:49:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D720220989;
        Tue, 11 Dec 2018 15:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543370;
        bh=wOd/Ml20No4T5bFzaBjvSB/dhXDhBhLauyZ2NmJ/W2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fFXsajm8SPq+7lELla65w82PoEQwqk+H1hfMaW1mp07RCTUT3nFJyGsXxR4fw+H/m
         HR8nJtOOPnlxa1ro669bqQeENd8mbpYna0ymcJQdPCL0FQU/a0nmzKr/Jak/qbjF6T
         o56SaE50oS3VIShjymulaBuQ9RvhOnjvge5gJgLs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 04/51] iommu/ipmmu-vmsa: Fix crash on early domain free
Date:   Tue, 11 Dec 2018 16:41:12 +0100
Message-Id: <20181211151612.838723292@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151612.328911565@linuxfoundation.org>
References: <20181211151612.328911565@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit e5b78f2e349eef5d4fca5dc1cf5a3b4b2cc27abd ]

If iommu_ops.add_device() fails, iommu_ops.domain_free() is still
called, leading to a crash, as the domain was only partially
initialized:

    ipmmu-vmsa e67b0000.mmu: Cannot accommodate DMA translation for IOMMU page tables
    sata_rcar ee300000.sata: Unable to initialize IPMMU context
    iommu: Failed to add device ee300000.sata to group 0: -22
    Unable to handle kernel NULL pointer dereference at virtual address 0000000000000038
    ...
    Call trace:
     ipmmu_domain_free+0x1c/0xa0
     iommu_group_release+0x48/0x68
     kobject_put+0x74/0xe8
     kobject_del.part.0+0x3c/0x50
     kobject_put+0x60/0xe8
     iommu_group_get_for_dev+0xa8/0x1f0
     ipmmu_add_device+0x1c/0x40
     of_iommu_configure+0x118/0x190

Fix this by checking if the domain's context already exists, before
trying to destroy it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Fixes: d25a2a16f0889 ('iommu: Add driver for Renesas VMSA-compatible IPMMU')
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/ipmmu-vmsa.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 85b5e75c7faa..3d2e9ca78f02 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -372,6 +372,9 @@ static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
 
 static void ipmmu_domain_destroy_context(struct ipmmu_vmsa_domain *domain)
 {
+	if (!domain->mmu)
+		return;
+
 	/*
 	 * Disable the context. Flush the TLB as required when modifying the
 	 * context registers.
-- 
2.19.1



