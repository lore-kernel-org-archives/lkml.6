Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A61C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BD0720661
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550957619;
	bh=DkwiJiXtSSm6c0uC5fTPJcgWdptSx8gv5SXSSe0emVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gJX/lUIF+g+zBvyZr2kj8vht/vMCmVNkEG3qEeJ1m6NAcaCeo3NjOyVxOif3v8vWy
	 8aO8O7kPYaXmZq9YX9FRycpyLy0W/RlQYyl91/xGuFNml0PsbjNzzIuF8xjdBu4rUE
	 05hP4JuQw+AZ8a6qNknVPulq0mbMwFcScnorP1/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbfBWVdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:33:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:40012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728117AbfBWVEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:04:53 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E76B20878;
        Sat, 23 Feb 2019 21:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550955892;
        bh=DkwiJiXtSSm6c0uC5fTPJcgWdptSx8gv5SXSSe0emVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aVTLt0Rtnm/DK16gdOekWsMRqxB3WfRQGZFWy8zDMmUc3TsMB8Hb+H+zN6RpghNP1
         LoHgmdsArGbE1frR4/pYEK1BhPQXxEcwQzCLq5KsgxtcOh5Sa5kTCA0e4wlzarVP05
         Zd7/o5EYoCaP7TnlrTftClWFHyhP7R0tT+wkpgYY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 4.20 18/72] iommu/amd: Fix IOMMU page flush when detach device from a domain
Date:   Sat, 23 Feb 2019 16:03:28 -0500
Message-Id: <20190223210422.199966-18-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210422.199966-1-sashal@kernel.org>
References: <20190223210422.199966-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

[ Upstream commit 9825bd94e3a2baae1f4874767ae3a7d4c049720e ]

When a VM is terminated, the VFIO driver detaches all pass-through
devices from VFIO domain by clearing domain id and page table root
pointer from each device table entry (DTE), and then invalidates
the DTE. Then, the VFIO driver unmap pages and invalidate IOMMU pages.

Currently, the IOMMU driver keeps track of which IOMMU and how many
devices are attached to the domain. When invalidate IOMMU pages,
the driver checks if the IOMMU is still attached to the domain before
issuing the invalidate page command.

However, since VFIO has already detached all devices from the domain,
the subsequent INVALIDATE_IOMMU_PAGES commands are being skipped as
there is no IOMMU attached to the domain. This results in data
corruption and could cause the PCI device to end up in indeterministic
state.

Fix this by invalidate IOMMU pages when detach a device, and
before decrementing the per-domain device reference counts.

Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Suggested-by: Joerg Roedel <joro@8bytes.org>
Co-developed-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Fixes: 6de8ad9b9ee0 ('x86/amd-iommu: Make iommu_flush_pages aware of multiple IOMMUs')
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd_iommu.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 9d06bc36a2c19..862cf8c27dd27 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1922,16 +1922,13 @@ static void do_attach(struct iommu_dev_data *dev_data,
 
 static void do_detach(struct iommu_dev_data *dev_data)
 {
+	struct protection_domain *domain = dev_data->domain;
 	struct amd_iommu *iommu;
 	u16 alias;
 
 	iommu = amd_iommu_rlookup_table[dev_data->devid];
 	alias = dev_data->alias;
 
-	/* decrease reference counters */
-	dev_data->domain->dev_iommu[iommu->index] -= 1;
-	dev_data->domain->dev_cnt                 -= 1;
-
 	/* Update data structures */
 	dev_data->domain = NULL;
 	list_del(&dev_data->list);
@@ -1941,6 +1938,16 @@ static void do_detach(struct iommu_dev_data *dev_data)
 
 	/* Flush the DTE entry */
 	device_flush_dte(dev_data);
+
+	/* Flush IOTLB */
+	domain_flush_tlb_pde(domain);
+
+	/* Wait for the flushes to finish */
+	domain_flush_complete(domain);
+
+	/* decrease reference counters - needs to happen after the flushes */
+	domain->dev_iommu[iommu->index] -= 1;
+	domain->dev_cnt                 -= 1;
 }
 
 /*
-- 
2.19.1

