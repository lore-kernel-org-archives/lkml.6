Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AA1C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 539B5222A2
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896224;
	bh=hoMUS8kZf5JkUNDg/gt7cFKkdZHHCc9RtMINp3quCl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yh5lnpjGqvL6HFbQ/ujgTPtI6brkfiaOhWH1lCrMMcYv3k3lWYTIIduefoJRUz8Nu
	 Yn+2qkW5t8wletiSNem8YZXnmH8YSJHUFF3vICItUykv/3FOBOX/PP6Y1e+g0t/6qk
	 HPHzjiSG3mFFmgT6njVRxw8XCKwPSpnRvS0dnlSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732688AbfBKOnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:43:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:55900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732673AbfBKOni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:43:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D064222A2;
        Mon, 11 Feb 2019 14:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896218;
        bh=hoMUS8kZf5JkUNDg/gt7cFKkdZHHCc9RtMINp3quCl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GrukTKI/33PUYHwSMPVfVFqNKfPJoiEdYeT0WAXpC+KnjRKq5YwoUeBe8oKFATGA6
         +82Fj6pFCSAZnVYQnPI/gmZO6OrcQ87zu5tzuhsY5xBf2mv4v3LR0D/FzpjYpUuKdf
         U5HSmPbbgWK17j/FQe7nMXHUVvU2r0CC3twEz5xw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 111/313] iommu/amd: Fix amd_iommu=force_isolation
Date:   Mon, 11 Feb 2019 15:16:31 +0100
Message-Id: <20190211141901.285423872@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index bee0dfb7b93b..34c9aa76a7bd 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -438,7 +438,14 @@ static int iommu_init_device(struct device *dev)
 
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



