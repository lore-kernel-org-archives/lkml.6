Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63964FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B29206B5
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:30:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B29206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbeINTpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:45:15 -0400
Received: from foss.arm.com ([217.140.101.70]:34180 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbeINTpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:45:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B01C18A;
        Fri, 14 Sep 2018 07:30:30 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.emea.arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3F71C3F575;
        Fri, 14 Sep 2018 07:30:28 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will.deacon@arm.com, thunder.leizhen@huawei.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com,
        john.garry@huawei.com
Subject: [PATCH v7 0/6] Add non-strict mode support for iommu-dma
Date:   Fri, 14 Sep 2018 15:30:18 +0100
Message-Id: <cover.1536935328.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.19.0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Since we'd like to get this polished up and merged and Leizhen has other
commitments, here's v7 of the previous series[1] wherein I address all
my own feedback :) This is a quick tweak of the v6 I sent yesterday
since I figured out slightly too late a much neater way of setting the
attribute at the appropriate time.

The principal change is that I've inverted things slightly such that
it's now a generic domain attribute controlled by iommu-dma given the
necessary support from individual IOMMU drivers. That way we can easily
enable other drivers straight away, as I've done for SMMUv2 here (which
also allowed me to give it a quick test with MMU-401s on a Juno board).
Otherwise it's really just cosmetic cleanup and rebasing onto Will's
pending SMMU queue.

Robin.

[1] https://www.mail-archive.com/iommu@lists.linux-foundation.org/msg25150.html


Robin Murphy (1):
  iommu/arm-smmu: Support non-strict mode

Zhen Lei (5):
  iommu/arm-smmu-v3: Implement flush_iotlb_all hook
  iommu/dma: Add support for non-strict mode
  iommu/io-pgtable-arm: Add support for non-strict mode
  iommu: Add bootup option "iommu.non_strict"
  iommu/arm-smmu-v3: Add support for non-strict mode

 .../admin-guide/kernel-parameters.txt         | 13 ++++++
 drivers/iommu/arm-smmu-v3.c                   | 40 +++++++++++++++----
 drivers/iommu/arm-smmu.c                      | 40 +++++++++++++++----
 drivers/iommu/dma-iommu.c                     | 29 +++++++++++++-
 drivers/iommu/io-pgtable-arm.c                |  9 +++--
 drivers/iommu/io-pgtable.h                    |  5 +++
 drivers/iommu/iommu.c                         | 26 ++++++++++++
 include/linux/iommu.h                         |  1 +
 8 files changed, 145 insertions(+), 18 deletions(-)

-- 
2.19.0.dirty

