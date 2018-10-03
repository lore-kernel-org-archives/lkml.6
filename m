Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062CAC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 23:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8620213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 23:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8620213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbeJDGio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 02:38:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:23160 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbeJDGin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 02:38:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2018 16:48:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,338,1534834800"; 
   d="scan'208";a="97224389"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.7.198.152])
  by orsmga002.jf.intel.com with ESMTP; 03 Oct 2018 16:48:08 -0700
Subject: [PATCH] dma-direct: Fix return value of dma_direct_supported
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     iommu@lists.linux-foundation.org
Cc:     benh@kernel.crashing.org, robin.murphy@arm.com,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        linuxppc-dev@lists.ozlabs.org, linux@roeck-us.net
Date:   Wed, 03 Oct 2018 16:48:07 -0700
Message-ID: <20181003234746.3586.42014.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that in commit 9d7a224b463e ("dma-direct: always allow dma mask
<= physiscal memory size") the logic of the test was changed from a "<" to
a ">=" however I don't see any reason for that change. I am assuming that
there was some additional change planned, specifically I suspect the logic
was intended to be reversed and possibly used for a return. Since that is
the case I have gone ahead and done that.

This addresses issues I had on my system that prevented me from booting
with the above mentioned commit applied on an x86_64 system w/ Intel IOMMU.

Fixes: 9d7a224b463e ("dma-direct: always allow dma mask <= physiscal memory size")
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 kernel/dma/direct.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 5a0806b5351b..65872f6c2e93 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -301,9 +301,7 @@ int dma_direct_supported(struct device *dev, u64 mask)
 
 	min_mask = min_t(u64, min_mask, (max_pfn - 1) << PAGE_SHIFT);
 
-	if (mask >= phys_to_dma(dev, min_mask))
-		return 0;
-	return 1;
+	return mask >= phys_to_dma(dev, min_mask);
 }
 
 int dma_direct_mapping_error(struct device *dev, dma_addr_t dma_addr)

