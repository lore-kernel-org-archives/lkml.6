Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B854BC282CC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 914B02081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbfBDMQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 07:16:25 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3174 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728216AbfBDMQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 07:16:25 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1C0BC8CD7ADCC1D2BF74;
        Mon,  4 Feb 2019 20:16:23 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.202.227.237) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Mon, 4 Feb 2019 20:16:15 +0800
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <lorenzo.pieralisi@arm.com>, <robin.murphy@arm.com>
CC:     <andrew.murray@arm.com>, <jean-philippe.brucker@arm.com>,
        <will.deacon@arm.com>, <mark.rutland@arm.com>,
        <guohanjun@huawei.com>, <john.garry@huawei.com>,
        <pabba@codeaurora.org>, <vkilari@codeaurora.org>,
        <rruigrok@codeaurora.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        <neil.m.leeder@gmail.com>
Subject: [PATCH v6 0/4] arm64 SMMUv3 PMU driver with IORT support
Date:   Mon, 4 Feb 2019 12:13:20 +0000
Message-ID: <20190204121324.11460-1-shameerali.kolothum.thodi@huawei.com>
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

SMMUv3 PMCG devices are named as smmuv3_pmcg_<phys_addr_page>
where <phys_addr_page> is the physical page address of the SMMU PMCG.
For example, the PMCG at 0xff88840000 is named smmuv3_pmcg_ff88840

Usage example:
For common arch supported events:
perf stat -e smmuv3_pmcg_ff88840/transaction,filter_enable=1,
 filter_span=1,filter_stream_id=0x42/ -a netperf

For IMP DEF events:
perf stat -e smmuv3_pmcg_ff88840/event=id/ -a netperf

This is sanity tested on a HiSilicon platform that requires
a quirk to run  it properly. As per HiSilicon erratum  #162001800,
PMCG event counter registers (SMMU_PMCG_EVCNTRn) on HiSilicon Hip08
platforms are read only and this prevents the software from setting
the initial period on event start. Unfortunately we were a bit late
in the cycle to detect this issue and now require software workaround
for this. Patch #4 is added to this series to provide a workaround
for this issue.

Further testing on supported platforms are very much welcome.

v5 ---> v6
-Addressed comments from Robin and Andrew.
-Changed the way global filter settings are applied as a probable
 fix to the v5 bug where in-use settings gets overwritten.
-Use of PMCG model number to identify the platform.
-Added R-by from Robin to patches #1 and #3.

v4 ---> v5
-IORT code is modified to pass the option/quirk flags to the driver
 through platform_data (patch #4), based on Robin's comments.
-Removed COMPILE_TEST (patch #2).

v3 --> v4

-Addressed comments from Jean and Robin.
-Merged dma config callbacks as per Lorenzo's comments(patch #1).
-Added handling of Global(Counter0) filter settings mode(patch #2).
-Added patch #4 to address HiSilicon erratum  #162001800
-
v2 --> v3

-Addressed comments from Robin.
-Removed iort helper function to retrieve the PMCG reference smmu.
-PMCG devices are now named using the base address

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
  perf/smmuv3: Add MSI irq support
  perf/smmuv3_pmu: Enable HiSilicon Erratum 162001800 quirk

 drivers/acpi/arm64/iort.c     | 131 +++++--
 drivers/perf/Kconfig          |   9 +
 drivers/perf/Makefile         |   1 +
 drivers/perf/arm_smmuv3_pmu.c | 873 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi_iort.h     |   7 +
 5 files changed, 997 insertions(+), 24 deletions(-)
 create mode 100644 drivers/perf/arm_smmuv3_pmu.c

-- 
2.7.4


