Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472D1ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E622146D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07E622146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732598AbeIRElx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:41:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50728 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728850AbeIRElw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:41:52 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 01467C49;
        Mon, 17 Sep 2018 23:12:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Huaisheng Ye <yehs1@lenovo.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 104/158] tools/testing/nvdimm: kaddr and pfn can be NULL to ->direct_access()
Date:   Tue, 18 Sep 2018 00:42:14 +0200
Message-Id: <20180917211716.102549525@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
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

From: Huaisheng Ye <yehs1@lenovo.com>

[ Upstream commit 45df5d3dc0c7289c1e67afe6d2ba806ad5174314 ]

The mock / test version of pmem_direct_access() needs to check the
validity of pointers kaddr and pfn for NULL assignment. If anyone
equals to NULL, it doesn't need to calculate the value.

If pointer equals to NULL, that is to say callers may have no need for
kaddr or pfn, so this patch is prepared for allowing them to pass in
NULL instead of having to pass in a local pointer or variable that
they then just throw away.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
Reviewed-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/nvdimm/pmem-dax.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/tools/testing/nvdimm/pmem-dax.c
+++ b/tools/testing/nvdimm/pmem-dax.c
@@ -31,17 +31,21 @@ long __pmem_direct_access(struct pmem_de
 	if (get_nfit_res(pmem->phys_addr + offset)) {
 		struct page *page;
 
-		*kaddr = pmem->virt_addr + offset;
+		if (kaddr)
+			*kaddr = pmem->virt_addr + offset;
 		page = vmalloc_to_page(pmem->virt_addr + offset);
-		*pfn = page_to_pfn_t(page);
+		if (pfn)
+			*pfn = page_to_pfn_t(page);
 		pr_debug_ratelimited("%s: pmem: %p pgoff: %#lx pfn: %#lx\n",
 				__func__, pmem, pgoff, page_to_pfn(page));
 
 		return 1;
 	}
 
-	*kaddr = pmem->virt_addr + offset;
-	*pfn = phys_to_pfn_t(pmem->phys_addr + offset, pmem->pfn_flags);
+	if (kaddr)
+		*kaddr = pmem->virt_addr + offset;
+	if (pfn)
+		*pfn = phys_to_pfn_t(pmem->phys_addr + offset, pmem->pfn_flags);
 
 	/*
 	 * If badblocks are present, limit known good range to the


