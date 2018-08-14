Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2222EC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C27AD2150A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MmmeEPw2";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ODyhDiG9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C27AD2150A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732006AbeHNNmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 09:42:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51514 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbeHNNmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 09:42:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5D0746079C; Tue, 14 Aug 2018 10:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534244141;
        bh=HcfwXDcKEA2QSHc2q2KAUyU3TDHZU+6FtprQd1h3Cg0=;
        h=From:To:Cc:Subject:Date:From;
        b=MmmeEPw2kvTOxOgdkCiFAh4gr/y+hbhF9Ynrzk3li9UJV16F9fHmZnZko5Odcz5Iz
         gEg6FG6HrkXkVkBYt1g/jyGR/Ue7jUB9fWBl4I2I6DH3VAtQ7J53cgxhDAnL2MBqLs
         4brpvAjLQcrTyJ0SuXfNJDeTtQKAjVa7CgkDWHjA=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E67766079C;
        Tue, 14 Aug 2018 10:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534244140;
        bh=HcfwXDcKEA2QSHc2q2KAUyU3TDHZU+6FtprQd1h3Cg0=;
        h=From:To:Cc:Subject:Date:From;
        b=ODyhDiG9YEfbCgmsH374PclQN5HTl/P+e5C33mGYg7q7jZjngbrFEl2jKAqXyZy//
         f4SQ+LDUf589ekhFoBf9FOiMUTitgCXG0EdX0mMRfRBlFmHTgyxLMGer0TQ49ejMM0
         eH0hqZ6fT007031P6xzEsk4OkTN+ZR/KuxqqeLyY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E67766079C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     joro@8bytes.org, andy.gross@linaro.org, will.deacon@arm.com,
        robin.murphy@arm.com, bjorn.andersson@linaro.org,
        iommu@lists.linux-foundation.org
Cc:     mark.rutland@arm.com, david.brown@linaro.org, tfiga@chromium.org,
        swboyd@chromium.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH 0/5] Qcom smmu-500 TLB invalidation errata for sdm845
Date:   Tue, 14 Aug 2018 16:25:23 +0530
Message-Id: <20180814105528.20592-1-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qcom's implementation of arm,mmu-500 on sdm845 has a functional/performance
errata [1] because of which the TCU cache look ups are stalled during
invalidation cycle. This is mitigated by serializing all the invalidation
requests coming to the smmu.

This patch series addresses this errata by adding new tlb_ops for
qcom,sdm845-smmu-500 [2]. These ops take context bank locks for all the
tlb_ops that queue and sync the TLB invalidation requests.

Besides adding locks, there's a way to expadite these TLB invalidations
for display and camera devices by turning off the 'wait-for-safe' logic
in hardware that holds the tlb invalidations until a safe level.
This 'wait-for-safe' logic is controlled by toggling a chicken bit
through a secure register. This secure register is accessed by making an
explicit SCM call into the EL3 firmware.
There are two ways of handling this logic -
 * Firmware, such as tz present on sdm845-mtp devices has a handler to do
   all the register access and bit set/clear. So is the handling in
   downstream arm-smmu driver [3].
 * Other firmwares can have handlers to just read/write this secure
   register. In such cases the kernel make io_read/writel scm calls to
   modify the register.
This patch series adds APIs in qcom-scm driver to handle both of these
cases.

Lastly, since these TLB invalidations can happen in atomic contexts
there's a need to add atomic versions of qcom_scm_io_readl/writel() and
qcom_scm_call() APIs. The traditional scm calls take mutex and we therefore
can't use these calls in atomic contexts.

This patch series is adapted version of how the errata is handled in
downstream [1].

[1] https://source.codeaurora.org/quic/la/kernel/msm-4.9/tree/drivers/iommu/arm-smmu.c?h=msm-4.9#n4842
[2] https://lore.kernel.org/patchwork/patch/974114/
[3] https://source.codeaurora.org/quic/la/kernel/msm-4.9/tree/drivers/iommu/arm-smmu.c?h=msm-4.9#n4864

Vivek Gautam (5):
  firmware: qcom_scm-64: Add atomic version of qcom_scm_call
  firmware/qcom_scm: Add atomic version of io read/write APIs
  firmware/qcom_scm: Add scm call to handle smmu errata
  iommu/arm-smmu: Make way to add Qcom's smmu-500 errata handling
  iommu/arm-smmu: Add support to handle Qcom's TLBI serialization errata

 drivers/firmware/qcom_scm-32.c |  17 ++++
 drivers/firmware/qcom_scm-64.c | 181 +++++++++++++++++++++++++++++++----------
 drivers/firmware/qcom_scm.c    |  18 ++++
 drivers/firmware/qcom_scm.h    |   9 ++
 drivers/iommu/arm-smmu-regs.h  |   2 +
 drivers/iommu/arm-smmu.c       | 168 ++++++++++++++++++++++++++++++++++++--
 include/linux/qcom_scm.h       |   6 ++
 7 files changed, 348 insertions(+), 53 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

