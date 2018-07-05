Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F3DC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60EF3240E2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="C/y+Zqi4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DCJfphCT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60EF3240E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754233AbeGEUYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 16:24:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52542 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754043AbeGEUYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 16:24:01 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9759060B27; Thu,  5 Jul 2018 20:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530822240;
        bh=ocPKaZDVS7cavjPZGVcb/qbUYF4ROpcotHdfpteyYXM=;
        h=From:To:Cc:Subject:Date:From;
        b=C/y+Zqi4u7H8m+jatYWEwBJxc08tmU/MNe6jhXbmLzpEzOrtjjdGSaHO/JwMKD85N
         6YZbOXxRtT1S+6AVnYnwGgdY37RvBKikq1vDhBfHlYpG2mgTZHZe1BfiDeihfaXbjs
         9lZY4/7pebU3Z7mVa1qB9qa4xupXGWorM2HxPRpA=
Received: from azshara.qualcomm.com (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: agustinv@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 358D360721;
        Thu,  5 Jul 2018 20:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530822239;
        bh=ocPKaZDVS7cavjPZGVcb/qbUYF4ROpcotHdfpteyYXM=;
        h=From:To:Cc:Subject:Date:From;
        b=DCJfphCTHV8leTAfc1HNqHDbr4A9H1yzqxo1gUESc7WaPYuagNaHpLvo6wU69Hot6
         b9BrtIYuoWnntk2ByEvrvsYcEKSSJvVzN8w7RTlBJRR5aaIl24H32N8dpCG29reMqE
         R+h5aMmty48GOh+cclH04YmwghIsVNedGc5lHd2I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 358D360721
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=agustinv@codeaurora.org
From:   Agustin Vega-Frias <agustinv@codeaurora.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Phani Pabba <pabba@codeaurora.org>,
        Richard Ruigrok <rruigrok@codeaurora.org>,
        Vijaya Kilari <vkilari@codeaurora.org>,
        Jeff Hugo <jhugo@codeaurora.org>,
        Rahul Ramasubramanian <rahulr@codeaurora.org>,
        Agustin Vega-Frias <agustin.vega.frias@gmail.com>,
        Agustin Vega-Frias <agustinv@codeaurora.org>
Subject: [RFC V4 0/3] arm_pmu: acpi: variant support and QCOM Falkor extensions
Date:   Thu,  5 Jul 2018 16:23:17 -0400
Message-Id: <1530822201-5890-1-git-send-email-agustinv@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a complete re-design of V1 of the QCOM Falkor extensions [1],
it introduces a probe table based on the HID of a device nested under the CPU
device to allow variant detection and arm_pmu customization.

The first patch adds an additional section at the end of each ACPI probe table.
This allows probe tables to be sentinel-delimited and better accommodate some
APIs that require such tables.

The second patch adds the PMUv3 ACPI probe table and plumbing to allow drivers
to plug into the ACPI PMUv3 probe sequence.

The third patch adds the PC capture extension applicable to Falkor and Saphira
CPUs. This shows how an extension that uses sampling events hooks. A similar
approach can be used to add RBB support and populate the sample branch stack
from it.

The fourth patch adds the matrix-based events extension applicable to Falkor
only.

If this found to be a reasonable extension approach other patches will be
added to the series to build on the base QCOM extensions.

[1] https://lkml.org/lkml/2017/3/1/540

Changes since V3:
- Add PC capture support as first extension. Add matrix-based events on top.

Changes since V2:
- Address V2 comments, which resulted in removing all uses of the PMU lock.

Agustin Vega-Frias (3):
  ACPI: add support for sentinel-delimited probe tables
  arm_pmu: acpi: add support for CPU PMU variant detection
  perf: qcom: Add Falkor CPU PMU IMPLEMENTATION DEFINED event support

 drivers/perf/Makefile             |   2 +-
 drivers/perf/arm_pmu_acpi.c       |  27 ++++
 drivers/perf/qcom_arm_pmu.c       | 310 ++++++++++++++++++++++++++++++++++++++
 include/asm-generic/vmlinux.lds.h |   4 +-
 include/linux/acpi.h              |  11 ++
 include/linux/perf/arm_pmu.h      |   1 +
 6 files changed, 353 insertions(+), 2 deletions(-)
 create mode 100644 drivers/perf/qcom_arm_pmu.c

--
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

