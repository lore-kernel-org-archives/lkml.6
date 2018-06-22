Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3108BC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D91E024814
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DTgGbelB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HcbKKGhw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D91E024814
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934476AbeFVTqs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 15:46:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55934 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934111AbeFVTqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 15:46:46 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2723560AD8; Fri, 22 Jun 2018 19:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529696806;
        bh=ie3qOV/kB96ch4FSlSY+/4tgePh/2EzqtwCJN1suZJQ=;
        h=From:To:Cc:Subject:Date:From;
        b=DTgGbelBY1o74BZQ3Pntn29v1eBp7uxKIRxGwsSM6N/37JsGfXBV/HKaZdZG929Cu
         ihNCH/2a5+UaPSXBd76BGHT5tl8P33iIUeetmWD4i3+TAIxvxva+J/SrvDuGhta/ky
         SgvSTzr9ZTyoeVDXIGNj+kd1WaAjSJGD9oh9cbT4=
Received: from azshara.qualcomm.com (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: agustinv@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0418560588;
        Fri, 22 Jun 2018 19:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529696805;
        bh=ie3qOV/kB96ch4FSlSY+/4tgePh/2EzqtwCJN1suZJQ=;
        h=From:To:Cc:Subject:Date:From;
        b=HcbKKGhw+HbcS2/Lno598gNYEEQexITISaGhtwxAAtna/AJybtW+baFlUiXjve0EQ
         H8Ff5b5ksHdw9rP5qCO5XIi9VsL2Y8C5Cd4YpDKf6Akwqqd3mXC8iPHzN7T8vu7TVB
         bw3Y6fKttozOJv1CrWv4hScPvKLLVMZZubjEpyss=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0418560588
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
Cc:     timur@codeaurora.org, agustinv@codeaurora.org
Subject: [RFC V3 0/3] arm_pmu: acpi: variant support and QCOM Falkor extensions
Date:   Fri, 22 Jun 2018 15:46:29 -0400
Message-Id: <1529696792-16903-1-git-send-email-agustinv@codeaurora.org>
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

The third patch adds the QCOM Falkor extensions using the new probe table.

If this found to be a reasonable extension approach other patches will be
added to the series to build on the base QCOM extensions.

[1] https://lkml.org/lkml/2017/3/1/540

Changes since V2:
- Address V2 comments, which resulted in removing all uses of the PMU lock.

Changes since V1:
- Redesign as a separate module by adding variant detection support.

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

