Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09CCC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D9320652
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79D9320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731947AbeIMTLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:11:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35162 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729933AbeIMTLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:11:49 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 91963D2E;
        Thu, 13 Sep 2018 14:02:11 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Suman Anna <s-anna@ti.com>,
        Ralf Goebel <ralf.goebel@imago-technologies.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 115/197] iommu/omap: Fix cache flushes on L2 table entries
Date:   Thu, 13 Sep 2018 15:31:04 +0200
Message-Id: <20180913131846.148475608@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ralf Goebel <ralf.goebel@imago-technologies.com>

[ Upstream commit 04c532a1cdc7e423656c07937aa4b5c1c2b064f9 ]

The base address used for DMA operations on the second-level table
did incorrectly include the offset for the table entry. The offset
was then added again which lead to incorrect behavior.

Operations on the L1 table are not affected.

The calculation of the base address is changed to point to the
beginning of the L2 table.

Fixes: bfee0cf0ee1d ("iommu/omap: Use DMA-API for performing cache flushes")
Acked-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Ralf Goebel <ralf.goebel@imago-technologies.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/omap-iommu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -550,7 +550,7 @@ static u32 *iopte_alloc(struct omap_iomm
 
 pte_ready:
 	iopte = iopte_offset(iopgd, da);
-	*pt_dma = virt_to_phys(iopte);
+	*pt_dma = iopgd_page_paddr(iopgd);
 	dev_vdbg(obj->dev,
 		 "%s: da:%08x pgd:%p *pgd:%08x pte:%p *pte:%08x\n",
 		 __func__, da, iopgd, *iopgd, iopte, *iopte);
@@ -738,7 +738,7 @@ static size_t iopgtable_clear_entry_core
 		}
 		bytes *= nent;
 		memset(iopte, 0, nent * sizeof(*iopte));
-		pt_dma = virt_to_phys(iopte);
+		pt_dma = iopgd_page_paddr(iopgd);
 		flush_iopte_range(obj->dev, pt_dma, pt_offset, nent);
 
 		/*


