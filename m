Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4894BECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A0920882
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:46:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A0920882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388369AbeGXMwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:52:32 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10110 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388172AbeGXMwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:52:32 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D20DA50A3C598;
        Tue, 24 Jul 2018 19:46:19 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.202.227.237) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.382.0; Tue, 24 Jul 2018 19:46:13 +0800
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <lorenzo.pieralisi@arm.com>, <robin.murphy@arm.com>
CC:     <will.deacon@arm.com>, <mark.rutland@arm.com>,
        <guohanjun@huawei.com>, <john.garry@huawei.com>,
        <pabba@codeaurora.org>, <vkilari@codeaurora.org>,
        <rruigrok@codeaurora.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        <neil.m.leeder@gmail.com>
Subject: [PATCH v2 0/4] arm64 SMMUv3 PMU driver with IORT support
Date:   Tue, 24 Jul 2018 12:45:11 +0100
Message-ID: <20180724114515.21764-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.237]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a driver for the SMMUv3 PMU into the perf framework.
It includes an IORT update to support PM Counter Groups.

This is based on the initial work done by Neil Leeder[1]

SMMUv3 PMCG devices are named as arm_smmu_v3_x_pmcg_y where x
denotes the associated smmuv3 dev id(if any) and y denotes the
pmu dev id.

Usage example:
For common arch supported events:
perf stat -e arm_smmu_v3_0_pmcg_6/transaction,filter_enable=1,
 filter_span=1,filter_stream_id=0x42/ -a pwd

For IMP DEF events:
perf stat -e arm_smmu_v3.0_pmcg.6/event=id/ -a pwd

Sanity tested on HiSilicon platform. Further testing on supported
platforms are very much welcome.

v1 --> v2

- Addressed comments from Robin.
- Added an helper to retrieve the associated smmu dev and named PMUs
  to make the association visible to user.
- Added MSI support  for overflow irq

[1]https://www.spinics.net/lists/arm-kernel/msg598591.html

Neil Leeder (2):
  acpi: arm64: add iort support for PMCG
  perf: add arm64 smmuv3 pmu driver

Shameer Kolothum (2):
  acpi: arm64: iort helper to find the associated smmu of pmcg node
  perf/smmuv3: Add MSI irq support

 drivers/acpi/arm64/iort.c     | 179 +++++++--
 drivers/perf/Kconfig          |   9 +
 drivers/perf/Makefile         |   1 +
 drivers/perf/arm_smmuv3_pmu.c | 901 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi_iort.h     |   4 +
 5 files changed, 1063 insertions(+), 31 deletions(-)
 create mode 100644 drivers/perf/arm_smmuv3_pmu.c

-- 
2.7.4


