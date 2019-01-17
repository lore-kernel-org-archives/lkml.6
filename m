Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD69FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92DE20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fzhplasc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fzhplasc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbfAQJ1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 04:27:31 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:39266 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfAQJ1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 04:27:31 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B1B0B6021A; Thu, 17 Jan 2019 09:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547717250;
        bh=ha3EEdy0k9HNUff6t9j+eSO2ILmrLR5UiUWmfVUPmZU=;
        h=From:To:Cc:Subject:Date:From;
        b=fzhplasc4Y4ORa3iZsE/ePbnHcgfqWwcg7KIsaMuCiw1+SUToPN2y7oUwk8P/TxoC
         doNOyalIjRmYZ5Qel6UiCDCyS0X4bkz1ZZrAXyvNsqHz4UYVuNzpusuJyRjDe6cw1d
         K3rMBxczeJYJVCzI+Z+yUyX5RdInM0IYKTUk1T2c=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3E25F6021A;
        Thu, 17 Jan 2019 09:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547717250;
        bh=ha3EEdy0k9HNUff6t9j+eSO2ILmrLR5UiUWmfVUPmZU=;
        h=From:To:Cc:Subject:Date:From;
        b=fzhplasc4Y4ORa3iZsE/ePbnHcgfqWwcg7KIsaMuCiw1+SUToPN2y7oUwk8P/TxoC
         doNOyalIjRmYZ5Qel6UiCDCyS0X4bkz1ZZrAXyvNsqHz4UYVuNzpusuJyRjDe6cw1d
         K3rMBxczeJYJVCzI+Z+yUyX5RdInM0IYKTUk1T2c=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3E25F6021A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, tfiga@chromium.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH 0/2] iommu/arm: Add support for non-coherent page tables
Date:   Thu, 17 Jan 2019 14:57:16 +0530
Message-Id: <20190117092718.1396-1-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As discussed in the Qcom system cache support thread [1], it is
imperative that we enable the support for non-cacheable page tables
for SMMU implementations for which removing snoop latency on walks
by making mappings as non-cacheable, outweighs the cost of cache
maintenance on PTE updates.

This series adds a new SMMU device tree option to let the particular
SMMU configuration setup cacheable or non-cacheable mappings for
page-tables out of box. We set a new quirk for i/o page tables -
IO_PGTABLE_QUIRK_NON_COHERENT, that lets us set different TCR
configurations.

This quirk enables the non-cacheable page tables for all masters
sitting on SMMU. Should this control be available per smmu_domain
as each master may have a different perf requirement?
Enabling this for the entire SMMU may not be desirable for all
masters.

[1] https://lore.kernel.org/patchwork/patch/1020906/

Vivek Gautam (2):
  iommu/io-pgtable-arm: Add support for non-coherent page tables
  iommu/arm-smmu: Add support for non-coherent page table mappings

 drivers/iommu/arm-smmu.c       |  7 +++++++
 drivers/iommu/io-pgtable-arm.c | 17 ++++++++++++-----
 drivers/iommu/io-pgtable.h     |  6 ++++++
 3 files changed, 25 insertions(+), 5 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

