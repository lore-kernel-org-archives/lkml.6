Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BE4C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB5021104
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543735;
	bh=gMjN66IapqfY7UfOjMi/Bd4081i+mXDbfJAqTgTlMd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RZjin5Q0zeFIh2a3SsGdV+WxZLcsd8QX3xLI7i4swUc2GHpFXnfOf1SYI7Y0S50/e
	 UvdOaV8pAywKc2YgXx4hKRquonh+Rgu7T0qCX3qUWiE3IQcj/ufxOTGoLhncsfywAp
	 aYpxua/02RZC7+2fJJ88tbxj/ssN6y6dGJ2LE34M=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CB5021104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbeLKPze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:55:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:44146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730132AbeLKPz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:55:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 915C1205C9;
        Tue, 11 Dec 2018 15:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543727;
        bh=gMjN66IapqfY7UfOjMi/Bd4081i+mXDbfJAqTgTlMd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HqvuYIiKQpk+iqYmKbpo4sh6GCSqAKXaD+THp/1N7IDwwETvn6lf6oS53JUm+UMTh
         pFwqu/QFF5yQFIScBeDXSOTZsZaUFCn5xAHUua1nGkS+Zld2ob9bkNUc6UQwB+zoEP
         sXhcYJ4UP4yre6ec6mhN93QT4Aq2r2KNXFZBen5Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 008/118] iommu/ipmmu-vmsa: Fix crash on early domain free
Date:   Tue, 11 Dec 2018 16:40:27 +0100
Message-Id: <20181211151644.564364796@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index 22b94f8a9a04..d8598e44e381 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -501,6 +501,9 @@ static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
 
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



