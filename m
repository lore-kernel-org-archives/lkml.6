Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D23DC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C639121741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548694861;
	bh=wTREkN/q9OC/o0xielMClZHEc1DD2924xaQddasG0wg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jsHf2f0r0Ywg3JAMpbQQ+xs9zjY8F8R36W6X0Tz5dxR/h90X5yfzmS7TSbw0kOxdg
	 8HqJOyjH6ws8Zd9/DcMQK6N0/EfOIvtK7yLgrD6KFelrlxNnujt0yhENcRqk+oR+31
	 hF1IHZg/LGSEG97WdF9ferdz9VEMigVYSDlnR+Go=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387781AbfA1QPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:15:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:45072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387768AbfA1QPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:15:17 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 517BD2147A;
        Mon, 28 Jan 2019 16:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692116;
        bh=wTREkN/q9OC/o0xielMClZHEc1DD2924xaQddasG0wg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hU8P0IiAexkIRJEB9LgWvVgnYxe3J+yteRWImxyhB8joRS3kG5r2BAYDM2ULqo6sQ
         FpUW9lx3svBtZpYzaIrFUmEt+DRtH1HJZk1+tksGo+TBvwzkb++xGC7RI29LbNiXLA
         xH6kwfuyuTkhGOA8hp3vfXEbnnLjZnzhy/pNMWvE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yu Zhao <yuzhao@google.com>, Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 4.14 075/170] iommu/amd: Fix amd_iommu=force_isolation
Date:   Mon, 28 Jan 2019 11:10:25 -0500
Message-Id: <20190128161200.55107-75-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Zhao <yuzhao@google.com>

[ Upstream commit c12b08ebbe16f0d3a96a116d86709b04c1ee8e74 ]

The parameter is still there but it's ignored. We need to check its
value before deciding to go into passthrough mode for AMD IOMMU v2
capable device.

We occasionally use this parameter to force v2 capable device into
translation mode to debug memory corruption that we suspect is
caused by DMA writes.

To address the following comment from Joerg Roedel on the first
version, v2 capability of device is completely ignored.
> This breaks the iommu_v2 use-case, as it needs a direct mapping for the
> devices that support it.

And from Documentation/admin-guide/kernel-parameters.txt:
  This option does not override iommu=pt

Fixes: aafd8ba0ca74 ("iommu/amd: Implement add_device and remove_device")

Signed-off-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd_iommu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index efa6cd2500b9..766103ea237e 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -442,7 +442,14 @@ static int iommu_init_device(struct device *dev)
 
 	dev_data->alias = get_alias(dev);
 
-	if (dev_is_pci(dev) && pci_iommuv2_capable(to_pci_dev(dev))) {
+	/*
+	 * By default we use passthrough mode for IOMMUv2 capable device.
+	 * But if amd_iommu=force_isolation is set (e.g. to debug DMA to
+	 * invalid address), we ignore the capability for the device so
+	 * it'll be forced to go into translation mode.
+	 */
+	if ((iommu_pass_through || !amd_iommu_force_isolation) &&
+	    dev_is_pci(dev) && pci_iommuv2_capable(to_pci_dev(dev))) {
 		struct amd_iommu *iommu;
 
 		iommu = amd_iommu_rlookup_table[dev_data->devid];
-- 
2.19.1

