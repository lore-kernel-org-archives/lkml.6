Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869C9FC618B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D228216FC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 16:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D228216FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbeIMVwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 17:52:47 -0400
Received: from foss.arm.com ([217.140.101.70]:51078 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbeIMVwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 17:52:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A886680D;
        Thu, 13 Sep 2018 09:42:30 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.emea.arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DC5873F703;
        Thu, 13 Sep 2018 09:42:28 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will.deacon@arm.com, thunder.leizhen@huawei.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com,
        john.garry@huawei.com
Subject: [PATCH v6 0/6] Add non-strict mode support for iommu-dma
Date:   Thu, 13 Sep 2018 17:42:17 +0100
Message-Id: <cover.1536856828.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.19.0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Since we'd like to get this polished up and merged and Leizhen has other
commitments, here's v6 of the previous series[1] wherein I address all
my own feedback :)

The principal change is that I've inverted things slightly such that
it's now a generic domain attribute controlled by iommu-dma given the
necessary support from individual IOMMU drivers. That way we can easily
enable other drivers straight away, as I've done for SMMUv2 here (which
also allowed me to give it a quick test with MMU-401s on a Juno board).
Otherwise it's really just cosmetic cleanup and rebasing onto Will's
pending SMMU queue.

Robin.

[1] https://www.mail-archive.com/iommu@lists.linux-foundation.org/msg25150.html


Robin Murphy (2):
  iommu/io-pgtable: Add helper for toggling non-strict mode
  iommu/arm-smmu: Support non-strict mode

Zhen Lei (5):
  iommu/arm-smmu-v3: Implement flush_iotlb_all hook
  iommu/dma: Add support for non-strict mode
  iommu/io-pgtable-arm: Add support for non-strict mode
  iommu/arm-smmu-v3: Add support for non-strict mode
  iommu/dma: Add bootup option "iommu.non_strict"

 .../admin-guide/kernel-parameters.txt         | 13 +++++
 drivers/iommu/arm-smmu-v3.c                   | 43 +++++++++++++---
 drivers/iommu/arm-smmu.c                      | 43 +++++++++++++---
 drivers/iommu/dma-iommu.c                     | 49 ++++++++++++++++++-
 drivers/iommu/io-pgtable-arm.c                |  9 ++--
 drivers/iommu/io-pgtable.c                    |  9 ++++
 drivers/iommu/io-pgtable.h                    |  6 +++
 include/linux/iommu.h                         |  1 +
 8 files changed, 155 insertions(+), 18 deletions(-)

-- 
2.19.0.dirty

