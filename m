Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA87AC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF80206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218045;
	bh=r7y15Grucrf0LGXelMlve6wIEgUgLw1S8IV4kcReYtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0umFtCKPPp7V4Z5hmYdCSpySHUVT+jwZV5QJBSkOv9g6oh1aMunFDFTjDyb5XSlOK
	 qwM2DGdF5ZWgvTcVZDi34Kb7DLFmbe5uXgMiSzvXkkYlwj7jkm9vgyoIUU//AhwVI1
	 bZl2kuOQK1krpBi7UTc8qRHfffQ610qHGGzMyqe8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391492AbfAKOrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:47:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:38668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391390AbfAKOrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:47:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DDE42063F;
        Fri, 11 Jan 2019 14:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547218040;
        bh=r7y15Grucrf0LGXelMlve6wIEgUgLw1S8IV4kcReYtI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S3KmBYxkV3pb03Q/0J5cWzH6+U/lmsBwLclWG9Ox6Z4czSwQCl7CgyICLvLSwcwTU
         UnV+hlOzDVuw0KXP1hgjbA9NlT6iQa8m8fkqamIRt95KA9zDAqvKPyREdZ7HYBq0us
         NhtjcRjRCPons+PdKiRAxelUIpE5Lcx8Z18h2TLs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Ramos Falcon, Ernesto R" <ernesto.r.ramos.falcon@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 4.4 83/88] iommu/vt-d: Handle domain agaw being less than iommu agaw
Date:   Fri, 11 Jan 2019 15:08:52 +0100
Message-Id: <20190111131059.557465397@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131045.137499039@linuxfoundation.org>
References: <20190111131045.137499039@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sohil Mehta <sohil.mehta@intel.com>

commit 3569dd07aaad71920c5ea4da2d5cc9a167c1ffd4 upstream.

The Intel IOMMU driver opportunistically skips a few top level page
tables from the domain paging directory while programming the IOMMU
context entry. However there is an implicit assumption in the code that
domain's adjusted guest address width (agaw) would always be greater
than IOMMU's agaw.

The IOMMU capabilities in an upcoming platform cause the domain's agaw
to be lower than IOMMU's agaw. The issue is seen when the IOMMU supports
both 4-level and 5-level paging. The domain builds a 4-level page table
based on agaw of 2. However the IOMMU's agaw is set as 3 (5-level). In
this case the code incorrectly tries to skip page page table levels.
This causes the IOMMU driver to avoid programming the context entry. The
fix handles this case and programs the context entry accordingly.

Fixes: de24e55395698 ("iommu/vt-d: Simplify domain_context_mapping_one")
Cc: <stable@vger.kernel.org>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reported-by: Ramos Falcon, Ernesto R <ernesto.r.ramos.falcon@intel.com>
Tested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iommu/intel-iommu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2041,7 +2041,7 @@ static int domain_context_mapping_one(st
 	 * than default.  Unnecessary for PT mode.
 	 */
 	if (translation != CONTEXT_TT_PASS_THROUGH) {
-		for (agaw = domain->agaw; agaw != iommu->agaw; agaw--) {
+		for (agaw = domain->agaw; agaw > iommu->agaw; agaw--) {
 			ret = -ENOMEM;
 			pgd = phys_to_virt(dma_pte_addr(pgd));
 			if (!dma_pte_present(pgd))
@@ -2055,7 +2055,7 @@ static int domain_context_mapping_one(st
 			translation = CONTEXT_TT_MULTI_LEVEL;
 
 		context_set_address_root(context, virt_to_phys(pgd));
-		context_set_address_width(context, iommu->agaw);
+		context_set_address_width(context, agaw);
 	} else {
 		/*
 		 * In pass through mode, AW must be programmed to


