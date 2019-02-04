Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C2EC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AED4217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277531;
	bh=bQ1wX3H2egCsMNL6MeTimrYFJMik/CI0G0t7mZ8O53U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aqpbu1q8i827CPqzo9ZJL7HmfH1Jexvj2JeA+R8UtK6tjMO0HkZ0rkiVSwhhJphMY
	 zc71IhEgvtkix9wVEjNMmrstxqv8QElUxKBlbhkhEgi8ZxcTQ03oq4f5pUHFobzhHp
	 KZQ9nQrJzMUGaHuY9gu6wRKDmmIhdCpX0NqoY5Dk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732539AbfBDKwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:52:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:49834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732521AbfBDKwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:52:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B43842070C;
        Mon,  4 Feb 2019 10:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277525;
        bh=bQ1wX3H2egCsMNL6MeTimrYFJMik/CI0G0t7mZ8O53U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mu6Ok/vTA2gkBzaMKbqrXZeyW57t1JZakIjmgAo608aS4+5dbzUXyOqmPrpbpufli
         9xCA/MZE8X03AbN+TFDHuc6PpK2n5trS+eh5DfDtvEy9n3jf1Nzm+5I72vV8NG5ziJ
         x26bA9TfpJt6ngqi5FgkCyl6v8ysIdFgHCf6xVzA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Eric Auger <eric.auger@redhat.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 4.20 41/80] iommu/vt-d: Fix memory leak in intel_iommu_put_resv_regions()
Date:   Mon,  4 Feb 2019 11:37:01 +0100
Message-Id: <20190204103625.703001782@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103620.287366543@linuxfoundation.org>
References: <20190204103620.287366543@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gerald Schaefer <gerald.schaefer@de.ibm.com>

commit 198bc3252ea3a45b0c5d500e6a5b91cfdd08f001 upstream.

Commit 9d3a4de4cb8d ("iommu: Disambiguate MSI region types") changed
the reserved region type in intel_iommu_get_resv_regions() from
IOMMU_RESV_RESERVED to IOMMU_RESV_MSI, but it forgot to also change
the type in intel_iommu_put_resv_regions().

This leads to a memory leak, because now the check in
intel_iommu_put_resv_regions() for IOMMU_RESV_RESERVED will never
be true, and no allocated regions will be freed.

Fix this by changing the region type in intel_iommu_put_resv_regions()
to IOMMU_RESV_MSI, matching the type of the allocated regions.

Fixes: 9d3a4de4cb8d ("iommu: Disambiguate MSI region types")
Cc: <stable@vger.kernel.org> # v4.11+
Signed-off-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iommu/intel-iommu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5204,7 +5204,7 @@ static void intel_iommu_put_resv_regions
 	struct iommu_resv_region *entry, *next;
 
 	list_for_each_entry_safe(entry, next, head, list) {
-		if (entry->type == IOMMU_RESV_RESERVED)
+		if (entry->type == IOMMU_RESV_MSI)
 			kfree(entry);
 	}
 }


