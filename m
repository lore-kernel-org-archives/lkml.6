Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8432CC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ABB42147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548692520;
	bh=kpcclXO/6zS6iMjupsPc1yGtaZyN58PULhUhbrdfF54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y0H0Q7ZJFlFH4nwYYO5KUsqCc+HiYJ7UYcZTyS/uskq5v1YYTPBExU+efJs/PgRdW
	 lbmO6wfQ/MrHHqFGE3oXtjP8IThLI1XbT2Dia+qq7RvFTx8eDqZ8C0acnzt7hTOXnQ
	 weUIIfmaQsmFW9ns7rjKlE7dk4BmaIZkIVrBkz+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389112AbfA1QV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:21:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:57702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389081AbfA1QVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:21:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB99F20663;
        Mon, 28 Jan 2019 16:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692508;
        bh=kpcclXO/6zS6iMjupsPc1yGtaZyN58PULhUhbrdfF54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PT9DxkV6n1S5IyzStfpvgoyBsNPn7T73/PbKsar7g752OO5N4FlDZXykzlxuVhoWn
         p9Djy2HyaeoLybbE+PvtwPnaJEbshPY0kklLsxMv30SMnzLaCTGtWiqiVc606+zZif
         mh6CZ6B3DKwBd3Quzj4JGlaxw9Epmk/bn94gGY8E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yu Zhao <yuzhao@google.com>, Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 4.9 043/107] iommu/amd: Fix amd_iommu=force_isolation
Date:   Mon, 28 Jan 2019 11:18:43 -0500
Message-Id: <20190128161947.57405-43-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161947.57405-1-sashal@kernel.org>
References: <20190128161947.57405-1-sashal@kernel.org>
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
index bba1b9f2f782..e984418ffa2a 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -464,7 +464,14 @@ static int iommu_init_device(struct device *dev)
 
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

