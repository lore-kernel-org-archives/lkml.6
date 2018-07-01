Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6262C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7207524835
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7207524835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031638AbeGAQis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:38:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36756 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031365AbeGAQij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:38:39 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4C3E6AA6;
        Sun,  1 Jul 2018 16:38:38 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.17 049/220] powerpc/powernv/ioda2: Remove redundant free of TCE pages
Date:   Sun,  1 Jul 2018 18:21:13 +0200
Message-Id: <20180701160910.374741835@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Kardashevskiy <aik@ozlabs.ru>

commit 98fd72fe82527fd26618062b60cfd329451f2329 upstream.

When IODA2 creates a PE, it creates an IOMMU table with it_ops::free
set to pnv_ioda2_table_free() which calls pnv_pci_ioda2_table_free_pages().

Since iommu_tce_table_put() calls it_ops::free when the last reference
to the table is released, explicit call to pnv_pci_ioda2_table_free_pages()
is not needed so let's remove it.

This should fix double free in the case of PCI hotuplug as
pnv_pci_ioda2_table_free_pages() does not reset neither
iommu_table::it_base nor ::it_size.

This was not exposed by SRIOV as it uses different code path via
pnv_pcibios_sriov_disable().

IODA1 does not inialize it_ops::free so it does not have this issue.

Fixes: c5f7700bbd2e ("powerpc/powernv: Dynamically release PE")
Cc: stable@vger.kernel.org # v4.8+
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/powernv/pci-ioda.c |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -3642,7 +3642,6 @@ static void pnv_pci_ioda2_release_pe_dma
 		WARN_ON(pe->table_group.group);
 	}
 
-	pnv_pci_ioda2_table_free_pages(tbl);
 	iommu_tce_table_put(tbl);
 }
 


