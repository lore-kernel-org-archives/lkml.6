Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C561AC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C7AA20879
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544571;
	bh=9GpkMUc592Vnk4Sgj9ziB7SSs/BHql6+9blfeMSh3lk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Cxi6Xb2Ggir9zorNgBlXKMrHpXcMKl3anhWPkaCLqj0EiWDhC0Yu3w35+jPxHKc6c
	 gzVaE5Y/2p+NJ1Yk3cpIdwpHMwSqbP1JxvrIs/Is0TOw0z47iyWLWq/c8eAppw7nnM
	 NktU6aYR/djAHnnqukIgYvpSIreWL3EJ1oK6Q1vU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C7AA20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730327AbeLKQJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:09:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:41048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729678AbeLKPwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:52:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F104820855;
        Tue, 11 Dec 2018 15:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543541;
        bh=9GpkMUc592Vnk4Sgj9ziB7SSs/BHql6+9blfeMSh3lk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VFzjU3DVn7Q1MAwMhUewZrwP5VsiaIRjq4HR8dMR7p2iHLMeTh0zIRuhl9x8sMydS
         KssshktCplqi7LZ9xoJGxef1Ifts/6d4RAayfKAJ5PPsqKv/2+Rn9TiWQ1CsE2JshI
         WkAJU+jBSRI61YAlogcZWNT8Bc3UgdBJH5ojnHuU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 04/67] iommu/ipmmu-vmsa: Fix crash on early domain free
Date:   Tue, 11 Dec 2018 16:41:04 +0100
Message-Id: <20181211151630.590896600@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151630.378216233@linuxfoundation.org>
References: <20181211151630.378216233@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index 5d0ba5f644c4..777aff1f549f 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -424,6 +424,9 @@ static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
 
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



