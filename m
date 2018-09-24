Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09317C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE662148C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:27:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFE662148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733306AbeIXS33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:29:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57316 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730233AbeIXS32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:29:28 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1449D1018;
        Mon, 24 Sep 2018 12:27:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 019/235] iommu/io-pgtable-arm: Fix pgtable allocation in selftest
Date:   Mon, 24 Sep 2018 13:50:05 +0200
Message-Id: <20180924113106.524637591@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
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

From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

[ Upstream commit fac83d29d95471ad6a104f8c0d21669a3d59097b ]

Commit 4b123757eeaa ("iommu/io-pgtable-arm: Make allocations
NUMA-aware") added a NUMA hint to page table allocation, but the pgtable
selftest doesn't provide an SMMU device parameter. Since dev_to_node
doesn't accept a NULL argument, add a special case for selftest.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/io-pgtable-arm.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -237,7 +237,8 @@ static void *__arm_lpae_alloc_pages(size
 	void *pages;
 
 	VM_BUG_ON((gfp & __GFP_HIGHMEM));
-	p = alloc_pages_node(dev_to_node(dev), gfp | __GFP_ZERO, order);
+	p = alloc_pages_node(dev ? dev_to_node(dev) : NUMA_NO_NODE,
+			     gfp | __GFP_ZERO, order);
 	if (!p)
 		return NULL;
 


