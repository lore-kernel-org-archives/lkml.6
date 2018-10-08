Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A04CC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB7421526
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+/TXBmB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBB7421526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbeJHWjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:39:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:59186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728918AbeJHWjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:39:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6401121565;
        Mon,  8 Oct 2018 15:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012446;
        bh=07guzT1ibb7f5HVn+t5rHam03LP5Buyr6XTbNU23hc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t+/TXBmBHyCdX/FQKbl65Vt2uS31FSTyC+5rHqVxRMKtBNetuNr0wTUr1kdKE9SLF
         Z1jnA68EncrCdOMDDq8G69opCFyYM0ZjL1AnnmhITeU+tlgekZjz63zAIzcVmrW3V4
         JqxUhsqFf0US54UqqmjwBmsZ0/9ACKr/dvT8nZR8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arindam Nath <arindam.nath@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 23/23] iommu/amd: Return devid as alias for ACPI HID devices
Date:   Mon,  8 Oct 2018 11:27:03 -0400
Message-Id: <20181008152703.70891-23-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152703.70891-1-sashal@kernel.org>
References: <20181008152703.70891-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arindam Nath <arindam.nath@amd.com>

[ Upstream commit 5ebb1bc2d63d90dd204169e21fd7a0b4bb8c776e ]

ACPI HID devices do not actually have an alias for
them in the IVRS. But dev_data->alias is still used
for indexing into the IOMMU device table for devices
being handled by the IOMMU. So for ACPI HID devices,
we simply return the corresponding devid as an alias,
as parsed from IVRS table.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
Fixes: 2bf9a0a12749 ('iommu/amd: Add iommu support for ACPI HID devices')
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iommu/amd_iommu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 16199b36a11e..bba1b9f2f782 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -288,7 +288,13 @@ static u16 get_alias(struct device *dev)
 
 	/* The callers make sure that get_device_id() does not fail here */
 	devid = get_device_id(dev);
+
+	/* For ACPI HID devices, we simply return the devid as such */
+	if (!dev_is_pci(dev))
+		return devid;
+
 	ivrs_alias = amd_iommu_alias_table[devid];
+
 	pci_for_each_dma_alias(pdev, __last_alias, &pci_alias);
 
 	if (ivrs_alias == pci_alias)
-- 
2.17.1

